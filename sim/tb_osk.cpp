// The on-screen keyboard on its own: does it draw what the panel generator
// drew, and does pressing a cell send the key that cell claims?
//
//   obj_osk/Vbbc_osk [-out dir]
//
// The module counts its position from de and vsync, so the bench only has to
// produce a raster: 640 x 256 active out of 1024 x 312, one pixel per six
// system clocks, which is what the core emits.
//
// Two checks, both against tools/make_osk_panel.py's own output rather than
// against a picture of it:
//   * every pixel of the panel matches the bitmap in rtl/rom/osk_panel.hex,
//     with the highlighted cell inverted;
//   * moving the highlight and pressing sends the matrix position the key map
//     gives for that cell -- the same table the RTL reads, checked from the
//     other side.
#include "Vbbc_osk.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

static const int W = 640, H = 256, HTOTAL = 1024, VTOTAL = 312;
static const int PW = 256, PH = 72, X0 = 64, Y0 = 172;
static const int MAP_BASE = 0x1200, SPAN_BASE = 0x1260;

static Vbbc_osk *dut;
static long tcount = 0;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); tcount++; }

struct Event { int col, row, press; };
static std::vector<Event> events;

// one frame of raster; returns the captured (active, pix) pair per pixel
static std::vector<uint8_t> *g_hi = nullptr;
static void frame(std::vector<uint8_t> *act, std::vector<uint8_t> *pix) {
    for (int line = 0; line < VTOTAL; line++) {
        for (int h = 0; h < HTOTAL; h++) {
            dut->vsync = (line == 0) ? 1 : 0;
            dut->de = (line < H && h < W) ? 1 : 0;
            for (int c = 0; c < 6; c++) {
                dut->cen_pix = (c == 0);
                tick();
                if (dut->kev_stb)
                    events.push_back({dut->kev_col, dut->kev_row, dut->kev_press});
                if (c == 0 && act && dut->de && line < H && h < W) {
                    (*act)[line * W + h] = dut->active;
                    (*pix)[line * W + h] = dut->pix;
                    if (g_hi) (*g_hi)[line * W + h] = dut->hi;
                }
            }
        }
    }
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    std::string out = "artifacts/osk";
    for (int i = 1; i < argc; i++)
        if (!strcmp(argv[i], "-out") && i + 1 < argc) out = argv[++i];

    // the panel generator's output, read as the truth for both checks
    std::vector<uint8_t> hi(W * H, 0);
    std::vector<uint8_t> rom;
    FILE *f = fopen("rtl/rom/osk_panel.hex", "r");
    if (!f) { fprintf(stderr, "run me from the repository root\n"); return 2; }
    unsigned v;
    while (fscanf(f, "%x", &v) == 1) rom.push_back((uint8_t)v);
    fclose(f);
    printf("panel rom: %zu bytes\n", rom.size());

    dut = new Vbbc_osk;
    dut->clk = 0; dut->cen_pix = 0; dut->de = 0; dut->vsync = 0;
    dut->chord = 0; dut->up = dut->down = dut->left = dut->right = 0;
    dut->press = 0;
    for (int i = 0; i < 16; i++) tick();

    // a frame with the keyboard down: nothing of ours on screen
    std::vector<uint8_t> act(W * H, 0), pix(W * H, 0);
    frame(&act, &pix);
    long lit = 0;
    for (auto a : act) lit += a;
    printf("keyboard down: %ld active pixels (want 0)%s\n", lit,
           lit ? "  FAIL" : "");
    int bad = lit ? 1 : 0;

    // the chord brings it up
    dut->chord = 1; frame(nullptr, nullptr);
    dut->chord = 0; frame(nullptr, nullptr);
    printf("after the chord: visible=%d (want 1)%s\n", dut->visible,
           dut->visible ? "" : "  FAIL");
    if (!dut->visible) bad++;

    std::fill(act.begin(), act.end(), 0);
    std::fill(pix.begin(), pix.end(), 0);
    g_hi = &hi;
    frame(&act, &pix);

    // a picture of it, drawn the way core_top draws it, to look at
    {
        std::string path = out + "/panel.rgb";
        std::vector<uint8_t> fb(W * H * 3, 0);
        for (int i = 0; i < W * H; i++) {
            if (!act[i] || !pix[i]) continue;
            fb[i * 3 + 0] = 0xFF;
            fb[i * 3 + 1] = hi[i] ? 0xC0 : 0xFF;
            fb[i * 3 + 2] = hi[i] ? 0x00 : 0xFF;
        }
        FILE *o = fopen(path.c_str(), "wb");
        if (o) { fwrite(fb.data(), 1, fb.size(), o); fclose(o);
                 printf("wrote %s (%dx%d)\n", path.c_str(), W, H); }
    }

    // it opens on SPACE: grid cell (6, 5)
    int cur_cx = 6, cur_cy = 5;
    long wrong = 0, first_x = -1, first_y = -1;
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            bool inside = (x >= X0 && x < X0 + PW * 2 && y >= Y0 && y < Y0 + PH);
            if (act[y * W + x] != inside) { wrong++; continue; }
            if (!inside) continue;
            int px = (x - X0) / 2, py = y - Y0;
            int bit = (rom[py * (PW / 8) + px / 8] >> (7 - (px & 7))) & 1;
            // the highlight is the whole KEY, whose extent the span map holds
            int sp = rom[SPAN_BASE + cur_cy * 16 + cur_cx];
            int k0 = sp >> 4, kn = sp & 15;
            bool hl = (px / 16 >= k0) && (px / 16 < k0 + kn) &&
                      (py >= cur_cy * 12) && (py < (cur_cy + 1) * 12);
            int want = hl ? !bit : bit;
            if (pix[y * W + x] != want) {
                if (wrong == 0) { first_x = x; first_y = y; }
                wrong++;
            }
        }
    }
    printf("panel pixels differing from the generator: %ld%s", wrong,
           wrong ? "  FAIL at " : "\n");
    if (wrong) printf("(%ld,%ld)\n", first_x, first_y);
    if (wrong) {
        bad++;
        // print one panel row of each, so the difference has a shape
        for (int py = 0; py < 12; py++) {
            std::string got, want;
            for (int px = 200; px < 256; px++) {
                int x = X0 + px * 2, y = Y0 + py;
                got += pix[y * W + x] ? '#' : '.';
                int bit = (rom[py * (PW / 8) + px / 8] >> (7 - (px & 7))) & 1;
                want += bit ? '#' : '.';
            }
            printf("   rtl %s\n   gen %s\n", got.c_str(), want.c_str());
        }
    }

    // move the highlight and press: the event must be the cell's own key
    events.clear();
    dut->right = 1; frame(nullptr, nullptr); dut->right = 0;
    frame(nullptr, nullptr);
    {
        int sp = rom[SPAN_BASE + cur_cy * 16 + cur_cx];
        int k0 = sp >> 4, kn = sp & 15;
        cur_cx = (k0 + kn >= 16) ? 0 : k0 + kn;
        printf("right from a %d-cell key: the cursor is now at column %d\n",
               kn, cur_cx);
    }
    auto press_once = [&]() {
        events.clear();
        dut->press = 1; frame(nullptr, nullptr);
        dut->press = 0;
        for (int i = 0; i < 8; i++) frame(nullptr, nullptr);
    };
    auto key_at = [&](int cx, int cy) { return rom[MAP_BASE + cy * 16 + cx]; };
    auto show = [&](const char *what) {
        printf("%s: %zu event(s)\n", what, events.size());
        for (auto &e : events)
            printf("   %s col %d row %d (code %02X)\n",
                   e.press ? "press  " : "release", e.col, e.row,
                   (e.col << 3) | e.row);
    };

    // CAPS LOCK is a latching key: one event down, and it stays down, so the
    // combinations that need it can be typed one key at a time
    press_once();
    int caps = key_at(cur_cx, cur_cy);
    show("CAPS LOCK pressed");
    if (events.size() != 1 || !events[0].press ||
        ((events[0].col << 3) | events[0].row) != caps) {
        printf("  FAIL: a latching key should send one press and hold it\n");
        bad++;
    }

    // ... and while it is down the panel says so, in the cells it occupies
    std::fill(hi.begin(), hi.end(), 0);
    frame(&act, &pix);
    long lit_hi = 0;
    for (auto v : hi) lit_hi += v;
    int sp_caps = rom[SPAN_BASE + cur_cy * 16 + cur_cx];
    long want_hi = (long)(sp_caps & 15) * 16 * 2 * 12;   // cells, 2x across
    printf("CAPS held: %ld pixels marked as latched (want %ld)\n",
           lit_hi, want_hi);
    if (lit_hi != want_hi) { printf("  FAIL\n"); bad++; }

    // pressing it again lets it up
    press_once();
    show("CAPS LOCK pressed again");
    if (events.size() != 1 || events[0].press) {
        printf("  FAIL: the second press should release it\n");
        bad++;
    }

    // a key that is not a modifier is a keystroke: down, then up a few
    // frames later
    dut->up = 1; frame(nullptr, nullptr); dut->up = 0;
    frame(nullptr, nullptr);
    cur_cy--;                       // row 4, column 0, which is SHIFT
    dut->right = 1; frame(nullptr, nullptr); dut->right = 0;
    frame(nullptr, nullptr);
    {                               // one cell right of SHIFT is Z
        int sp = rom[SPAN_BASE + cur_cy * 16 + cur_cx];
        cur_cx = (sp >> 4) + (sp & 15);
    }
    press_once();
    int k = key_at(cur_cx, cur_cy);
    show("a letter pressed");
    bool got_press = false, got_release = false;
    for (auto &e : events) {
        int code = (e.col << 3) | e.row;
        if (code == k && e.press) got_press = true;
        if (code == k && !e.press) got_release = true;
    }
    if (!got_press || !got_release) {
        printf("  FAIL: no press/release pair for key %02X\n", k);
        bad++;
    }

    // SHIFT down swaps the whole panel for the shifted legends, so the
    // punctuation it types is printed on the keys.  Checked against the
    // second page the generator rendered, not against a picture of it.
    dut->left = 1; frame(nullptr, nullptr); dut->left = 0;
    frame(nullptr, nullptr);
    cur_cx = 0;                     // back to SHIFT on row 4
    press_once();
    show("SHIFT pressed");
    std::fill(act.begin(), act.end(), 0);
    std::fill(pix.begin(), pix.end(), 0);
    frame(&act, &pix);
    long shifted_wrong = 0;
    for (int y = Y0; y < Y0 + PH; y++) {
        for (int x = X0; x < X0 + PW * 2; x++) {
            int px = (x - X0) / 2, py = y - Y0;
            int bit = (rom[0x900 + py * (PW / 8) + px / 8] >> (7 - (px & 7))) & 1;
            int sp = rom[SPAN_BASE + cur_cy * 16 + cur_cx];
            bool hl = (px / 16 >= (sp >> 4)) && (px / 16 < (sp >> 4) + (sp & 15)) &&
                      (py >= cur_cy * 12) && (py < (cur_cy + 1) * 12);
            if (pix[y * W + x] != (hl ? !bit : bit)) shifted_wrong++;
        }
    }
    printf("with SHIFT down, pixels differing from the SHIFTED page: %ld\n",
           shifted_wrong);
    if (shifted_wrong) { printf("  FAIL\n"); bad++; }
    {
        std::string path = out + "/panel_shifted.rgb";
        std::vector<uint8_t> fb(W * H * 3, 0);
        for (int i = 0; i < W * H; i++) {
            if (!act[i] || !pix[i]) continue;
            fb[i * 3 + 0] = 0xFF;
            fb[i * 3 + 1] = hi[i] ? 0xC0 : 0xFF;
            fb[i * 3 + 2] = hi[i] ? 0x00 : 0xFF;
        }
        FILE *o = fopen(path.c_str(), "wb");
        if (o) { fwrite(fb.data(), 1, fb.size(), o); fclose(o); }
    }

    // dismissing it hands the pad back
    dut->chord = 1; frame(nullptr, nullptr);
    dut->chord = 0; frame(nullptr, nullptr);
    printf("after the chord again: visible=%d (want 0)%s\n", dut->visible,
           dut->visible ? "  FAIL" : "");
    if (dut->visible) bad++;

    delete dut;
    printf(bad ? "FAIL\n" : "PASS\n");
    return bad ? 1 : 0;
}

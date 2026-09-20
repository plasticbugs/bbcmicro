// The whole machine on the real memory glue, before the first flash.
//
//   obj_pocket/Vtb_pocket_top [rom] [-ms N] [-snap a,b,c] [-out dir]
//                             [-disc f] [-disc1 f] [-break ms] [-links N]
//                             [-keys "ms:col,row,hold_ms ..."] [-compare dir]
//                             [-gap N] [-hold N] [-quiet]
//
// sim/run_boot.sh answers the disc controller from an array the clock after
// it asks.  Here the same core drives target/pocket/bbcmicro_mem.sv, the real
// SDRAM controller and a behavioural chip, and both images are pushed in
// through the download ports at the loader's rate -- so refresh, the burst
// arbiter, the download FIFO and the byte lanes are all in the path for the
// first time (METHODOLOGY section 5.16).  Two cores shipped black screens
// because everything between the core's ports and the pins went untested
// until hardware.
//
// -compare takes the directory the fast bench wrote its frames to and
// requires every snapshot to be identical, pixel for pixel.  That is the
// gate: the glue is transparent or it is not.
#include "Vtb_pocket_top.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <algorithm>

static const int W = 640, H = 256;
static const long IMG = 0x14400;        // bbcmicro.rom
static const long CLK_HZ = 96000000;

static Vtb_pocket_top *dut;
static long tcount = 0;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); tcount++; }
static double ms_now() { return 1000.0 * (double)tcount / (double)CLK_HZ; }

struct KeyEvent { double ms; int col, row; double hold_ms; bool done_down, done_up; };

static std::vector<uint8_t> slurp(const std::string &p, size_t cap) {
    std::vector<uint8_t> v;
    FILE *f = fopen(p.c_str(), "rb");
    if (!f) { fprintf(stderr, "cannot open %s\n", p.c_str()); exit(2); }
    v.resize(cap);
    size_t n = fread(v.data(), 1, cap, f);
    fclose(f);
    v.resize(n);
    return v;
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    std::string path = "../bbcmicro.rom", out = "../artifacts/pocket", compare;
    std::string disc[2], dumpram, bustrace;
    long bus_n = 400000;
    double run_ms = 2600, break_ms = -1, trace_from = 0;
    int gap = 8, hold = 4, links = 0;
    long trace_n = 0, pc_lo = -1, pc_hi = -1;
    bool quiet = false, wonly = false;
    std::vector<double> snaps;
    std::vector<KeyEvent> keys;

    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "-ms" && i + 1 < argc) run_ms = atof(argv[++i]);
        else if (a == "-out" && i + 1 < argc) out = argv[++i];
        else if (a == "-compare" && i + 1 < argc) compare = argv[++i];
        else if (a == "-disc" && i + 1 < argc) disc[0] = argv[++i];
        else if (a == "-disc1" && i + 1 < argc) disc[1] = argv[++i];
        else if (a == "-gap" && i + 1 < argc) gap = atoi(argv[++i]);
        else if (a == "-hold" && i + 1 < argc) hold = atoi(argv[++i]);
        else if (a == "-break" && i + 1 < argc) break_ms = atof(argv[++i]);
        else if (a == "-links" && i + 1 < argc) links = (int)strtol(argv[++i], nullptr, 0);
        else if (a == "-trace" && i + 1 < argc) trace_n = atol(argv[++i]);
        else if (a == "-trace_from" && i + 1 < argc) trace_from = atof(argv[++i]);
        else if (a == "-wonly") wonly = true;
        else if (a == "-dumpram" && i + 1 < argc) dumpram = argv[++i];
        else if (a == "-bus" && i + 1 < argc) bustrace = argv[++i];
        else if (a == "-bus_n" && i + 1 < argc) bus_n = atol(argv[++i]);
        else if (a == "-quiet") quiet = true;
        else if (a == "-pc" && i + 1 < argc) sscanf(argv[++i], "%lx,%lx", &pc_lo, &pc_hi);
        else if (a == "-snap" && i + 1 < argc) {
            char *s = strdup(argv[++i]);
            for (char *t = strtok(s, ","); t; t = strtok(nullptr, ",")) snaps.push_back(atof(t));
            free(s);
        } else if (a == "-keys" && i + 1 < argc) {
            char *s = strdup(argv[++i]);
            for (char *t = strtok(s, " "); t; t = strtok(nullptr, " ")) {
                KeyEvent k{}; double h = 60;
                if (sscanf(t, "%lf:%d,%d,%lf", &k.ms, &k.col, &k.row, &h) >= 3) {
                    k.hold_ms = h; keys.push_back(k);
                }
            }
            free(s);
        } else if (a[0] != '+' && a[0] != '-') path = a;
    }
    if (hold >= gap) hold = gap - 1;
    if (hold < 1) hold = 1;
    std::sort(snaps.begin(), snaps.end());
    size_t next_snap = 0;

    std::vector<uint8_t> rom = slurp(path, IMG);
    if (rom.size() != (size_t)IMG) {
        fprintf(stderr, "%s is %zu bytes, expected %ld\n", path.c_str(), rom.size(), IMG);
        return 2;
    }

    dut = new Vtb_pocket_top;
    dut->rst = 1; dut->mem_init = 1; dut->pause = 0;
    dut->dl_we = 0; dut->dl_addr = 0; dut->dl_data = 0;
    dut->disc_dl_we = 0; dut->disc_dl_active = 0; dut->disc_dl_drive = 0;
    dut->disc_present = 0;
    dut->kev_stb = 0; dut->key_break = 0; dut->links = links;
    for (int i = 0; i < 16; i++) tick();
    dut->mem_init = 0;

    // the SDRAM has to come up before anything can be written to it
    long t = 0;
    while (!dut->mem_ready && t++ < 400000) tick();
    if (!dut->mem_ready) { printf("FAIL  the SDRAM controller never came ready\n"); return 1; }
    printf("sdram ready after %ld clocks\n", t);

    // the ROM image, into the core's block RAM
    printf("rom: %ld bytes, one per %d clocks, strobe held %d\n", IMG, gap, hold);
    for (long a = 0; a < IMG; a++) {
        dut->dl_addr = a; dut->dl_data = rom[a]; dut->dl_we = 1;
        for (int i = 0; i < hold; i++) tick();
        dut->dl_we = 0;
        for (int i = hold; i < gap; i++) tick();
    }
    printf("image checksum in the core: %04X over %u bytes\n",
           dut->dbg_rom_sum, (unsigned)dut->dbg_rom_count);

    // the disc images, through bbcmicro_mem's FIFO into SDRAM, at the same
    // rate -- this is the path run_mem.sh gates, with the machine's own
    // clients now sharing the controller
    int present = 0;
    for (int d = 0; d < 2; d++) {
        if (disc[d].empty()) continue;
        std::vector<uint8_t> img = slurp(disc[d], 1 << 20);
        printf("drive %d: %s, %zu bytes\n", d, disc[d].c_str(), img.size());
        dut->disc_dl_active = 1; dut->disc_dl_drive = d;
        for (size_t a = 0; a < img.size(); a++) {
            dut->disc_dl_addr = a; dut->disc_dl_data = img[a]; dut->disc_dl_we = 1;
            for (int i = 0; i < hold; i++) tick();
            dut->disc_dl_we = 0;
            for (int i = hold; i < gap; i++) tick();
        }
        for (int i = 0; i < 512; i++) tick();
        dut->disc_dl_active = 0;
        present |= 1 << d;
    }
    dut->disc_present = present;

    for (int i = 0; i < 64; i++) tick();
    dut->rst = 0;
    tcount = 0;                          // time runs from the release of reset

    // the same RAM shadow and bus trace the fast bench keeps, so the two can
    // be held to each other when their pictures differ: tools/diff_bus.py
    // says where the CPUs parted, and the RAM says whether the machine or
    // only the video path is different
    std::vector<uint8_t> shadow(32768, 0);
    FILE *bus = bustrace.empty() ? nullptr : fopen(bustrace.c_str(), "w");
    long bus_count = 0;

    std::vector<uint8_t> fb(W * H * 3, 0);
    long frame = 0, x = 0, y = -1, active = 0, active_prev = 0;
    int prev_vs = 0, prev_de = 0, prev_hs = 0;
    double last_vs_ms = 0, frame_ms = 0;
    long snaps_done = 0, snaps_bad = 0;

    auto write_frame = [&](double at_ms) {
        char name[512];
        snprintf(name, sizeof name, "%s/frame_%05.0fms.rgb", out.c_str(), at_ms);
        FILE *o = fopen(name, "wb");
        if (!o) { fprintf(stderr, "cannot write %s\n", name); return; }
        fwrite(fb.data(), 1, fb.size(), o);
        fclose(o);
        printf("  %8.2f ms  frame %ld  %ld active pixels  %.3f ms/frame -> %s\n",
               at_ms, frame, active_prev, frame_ms, name);
        snaps_done++;
        if (compare.empty()) return;
        char ref[512];
        snprintf(ref, sizeof ref, "%s/frame_%05.0fms.rgb", compare.c_str(), at_ms);
        FILE *r = fopen(ref, "rb");
        if (!r) { printf("            no fast-bench frame at %s to compare\n", ref);
                  snaps_bad++; return; }
        std::vector<uint8_t> want(fb.size());
        size_t n = fread(want.data(), 1, want.size(), r);
        fclose(r);
        if (n != want.size()) { printf("            %s is %zu bytes\n", ref, n);
                                snaps_bad++; return; }
        long bad = 0, first = -1;
        for (size_t i = 0; i < fb.size(); i += 3)
            if (memcmp(&fb[i], &want[i], 3)) { if (first < 0) first = (long)(i / 3); bad++; }
        if (bad) {
            printf("            %ld of %d pixels differ from the fast bench, "
                   "first at x=%ld y=%ld\n", bad, W * H, first % W, first / W);
            snaps_bad++;
        } else {
            printf("            identical to the fast bench, all %d pixels\n", W * H);
        }
    };

    while (ms_now() < run_ms) {
        tick();

        if (dut->trc_cen && trace_n > 0 && ms_now() >= trace_from &&
            (pc_lo < 0 || (dut->trc_addr >= pc_lo && dut->trc_addr <= pc_hi)) &&
            (!wonly || !dut->trc_rnw)) {
            printf("%8.3fms  %04X %c %02X  irq=%X\n", ms_now(), dut->trc_addr,
                   dut->trc_rnw ? 'r' : 'w', dut->trc_data, dut->trc_irq);
            trace_n--;
        }

        if (bus && dut->trc_cen && bus_count < bus_n) {
            fprintf(bus, "%c %04X %02X\n", dut->trc_rnw ? 'R' : 'W',
                    dut->trc_addr, dut->trc_data);
            if (++bus_count == bus_n) { fclose(bus); bus = nullptr; }
        }
        if (dut->trc_cen && !dut->trc_rnw && dut->trc_addr < 0x8000)
            shadow[dut->trc_addr] = dut->trc_data;

        double now = ms_now();
        for (auto &k : keys) {
            if (!k.done_down && now >= k.ms) {
                dut->kev_stb = 1; dut->kev_press = 1;
                dut->kev_col = k.col; dut->kev_row = k.row;
                tick(); dut->kev_stb = 0;
                k.done_down = true;
            } else if (k.done_down && !k.done_up && now >= k.ms + k.hold_ms) {
                dut->kev_stb = 1; dut->kev_press = 0;
                dut->kev_col = k.col; dut->kev_row = k.row;
                tick(); dut->kev_stb = 0;
                k.done_up = true;
            }
        }
        dut->key_break = (break_ms >= 0 && now >= break_ms && now < break_ms + 20);

        if (!dut->pix_ce) continue;
        int vs = dut->vsync, de = dut->de, hs = dut->hsync;
        if (vs && !prev_vs) {
            frame_ms = now - last_vs_ms;
            last_vs_ms = now;
            active_prev = active;
            if (next_snap < snaps.size() && now >= snaps[next_snap]) {
                write_frame(now);
                while (next_snap < snaps.size() && now >= snaps[next_snap]) next_snap++;
            }
            frame++;
            y = -1; active = 0;
            std::fill(fb.begin(), fb.end(), 0);
        }
        if (hs && !prev_hs) x = 0;
        if (de && !prev_de) { x = 0; y++; }
        if (de) {
            if (y >= 0 && y < H && x < W) {
                uint32_t c = dut->rgb;
                size_t o = ((size_t)y * W + x) * 3;
                fb[o + 0] = (c >> 16) & 0xFF; fb[o + 1] = (c >> 8) & 0xFF; fb[o + 2] = c & 0xFF;
            }
            x++; active++;
        }
        prev_vs = vs; prev_de = de; prev_hs = hs;
    }

    if (!quiet)
        printf("%.1f ms: %ld frames (last %.3f ms = %.2f Hz)\n",
               ms_now(), frame, frame_ms, frame_ms > 0 ? 1000.0 / frame_ms : 0.0);
    if (bus) { fclose(bus); printf("bus trace: %ld transactions -> %s\n",
                                   bus_count, bustrace.c_str()); }
    if (!dumpram.empty()) {
        FILE *o = fopen(dumpram.c_str(), "wb");
        if (o) { fwrite(shadow.data(), 1, shadow.size(), o); fclose(o);
                 printf("wrote %s (32768 bytes of RAM, as the CPU wrote it)\n",
                        dumpram.c_str()); }
    }
    delete dut;

    if (!compare.empty()) {
        if (!snaps_done) { printf("FAIL  no frame was captured to compare\n"); return 1; }
        if (snaps_bad) {
            printf("FAIL  %ld of %ld frames differ from the fast bench: the memory "
                   "glue is not transparent\n", snaps_bad, snaps_done);
            return 1;
        }
        printf("PASS  all %ld frames identical through the real memory glue\n", snaps_done);
    }
    return 0;
}

// Boot the machine and capture frames.
//
//   obj_boot/Vtb_boot_top [rom] [-ms N] [-snap a,b,c] [-out dir]
//                         [-keys "ms:col,row,hold_ms ..."] [-break ms]
//                         [-gap N] [-hold N] [-quiet]
//
// Times are emulated milliseconds, not frames: at reset the CRTC is in its
// own power-on state and runs at whatever rate that gives, so a frame counter
// means nothing until the OS has programmed it.  A snapshot is the first
// whole frame to finish at or after the time asked for, and the run prints
// what it actually captured.
//
// The ROM image goes in through the download port at the Pocket loader's real
// rate -- one byte every eight clocks, the strobe held for four with address
// and data stable underneath -- because a bench that idealises the platform
// boundary is how two cores shipped broken (METHODOLOGY section 5.8).
//
// Frames are captured from the core's own de/hsync/vsync, which are the
// CRTC's, so the capture is 640x256 whatever the machine is doing.  Each frame
// is written as raw RGB for tools/rgb2png.py.
#include "Vtb_boot_top.h"
#include "Vtb_boot_top___024root.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <algorithm>

static int W = 640, H = 256;           // the window; -raw captures the raster
static const long IMG = 0x14400;        // bbcmicro.rom
static const long CLK_HZ = 96000000;

static Vtb_boot_top *dut;
static long tcount = 0;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); tcount++; }
static double ms_now() { return 1000.0 * (double)tcount / (double)CLK_HZ; }

struct KeyEvent { double ms; int col, row; double hold_ms; bool done_down, done_up; };

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    std::string path = "../bbcmicro.rom", out = "../artifacts/boot";
    double run_ms = 2000;
    int gap = 8, hold = 4;
    bool quiet = false;
    double break_ms = -1;
    long trace_n = 0;
    std::string dumpram, disc, bustrace, wav;
    double wav_from = 0;
    long bus_n = 400000;
    bool raw = false;
    double trace_from = 0;
    bool io_only = false;
    long pc_lo = -1, pc_hi = -1;         // trace only this address range
    bool wonly = false;                  // and only the writes
    int links = 0;                       // the startup links: bit 0 is column 2
    int swram = 0;                       // a sideways RAM board fitted
    int predelay = 0;                    // extra clocks held in reset
    std::vector<double> snaps;
    std::vector<KeyEvent> keys;

    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "-ms" && i + 1 < argc) run_ms = atof(argv[++i]);
        else if (a == "-out" && i + 1 < argc) out = argv[++i];
        else if (a == "-gap" && i + 1 < argc) gap = atoi(argv[++i]);
        else if (a == "-hold" && i + 1 < argc) hold = atoi(argv[++i]);
        else if (a == "-break" && i + 1 < argc) break_ms = atof(argv[++i]);
        else if (a == "-quiet") quiet = true;
        else if (a == "-raw") { raw = true; W = 1024; H = 320; }
        else if (a == "-disc" && i + 1 < argc) disc = argv[++i];
        else if (a == "-bus" && i + 1 < argc) bustrace = argv[++i];
        else if (a == "-bus_n" && i + 1 < argc) bus_n = atol(argv[++i]);
        else if (a == "-dumpram" && i + 1 < argc) dumpram = argv[++i];
        else if (a == "-trace" && i + 1 < argc) trace_n = atol(argv[++i]);
        else if (a == "-trace_from" && i + 1 < argc) trace_from = atof(argv[++i]);
        else if (a == "-io") io_only = true;   // trace only FRED, JIM and SHEILA
        else if (a == "-wonly") wonly = true;
        else if (a == "-predelay" && i + 1 < argc) predelay = atoi(argv[++i]);
        else if (a == "-wav" && i + 1 < argc) wav = argv[++i];
        else if (a == "-wav_from" && i + 1 < argc) wav_from = atof(argv[++i]);
        else if (a == "-pc" && i + 1 < argc) {
            sscanf(argv[++i], "%lx,%lx", &pc_lo, &pc_hi);
        }
        else if (a == "-links" && i + 1 < argc) links = (int)strtol(argv[++i], nullptr, 0);
        else if (a == "-swram" && i + 1 < argc) swram = atoi(argv[++i]);
        else if (a == "-snap" && i + 1 < argc) {
            char *s = strdup(argv[++i]);
            for (char *t = strtok(s, ","); t; t = strtok(nullptr, ","))
                snaps.push_back(atof(t));
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

    std::vector<uint8_t> rom(IMG, 0xFF);
    FILE *f = fopen(path.c_str(), "rb");
    if (!f) { fprintf(stderr, "cannot open %s\n", path.c_str()); return 2; }
    size_t got = fread(rom.data(), 1, IMG, f);
    fclose(f);
    if (got != (size_t)IMG) {
        fprintf(stderr, "%s is %zu bytes, expected %ld\n", path.c_str(), got, IMG);
        return 2;
    }

    dut = new Vtb_boot_top;
    dut->disc_loaded = 0;
    if (!disc.empty()) {
        FILE *d = fopen(disc.c_str(), "rb");
        if (!d) { fprintf(stderr, "cannot open %s\n", disc.c_str()); return 2; }
        std::vector<uint8_t> img(1 << 20);
        size_t n = fread(img.data(), 1, img.size(), d);
        fclose(d);
        for (size_t k = 0; k < n; k++)
            dut->rootp->tb_boot_top__DOT__disc_mem[k] = img[k];
        dut->disc_loaded = 1;
        printf("drive 0: %s, %zu bytes (%zu tracks of ten 256-byte sectors)\n",
               disc.c_str(), n, n / 2560);
    }
    dut->rst = 1; dut->pause = 0;
    dut->dl_we = 0; dut->kev_stb = 0; dut->key_break = 0;
    dut->links = links;                  // default: every link open, as MAME's
    dut->swram_en = swram ? 1 : 0;
    for (int i = 0; i < 32; i++) tick();

    printf("loading %ld bytes, one per %d clocks, strobe held %d\n", IMG, gap, hold);
    for (long a = 0; a < IMG; a++) {
        dut->dl_addr = a; dut->dl_data = rom[a]; dut->dl_we = 1;
        for (int i = 0; i < hold; i++) tick();
        dut->dl_we = 0;
        for (int i = hold; i < gap; i++) tick();
    }
    printf("image checksum in the core: %04X over %u bytes\n",
           dut->dbg_rom_sum, (unsigned)dut->dbg_rom_count);

    for (int i = 0; i < 64 + predelay; i++) tick();
    dut->rst = 0;
    tcount = 0;                          // time runs from the release of reset

    // A shadow of the machine's RAM, built from the writes the CPU makes on
    // the traced bus.  It costs nothing, needs no window into the design, and
    // is what the frozen-state gate will compare against MAME's dump.
    std::vector<uint8_t> shadow(32768, 0);

    // The CPU's bus, in the format tools/bus_trace.lua writes from MAME, so
    // that tools/diff_bus.py can hold this 6502 to that one transaction by
    // transaction (METHODOLOGY section 4).
    FILE *bus = bustrace.empty() ? nullptr : fopen(bustrace.c_str(), "w");
    long bus_count = 0;

    // The sound, at the rate the Pocket takes it: 96 MHz / 2000 is exactly
    // 48 kHz, the same rate MAME writes, so tools/compare_audio.py can put
    // the two side by side without resampling either.
    std::vector<int16_t> pcm;
    long wav_div = 0;

    std::vector<uint8_t> fb(W * H * 3, 0);
    long frame = 0, x = 0, y = -1, active = 0, active_prev = 0;
    int prev_vs = 0, prev_de = 0, prev_hs = 0;
    long fetches = 0, stretched = 0;
    double last_vs_ms = 0, frame_ms = 0;

    auto write_frame = [&](double at_ms) {
        char name[512];
        snprintf(name, sizeof name, "%s/frame_%05.0fms.rgb", out.c_str(), at_ms);
        FILE *o = fopen(name, "wb");
        if (!o) { fprintf(stderr, "cannot write %s\n", name); return; }
        fwrite(fb.data(), 1, fb.size(), o);
        fclose(o);
        printf("  %8.2f ms  frame %ld  %ld active pixels  %.3f ms/frame -> %s\n",
               at_ms, frame, active_prev, frame_ms, name);
    };

    while (ms_now() < run_ms) {
        tick();

        if (dut->trc_cen && trace_n > 0 && ms_now() >= trace_from &&
            (!io_only || (dut->trc_addr >= 0xFC00 && dut->trc_addr < 0xFF00)) &&
            (pc_lo < 0 || (dut->trc_addr >= pc_lo && dut->trc_addr <= pc_hi)) &&
            (!wonly || !dut->trc_rnw)) {
            printf("%8.3fms  %04X %c %02X  irq=%X ic32=%02X pa=%02X%s\n",
                   ms_now(), dut->trc_addr, dut->trc_rnw ? 'r' : 'w',
                   dut->trc_data, dut->trc_irq, dut->trc_dbg >> 8,
                   dut->trc_dbg & 0xFF,
                   dut->trc_sync ? "  <- opcode" : "");
            trace_n--;
        }
        if (bus && dut->trc_cen && bus_count < bus_n) {
            fprintf(bus, "%c %04X %02X\n", dut->trc_rnw ? 'R' : 'W',
                    dut->trc_addr, dut->trc_data);
            if (++bus_count == bus_n) { fclose(bus); bus = nullptr;
                printf("bus trace: %ld transactions -> %s\n", bus_count,
                       bustrace.c_str()); }
        }
        if (dut->trc_cen && !dut->trc_rnw && dut->trc_addr < 0x8000)
            shadow[dut->trc_addr] = dut->trc_data;
        if (!wav.empty() && ++wav_div == 2000) {
            wav_div = 0;
            if (ms_now() >= wav_from) pcm.push_back(dut->snd);
        }
        if (dut->dbg_bus) fetches++;
        if (dut->dbg_wait) stretched++;

        // keyboard, by time
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
        if (hs && !prev_hs) { x = 0; if (raw) y++; }
        if (de && !prev_de && !raw) { x = 0; y++; }

        if (de || raw) {
            if (y >= 0 && y < H && x < W) {
                uint32_t c = dut->rgb;
                size_t o = ((size_t)y * W + x) * 3;
                fb[o + 0] = (c >> 16) & 0xFF;
                fb[o + 1] = (c >> 8) & 0xFF;
                fb[o + 2] = c & 0xFF;
            }
            x++; active++;
        }
        prev_vs = vs; prev_de = de; prev_hs = hs;
    }

    if (!quiet)
        printf("%.1f ms: %ld frames (last %.3f ms = %.2f Hz), %ld opcode fetches, "
               "%ld clocks stretched\n",
               ms_now(), frame, frame_ms, frame_ms > 0 ? 1000.0 / frame_ms : 0.0,
               fetches, stretched);
    if (bus) {
        fclose(bus);
        printf("bus trace: %ld transactions -> %s\n", bus_count, bustrace.c_str());
    }
    if (!wav.empty()) {
        FILE *o = fopen(wav.c_str(), "wb");
        if (!o) fprintf(stderr, "cannot write %s\n", wav.c_str());
        else {
            uint32_t n = (uint32_t)pcm.size() * 2, rate = 48000;
            auto w32 = [&](uint32_t v) { fwrite(&v, 4, 1, o); };
            auto w16 = [&](uint16_t v) { fwrite(&v, 2, 1, o); };
            fwrite("RIFF", 1, 4, o); w32(36 + n); fwrite("WAVE", 1, 4, o);
            fwrite("fmt ", 1, 4, o); w32(16); w16(1); w16(1);
            w32(rate); w32(rate * 2); w16(2); w16(16);
            fwrite("data", 1, 4, o); w32(n);
            fwrite(pcm.data(), 1, n, o);
            fclose(o);
            printf("wrote %s (%zu samples, %.3f s at 48 kHz)\n",
                   wav.c_str(), pcm.size(), pcm.size() / 48000.0);
        }
    }
    if (!dumpram.empty()) {
        FILE *o = fopen(dumpram.c_str(), "wb");
        if (o) {
            fwrite(shadow.data(), 1, shadow.size(), o);
            fclose(o);
            printf("wrote %s (32768 bytes of RAM, as the CPU wrote it)\n",
                   dumpram.c_str());
        }
    }
    delete dut;
    return 0;
}

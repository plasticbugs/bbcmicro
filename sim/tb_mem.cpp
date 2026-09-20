// Pocket memory gate: push a disc image through bbcmicro_mem's download port
// at the APF loader's rate, then read every byte back through the disc
// controller's port and compare.  Then write through it and read that back.
//
//   obj_mem/Vtb_mem_top [-gap N] [-hold N] [-quick] [-size N]
//
// The image is pseudo-random, which is a harder test than a real one (no runs
// of equal bytes to hide a dropped or merged write) and needs nothing the
// repository may not hold.
//
// -gap   clocks between download bytes.  The loader delivers one per 8;
//        smaller is harder.  A core that passes at 12 and fails at 8 has the
//        fault that blacked out two earlier cores (METHODOLOGY 5.16).
// -hold  clocks the write strobe is held high.  The Pocket holds it for 4
//        with address and data stable; anything that counts, sums or pushes
//        on the strobe's level rather than its edge fails here (5.8).
//
// The layout constants must match target/pocket/bbcmicro_mem.sv.
#include "Vtb_mem_top.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

static Vtb_mem_top *dut;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); }

static const uint32_t DSD = 409600;     // the largest image a drive can hold

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    int gap = 8, hold = 4;
    bool quick = false;
    uint32_t size = DSD;
    for (int i = 1; i < argc; i++) {
        std::string a = argv[i];
        if (a == "-gap" && i + 1 < argc) gap = atoi(argv[++i]);
        else if (a == "-hold" && i + 1 < argc) hold = atoi(argv[++i]);
        else if (a == "-size" && i + 1 < argc) size = strtoul(argv[++i], nullptr, 0);
        else if (a == "-quick") quick = true;
    }
    if (hold >= gap) hold = gap - 1;
    if (hold < 1) hold = 1;

    // two images, one per drive, each its own pseudo-random stream
    std::vector<uint8_t> img[2];
    for (int d = 0; d < 2; d++) {
        img[d].resize(size);
        uint32_t x = 0x2545F491u + d * 0x9E3779B9u;
        for (auto &b : img[d]) { x ^= x << 13; x ^= x >> 17; x ^= x << 5; b = uint8_t(x >> 11); }
    }

    dut = new Vtb_mem_top;
    dut->init = 1; dut->rd_late = 1; dut->burst_slow = 0;
    dut->dl_we = 0; dut->dl_active = 0; dut->dl_drive = 0;
    dut->disc_req = 0; dut->disc_we = 0; dut->disc_drive = 0;
    for (int i = 0; i < 16; i++) tick();
    dut->init = 0;
    long t = 0; while (!dut->ready && t++ < 200000) tick();
    printf("sdram ready after %ld clocks\n", t);
    if (!dut->ready) { printf("FAIL  the controller never came ready\n"); return 1; }

    for (int d = 0; d < 2; d++) {
        printf("drive %d: %u bytes, one per %d clocks, strobe held %d...\n",
               d, size, gap, hold);
        dut->dl_active = 1; dut->dl_drive = d;
        for (uint32_t a = 0; a < size; a++) {
            dut->dl_addr = a; dut->dl_data = img[d][a]; dut->dl_we = 1;
            for (int i = 0; i < hold; i++) tick();
            dut->dl_we = 0;
            for (int i = hold; i < gap; i++) tick();
        }
        for (int i = 0; i < 400; i++) tick();
        dut->dl_active = 0;
    }

    auto access = [&](int drive, uint32_t addr, bool we, uint8_t din) -> uint8_t {
        dut->disc_drive = drive; dut->disc_addr = addr;
        dut->disc_we = we; dut->disc_din = din; dut->disc_req = 1;
        int g = 0; while (!dut->disc_ack && g++ < 4000) tick();
        dut->disc_req = 0; tick();
        return dut->disc_q;
    };

    long bad = 0, checked = 0;
    const uint32_t step = quick ? 61 : 1;   // a prime stride still visits every row
    for (int d = 0; d < 2; d++) {
        for (uint32_t a = 0; a < size; a += step) {
            uint8_t got = access(d, a, false, 0);
            checked++;
            if (got != img[d][a]) {
                if (bad < 12)
                    printf("  drive %d [%06X] got %02X want %02X\n", d, a, got, img[d][a]);
                bad++;
            }
        }
    }
    printf("read back: %ld bytes through the disc port, %ld wrong\n", checked, bad);

    // writes: the controller writes single bytes, which the memory does with
    // byte enables rather than a read-modify-write, so a write must not
    // disturb its neighbour
    long wbad = 0;
    for (uint32_t a = 0x100; a < 0x110; a++) access(0, a, true, uint8_t(a ^ 0x5A));
    for (uint32_t a = 0x100; a < 0x110; a++) {
        uint8_t got = access(0, a, false, 0);
        if (got != uint8_t(a ^ 0x5A)) {
            printf("  write [%06X] read back %02X want %02X\n", a, got, uint8_t(a ^ 0x5A));
            wbad++;
        }
    }
    // and the bytes either side of the written run are untouched
    for (uint32_t a : {0x0FFu, 0x110u}) {
        uint8_t got = access(0, a, false, 0);
        if (got != img[0][a]) {
            printf("  neighbour [%06X] disturbed: %02X want %02X\n", a, got, img[0][a]);
            wbad++;
        }
    }
    printf("writes: %ld wrong\n", wbad);

    delete dut;
    if (bad || wbad) { printf("FAIL  what came back is not what was sent\n"); return 1; }
    printf("PASS  every byte of both images reads back as it was sent\n");
    return 0;
}

// Sideways RAM, on its own: with a board fitted, do banks 4-7 take writes and
// give them back, do banks 0-3 still answer from the ROM image, do banks 8-15
// read as empty sockets, and with no board fitted is nothing reachable above
// bank 3 at all?
//
//   obj_swram/Vbbc_rom
//
// rtl/bbc_rom.sv answers a clock after its address, so every read here is
// address, tick, tick, read -- the same shape the core uses.
//
// The module sees ROMSEL's four bits whatever `swram_en` says; it is the core
// that narrows the register to two bits when no board is fitted, so the
// "no board" checks below drive banks 0-3 only, which is all the core can
// present.  The one check that drives a high bank with the board absent is
// there to show the module does not answer from RAM on its own.
#include "Vbbc_rom.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>

static Vbbc_rom *dut;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); }

static void wr(int bank, int off, int v) {
    dut->paged_bank = bank; dut->paged_a = off;
    dut->paged_din = v; dut->paged_we = 1;
    tick();
    dut->paged_we = 0;
    tick();
}
static int rd(int bank, int off) {
    dut->paged_bank = bank; dut->paged_a = off;
    tick(); tick();
    return dut->paged_q;
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vbbc_rom;
    dut->dl_we = 0; dut->paged_we = 0; dut->swram_en = 0;
    dut->paged_bank = 0; dut->paged_a = 0;
    dut->mos_addr = 0; dut->font_addr = 0;
    for (int i = 0; i < 8; i++) tick();

    // an image in the paged ROM: a different byte in every bank
    for (int b = 0; b < 4; b++)
        for (int off = 0; off < 4; off++) {
            dut->dl_addr = (b << 14) | off;
            dut->dl_data = 0xA0 + b * 16 + off;
            dut->dl_we = 1; tick(); tick();
            dut->dl_we = 0; tick(); tick();
        }

    int bad = 0;
    auto check = [&](const char *what, int got, int want) {
        printf("  %-52s got %02X want %02X%s\n", what, got, want,
               got == want ? "" : "   FAIL");
        if (got != want) bad++;
    };

    // ---- no board fitted: the four banks of a bare machine, nothing else
    dut->swram_en = 0;
    check("no board: bank 0 is the image", rd(0, 0), 0xA0);
    check("no board: bank 3 is the image", rd(3, 0), 0xD0);
    wr(1, 0, 0x5A);
    check("no board: a write to bank 1 is ignored", rd(1, 0), 0xB0);
    wr(4, 0, 0x5A);
    check("no board: bank 4 is not RAM either", rd(4, 0), 0xA0);

    // ---- board fitted: 4-7 are RAM, 0-3 are still the image, 8-15 are empty
    dut->swram_en = 1;
    check("fitted: bank 4 reads zero before anything is written", rd(4, 0), 0x00);
    check("fitted: bank 0 still answers from the image", rd(0, 0), 0xA0);
    check("fitted: bank 3 still answers from the image", rd(3, 0), 0xD0);
    check("fitted: bank 8 is an empty socket", rd(8, 0), 0xFF);
    check("fitted: bank 15 is an empty socket", rd(15, 0), 0xFF);

    wr(4, 0, 0x44);
    wr(5, 0, 0x55);
    wr(6, 0, 0x66);
    wr(7, 0, 0x77);
    wr(4, 0x3FFF, 0x4F);
    wr(7, 0x3FFF, 0x7F);
    check("fitted: bank 4 keeps what was written", rd(4, 0), 0x44);
    check("fitted: bank 5 keeps its own byte", rd(5, 0), 0x55);
    check("fitted: bank 6 keeps its own byte", rd(6, 0), 0x66);
    check("fitted: bank 7 keeps its own byte", rd(7, 0), 0x77);
    check("fitted: bank 4 at the top of its 16K", rd(4, 0x3FFF), 0x4F);
    check("fitted: bank 7 at the top of its 16K", rd(7, 0x3FFF), 0x7F);
    check("fitted: all four are separate 16K, bank 4 undisturbed", rd(4, 0), 0x44);

    // a write to a bank that is not RAM must not reach the image or the RAM
    wr(0, 0, 0x99);
    wr(9, 0, 0x99);
    check("fitted: a write to bank 0 does not reach the image", rd(0, 0), 0xA0);
    check("fitted: a write to an empty bank stays empty", rd(9, 0), 0xFF);
    check("fitted: and disturbed neither bank 4", rd(4, 0), 0x44);
    check("fitted: nor bank 5", rd(5, 0), 0x55);

    // ---- the board taken out and put back: contents survive, as a real
    // board's do across BREAK, and nothing above bank 3 is reachable meanwhile
    dut->swram_en = 0;
    check("unfitted again: bank 4 is not RAM", rd(4, 0), 0xA0);
    dut->swram_en = 1;
    check("refitted: bank 4 still holds its RAM", rd(4, 0), 0x44);
    check("refitted: bank 7 still holds its RAM", rd(7, 0x3FFF), 0x7F);

    delete dut;
    printf(bad ? "\nFAIL\n" : "\nPASS\n");
    return bad ? 1 : 0;
}

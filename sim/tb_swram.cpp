// Sideways RAM, on its own: does a socket selected as RAM take writes and
// give them back, does a socket that is not selected still answer from the
// ROM image, and does the choice of sockets do what the menu says?
//
//   obj_swram/Vbbc_rom
//
// rtl/bbc_rom.sv answers a clock after its address, so every read here is
// address, tick, tick, read -- the same shape the core uses.
#include "Vbbc_rom.h"
#include "verilated.h"
#include <cstdio>
#include <cstdlib>

static Vbbc_rom *dut;
static void tick() { dut->clk = 0; dut->eval(); dut->clk = 1; dut->eval(); }

// bank 0..3, offset 0..0x3FFF
static void wr(int bank, int off, int v) {
    dut->paged_addr = (bank << 14) | off;
    dut->paged_din = v; dut->paged_we = 1;
    tick();
    dut->paged_we = 0;
    tick();
}
static int rd(int bank, int off) {
    dut->paged_addr = (bank << 14) | off;
    tick(); tick();
    return dut->paged_q;
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vbbc_rom;
    dut->dl_we = 0; dut->paged_we = 0; dut->slots = 0;
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
        printf("  %-46s got %02X want %02X%s\n", what, got, want,
               got == want ? "" : "   FAIL");
        if (got != want) bad++;
    };

    // with no socket set to RAM, every bank is the image and writes do nothing
    dut->slots = 0;
    check("sockets off: bank 1 reads the image", rd(1, 0), 0xB0);
    wr(1, 0, 0x5A);
    check("sockets off: a write to bank 1 is ignored", rd(1, 0), 0xB0);

    // socket 1 as RAM: it takes writes, and the others do not change
    dut->slots = 0b0010;
    check("socket 1 as RAM reads zero before anything is written", rd(1, 0), 0x00);
    wr(1, 0, 0x5A);
    wr(1, 0x3FFF, 0x5B);
    check("socket 1 keeps what was written", rd(1, 0), 0x5A);
    check("socket 1 keeps it at the top of the bank", rd(1, 0x3FFF), 0x5B);
    check("socket 0 still answers from the image", rd(0, 0), 0xA0);
    check("socket 2 still answers from the image", rd(2, 0), 0xC0);
    check("socket 3 still answers from the image", rd(3, 0), 0xD0);
    wr(2, 0, 0x77);
    check("a write to socket 2 does not reach the image", rd(2, 0), 0xC0);

    // sockets 1 and 2 as RAM: two separate banks, not one mirrored twice
    dut->slots = 0b0110;
    wr(1, 0x100, 0x11);
    wr(2, 0x100, 0x22);
    check("socket 1 and socket 2 are separate 16K", rd(1, 0x100), 0x11);
    check("socket 2 has its own contents", rd(2, 0x100), 0x22);
    check("what socket 1 held earlier is still there", rd(1, 0), 0x5A);

    // turning the option off hands the sockets back to the image, and the
    // contents survive for when it is turned on again
    dut->slots = 0;
    check("switched off, socket 1 is the image again", rd(1, 0), 0xB0);
    dut->slots = 0b0010;
    check("switched back on, socket 1 still holds its RAM", rd(1, 0), 0x5A);

    // sockets 0 and 3 are masked off inside the module rather than merely
    // asked not to be set: the RAM's address folds the socket number down to
    // one bit, so a stray bit here would alias onto 1's or 2's 16K and show
    // up as a corrupted ROM rather than as an obvious wrong answer
    dut->slots = 0b1001;
    check("a socket 0 asked for as RAM is refused", rd(0, 0), 0xA0);
    check("a socket 3 asked for as RAM is refused", rd(3, 0), 0xD0);
    wr(0, 0, 0x99);
    wr(3, 0, 0x99);
    dut->slots = 0b0110;
    check("and a write through it did not disturb socket 1", rd(1, 0), 0x5A);
    check("nor socket 2", rd(2, 0x100), 0x22);

    delete dut;
    printf(bad ? "\nFAIL\n" : "\nPASS\n");
    return bad ? 1 : 0;
}

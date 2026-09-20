//------------------------------------------------------------------------------
// Clock enables from the 96 MHz system clock (docs/core-design.md section 1).
//
// The BBC Micro divides one 16 MHz crystal and 96 is 6 x 16, so every clock in
// the machine is an exact division of the Pocket's system clock and there is no
// fractional accumulator anywhere:
//
//   cen_16m   the video ULA's dot clock, 96/6          modes 0-6
//   cen_12m   the SAA5050's dot clock,   96/8          MODE 7
//   phase     0..5 within each 16 MHz cycle, so the rest of the machine can
//             place itself inside a cycle the way the real one does
//
// Everything slower -- the CRTC, the CPU, the 1 MHz bus, the 4 MHz VIA tick --
// is derived in bbcmicro_core.sv from `phase` and the video ULA's own 16-count
// cycle counter, because that counter is the one the video fetch is timed by
// and there must only be one of it (the ULA never resets it, so a second
// counter here would sit at an unknown phase relative to it after a reset).
//
// Pausing freezes nothing here: the picture must stay up while the Pocket's
// menu is open (METHODOLOGY section 5.5), so the dot clocks keep running and
// bbcmicro_core masks the CPU, VIA and sound enables instead.
//------------------------------------------------------------------------------
`default_nettype none

module clk_enables (
    input  logic clk,
    input  logic rst,
    // One pulse just after each edge of the platform's video clock, which
    // restarts the dot divider.  Without it the dot enable would sit at
    // whatever phase the reset left it in, and the pixel handed to the video
    // clock could be sampled while it changes (METHODOLOGY section 5.4).
    input  logic pix_sync,
    output logic       cen_16m,
    output logic       cen_12m,
    output logic [2:0] phase      // 0..5 inside the 16 MHz cycle
);
    // 96 / 6 = 16 MHz.  clk_vid is the same 16 MHz from the same PLL, and
    // pix_sync pins this divider to it, so the pixel the video clock samples
    // has been stable for a known number of system clocks.
    logic [2:0] d16;
    always_ff @(posedge clk) begin
        if (rst) d16 <= 3'd0;
        else if (pix_sync) d16 <= 3'd0;
        else if (d16 == 3'd5) d16 <= 3'd0;
        else d16 <= d16 + 3'd1;
    end
    assign phase   = d16;
    assign cen_16m = (d16 == 3'd0);

    // 96 / 8 = 12 MHz for the teletext generator.  It is not a division of
    // the 16 MHz dot clock, which is the whole reason MODE 7 needs its own.
    logic [2:0] d12;
    always_ff @(posedge clk) begin
        if (rst) d12 <= 3'd0;
        else d12 <= d12 + 3'd1;
    end
    assign cen_12m = (d12 == 3'd0);
endmodule

`default_nettype wire

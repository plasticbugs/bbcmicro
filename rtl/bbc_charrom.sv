//------------------------------------------------------------------------------
// The SAA5050's character generator.
//
// Upstream's saa5050.vhd instantiates a 4096-entry table holding both the
// alphanumeric font and the mosaic graphics characters.  This core may not
// carry ROM data, and the font is in the user's own romset anyway
// (bbcmicro.rom, from MAME's saa5050:chargen region), so the font half is a
// block RAM filled by the loader and the graphics half is generated here.
//
// The interface is the one the module already had: two independent addresses,
// data one clock later.  Address, as upstream builds it:
//
//   [11]    1 = graphics half
//   [10:4]  character code
//   [3:0]   row within the 10-row cell
//
// Data, as upstream reads it:
//
//   [5:0]   the row's six pixels, which the shift register doubles to twelve
//   [7]     1 = this is a mosaic graphics character, so separated-graphics
//           blanking and hold-graphics apply to it
//
// The font in the image is 96 characters of 10 rows, code 0x20 first, five
// bits per row (bit 4 leftmost) -- so an alphanumeric row is the font byte
// unchanged with bit 7 clear, and rows 10-15 are blank.
//
// Mosaic graphics, from MAME's saa5050.cpp and confirmed against upstream's
// table: each character is two columns by three blocks, the blocks being rows
// 0-2, 3-6 and 7-9, and the bits of the code are
//
//   bit 0 top left    bit 1 top right
//   bit 2 mid left    bit 3 mid right
//   bit 4 low left    bit 6 low right
//
// with bit 5 distinguishing graphics from alphanumerics: codes 0x40-0x5F are
// letters even in graphics mode, which is why the flag in bit 7 is per
// character and not just "the graphics half".
//------------------------------------------------------------------------------
`default_nettype none

module bbc_charrom (
    input  logic        clk,

    // to rtl/bbc_rom.sv's font block RAM
    output logic  [9:0] font_addr,
    input  logic  [7:0] font_q,

    // the two ports saa5050.vhd asks for
    input  logic [11:0] a1,
    output logic  [7:0] d1,
    input  logic [11:0] a2,
    output logic  [7:0] d2
);
    // ---------------------------------------------------------------- decode
    // One font RAM, two addresses: the two ports are read on alternate system
    // clocks and held, which costs nothing at 96 MHz (the SAA5050 asks for a
    // new character every 12 pixels of a 12 MHz clock, 64 system clocks) and
    // keeps this to a single block RAM rather than a duplicated one.
    logic        ping;
    logic [11:0] a_sel;
    always_ff @(posedge clk) ping <= ~ping;
    assign a_sel = ping ? a2 : a1;

    // (code - 0x20) * 10 + row, for codes 0x20..0x7F and rows 0..9
    wire  [6:0] code = a_sel[10:4];
    wire  [3:0] row  = a_sel[3:0];
    wire  [6:0] idx  = code - 7'h20;
    wire  [9:0] base = {idx, 3'd0} + {2'd0, idx, 1'd0};      // idx*8 + idx*2
    wire        alpha_valid = (code >= 7'h20) && (row <= 4'd9);
    assign font_addr = base + {6'd0, row};

    // ------------------------------------------------------------- graphics
    // codes 0x40-0x5F are letters even in the graphics half: bit 6 set, bit 5 clear
    wire        is_gfx = a_sel[11] && !(code[6] && !code[5]);
    wire  [2:0] block  = (row <= 4'd2) ? 3'd0 : (row <= 4'd6) ? 3'd1 : 3'd2;
    logic       left, right;
    always_comb begin
        case (block)
            3'd0:    begin left = code[0]; right = code[1]; end
            3'd1:    begin left = code[2]; right = code[3]; end
            default: begin left = code[4]; right = code[6]; end
        endcase
    end
    wire [7:0] gfx_byte = (row <= 4'd9) ? {1'b1, 1'b0, {3{left}}, {3{right}}} : 8'h00;

    // ------------------------------------------------------------ the ports
    // The font RAM answers one clock after its address, so the select that
    // chose the address has to be delayed with it, as does the generated
    // graphics byte.
    logic       ping_d, gfx_d, alpha_d;
    logic [7:0] gfx_byte_d;
    always_ff @(posedge clk) begin
        ping_d     <= ping;
        gfx_d      <= is_gfx;
        alpha_d    <= alpha_valid;
        gfx_byte_d <= gfx_byte;
    end

    wire [7:0] answer = gfx_d   ? gfx_byte_d
                      : alpha_d ? {2'b00, font_q[5:0]}
                                : 8'h00;

    always_ff @(posedge clk) begin
        if (ping_d) d2 <= answer;
        else        d1 <= answer;
    end
endmodule

`default_nettype wire

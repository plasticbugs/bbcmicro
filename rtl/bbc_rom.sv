//------------------------------------------------------------------------------
// The machine's read-only memories, in block RAM, filled by the Pocket's
// loader (docs/core-design.md sections 2 and 3).
//
//   image 0x00000..0x0FFFF   4 sideways ROM sockets of 16K   -> paged
//   image 0x10000..0x13FFF   the MOS                         -> mos
//   image 0x14000..0x143FF   the SAA5050 font, 960 bytes     -> font
//
// Three separate one-dimensional, power-of-two RAMs, addressed by
// concatenation, because that is the one shape a synthesiser cannot interpret
// two ways (METHODOLOGY section 5.18).
//
// The download writes straight in.  A block RAM write cannot stall, so this
// path needs no FIFO -- unlike the SDRAM the disc images go to.  Each byte is
// taken on the *rising edge* of the strobe, never its level: the Pocket holds
// the strobe for four clocks with the address and data stable underneath, and
// anything that acts on the level acts four times (METHODOLOGY section 5.8).
// Here a repeated write would be harmless, but the edge is free and the habit
// is not optional.
//------------------------------------------------------------------------------
`default_nettype none

module bbc_rom (
    input  logic        clk,

    // from the Pocket's data slot 0
    input  logic        dl_we,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,

    // the CPU's two ROM windows
    input  logic [15:0] paged_addr,     // {romsel[1:0], a[13:0]}
    output logic  [7:0] paged_q,

    // Sideways RAM.  A Model B has four sockets and this image fills two of
    // them -- DNFS in 0, BASIC in 3 -- so 1 and 2 are the ones a real board
    // would have RAM in, and that is what `slots` selects: a bit per socket,
    // and only 1 and 2 are ever set.  A bank that is RAM answers reads from
    // its own 16K instead of the image and takes writes from the CPU.
    input  logic  [3:0] slots,          // which sockets are RAM
    input  logic        paged_we,       // the CPU is writing &8000-&BFFF
    input  logic  [7:0] paged_din,
    input  logic [13:0] mos_addr,
    output logic  [7:0] mos_q,

    // the teletext character generator (rtl/bbc_charrom.sv)
    input  logic  [9:0] font_addr,
    output logic  [7:0] font_q,

    // bring-up: a checksum of everything written, and how many bytes
    output logic [15:0] dl_sum,
    output logic [24:0] dl_count
);
    localparam logic [24:0] MOS_BASE  = 25'h10000;
    localparam logic [24:0] FONT_BASE = 25'h14000;
    localparam logic [24:0] IMG_END   = 25'h14400;

    // no_rw_check: the loader writes these while the machine is held in
    // reset, so no read ever needs to see a write made on the same clock and
    // the read-during-write bypass Quartus would otherwise build is pure
    // cost.  It was not free: the longest path in the fit ran from the paged
    // ROM's write-enable register, through that mux and cpu_di, into the
    // 6502's ALU adder, and missed the cold corner by 0.255 ns.
    (* ramstyle = "no_rw_check" *) logic [7:0] paged [65536];
    (* ramstyle = "no_rw_check" *) logic [7:0] mos   [16384];
    (* ramstyle = "no_rw_check" *) logic [7:0] font  [1024];

    // 32K, enough for sockets 1 and 2.  It is not cleared on BREAK, because a
    // real sideways RAM board is not either -- that is what makes it useful
    // and what the persistence test checks.  It powers up as zeros, which the
    // OS reads as an empty socket rather than as a ROM header it should try
    // to enter.
    (* ramstyle = "no_rw_check" *) logic [7:0] swram [32768];
    // only 1 and 2, enforced here and not just asked for: the address below
    // folds the socket number down to one bit, so a socket 0 or 3 set by
    // mistake would alias onto 1's or 2's 16K rather than fail visibly
    wire  [3:0] slots_ok = slots & 4'b0110;
    wire        sw_hit  = slots_ok[paged_addr[15:14]];
    wire [14:0] sw_addr = {paged_addr[15], paged_addr[13:0]};

    logic dl_we_d;
    wire  take = dl_we && !dl_we_d;

    wire in_font = (dl_addr >= FONT_BASE) && (dl_addr < IMG_END);
    wire in_mos  = (dl_addr >= MOS_BASE)  && (dl_addr < FONT_BASE);
    wire in_page = (dl_addr < MOS_BASE);

    always_ff @(posedge clk) begin
        dl_we_d <= dl_we;
        if (take) begin
            if (in_page) paged[dl_addr[15:0]] <= dl_data;
            if (in_mos)  mos[dl_addr[13:0]]   <= dl_data;
            if (in_font) font[dl_addr[9:0]]   <= dl_data;
            // Fletcher-style running sum over the whole image, so the panel
            // can show that what arrived is what was sent -- reading back the
            // first byte of a region proves the path, not the image
            // (METHODOLOGY section 5.21).  The image always starts at byte 0,
            // so that is where the sum starts again; the core's own reset must
            // not clear it, because the machine resets whenever the user asks.
            if (dl_addr == 25'd0) begin
                dl_sum   <= {8'd0 + dl_data, dl_data};
                dl_count <= 25'd1;
            end else begin
                dl_sum   <= {dl_sum[15:8] + dl_sum[7:0] + dl_data, dl_sum[7:0] + dl_data};
                dl_count <= dl_count + 25'd1;
            end
        end
    end

    logic [7:0] rom_q, sw_q;
    logic       sw_hit_d;
    always_ff @(posedge clk) begin
        rom_q    <= paged[paged_addr];
        sw_q     <= swram[sw_addr];
        sw_hit_d <= sw_hit;
        if (paged_we && sw_hit) swram[sw_addr] <= paged_din;
        mos_q   <= mos[mos_addr];
        font_q  <= font[font_addr];
    end
    // the read is a clock behind the address, so which array answered has to
    // be a clock behind too
    assign paged_q = sw_hit_d ? sw_q : rom_q;
endmodule

`default_nettype wire

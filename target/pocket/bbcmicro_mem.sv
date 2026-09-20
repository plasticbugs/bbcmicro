//------------------------------------------------------------------------------
// The Pocket's memories behind the core's ports (docs/core-design.md section 2).
//
//   SDRAM   drive 0 image   512 KB   byte 0x000000
//           drive 1 image   512 KB   byte 0x080000
//
// That is all.  Everything the CPU touches -- 32K of RAM, the MOS, the four
// sideways sockets and the teletext font -- is block RAM inside the core, so
// the CPU never waits for memory and there is no arbiter in its path.  The
// only client out here is the disc controller, which wants one byte every
// 32 us and can wait as long as it likes.
//
// The Pocket's SRAM is not used: a disc image does not fit in 128 KB and
// nothing else needs it.
//
// The download is the part that cannot be told to wait, and it is the part
// that broke two cores before this one (METHODOLOGY section 5.16): the loader
// sends a byte every eight clocks whatever the SDRAM is doing, so the paired
// words go into a FIFO deep enough to ride out a refresh or a row change, and
// each byte is taken once, on the rising edge of a strobe the Pocket holds for
// four clocks.
//------------------------------------------------------------------------------
`default_nettype none

module bbcmicro_mem (
    input  logic        clk,            // 96 MHz
    input  logic        clk_sdram,      // 96 MHz, phase shifted, drives the pin
    input  logic        init,           // hold to (re)initialise the SDRAM
    output logic        ready,

    input  logic        rd_late,        // SDRAM diagnostics, from the Pocket menu
    input  logic        burst_slow,

    // a disc image arriving from the Pocket
    input  logic        dl_we,
    input  logic [24:0] dl_addr,        // byte within the drive's image
    input  logic  [7:0] dl_data,
    input  logic        dl_drive,       // which drive it is for
    input  logic        dl_active,

    // the core's disc controller
    input  logic        disc_req,
    input  logic        disc_we,
    input  logic        disc_drive,
    input  logic [19:0] disc_addr,
    input  logic  [7:0] disc_din,
    output logic        disc_ack,
    output logic  [7:0] disc_q,

    // SDRAM pins
    inout  wire  [15:0] SDRAM_DQ,
    output logic [12:0] SDRAM_A,
    output logic        SDRAM_DQML, SDRAM_DQMH,
    output logic  [1:0] SDRAM_BA,
    output logic        SDRAM_nCS, SDRAM_nWE, SDRAM_nRAS, SDRAM_nCAS,
    output logic        SDRAM_CKE, SDRAM_CLK
);
    // Each drive gets 512 KB, which holds a double-sided 400 KB image, and the
    // base is a power of two so the drive number is a bit of the address.
    // ------------------------------------------------------------ download
    localparam int DLQ = 64;
    logic [39:0] dlq [DLQ];             // {word address [24:1], data [15:0]}
    logic  [6:0] dlq_wp, dlq_rp;
    logic  [7:0] dl_lo;
    logic        dl_we_d;
    wire         dlq_empty = (dlq_wp == dlq_rp);
    wire  [39:0] dlq_head  = dlq[dlq_rp[5:0]];
    wire         nb        = dl_we && !dl_we_d;   // one byte, once

    // The image is a byte stream and the SDRAM is 16 bits wide, so bytes are
    // paired little-endian: byte 2n in the low half, byte 2n+1 in the high
    // half, which is the order the disc controller reads them back in.
    wire [24:1] dl_target = {5'd0, dl_drive, dl_addr[18:1]};

    always_ff @(posedge clk) begin
        dl_we_d <= dl_we;
        if (init) begin
            dlq_wp <= '0;
            dlq_rp <= '0;
        end else begin
            if (nb) begin
                if (!dl_addr[0]) dl_lo <= dl_data;
                else begin
                    dlq[dlq_wp[5:0]] <= {dl_target, dl_data, dl_lo};
                    dlq_wp <= dlq_wp + 7'd1;
                end
            end
            if (!dlq_empty && dl_ack) dlq_rp <= dlq_rp + 7'd1;
        end
    end

    // ---------------------------------------------------- SDRAM clients
    // 0 the download (writes, cannot wait), 1 the disc controller.
    localparam int NCLI = 2;
    logic [24:1] c_addr  [NCLI];
    logic        c_req   [NCLI];
    logic        c_we    [NCLI];
    logic [15:0] c_wdata [NCLI];
    logic  [1:0] c_be    [NCLI];
    logic        c_ack   [NCLI];
    logic [15:0] rdata;

    wire dl_ack = c_ack[0];
    assign c_addr[0]  = dlq_head[39:16];
    assign c_req[0]   = !dlq_empty;
    assign c_we[0]    = 1'b1;
    assign c_wdata[0] = dlq_head[15:0];
    assign c_be[0]    = 2'b11;

    // The disc controller reads and writes single bytes.  A write uses the
    // byte enables rather than a read-modify-write, so it is one access.
    assign c_addr[1]  = {4'd0, disc_drive, disc_addr[19:1]};
    assign c_req[1]   = disc_req && !disc_ack;
    assign c_we[1]    = disc_we;
    assign c_wdata[1] = {disc_din, disc_din};
    assign c_be[1]    = disc_addr[0] ? 2'b10 : 2'b01;

    logic disc_lo;
    always_ff @(posedge clk) begin
        disc_ack <= c_ack[1];
        if (c_req[1]) disc_lo <= disc_addr[0];
        if (c_ack[1]) disc_q <= disc_lo ? rdata[15:8] : rdata[7:0];
    end

    // ------------------------------------------------------------- SDRAM
    sdram_ctrl #(.NCLI(NCLI)) u_sdram (
        .clk(clk), .clk_pin(clk_sdram), .init(init),
        .rd_late(rd_late), .burst_slow(burst_slow), .ready(ready),
        .SDRAM_DQ(SDRAM_DQ), .SDRAM_A(SDRAM_A),
        .SDRAM_DQML(SDRAM_DQML), .SDRAM_DQMH(SDRAM_DQMH), .SDRAM_BA(SDRAM_BA),
        .SDRAM_nCS(SDRAM_nCS), .SDRAM_nWE(SDRAM_nWE),
        .SDRAM_nRAS(SDRAM_nRAS), .SDRAM_nCAS(SDRAM_nCAS),
        .SDRAM_CKE(SDRAM_CKE), .SDRAM_CLK(SDRAM_CLK),
        .c_addr(c_addr), .c_req(c_req), .c_we(c_we), .c_wdata(c_wdata),
        .c_be(c_be), .c_ack(c_ack), .rdata(rdata),
        // no burst client: nothing here reads more than a byte at a time
        .b_addr(24'd0), .b_len(10'd0),
        .b_req(1'b0), .b_abort(1'b0),
        .b_wr(), .b_idx(), .b_data(), .b_done(),
        .b_we(1'b0), .b_wdata(16'd0), .b_be(2'b00), .b_widx()
    );

    wire _unused = &{1'b0, dl_active, dl_addr[24:19], 1'b0};
endmodule

`default_nettype wire

// Bench wrapper for target/pocket/bbcmicro_mem.sv: the Pocket memory subsystem
// with a behavioural SDRAM behind the pins.  sim/tb_mem.cpp pushes a disc
// image in through the download port at the APF loader's rate and reads every
// byte back through the disc controller's port.
//
// This is the gate two cores shipped without (METHODOLOGY section 5.16): a
// whole-machine bench that answers the machine from arrays never exercises
// the controller, the arbiter, or the download path that fills it.  In this
// core the only thing out here is the disc image -- the ROMs and the RAM are
// block RAM inside the machine -- so this is the gate for the disc.
`default_nettype none
module tb_mem_top (
    input  logic        clk,
    input  logic        init,
    output logic        ready,
    input  logic        rd_late, burst_slow,
    input  logic        dl_we,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,
    input  logic        dl_drive,
    input  logic        dl_active,
    input  logic        disc_req, disc_we, disc_drive,
    input  logic [19:0] disc_addr,
    input  logic  [7:0] disc_din,
    output logic        disc_ack,
    output logic  [7:0] disc_q
);
    wire [15:0] SDRAM_DQ; wire [12:0] SDRAM_A; wire [1:0] SDRAM_BA;
    wire        SDRAM_DQML, SDRAM_DQMH, SDRAM_nCS, SDRAM_nWE, SDRAM_nRAS, SDRAM_nCAS;
    wire        SDRAM_CKE, SDRAM_CLK;

    bbcmicro_mem dut (
        .clk(clk), .clk_sdram(clk), .init(init), .ready(ready),
        .rd_late(rd_late), .burst_slow(burst_slow),
        .dl_we(dl_we), .dl_addr(dl_addr), .dl_data(dl_data),
        .dl_drive(dl_drive), .dl_active(dl_active),
        .disc_req(disc_req), .disc_we(disc_we), .disc_drive(disc_drive),
        .disc_addr(disc_addr), .disc_din(disc_din),
        .disc_ack(disc_ack), .disc_q(disc_q),
        .SDRAM_DQ(SDRAM_DQ), .SDRAM_A(SDRAM_A), .SDRAM_BA(SDRAM_BA),
        .SDRAM_DQML(SDRAM_DQML), .SDRAM_DQMH(SDRAM_DQMH),
        .SDRAM_nCS(SDRAM_nCS), .SDRAM_nWE(SDRAM_nWE), .SDRAM_nRAS(SDRAM_nRAS),
        .SDRAM_nCAS(SDRAM_nCAS), .SDRAM_CKE(SDRAM_CKE), .SDRAM_CLK(SDRAM_CLK)
    );

    sdram_model #(.AW(24)) chip (
        .clk(clk), .dq(SDRAM_DQ), .a(SDRAM_A), .ba(SDRAM_BA),
        .dqml(SDRAM_DQML), .dqmh(SDRAM_DQMH), .cs_n(SDRAM_nCS),
        .ras_n(SDRAM_nRAS), .cas_n(SDRAM_nCAS), .we_n(SDRAM_nWE), .cke(SDRAM_CKE)
    );
endmodule

`default_nettype wire

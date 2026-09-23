// The whole machine on the real memory glue: rtl/bbcmicro_core.sv driving
// target/pocket/bbcmicro_mem.sv, the real SDRAM controller, and a behavioural
// SDRAM chip behind the pins -- with both images pushed in through the
// download ports at the Pocket loader's rate.
//
// This is the bench METHODOLOGY section 5.16 is about: the fast bench
// (sim/tb_boot_top.sv) answers the disc from an array, with no arbitration,
// no refresh and no download contention, and everything between the core's
// ports and the pins is unverified until this one runs.
`default_nettype none

module tb_pocket_top (
    input  logic        clk,
    input  logic        rst,
    input  logic        mem_init,   // the real core drives this from the PLL
                                    // lock, not from the machine's reset: the
                                    // controller has to come ready before an
                                    // image can be pushed into it, and the
                                    // machine is held in reset until it is
    input  logic        pause,

    // the ROM image, straight into the core's block RAM
    input  logic        dl_we,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,

    // a disc image, through the memory module's FIFO into SDRAM
    input  logic        disc_dl_we,
    input  logic [24:0] disc_dl_addr,
    input  logic  [7:0] disc_dl_data,
    input  logic        disc_dl_drive,
    input  logic        disc_dl_active,
    input  logic  [1:0] disc_present,

    input  logic        kev_stb,
    input  logic        kev_press,
    input  logic  [3:0] kev_col,
    input  logic  [2:0] kev_row,
    input  logic        key_break,
    input  logic  [7:0] links,
    input  logic  [1:0] swram_sel,

    output logic        mem_ready,
    output logic [23:0] rgb,
    output logic        hsync, vsync, hblank, vblank,
    output logic        pix_ce, de,
    output logic signed [15:0] snd,
    output logic [15:0] dbg_rom_sum,
    output logic [24:0] dbg_rom_count,
    output logic [23:1] dbg_addr,
    output logic        dbg_bus, dbg_wait,
    output logic        trc_cen,
    output logic [15:0] trc_addr,
    output logic  [7:0] trc_data,
    output logic        trc_rnw,
    output logic        trc_sync,
    output logic  [3:0] trc_irq,
    output logic [15:0] trc_dbg,
    output logic  [7:0] dbg_fdc
);
    wire        disc_req, disc_we, disc_drive, disc_ack;
    wire [19:0] disc_addr;
    wire  [7:0] disc_din, disc_q;

    wire [15:0] SDRAM_DQ; wire [12:0] SDRAM_A; wire [1:0] SDRAM_BA;
    wire        SDRAM_DQML, SDRAM_DQMH, SDRAM_nCS, SDRAM_nWE, SDRAM_nRAS, SDRAM_nCAS;
    wire        SDRAM_CKE, SDRAM_CLK;

    bbcmicro_mem u_mem (
        .clk(clk), .clk_sdram(clk), .init(mem_init), .ready(mem_ready),
        .rd_late(1'b1), .burst_slow(1'b0),
        .dl_we(disc_dl_we), .dl_addr(disc_dl_addr), .dl_data(disc_dl_data),
        .dl_drive(disc_dl_drive), .dl_active(disc_dl_active),
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

    bbcmicro_core dut (
        .clk(clk), .rst(rst), .pause(pause), .pix_sync(1'b0),
        .dl_we(dl_we), .dl_addr(dl_addr), .dl_data(dl_data),
        .disc_req(disc_req), .disc_we(disc_we), .disc_drive(disc_drive),
        .disc_addr(disc_addr), .disc_din(disc_din),
        .disc_ack(disc_ack), .disc_q(disc_q),
        .disc_present(disc_present), .disc_dsided(2'b00),
        .kev_stb(kev_stb), .kev_press(kev_press),
        .kev_col(kev_col), .kev_row(kev_row), .kev_clear(1'b0),
        .key_break(key_break), .links(links), .swram_sel(swram_sel),
        .adc_ch0(12'h800), .adc_ch1(12'h800), .adc_fire_n(2'b11),
        .rgb(rgb), .hsync(hsync), .vsync(vsync),
        .hblank(hblank), .vblank(vblank), .pix_ce(pix_ce), .de(de),
        .snd(snd),
        .dbg_halted(), .dbg_addr(dbg_addr), .dbg_bus(dbg_bus), .dbg_wait(dbg_wait),
        .watchdog_reset(),
        .dbg_rom_sum(dbg_rom_sum), .dbg_rom_count(dbg_rom_count), .dbg_fdc(dbg_fdc),
        .trc_cen(trc_cen), .trc_addr(trc_addr), .trc_data(trc_data),
        .trc_rnw(trc_rnw), .trc_sync(trc_sync), .trc_irq(trc_irq), .trc_dbg(trc_dbg)
    );
endmodule

`default_nettype wire

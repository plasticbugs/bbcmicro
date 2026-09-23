// Bench wrapper for the whole machine with ideal memories: rtl/bbcmicro_core.sv
// and nothing of the Pocket but the download port, driven the way the APF's
// loader drives it.  sim/tb_boot.cpp pushes the ROM image in and captures
// frames.
//
// This is the FAST bench (METHODOLOGY section 5.16): the disc controller's
// SDRAM port is answered from an array here, with no arbitration, no refresh
// and no download contention.  Everything between the core's ports and the
// Pocket's pins is verified by sim/run_pocket.sh instead, which requires the
// picture to come out identical to this bench's through the real glue.
`default_nettype none

module tb_boot_top (
    input  logic        clk,
    input  logic        rst,
    input  logic        pause,

    // the ROM image, as the Pocket's loader sends it
    input  logic        dl_we,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,

    // keyboard events from the bench
    input  logic        kev_stb,
    input  logic        kev_press,
    input  logic  [3:0] kev_col,
    input  logic  [2:0] kev_row,
    input  logic        key_break,
    input  logic  [7:0] links,
    input  logic  [1:0] swram_sel,
    input  logic        disc_loaded,

    // what the bench watches
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
    output logic [15:0] trc_dbg
);
    // Ideal disc memory: one image, answered the clock after it is asked for.
    // The bench fills it directly -- the real path to it is SDRAM, and that is
    // sim/run_pocket.sh's job, not this bench's (METHODOLOGY section 5.16).
    logic [7:0] disc_mem [2097152] /* verilator public_flat_rw */;  // 2 x 1 MB
    logic       disc_req, disc_we, disc_drive;
    logic [19:0] disc_addr;
    logic  [7:0] disc_din;
    logic        disc_ack;
    logic  [7:0] disc_q;

    always_ff @(posedge clk) begin
        disc_ack <= 1'b0;
        if (disc_req && !disc_ack) begin
            if (disc_we) disc_mem[{disc_drive, disc_addr}] <= disc_din;
            else         disc_q <= disc_mem[{disc_drive, disc_addr}];
            disc_ack <= 1'b1;
        end
    end

    bbcmicro_core dut (
        .clk(clk), .rst(rst), .pause(pause), .pix_sync(1'b0),
        .dl_we(dl_we), .dl_addr(dl_addr), .dl_data(dl_data),
        .disc_req(disc_req), .disc_we(disc_we), .disc_drive(disc_drive),
        .disc_addr(disc_addr), .disc_din(disc_din),
        .disc_ack(disc_ack), .disc_q(disc_q),
        .disc_present({1'b0, disc_loaded}), .disc_dsided(2'b00),
        .kev_stb(kev_stb), .kev_press(kev_press),
        .kev_col(kev_col), .kev_row(kev_row), .kev_clear(1'b0),
        .key_break(key_break), .links(links), .swram_sel(swram_sel),
        .adc_ch0(12'h800), .adc_ch1(12'h800), .adc_fire_n(2'b11),
        .rgb(rgb), .hsync(hsync), .vsync(vsync),
        .hblank(hblank), .vblank(vblank), .pix_ce(pix_ce), .de(de),
        .snd(snd),
        .dbg_halted(), .dbg_addr(dbg_addr), .dbg_bus(dbg_bus), .dbg_wait(dbg_wait),
        .watchdog_reset(),
        .dbg_rom_sum(dbg_rom_sum), .dbg_rom_count(dbg_rom_count), .dbg_fdc(),
        .trc_cen(trc_cen), .trc_addr(trc_addr), .trc_data(trc_data),
        .trc_rnw(trc_rnw), .trc_sync(trc_sync), .trc_irq(trc_irq), .trc_dbg(trc_dbg)
    );
endmodule

`default_nettype wire

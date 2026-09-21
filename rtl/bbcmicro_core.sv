//------------------------------------------------------------------------------
// BBC Micro Model B -- the machine, platform-agnostic.
//
// Everything here is traceable to docs/hardware.md, which was written from
// MAME's driver (ref/mame/acorn/) before any of this existed.  The chips are
// vendored (modules/VENDOR.md); what is written here is the board they sit on:
// the address decode, the sideways ROM paging, the 1 MHz clock stretching, the
// addressable latch, the interrupt wiring, the video address translation and
// the keyboard.
//
// The port list is the contract with target/pocket/core_top.sv and the benches
// in sim/.  It is not the template's arcade shape any more: this machine has
// no tile ROMs and no sprite engine, its ROMs and RAM are block RAM filled by
// the loader, and the only thing outside the FPGA is the disc image.
//------------------------------------------------------------------------------
`default_nettype none

module bbcmicro_core (
    input  logic        clk,            // 96 MHz
    input  logic        rst,            // power-on, or the menu's reset
    input  logic        pause,          // the Pocket's menu is open
    input  logic        pix_sync,       // see clk_enables.sv

    // ---------------- the ROM image, data slot 0, straight into block RAM
    input  logic        dl_we,
    input  logic [24:0] dl_addr,
    input  logic  [7:0] dl_data,

    // ---------------- disc images in SDRAM, through bbcmicro_mem.sv
    output logic        disc_req,
    output logic        disc_we,
    output logic        disc_drive,     // which image
    output logic [19:0] disc_addr,      // byte within that drive's image
    output logic  [7:0] disc_din,
    input  logic        disc_ack,
    input  logic  [7:0] disc_q,
    input  logic  [1:0] disc_present,   // a drive with no image is not ready
    input  logic  [1:0] disc_dsided,    // and a double-sided image interleaves

    // ---------------- keyboard, as matrix positions (the on-screen keyboard
    // and core_top's key map both know the matrix; docs/hardware.md 3.1)
    input  logic        kev_stb,
    input  logic        kev_press,
    input  logic  [3:0] kev_col,
    input  logic  [2:0] kev_row,
    input  logic        kev_clear,
    input  logic        key_break,      // BREAK is not in the matrix
    input  logic  [7:0] links,          // the startup links, bit 0 = column 2

    // ---------------- analogue port
    input  logic [11:0] adc_ch0, adc_ch1,
    input  logic  [1:0] adc_fire_n,

    // ---------------- video, one pixel per pix_ce in the clk domain
    output logic [23:0] rgb,
    output logic        hsync, vsync, hblank, vblank,
    output logic        pix_ce, de,

    output logic signed [15:0] snd,

    // ---------------- bring-up (the panel in core_top)
    output logic        dbg_halted,
    output logic [23:1] dbg_addr,
    output logic        dbg_bus, dbg_wait,
    output logic        watchdog_reset,
    output logic [15:0] dbg_rom_sum,
    output logic [24:0] dbg_rom_count,
    output logic  [7:0] dbg_fdc,

    // ---------------- the CPU's bus, one pulse per cycle, for the trace
    // bench that holds this 6502 to MAME's (METHODOLOGY section 4)
    output logic        trc_cen,
    output logic [15:0] trc_addr,
    output logic  [7:0] trc_data,
    output logic        trc_rnw,
    output logic        trc_sync,
    output logic  [3:0] trc_irq,    // {sysvia, uservia, fdc_irq, fdc_drq}
    output logic [15:0] trc_dbg     // {ic32, system VIA port A}
);
    // =====================================================================
    // Clocks.  clk_enables gives the two dot clocks and the position inside
    // each 16 MHz cycle; the video ULA owns the 16-count cycle counter that
    // everything slower is timed from (docs/core-design.md section 1).
    // =====================================================================
    logic       cen_16m, cen_12m;
    logic [2:0] phase;
    clk_enables u_cen (
        .clk(clk), .rst(rst), .pix_sync(pix_sync),
        .cen_16m(cen_16m), .cen_12m(cen_12m), .phase(phase)
    );
    assign pix_ce = cen_16m;

    logic [3:0] clken_count;            // from the video ULA
    logic       clken_crtc;

    // Positions inside the 16 MHz cycle, in the same places the real machine
    // puts them: the CRTC fetches in cycle 0 (and 8 at 2 MHz), the CPU runs
    // half a cycle later, in 4 and 12.
    wire cen_4m_pos = (phase == 3'd2) && (clken_count[1:0] == 2'd3);
    wire cen_1m_pos = (phase == 3'd2) && (clken_count      == 4'd3);
    wire cpu_pos    = (phase == 3'd4) && (clken_count[2:0] == 3'd3);
    wire stretch_pos= (phase == 3'd2) && (clken_count[2:0] == 3'd3);

    // Pausing masks everything that moves the machine on, and leaves the
    // video running so the picture stays up behind the Pocket's menu
    // (METHODOLOGY section 5.5).  Nothing is skipped or doubled: the enables
    // are the same pulses, gated.
    wire run     = !pause;
    wire cen_4m  = run && cen_4m_pos;
    wire cen_1m  = run && cen_1m_pos;

    // 1 MHz cycle stretching (docs/hardware.md section 9).  An access to a
    // 1 MHz device is held until it can complete inside a whole 1 MHz cycle,
    // which is what makes the CPU and the video circuit share the RAM without
    // ever colliding, and what makes cycle-counted software run at the right
    // speed.
    logic [1:0] cycle_mask;
    wire        cpu_cen = run && cpu_pos && (cycle_mask == 2'd0);
    logic       mhz1_access;            // the address decodes to a slow device

    always_ff @(posedge clk) begin
        if (rst) begin
            cycle_mask <= 2'd0;
        end else if (run && stretch_pos) begin
            if (mhz1_access && cycle_mask == 2'd0)
                cycle_mask <= clken_count[3] ? 2'd1 : 2'd2;
            else if (cycle_mask != 2'd0)
                cycle_mask <= cycle_mask - 2'd1;
        end
    end

    // =====================================================================
    // Reset.  BREAK pulls the CPU's reset line and resets the peripherals a
    // real BREAK resets -- not the system VIA, the CRTC or the video ULA,
    // which is why the screen mode survives it (docs/hardware.md 3.2).
    // =====================================================================
    logic [7:0] rst_cnt;
    // The vendored chips take an asynchronous reset and this core reads the
    // same signal synchronously, which is what a reset distribution looks
    // like; it is one net either way, released by a synchronous counter.
    /* verilator lint_off SYNCASYNCNET */
    logic       hard_rst;               // power-on and the menu's reset
    /* verilator lint_on SYNCASYNCNET */
    always_ff @(posedge clk) begin
        if (rst) begin
            rst_cnt  <= 8'd0;
            hard_rst <= 1'b1;
        end else if (cpu_cen) begin
            if (rst_cnt == 8'd255) hard_rst <= 1'b0;
            else rst_cnt <= rst_cnt + 8'd1;
        end
    end
    wire hard_reset_n = !hard_rst;
    wire cpu_reset_n  = hard_reset_n && !key_break;

    // =====================================================================
    // CPU
    // =====================================================================
    wire [23:0] cpu_a24;
    wire  [7:0] cpu_do;
    wire        cpu_rnw, cpu_sync;
    logic [7:0] cpu_di;
    wire        cpu_irq_n, cpu_nmi_n;
    wire [15:0] cpu_a = cpu_a24[15:0];

    T65 u_cpu (
        .Mode(2'b00),                   // 6502
        .Res_n(cpu_reset_n),
        .Enable(cpu_cen),
        .Clk(clk),
        .Rdy(1'b1),
        .Abort_n(1'b1),
        .IRQ_n(cpu_irq_n),
        .NMI_n(cpu_nmi_n),
        .SO_n(1'b1),
        .R_W_n(cpu_rnw),
        .Sync(cpu_sync),
        .A(cpu_a24),
        .DI(cpu_di),
        .DO(cpu_do),
        // the 65816 and debug outputs this machine has no use for, named so
        // that a pin appearing or vanishing upstream is a lint error and not
        // a silent change
        .EF(), .MF(), .XF(), .ML_n(), .VP_n(), .VDA(), .VPA(),
        .Regs(), .NMI_ack(),
        .\DEBUG[I] (), .\DEBUG[A] (), .\DEBUG[X] (), .\DEBUG[Y] (),
        .\DEBUG[S] (), .\DEBUG[P] ()
    );

    // =====================================================================
    // Address decode (docs/hardware.md section 2)
    // =====================================================================
    wire ram_sel   = !cpu_a[15];
    wire paged_sel = cpu_a[15] && !cpu_a[14];
    wire io_fred   = (cpu_a[15:8] == 8'hFC);
    wire io_jim    = (cpu_a[15:8] == 8'hFD);
    wire io_sheila = (cpu_a[15:8] == 8'hFE);
    wire mos_sel   = cpu_a[15] && cpu_a[14] && !(io_fred || io_jim || io_sheila);

    // SHEILA, by the top three bits of the low byte
    wire crtc_sel    = io_sheila && (cpu_a[7:5] == 3'b000) && !cpu_a[4] && !cpu_a[3];
    wire acia_sel    = io_sheila && (cpu_a[7:5] == 3'b000) && !cpu_a[4] &&  cpu_a[3];
    wire serula_sel  = io_sheila && (cpu_a[7:5] == 3'b000) &&  cpu_a[4] && !cpu_a[3];
    wire statid_sel  = io_sheila && (cpu_a[7:5] == 3'b000) &&  cpu_a[4] &&  cpu_a[3];
    wire vidproc_sel = io_sheila && (cpu_a[7:5] == 3'b001) && !cpu_a[4];
    wire romsel_sel  = io_sheila && (cpu_a[7:5] == 3'b001) &&  cpu_a[4];
    wire sysvia_sel  = io_sheila && (cpu_a[7:5] == 3'b010);
    wire uservia_sel = io_sheila && (cpu_a[7:5] == 3'b011);
    wire fdc_sel     = io_sheila && (cpu_a[7:5] == 3'b100);
    wire adlc_sel    = io_sheila && (cpu_a[7:5] == 3'b101);
    wire adc_sel     = io_sheila && (cpu_a[7:5] == 3'b110);
    wire tube_sel    = io_sheila && (cpu_a[7:5] == 3'b111);

    // Which of those live on the 1 MHz bus and therefore stretch the CPU
    always_comb mhz1_access = io_fred || io_jim || crtc_sel || acia_sel ||
                              serula_sel || sysvia_sel || uservia_sel ||
                              fdc_sel || adlc_sel || adc_sel;

    // the paged ROM latch: a Model B decodes two bits of it
    logic [1:0] romsel;
    always_ff @(posedge clk) begin
        if (!hard_reset_n) romsel <= 2'd0;
        else if (cpu_cen && romsel_sel && !cpu_rnw) romsel <= cpu_do[1:0];
    end

    // =====================================================================
    // Memory
    // =====================================================================
    wire  [7:0] paged_q, mos_q, font_q;
    wire  [9:0] font_addr;
    bbc_rom u_rom (
        .clk(clk),
        .dl_we(dl_we), .dl_addr(dl_addr), .dl_data(dl_data),
        .paged_addr({romsel, cpu_a[13:0]}), .paged_q(paged_q),
        .mos_addr(cpu_a[13:0]), .mos_q(mos_q),
        .font_addr(font_addr), .font_q(font_q),
        .dl_sum(dbg_rom_sum), .dl_count(dbg_rom_count)
    );

    // 32K of main RAM, dual port: the CPU on one side, the video circuit on
    // the other, as the two halves of the 2 MHz cycle are on the real board.
    logic [7:0] ram [32768];
    logic [7:0] ram_q, vid_q;
    logic [14:0] display_a;

    always_ff @(posedge clk) begin
        if (cpu_cen && ram_sel && !cpu_rnw) ram[cpu_a[14:0]] <= cpu_do;
        ram_q <= ram[cpu_a[14:0]];
        vid_q <= ram[display_a];
    end

    // =====================================================================
    // The addressable latch (74LS259), written through system VIA port B
    // =====================================================================
    logic [7:0] ic32;
    wire  [7:0] sysvia_pb_out;
    always_ff @(posedge clk) begin
        if (!hard_reset_n) ic32 <= 8'd0;
        else if (cen_1m) ic32[sysvia_pb_out[2:0]] <= sysvia_pb_out[3];
    end
    wire       sound_we_n = ic32[0];
    wire       kb_en      = ic32[3];
    wire [1:0] disp_offs  = {ic32[5], ic32[4]};

    // =====================================================================
    // Video
    // =====================================================================
    wire        crtc_de, crtc_hs, crtc_vs, crtc_cursor;
    wire [13:0] crtc_ma;
    wire  [4:0] crtc_ra;
    wire  [7:0] crtc_do;

    mc6845 u_crtc (
        .CLOCK(clk), .CLKEN(clken_crtc), .CLKEN_CPU(cpu_cen),
        .nRESET(hard_reset_n),
        .ENABLE(crtc_sel), .R_nW(cpu_rnw), .RS(cpu_a[0]),
        .DI(cpu_do), .DO(crtc_do),
        .VSYNC(crtc_vs), .HSYNC(crtc_hs), .DE(crtc_de), .CURSOR(crtc_cursor),
        .LPSTB(1'b0), .VGA(1'b0),
        .MA(crtc_ma), .RA(crtc_ra), .test()
    );
    // The screen wrap: MA12 with the addressable latch's C0/C1 chooses how far
    // the address is bumped so that the screen wraps at 0x8000 -- MAME builds
    // it out of four NAND gates and a 4-bit adder (bbc_v.cpp), which comes to
    // the same four offsets.  docs/hardware.md 5.4.
    logic [3:0] aa;
    always_comb begin
        if (!crtc_ma[12]) aa = crtc_ma[11:8];
        else case (disp_offs)                       // {C1, C0}
            2'b00:   aa = crtc_ma[11:8] + 4'd8;     // modes 3:   restart 0x4000
            2'b01:   aa = crtc_ma[11:8] + 4'd12;    // mode 6:    restart 0x6000
            2'b10:   aa = crtc_ma[11:8] + 4'd6;     // modes 0-2: restart 0x3000
            default: aa = crtc_ma[11:8] + 4'd11;    // modes 4,5: restart 0x5800
        endcase
    end
    always_comb begin
        if (!crtc_ma[13]) display_a = {aa, crtc_ma[7:0], crtc_ra[2:0]};
        else              display_a = {aa[3], 4'b1111, crtc_ma[9:0]};
    end

    wire ula_r, ula_g, ula_b, ttxt_sel;
    wire ttxt_r, ttxt_g, ttxt_b;
    // DISEN is masked by RA3, which is how modes 3 and 6 get their blank rows
    wire vidproc_disen = crtc_de && !crtc_ra[3];

    vidproc_orig u_ula (
        .CLOCK(clk), .CPUCLKEN(cpu_cen), .CLKEN(cen_16m), .nRESET(hard_reset_n),
        .CLKEN_CRTC(clken_crtc), .CLKEN_COUNT(clken_count), .TTXT(ttxt_sel),
        .VGA(1'b0),
        .ENABLE(vidproc_sel && !cpu_rnw), .A0(cpu_a[0]),
        .DI_CPU(cpu_do), .DI_RAM(vid_q),
        .nINVERT(1'b1), .DISEN(vidproc_disen), .CURSOR(crtc_cursor),
        .R_IN(ttxt_r), .G_IN(ttxt_g), .B_IN(ttxt_b),
        .R(ula_r), .G(ula_g), .B(ula_b)
    );

    // IC15, the LS273 latch that sits between the RAM and the SAA5050 on the
    // real board.  It takes the character byte and DE together, once per
    // character time at the CRTC's fetch point, and is cleared whenever MA13
    // says the CRTC is not addressing the teletext area -- and the SAA5050
    // samples it half a character later, which is what lines its output up
    // with the video ULA's cursor.  Without it the teletext output sat two
    // characters late: the first character of every row was pushed past the
    // end of the previous line and showed up at the right-hand edge.
    logic [6:0] ttxt_data;
    logic       ttxt_lose;
    wire        ic15_clken    = cen_16m && (clken_count == 4'd0);
    wire        ttxt_di_clken = cen_16m && (clken_count == 4'd8);
    always_ff @(posedge clk) begin
        if (!crtc_ma[13]) begin
            ttxt_data <= 7'd0;
            ttxt_lose <= 1'b0;
        end else if (ic15_clken) begin
            ttxt_data <= vid_q[6:0];
            ttxt_lose <= crtc_de;
        end
    end

    wire [11:0] rom_a1, rom_a2;
    wire  [7:0] rom_d1, rom_d2;
    saa5050 u_ttxt (
        .CLOCK(clk), .CLKEN(cen_12m), .nRESET(hard_reset_n), .VGA(1'b0),
        .DI_CLOCK(clk), .DI_CLKEN(ttxt_di_clken), .DI(ttxt_data),
        .GLR(!crtc_hs), .DEW(crtc_vs), .CRS(!crtc_ra[0]), .LOSE(ttxt_lose),
        .ROM_A1(rom_a1), .ROM_D1(rom_d1), .ROM_A2(rom_a2), .ROM_D2(rom_d2),
        .R(ttxt_r), .G(ttxt_g), .B(ttxt_b), .Y()
    );

    bbc_charrom u_charrom (
        .clk(clk), .font_addr(font_addr), .font_q(font_q),
        .a1(rom_a1), .d1(rom_d1), .a2(rom_a2), .d2(rom_d2)
    );

    // =====================================================================
    // Video out: the CRTC's sync, and a fixed window inside it
    // (docs/core-design.md section 6).  The core's raster IS the machine's,
    // so a game that reprograms the CRTC moves the picture exactly as it
    // would on a monitor.
    // =====================================================================
    // Where the picture lands is not the same in teletext as in the bitmap
    // modes, and the machine is responsible for most of the difference.  The
    // OS puts hsync at character 51 of 64 in MODE 7 (1 MHz characters) and at
    // 98 of 128 in MODE 0-6 (2 MHz), so the CRTC's display starts 208 dots
    // after the hsync edge in one and 240 in the other: the machine itself
    // sets MODE 7 two microseconds left of a bitmap mode, which is why
    // teletext sits left of the other modes on a real monitor.
    //
    // The rest is this core's own pipelines, measured -- the bitmap path from
    // where the MODE 1 cursor block lands (a block fills its whole cell, so
    // it is a better ruler than a glyph), the teletext path from the
    // alignment that makes the Exile title page agree with MAME:
    //
    //     MODE 0-6   CRTC 240   picture 248   8 dots, one ULA character
    //     MODE 7     CRTC 208   picture 275   67 dots, about four characters
    //
    // (Those are the bench's raster coordinates, which lag hcnt by the one
    // clock the sync output is registered for, so the starts below are one
    // less.  Checked by the score: with the window a dot late the Exile title
    // page agreed with MAME on 80.00% of its lit pixels, which is exactly
    // what the raw capture scored one dot off the peak; on the peak it is
    // 89.19%.)
    //
    // Both pictures are exactly 640 dots wide and they are 27 dots apart, so
    // one fixed window cannot hold both: with the window where MODE 7's CRTC
    // asks for it, four characters of every teletext line fell off the right
    // -- which is what the picture looked like.  The window follows the
    // ULA's own teletext bit, sampled at the hsync edge so it cannot move
    // inside a line.
    localparam int H_START_BITMAP = 247;
    localparam int H_START_TTXT   = 274;
    localparam int H_WIDTH = 640;
    localparam int V_START = 24;        // lines after the vsync edge
    localparam int V_HEIGHT = 256;

    logic [10:0] hcnt, h_start;
    logic  [9:0] vcnt;
    logic        hs_d, vs_d;
    wire         hs_rise = crtc_hs && !hs_d;
    wire         vs_rise = crtc_vs && !vs_d;

    always_ff @(posedge clk) begin
        if (cen_16m) begin
            hs_d <= crtc_hs;
            vs_d <= crtc_vs;
            hcnt <= hs_rise ? 11'd0 : (hcnt + 11'd1);
            if (hs_rise)
                h_start <= ttxt_sel ? 11'(H_START_TTXT) : 11'(H_START_BITMAP);
            if (vs_rise)      vcnt <= 10'd0;
            else if (hs_rise) vcnt <= vcnt + 10'd1;
        end
    end

    wire in_h = (hcnt >= h_start) && (hcnt < h_start + 11'(H_WIDTH));
    wire in_v = (vcnt >= 10'(V_START)) && (vcnt < 10'(V_START + V_HEIGHT));

    // The colour is whatever the ULA is producing, in the window or out of it:
    // outside the CRTC's display area the ULA blanks it anyway, and a bench
    // that captures the whole raster then sees the border as the monitor
    // would.  `de` is what marks the part the Pocket scales.
    always_ff @(posedge clk) begin
        if (cen_16m) begin
            rgb    <= {{8{ula_r}}, {8{ula_g}}, {8{ula_b}}};
            de     <= in_h && in_v;
            hblank <= !in_h;
            vblank <= !in_v;
            hsync  <= crtc_hs;
            vsync  <= crtc_vs;
        end
    end

    // =====================================================================
    // System VIA: keyboard, sound, screen wrap, the LEDs
    // =====================================================================
    wire [7:0] sysvia_do, sysvia_pa_out, sysvia_pa_oe_n;
    wire       sysvia_irq_n, sysvia_do_oe_n;
    wire       kb_pa7, kb_ca2;

    bbc_keyboard u_kbd (
        .clk(clk), .rst(!hard_reset_n), .cen_1m(cen_1m),
        .kev_stb(kev_stb), .kev_press(kev_press),
        .kev_col(kev_col), .kev_row(kev_row), .kev_clear(kev_clear),
        .links(links),
        .kb_en(kb_en), .pa(sysvia_pa_out[6:0]),
        .pa7(kb_pa7), .ca2(kb_ca2)
    );

    // Port A is the slow data bus: the VIA drives PA6-0, the keyboard answers
    // on PA7, and the same eight lines are the sound chip's data bus.
    wire [7:0] sysvia_pa_in = {kb_pa7, sysvia_pa_out[6:0]};
    // PB4 and PB5 are the joystick fire buttons, active low; PB6 and PB7 are
    // the speech chip, which is not fitted and reads high.
    wire [7:0] sysvia_pb_in = {2'b11, adc_fire_n, sysvia_pb_out[3:0]};

    wire adc_eoc_n;
    M6522 u_sysvia (
        .I_RS(cpu_a[3:0]), .I_DATA(cpu_do), .O_DATA(sysvia_do),
        .O_DATA_OE_L(sysvia_do_oe_n),
        .I_RW_L(cpu_rnw), .I_CS1(sysvia_sel), .I_CS2_L(1'b0),
        .O_IRQ_L(sysvia_irq_n),
        .I_CA1(crtc_vs), .I_CA2(kb_ca2), .O_CA2(), .O_CA2_OE_L(),
        .I_PA(sysvia_pa_in), .O_PA(sysvia_pa_out), .O_PA_OE_L(sysvia_pa_oe_n),
        .I_CB1(adc_eoc_n), .O_CB1(), .O_CB1_OE_L(),
        .I_CB2(1'b1), .O_CB2(), .O_CB2_OE_L(),
        .I_PB(sysvia_pb_in), .O_PB(sysvia_pb_out), .O_PB_OE_L(),
        .I_P2_H(cen_1m), .RESET_L(hard_reset_n), .ENA_4(cen_4m), .CLK(clk)
    );

    // =====================================================================
    // User VIA: nothing is connected to it, but software reads its timers
    // =====================================================================
    wire [7:0] uservia_do;
    wire       uservia_irq_n, uservia_do_oe_n;
    M6522 u_uservia (
        .I_RS(cpu_a[3:0]), .I_DATA(cpu_do), .O_DATA(uservia_do),
        .O_DATA_OE_L(uservia_do_oe_n),
        .I_RW_L(cpu_rnw), .I_CS1(uservia_sel), .I_CS2_L(1'b0),
        .O_IRQ_L(uservia_irq_n),
        .I_CA1(1'b1), .I_CA2(1'b1), .O_CA2(), .O_CA2_OE_L(),
        .I_PA(8'hFF), .O_PA(), .O_PA_OE_L(),
        .I_CB1(1'b1), .O_CB1(), .O_CB1_OE_L(),
        .I_CB2(1'b1), .O_CB2(), .O_CB2_OE_L(),
        .I_PB(8'hFF), .O_PB(), .O_PB_OE_L(),
        .I_P2_H(cen_1m), .RESET_L(cpu_reset_n), .ENA_4(cen_4m), .CLK(clk)
    );

    // The 6522's data output is only valid while its phase-2 input is high --
    // one system clock, here -- and the CPU samples its bus two clocks later,
    // so both VIAs' reads have to be latched while they are good.  Without
    // this every VIA read returned zero: the writes all worked, so the sound
    // and the screen wrap looked right, but the OS read the interrupt flag
    // register as "no interrupt", never cleared the interrupt that had
    // actually happened, and the machine spent its life in an interrupt
    // storm, one instruction at a time, with the keyboard dead.
    logic [7:0] sysvia_do_r, uservia_do_r;
    always_ff @(posedge clk) begin
        if (cen_1m) begin
            sysvia_do_r  <= sysvia_do;
            uservia_do_r <= uservia_do;
        end
    end

    // =====================================================================
    // Sound: one SN76489A on the system VIA's port A, strobed by latch Q0
    // =====================================================================
    wire [15:0] sn_out;
    sn76489 u_sn (
        .clk(clk), .clk_en(cen_4m), .reset(!hard_reset_n),
        .d(sysvia_pa_out), .we_n(sound_we_n), .ce_n(1'b0),
        .audio_out(sn_out)
    );
    // The chip's output is unsigned and silent at zero -- all four channels
    // attenuated is 0, not mid-scale -- and the board couples it to the
    // amplifier through a capacitor.  Subtracting mid-scale instead put
    // silence at -16384, half of full scale of DC, and started every sound
    // with a step that size: measured, a SOUND 1,-15,100,50 typed into BASIC
    // came out switching between -16384 and -8193 where MAME's swung about
    // its own zero.  A one-pole DC blocker does what the capacitor does:
    //
    //     y[n] = x[n] - x[n-1] + (1 - 2^-13) * y[n-1]
    //
    // run on the 1 MHz enable, which puts the corner at 1e6/(2*pi*8192) =
    // 19 Hz -- below the lowest note the SN76489 can make at this clock
    // (4 MHz / 32 / 1023 = 122 Hz) and far below anything a game plays.
    // The accumulator carries 8 fractional bits.  Without them `y >>> 13` is
    // zero for every |y| below 8192 -- larger than this signal ever gets --
    // so the leak never fires, the filter degenerates into an integrator of
    // the input's differences, and it passes the DC through untouched.  That
    // is what the first version measured: silence at 0, but the beep still
    // sitting entirely above it at 0..8191.
    // The sample is registered before the filter sees it.  Without that the
    // path ran from inside the SN76489's own output logic through the
    // filter's adders in one clock and was the longest in the design
    // (-0.637 ns at 96 MHz, sn76489|n206[20] -> dcb_y[22]).  26 bits is
    // enough for the widest excursion: 15 bits of sample, 8 of fraction and
    // two of headroom.
    localparam int DCB_SHIFT = 13;
    localparam int DCB_FRAC  = 8;
    wire signed [15:0] sn_sample = $signed({1'b0, sn_out[15:1]});
    logic signed [15:0] sn_reg, dcb_x_d;
    logic signed [25:0] dcb_y;
    wire  signed [25:0] dcb_out = dcb_y >>> DCB_FRAC;
    always_ff @(posedge clk) begin
        if (!hard_reset_n) begin
            sn_reg  <= 16'sd0;
            dcb_x_d <= 16'sd0;
            dcb_y   <= 26'sd0;
        end else if (cen_1m) begin
            sn_reg  <= sn_sample;
            dcb_x_d <= sn_reg;
            dcb_y   <= dcb_y - (dcb_y >>> DCB_SHIFT)
                       + ((26'(sn_reg) - 26'(dcb_x_d)) <<< DCB_FRAC);
        end
    end
    // the blocker's output cannot exceed the input's range, but it is clamped
    // rather than wrapped: a wrap would be an audible crack, a clamp is not
    assign snd = (dcb_out >  26'sd32767) ?  16'sd32767 :
                 (dcb_out < -26'sd32768) ? -16'sd32768 : 16'(dcb_out);

    // =====================================================================
    // Analogue port
    // =====================================================================
    wire [7:0] adc_do;
    upd7002 u_adc (
        .clk(clk), .cpu_clken(cpu_cen), .mhz1_clken(cen_1m),
        .reset_n(hard_reset_n),
        .cs(adc_sel), .r_nw(cpu_rnw), .addr(cpu_a[1:0]), .di(cpu_do),
        .\do (adc_do), .eoc_n(adc_eoc_n),
        .ch0(adc_ch0), .ch1(adc_ch1), .ch2(12'd0), .ch3(12'd0)
    );

    // =====================================================================
    // 6850 ACIA -- not implemented (no cassette, no RS423), but it cannot be
    // left to read as an unmapped SHEILA address.  The OS's interrupt handler
    // checks bit 7 of the ACIA's status register FIRST, and an unmapped read
    // gives 0xFE, which has bit 7 set: every interrupt was therefore serviced
    // as a serial interrupt, the system VIA that had actually interrupted was
    // never reached or cleared, and the machine sat in an interrupt storm
    // from the moment the OS enabled interrupts.  It printed its banner and
    // BASIC's name and then executed one instruction over and over.
    //
    // An idle 6850 reads 0x02: transmit register empty, nothing received, no
    // interrupt.  docs/hardware.md section 8 lists what this leaves out.
    wire [7:0] acia_do = cpu_a[0] ? 8'h00 : 8'h02;

    // =====================================================================
    // Disc controller.  BREAK resets it, as it does on the board.
    // =====================================================================
    wire [7:0] fdc_do;
    wire       fdc_irq, fdc_drq;
    i8271 u_fdc (
        .clk(clk), .rst(!cpu_reset_n), .cen_1us(cen_1m),
        .acc(fdc_sel && cpu_cen), .rnw(cpu_rnw), .addr(cpu_a[2:0]),
        .din(cpu_do), .dout(fdc_do), .irq(fdc_irq), .drq(fdc_drq),
        .img_req(disc_req), .img_we(disc_we), .img_drive(disc_drive),
        .img_addr(disc_addr), .img_wdata(disc_din),
        .img_ack(disc_ack), .img_rdata(disc_q),
        .img_present(disc_present), .img_dsided(disc_dsided),
        .dbg(dbg_fdc)
    );

    // =====================================================================
    // Interrupts (docs/hardware.md section 4)
    // =====================================================================
    assign cpu_irq_n = sysvia_irq_n && uservia_irq_n;
    assign cpu_nmi_n = !(fdc_irq || fdc_drq);

    // =====================================================================
    // What the CPU reads
    // =====================================================================
    always_comb begin
        if (ram_sel)          cpu_di = ram_q;
        else if (paged_sel)   cpu_di = paged_q;
        else if (mos_sel)     cpu_di = mos_q;
        else if (io_fred)     cpu_di = 8'hFF;   // nothing on the 1 MHz bus
        else if (io_jim)      cpu_di = 8'hFF;
        else if (crtc_sel)    cpu_di = crtc_do;
        else if (acia_sel)    cpu_di = acia_do;
        else if (sysvia_sel)  cpu_di = sysvia_do_r;
        else if (uservia_sel) cpu_di = uservia_do_r;
        else if (adc_sel)     cpu_di = adc_do;
        else if (fdc_sel)     cpu_di = fdc_do;
        else                  cpu_di = 8'hFE;   // unmapped SHEILA
    end

    // =====================================================================
    // Bring-up
    // =====================================================================
    // The bus as the CPU leaves it at the end of each cycle: at the enable
    // edge the address, R/W and write data are still this cycle's, and the
    // read data is what the CPU is about to take.
    assign trc_cen  = cpu_cen;
    assign trc_addr = cpu_a;
    assign trc_data = cpu_rnw ? cpu_di : cpu_do;
    assign trc_rnw  = cpu_rnw;
    assign trc_sync = cpu_sync;
    assign trc_irq  = {~sysvia_irq_n, ~uservia_irq_n, fdc_irq, fdc_drq};
    assign trc_dbg  = {ic32, sysvia_pa_out};

    assign dbg_halted     = 1'b0;
    assign dbg_addr       = {8'd0, cpu_a[15:1]};
    assign dbg_bus        = cpu_sync;
    assign dbg_wait       = (cycle_mask != 2'd0);
    assign watchdog_reset = 1'b0;

    wire _unused = &{1'b0, cpu_a24[23:16],
                     statid_sel, adlc_sel, tube_sel, serula_sel, acia_sel,
                     ttxt_sel, sysvia_do_oe_n, uservia_do_oe_n, sysvia_pa_oe_n,
                     crtc_ra[4], 1'b0};
endmodule

`default_nettype wire

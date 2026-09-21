//------------------------------------------------------------------------------
// The on-screen keyboard: the BBC's own keyboard drawn over the picture, with
// the pad pressing keys on it.
//
// The Pocket has no keys, and a BBC game or BASIC needs them, so this draws
// the machine's keyboard (tools/make_osk_panel.py renders the panel and the
// map of which cell presses which matrix position) and sends the same key
// events the pad's own mapping sends.
//
//   L + R + Select   show the keyboard, and dismiss it
//   d-pad            move the highlight; it wraps, and holding repeats
//   A or B           press the highlighted key
//   SHIFT, CTRL, CAPS LOCK and SHIFT LOCK latch, so the combinations that
//                    need them can be typed one key at a time
//   BREAK            is not a key in the matrix: it is a reset line, and it
//                    is reported separately
//
// Position is counted from the core's own de and vsync, the way
// rtl/dbg_overlay.sv does, so this module needs nothing from the video
// timing but those two signals.
//------------------------------------------------------------------------------
`default_nettype none

module bbc_osk #(
    // Panel geometry: 16 x 6 cells of 16 x 12, drawn at twice its width and
    // its own height.  The window is 640 x 256 shown as 4:3, so an output
    // pixel is about half as wide as it is tall; at 2x both ways the keys
    // came out tall and narrow and the panel filled more than half the
    // picture's height.  512 x 72 is 80% of the width and 28% of the height,
    // which is where the MSX core's panel sits, and its keys read as keys.
    parameter int X0 = 64,              // where the panel starts in the window
    parameter int Y0 = 172
) (
    input  logic        clk,
    input  logic        cen_pix,
    input  logic        de, vsync,

    // the pad
    input  logic        chord,          // L + R + Select
    input  logic        up, down, left, right,
    input  logic        press,          // A or B

    // to the machine
    output logic        visible,        // the pad belongs to the keyboard
    output logic        kev_stb,
    output logic        kev_press,
    output logic  [3:0] kev_col,
    output logic  [2:0] kev_row,
    output logic        key_break,

    // over the picture
    output logic        active,         // this pixel is the panel's
    output logic        pix,            // and it is lit
    output logic        hi              // ... and its key is latched down
);
    localparam int CELLS_X = 16, CELLS_Y = 6;
    localparam int CELL_W = 16, CELL_H = 12;
    localparam int PW = CELLS_X * CELL_W;       // 256
    localparam int PH = CELLS_Y * CELL_H;       // 72
    // The generator's layout (tools/make_osk_panel.py): two bitmap pages,
    // unshifted then shifted, then one byte a cell of matrix position and one
    // of {start column, span}.
    localparam logic [12:0] PAGE_SHIFT = 13'h0900;
    localparam logic [12:0] MAP_BASE   = 13'h1200;
    localparam logic [12:0] SPAN_BASE  = 13'h1260;
    localparam logic [6:0] NO_KEY = 7'h7E, BREAK_KEY = 7'h7F;

    // ------------------------------------------------------------- the ROM
    // The panel bitmap and, at MAP_BASE, one byte per grid cell saying which
    // matrix position it presses.  Read twice per clock pair: the pixel
    // stream on one, the highlighted cell's code on the other, so one block
    // RAM serves both.
    // The panel is loaded two ways from the same generator output, because
    // Quartus and Verilator resolve paths from different places: Quartus
    // takes the .mif through the RAM's init attribute, found on the project's
    // search path (rtl/ is on it, so "rom/..." resolves), and the benches
    // read the .hex with $readmemh relative to the repository root, which is
    // where sim/run_osk.sh runs them from.  tools/make_osk_panel.py writes
    // both from one render, so they cannot drift apart.
    (* ram_init_file = "rom/osk_panel.mif" *) logic [7:0] rom [4800];
// ALTERA_RESERVED_QIS is defined while Quartus is synthesising, and is the
// documented way to keep simulation-only code out of the build.
`ifndef ALTERA_RESERVED_QIS
    initial $readmemh("rtl/rom/osk_panel.hex", rom);
`endif
    logic [12:0] rom_a;
    logic  [7:0] rom_q;
    always_ff @(posedge clk) rom_q <= rom[rom_a];

    // ---------------------------------------------------------- where we are
    logic [9:0] x;
    logic [8:0] y;
    logic       de_d, vs_d;
    wire        frame = vsync && !vs_d;

    always_ff @(posedge clk) begin
        if (cen_pix) begin
            de_d <= de; vs_d <= vsync;
            if (frame) y <= 9'd0;
            else if (!de && de_d) y <= y + 9'd1;
            if (de && !de_d) x <= 10'd0;
            else if (de) x <= x + 10'd1;
        end
    end

    // ------------------------------------------------------------- the chord
    logic chord_d;
    always_ff @(posedge clk) begin
        chord_d <= chord;
        if (chord && !chord_d) visible <= ~visible;
    end

    // ------------------------------------------------------ the highlight
    // cx is wherever the d-pad left the cursor; cur_start and cur_span are
    // the extent of the KEY that cell belongs to, read from the ROM once a
    // frame.  Moving left or right steps to the far side of the key rather
    // than to the next cell, so SPACE is one press away and not ten, and the
    // highlight covers the key rather than a tenth of it.
    logic [3:0] cx;
    logic [2:0] cy;
    logic [3:0] cur_start, cur_span;
    logic [4:0] rpt;                    // auto-repeat, in frames
    logic       moved;

    always_ff @(posedge clk) begin
        if (!visible) begin
            cx <= 4'd6; cy <= 3'd5;     // SPACE, a sensible place to open on
            rpt <= 5'd0;
        end else if (frame && cen_pix) begin
            moved <= 1'b0;
            if (!(up || down || left || right)) begin
                rpt <= 5'd0;
            end else if (rpt == 5'd0) begin
                rpt <= 5'd14;           // first repeat after ~280 ms
                moved <= 1'b1;
                if (up)    cy <= (cy == 3'd0) ? 3'(CELLS_Y - 1) : cy - 3'd1;
                if (down)  cy <= (cy == 3'(CELLS_Y - 1)) ? 3'd0 : cy + 3'd1;
                if (left)  cx <= (cur_start == 4'd0) ? 4'(CELLS_X - 1)
                                                     : cur_start - 4'd1;
                if (right) cx <= ({1'b0, cur_start} + {1'b0, cur_span}
                                  >= 5'(CELLS_X)) ? 4'd0
                                                  : cur_start + cur_span;
            end else begin
                rpt <= rpt - 5'd1;
                if (rpt == 5'd1) rpt <= 5'd3;   // then every ~60 ms
            end
        end
    end

    // -------------------------------------------------------- the key press
    // The code under the highlight is fetched once a frame, on the line above
    // the panel, when the pixel stream is not using the ROM -- so the ROM has
    // one address driver and no arbitration.
    logic [6:0] cur_key;
    logic [3:0] map_seq;                // four stages: address, address, take, take
    wire        map_time = cen_pix && de && !de_d && (y == 9'(Y0 - 1));

    // Latching keys: the modifiers, so that combinations can be typed one key
    // at a time.  Everything else is a keystroke: pressed, then released a
    // few frames later.
    function automatic logic is_latching(input logic [6:0] k);
        is_latching = (k == {4'd0, 3'd0})      // SHIFT
                   || (k == {4'd1, 3'd0})      // CTRL
                   || (k == {4'd0, 3'd4})      // CAPS LOCK
                   || (k == {4'd0, 3'd5});     // SHIFT LOCK
    endfunction

    logic [127:0] latched;              // which latching keys are down

    // Where each latched modifier sits, recorded when it latches -- the
    // cursor is on it at that moment, so its extent is already known.  Four
    // flat registers rather than an array of them (METHODOLOGY 5.18), one a
    // modifier: {valid, row, start column, span}.
    logic [11:0] lock0, lock1, lock2, lock3;
    function automatic logic [1:0] lock_slot(input logic [6:0] k);
        case (k)
            {4'd1, 3'd0}: lock_slot = 2'd1;    // CTRL
            {4'd0, 3'd4}: lock_slot = 2'd2;    // CAPS LOCK
            {4'd0, 3'd5}: lock_slot = 2'd3;    // SHIFT LOCK
            default:      lock_slot = 2'd0;    // SHIFT
        endcase
    endfunction
    logic  [3:0]  hold;                 // frames left of a keystroke
    logic         press_d;
    logic  [6:0]  typing;
    logic  [7:0]  break_left;
    logic  [6:0]  unlatch;              // walks the latched keys on the way out

    always_ff @(posedge clk) begin
        kev_stb <= 1'b0;
        press_d <= press;

        if (!visible) begin
            // Leaving the keyboard releases everything it was holding, one
            // key per strobe, so a latched SHIFT cannot be left down over the
            // game.
            hold <= 4'd0;
            lock0[11] <= 1'b0; lock1[11] <= 1'b0;
            lock2[11] <= 1'b0; lock3[11] <= 1'b0;
            if (latched[unlatch]) begin
                kev_stb   <= 1'b1;
                kev_press <= 1'b0;
                kev_col   <= unlatch[6:3];
                kev_row   <= unlatch[2:0];
                latched[unlatch] <= 1'b0;
            end
            unlatch <= unlatch + 7'd1;
        end else if (press && !press_d && hold == 4'd0) begin
            if (cur_key == BREAK_KEY) begin
                break_left <= 8'd10;
            end else if (cur_key != NO_KEY) begin
                if (is_latching(cur_key)) begin
                    kev_stb   <= 1'b1;
                    kev_press <= ~latched[cur_key];
                    kev_col   <= cur_key[6:3];
                    kev_row   <= cur_key[2:0];
                    latched[cur_key] <= ~latched[cur_key];
                    // remember where it is, so the panel can show it down
                    case (lock_slot(cur_key))
                        2'd0: lock0 <= {~latched[cur_key], cy, cur_start, cur_span};
                        2'd1: lock1 <= {~latched[cur_key], cy, cur_start, cur_span};
                        2'd2: lock2 <= {~latched[cur_key], cy, cur_start, cur_span};
                        2'd3: lock3 <= {~latched[cur_key], cy, cur_start, cur_span};
                    endcase
                end else begin
                    kev_stb   <= 1'b1;
                    kev_press <= 1'b1;
                    kev_col   <= cur_key[6:3];
                    kev_row   <= cur_key[2:0];
                    typing    <= cur_key;
                    hold      <= 4'd4;
                end
            end
        end else if (hold != 4'd0 && frame && cen_pix) begin
            hold <= hold - 4'd1;
            if (hold == 4'd1) begin
                kev_stb   <= 1'b1;
                kev_press <= 1'b0;
                kev_col   <= typing[6:3];
                kev_row   <= typing[2:0];
            end
        end

        if (break_left != 8'd0 && frame && cen_pix) break_left <= break_left - 8'd1;
    end
    assign key_break = (break_left != 8'd0);

    // --------------------------------------------------------- the picture
    // Two output pixels across per panel pixel, one down: see the note on the
    // geometry at the top.  The byte holding the next eight panel pixels is
    // fetched while the current one is drawn.
    //
    // SHIFT or SHIFT LOCK being down swaps the whole panel for the page the
    // generator rendered with the shifted legends, so the punctuation SHIFT
    // types is on the keys rather than remembered.
    wire        shift_page = latched[{4'd0, 3'd0}] || latched[{4'd0, 3'd5}];
    wire [12:0] page_base  = shift_page ? PAGE_SHIFT : 13'd0;
    wire        in_x = visible && (x >= 10'(X0)) && (x < 10'(X0 + PW * 2));
    wire        in_y = visible && (y >= 9'(Y0))  && (y < 9'(Y0 + PH));
    wire  [8:0] px   = 9'((x - 10'(X0)) >> 1);
    wire  [7:0] py   = 8'(y - 9'(Y0));

    // The pixel a clock edge starts is the NEXT one -- x is updated by the
    // same edge -- so the shift register and the fetch are timed from x + 1.
    // Timed from x itself the whole panel came out one pixel to the right,
    // which the bench caught as 5,768 differing pixels against the generator.
    wire  [9:0] xn  = x + 10'd1;
    wire  [8:0] pxn = 9'((xn - 10'(X0)) >> 1);
    wire        inn = visible && (xn >= 10'(X0)) && (xn < 10'(X0 + PW * 2));

    logic [7:0] shifter;
    always_ff @(posedge clk) begin
        // The ROM answers a clock after its address, so addressing the two
        // map bytes on consecutive clocks lands their answers on the two
        // clocks after that.  Nothing else drives rom_a on this line: the
        // pixel fetch below is inside in_y, and this runs on the line above.
        // rom_q at stage n+1 is what rom_a asked for at stage n: MAP was
        // addressed on map_time and SPAN on stage 0, so their answers are on
        // stages 1 and 2.  Taking them on 2 and 3 put the span byte into
        // cur_key, and the bench read it as pressing col 0 row 3 where the
        // panel says CAPS is col 0 row 4.
        map_seq <= {map_seq[2:0], map_time};
        if (map_seq[1]) cur_key <= rom_q[6:0];
        if (map_seq[2]) begin
            cur_start <= rom_q[7:4];
            cur_span  <= rom_q[3:0];
        end

        if (map_time) begin
            rom_a <= MAP_BASE + {6'd0, cy, cx};
        end else if (map_seq[0]) begin
            rom_a <= SPAN_BASE + {6'd0, cy, cx};
        end else if (cen_pix && inn && in_y) begin
            // a new byte every sixteen output pixels, fetched one pixel ahead
            if (pxn[2:0] == 3'd7 && xn[0])       rom_a <= page_base + {1'b0, py[6:0], pxn[7:3]} + 13'd1;
            if (pxn[2:0] == 3'd0 && !xn[0])      shifter <= rom_q;
            else if (pxn[2:0] != 3'd0 && !xn[0]) shifter <= {shifter[6:0], 1'b0};
        end else if (cen_pix && !inn && in_y) begin
            // the first byte of the line, ready for the panel's left edge
            rom_a <= page_base + {1'b0, py[6:0], 5'd0};
        end
    end

    // A row's top edge is row * 12, which is (row << 3) + (row << 2).
    function automatic logic in_row(input logic [2:0] r);
        in_row = (py >= {2'd0, r, 3'd0} + {3'd0, r, 2'd0}) &&
                 (py <  {2'd0, r, 3'd0} + {3'd0, r, 2'd0} + 8'(CELL_H));
    endfunction
    function automatic logic in_span(input logic [3:0] start, input logic [3:0] span);
        in_span = (px[7:4] >= start) &&
                  ({1'b0, px[7:4]} < {1'b0, start} + {1'b0, span});
    endfunction
    function automatic logic on_lock(input logic [11:0] L);
        on_lock = L[11] && in_row(L[10:8]) && in_span(L[7:4], L[3:0]);
    endfunction

    // The highlight covers the whole key the cursor is on, not the cell it
    // happens to be standing in.
    wire in_cell = in_row(cy) && in_span(cur_start, cur_span);
    assign active = in_x && in_y;
    assign pix    = in_cell ? ~shifter[7] : shifter[7];
    // gated by the panel's own area: outside it px[7:4] wraps and lands back
    // on column 0, which the bench saw as 768 pixels of a latched key printed
    // in the border to the right of the keyboard
    assign hi     = in_x && in_y && (on_lock(lock0) || on_lock(lock1) ||
                                     on_lock(lock2) || on_lock(lock3));
endmodule

`default_nettype wire

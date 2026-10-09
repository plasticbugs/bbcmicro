//------------------------------------------------------------------------------
// A PS/2 keyboard on the Analogizer's SNAC port, as keys on a BBC keyboard.
//
// The adapter's receiver (target/pocket/analogizer/ps2_keyboard.vhd, in the
// Analogizer's clock) hands over each byte the keyboard sends -- scancode set
// 2, prefixes and all -- on `ps2_code`, and holds `ps2_code_new` HIGH from the
// moment the byte is complete until the next byte starts.  So here it is a
// level to synchronise and edge-detect, and the code is stable for as long as
// that level is high: it is sampled two clocks after the synchronised edge.
//
// The layout is positional, as MAME maps a host keyboard onto this machine
// (ref/mame/acorn/bbc_kbd.cpp, PORT_CODE): each PC key presses the BBC key in
// the same place, whatever its legend says.  So SHIFT+2 gives the BBC's
// double quote, not the PC's @.  MAME's choices for the keys a PC does not
// have: F1-F10 are f0-f9, Left Alt is SHIFT LOCK, End is COPY, Delete and
// Backspace are DELETE, F12 is BREAK.  Both SHIFTs are SHIFT, both CTRLs CTRL.
//
// A key is a matrix position {column[3:0], row[2:0]}, the shape bbc_input and
// the on-screen keyboard send (docs/hardware.md 3.1).  An event waits in
// `pend` until core_top takes it, in a clock when neither of the other two
// sources is sending.  BREAK is not in the matrix: it is a level, for as long
// as F12 is held.
//------------------------------------------------------------------------------
`default_nettype none

module bbc_ps2 (
    input  logic       clk,
    input  logic       rst,

    // from the adapter's receiver, in its own clock domain
    input  logic       ps2_code_new,    // a level: high while `ps2_code` holds a byte
    input  logic [7:0] ps2_code,

    // one key event at a time, held until taken
    output logic       pend,
    input  logic       take,
    output logic       kev_press,
    output logic [3:0] kev_col,
    output logic [2:0] kev_row,

    output logic       key_break
);
    // ------------------------------------------------- bytes into this clock
    logic [2:0] new_s;
    logic [1:0] wait_s;
    logic       byte_stb;
    logic [7:0] byte_q;
    always_ff @(posedge clk) begin
        new_s    <= {new_s[1:0], ps2_code_new};
        wait_s   <= {wait_s[0], new_s[1] && !new_s[2]};
        byte_stb <= wait_s[1];
        if (wait_s[1]) byte_q <= ps2_code;      // stable: the level is still high
    end

    // ------------------------------------------------------------ the map
    localparam logic [6:0] K_NONE = 7'h7F;
    localparam logic [6:0] K_BREAK = 7'h7E;     // not a matrix position

    // Set 2 scancode (and whether it came after E0) to a BBC key.
    function automatic logic [6:0] keymap(input logic ext, input logic [7:0] c);
        keymap = K_NONE;
        if (!ext) case (c)
            // column 0
            8'h12, 8'h59: keymap = {4'd0, 3'd0};   // SHIFT (left, right)
            8'h15: keymap = {4'd0, 3'd1};          // Q
            8'h05: keymap = {4'd0, 3'd2};          // F1 -> f0
            8'h16: keymap = {4'd0, 3'd3};          // 1
            8'h58: keymap = {4'd0, 3'd4};          // CAPS LOCK
            8'h11: keymap = {4'd0, 3'd5};          // Left Alt -> SHIFT LOCK
            8'h0D: keymap = {4'd0, 3'd6};          // TAB
            8'h76: keymap = {4'd0, 3'd7};          // ESCAPE
            // column 1
            8'h14: keymap = {4'd1, 3'd0};          // CTRL (left)
            8'h26: keymap = {4'd1, 3'd1};          // 3
            8'h1D: keymap = {4'd1, 3'd2};          // W
            8'h1E: keymap = {4'd1, 3'd3};          // 2
            8'h1C: keymap = {4'd1, 3'd4};          // A
            8'h1B: keymap = {4'd1, 3'd5};          // S
            8'h1A: keymap = {4'd1, 3'd6};          // Z
            8'h06: keymap = {4'd1, 3'd7};          // F2 -> f1
            // column 2
            8'h25: keymap = {4'd2, 3'd1};          // 4
            8'h24: keymap = {4'd2, 3'd2};          // E
            8'h23: keymap = {4'd2, 3'd3};          // D
            8'h22: keymap = {4'd2, 3'd4};          // X
            8'h21: keymap = {4'd2, 3'd5};          // C
            8'h29: keymap = {4'd2, 3'd6};          // SPACE
            8'h04: keymap = {4'd2, 3'd7};          // F3 -> f2
            // column 3
            8'h2E: keymap = {4'd3, 3'd1};          // 5
            8'h2C: keymap = {4'd3, 3'd2};          // T
            8'h2D: keymap = {4'd3, 3'd3};          // R
            8'h2B: keymap = {4'd3, 3'd4};          // F
            8'h34: keymap = {4'd3, 3'd5};          // G
            8'h2A: keymap = {4'd3, 3'd6};          // V
            8'h0C: keymap = {4'd3, 3'd7};          // F4 -> f3
            // column 4
            8'h03: keymap = {4'd4, 3'd1};          // F5 -> f4
            8'h3D: keymap = {4'd4, 3'd2};          // 7
            8'h36: keymap = {4'd4, 3'd3};          // 6
            8'h35: keymap = {4'd4, 3'd4};          // Y
            8'h33: keymap = {4'd4, 3'd5};          // H
            8'h32: keymap = {4'd4, 3'd6};          // B
            8'h0B: keymap = {4'd4, 3'd7};          // F6 -> f5
            // column 5
            8'h3E: keymap = {4'd5, 3'd1};          // 8
            8'h43: keymap = {4'd5, 3'd2};          // I
            8'h3C: keymap = {4'd5, 3'd3};          // U
            8'h3B: keymap = {4'd5, 3'd4};          // J
            8'h31: keymap = {4'd5, 3'd5};          // N
            8'h3A: keymap = {4'd5, 3'd6};          // M
            8'h83: keymap = {4'd5, 3'd7};          // F7 -> f6
            // column 6
            8'h0A: keymap = {4'd6, 3'd1};          // F8 -> f7
            8'h46: keymap = {4'd6, 3'd2};          // 9
            8'h44: keymap = {4'd6, 3'd3};          // O
            8'h42: keymap = {4'd6, 3'd4};          // K
            8'h4B: keymap = {4'd6, 3'd5};          // L
            8'h41: keymap = {4'd6, 3'd6};          // , <
            8'h01: keymap = {4'd6, 3'd7};          // F9 -> f8
            // column 7
            8'h4E: keymap = {4'd7, 3'd1};          // - =
            8'h45: keymap = {4'd7, 3'd2};          // 0
            8'h4D: keymap = {4'd7, 3'd3};          // P
            8'h5D: keymap = {4'd7, 3'd4};          // PC \ -> @
            8'h4C: keymap = {4'd7, 3'd5};          // ; +
            8'h49: keymap = {4'd7, 3'd6};          // . >
            8'h09: keymap = {4'd7, 3'd7};          // F10 -> f9
            // column 8
            8'h55: keymap = {4'd8, 3'd1};          // PC = -> ^ ~
            8'h0E: keymap = {4'd8, 3'd2};          // PC ` -> _ and pound
            8'h54: keymap = {4'd8, 3'd3};          // [ {
            8'h52: keymap = {4'd8, 3'd4};          // PC ' -> : *
            8'h5B: keymap = {4'd8, 3'd5};          // ] }
            8'h4A: keymap = {4'd8, 3'd6};          // / ?
            8'h61: keymap = {4'd8, 3'd7};          // the ISO key left of Z -> \ |
            // column 9
            8'h5A: keymap = {4'd9, 3'd4};          // RETURN
            8'h66: keymap = {4'd9, 3'd5};          // Backspace -> DELETE
            8'h07: keymap = K_BREAK;               // F12 -> BREAK
            default: ;
        endcase else case (c)
            8'h14: keymap = {4'd1, 3'd0};          // right CTRL
            8'h6B: keymap = {4'd9, 3'd1};          // cursor left
            8'h72: keymap = {4'd9, 3'd2};          // cursor down
            8'h75: keymap = {4'd9, 3'd3};          // cursor up
            8'h5A: keymap = {4'd9, 3'd4};          // keypad Enter -> RETURN
            8'h71: keymap = {4'd9, 3'd5};          // Delete -> DELETE
            8'h69: keymap = {4'd9, 3'd6};          // End -> COPY
            8'h74: keymap = {4'd9, 3'd7};          // cursor right
            // E0 12 and E0 59 are the "fake shifts" a keyboard wraps round
            // Print Screen and the cursor block: unmapped, so ignored, which is
            // what keeps SHIFT from being released under a shifted cursor key
            default: ;
        endcase
    endfunction

    // ------------------------------------------------------- the decoder
    // E0 marks the next code extended, F0 marks it a release; E1 starts the
    // eight-byte Pause sequence, which is skipped whole (it has no break
    // codes of its own and nothing on the BBC to press).
    logic       ext, rel;
    logic [2:0] skip;
    wire  [6:0] k = keymap(ext, byte_q);

    always_ff @(posedge clk) begin
        if (rst) begin
            ext <= 1'b0; rel <= 1'b0; skip <= 3'd0;
            pend <= 1'b0; key_break <= 1'b0;
        end else begin
            if (take) pend <= 1'b0;
            if (byte_stb) begin
                if (skip != 3'd0)        skip <= skip - 3'd1;
                else if (byte_q == 8'hE1) skip <= 3'd7;
                else if (byte_q == 8'hE0) ext  <= 1'b1;
                else if (byte_q == 8'hF0) rel  <= 1'b1;
                else begin
                    ext <= 1'b0; rel <= 1'b0;
                    if (k == K_BREAK) key_break <= !rel;
                    else if (k != K_NONE) begin
                        // a byte every millisecond at the most: the last event
                        // is long taken by the time another can arrive
                        pend      <= 1'b1;
                        kev_press <= !rel;
                        kev_col   <= k[6:3];
                        kev_row   <= k[2:0];
                    end
                end
            end
        end
    end
endmodule

`default_nettype wire

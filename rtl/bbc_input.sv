//------------------------------------------------------------------------------
// The Pocket's pad, as keys on a BBC keyboard.
//
// The machine has no joystick port worth using -- the analogue port needs a
// real Acorn joystick and almost nothing supports it -- so a BBC game reads
// the keyboard, and the pad has to press keys.  Each direction and each button
// presses one position in the key matrix, and which position is chosen from
// the Core Settings menu, because every game uses different keys.
//
// A key is a matrix position: {column[3:0], row[2:0]}, exactly as
// docs/hardware.md section 3.1 lists them, and the same shape the on-screen
// keyboard sends.  Events go out one at a time, on a small queue, because the
// core takes one press or release per strobe.
//------------------------------------------------------------------------------
`default_nettype none

module bbc_input (
    input  logic       clk,
    input  logic       rst,

    // the pad
    input  logic       up, down, left, right,
    input  logic       b_a, b_b, b_x, b_y,
    input  logic       b_l, b_r,
    input  logic       b_select, b_start,

    // which keys they press (from the menu)
    input  logic [3:0] map_dpad,        // a set of four keys for the d-pad
    input  logic [3:0] map_a, map_b, map_x, map_y,
    input  logic [3:0] map_select, map_start,

    // hold everything off (the on-screen keyboard has the pad)
    input  logic       inhibit,

    // one key event at a time
    output logic       kev_stb,
    output logic       kev_press,
    output logic [3:0] kev_col,
    output logic [2:0] kev_row
);
    // ---------------------------------------------------------------- keys
    // {column, row} of every key this module can press.  From MAME's port
    // definitions (ref/mame/acorn/bbc_kbd.cpp), which tools/list_ports.lua
    // prints.
    localparam logic [6:0] K_NONE   = 7'h7F;   // column 15 is not wired
    localparam logic [6:0] K_SPACE  = {4'd2, 3'd6};
    localparam logic [6:0] K_RETURN = {4'd9, 3'd4};
    localparam logic [6:0] K_DELETE = {4'd9, 3'd5};
    localparam logic [6:0] K_COPY   = {4'd9, 3'd6};
    localparam logic [6:0] K_ESCAPE = {4'd0, 3'd7};
    localparam logic [6:0] K_SHIFT  = {4'd0, 3'd0};
    localparam logic [6:0] K_CTRL   = {4'd1, 3'd0};
    localparam logic [6:0] K_UP     = {4'd9, 3'd3};
    localparam logic [6:0] K_DOWN   = {4'd9, 3'd2};
    localparam logic [6:0] K_LEFT   = {4'd9, 3'd1};
    localparam logic [6:0] K_RIGHT  = {4'd9, 3'd7};
    localparam logic [6:0] K_A      = {4'd1, 3'd4};
    localparam logic [6:0] K_S      = {4'd1, 3'd5};
    localparam logic [6:0] K_D      = {4'd2, 3'd3};
    localparam logic [6:0] K_F      = {4'd3, 3'd4};
    localparam logic [6:0] K_Z      = {4'd1, 3'd6};
    localparam logic [6:0] K_X      = {4'd2, 3'd4};
    localparam logic [6:0] K_C      = {4'd2, 3'd5};
    localparam logic [6:0] K_V      = {4'd3, 3'd6};
    localparam logic [6:0] K_P      = {4'd7, 3'd3};
    localparam logic [6:0] K_L      = {4'd6, 3'd5};
    localparam logic [6:0] K_COLON  = {4'd8, 3'd4};   // : and *
    localparam logic [6:0] K_SLASH  = {4'd8, 3'd6};   // / and ?
    localparam logic [6:0] K_AT     = {4'd7, 3'd4};
    localparam logic [6:0] K_MINUS  = {4'd7, 3'd1};
    localparam logic [6:0] K_1      = {4'd0, 3'd3};
    localparam logic [6:0] K_2      = {4'd1, 3'd3};
    localparam logic [6:0] K_F0     = {4'd0, 3'd2};
    localparam logic [6:0] K_COMMA_L = {4'd6, 3'd6};   // , <
    localparam logic [6:0] K_COMMA_R = {4'd7, 3'd6};   // . >
    localparam logic [6:0] K_W       = {4'd1, 3'd2};

    // The menu's sixteen choices for a button.  Keep this list and
    // interact.json's option list in the same order: every entry in that menu
    // is a claim that the gateware does something (METHODOLOGY section 5.5).
    function automatic logic [6:0] keysel(input logic [3:0] sel);
        case (sel)
            4'd0:  keysel = K_SPACE;
            4'd1:  keysel = K_RETURN;
            4'd2:  keysel = K_SHIFT;
            4'd3:  keysel = K_CTRL;
            4'd4:  keysel = K_ESCAPE;
            4'd5:  keysel = K_DELETE;
            4'd6:  keysel = K_COPY;
            4'd7:  keysel = K_A;
            4'd8:  keysel = K_S;
            4'd9:  keysel = K_Z;
            4'd10: keysel = K_X;
            4'd11: keysel = K_C;
            4'd12: keysel = K_COLON;
            4'd13: keysel = K_SLASH;
            4'd14: keysel = K_F0;
            default: keysel = K_1;
        endcase
    endfunction

    // The d-pad's four keys, as sets, because a game's directions come as a
    // set and mapping them one at a time from a menu is four times the work
    // for the person holding the Pocket.
    function automatic logic [6:0] dpadsel(input logic [3:0] sel,
                                           input logic [1:0] dir);
        // dir: 0 up, 1 down, 2 left, 3 right
        case (sel)
            4'd0: case (dir)                     // cursor keys
                      2'd0: dpadsel = K_UP;
                      2'd1: dpadsel = K_DOWN;
                      2'd2: dpadsel = K_LEFT;
                      default: dpadsel = K_RIGHT;
                  endcase
            4'd1: case (dir)                     // Z X : / -- the common set
                      2'd0: dpadsel = K_COLON;
                      2'd1: dpadsel = K_SLASH;
                      2'd2: dpadsel = K_Z;
                      default: dpadsel = K_X;
                  endcase
            4'd2: case (dir)                     // A Z , . style: A S / space
                      2'd0: dpadsel = K_A;
                      2'd1: dpadsel = K_Z;
                      2'd2: dpadsel = K_COMMA_L;
                      default: dpadsel = K_COMMA_R;
                  endcase
            default: case (dir)                  // W A S D
                      2'd0: dpadsel = K_W;
                      2'd1: dpadsel = K_S;
                      2'd2: dpadsel = K_A;
                      default: dpadsel = K_D;
                  endcase
        endcase
    endfunction

    // ------------------------------------------------------- the pad's keys
    localparam int NPAD = 10;
    logic [6:0] want [NPAD];
    logic       down_now [NPAD];

    always_comb begin
        want[0] = dpadsel(map_dpad, 2'd0); down_now[0] = up       && !inhibit;
        want[1] = dpadsel(map_dpad, 2'd1); down_now[1] = down     && !inhibit;
        want[2] = dpadsel(map_dpad, 2'd2); down_now[2] = left     && !inhibit;
        want[3] = dpadsel(map_dpad, 2'd3); down_now[3] = right    && !inhibit;
        want[4] = keysel(map_a);           down_now[4] = b_a      && !inhibit;
        want[5] = keysel(map_b);           down_now[5] = b_b      && !inhibit;
        want[6] = keysel(map_x);           down_now[6] = b_x      && !inhibit;
        want[7] = keysel(map_y);           down_now[7] = b_y      && !inhibit;
        want[8] = keysel(map_select);      down_now[8] = b_select && !inhibit
                                                         && !(b_l && b_r);
        want[9] = keysel(map_start);       down_now[9] = b_start  && !inhibit
                                                         && !(b_l && b_r);
    end

    // ------------------------------------------------------------- events
    // One event per strobe, walking the pad's keys in turn and reporting any
    // that changed.  A key whose mapping changed while it was held is
    // released at its old position first, because the machine's matrix has
    // no idea the menu moved.
    logic [6:0] held [NPAD];
    logic       is_held [NPAD];
    logic [3:0] scan;

    always_ff @(posedge clk) begin
        kev_stb <= 1'b0;
        if (rst) begin
            scan <= 4'd0;
            for (int i = 0; i < NPAD; i++) is_held[i] <= 1'b0;
        end else begin
            scan <= (scan == 4'(NPAD - 1)) ? 4'd0 : scan + 4'd1;
            if (is_held[scan] && (!down_now[scan] || held[scan] != want[scan])) begin
                kev_stb   <= 1'b1;
                kev_press <= 1'b0;
                kev_col   <= held[scan][6:3];
                kev_row   <= held[scan][2:0];
                is_held[scan] <= 1'b0;
            end else if (!is_held[scan] && down_now[scan] && want[scan] != K_NONE) begin
                kev_stb   <= 1'b1;
                kev_press <= 1'b1;
                kev_col   <= want[scan][6:3];
                kev_row   <= want[scan][2:0];
                held[scan]    <= want[scan];
                is_held[scan] <= 1'b1;
            end
        end
    end
endmodule

`default_nettype wire

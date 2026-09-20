//------------------------------------------------------------------------------
// The BBC keyboard: a 10 x 8 matrix, its two scan modes, and the startup links
// (docs/hardware.md section 3).
//
// The matrix is addressed through the system VIA's port A -- PA3-0 the column,
// PA6-4 the row -- and answers on PA7, which is the one pin of the port that
// is an input.  Two modes, chosen by the addressable latch's Q3 (`kb_en`,
// active low):
//
//   kb_en = 0   polled: the column comes from PA3-0 and PA7 is that key
//   kb_en = 1   free running: a 1 MHz counter walks the columns by itself and
//               raises CA2 whenever any key in the current column other than
//               row 0 is down, which is how the OS gets a keyboard interrupt
//
// Row 0 is not keys.  Columns 0 and 1 are SHIFT and CTRL, and columns 2 to 9
// are the startup links the OS reads at reset -- which is why row 0 is
// excluded from the interrupt.  A link fitted reads as a key down.
//
// Keys arrive as matrix positions rather than scancodes, because both sources
// know the matrix: the on-screen keyboard draws it, and core_top translates
// the pad and any USB keyboard into it.
//------------------------------------------------------------------------------
`default_nettype none

module bbc_keyboard (
    input  logic       clk,
    input  logic       rst,
    input  logic       cen_1m,

    // a key going down or coming up, as a matrix position
    input  logic       kev_stb,
    input  logic       kev_press,
    input  logic [3:0] kev_col,
    input  logic [2:0] kev_row,
    input  logic       kev_clear,      // release everything (menu opened, say)

    // the startup links, bit 0 = column 2 ... bit 7 = column 9.
    // 1 = fitted, which the OS reads as a key down.
    input  logic [7:0] links,

    // from the machine
    input  logic       kb_en,          // latch Q3: 1 = free running
    input  logic [6:0] pa,             // what the VIA drives on PA6-0

    // to the machine
    output logic       pa7,            // 1 = the addressed key is down
    output logic       ca2             // 1 = a key is down in the scanned column
);
    // {column, row}: 128 bits of state, flat, so there is nothing for a
    // synthesiser to interpret (METHODOLOGY section 5.18).  Row 0 of columns
    // 0 and 1 (SHIFT, CTRL) lives here too; row 0 of columns 2-9 comes from
    // the links and is never written.
    logic [127:0] keys;

    always_ff @(posedge clk) begin
        if (rst || kev_clear) begin
            keys <= '0;
        end else if (kev_stb) begin
            keys[{kev_col, kev_row}] <= kev_press;
        end
    end

    // free-running column counter, 1 MHz, exactly as the hardware's 4-bit
    // counter does when the latch releases it
    logic [3:0] scan_col;
    always_ff @(posedge clk) begin
        if (rst) scan_col <= 4'd0;
        else if (cen_1m && kb_en) scan_col <= scan_col + 4'd1;
    end

    wire [3:0] col = kb_en ? scan_col : pa[3:0];
    wire [2:0] row = pa[6:4];

    // row 0 of columns 2..9 is the links, not the matrix
    function automatic logic key_at(input logic [3:0] c, input logic [2:0] r);
        if (r == 3'd0 && c >= 4'd2 && c <= 4'd9) key_at = links[3'(c - 4'd2)];
        else                                     key_at = keys[{c, r}];
    endfunction

    // PA7 in polled mode is the addressed key; in free-running mode the VIA
    // reads back what it drove, which the machine's port A mux does.
    assign pa7 = key_at(col, row);

    // CA2: any key down in this column except row 0
    logic any;
    always_comb begin
        any = 1'b0;
        for (int r = 1; r < 8; r++) any |= keys[{col, r[2:0]}];
    end
    assign ca2 = any;
endmodule

`default_nettype wire

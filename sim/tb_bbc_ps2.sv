// rtl/bbc_ps2.sv on its own, as core_top drives it: bytes arrive in the
// Analogizer's 48 MHz clock the way its PS/2 receiver hands them over
// (ps2_keyboard.vhd: the code on `ps2_code`, `ps2_code_new` HIGH from the end
// of the byte until the next byte starts), and the events are taken in the
// 96 MHz clock whenever they are pending, as core_top takes them.  Checks:
//
//   map      every key MAME maps from a host keyboard (sim/run_ps2.sh builds
//            the list from ref/mame/acorn/bbc_kbd.cpp and the set 2 table),
//            pressed and released: one press and one release at its position
//   E0       an extended key after a plain one with the same code (cursor
//            down E0 72 is not keypad 2's 72): the prefix applies once
//   fake     E0 12 / E0 F0 12 around a cursor key do not touch SHIFT
//   Pause    E1 14 77 E1 F0 14 F0 77 sends nothing, and the next key works
//   BREAK    F12 holds key_break for as long as it is down; no matrix event
//   other    an unmapped key (Scroll Lock 7E) sends nothing
//
// sim/run_ps2.sh builds and runs it.
`timescale 1ps/1ps
`default_nettype none

module tb_bbc_ps2;
    logic clk = 1'b0, clk_a = 1'b0;
    always #5208 clk = ~clk;              // 96 MHz
    always #10416 clk_a = ~clk_a;         // 48 MHz, the Analogizer's

    logic       rst = 1'b1;
    logic       code_new = 1'b0;
    logic [7:0] code = 8'h00;
    wire        pend, kev_press, key_break;
    wire  [3:0] kev_col;
    wire  [2:0] kev_row;

    bbc_ps2 dut (
        .clk(clk), .rst(rst),
        .ps2_code_new(code_new), .ps2_code(code),
        .pend(pend), .take(pend),
        .kev_press(kev_press), .kev_col(kev_col), .kev_row(kev_row),
        .key_break(key_break)
    );

    // what core_top passes on to the matrix, taken as it is pending
    typedef struct packed { logic press; logic [3:0] col; logic [2:0] row; } ev_t;
    ev_t evq[$];
    always @(posedge clk) if (pend) evq.push_back({kev_press, kev_col, kev_row});

    // One byte, as the receiver gives it: the line goes busy (the level
    // drops), eleven bit times later the code is there and the level rises,
    // and it stays up until the next byte -- here a byte every 1.2 ms or so,
    // which is a keyboard's pace, shortened to keep the run short.
    task automatic send(input [7:0] b);
        @(posedge clk_a) code_new <= 1'b0;
        repeat (200) @(posedge clk_a);
        code <= b;
        code_new <= 1'b1;
        repeat (200) @(posedge clk_a);
    endtask

    int errors = 0;
    task automatic fail(input string what);
        $display("FAIL: %s", what);
        errors++;
    endtask

    task automatic expect_events(input ev_t want[$], input string what);
        repeat (20) @(posedge clk);
        if (evq.size() != want.size()) begin
            $display("  %s: %0d events, want %0d", what, evq.size(), want.size());
            fail("wrong number of key events");
        end else
            foreach (want[i])
                if (evq[i] !== want[i]) begin
                    $display("  %s: event %0d is %s col %0d row %0d, want %s col %0d row %0d",
                             what, i, evq[i].press ? "press" : "release", evq[i].col, evq[i].row,
                             want[i].press ? "press" : "release", want[i].col, want[i].row);
                    fail("wrong key event");
                end
        evq.delete();
    endtask

    int keys = 0;
    task automatic key_try(input logic ext, input [7:0] c, input [3:0] col, input [2:0] row,
                           input string name);
        ev_t want[$];
        if (ext) send(8'hE0);
        send(c);
        if (ext) send(8'hE0);
        send(8'hF0);
        send(c);
        want = '{{1'b1, col, row}, {1'b0, col, row}};
        expect_events(want, name);
        keys++;
    endtask
`include "keys.svh"

    initial begin
        ev_t want[$];
        repeat (20) @(posedge clk);
        rst = 1'b0;
        repeat (20) @(posedge clk);

        map_keys();
        if (keys != MAPPED || keys < 70) fail("the map list is short");
        $display("map: %0d host keys from MAME's port list, each one press and one release where MAME puts it",
                 keys);

        // E0 applies to one code only: keypad 2 (72, unmapped) after cursor down
        send(8'hE0); send(8'h72); send(8'h72); send(8'hE0); send(8'hF0); send(8'h72);
        want = '{{1'b1, 4'd9, 3'd2}, {1'b0, 4'd9, 3'd2}};
        expect_events(want, "E0 once");

        // a shifted cursor key: E0 F0 12 before, E0 12 after, SHIFT untouched
        send(8'h12);                                    // SHIFT down
        send(8'hE0); send(8'hF0); send(8'h12);          // fake shift up
        send(8'hE0); send(8'h75);                       // cursor up
        send(8'hE0); send(8'hF0); send(8'h75);
        send(8'hE0); send(8'h12);                       // fake shift down
        send(8'hF0); send(8'h12);                       // SHIFT up
        want = '{{1'b1, 4'd0, 3'd0}, {1'b1, 4'd9, 3'd3}, {1'b0, 4'd9, 3'd3}, {1'b0, 4'd0, 3'd0}};
        expect_events(want, "fake shifts");

        // Pause, then A
        send(8'hE1); send(8'h14); send(8'h77); send(8'hE1);
        send(8'hF0); send(8'h14); send(8'hF0); send(8'h77);
        send(8'h1C); send(8'hF0); send(8'h1C);
        want = '{{1'b1, 4'd1, 3'd4}, {1'b0, 4'd1, 3'd4}};
        expect_events(want, "Pause, then A");

        // BREAK: a level, not a key
        send(8'h07);
        repeat (20) @(posedge clk);
        if (key_break !== 1'b1) fail("BREAK: F12 down does not hold key_break");
        send(8'hF0); send(8'h07);
        repeat (20) @(posedge clk);
        if (key_break !== 1'b0) fail("BREAK: F12 up does not let go");
        want = '{};
        expect_events(want, "BREAK");

        // unmapped: Scroll Lock
        send(8'h7E); send(8'hF0); send(8'h7E);
        expect_events(want, "Scroll Lock");
        $display("E0 once, fake shifts, Pause, BREAK, unmapped: checked");

        if (errors == 0) $display("PASS");
        else $display("FAILED: %0d", errors);
        $finish;
    end
endmodule

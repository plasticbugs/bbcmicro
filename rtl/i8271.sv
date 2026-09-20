//------------------------------------------------------------------------------
// Intel 8271 floppy disc controller, as DFS 1.20 uses it.
//
// Written from MAME's device model (ref/mame/devices/i8271.cpp) and from a
// trace of what DFS actually asks for -- tools/fdc_trace.lua logs every access
// to FE80-FE9F while MAME boots the disc, and over a whole Exile boot DFS
// issues exactly seven commands:
//
//   35 Specify                 four parameters; initialisation and bad tracks
//   3A Write special register  the mode register (17) and the drive control
//                              output port (23): side, head load, step
//   3D Read special register   reads the output port back
//   2C Read drive status       ready, write protect, index, track 0
//   29 Seek                    one parameter, the track
//   13 Read data, multi-sector track, sector, then size and count
//   0B Write data, multi       the same, for saving
//
// Everything else answers with "not implemented" rather than silently
// succeeding, because a fallback that looks like success hides the failure
// that triggered it (METHODOLOGY section 5.8).
//
// This is a functional model of the chip, not of the disc: there is no flux,
// no CRC and no index timing.  What it does keep is the byte rate -- one byte
// every 32 us, which is what a 250 kbit/s FM disc delivers -- because that is
// the pace DFS's transfer loop is written around, and the handshake, because
// the real chip drops a transfer that the CPU does not keep up with.
//
// The disc image lives in SDRAM as a flat DFS image: ten 256-byte sectors per
// track, so sector s of track t is at (t*10 + s)*256 on a single-sided image,
// and tracks alternate sides on a double-sided one.
//------------------------------------------------------------------------------
`default_nettype none

module i8271 (
    input  logic        clk,
    input  logic        rst,
    input  logic        cen_1us,        // one pulse per microsecond

    // CPU side: one access per `acc` pulse, at the end of the CPU's cycle
    input  logic        acc,
    input  logic        rnw,
    input  logic  [2:0] addr,           // bit 2 selects the data register
    input  logic  [7:0] din,
    output logic  [7:0] dout,
    output logic        irq,
    output logic        drq,

    // the disc images in SDRAM
    output logic        img_req,
    output logic        img_we,
    output logic        img_drive,
    output logic [19:0] img_addr,
    output logic  [7:0] img_wdata,
    input  logic        img_ack,
    input  logic  [7:0] img_rdata,
    input  logic  [1:0] img_present,
    input  logic  [1:0] img_dsided,     // this image has both sides in it

    output logic  [7:0] dbg
);
    // --------------------------------------------------------------- timing
    localparam int BYTE_US = 32;        // 250 kbit/s FM
    localparam int STEP_US = 2000;      // per track, while seeking
    localparam int SETTLE_US = 8000;    // head settling after a seek
    localparam int END_US = 8;          // between the last byte and the
                                        // completion interrupt, so the CPU
                                        // sees NMI go low between them

    // ------------------------------------------------------------- results
    localparam logic [7:0] ERR_NONE = 8'h00;
    localparam logic [7:0] ERR_DMA  = 8'h0A;   // the CPU missed a byte
    localparam logic [7:0] ERR_NR   = 8'h10;   // drive not ready
    localparam logic [7:0] ERR_WP   = 8'h12;   // write protected
    localparam logic [7:0] ERR_NF   = 8'h18;   // sector not found

    // -------------------------------------------------------------- phases
    typedef enum logic [1:0] { P_IDLE, P_CMD, P_EXEC, P_RESULT } phase_t;
    phase_t phase;

    logic [7:0] cmd, par0, par1, par2, par3;
    logic [2:0] par_have, par_want;
    logic [7:0] result;
    logic [7:0] moder, oport;
    logic [7:0] pcn0, pcn1;             // present cylinder, per drive
    logic [7:0] scan_sec;

    wire        sel_drive = cmd[7];
    wire        head_load = oport[3];
    wire        side      = oport[5];
    wire        ready0    = head_load && img_present[0];
    wire        ready1    = head_load && img_present[1];

    // ----------------------------------------------------------- execution
    typedef enum logic [3:0] {
        X_NONE, X_SEEK, X_RD_FETCH, X_RD_WAIT, X_RD_OFFER, X_RD_NEXT,
        X_WR_ASK, X_WR_WAIT, X_WR_STORE, X_WR_NEXT, X_END, X_DONE
    } exec_t;
    exec_t xs;

    logic [7:0]  trk, sec, sec_left;
    logic [8:0]  byte_left;
    logic [19:0] cur_addr;
    logic [15:0] us_left;
    logic [7:0]  data_reg;

    // Sector size from the size code.  DFS only ever asks for 256, and the
    // single-record commands take their size from the ID field on the disc,
    // which on a DFS disc is always 256 -- MAME's model forces 128 there, and
    // nothing this core runs exercises it either way.
    function automatic logic [8:0] sec_size(input logic [2:0] code);
        case (code)
            3'd0: sec_size = 9'd128;
            3'd1: sec_size = 9'd256;
            default: sec_size = 9'd256;   // 512 and up cannot be a DFS disc
        endcase
    endfunction

    // where a sector lives in the image
    function automatic logic [19:0] sector_addr(
            input logic [7:0] t, input logic [7:0] s,
            input logic sd, input logic dsided);
        logic [15:0] lsn, cyl;
        cyl = dsided ? ({7'd0, t, 1'b0} + {15'd0, sd}) : {8'd0, t};
        lsn = cyl * 16'd10 + {8'd0, s};
        sector_addr = {lsn[11:0], 8'd0};
    endfunction

    // ------------------------------------------------------ how many params
    always_comb begin
        case (din[5:0])
            6'h35:   par_want = 3'd4;    // specify
            6'h3A:   par_want = 3'd2;    // write special register
            6'h3D:   par_want = 3'd1;    // read special register
            6'h2C:   par_want = 3'd0;    // read drive status
            6'h29:   par_want = 3'd1;    // seek
            6'h13, 6'h17, 6'h0B, 6'h0F, 6'h1F, 6'h1B:
                     par_want = 3'd3;    // multi-sector transfers and read id
            6'h12, 6'h16, 6'h0A, 6'h0E, 6'h1E:
                     par_want = 3'd2;    // single-sector transfers
            6'h23:   par_want = 3'd4;    // format
            default: par_want = 3'd0;
        endcase
    end
    logic [2:0] par_need;                // latched with the command

    // ------------------------------------------------------- the registers
    // 300 rpm: an index pulse of 2 ms every 200 ms.  DFS reads it but does
    // not wait for it; a controller that never showed one would still work,
    // and one that always showed one would look like a disc that is not
    // turning.
    logic [17:0] rot;
    always_ff @(posedge clk) begin
        if (rst) rot <= 18'd0;
        else if (cen_1us) rot <= (rot == 18'd199_999) ? 18'd0 : rot + 18'd1;
    end
    wire index = (rot < 18'd2000);
    wire [7:0] cur_pcn = sel_drive ? pcn1 : pcn0;
    wire [7:0] drive_status = {1'b0, ready1, 1'b0, index,
                               1'b1, ready0, 1'b0, cur_pcn == 8'd0};
    wire [7:0] status = {phase == P_EXEC, phase == P_CMD, 1'b0,
                         phase == P_RESULT, irq,
                         drq && moder[0], 2'b00};

    always_comb begin
        if (addr[2])               dout = data_reg;
        else if (addr[1:0] == 2'd0) dout = status;
        else if (addr[1:0] == 2'd1) dout = result;
        else                        dout = 8'hFF;
    end

    assign img_drive = sel_drive;
    assign img_addr  = cur_addr;
    assign img_wdata = data_reg;
    assign dbg       = {2'b00, phase, xs};

    // ------------------------------------------------------------ the chip
    always_ff @(posedge clk) begin
        if (rst) begin
            phase    <= P_IDLE;
            xs       <= X_NONE;
            irq      <= 1'b0;
            drq      <= 1'b0;
            result   <= 8'h00;
            moder    <= 8'hC0;
            oport    <= 8'h00;
            pcn0     <= 8'd0;
            pcn1     <= 8'd0;
            scan_sec <= 8'd0;
            img_req  <= 1'b0;
            img_we   <= 1'b0;
            par_have <= 3'd0;
            par_need <= 3'd0;
        end else begin
            // ---------------------------------------------------- CPU side
            if (acc) begin
                if (addr[2]) begin
                    // the data register: reading takes the byte, writing
                    // supplies one, and either way the request is answered
                    if (rnw) drq <= 1'b0;
                    else begin
                        if (drq) begin
                            data_reg <= din;
                            drq <= 1'b0;
                        end
                    end
                end else if (rnw) begin
                    // reading the result register ends the result phase
                    if (addr[1:0] == 2'd1) begin
                        if (phase == P_RESULT) phase <= P_IDLE;
                        irq <= 1'b0;
                    end
                end else begin
                    case (addr[1:0])
                        2'd0: if (phase == P_IDLE) begin          // command
                            cmd      <= din;
                            par_have <= 3'd0;
                            par_need <= par_want;
                            result   <= ERR_NONE;
                            phase    <= (par_want == 3'd0) ? P_EXEC : P_CMD;
                            if (par_want == 3'd0) xs <= X_NONE;   // start below
                        end
                        2'd1: if (phase == P_CMD) begin           // parameter
                            case (par_have)
                                3'd0: par0 <= din;
                                3'd1: par1 <= din;
                                3'd2: par2 <= din;
                                default: par3 <= din;
                            endcase
                            if (par_have + 3'd1 == par_need) begin
                                par_have <= 3'd0;
                                phase    <= P_EXEC;
                                xs       <= X_NONE;
                            end else begin
                                par_have <= par_have + 3'd1;
                            end
                        end
                        2'd2: begin                               // reset
                            if (din[0]) begin
                                phase <= P_IDLE;
                                xs    <= X_NONE;
                                irq   <= 1'b0;
                                drq   <= 1'b0;
                            end
                        end
                        default: ;
                    endcase
                end
            end

            // ------------------------------------------------- the command
            if (phase == P_EXEC && xs == X_NONE) begin
                case (cmd[5:0])
                    6'h35: begin                                  // specify
                        case (par0)
                            8'h10, 8'h18: begin
                                if (par0[3]) pcn1 <= par3;
                                else         pcn0 <= par3;
                            end
                            default: ;                            // rates: no effect here
                        endcase
                        xs <= X_DONE;
                        result <= ERR_NONE;
                        phase  <= P_IDLE;                         // no result phase
                    end
                    6'h3A: begin                                  // write special
                        case (par0)
                            8'h06: scan_sec <= par1;
                            8'h12: pcn0 <= par1;
                            8'h17: moder <= par1 | 8'hC0;
                            8'h1A: pcn1 <= par1;
                            8'h23: oport <= par1 & 8'h3F;
                            default: ;
                        endcase
                        xs <= X_DONE;
                        phase <= P_IDLE;
                    end
                    6'h3D: begin                                  // read special
                        case (par0)
                            8'h06:   result <= scan_sec;
                            8'h12:   result <= pcn0;
                            8'h17:   result <= moder;
                            8'h1A:   result <= pcn1;
                            8'h22:   result <= drive_status;
                            8'h23:   result <= {cmd[7:6], oport[5:0]};
                            default: result <= 8'h00;
                        endcase
                        xs <= X_DONE;
                        // the command ends here: DFS reads the status as 00
                        // and then takes the result register, so there is no
                        // result phase and no interrupt (traced in MAME)
                        phase <= P_IDLE;
                    end
                    6'h2C: begin                                  // drive status
                        result <= drive_status;
                        xs <= X_DONE;
                        phase <= P_IDLE;                          // as above
                    end
                    6'h29: begin                                  // seek
                        trk <= par0;
                        xs  <= X_SEEK;
                        // the head takes STEP_US a track, and none at all
                        // when it is already there, which is what the first
                        // seek of a boot does
                        us_left <= 16'(STEP_US) *
                                   {8'd0, ((par0 > cur_pcn) ? (par0 - cur_pcn)
                                                            : (cur_pcn - par0))};
                    end
                    6'h13, 6'h17, 6'h12, 6'h16: begin             // read data
                        if (!(sel_drive ? ready1 : ready0)) begin
                            result <= ERR_NR;
                            xs     <= X_DONE;
                            phase  <= P_RESULT;
                            irq    <= 1'b1;
                        end else begin
                            trk      <= par0;
                            sec      <= par1;
                            sec_left <= cmd[0] ? (par2 & 8'h1F) : 8'd1;
                            byte_left <= cmd[0] ? sec_size(par2[7:5]) : 9'd256;
                            cur_addr <= sector_addr(par0, par1, side,
                                                    img_dsided[cmd[7]]);
                            us_left  <= 16'(BYTE_US);
                            xs       <= X_RD_WAIT;
                        end
                    end
                    6'h0B, 6'h0F, 6'h0A, 6'h0E: begin             // write data
                        if (!(sel_drive ? ready1 : ready0)) begin
                            result <= ERR_NR;
                            xs     <= X_DONE;
                            phase  <= P_RESULT;
                            irq    <= 1'b1;
                        end else begin
                            trk      <= par0;
                            sec      <= par1;
                            sec_left <= cmd[0] ? (par2 & 8'h1F) : 8'd1;
                            byte_left <= cmd[0] ? sec_size(par2[7:5]) : 9'd256;
                            cur_addr <= sector_addr(par0, par1, side,
                                                    img_dsided[cmd[7]]);
                            us_left  <= 16'(BYTE_US);
                            xs       <= X_WR_ASK;
                        end
                    end
                    default: begin
                        // Anything else is not implemented, and says so: an
                        // unimplemented command that returned success would
                        // be invisible until something depended on it.
                        result <= ERR_NF;
                        xs     <= X_DONE;
                        phase  <= P_RESULT;
                        irq    <= 1'b1;
                    end
                endcase
            end

            // ------------------------------------------------- the machine
            if (cen_1us && us_left != 16'd0) us_left <= us_left - 16'd1;

            case (xs)
                X_SEEK: if (us_left == 16'd0) begin
                    if (sel_drive) pcn1 <= trk; else pcn0 <= trk;
                    result <= ERR_NONE;
                    phase  <= P_RESULT;
                    irq    <= 1'b1;
                    xs     <= X_DONE;
                end

                // one byte every BYTE_US, as the disc turns
                X_RD_WAIT: if (us_left == 16'd0) begin
                    if (drq) begin
                        // the CPU did not take the last byte in time; the
                        // real chip gives up here and says why
                        result <= ERR_DMA;
                        phase  <= P_RESULT;
                        irq    <= 1'b1;
                        xs     <= X_DONE;
                    end else begin
                        img_req <= 1'b1;
                        img_we  <= 1'b0;
                        xs      <= X_RD_FETCH;
                    end
                end
                X_RD_FETCH: if (img_ack) begin
                    img_req  <= 1'b0;
                    data_reg <= img_rdata;
                    drq      <= 1'b1;
                    xs       <= X_RD_NEXT;
                end
                X_RD_NEXT: begin
                    us_left  <= 16'(BYTE_US);
                    cur_addr <= cur_addr + 20'd1;
                    if (byte_left == 9'd1) begin
                        if (sec_left == 8'd1) begin
                            xs <= X_RD_OFFER;          // wait for the last byte
                        end else begin
                            sec_left  <= sec_left - 8'd1;
                            sec       <= sec + 8'd1;
                            byte_left <= 9'd256;
                            xs        <= X_RD_WAIT;
                        end
                    end else begin
                        byte_left <= byte_left - 9'd1;
                        xs        <= X_RD_WAIT;
                    end
                end
                // The last byte has been taken.  Both the data request and
                // the completion interrupt are wired to the CPU's NMI, and a
                // 6502 takes an NMI on an EDGE -- so the line has to be seen
                // low between the two.  Asserted a clock after the request
                // cleared, the low lasts 10 ns and the CPU, which samples NMI
                // once per cycle, never sees it: DFS read the catalogue, got
                // no completion interrupt, and the boot stopped there with
                // the controller still holding its result.  The real chip
                // takes microseconds to finish a sector; so does this.
                X_RD_OFFER: if (!drq) begin
                    us_left <= 16'(END_US);
                    xs      <= X_END;
                end
                X_END: if (us_left == 16'd0) begin
                    result <= ERR_NONE;
                    phase  <= P_RESULT;
                    irq    <= 1'b1;
                    xs     <= X_DONE;
                end

                X_WR_ASK: if (us_left == 16'd0) begin
                    drq <= 1'b1;
                    xs  <= X_WR_WAIT;
                end
                X_WR_WAIT: if (!drq) begin             // the CPU supplied it
                    img_req <= 1'b1;
                    img_we  <= 1'b1;
                    xs      <= X_WR_STORE;
                end
                X_WR_STORE: if (img_ack) begin
                    img_req <= 1'b0;
                    img_we  <= 1'b0;
                    xs      <= X_WR_NEXT;
                end
                X_WR_NEXT: begin
                    us_left  <= 16'(BYTE_US);
                    cur_addr <= cur_addr + 20'd1;
                    if (byte_left == 9'd1) begin
                        if (sec_left == 8'd1) begin
                            us_left <= 16'(END_US);   // the same gap, and why
                            xs      <= X_END;
                        end else begin
                            sec_left  <= sec_left - 8'd1;
                            sec       <= sec + 8'd1;
                            byte_left <= 9'd256;
                            xs        <= X_WR_ASK;
                        end
                    end else begin
                        byte_left <= byte_left - 9'd1;
                        xs        <= X_WR_ASK;
                    end
                end
                default: ;
            endcase
        end
    end

    wire _unused = &{1'b0, din[7:6], trk, 1'b0};
endmodule

`default_nettype wire

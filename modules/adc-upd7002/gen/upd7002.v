module upd7002
  (input  clk,
   input  cpu_clken,
   input  mhz1_clken,
   input  reset_n,
   input  cs,
   input  r_nw,
   input  [1:0] addr,
   input  [7:0] di,
   output [7:0] \do ,
   output eoc_n,
   input  [11:0] ch0,
   input  [11:0] ch1,
   input  [11:0] ch2,
   input  [11:0] ch3);
  wire [1:0] mux;
  wire mode;
  wire flag;
  wire [11:0] value;
  wire busy_n;
  wire completed_n;
  wire [13:0] counter;
  wire n4;
  wire n6;
  wire n7;
  wire n9;
  wire n10;
  wire [1:0] n11;
  wire n12;
  wire n13;
  wire n14;
  wire n15;
  wire [13:0] n18;
  wire n23;
  wire n25;
  wire [13:0] n26;
  wire n27;
  wire n28;
  wire n29;
  wire n30;
  wire n31;
  wire n32;
  wire n33;
  wire [13:0] n35;
  wire n37;
  wire n39;
  wire n41;
  wire n42;
  wire n43;
  wire [13:0] n44;
  wire n45;
  wire n46;
  wire n47;
  wire n69;
  wire [1:0] n70;
  wire [1:0] n71;
  wire [3:0] n72;
  wire [4:0] n73;
  wire [5:0] n74;
  wire [7:0] n75;
  wire n77;
  wire [7:0] n78;
  wire n80;
  wire [3:0] n81;
  wire [7:0] n83;
  wire n85;
  wire [2:0] n86;
  reg [7:0] n88;
  wire [7:0] n90;
  wire n94;
  wire [11:0] n95;
  wire n97;
  wire [11:0] n98;
  wire n100;
  wire [11:0] n101;
  wire [1:0] n102;
  reg [1:0] n103;
  wire n104;
  reg n105;
  wire n106;
  reg n107;
  reg n108;
  reg n109;
  reg [13:0] n110;
  assign \do  = n90; //(module output)
  assign eoc_n = completed_n; //(module output)
  /*# upd7002.vhd:30:8 */
  assign mux = n103; // (signal)
  /*# upd7002.vhd:31:8 */
  assign mode = n105; // (signal)
  /*# upd7002.vhd:32:8 */
  assign flag = n107; // (signal)
  /*# upd7002.vhd:33:8 */
  assign value = n95; // (signal)
  /*# upd7002.vhd:34:8 */
  assign busy_n = n108; // (signal)
  /*# upd7002.vhd:35:8 */
  assign completed_n = n109; // (signal)
  /*# upd7002.vhd:36:8 */
  assign counter = n110; // (signal)
  /*# upd7002.vhd:42:20 */
  assign n4 = ~reset_n;
  /*# upd7002.vhd:52:38 */
  assign n6 = ~r_nw;
  /*# upd7002.vhd:52:29 */
  assign n7 = n6 & cs;
  /*# upd7002.vhd:52:53 */
  assign n9 = addr == 2'b00;
  /*# upd7002.vhd:52:44 */
  assign n10 = n9 & n7;
  /*# upd7002.vhd:55:39 */
  assign n11 = di[1:0]; // extract
  /*# upd7002.vhd:56:39 */
  assign n12 = di[2]; // extract
  /*# upd7002.vhd:57:39 */
  assign n13 = di[3]; // extract
  /*# upd7002.vhd:58:26 */
  assign n14 = di[3]; // extract
  /*# upd7002.vhd:58:30 */
  assign n15 = ~n14;
  /*# upd7002.vhd:58:21 */
  assign n18 = n15 ? 14'b00111110100000 : 14'b10011100010000;
  /*# upd7002.vhd:50:13 */
  assign n23 = n30 ? 1'b0 : busy_n;
  /*# upd7002.vhd:50:13 */
  assign n25 = n31 ? 1'b1 : completed_n;
  /*# upd7002.vhd:50:13 */
  assign n26 = n32 ? n18 : counter;
  /*# upd7002.vhd:50:13 */
  assign n27 = n10 & cpu_clken;
  /*# upd7002.vhd:50:13 */
  assign n28 = n10 & cpu_clken;
  /*# upd7002.vhd:50:13 */
  assign n29 = n10 & cpu_clken;
  /*# upd7002.vhd:50:13 */
  assign n30 = n10 & cpu_clken;
  /*# upd7002.vhd:50:13 */
  assign n31 = n10 & cpu_clken;
  /*# upd7002.vhd:50:13 */
  assign n32 = n10 & cpu_clken;
  /*# upd7002.vhd:66:27 */
  assign n33 = ~busy_n;
  /*# upd7002.vhd:67:40 */
  assign n35 = counter - 14'b00000000000001;
  /*# upd7002.vhd:68:32 */
  assign n37 = counter == 14'b00000000000000;
  /*# upd7002.vhd:65:13 */
  assign n39 = n45 ? 1'b1 : n23;
  /*# upd7002.vhd:65:13 */
  assign n41 = n46 ? 1'b0 : n25;
  /*# upd7002.vhd:66:17 */
  assign n42 = n37 & n33;
  /*# upd7002.vhd:66:17 */
  assign n43 = n37 & n33;
  /*# upd7002.vhd:65:13 */
  assign n44 = n47 ? n35 : n26;
  /*# upd7002.vhd:65:13 */
  assign n45 = n42 & mhz1_clken;
  /*# upd7002.vhd:65:13 */
  assign n46 = n43 & mhz1_clken;
  /*# upd7002.vhd:65:13 */
  assign n47 = n33 & mhz1_clken;
  /*# upd7002.vhd:81:21 */
  assign n69 = r_nw & cs;
  /*# upd7002.vhd:85:39 */
  assign n70 = {completed_n, busy_n};
  /*# upd7002.vhd:85:55 */
  assign n71 = value[11:10]; // extract
  /*# upd7002.vhd:85:48 */
  assign n72 = {n70, n71};
  /*# upd7002.vhd:85:70 */
  assign n73 = {n72, mode};
  /*# upd7002.vhd:85:77 */
  assign n74 = {n73, flag};
  /*# upd7002.vhd:85:84 */
  assign n75 = {n74, mux};
  /*# upd7002.vhd:83:17 */
  assign n77 = addr == 2'b00;
  /*# upd7002.vhd:88:32 */
  assign n78 = value[11:4]; // extract
  /*# upd7002.vhd:86:17 */
  assign n80 = addr == 2'b01;
  /*# upd7002.vhd:91:32 */
  assign n81 = value[3:0]; // extract
  /*# upd7002.vhd:91:45 */
  assign n83 = {n81, 4'b0000};
  /*# upd7002.vhd:89:17 */
  assign n85 = addr == 2'b10;
  /*# upd7002.vhd:82:13 */
  assign n86 = {n85, n80, n77};
  /*# upd7002.vhd:82:13 */
  always @*
    case (n86)
      3'b100: n88 = n83;
      3'b010: n88 = n78;
      3'b001: n88 = n75;
      default: n88 = 8'b00000000;
    endcase
  /*# upd7002.vhd:81:9 */
  assign n90 = n69 ? n88 : 8'b00000000;
  /*# upd7002.vhd:98:27 */
  assign n94 = mux == 2'b00;
  /*# upd7002.vhd:98:18 */
  assign n95 = n94 ? ch0 : n98;
  /*# upd7002.vhd:99:27 */
  assign n97 = mux == 2'b01;
  /*# upd7002.vhd:98:34 */
  assign n98 = n97 ? ch1 : n101;
  /*# upd7002.vhd:100:27 */
  assign n100 = mux == 2'b10;
  /*# upd7002.vhd:99:34 */
  assign n101 = n100 ? ch2 : ch3;
  /*# upd7002.vhd:49:9 */
  assign n102 = n27 ? n11 : mux;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n103 <= 2'b00;
    else
      n103 <= n102;
  /*# upd7002.vhd:49:9 */
  assign n104 = n28 ? n13 : mode;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n105 <= 1'b0;
    else
      n105 <= n104;
  /*# upd7002.vhd:49:9 */
  assign n106 = n29 ? n12 : flag;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n107 <= 1'b0;
    else
      n107 <= n106;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n108 <= 1'b1;
    else
      n108 <= n39;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n109 <= 1'b1;
    else
      n109 <= n41;
  /*# upd7002.vhd:49:9 */
  always @(posedge clk or posedge n4)
    if (n4)
      n110 <= 14'b00000000000000;
    else
      n110 <= n44;
endmodule


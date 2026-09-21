module tone_generator_Bsyn
  (input  clk,
   input  clk_div16_en,
   input  reset,
   input  [9:0] freq,
   output audio_out);
  reg [9:0] n359_count;
  reg n359_tone;
  wire n364;
  wire n365;
  wire [9:0] n367;
  wire [9:0] n369;
  wire n372;
  wire [9:0] n381;
  reg [9:0] n382;
  wire n383;
  reg n384;
  assign audio_out = n384; //(module output)
  /*# sn76489.vhd:37:14 */
  always @*
    n359_count = n382; // (isignal)
  initial
    n359_count = 10'bX;
  /*# sn76489.vhd:38:14 */
  always @*
    n359_tone = n384; // (isignal)
  initial
    n359_tone = 1'bX;
  /*# sn76489.vhd:45:18 */
  assign n364 = $unsigned(n359_count) >= $unsigned(freq);
  /*# sn76489.vhd:46:19 */
  assign n365 = ~n359_tone;
  /*# sn76489.vhd:49:26 */
  assign n367 = n359_count + 10'b0000000001;
  /*# sn76489.vhd:45:9 */
  assign n369 = n364 ? 10'b0000000001 : n367;
  /*# sn76489.vhd:44:7 */
  assign n372 = n364 & clk_div16_en;
  /*# sn76489.vhd:43:5 */
  assign n381 = clk_div16_en ? n369 : n359_count;
  /*# sn76489.vhd:43:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n382 <= 10'b0000000001;
    else
      n382 <= n381;
  /*# sn76489.vhd:43:5 */
  assign n383 = n372 ? n365 : n359_tone;
  /*# sn76489.vhd:43:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n384 <= 1'b0;
    else
      n384 <= n383;
endmodule

module sn76489
  (input  clk,
   input  clk_en,
   input  reset,
   input  [7:0] d,
   input  we_n,
   input  ce_n,
   output [15:0] audio_out);
  wire [79:0] \reg ;
  wire clk_div16_en;
  wire [3:0] audio_d;
  reg [2:0] reg_a;
  reg [3:0] n2_count;
  wire n7;
  wire n10;
  wire [3:0] n12;
  wire n14;
  wire n26;
  wire n27;
  wire n28;
  wire n29;
  wire [2:0] n30;
  wire [2:0] n33;
  wire [3:0] n35;
  wire [2:0] n38;
  wire [5:0] n40;
  wire n43;
  wire n45;
  wire n46;
  wire n48;
  wire n49;
  wire [2:0] n51;
  wire [3:0] n53;
  reg [79:0] n55;
  wire [79:0] n56;
  wire n59;
  wire n60;
  wire n61;
  wire \gen_tone_gens_n1_tone_inst.audio_out ;
  wire [9:0] n68;
  wire \gen_tone_gens_n2_tone_inst.audio_out ;
  wire [9:0] n70;
  wire \gen_tone_gens_n3_tone_inst.audio_out ;
  wire [9:0] n72;
  reg [14:0] n74_noise_r;
  reg [6:0] n74_count;
  reg n74_noise_f_ref_r;
  wire [1:0] n81;
  wire [4:0] n82;
  wire n84;
  wire n86;
  wire [5:0] n87;
  wire n89;
  wire n91;
  wire n93;
  wire n95;
  wire n96;
  wire n97;
  wire n98;
  wire [2:0] n99;
  reg n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire [13:0] n106;
  wire [14:0] n107;
  wire [14:0] n108;
  wire [6:0] n110;
  wire n111;
  wire n112;
  wire n118;
  wire n119;
  wire n120;
  wire [31:0] n121;
  wire n123;
  wire n124;
  wire [14:0] n126;
  wire n127;
  wire n139;
  wire n140;
  wire n146;
  wire [3:0] n147;
  wire [15:0] n155;
  wire [15:0] n157;
  wire n158;
  wire [3:0] n159;
  wire [15:0] n166;
  wire [15:0] n168;
  wire n169;
  wire [3:0] n170;
  wire [15:0] n177;
  wire [15:0] n179;
  wire n180;
  wire [3:0] n181;
  wire [15:0] n188;
  wire [15:0] n190;
  wire [63:0] n191;
  wire [15:0] n192;
  wire [63:0] n193;
  wire [15:0] n194;
  wire [15:0] n195;
  wire [63:0] n196;
  wire [15:0] n197;
  wire [15:0] n198;
  wire [63:0] n199;
  wire [15:0] n200;
  wire [15:0] n201;
  wire [3:0] n204;
  wire [79:0] n205;
  reg [79:0] n206;
  wire n207;
  wire n208;
  reg n209;
  wire n210;
  wire n211;
  wire [2:0] n212;
  reg [2:0] n213;
  wire [3:0] n214;
  reg [3:0] n215;
  reg [14:0] n216;
  wire [6:0] n217;
  reg [6:0] n218;
  wire n219;
  wire n220;
  wire n221;
  reg n222;
  wire [13:0] n225; // mem_rd
  wire [13:0] n226; // mem_rd
  wire [13:0] n227; // mem_rd
  wire [13:0] n228; // mem_rd
  wire n229;
  wire n230;
  wire n231;
  wire n232;
  wire n233;
  wire n234;
  wire n235;
  wire n236;
  wire n237;
  wire n238;
  wire n239;
  wire n240;
  wire n241;
  wire n242;
  wire n243;
  wire n244;
  wire n245;
  wire n246;
  wire [3:0] n247;
  wire [3:0] n248;
  wire [5:0] n249;
  wire [3:0] n250;
  wire [3:0] n251;
  wire [5:0] n252;
  wire [3:0] n253;
  wire [3:0] n254;
  wire [5:0] n255;
  wire [3:0] n256;
  wire [3:0] n257;
  wire [5:0] n258;
  wire [3:0] n259;
  wire [3:0] n260;
  wire [5:0] n261;
  wire [3:0] n262;
  wire [3:0] n263;
  wire [5:0] n264;
  wire [3:0] n265;
  wire [3:0] n266;
  wire [5:0] n267;
  wire [3:0] n268;
  wire [3:0] n269;
  wire [5:0] n270;
  wire [79:0] n271;
  wire n272;
  wire n273;
  wire n274;
  wire n275;
  wire n276;
  wire n277;
  wire n278;
  wire n279;
  wire n280;
  wire n281;
  wire n282;
  wire n283;
  wire n284;
  wire n285;
  wire n286;
  wire n287;
  wire n288;
  wire n289;
  wire [3:0] n290;
  wire [5:0] n291;
  wire [5:0] n292;
  wire [3:0] n293;
  wire [5:0] n294;
  wire [5:0] n295;
  wire [3:0] n296;
  wire [5:0] n297;
  wire [5:0] n298;
  wire [3:0] n299;
  wire [5:0] n300;
  wire [5:0] n301;
  wire [3:0] n302;
  wire [5:0] n303;
  wire [5:0] n304;
  wire [3:0] n305;
  wire [5:0] n306;
  wire [5:0] n307;
  wire [3:0] n308;
  wire [5:0] n309;
  wire [5:0] n310;
  wire [3:0] n311;
  wire [5:0] n312;
  wire [5:0] n313;
  wire [79:0] n314;
  wire n315;
  wire n316;
  wire n317;
  wire n318;
  wire n319;
  wire n320;
  wire n321;
  wire n322;
  wire n323;
  wire n324;
  wire n325;
  wire n326;
  wire n327;
  wire n328;
  wire n329;
  wire n330;
  wire n331;
  wire n332;
  wire [3:0] n333;
  wire [3:0] n334;
  wire [5:0] n335;
  wire [3:0] n336;
  wire [3:0] n337;
  wire [5:0] n338;
  wire [3:0] n339;
  wire [3:0] n340;
  wire [5:0] n341;
  wire [3:0] n342;
  wire [3:0] n343;
  wire [5:0] n344;
  wire [3:0] n345;
  wire [3:0] n346;
  wire [5:0] n347;
  wire [3:0] n348;
  wire [3:0] n349;
  wire [5:0] n350;
  wire [3:0] n351;
  wire [3:0] n352;
  wire [5:0] n353;
  wire [3:0] n354;
  wire [3:0] n355;
  wire [5:0] n356;
  wire [79:0] n357;
  assign audio_out = n201; //(module output)
  /*# sn76489.vhd:87:10 */
  assign \reg  = n206; // (signal)
  /*# sn76489.vhd:97:10 */
  assign clk_div16_en = n209; // (signal)
  /*# sn76489.vhd:98:10 */
  assign audio_d = n204; // (signal)
  /*# sn76489.vhd:107:19 */
  always @*
    reg_a = n213; // (isignal)
  initial
    reg_a = 3'b000;
  /*# sn76489.vhd:112:14 */
  always @*
    n2_count = n215; // (isignal)
  initial
    n2_count = 4'b0000;
  /*# sn76489.vhd:119:18 */
  assign n7 = n2_count == 4'b0000;
  /*# sn76489.vhd:119:9 */
  assign n10 = n7 ? 1'b1 : 1'b0;
  /*# sn76489.vhd:122:24 */
  assign n12 = n2_count + 4'b0001;
  /*# sn76489.vhd:118:7 */
  assign n14 = clk_en ? n10 : 1'b0;
  /*# sn76489.vhd:138:17 */
  assign n26 = ~ce_n;
  /*# sn76489.vhd:138:32 */
  assign n27 = ~we_n;
  /*# sn76489.vhd:138:23 */
  assign n28 = n27 & n26;
  /*# sn76489.vhd:139:15 */
  assign n29 = d[7]; // extract
  /*# sn76489.vhd:140:36 */
  assign n30 = d[6:4]; // extract
  /*# sn76489.vhd:142:17 */
  assign n33 = 3'b111 - n30;
  /*# sn76489.vhd:142:40 */
  assign n35 = d[3:0]; // extract
  /*# sn76489.vhd:146:21 */
  assign n38 = 3'b111 - reg_a;
  /*# sn76489.vhd:146:44 */
  assign n40 = d[5:0]; // extract
  /*# sn76489.vhd:145:15 */
  assign n43 = reg_a == 3'b000;
  /*# sn76489.vhd:145:28 */
  assign n45 = reg_a == 3'b010;
  /*# sn76489.vhd:145:28 */
  assign n46 = n43 | n45;
  /*# sn76489.vhd:145:38 */
  assign n48 = reg_a == 3'b100;
  /*# sn76489.vhd:145:38 */
  assign n49 = n46 | n48;
  /*# sn76489.vhd:150:21 */
  assign n51 = 3'b111 - reg_a;
  /*# sn76489.vhd:150:44 */
  assign n53 = d[3:0]; // extract
  /*# sn76489.vhd:144:13 */
  always @*
    case (n49)
      1'b1: n55 = n314;
      default: n55 = n357;
    endcase
  /*# sn76489.vhd:139:11 */
  assign n56 = n29 ? n271 : n55;
  /*# sn76489.vhd:138:9 */
  assign n59 = n29 & n28;
  /*# sn76489.vhd:136:7 */
  assign n60 = n28 & clk_en;
  /*# sn76489.vhd:136:7 */
  assign n61 = n59 & clk_en;
  /*# sn76489.vhd:160:5 */
  tone_generator_Bsyn gen_tone_gens_n1_tone_inst (
    .clk(clk),
    .clk_div16_en(clk_div16_en),
    .reset(reset),
    .freq(n68),
    .audio_out(\gen_tone_gens_n1_tone_inst.audio_out ));
  /*# sn76489.vhd:167:31 */
  assign n68 = \reg [79:70]; // extract
  /*# sn76489.vhd:160:5 */
  tone_generator_Bsyn gen_tone_gens_n2_tone_inst (
    .clk(clk),
    .clk_div16_en(clk_div16_en),
    .reset(reset),
    .freq(n70),
    .audio_out(\gen_tone_gens_n2_tone_inst.audio_out ));
  /*# sn76489.vhd:167:31 */
  assign n70 = \reg [59:50]; // extract
  /*# sn76489.vhd:160:5 */
  tone_generator_Bsyn gen_tone_gens_n3_tone_inst (
    .clk(clk),
    .clk_div16_en(clk_div16_en),
    .reset(reset),
    .freq(n72),
    .audio_out(\gen_tone_gens_n3_tone_inst.audio_out ));
  /*# sn76489.vhd:167:31 */
  assign n72 = \reg [39:30]; // extract
  /*# sn76489.vhd:176:14 */
  always @*
    n74_noise_r = n216; // (isignal)
  initial
    n74_noise_r = 15'bX;
  /*# sn76489.vhd:177:14 */
  always @*
    n74_count = n218; // (isignal)
  initial
    n74_count = 7'bX;
  /*# sn76489.vhd:178:14 */
  always @*
    n74_noise_f_ref_r = n222; // (isignal)
  initial
    n74_noise_f_ref_r = 1'bX;
  /*# sn76489.vhd:188:28 */
  assign n81 = \reg [11:10]; // extract
  /*# sn76489.vhd:190:27 */
  assign n82 = n74_count[4:0]; // extract
  /*# sn76489.vhd:190:51 */
  assign n84 = n82 == 5'b00000;
  /*# sn76489.vhd:189:11 */
  assign n86 = n81 == 2'b00;
  /*# sn76489.vhd:192:27 */
  assign n87 = n74_count[5:0]; // extract
  /*# sn76489.vhd:192:51 */
  assign n89 = n87 == 6'b000000;
  /*# sn76489.vhd:191:11 */
  assign n91 = n81 == 2'b01;
  /*# sn76489.vhd:194:49 */
  assign n93 = n74_count == 7'b0000000;
  /*# sn76489.vhd:193:11 */
  assign n95 = n81 == 2'b10;
  /*# sn76489.vhd:101:9 */
  assign n96 = audio_d[1]; // extract
  /*# sn76489.vhd:197:58 */
  assign n97 = ~n74_noise_f_ref_r;
  /*# sn76489.vhd:197:40 */
  assign n98 = n97 & n96;
  /*# sn76489.vhd:188:9 */
  assign n99 = {n95, n91, n86};
  /*# sn76489.vhd:188:9 */
  always @*
    case (n99)
      3'b100: n100 = n93;
      3'b010: n100 = n89;
      3'b001: n100 = n84;
      default: n100 = n98;
    endcase
  /*# sn76489.vhd:201:30 */
  assign n101 = n74_noise_r[1]; // extract
  /*# sn76489.vhd:201:53 */
  assign n102 = \reg [12]; // extract
  /*# sn76489.vhd:201:68 */
  assign n103 = n74_noise_r[0]; // extract
  /*# sn76489.vhd:201:57 */
  assign n104 = n102 & n103;
  /*# sn76489.vhd:201:34 */
  assign n105 = n101 ^ n104;
  /*# sn76489.vhd:201:83 */
  assign n106 = n74_noise_r[14:1]; // extract
  /*# sn76489.vhd:201:74 */
  assign n107 = {n105, n106};
  /*# sn76489.vhd:187:7 */
  assign n108 = n112 ? n107 : n74_noise_r;
  /*# sn76489.vhd:203:24 */
  assign n110 = n74_count + 7'b0000001;
  /*# sn76489.vhd:101:9 */
  assign n111 = audio_d[1]; // extract
  /*# sn76489.vhd:187:7 */
  assign n112 = n100 & clk_div16_en;
  /*# sn76489.vhd:209:17 */
  assign n118 = ~ce_n;
  /*# sn76489.vhd:209:32 */
  assign n119 = ~we_n;
  /*# sn76489.vhd:209:23 */
  assign n120 = n119 & n118;
  /*# sn76489.vhd:209:48 */
  assign n121 = {29'b0, reg_a};  // uext
  /*# sn76489.vhd:209:48 */
  assign n123 = n121 == 32'b00000000000000000000000000000110;
  /*# sn76489.vhd:209:38 */
  assign n124 = n123 & n120;
  /*# sn76489.vhd:208:7 */
  assign n126 = n127 ? 15'b100000000000000 : n108;
  /*# sn76489.vhd:208:7 */
  assign n127 = n124 & clk_en;
  /*# sn76489.vhd:217:30 */
  assign n139 = n216[0]; // extract
  /*# sn76489.vhd:217:19 */
  assign n140 = ~n139;
  /*# sn76489.vhd:249:19 */
  assign n146 = audio_d[3]; // extract
  /*# sn76489.vhd:250:56 */
  assign n147 = \reg [63:60]; // extract
  /*# sn76489.vhd:250:25 */
  assign n155 = {2'b00, n228};
  /*# sn76489.vhd:249:9 */
  assign n157 = n146 ? n155 : 16'b0000000000000000;
  /*# sn76489.vhd:249:19 */
  assign n158 = audio_d[2]; // extract
  /*# sn76489.vhd:250:56 */
  assign n159 = \reg [43:40]; // extract
  /*# sn76489.vhd:250:25 */
  assign n166 = {2'b00, n227};
  /*# sn76489.vhd:249:9 */
  assign n168 = n158 ? n166 : 16'b0000000000000000;
  /*# sn76489.vhd:249:19 */
  assign n169 = audio_d[1]; // extract
  /*# sn76489.vhd:250:56 */
  assign n170 = \reg [23:20]; // extract
  /*# sn76489.vhd:250:25 */
  assign n177 = {2'b00, n226};
  /*# sn76489.vhd:249:9 */
  assign n179 = n169 ? n177 : 16'b0000000000000000;
  /*# sn76489.vhd:249:19 */
  assign n180 = audio_d[0]; // extract
  /*# sn76489.vhd:250:56 */
  assign n181 = \reg [3:0]; // extract
  /*# sn76489.vhd:250:25 */
  assign n188 = {2'b00, n225};
  /*# sn76489.vhd:249:9 */
  assign n190 = n180 ? n188 : 16'b0000000000000000;
  /*# sn76489.vhd:245:16 */
  assign n191 = {n157, n168, n179, n190};
  /*# sn76489.vhd:256:24 */
  assign n192 = n191[63:48]; // extract
  /*# sn76489.vhd:245:16 */
  assign n193 = {n157, n168, n179, n190};
  /*# sn76489.vhd:256:32 */
  assign n194 = n193[47:32]; // extract
  /*# sn76489.vhd:256:28 */
  assign n195 = n192 + n194;
  /*# sn76489.vhd:245:16 */
  assign n196 = {n157, n168, n179, n190};
  /*# sn76489.vhd:256:40 */
  assign n197 = n196[31:16]; // extract
  /*# sn76489.vhd:256:36 */
  assign n198 = n195 + n197;
  /*# sn76489.vhd:245:16 */
  assign n199 = {n157, n168, n179, n190};
  /*# sn76489.vhd:256:48 */
  assign n200 = n199[15:0]; // extract
  /*# sn76489.vhd:256:44 */
  assign n201 = n198 + n200;
  /*# sn76489.vhd:98:10 */
  assign n204 = {\gen_tone_gens_n1_tone_inst.audio_out , \gen_tone_gens_n2_tone_inst.audio_out , \gen_tone_gens_n3_tone_inst.audio_out , n140};
  /*# sn76489.vhd:135:5 */
  assign n205 = n60 ? n56 : \reg ;
  /*# sn76489.vhd:135:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n206 <= 80'b11111111111111111111111111111111111111111111111111111111111111111111111111111111;
    else
      n206 <= n205;
  /*# sn76489.vhd:97:10 */
  assign n207 = ~reset;
  /*# sn76489.vhd:116:5 */
  assign n208 = n207 ? n14 : clk_div16_en;
  /*# sn76489.vhd:116:5 */
  always @(posedge clk)
    n209 <= n208;
  /*# sn76489.vhd:107:19 */
  assign n210 = ~reset;
  /*# sn76489.vhd:107:19 */
  assign n211 = n61 & n210;
  /*# sn76489.vhd:135:5 */
  assign n212 = n211 ? n30 : reg_a;
  /*# sn76489.vhd:135:5 */
  always @(posedge clk)
    n213 <= n212;
  initial
    n213 = 3'b000;
  /*# sn76489.vhd:116:5 */
  assign n214 = clk_en ? n12 : n2_count;
  /*# sn76489.vhd:116:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n215 <= 4'b0000;
    else
      n215 <= n214;
  /*# sn76489.vhd:185:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n216 <= 15'b100000000000000;
    else
      n216 <= n126;
  /*# sn76489.vhd:185:5 */
  assign n217 = clk_div16_en ? n110 : n74_count;
  /*# sn76489.vhd:185:5 */
  always @(posedge clk or posedge reset)
    if (reset)
      n218 <= 7'b0000000;
    else
      n218 <= n217;
  /*# sn76489.vhd:178:14 */
  assign n219 = ~reset;
  /*# sn76489.vhd:178:14 */
  assign n220 = clk_div16_en & n219;
  /*# sn76489.vhd:185:5 */
  assign n221 = n220 ? n111 : n74_noise_f_ref_r;
  /*# sn76489.vhd:185:5 */
  always @(posedge clk)
    n222 <= n221;
  /*# sn76489.vhd:250:33 */
  reg [13:0] n223[15:0] ; // memory
  initial begin
    n223[15] = 14'b00000000000000;
    n223[14] = 14'b00001010001100;
    n223[13] = 14'b00001100110101;
    n223[12] = 14'b00010000001010;
    n223[11] = 14'b00010100010101;
    n223[10] = 14'b00011001100110;
    n223[9] = 14'b00100000001111;
    n223[8] = 14'b00101000100101;
    n223[7] = 14'b00110011000101;
    n223[6] = 14'b01000000010011;
    n223[5] = 14'b01010000111101;
    n223[4] = 14'b01100101111011;
    n223[3] = 14'b10000000010011;
    n223[2] = 14'b10100001100010;
    n223[1] = 14'b11001011010110;
    n223[0] = 14'b11111111111111;
    end
  assign n225 = n223[n181];
  assign n226 = n223[n170];
  assign n227 = n223[n159];
  assign n228 = n223[n147];
  /*# sn76489.vhd:250:33 */
  /*# sn76489.vhd:250:33 */
  /*# sn76489.vhd:250:33 */
  /*# sn76489.vhd:250:33 */
  /*# sn76489.vhd:142:13 */
  assign n229 = n33[2]; // extract
  /*# sn76489.vhd:142:13 */
  assign n230 = ~n229;
  /*# sn76489.vhd:142:13 */
  assign n231 = n33[1]; // extract
  /*# sn76489.vhd:142:13 */
  assign n232 = ~n231;
  /*# sn76489.vhd:142:13 */
  assign n233 = n230 & n232;
  /*# sn76489.vhd:142:13 */
  assign n234 = n230 & n231;
  /*# sn76489.vhd:142:13 */
  assign n235 = n229 & n232;
  /*# sn76489.vhd:142:13 */
  assign n236 = n229 & n231;
  /*# sn76489.vhd:142:13 */
  assign n237 = n33[0]; // extract
  /*# sn76489.vhd:142:13 */
  assign n238 = ~n237;
  /*# sn76489.vhd:142:13 */
  assign n239 = n233 & n238;
  /*# sn76489.vhd:142:13 */
  assign n240 = n233 & n237;
  /*# sn76489.vhd:142:13 */
  assign n241 = n234 & n238;
  /*# sn76489.vhd:142:13 */
  assign n242 = n234 & n237;
  /*# sn76489.vhd:142:13 */
  assign n243 = n235 & n238;
  /*# sn76489.vhd:142:13 */
  assign n244 = n235 & n237;
  /*# sn76489.vhd:142:13 */
  assign n245 = n236 & n238;
  /*# sn76489.vhd:142:13 */
  assign n246 = n236 & n237;
  /*# sn76489.vhd:142:13 */
  assign n247 = \reg [3:0]; // extract
  /*# sn76489.vhd:142:13 */
  assign n248 = n239 ? n35 : n247;
  /*# sn76489.vhd:142:13 */
  assign n249 = \reg [9:4]; // extract
  /*# sn76489.vhd:142:13 */
  assign n250 = \reg [13:10]; // extract
  /*# sn76489.vhd:142:13 */
  assign n251 = n240 ? n35 : n250;
  /*# sn76489.vhd:142:13 */
  assign n252 = \reg [19:14]; // extract
  /*# sn76489.vhd:142:13 */
  assign n253 = \reg [23:20]; // extract
  /*# sn76489.vhd:142:13 */
  assign n254 = n241 ? n35 : n253;
  /*# sn76489.vhd:142:13 */
  assign n255 = \reg [29:24]; // extract
  /*# sn76489.vhd:142:13 */
  assign n256 = \reg [33:30]; // extract
  /*# sn76489.vhd:142:13 */
  assign n257 = n242 ? n35 : n256;
  /*# sn76489.vhd:142:13 */
  assign n258 = \reg [39:34]; // extract
  /*# sn76489.vhd:142:13 */
  assign n259 = \reg [43:40]; // extract
  /*# sn76489.vhd:142:13 */
  assign n260 = n243 ? n35 : n259;
  /*# sn76489.vhd:142:13 */
  assign n261 = \reg [49:44]; // extract
  /*# sn76489.vhd:142:13 */
  assign n262 = \reg [53:50]; // extract
  /*# sn76489.vhd:142:13 */
  assign n263 = n244 ? n35 : n262;
  /*# sn76489.vhd:142:13 */
  assign n264 = \reg [59:54]; // extract
  /*# sn76489.vhd:142:13 */
  assign n265 = \reg [63:60]; // extract
  /*# sn76489.vhd:142:13 */
  assign n266 = n245 ? n35 : n265;
  /*# sn76489.vhd:142:13 */
  assign n267 = \reg [69:64]; // extract
  /*# sn76489.vhd:142:13 */
  assign n268 = \reg [73:70]; // extract
  /*# sn76489.vhd:142:13 */
  assign n269 = n246 ? n35 : n268;
  /*# sn76489.vhd:142:13 */
  assign n270 = \reg [79:74]; // extract
  /*# sn76489.vhd:142:13 */
  assign n271 = {n270, n269, n267, n266, n264, n263, n261, n260, n258, n257, n255, n254, n252, n251, n249, n248};
  /*# sn76489.vhd:146:17 */
  assign n272 = n38[2]; // extract
  /*# sn76489.vhd:146:17 */
  assign n273 = ~n272;
  /*# sn76489.vhd:146:17 */
  assign n274 = n38[1]; // extract
  /*# sn76489.vhd:146:17 */
  assign n275 = ~n274;
  /*# sn76489.vhd:146:17 */
  assign n276 = n273 & n275;
  /*# sn76489.vhd:146:17 */
  assign n277 = n273 & n274;
  /*# sn76489.vhd:146:17 */
  assign n278 = n272 & n275;
  /*# sn76489.vhd:146:17 */
  assign n279 = n272 & n274;
  /*# sn76489.vhd:146:17 */
  assign n280 = n38[0]; // extract
  /*# sn76489.vhd:146:17 */
  assign n281 = ~n280;
  /*# sn76489.vhd:146:17 */
  assign n282 = n276 & n281;
  /*# sn76489.vhd:146:17 */
  assign n283 = n276 & n280;
  /*# sn76489.vhd:146:17 */
  assign n284 = n277 & n281;
  /*# sn76489.vhd:146:17 */
  assign n285 = n277 & n280;
  /*# sn76489.vhd:146:17 */
  assign n286 = n278 & n281;
  /*# sn76489.vhd:146:17 */
  assign n287 = n278 & n280;
  /*# sn76489.vhd:146:17 */
  assign n288 = n279 & n281;
  /*# sn76489.vhd:146:17 */
  assign n289 = n279 & n280;
  /*# sn76489.vhd:146:17 */
  assign n290 = \reg [3:0]; // extract
  /*# sn76489.vhd:146:17 */
  assign n291 = \reg [9:4]; // extract
  /*# sn76489.vhd:146:17 */
  assign n292 = n282 ? n40 : n291;
  /*# sn76489.vhd:146:17 */
  assign n293 = \reg [13:10]; // extract
  /*# sn76489.vhd:146:17 */
  assign n294 = \reg [19:14]; // extract
  /*# sn76489.vhd:146:17 */
  assign n295 = n283 ? n40 : n294;
  /*# sn76489.vhd:146:17 */
  assign n296 = \reg [23:20]; // extract
  /*# sn76489.vhd:146:17 */
  assign n297 = \reg [29:24]; // extract
  /*# sn76489.vhd:146:17 */
  assign n298 = n284 ? n40 : n297;
  /*# sn76489.vhd:146:17 */
  assign n299 = \reg [33:30]; // extract
  /*# sn76489.vhd:146:17 */
  assign n300 = \reg [39:34]; // extract
  /*# sn76489.vhd:146:17 */
  assign n301 = n285 ? n40 : n300;
  /*# sn76489.vhd:146:17 */
  assign n302 = \reg [43:40]; // extract
  /*# sn76489.vhd:146:17 */
  assign n303 = \reg [49:44]; // extract
  /*# sn76489.vhd:146:17 */
  assign n304 = n286 ? n40 : n303;
  /*# sn76489.vhd:146:17 */
  assign n305 = \reg [53:50]; // extract
  /*# sn76489.vhd:146:17 */
  assign n306 = \reg [59:54]; // extract
  /*# sn76489.vhd:146:17 */
  assign n307 = n287 ? n40 : n306;
  /*# sn76489.vhd:146:17 */
  assign n308 = \reg [63:60]; // extract
  /*# sn76489.vhd:146:17 */
  assign n309 = \reg [69:64]; // extract
  /*# sn76489.vhd:146:17 */
  assign n310 = n288 ? n40 : n309;
  /*# sn76489.vhd:146:17 */
  assign n311 = \reg [73:70]; // extract
  /*# sn76489.vhd:146:17 */
  assign n312 = \reg [79:74]; // extract
  /*# sn76489.vhd:146:17 */
  assign n313 = n289 ? n40 : n312;
  /*# sn76489.vhd:146:17 */
  assign n314 = {n313, n311, n310, n308, n307, n305, n304, n302, n301, n299, n298, n296, n295, n293, n292, n290};
  /*# sn76489.vhd:150:17 */
  assign n315 = n51[2]; // extract
  /*# sn76489.vhd:150:17 */
  assign n316 = ~n315;
  /*# sn76489.vhd:150:17 */
  assign n317 = n51[1]; // extract
  /*# sn76489.vhd:150:17 */
  assign n318 = ~n317;
  /*# sn76489.vhd:150:17 */
  assign n319 = n316 & n318;
  /*# sn76489.vhd:150:17 */
  assign n320 = n316 & n317;
  /*# sn76489.vhd:150:17 */
  assign n321 = n315 & n318;
  /*# sn76489.vhd:150:17 */
  assign n322 = n315 & n317;
  /*# sn76489.vhd:150:17 */
  assign n323 = n51[0]; // extract
  /*# sn76489.vhd:150:17 */
  assign n324 = ~n323;
  /*# sn76489.vhd:150:17 */
  assign n325 = n319 & n324;
  /*# sn76489.vhd:150:17 */
  assign n326 = n319 & n323;
  /*# sn76489.vhd:150:17 */
  assign n327 = n320 & n324;
  /*# sn76489.vhd:150:17 */
  assign n328 = n320 & n323;
  /*# sn76489.vhd:150:17 */
  assign n329 = n321 & n324;
  /*# sn76489.vhd:150:17 */
  assign n330 = n321 & n323;
  /*# sn76489.vhd:150:17 */
  assign n331 = n322 & n324;
  /*# sn76489.vhd:150:17 */
  assign n332 = n322 & n323;
  /*# sn76489.vhd:150:17 */
  assign n333 = \reg [3:0]; // extract
  /*# sn76489.vhd:150:17 */
  assign n334 = n325 ? n53 : n333;
  /*# sn76489.vhd:150:17 */
  assign n335 = \reg [9:4]; // extract
  /*# sn76489.vhd:150:17 */
  assign n336 = \reg [13:10]; // extract
  /*# sn76489.vhd:150:17 */
  assign n337 = n326 ? n53 : n336;
  /*# sn76489.vhd:150:17 */
  assign n338 = \reg [19:14]; // extract
  /*# sn76489.vhd:150:17 */
  assign n339 = \reg [23:20]; // extract
  /*# sn76489.vhd:150:17 */
  assign n340 = n327 ? n53 : n339;
  /*# sn76489.vhd:150:17 */
  assign n341 = \reg [29:24]; // extract
  /*# sn76489.vhd:150:17 */
  assign n342 = \reg [33:30]; // extract
  /*# sn76489.vhd:150:17 */
  assign n343 = n328 ? n53 : n342;
  /*# sn76489.vhd:150:17 */
  assign n344 = \reg [39:34]; // extract
  /*# sn76489.vhd:150:17 */
  assign n345 = \reg [43:40]; // extract
  /*# sn76489.vhd:150:17 */
  assign n346 = n329 ? n53 : n345;
  /*# sn76489.vhd:150:17 */
  assign n347 = \reg [49:44]; // extract
  /*# sn76489.vhd:150:17 */
  assign n348 = \reg [53:50]; // extract
  /*# sn76489.vhd:150:17 */
  assign n349 = n330 ? n53 : n348;
  /*# sn76489.vhd:150:17 */
  assign n350 = \reg [59:54]; // extract
  /*# sn76489.vhd:150:17 */
  assign n351 = \reg [63:60]; // extract
  /*# sn76489.vhd:150:17 */
  assign n352 = n331 ? n53 : n351;
  /*# sn76489.vhd:150:17 */
  assign n353 = \reg [69:64]; // extract
  /*# sn76489.vhd:150:17 */
  assign n354 = \reg [73:70]; // extract
  /*# sn76489.vhd:150:17 */
  assign n355 = n332 ? n53 : n354;
  /*# sn76489.vhd:150:17 */
  assign n356 = \reg [79:74]; // extract
  /*# sn76489.vhd:150:17 */
  assign n357 = {n356, n355, n353, n352, n350, n349, n347, n346, n344, n343, n341, n340, n338, n337, n335, n334};
endmodule


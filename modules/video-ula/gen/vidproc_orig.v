module vidproc_orig
  (input  CLOCK,
   input  CPUCLKEN,
   input  CLKEN,
   input  nRESET,
   output CLKEN_CRTC,
   output [3:0] CLKEN_COUNT,
   output TTXT,
   input  VGA,
   input  ENABLE,
   input  A0,
   input  [7:0] DI_CPU,
   input  [7:0] DI_RAM,
   input  nINVERT,
   input  DISEN,
   input  CURSOR,
   input  R_IN,
   input  G_IN,
   input  B_IN,
   output R,
   output G,
   output B);
  wire r0_cursor0;
  wire r0_cursor1;
  wire r0_cursor2;
  wire r0_crtc_2mhz;
  wire [1:0] r0_pixel_rate;
  wire r0_teletext;
  wire r0_flash;
  wire [63:0] palette;
  wire [7:0] shiftreg;
  wire delayed_disen;
  wire clken_pixel;
  wire clken_fetch;
  reg [3:0] clken_counter;
  wire cursor_invert;
  wire cursor_invert1;
  wire cursor_invert2;
  wire cursor_active;
  wire [1:0] cursor_counter;
  wire rr;
  wire gg;
  wire bb;
  wire n9;
  wire n27;
  wire n28;
  wire n29;
  wire n30;
  wire n31;
  wire [1:0] n32;
  wire n33;
  wire n34;
  wire [3:0] n35;
  wire [3:0] n38;
  wire [3:0] n40;
  wire [63:0] n49;
  wire n50;
  wire n51;
  wire n52;
  wire n53;
  wire n54;
  wire n55;
  wire n56;
  wire n58;
  wire n59;
  wire n60;
  wire n61;
  wire n62;
  wire n63;
  wire n64;
  wire n65;
  wire [63:0] n88;
  wire n92;
  wire n93;
  wire n94;
  wire n95;
  wire n96;
  wire n98;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n107;
  wire n108;
  wire n109;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n127;
  wire n128;
  wire n129;
  wire n130;
  wire n131;
  wire n132;
  wire [3:0] n137;
  wire n143;
  wire [6:0] n145;
  wire [7:0] n147;
  wire [7:0] n148;
  wire n151;
  wire n159;
  wire n160;
  wire n161;
  wire n162;
  wire n163;
  wire n164;
  wire n165;
  wire n166;
  wire n167;
  wire n168;
  wire n169;
  wire n170;
  wire n171;
  wire n172;
  wire n173;
  wire n176;
  wire n178;
  wire n180;
  wire n183;
  wire n185;
  wire [1:0] n187;
  wire [1:0] n189;
  wire n192;
  wire n193;
  wire n208;
  wire n210;
  wire n211;
  wire [1:0] n212;
  wire n213;
  wire [2:0] n214;
  wire n215;
  wire [3:0] n216;
  wire [3:0] n219;
  wire n222;
  wire n223;
  wire n224;
  wire n225;
  wire n226;
  wire n227;
  wire n228;
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
  reg n287;
  wire n288;
  reg n289;
  wire n290;
  reg n291;
  wire n292;
  reg n293;
  wire [1:0] n294;
  reg [1:0] n295;
  wire n296;
  reg n297;
  wire n298;
  reg n299;
  wire [63:0] n300;
  reg [63:0] n301;
  wire [7:0] n302;
  reg [7:0] n303;
  wire n304;
  reg n305;
  wire [3:0] n306;
  reg [3:0] n307;
  wire n308;
  wire n309;
  wire n310;
  reg n311;
  wire n312;
  wire n313;
  wire n314;
  reg n315;
  wire n316;
  reg n317;
  wire [1:0] n318;
  reg [1:0] n319;
  wire n320;
  reg n321;
  wire n322;
  reg n323;
  wire n324;
  reg n325;
  wire n326;
  wire n327;
  wire n328;
  wire n329;
  wire n330;
  wire n331;
  wire n332;
  wire n333;
  wire n334;
  wire n335;
  wire n336;
  wire n337;
  wire n338;
  wire n339;
  wire n340;
  wire n341;
  wire n342;
  wire n343;
  wire n344;
  wire n345;
  wire n346;
  wire n347;
  wire n348;
  wire n349;
  wire n350;
  wire n351;
  wire n352;
  wire n353;
  wire n354;
  wire n355;
  wire n356;
  wire n357;
  wire n358;
  wire n359;
  wire n360;
  wire n361;
  wire [3:0] n362;
  wire [3:0] n363;
  wire [3:0] n364;
  wire [3:0] n365;
  wire [3:0] n366;
  wire [3:0] n367;
  wire [3:0] n368;
  wire [3:0] n369;
  wire [3:0] n370;
  wire [3:0] n371;
  wire [3:0] n372;
  wire [3:0] n373;
  wire [3:0] n374;
  wire [3:0] n375;
  wire [3:0] n376;
  wire [3:0] n377;
  wire [3:0] n378;
  wire [3:0] n379;
  wire [3:0] n380;
  wire [3:0] n381;
  wire [3:0] n382;
  wire [3:0] n383;
  wire [3:0] n384;
  wire [3:0] n385;
  wire [3:0] n386;
  wire [3:0] n387;
  wire [3:0] n388;
  wire [3:0] n389;
  wire [3:0] n390;
  wire [3:0] n391;
  wire [3:0] n392;
  wire [3:0] n393;
  wire [63:0] n394;
  wire [3:0] n395;
  assign CLKEN_CRTC = clken_fetch; //(module output)
  assign CLKEN_COUNT = clken_counter; //(module output)
  assign TTXT = r0_teletext; //(module output)
  assign R = n278; //(module output)
  assign G = n281; //(module output)
  assign B = n284; //(module output)
  /*# vidproc_orig.vhd:103:12 */
  assign r0_cursor0 = n287; // (signal)
  /*# vidproc_orig.vhd:104:12 */
  assign r0_cursor1 = n289; // (signal)
  /*# vidproc_orig.vhd:105:12 */
  assign r0_cursor2 = n291; // (signal)
  /*# vidproc_orig.vhd:106:12 */
  assign r0_crtc_2mhz = n293; // (signal)
  /*# vidproc_orig.vhd:107:12 */
  assign r0_pixel_rate = n295; // (signal)
  /*# vidproc_orig.vhd:108:12 */
  assign r0_teletext = n297; // (signal)
  /*# vidproc_orig.vhd:109:12 */
  assign r0_flash = n299; // (signal)
  /*# vidproc_orig.vhd:112:12 */
  assign palette = n301; // (signal)
  /*# vidproc_orig.vhd:115:12 */
  assign shiftreg = n303; // (signal)
  /*# vidproc_orig.vhd:117:12 */
  assign delayed_disen = n305; // (signal)
  /*# vidproc_orig.vhd:120:12 */
  assign clken_pixel = n93; // (signal)
  /*# vidproc_orig.vhd:121:12 */
  assign clken_fetch = n132; // (signal)
  /*# vidproc_orig.vhd:122:12 */
  always @*
    clken_counter = n307; // (isignal)
  initial
    clken_counter = 4'b0000;
  /*# vidproc_orig.vhd:127:12 */
  assign cursor_invert = n173; // (signal)
  /*# vidproc_orig.vhd:128:12 */
  assign cursor_invert1 = n311; // (signal)
  /*# vidproc_orig.vhd:129:12 */
  assign cursor_invert2 = n315; // (signal)
  /*# vidproc_orig.vhd:130:12 */
  assign cursor_active = n317; // (signal)
  /*# vidproc_orig.vhd:131:12 */
  assign cursor_counter = n319; // (signal)
  /*# vidproc_orig.vhd:133:12 */
  assign rr = n321; // (signal)
  /*# vidproc_orig.vhd:134:12 */
  assign gg = n323; // (signal)
  /*# vidproc_orig.vhd:135:12 */
  assign bb = n325; // (signal)
  /*# vidproc_orig.vhd:141:19 */
  assign n9 = ~nRESET;
  /*# vidproc_orig.vhd:161:27 */
  assign n27 = ~A0;
  /*# vidproc_orig.vhd:163:45 */
  assign n28 = DI_CPU[7]; // extract
  /*# vidproc_orig.vhd:164:45 */
  assign n29 = DI_CPU[6]; // extract
  /*# vidproc_orig.vhd:165:45 */
  assign n30 = DI_CPU[5]; // extract
  /*# vidproc_orig.vhd:166:47 */
  assign n31 = DI_CPU[4]; // extract
  /*# vidproc_orig.vhd:167:48 */
  assign n32 = DI_CPU[3:2]; // extract
  /*# vidproc_orig.vhd:168:46 */
  assign n33 = DI_CPU[1]; // extract
  /*# vidproc_orig.vhd:169:43 */
  assign n34 = DI_CPU[0]; // extract
  /*# vidproc_orig.vhd:172:59 */
  assign n35 = DI_CPU[7:4]; // extract
  /*# vidproc_orig.vhd:172:33 */
  assign n38 = 4'b1111 - n35;
  /*# vidproc_orig.vhd:172:84 */
  assign n40 = DI_CPU[3:0]; // extract
  /*# vidproc_orig.vhd:161:21 */
  assign n49 = n27 ? palette : n394;
  /*# vidproc_orig.vhd:160:17 */
  assign n50 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n51 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n52 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n53 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n54 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n55 = n27 & ENABLE;
  /*# vidproc_orig.vhd:160:17 */
  assign n56 = n27 & ENABLE;
  /*# vidproc_orig.vhd:159:13 */
  assign n58 = n50 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n59 = n51 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n60 = n52 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n61 = n53 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n62 = n54 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n63 = n55 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n64 = n56 & CPUCLKEN;
  /*# vidproc_orig.vhd:159:13 */
  assign n65 = ENABLE & CPUCLKEN;
  /*# vidproc_orig.vhd:141:9 */
  assign n88 = {4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000, 4'b0000};
  /*# vidproc_orig.vhd:184:88 */
  assign n92 = r0_pixel_rate == 2'b11;
  /*# vidproc_orig.vhd:184:69 */
  assign n93 = n92 ? CLKEN : n99;
  /*# vidproc_orig.vhd:185:37 */
  assign n94 = clken_counter[0]; // extract
  /*# vidproc_orig.vhd:185:20 */
  assign n95 = ~n94;
  /*# vidproc_orig.vhd:185:15 */
  assign n96 = CLKEN & n95;
  /*# vidproc_orig.vhd:185:88 */
  assign n98 = r0_pixel_rate == 2'b10;
  /*# vidproc_orig.vhd:184:95 */
  assign n99 = n98 ? n96 : n108;
  /*# vidproc_orig.vhd:186:37 */
  assign n100 = clken_counter[0]; // extract
  /*# vidproc_orig.vhd:186:20 */
  assign n101 = ~n100;
  /*# vidproc_orig.vhd:186:15 */
  assign n102 = CLKEN & n101;
  /*# vidproc_orig.vhd:186:64 */
  assign n103 = clken_counter[1]; // extract
  /*# vidproc_orig.vhd:186:47 */
  assign n104 = ~n103;
  /*# vidproc_orig.vhd:186:42 */
  assign n105 = n102 & n104;
  /*# vidproc_orig.vhd:186:88 */
  assign n107 = r0_pixel_rate == 2'b01;
  /*# vidproc_orig.vhd:185:95 */
  assign n108 = n107 ? n105 : n117;
  /*# vidproc_orig.vhd:187:37 */
  assign n109 = clken_counter[0]; // extract
  /*# vidproc_orig.vhd:187:20 */
  assign n110 = ~n109;
  /*# vidproc_orig.vhd:187:15 */
  assign n111 = CLKEN & n110;
  /*# vidproc_orig.vhd:187:64 */
  assign n112 = clken_counter[1]; // extract
  /*# vidproc_orig.vhd:187:47 */
  assign n113 = ~n112;
  /*# vidproc_orig.vhd:187:42 */
  assign n114 = n111 & n113;
  /*# vidproc_orig.vhd:187:91 */
  assign n115 = clken_counter[2]; // extract
  /*# vidproc_orig.vhd:187:74 */
  assign n116 = ~n115;
  /*# vidproc_orig.vhd:187:69 */
  assign n117 = n114 & n116;
  /*# vidproc_orig.vhd:192:37 */
  assign n118 = clken_counter[0]; // extract
  /*# vidproc_orig.vhd:192:20 */
  assign n119 = ~n118;
  /*# vidproc_orig.vhd:191:26 */
  assign n120 = CLKEN & n119;
  /*# vidproc_orig.vhd:192:64 */
  assign n121 = clken_counter[1]; // extract
  /*# vidproc_orig.vhd:192:47 */
  assign n122 = ~n121;
  /*# vidproc_orig.vhd:192:42 */
  assign n123 = n120 & n122;
  /*# vidproc_orig.vhd:192:91 */
  assign n124 = clken_counter[2]; // extract
  /*# vidproc_orig.vhd:192:74 */
  assign n125 = ~n124;
  /*# vidproc_orig.vhd:192:69 */
  assign n126 = n123 & n125;
  /*# vidproc_orig.vhd:193:38 */
  assign n127 = clken_counter[3]; // extract
  /*# vidproc_orig.vhd:193:21 */
  assign n128 = ~n127;
  /*# vidproc_orig.vhd:193:43 */
  assign n129 = n128 | r0_crtc_2mhz;
  /*# vidproc_orig.vhd:193:75 */
  assign n130 = r0_teletext & VGA;
  /*# vidproc_orig.vhd:193:59 */
  assign n131 = n129 | n130;
  /*# vidproc_orig.vhd:192:96 */
  assign n132 = n126 & n131;
  /*# vidproc_orig.vhd:203:48 */
  assign n137 = clken_counter + 4'b0001;
  /*# vidproc_orig.vhd:211:19 */
  assign n143 = ~nRESET;
  /*# vidproc_orig.vhd:224:41 */
  assign n145 = shiftreg[6:0]; // extract
  /*# vidproc_orig.vhd:224:54 */
  assign n147 = {n145, 1'b1};
  /*# vidproc_orig.vhd:216:17 */
  assign n148 = clken_fetch ? DI_RAM : n147;
  /*# vidproc_orig.vhd:215:13 */
  assign n151 = clken_fetch & clken_pixel;
  /*# vidproc_orig.vhd:232:58 */
  assign n159 = cursor_counter[0]; // extract
  /*# vidproc_orig.vhd:232:79 */
  assign n160 = cursor_counter[1]; // extract
  /*# vidproc_orig.vhd:232:62 */
  assign n161 = n159 | n160;
  /*# vidproc_orig.vhd:232:39 */
  assign n162 = ~n161;
  /*# vidproc_orig.vhd:232:35 */
  assign n163 = r0_cursor0 & n162;
  /*# vidproc_orig.vhd:233:53 */
  assign n164 = cursor_counter[0]; // extract
  /*# vidproc_orig.vhd:233:35 */
  assign n165 = r0_cursor1 & n164;
  /*# vidproc_orig.vhd:233:79 */
  assign n166 = cursor_counter[1]; // extract
  /*# vidproc_orig.vhd:233:61 */
  assign n167 = ~n166;
  /*# vidproc_orig.vhd:233:57 */
  assign n168 = n165 & n167;
  /*# vidproc_orig.vhd:232:85 */
  assign n169 = n163 | n168;
  /*# vidproc_orig.vhd:234:53 */
  assign n170 = cursor_counter[1]; // extract
  /*# vidproc_orig.vhd:234:35 */
  assign n171 = r0_cursor2 & n170;
  /*# vidproc_orig.vhd:233:84 */
  assign n172 = n169 | n171;
  /*# vidproc_orig.vhd:231:36 */
  assign n173 = cursor_active & n172;
  /*# vidproc_orig.vhd:238:19 */
  assign n176 = ~nRESET;
  /*# vidproc_orig.vhd:243:33 */
  assign n178 = CURSOR | cursor_active;
  /*# vidproc_orig.vhd:248:39 */
  assign n180 = cursor_counter == 2'b11;
  /*# vidproc_orig.vhd:248:21 */
  assign n183 = n180 ? 1'b0 : 1'b1;
  /*# vidproc_orig.vhd:253:38 */
  assign n185 = ~cursor_active;
  /*# vidproc_orig.vhd:258:58 */
  assign n187 = cursor_counter + 2'b01;
  /*# vidproc_orig.vhd:253:21 */
  assign n189 = n185 ? 2'b00 : n187;
  /*# vidproc_orig.vhd:242:13 */
  assign n192 = n178 & clken_fetch;
  /*# vidproc_orig.vhd:242:13 */
  assign n193 = n178 & clken_fetch;
  /*# vidproc_orig.vhd:285:19 */
  assign n208 = ~nRESET;
  /*# vidproc_orig.vhd:296:38 */
  assign n210 = shiftreg[7]; // extract
  /*# vidproc_orig.vhd:296:52 */
  assign n211 = shiftreg[5]; // extract
  /*# vidproc_orig.vhd:296:42 */
  assign n212 = {n210, n211};
  /*# vidproc_orig.vhd:296:66 */
  assign n213 = shiftreg[3]; // extract
  /*# vidproc_orig.vhd:296:56 */
  assign n214 = {n212, n213};
  /*# vidproc_orig.vhd:296:80 */
  assign n215 = shiftreg[1]; // extract
  /*# vidproc_orig.vhd:296:70 */
  assign n216 = {n214, n215};
  /*# vidproc_orig.vhd:297:36 */
  assign n219 = 4'b1111 - n216;
  /*# vidproc_orig.vhd:300:36 */
  assign n222 = n395[3]; // extract
  /*# vidproc_orig.vhd:300:40 */
  assign n223 = n222 & r0_flash;
  /*# vidproc_orig.vhd:300:69 */
  assign n224 = n395[0]; // extract
  /*# vidproc_orig.vhd:300:58 */
  assign n225 = ~n224;
  /*# vidproc_orig.vhd:300:54 */
  assign n226 = n223 ^ n225;
  /*# vidproc_orig.vhd:301:38 */
  assign n227 = n395[3]; // extract
  /*# vidproc_orig.vhd:301:42 */
  assign n228 = n227 & r0_flash;
  /*# vidproc_orig.vhd:301:71 */
  assign n229 = n395[1]; // extract
  /*# vidproc_orig.vhd:301:60 */
  assign n230 = ~n229;
  /*# vidproc_orig.vhd:301:56 */
  assign n231 = n228 ^ n230;
  /*# vidproc_orig.vhd:302:37 */
  assign n232 = n395[3]; // extract
  /*# vidproc_orig.vhd:302:41 */
  assign n233 = n232 & r0_flash;
  /*# vidproc_orig.vhd:302:70 */
  assign n234 = n395[2]; // extract
  /*# vidproc_orig.vhd:302:59 */
  assign n235 = ~n234;
  /*# vidproc_orig.vhd:302:55 */
  assign n236 = n233 ^ n235;
  /*# vidproc_orig.vhd:305:32 */
  assign n237 = n226 & delayed_disen;
  /*# vidproc_orig.vhd:305:51 */
  assign n238 = n237 ^ cursor_invert;
  /*# vidproc_orig.vhd:306:34 */
  assign n239 = n231 & delayed_disen;
  /*# vidproc_orig.vhd:306:53 */
  assign n240 = n239 ^ cursor_invert;
  /*# vidproc_orig.vhd:307:33 */
  assign n241 = n236 & delayed_disen;
  /*# vidproc_orig.vhd:307:52 */
  assign n242 = n241 ^ cursor_invert;
  /*# vidproc_orig.vhd:317:33 */
  assign n277 = ~r0_teletext;
  /*# vidproc_orig.vhd:317:16 */
  assign n278 = n277 ? rr : n279;
  /*# vidproc_orig.vhd:317:49 */
  assign n279 = R_IN ^ cursor_invert2;
  /*# vidproc_orig.vhd:318:33 */
  assign n280 = ~r0_teletext;
  /*# vidproc_orig.vhd:318:16 */
  assign n281 = n280 ? gg : n282;
  /*# vidproc_orig.vhd:318:49 */
  assign n282 = G_IN ^ cursor_invert2;
  /*# vidproc_orig.vhd:319:33 */
  assign n283 = ~r0_teletext;
  /*# vidproc_orig.vhd:319:16 */
  assign n284 = n283 ? bb : n285;
  /*# vidproc_orig.vhd:319:49 */
  assign n285 = B_IN ^ cursor_invert2;
  /*# vidproc_orig.vhd:153:9 */
  assign n286 = n58 ? n28 : r0_cursor0;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n287 <= 1'b0;
    else
      n287 <= n286;
  /*# vidproc_orig.vhd:153:9 */
  assign n288 = n59 ? n29 : r0_cursor1;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n289 <= 1'b0;
    else
      n289 <= n288;
  /*# vidproc_orig.vhd:153:9 */
  assign n290 = n60 ? n30 : r0_cursor2;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n291 <= 1'b0;
    else
      n291 <= n290;
  /*# vidproc_orig.vhd:153:9 */
  assign n292 = n61 ? n31 : r0_crtc_2mhz;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n293 <= 1'b0;
    else
      n293 <= n292;
  /*# vidproc_orig.vhd:153:9 */
  assign n294 = n62 ? n32 : r0_pixel_rate;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n295 <= 2'b00;
    else
      n295 <= n294;
  /*# vidproc_orig.vhd:153:9 */
  assign n296 = n63 ? n33 : r0_teletext;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n297 <= 1'b0;
    else
      n297 <= n296;
  /*# vidproc_orig.vhd:153:9 */
  assign n298 = n64 ? n34 : r0_flash;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n299 <= 1'b0;
    else
      n299 <= n298;
  /*# vidproc_orig.vhd:153:9 */
  assign n300 = n65 ? n49 : palette;
  /*# vidproc_orig.vhd:153:9 */
  always @(posedge CLOCK or posedge n9)
    if (n9)
      n301 <= n88;
    else
      n301 <= n300;
  /*# vidproc_orig.vhd:214:9 */
  assign n302 = clken_pixel ? n148 : shiftreg;
  /*# vidproc_orig.vhd:214:9 */
  always @(posedge CLOCK or posedge n143)
    if (n143)
      n303 <= 8'b00000000;
    else
      n303 <= n302;
  /*# vidproc_orig.vhd:214:9 */
  assign n304 = n151 ? DISEN : delayed_disen;
  /*# vidproc_orig.vhd:214:9 */
  always @(posedge CLOCK or posedge n143)
    if (n143)
      n305 <= 1'b0;
    else
      n305 <= n304;
  /*# vidproc_orig.vhd:200:9 */
  assign n306 = CLKEN ? n137 : clken_counter;
  /*# vidproc_orig.vhd:200:9 */
  always @(posedge CLOCK)
    n307 <= n306;
  initial
    n307 = 4'b0000;
  /*# vidproc_orig.vhd:128:12 */
  assign n308 = ~n208;
  /*# vidproc_orig.vhd:128:12 */
  assign n309 = clken_pixel & n308;
  /*# vidproc_orig.vhd:289:9 */
  assign n310 = n309 ? cursor_invert : cursor_invert1;
  /*# vidproc_orig.vhd:289:9 */
  always @(posedge CLOCK)
    n311 <= n310;
  /*# vidproc_orig.vhd:129:12 */
  assign n312 = ~n208;
  /*# vidproc_orig.vhd:129:12 */
  assign n313 = clken_pixel & n312;
  /*# vidproc_orig.vhd:289:9 */
  assign n314 = n313 ? cursor_invert1 : cursor_invert2;
  /*# vidproc_orig.vhd:289:9 */
  always @(posedge CLOCK)
    n315 <= n314;
  /*# vidproc_orig.vhd:241:9 */
  assign n316 = n192 ? n183 : cursor_active;
  /*# vidproc_orig.vhd:241:9 */
  always @(posedge CLOCK or posedge n176)
    if (n176)
      n317 <= 1'b0;
    else
      n317 <= n316;
  /*# vidproc_orig.vhd:241:9 */
  assign n318 = n193 ? n189 : cursor_counter;
  /*# vidproc_orig.vhd:241:9 */
  always @(posedge CLOCK or posedge n176)
    if (n176)
      n319 <= 2'b00;
    else
      n319 <= n318;
  /*# vidproc_orig.vhd:289:9 */
  assign n320 = clken_pixel ? n238 : rr;
  /*# vidproc_orig.vhd:289:9 */
  always @(posedge CLOCK or posedge n208)
    if (n208)
      n321 <= 1'b0;
    else
      n321 <= n320;
  /*# vidproc_orig.vhd:289:9 */
  assign n322 = clken_pixel ? n240 : gg;
  /*# vidproc_orig.vhd:289:9 */
  always @(posedge CLOCK or posedge n208)
    if (n208)
      n323 <= 1'b0;
    else
      n323 <= n322;
  /*# vidproc_orig.vhd:289:9 */
  assign n324 = clken_pixel ? n242 : bb;
  /*# vidproc_orig.vhd:289:9 */
  always @(posedge CLOCK or posedge n208)
    if (n208)
      n325 <= 1'b0;
    else
      n325 <= n324;
  /*# vidproc_orig.vhd:172:25 */
  assign n326 = n38[3]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n327 = ~n326;
  /*# vidproc_orig.vhd:172:25 */
  assign n328 = n38[2]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n329 = ~n328;
  /*# vidproc_orig.vhd:172:25 */
  assign n330 = n327 & n329;
  /*# vidproc_orig.vhd:172:25 */
  assign n331 = n327 & n328;
  /*# vidproc_orig.vhd:172:25 */
  assign n332 = n326 & n329;
  /*# vidproc_orig.vhd:172:25 */
  assign n333 = n326 & n328;
  /*# vidproc_orig.vhd:172:25 */
  assign n334 = n38[1]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n335 = ~n334;
  /*# vidproc_orig.vhd:172:25 */
  assign n336 = n330 & n335;
  /*# vidproc_orig.vhd:172:25 */
  assign n337 = n330 & n334;
  /*# vidproc_orig.vhd:172:25 */
  assign n338 = n331 & n335;
  /*# vidproc_orig.vhd:172:25 */
  assign n339 = n331 & n334;
  /*# vidproc_orig.vhd:172:25 */
  assign n340 = n332 & n335;
  /*# vidproc_orig.vhd:172:25 */
  assign n341 = n332 & n334;
  /*# vidproc_orig.vhd:172:25 */
  assign n342 = n333 & n335;
  /*# vidproc_orig.vhd:172:25 */
  assign n343 = n333 & n334;
  /*# vidproc_orig.vhd:172:25 */
  assign n344 = n38[0]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n345 = ~n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n346 = n336 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n347 = n336 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n348 = n337 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n349 = n337 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n350 = n338 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n351 = n338 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n352 = n339 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n353 = n339 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n354 = n340 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n355 = n340 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n356 = n341 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n357 = n341 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n358 = n342 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n359 = n342 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n360 = n343 & n345;
  /*# vidproc_orig.vhd:172:25 */
  assign n361 = n343 & n344;
  /*# vidproc_orig.vhd:172:25 */
  assign n362 = palette[3:0]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n363 = n346 ? n40 : n362;
  /*# vidproc_orig.vhd:172:25 */
  assign n364 = palette[7:4]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n365 = n347 ? n40 : n364;
  /*# vidproc_orig.vhd:172:25 */
  assign n366 = palette[11:8]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n367 = n348 ? n40 : n366;
  /*# vidproc_orig.vhd:172:25 */
  assign n368 = palette[15:12]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n369 = n349 ? n40 : n368;
  /*# vidproc_orig.vhd:172:25 */
  assign n370 = palette[19:16]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n371 = n350 ? n40 : n370;
  /*# vidproc_orig.vhd:172:25 */
  assign n372 = palette[23:20]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n373 = n351 ? n40 : n372;
  /*# vidproc_orig.vhd:172:25 */
  assign n374 = palette[27:24]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n375 = n352 ? n40 : n374;
  /*# vidproc_orig.vhd:172:25 */
  assign n376 = palette[31:28]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n377 = n353 ? n40 : n376;
  /*# vidproc_orig.vhd:172:25 */
  assign n378 = palette[35:32]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n379 = n354 ? n40 : n378;
  /*# vidproc_orig.vhd:172:25 */
  assign n380 = palette[39:36]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n381 = n355 ? n40 : n380;
  /*# vidproc_orig.vhd:172:25 */
  assign n382 = palette[43:40]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n383 = n356 ? n40 : n382;
  /*# vidproc_orig.vhd:172:25 */
  assign n384 = palette[47:44]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n385 = n357 ? n40 : n384;
  /*# vidproc_orig.vhd:172:25 */
  assign n386 = palette[51:48]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n387 = n358 ? n40 : n386;
  /*# vidproc_orig.vhd:172:25 */
  assign n388 = palette[55:52]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n389 = n359 ? n40 : n388;
  /*# vidproc_orig.vhd:172:25 */
  assign n390 = palette[59:56]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n391 = n360 ? n40 : n390;
  /*# vidproc_orig.vhd:172:25 */
  assign n392 = palette[63:60]; // extract
  /*# vidproc_orig.vhd:172:25 */
  assign n393 = n361 ? n40 : n392;
  /*# vidproc_orig.vhd:172:25 */
  assign n394 = {n393, n391, n389, n387, n385, n383, n381, n379, n377, n375, n373, n371, n369, n367, n365, n363};
  /*# vidproc_orig.vhd:297:36 */
  assign n395 = palette[n219 * 4 +: 4]; //(Bmux)
endmodule


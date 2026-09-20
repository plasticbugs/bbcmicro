module saa5050
  (input  CLOCK,
   input  CLKEN,
   input  nRESET,
   input  VGA,
   input  DI_CLOCK,
   input  DI_CLKEN,
   input  [6:0] DI,
   input  GLR,
   input  DEW,
   input  CRS,
   input  LOSE,
   output [11:0] ROM_A1,
   input  [7:0] ROM_D1,
   output [11:0] ROM_A2,
   input  [7:0] ROM_D2,
   output R,
   output G,
   output B,
   output Y);
  wire [6:0] di_tmp;
  wire [6:0] di_r;
  wire dew_r;
  wire lose_r;
  wire [6:0] code;
  wire [3:0] line_addr;
  wire [11:0] rom_address1;
  wire [11:0] rom_address2;
  wire [7:0] rom_data1;
  wire [7:0] rom_data2;
  wire disp_enable;
  wire dew_latch;
  wire lose_latch;
  wire disp_enable_latch;
  wire [3:0] line_counter;
  wire [3:0] pixel_counter;
  wire [5:0] flash_counter;
  wire [11:0] shift_reg;
  wire flash;
  wire [2:0] fg;
  wire [2:0] bg;
  wire conceal;
  wire gfx;
  wire gfx_sep;
  wire gfx_hold;
  wire is_flash;
  wire double_high;
  wire [2:0] fg_next;
  wire alpha_next;
  wire gfx_next;
  wire gfx_release_next;
  wire is_flash_next;
  wire double_high_next;
  wire unconceal_next;
  wire [6:0] code_r;
  wire disp_enable_r;
  wire [2:0] fg_r;
  wire [2:0] bg_r;
  wire conceal_r;
  wire is_flash_r;
  wire last_gfx_sep;
  wire [6:0] last_gfx;
  wire hold_active;
  wire double_high1;
  wire double_high2;
  wire n6;
  wire n7;
  wire n8;
  wire n11;
  wire n32;
  wire n35;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n47;
  wire n48;
  wire n73;
  wire n75;
  wire n76;
  wire n77;
  wire n78;
  wire n80;
  wire n82;
  wire [3:0] n84;
  wire [3:0] n87;
  wire n88;
  wire n89;
  wire [3:0] n91;
  wire n92;
  wire n93;
  wire [5:0] n95;
  wire n97;
  wire n98;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n104;
  wire [3:0] n106;
  wire [3:0] n108;
  wire n110;
  wire n111;
  wire [3:0] n112;
  wire n113;
  wire n114;
  wire [3:0] n116;
  wire n118;
  wire n120;
  wire n121;
  wire n127;
  wire n160;
  wire n162;
  wire n164;
  wire n165;
  wire [1:0] n166;
  wire n168;
  wire n169;
  wire n170;
  wire [4:0] n171;
  wire n173;
  wire n174;
  wire [6:0] n176;
  wire n177;
  wire [6:0] n178;
  wire n180;
  wire [2:0] n181;
  wire n183;
  wire n185;
  wire n187;
  wire n189;
  wire n191;
  wire n192;
  wire n194;
  wire [1:0] n195;
  wire n197;
  wire n198;
  wire n199;
  wire [2:0] n200;
  wire n202;
  wire [2:0] n203;
  wire n204;
  wire n207;
  wire n210;
  wire n213;
  wire [2:0] n215;
  wire n217;
  wire n219;
  wire n221;
  wire n224;
  wire [4:0] n225;
  wire n227;
  wire n229;
  wire [6:0] n231;
  wire n233;
  wire n234;
  wire [6:0] n236;
  wire n238;
  wire n240;
  wire n242;
  wire n244;
  wire n246;
  wire n248;
  wire [2:0] n249;
  wire n251;
  wire n253;
  wire n255;
  wire [10:0] n256;
  reg [2:0] n258;
  reg n260;
  reg n263;
  reg n265;
  reg n267;
  reg n269;
  reg n272;
  reg n275;
  reg n278;
  reg [6:0] n279;
  wire [2:0] n280;
  wire n281;
  wire n282;
  wire n283;
  wire n284;
  wire n285;
  wire [2:0] n287;
  wire n289;
  wire n291;
  wire n292;
  wire n294;
  wire n296;
  wire n298;
  wire [6:0] n299;
  wire [2:0] n300;
  wire n301;
  wire n302;
  wire n303;
  wire n304;
  wire n305;
  wire [2:0] n307;
  wire n310;
  wire n313;
  wire n316;
  wire n319;
  wire n322;
  wire n325;
  wire [6:0] n327;
  wire n328;
  wire n329;
  wire n330;
  wire n331;
  wire n332;
  wire n333;
  wire n334;
  wire n335;
  wire [2:0] n336;
  wire n337;
  wire n338;
  wire n339;
  wire n340;
  wire n341;
  wire n342;
  wire n343;
  wire [6:0] n344;
  wire [2:0] n346;
  wire [2:0] n348;
  wire n350;
  wire n352;
  wire n354;
  wire n356;
  wire n358;
  wire n360;
  wire [2:0] n362;
  wire n364;
  wire n366;
  wire n368;
  wire n370;
  wire n372;
  wire n374;
  wire n376;
  wire [6:0] n378;
  wire n448;
  wire [3:0] n449;
  wire [2:0] n450;
  wire [3:0] n452;
  wire n453;
  wire [3:0] n454;
  wire [2:0] n455;
  wire [3:0] n457;
  wire [3:0] n459;
  wire [1:0] n461;
  wire n463;
  wire n464;
  wire n465;
  wire n468;
  wire n469;
  wire [11:0] n470;
  wire [7:0] n471;
  wire [11:0] n472;
  wire [11:0] n473;
  wire [7:0] n474;
  wire [11:0] n475;
  wire [11:0] n477;
  wire n478;
  wire n479;
  wire n480;
  wire n481;
  wire n482;
  wire n483;
  wire [11:0] n484;
  wire [11:0] n486;
  wire n491;
  wire n494;
  wire n495;
  wire n496;
  wire n497;
  wire [1:0] n498;
  wire n499;
  wire [2:0] n500;
  wire n501;
  wire [3:0] n502;
  wire n503;
  wire [4:0] n504;
  wire n505;
  wire [5:0] n506;
  wire n507;
  wire [6:0] n508;
  wire n509;
  wire [7:0] n510;
  wire n511;
  wire [8:0] n512;
  wire n513;
  wire [9:0] n514;
  wire n515;
  wire [10:0] n516;
  wire n517;
  wire [11:0] n518;
  wire n519;
  wire n520;
  wire [1:0] n521;
  wire n522;
  wire [2:0] n523;
  wire n524;
  wire [3:0] n525;
  wire n526;
  wire [4:0] n527;
  wire n528;
  wire [5:0] n529;
  wire n530;
  wire [6:0] n531;
  wire n532;
  wire [7:0] n533;
  wire n534;
  wire [8:0] n535;
  wire n536;
  wire [9:0] n537;
  wire n538;
  wire [10:0] n539;
  wire n540;
  wire [11:0] n541;
  wire n542;
  wire n543;
  wire n544;
  wire n545;
  wire n546;
  wire n552;
  wire n554;
  wire n555;
  wire n557;
  wire n558;
  wire [3:0] n560;
  wire [3:0] n561;
  wire [11:0] n562;
  wire [11:0] n563;
  wire [11:0] n564;
  wire [10:0] n565;
  wire [11:0] n567;
  wire [11:0] n568;
  wire [10:0] n569;
  wire [11:0] n571;
  wire [11:0] n572;
  wire [11:0] n573;
  wire [11:0] n574;
  wire [10:0] n575;
  wire [11:0] n577;
  wire [11:0] n578;
  wire [10:0] n579;
  wire [11:0] n581;
  wire [11:0] n582;
  wire [11:0] n583;
  wire [11:0] n584;
  wire [11:0] n585;
  wire [10:0] n586;
  wire [11:0] n588;
  wire [11:0] n589;
  wire n607;
  wire n608;
  wire n609;
  wire n610;
  wire n611;
  wire n612;
  wire n613;
  wire n614;
  wire n615;
  wire n616;
  wire n617;
  wire n618;
  wire n619;
  wire n620;
  wire n632;
  reg n633;
  wire n634;
  reg n635;
  wire n636;
  reg n637;
  wire n638;
  reg n639;
  wire [6:0] n640;
  reg [6:0] n641;
  wire [6:0] n642;
  reg [6:0] n643;
  wire n644;
  reg n645;
  wire n646;
  reg n647;
  wire [6:0] n648;
  reg [6:0] n649;
  wire n650;
  reg n651;
  wire n652;
  reg n653;
  wire n654;
  reg n655;
  wire n656;
  reg n657;
  wire [3:0] n658;
  reg [3:0] n659;
  wire [3:0] n660;
  reg [3:0] n661;
  wire [5:0] n662;
  reg [5:0] n663;
  wire [11:0] n664;
  reg [11:0] n665;
  wire [2:0] n666;
  reg [2:0] n667;
  wire [2:0] n668;
  reg [2:0] n669;
  wire n670;
  reg n671;
  wire n672;
  reg n673;
  wire n674;
  reg n675;
  wire n676;
  reg n677;
  wire n678;
  reg n679;
  wire n680;
  reg n681;
  wire [2:0] n682;
  reg [2:0] n683;
  wire n684;
  reg n685;
  wire n686;
  reg n687;
  wire n688;
  reg n689;
  wire n690;
  reg n691;
  wire n692;
  reg n693;
  wire n694;
  reg n695;
  wire [6:0] n696;
  reg [6:0] n697;
  wire n698;
  reg n699;
  wire [2:0] n700;
  reg [2:0] n701;
  wire [2:0] n702;
  reg [2:0] n703;
  wire n704;
  reg n705;
  wire n706;
  reg n707;
  wire n708;
  reg n709;
  wire [6:0] n710;
  reg [6:0] n711;
  wire n712;
  reg n713;
  wire n714;
  reg n715;
  assign ROM_A1 = rom_address1; //(module output)
  assign ROM_A2 = rom_address2; //(module output)
  assign R = n633; //(module output)
  assign G = n635; //(module output)
  assign B = n637; //(module output)
  assign Y = n639; //(module output)
  /*# saa5050.vhd:114:8 */
  assign di_tmp = n641; // (signal)
  /*# saa5050.vhd:115:8 */
  assign di_r = n643; // (signal)
  /*# saa5050.vhd:116:8 */
  assign dew_r = n645; // (signal)
  /*# saa5050.vhd:117:8 */
  assign lose_r = n647; // (signal)
  /*# saa5050.vhd:119:8 */
  assign code = n649; // (signal)
  /*# saa5050.vhd:120:8 */
  assign line_addr = n449; // (signal)
  /*# saa5050.vhd:121:8 */
  assign rom_address1 = n470; // (signal)
  /*# saa5050.vhd:122:8 */
  assign rom_address2 = n484; // (signal)
  /*# saa5050.vhd:123:8 */
  assign rom_data1 = ROM_D1; // (signal)
  /*# saa5050.vhd:124:8 */
  assign rom_data2 = ROM_D2; // (signal)
  /*# saa5050.vhd:127:8 */
  assign disp_enable = n651; // (signal)
  /*# saa5050.vhd:129:8 */
  assign dew_latch = n653; // (signal)
  /*# saa5050.vhd:130:8 */
  assign lose_latch = n655; // (signal)
  /*# saa5050.vhd:131:8 */
  assign disp_enable_latch = n657; // (signal)
  /*# saa5050.vhd:135:8 */
  assign line_counter = n659; // (signal)
  /*# saa5050.vhd:137:8 */
  assign pixel_counter = n661; // (signal)
  /*# saa5050.vhd:141:8 */
  assign flash_counter = n663; // (signal)
  /*# saa5050.vhd:143:8 */
  assign shift_reg = n665; // (signal)
  /*# saa5050.vhd:146:8 */
  assign flash = n8; // (signal)
  /*# saa5050.vhd:150:8 */
  assign fg = n667; // (signal)
  /*# saa5050.vhd:152:8 */
  assign bg = n669; // (signal)
  /*# saa5050.vhd:153:8 */
  assign conceal = n671; // (signal)
  /*# saa5050.vhd:154:8 */
  assign gfx = n673; // (signal)
  /*# saa5050.vhd:155:8 */
  assign gfx_sep = n675; // (signal)
  /*# saa5050.vhd:156:8 */
  assign gfx_hold = n677; // (signal)
  /*# saa5050.vhd:157:8 */
  assign is_flash = n679; // (signal)
  /*# saa5050.vhd:158:8 */
  assign double_high = n681; // (signal)
  /*# saa5050.vhd:161:8 */
  assign fg_next = n683; // (signal)
  /*# saa5050.vhd:162:8 */
  assign alpha_next = n685; // (signal)
  /*# saa5050.vhd:163:8 */
  assign gfx_next = n687; // (signal)
  /*# saa5050.vhd:164:8 */
  assign gfx_release_next = n689; // (signal)
  /*# saa5050.vhd:165:8 */
  assign is_flash_next = n691; // (signal)
  /*# saa5050.vhd:166:8 */
  assign double_high_next = n693; // (signal)
  /*# saa5050.vhd:167:8 */
  assign unconceal_next = n695; // (signal)
  /*# saa5050.vhd:171:8 */
  assign code_r = n697; // (signal)
  /*# saa5050.vhd:172:8 */
  assign disp_enable_r = n699; // (signal)
  /*# saa5050.vhd:173:8 */
  assign fg_r = n701; // (signal)
  /*# saa5050.vhd:174:8 */
  assign bg_r = n703; // (signal)
  /*# saa5050.vhd:175:8 */
  assign conceal_r = n705; // (signal)
  /*# saa5050.vhd:176:8 */
  assign is_flash_r = n707; // (signal)
  /*# saa5050.vhd:179:8 */
  assign last_gfx_sep = n709; // (signal)
  /*# saa5050.vhd:180:8 */
  assign last_gfx = n711; // (signal)
  /*# saa5050.vhd:181:8 */
  assign hold_active = n465; // (signal)
  /*# saa5050.vhd:184:8 */
  assign double_high1 = n713; // (signal)
  /*# saa5050.vhd:186:8 */
  assign double_high2 = n715; // (signal)
  /*# saa5050.vhd:191:27 */
  assign n6 = flash_counter[5]; // extract
  /*# saa5050.vhd:191:48 */
  assign n7 = flash_counter[4]; // extract
  /*# saa5050.vhd:191:31 */
  assign n8 = n6 & n7;
  /*# saa5050.vhd:196:19 */
  assign n11 = ~nRESET;
  /*# saa5050.vhd:214:19 */
  assign n32 = ~nRESET;
  /*# saa5050.vhd:225:34 */
  assign n35 = pixel_counter == 4'b0000;
  /*# saa5050.vhd:223:13 */
  assign n43 = n35 & CLKEN;
  /*# saa5050.vhd:223:13 */
  assign n44 = n35 & CLKEN;
  /*# saa5050.vhd:223:13 */
  assign n45 = n35 & CLKEN;
  /*# saa5050.vhd:223:13 */
  assign n46 = n35 & CLKEN;
  /*# saa5050.vhd:223:13 */
  assign n47 = n35 & CLKEN;
  /*# saa5050.vhd:223:13 */
  assign n48 = n35 & CLKEN;
  /*# saa5050.vhd:240:19 */
  assign n73 = ~nRESET;
  /*# saa5050.vhd:258:55 */
  assign n75 = ~double_high1;
  /*# saa5050.vhd:258:38 */
  assign n76 = n75 & double_high;
  /*# saa5050.vhd:258:78 */
  assign n77 = ~double_high2;
  /*# saa5050.vhd:258:61 */
  assign n78 = n77 & n76;
  /*# saa5050.vhd:258:17 */
  assign n80 = n78 ? 1'b1 : double_high1;
  /*# saa5050.vhd:263:34 */
  assign n82 = pixel_counter == 4'b1011;
  /*# saa5050.vhd:268:52 */
  assign n84 = pixel_counter + 4'b0001;
  /*# saa5050.vhd:263:17 */
  assign n87 = n82 ? 4'b0000 : n84;
  /*# saa5050.vhd:272:48 */
  assign n88 = ~lose_latch;
  /*# saa5050.vhd:272:33 */
  assign n89 = n88 & lose_r;
  /*# saa5050.vhd:272:17 */
  assign n91 = n89 ? 4'b0110 : n87;
  /*# saa5050.vhd:279:26 */
  assign n92 = ~dew_r;
  /*# saa5050.vhd:279:32 */
  assign n93 = dew_latch & n92;
  /*# saa5050.vhd:280:52 */
  assign n95 = flash_counter + 6'b000001;
  /*# saa5050.vhd:290:36 */
  assign n97 = ~disp_enable;
  /*# saa5050.vhd:290:42 */
  assign n98 = disp_enable_latch & n97;
  /*# saa5050.vhd:290:79 */
  assign n99 = ~VGA;
  /*# saa5050.vhd:290:92 */
  assign n100 = ~CRS;
  /*# saa5050.vhd:290:85 */
  assign n101 = n99 | n100;
  /*# saa5050.vhd:290:70 */
  assign n102 = n101 & n98;
  /*# saa5050.vhd:291:41 */
  assign n104 = line_counter == 4'b1001;
  /*# saa5050.vhd:303:58 */
  assign n106 = line_counter + 4'b0001;
  /*# saa5050.vhd:291:25 */
  assign n108 = n104 ? 4'b0000 : n106;
  /*# saa5050.vhd:290:21 */
  assign n110 = n113 ? 1'b0 : n80;
  /*# saa5050.vhd:290:21 */
  assign n111 = n114 ? double_high1 : double_high2;
  /*# saa5050.vhd:290:21 */
  assign n112 = n102 ? n108 : line_counter;
  /*# saa5050.vhd:290:21 */
  assign n113 = n104 & n102;
  /*# saa5050.vhd:290:21 */
  assign n114 = n104 & n102;
  /*# saa5050.vhd:283:17 */
  assign n116 = dew_r ? 4'b0000 : n112;
  /*# saa5050.vhd:283:17 */
  assign n118 = dew_r ? 1'b0 : n110;
  /*# saa5050.vhd:283:17 */
  assign n120 = dew_r ? 1'b0 : n111;
  /*# saa5050.vhd:251:13 */
  assign n121 = n82 & CLKEN;
  /*# saa5050.vhd:251:13 */
  assign n127 = n93 & CLKEN;
  /*# saa5050.vhd:316:19 */
  assign n160 = ~nRESET;
  /*# saa5050.vhd:340:32 */
  assign n162 = ~disp_enable;
  /*# saa5050.vhd:361:37 */
  assign n164 = pixel_counter == 4'b0000;
  /*# saa5050.vhd:370:28 */
  assign n165 = code[5]; // extract
  /*# saa5050.vhd:374:31 */
  assign n166 = code[6:5]; // extract
  /*# saa5050.vhd:374:44 */
  assign n168 = n166 == 2'b00;
  /*# saa5050.vhd:374:64 */
  assign n169 = ~gfx_hold;
  /*# saa5050.vhd:374:51 */
  assign n170 = n169 & n168;
  /*# saa5050.vhd:374:78 */
  assign n171 = code[4:0]; // extract
  /*# saa5050.vhd:374:91 */
  assign n173 = n171 != 5'b11110;
  /*# saa5050.vhd:374:70 */
  assign n174 = n173 & n170;
  /*# saa5050.vhd:374:21 */
  assign n176 = n174 ? 7'b0000000 : last_gfx;
  /*# saa5050.vhd:361:17 */
  assign n177 = n343 ? gfx_sep : last_gfx_sep;
  /*# saa5050.vhd:370:21 */
  assign n178 = n165 ? code : n176;
  /*# saa5050.vhd:384:32 */
  assign n180 = fg_next != 3'b000;
  /*# saa5050.vhd:361:17 */
  assign n181 = n328 ? fg_next : fg;
  /*# saa5050.vhd:387:21 */
  assign n183 = gfx_next ? 1'b1 : gfx;
  /*# saa5050.vhd:390:21 */
  assign n185 = alpha_next ? 1'b0 : n183;
  /*# saa5050.vhd:393:21 */
  assign n187 = is_flash_next ? 1'b1 : is_flash;
  /*# saa5050.vhd:396:21 */
  assign n189 = double_high_next ? 1'b1 : double_high;
  /*# saa5050.vhd:399:21 */
  assign n191 = gfx_release_next ? 1'b0 : gfx_hold;
  /*# saa5050.vhd:405:38 */
  assign n192 = unconceal_next & conceal;
  /*# saa5050.vhd:405:21 */
  assign n194 = n192 ? 1'b0 : conceal;
  /*# saa5050.vhd:410:28 */
  assign n195 = code[6:5]; // extract
  /*# saa5050.vhd:410:41 */
  assign n197 = n195 == 2'b00;
  /*# saa5050.vhd:411:32 */
  assign n198 = code[3]; // extract
  /*# saa5050.vhd:411:36 */
  assign n199 = ~n198;
  /*# saa5050.vhd:413:36 */
  assign n200 = code[2:0]; // extract
  /*# saa5050.vhd:413:49 */
  assign n202 = n200 != 3'b000;
  /*# saa5050.vhd:417:48 */
  assign n203 = code[2:0]; // extract
  /*# saa5050.vhd:419:40 */
  assign n204 = code[4]; // extract
  /*# saa5050.vhd:419:33 */
  assign n207 = n204 ? 1'b0 : 1'b1;
  /*# saa5050.vhd:419:33 */
  assign n210 = n204 ? 1'b1 : 1'b0;
  /*# saa5050.vhd:419:33 */
  assign n213 = n204 ? 1'b0 : 1'b1;
  /*# saa5050.vhd:413:29 */
  assign n215 = n202 ? n203 : 3'b000;
  /*# saa5050.vhd:413:29 */
  assign n217 = n202 ? n207 : 1'b0;
  /*# saa5050.vhd:413:29 */
  assign n219 = n202 ? n210 : 1'b0;
  /*# saa5050.vhd:413:29 */
  assign n221 = n202 ? n213 : 1'b0;
  /*# saa5050.vhd:413:29 */
  assign n224 = n202 ? 1'b1 : 1'b0;
  /*# saa5050.vhd:427:38 */
  assign n225 = code[4:0]; // extract
  /*# saa5050.vhd:429:29 */
  assign n227 = n225 == 5'b01000;
  /*# saa5050.vhd:432:29 */
  assign n229 = n225 == 5'b01001;
  /*# saa5050.vhd:438:33 */
  assign n231 = double_high ? 7'b0000000 : n178;
  /*# saa5050.vhd:435:29 */
  assign n233 = n225 == 5'b01100;
  /*# saa5050.vhd:445:49 */
  assign n234 = ~double_high;
  /*# saa5050.vhd:445:33 */
  assign n236 = n234 ? 7'b0000000 : n178;
  /*# saa5050.vhd:442:29 */
  assign n238 = n225 == 5'b01101;
  /*# saa5050.vhd:449:29 */
  assign n240 = n225 == 5'b11000;
  /*# saa5050.vhd:452:29 */
  assign n242 = n225 == 5'b11001;
  /*# saa5050.vhd:455:29 */
  assign n244 = n225 == 5'b11010;
  /*# saa5050.vhd:458:29 */
  assign n246 = n225 == 5'b11100;
  /*# saa5050.vhd:463:44 */
  assign n248 = fg_next != 3'b000;
  /*# saa5050.vhd:463:33 */
  assign n249 = n248 ? fg_next : fg;
  /*# saa5050.vhd:461:29 */
  assign n251 = n225 == 5'b11101;
  /*# saa5050.vhd:469:29 */
  assign n253 = n225 == 5'b11110;
  /*# saa5050.vhd:472:29 */
  assign n255 = n225 == 5'b11111;
  /*# saa5050.vhd:427:29 */
  assign n256 = {n255, n253, n251, n246, n244, n242, n240, n238, n233, n229, n227};
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n258 = bg;
      11'b01000000000: n258 = bg;
      11'b00100000000: n258 = n249;
      11'b00010000000: n258 = 3'b000;
      11'b00001000000: n258 = bg;
      11'b00000100000: n258 = bg;
      11'b00000010000: n258 = bg;
      11'b00000001000: n258 = bg;
      11'b00000000100: n258 = bg;
      11'b00000000010: n258 = bg;
      11'b00000000001: n258 = bg;
      default: n258 = bg;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n260 = n194;
      11'b01000000000: n260 = n194;
      11'b00100000000: n260 = n194;
      11'b00010000000: n260 = n194;
      11'b00001000000: n260 = n194;
      11'b00000100000: n260 = n194;
      11'b00000010000: n260 = 1'b1;
      11'b00000001000: n260 = n194;
      11'b00000000100: n260 = n194;
      11'b00000000010: n260 = n194;
      11'b00000000001: n260 = n194;
      default: n260 = n194;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n263 = gfx_sep;
      11'b01000000000: n263 = gfx_sep;
      11'b00100000000: n263 = gfx_sep;
      11'b00010000000: n263 = gfx_sep;
      11'b00001000000: n263 = 1'b1;
      11'b00000100000: n263 = 1'b0;
      11'b00000010000: n263 = gfx_sep;
      11'b00000001000: n263 = gfx_sep;
      11'b00000000100: n263 = gfx_sep;
      11'b00000000010: n263 = gfx_sep;
      11'b00000000001: n263 = gfx_sep;
      default: n263 = gfx_sep;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n265 = n191;
      11'b01000000000: n265 = 1'b1;
      11'b00100000000: n265 = n191;
      11'b00010000000: n265 = n191;
      11'b00001000000: n265 = n191;
      11'b00000100000: n265 = n191;
      11'b00000010000: n265 = n191;
      11'b00000001000: n265 = n191;
      11'b00000000100: n265 = n191;
      11'b00000000010: n265 = n191;
      11'b00000000001: n265 = n191;
      default: n265 = n191;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n267 = n187;
      11'b01000000000: n267 = n187;
      11'b00100000000: n267 = n187;
      11'b00010000000: n267 = n187;
      11'b00001000000: n267 = n187;
      11'b00000100000: n267 = n187;
      11'b00000010000: n267 = n187;
      11'b00000001000: n267 = n187;
      11'b00000000100: n267 = n187;
      11'b00000000010: n267 = 1'b0;
      11'b00000000001: n267 = n187;
      default: n267 = n187;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n269 = n189;
      11'b01000000000: n269 = n189;
      11'b00100000000: n269 = n189;
      11'b00010000000: n269 = n189;
      11'b00001000000: n269 = n189;
      11'b00000100000: n269 = n189;
      11'b00000010000: n269 = n189;
      11'b00000001000: n269 = n189;
      11'b00000000100: n269 = 1'b0;
      11'b00000000010: n269 = n189;
      11'b00000000001: n269 = n189;
      default: n269 = n189;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n272 = 1'b1;
      11'b01000000000: n272 = 1'b0;
      11'b00100000000: n272 = 1'b0;
      11'b00010000000: n272 = 1'b0;
      11'b00001000000: n272 = 1'b0;
      11'b00000100000: n272 = 1'b0;
      11'b00000010000: n272 = 1'b0;
      11'b00000001000: n272 = 1'b0;
      11'b00000000100: n272 = 1'b0;
      11'b00000000010: n272 = 1'b0;
      11'b00000000001: n272 = 1'b0;
      default: n272 = 1'b0;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n275 = 1'b0;
      11'b01000000000: n275 = 1'b0;
      11'b00100000000: n275 = 1'b0;
      11'b00010000000: n275 = 1'b0;
      11'b00001000000: n275 = 1'b0;
      11'b00000100000: n275 = 1'b0;
      11'b00000010000: n275 = 1'b0;
      11'b00000001000: n275 = 1'b0;
      11'b00000000100: n275 = 1'b0;
      11'b00000000010: n275 = 1'b0;
      11'b00000000001: n275 = 1'b1;
      default: n275 = 1'b0;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n278 = 1'b0;
      11'b01000000000: n278 = 1'b0;
      11'b00100000000: n278 = 1'b0;
      11'b00010000000: n278 = 1'b0;
      11'b00001000000: n278 = 1'b0;
      11'b00000100000: n278 = 1'b0;
      11'b00000010000: n278 = 1'b0;
      11'b00000001000: n278 = 1'b1;
      11'b00000000100: n278 = 1'b0;
      11'b00000000010: n278 = 1'b0;
      11'b00000000001: n278 = 1'b0;
      default: n278 = 1'b0;
    endcase
  /*# saa5050.vhd:427:29 */
  always @*
    case (n256)
      11'b10000000000: n279 = n178;
      11'b01000000000: n279 = n178;
      11'b00100000000: n279 = n178;
      11'b00010000000: n279 = n178;
      11'b00001000000: n279 = n178;
      11'b00000100000: n279 = n178;
      11'b00000010000: n279 = n178;
      11'b00000001000: n279 = n236;
      11'b00000000100: n279 = n231;
      11'b00000000010: n279 = n178;
      11'b00000000001: n279 = n178;
      default: n279 = n178;
    endcase
  /*# saa5050.vhd:411:25 */
  assign n280 = n199 ? bg : n258;
  /*# saa5050.vhd:411:25 */
  assign n281 = n199 ? n194 : n260;
  /*# saa5050.vhd:411:25 */
  assign n282 = n199 ? gfx_sep : n263;
  /*# saa5050.vhd:411:25 */
  assign n283 = n199 ? n191 : n265;
  /*# saa5050.vhd:411:25 */
  assign n284 = n199 ? n187 : n267;
  /*# saa5050.vhd:411:25 */
  assign n285 = n199 ? n189 : n269;
  /*# saa5050.vhd:411:25 */
  assign n287 = n199 ? n215 : 3'b000;
  /*# saa5050.vhd:411:25 */
  assign n289 = n199 ? n217 : 1'b0;
  /*# saa5050.vhd:411:25 */
  assign n291 = n199 ? n219 : 1'b0;
  /*# saa5050.vhd:411:25 */
  assign n292 = n199 ? n221 : n272;
  /*# saa5050.vhd:411:25 */
  assign n294 = n199 ? 1'b0 : n275;
  /*# saa5050.vhd:411:25 */
  assign n296 = n199 ? 1'b0 : n278;
  /*# saa5050.vhd:411:25 */
  assign n298 = n199 ? n224 : 1'b0;
  /*# saa5050.vhd:411:25 */
  assign n299 = n199 ? n178 : n279;
  /*# saa5050.vhd:361:17 */
  assign n300 = n329 ? n280 : bg;
  /*# saa5050.vhd:410:21 */
  assign n301 = n197 ? n281 : n194;
  /*# saa5050.vhd:361:17 */
  assign n302 = n332 ? n282 : gfx_sep;
  /*# saa5050.vhd:410:21 */
  assign n303 = n197 ? n283 : n191;
  /*# saa5050.vhd:410:21 */
  assign n304 = n197 ? n284 : n187;
  /*# saa5050.vhd:410:21 */
  assign n305 = n197 ? n285 : n189;
  /*# saa5050.vhd:410:21 */
  assign n307 = n197 ? n287 : 3'b000;
  /*# saa5050.vhd:410:21 */
  assign n310 = n197 ? n289 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n313 = n197 ? n291 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n316 = n197 ? n292 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n319 = n197 ? n294 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n322 = n197 ? n296 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n325 = n197 ? n298 : 1'b0;
  /*# saa5050.vhd:410:21 */
  assign n327 = n197 ? n299 : n178;
  /*# saa5050.vhd:361:17 */
  assign n328 = n180 & n164;
  /*# saa5050.vhd:361:17 */
  assign n329 = n197 & n164;
  /*# saa5050.vhd:361:17 */
  assign n330 = n164 ? n301 : conceal;
  /*# saa5050.vhd:361:17 */
  assign n331 = n164 ? n185 : gfx;
  /*# saa5050.vhd:361:17 */
  assign n332 = n197 & n164;
  /*# saa5050.vhd:361:17 */
  assign n333 = n164 ? n303 : gfx_hold;
  /*# saa5050.vhd:361:17 */
  assign n334 = n164 ? n304 : is_flash;
  /*# saa5050.vhd:361:17 */
  assign n335 = n164 ? n305 : double_high;
  /*# saa5050.vhd:361:17 */
  assign n336 = n164 ? n307 : fg_next;
  /*# saa5050.vhd:361:17 */
  assign n337 = n164 ? n310 : alpha_next;
  /*# saa5050.vhd:361:17 */
  assign n338 = n164 ? n313 : gfx_next;
  /*# saa5050.vhd:361:17 */
  assign n339 = n164 ? n316 : gfx_release_next;
  /*# saa5050.vhd:361:17 */
  assign n340 = n164 ? n319 : is_flash_next;
  /*# saa5050.vhd:361:17 */
  assign n341 = n164 ? n322 : double_high_next;
  /*# saa5050.vhd:361:17 */
  assign n342 = n164 ? n325 : unconceal_next;
  /*# saa5050.vhd:361:17 */
  assign n343 = n165 & n164;
  /*# saa5050.vhd:361:17 */
  assign n344 = n164 ? n327 : last_gfx;
  /*# saa5050.vhd:340:17 */
  assign n346 = n162 ? 3'b111 : n181;
  /*# saa5050.vhd:340:17 */
  assign n348 = n162 ? 3'b000 : n300;
  /*# saa5050.vhd:340:17 */
  assign n350 = n162 ? 1'b0 : n330;
  /*# saa5050.vhd:340:17 */
  assign n352 = n162 ? 1'b0 : n331;
  /*# saa5050.vhd:340:17 */
  assign n354 = n162 ? 1'b0 : n302;
  /*# saa5050.vhd:340:17 */
  assign n356 = n162 ? 1'b0 : n333;
  /*# saa5050.vhd:340:17 */
  assign n358 = n162 ? 1'b0 : n334;
  /*# saa5050.vhd:340:17 */
  assign n360 = n162 ? 1'b0 : n335;
  /*# saa5050.vhd:340:17 */
  assign n362 = n162 ? 3'b000 : n336;
  /*# saa5050.vhd:340:17 */
  assign n364 = n162 ? 1'b0 : n337;
  /*# saa5050.vhd:340:17 */
  assign n366 = n162 ? 1'b0 : n338;
  /*# saa5050.vhd:340:17 */
  assign n368 = n162 ? 1'b0 : n339;
  /*# saa5050.vhd:340:17 */
  assign n370 = n162 ? 1'b0 : n340;
  /*# saa5050.vhd:340:17 */
  assign n372 = n162 ? 1'b0 : n341;
  /*# saa5050.vhd:340:17 */
  assign n374 = n162 ? 1'b0 : n342;
  /*# saa5050.vhd:340:17 */
  assign n376 = n162 ? 1'b0 : n177;
  /*# saa5050.vhd:340:17 */
  assign n378 = n162 ? 7'b0000000 : n344;
  /*# saa5050.vhd:490:63 */
  assign n448 = ~double_high;
  /*# saa5050.vhd:490:46 */
  assign n449 = n448 ? line_counter : n454;
  /*# saa5050.vhd:491:32 */
  assign n450 = line_counter[3:1]; // extract
  /*# saa5050.vhd:491:18 */
  assign n452 = {1'b0, n450};
  /*# saa5050.vhd:491:64 */
  assign n453 = ~double_high2;
  /*# saa5050.vhd:490:69 */
  assign n454 = n453 ? n452 : n459;
  /*# saa5050.vhd:492:32 */
  assign n455 = line_counter[3:1]; // extract
  /*# saa5050.vhd:492:18 */
  assign n457 = {1'b0, n455};
  /*# saa5050.vhd:492:46 */
  assign n459 = n457 + 4'b0101;
  /*# saa5050.vhd:494:54 */
  assign n461 = code_r[6:5]; // extract
  /*# saa5050.vhd:494:67 */
  assign n463 = n461 == 2'b00;
  /*# saa5050.vhd:494:44 */
  assign n464 = n463 & gfx_hold;
  /*# saa5050.vhd:494:24 */
  assign n465 = n464 ? 1'b1 : 1'b0;
  /*# saa5050.vhd:496:55 */
  assign n468 = ~double_high;
  /*# saa5050.vhd:496:61 */
  assign n469 = double_high2 & n468;
  /*# saa5050.vhd:496:37 */
  assign n470 = n469 ? 12'b000000000000 : n473;
  /*# saa5050.vhd:497:25 */
  assign n471 = {gfx, last_gfx};
  /*# saa5050.vhd:497:36 */
  assign n472 = {n471, line_addr};
  /*# saa5050.vhd:496:85 */
  assign n473 = hold_active ? n472 : n475;
  /*# saa5050.vhd:498:25 */
  assign n474 = {gfx, code_r};
  /*# saa5050.vhd:498:34 */
  assign n475 = {n474, line_addr};
  /*# saa5050.vhd:501:34 */
  assign n477 = rom_address1 + 12'b000000000001;
  /*# saa5050.vhd:501:57 */
  assign n478 = ~double_high;
  /*# saa5050.vhd:501:71 */
  assign n479 = ~CRS;
  /*# saa5050.vhd:501:63 */
  assign n480 = n479 & n478;
  /*# saa5050.vhd:501:116 */
  assign n481 = line_counter[0]; // extract
  /*# saa5050.vhd:501:100 */
  assign n482 = n481 & double_high;
  /*# saa5050.vhd:501:78 */
  assign n483 = n480 | n482;
  /*# saa5050.vhd:501:38 */
  assign n484 = n483 ? n477 : n486;
  /*# saa5050.vhd:502:34 */
  assign n486 = rom_address1 - 12'b000000000001;
  /*# saa5050.vhd:520:19 */
  assign n491 = ~nRESET;
  /*# saa5050.vhd:524:58 */
  assign n494 = pixel_counter == 4'b0000;
  /*# saa5050.vhd:524:40 */
  assign n495 = n494 & disp_enable_r;
  /*# saa5050.vhd:528:35 */
  assign n496 = rom_data1[5]; // extract
  /*# saa5050.vhd:528:50 */
  assign n497 = rom_data1[5]; // extract
  /*# saa5050.vhd:528:39 */
  assign n498 = {n496, n497};
  /*# saa5050.vhd:529:35 */
  assign n499 = rom_data1[4]; // extract
  /*# saa5050.vhd:528:54 */
  assign n500 = {n498, n499};
  /*# saa5050.vhd:529:50 */
  assign n501 = rom_data1[4]; // extract
  /*# saa5050.vhd:529:39 */
  assign n502 = {n500, n501};
  /*# saa5050.vhd:530:35 */
  assign n503 = rom_data1[3]; // extract
  /*# saa5050.vhd:529:54 */
  assign n504 = {n502, n503};
  /*# saa5050.vhd:530:50 */
  assign n505 = rom_data1[3]; // extract
  /*# saa5050.vhd:530:39 */
  assign n506 = {n504, n505};
  /*# saa5050.vhd:531:35 */
  assign n507 = rom_data1[2]; // extract
  /*# saa5050.vhd:530:54 */
  assign n508 = {n506, n507};
  /*# saa5050.vhd:531:50 */
  assign n509 = rom_data1[2]; // extract
  /*# saa5050.vhd:531:39 */
  assign n510 = {n508, n509};
  /*# saa5050.vhd:532:35 */
  assign n511 = rom_data1[1]; // extract
  /*# saa5050.vhd:531:54 */
  assign n512 = {n510, n511};
  /*# saa5050.vhd:532:50 */
  assign n513 = rom_data1[1]; // extract
  /*# saa5050.vhd:532:39 */
  assign n514 = {n512, n513};
  /*# saa5050.vhd:533:35 */
  assign n515 = rom_data1[0]; // extract
  /*# saa5050.vhd:532:54 */
  assign n516 = {n514, n515};
  /*# saa5050.vhd:533:50 */
  assign n517 = rom_data1[0]; // extract
  /*# saa5050.vhd:533:39 */
  assign n518 = {n516, n517};
  /*# saa5050.vhd:536:35 */
  assign n519 = rom_data2[5]; // extract
  /*# saa5050.vhd:536:50 */
  assign n520 = rom_data2[5]; // extract
  /*# saa5050.vhd:536:39 */
  assign n521 = {n519, n520};
  /*# saa5050.vhd:537:35 */
  assign n522 = rom_data2[4]; // extract
  /*# saa5050.vhd:536:54 */
  assign n523 = {n521, n522};
  /*# saa5050.vhd:537:50 */
  assign n524 = rom_data2[4]; // extract
  /*# saa5050.vhd:537:39 */
  assign n525 = {n523, n524};
  /*# saa5050.vhd:538:35 */
  assign n526 = rom_data2[3]; // extract
  /*# saa5050.vhd:537:54 */
  assign n527 = {n525, n526};
  /*# saa5050.vhd:538:50 */
  assign n528 = rom_data2[3]; // extract
  /*# saa5050.vhd:538:39 */
  assign n529 = {n527, n528};
  /*# saa5050.vhd:539:35 */
  assign n530 = rom_data2[2]; // extract
  /*# saa5050.vhd:538:54 */
  assign n531 = {n529, n530};
  /*# saa5050.vhd:539:50 */
  assign n532 = rom_data2[2]; // extract
  /*# saa5050.vhd:539:39 */
  assign n533 = {n531, n532};
  /*# saa5050.vhd:540:35 */
  assign n534 = rom_data2[1]; // extract
  /*# saa5050.vhd:539:54 */
  assign n535 = {n533, n534};
  /*# saa5050.vhd:540:50 */
  assign n536 = rom_data2[1]; // extract
  /*# saa5050.vhd:540:39 */
  assign n537 = {n535, n536};
  /*# saa5050.vhd:541:35 */
  assign n538 = rom_data2[0]; // extract
  /*# saa5050.vhd:540:54 */
  assign n539 = {n537, n538};
  /*# saa5050.vhd:541:50 */
  assign n540 = rom_data2[0]; // extract
  /*# saa5050.vhd:541:39 */
  assign n541 = {n539, n540};
  /*# saa5050.vhd:547:33 */
  assign n542 = rom_data1[7]; // extract
  /*# saa5050.vhd:549:41 */
  assign n543 = ~hold_active;
  /*# saa5050.vhd:549:47 */
  assign n544 = gfx_sep & n543;
  /*# saa5050.vhd:549:88 */
  assign n545 = last_gfx_sep & hold_active;
  /*# saa5050.vhd:549:66 */
  assign n546 = n544 | n545;
  /*# saa5050.vhd:554:42 */
  assign n552 = line_addr == 4'b0010;
  /*# saa5050.vhd:554:59 */
  assign n554 = line_addr == 4'b0110;
  /*# saa5050.vhd:554:46 */
  assign n555 = n552 | n554;
  /*# saa5050.vhd:554:76 */
  assign n557 = line_addr == 4'b1001;
  /*# saa5050.vhd:554:63 */
  assign n558 = n555 | n557;
  /*# saa5050.vhd:517:14 */
  assign n560 = n518[3:0]; // extract
  /*# saa5050.vhd:517:14 */
  assign n561 = n518[9:6]; // extract
  /*# saa5050.vhd:517:14 */
  assign n562 = {1'b0, 1'b0, n561, 1'b0, 1'b0, n560};
  /*# saa5050.vhd:554:29 */
  assign n563 = n558 ? 12'b000000000000 : n562;
  /*# saa5050.vhd:549:25 */
  assign n564 = n546 ? n563 : n518;
  /*# saa5050.vhd:561:38 */
  assign n565 = n518[11:1]; // extract
  /*# saa5050.vhd:561:35 */
  assign n567 = {1'b0, n565};
  /*# saa5050.vhd:561:53 */
  assign n568 = n567 & n541;
  /*# saa5050.vhd:561:74 */
  assign n569 = n541[11:1]; // extract
  /*# saa5050.vhd:561:71 */
  assign n571 = {1'b0, n569};
  /*# saa5050.vhd:561:63 */
  assign n572 = ~n571;
  /*# saa5050.vhd:561:59 */
  assign n573 = n568 & n572;
  /*# saa5050.vhd:560:32 */
  assign n574 = n518 | n573;
  /*# saa5050.vhd:562:32 */
  assign n575 = n518[10:0]; // extract
  /*# saa5050.vhd:562:46 */
  assign n577 = {n575, 1'b0};
  /*# saa5050.vhd:562:53 */
  assign n578 = n577 & n541;
  /*# saa5050.vhd:562:68 */
  assign n579 = n541[10:0]; // extract
  /*# saa5050.vhd:562:82 */
  assign n581 = {n579, 1'b0};
  /*# saa5050.vhd:562:63 */
  assign n582 = ~n581;
  /*# saa5050.vhd:562:59 */
  assign n583 = n578 & n582;
  /*# saa5050.vhd:561:90 */
  assign n584 = n574 | n583;
  /*# saa5050.vhd:547:21 */
  assign n585 = n542 ? n564 : n584;
  /*# saa5050.vhd:571:43 */
  assign n586 = shift_reg[10:0]; // extract
  /*# saa5050.vhd:571:57 */
  assign n588 = {n586, 1'b0};
  /*# saa5050.vhd:524:17 */
  assign n589 = n495 ? n585 : n588;
  /*# saa5050.vhd:585:35 */
  assign n607 = shift_reg[11]; // extract
  /*# saa5050.vhd:585:56 */
  assign n608 = flash & is_flash_r;
  /*# saa5050.vhd:585:72 */
  assign n609 = n608 | conceal_r;
  /*# saa5050.vhd:585:44 */
  assign n610 = ~n609;
  /*# saa5050.vhd:585:40 */
  assign n611 = n607 & n610;
  /*# saa5050.vhd:592:30 */
  assign n612 = fg_r[0]; // extract
  /*# saa5050.vhd:593:30 */
  assign n613 = fg_r[1]; // extract
  /*# saa5050.vhd:594:30 */
  assign n614 = fg_r[2]; // extract
  /*# saa5050.vhd:596:30 */
  assign n615 = bg_r[0]; // extract
  /*# saa5050.vhd:597:30 */
  assign n616 = bg_r[1]; // extract
  /*# saa5050.vhd:598:30 */
  assign n617 = bg_r[2]; // extract
  /*# saa5050.vhd:591:17 */
  assign n618 = n611 ? n612 : n615;
  /*# saa5050.vhd:591:17 */
  assign n619 = n611 ? n613 : n616;
  /*# saa5050.vhd:591:17 */
  assign n620 = n611 ? n614 : n617;
  /*# saa5050.vhd:583:9 */
  assign n632 = CLKEN ? n618 : n633;
  /*# saa5050.vhd:583:9 */
  always @(posedge CLOCK)
    n633 <= n632;
  /*# saa5050.vhd:583:9 */
  assign n634 = CLKEN ? n619 : n635;
  /*# saa5050.vhd:583:9 */
  always @(posedge CLOCK)
    n635 <= n634;
  /*# saa5050.vhd:583:9 */
  assign n636 = CLKEN ? n620 : n637;
  /*# saa5050.vhd:583:9 */
  always @(posedge CLOCK)
    n637 <= n636;
  /*# saa5050.vhd:583:9 */
  assign n638 = CLKEN ? n611 : n639;
  /*# saa5050.vhd:583:9 */
  always @(posedge CLOCK)
    n639 <= n638;
  /*# saa5050.vhd:201:9 */
  assign n640 = DI_CLKEN ? DI : di_tmp;
  /*# saa5050.vhd:201:9 */
  always @(posedge DI_CLOCK or posedge n11)
    if (n11)
      n641 <= 7'b0000000;
    else
      n641 <= n640;
  /*# saa5050.vhd:201:9 */
  assign n642 = DI_CLKEN ? di_tmp : di_r;
  /*# saa5050.vhd:201:9 */
  always @(posedge DI_CLOCK or posedge n11)
    if (n11)
      n643 <= 7'b0000000;
    else
      n643 <= n642;
  /*# saa5050.vhd:201:9 */
  assign n644 = DI_CLKEN ? DEW : dew_r;
  /*# saa5050.vhd:201:9 */
  always @(posedge DI_CLOCK or posedge n11)
    if (n11)
      n645 <= 1'b0;
    else
      n645 <= n644;
  /*# saa5050.vhd:201:9 */
  assign n646 = DI_CLKEN ? LOSE : lose_r;
  /*# saa5050.vhd:201:9 */
  always @(posedge DI_CLOCK or posedge n11)
    if (n11)
      n647 <= 1'b0;
    else
      n647 <= n646;
  /*# saa5050.vhd:222:9 */
  assign n648 = CLKEN ? di_r : code;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n649 <= 7'b0000000;
    else
      n649 <= n648;
  /*# saa5050.vhd:250:9 */
  assign n650 = n121 ? lose_r : disp_enable;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n651 <= 1'b0;
    else
      n651 <= n650;
  /*# saa5050.vhd:250:9 */
  assign n652 = CLKEN ? dew_r : dew_latch;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n653 <= 1'b0;
    else
      n653 <= n652;
  /*# saa5050.vhd:250:9 */
  assign n654 = CLKEN ? lose_r : lose_latch;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n655 <= 1'b0;
    else
      n655 <= n654;
  /*# saa5050.vhd:250:9 */
  assign n656 = CLKEN ? disp_enable : disp_enable_latch;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n657 <= 1'b0;
    else
      n657 <= n656;
  /*# saa5050.vhd:250:9 */
  assign n658 = CLKEN ? n116 : line_counter;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n659 <= 4'b0000;
    else
      n659 <= n658;
  /*# saa5050.vhd:250:9 */
  assign n660 = CLKEN ? n91 : pixel_counter;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n661 <= 4'b0000;
    else
      n661 <= n660;
  /*# saa5050.vhd:250:9 */
  assign n662 = n127 ? n95 : flash_counter;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n663 <= 6'b000000;
    else
      n663 <= n662;
  /*# saa5050.vhd:522:9 */
  assign n664 = CLKEN ? n589 : shift_reg;
  /*# saa5050.vhd:522:9 */
  always @(posedge CLOCK or posedge n491)
    if (n491)
      n665 <= 12'b000000000000;
    else
      n665 <= n664;
  /*# saa5050.vhd:337:9 */
  assign n666 = CLKEN ? n346 : fg;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n667 <= 3'b111;
    else
      n667 <= n666;
  /*# saa5050.vhd:337:9 */
  assign n668 = CLKEN ? n348 : bg;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n669 <= 3'b000;
    else
      n669 <= n668;
  /*# saa5050.vhd:337:9 */
  assign n670 = CLKEN ? n350 : conceal;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n671 <= 1'b0;
    else
      n671 <= n670;
  /*# saa5050.vhd:337:9 */
  assign n672 = CLKEN ? n352 : gfx;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n673 <= 1'b0;
    else
      n673 <= n672;
  /*# saa5050.vhd:337:9 */
  assign n674 = CLKEN ? n354 : gfx_sep;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n675 <= 1'b0;
    else
      n675 <= n674;
  /*# saa5050.vhd:337:9 */
  assign n676 = CLKEN ? n356 : gfx_hold;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n677 <= 1'b0;
    else
      n677 <= n676;
  /*# saa5050.vhd:337:9 */
  assign n678 = CLKEN ? n358 : is_flash;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n679 <= 1'b0;
    else
      n679 <= n678;
  /*# saa5050.vhd:337:9 */
  assign n680 = CLKEN ? n360 : double_high;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n681 <= 1'b0;
    else
      n681 <= n680;
  /*# saa5050.vhd:337:9 */
  assign n682 = CLKEN ? n362 : fg_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n683 <= 3'b000;
    else
      n683 <= n682;
  /*# saa5050.vhd:337:9 */
  assign n684 = CLKEN ? n364 : alpha_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n685 <= 1'b0;
    else
      n685 <= n684;
  /*# saa5050.vhd:337:9 */
  assign n686 = CLKEN ? n366 : gfx_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n687 <= 1'b0;
    else
      n687 <= n686;
  /*# saa5050.vhd:337:9 */
  assign n688 = CLKEN ? n368 : gfx_release_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n689 <= 1'b0;
    else
      n689 <= n688;
  /*# saa5050.vhd:337:9 */
  assign n690 = CLKEN ? n370 : is_flash_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n691 <= 1'b0;
    else
      n691 <= n690;
  /*# saa5050.vhd:337:9 */
  assign n692 = CLKEN ? n372 : double_high_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n693 <= 1'b0;
    else
      n693 <= n692;
  /*# saa5050.vhd:337:9 */
  assign n694 = CLKEN ? n374 : unconceal_next;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n695 <= 1'b0;
    else
      n695 <= n694;
  /*# saa5050.vhd:222:9 */
  assign n696 = n43 ? code : code_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n697 <= 7'b0000000;
    else
      n697 <= n696;
  /*# saa5050.vhd:222:9 */
  assign n698 = n44 ? disp_enable : disp_enable_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n699 <= 1'b0;
    else
      n699 <= n698;
  /*# saa5050.vhd:222:9 */
  assign n700 = n45 ? fg : fg_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n701 <= 3'b000;
    else
      n701 <= n700;
  /*# saa5050.vhd:222:9 */
  assign n702 = n46 ? bg : bg_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n703 <= 3'b000;
    else
      n703 <= n702;
  /*# saa5050.vhd:222:9 */
  assign n704 = n47 ? conceal : conceal_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n705 <= 1'b0;
    else
      n705 <= n704;
  /*# saa5050.vhd:222:9 */
  assign n706 = n48 ? is_flash : is_flash_r;
  /*# saa5050.vhd:222:9 */
  always @(posedge CLOCK or posedge n32)
    if (n32)
      n707 <= 1'b0;
    else
      n707 <= n706;
  /*# saa5050.vhd:337:9 */
  assign n708 = CLKEN ? n376 : last_gfx_sep;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n709 <= 1'b0;
    else
      n709 <= n708;
  /*# saa5050.vhd:337:9 */
  assign n710 = CLKEN ? n378 : last_gfx;
  /*# saa5050.vhd:337:9 */
  always @(posedge CLOCK or posedge n160)
    if (n160)
      n711 <= 7'b0000000;
    else
      n711 <= n710;
  /*# saa5050.vhd:250:9 */
  assign n712 = CLKEN ? n118 : double_high1;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n713 <= 1'b0;
    else
      n713 <= n712;
  /*# saa5050.vhd:250:9 */
  assign n714 = CLKEN ? n120 : double_high2;
  /*# saa5050.vhd:250:9 */
  always @(posedge CLOCK or posedge n73)
    if (n73)
      n715 <= 1'b0;
    else
      n715 <= n714;
endmodule


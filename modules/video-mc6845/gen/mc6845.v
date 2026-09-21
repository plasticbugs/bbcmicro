module mc6845
  (input  CLOCK,
   input  CLKEN,
   input  CLKEN_CPU,
   input  nRESET,
   input  ENABLE,
   input  R_nW,
   input  RS,
   input  [7:0] DI,
   output [7:0] DO,
   output VSYNC,
   output HSYNC,
   output DE,
   output CURSOR,
   input  LPSTB,
   input  VGA,
   input  NO_ILACE,
   output [13:0] MA,
   output [4:0] RA,
   output [3:0] test);
  wire [4:0] addr_reg;
  wire [7:0] r00_h_total;
  wire [7:0] r01_h_displayed;
  wire [7:0] r02_h_sync_pos;
  wire [3:0] r03_v_sync_width;
  wire [3:0] r03_h_sync_width;
  wire [6:0] r04_v_total;
  wire [4:0] r05_v_total_adj;
  wire [6:0] r06_v_displayed;
  wire [6:0] r07_v_sync_pos;
  wire [7:0] r08_interlace;
  wire [4:0] r09_max_scanline_addr;
  wire [1:0] r10_cursor_mode;
  wire [4:0] r10_cursor_start;
  wire [4:0] r11_cursor_end;
  wire [5:0] r12_start_addr_h;
  wire [7:0] r13_start_addr_l;
  wire [5:0] r14_cursor_h;
  wire [7:0] r15_cursor_l;
  wire [5:0] r16_light_pen_h;
  wire [7:0] r17_light_pen_l;
  wire [7:0] h_counter;
  wire [3:0] h_sync_counter;
  wire [6:0] row_counter;
  wire [6:0] row_counter_next;
  wire [4:0] line_counter;
  wire [4:0] line_counter_next;
  wire [3:0] v_sync_counter;
  wire [4:0] field_counter;
  wire h_display;
  wire hs;
  wire v_display;
  wire vs;
  wire vs_hit;
  wire vs_hit_last;
  wire vs_even;
  wire vs_odd;
  wire odd_field;
  wire [13:0] ma_i;
  wire [3:0] lpstb_sync;
  wire de0;
  wire de1;
  wire de2;
  wire cursor0;
  wire cursor1;
  wire cursor2;
  wire interlaced_video;
  wire [4:0] max_scanline;
  wire [4:0] adj_scanline;
  wire [13:0] ma_row;
  wire in_adj;
  wire adj_in_progress;
  wire [2:0] sol;
  wire eom_latched;
  wire eof_latched;
  wire first_scanline;
  wire extra_scanline;
  wire new_frame;
  wire r00_h_total_hit;
  wire max_scanline_hit;
  wire [4:0] n9;
  wire [4:0] n10;
  wire [3:0] n11;
  wire [4:0] n13;
  wire [1:0] n14;
  wire n16;
  wire [4:0] n17;
  wire n19;
  wire n20;
  wire n21;
  wire n22;
  wire [4:0] n25;
  wire [1:0] n26;
  wire n28;
  wire n29;
  wire [4:0] n30;
  wire n32;
  wire n33;
  wire n36;
  wire n37;
  wire n38;
  wire n39;
  wire n40;
  wire n41;
  wire n42;
  wire n43;
  wire n44;
  wire n45;
  wire n46;
  wire n50;
  wire [7:0] n53;
  wire n55;
  wire n57;
  wire [7:0] n59;
  wire n61;
  wire n63;
  wire [7:0] n65;
  wire n67;
  wire n69;
  wire [5:0] n70;
  reg [7:0] n72;
  wire n73;
  wire [4:0] n74;
  wire n76;
  wire n78;
  wire n80;
  wire [3:0] n81;
  wire [3:0] n82;
  wire n84;
  wire [6:0] n85;
  wire n87;
  wire [4:0] n88;
  wire n90;
  wire [6:0] n91;
  wire n93;
  wire [6:0] n94;
  wire n96;
  wire n98;
  wire [4:0] n99;
  wire n101;
  wire [1:0] n102;
  wire [4:0] n103;
  wire n105;
  wire [4:0] n106;
  wire n108;
  wire [5:0] n109;
  wire n111;
  wire n113;
  wire [5:0] n114;
  wire n116;
  wire n118;
  wire [15:0] n119;
  reg [7:0] n120;
  reg [7:0] n121;
  reg [7:0] n122;
  reg [3:0] n123;
  reg [3:0] n124;
  reg [6:0] n125;
  reg [4:0] n126;
  reg [6:0] n127;
  reg [6:0] n128;
  reg [7:0] n129;
  reg [4:0] n130;
  reg [1:0] n131;
  reg [4:0] n132;
  reg [4:0] n133;
  reg [5:0] n134;
  reg [7:0] n135;
  reg [5:0] n136;
  reg [7:0] n137;
  wire [4:0] n138;
  wire [7:0] n139;
  wire [7:0] n140;
  wire [7:0] n141;
  wire [3:0] n142;
  wire [3:0] n143;
  wire [6:0] n144;
  wire [4:0] n145;
  wire [6:0] n146;
  wire [6:0] n147;
  wire [7:0] n148;
  wire [4:0] n149;
  wire [1:0] n150;
  wire [4:0] n151;
  wire [4:0] n152;
  wire [5:0] n153;
  wire [7:0] n154;
  wire [5:0] n155;
  wire [7:0] n156;
  wire n157;
  wire [7:0] n158;
  wire [7:0] n159;
  wire [7:0] n160;
  wire [3:0] n161;
  wire [3:0] n162;
  wire [6:0] n163;
  wire [4:0] n164;
  wire [6:0] n165;
  wire [6:0] n166;
  wire [7:0] n167;
  wire [4:0] n168;
  wire [1:0] n169;
  wire [4:0] n170;
  wire [4:0] n171;
  wire [5:0] n172;
  wire [7:0] n173;
  wire [5:0] n174;
  wire [7:0] n175;
  wire [4:0] n177;
  wire [7:0] n178;
  wire [7:0] n179;
  wire [7:0] n180;
  wire [3:0] n181;
  wire [3:0] n182;
  wire [6:0] n183;
  wire [4:0] n184;
  wire [6:0] n185;
  wire [6:0] n186;
  wire [7:0] n187;
  wire [4:0] n188;
  wire [1:0] n189;
  wire [4:0] n190;
  wire [4:0] n191;
  wire [5:0] n192;
  wire [7:0] n193;
  wire [5:0] n194;
  wire [7:0] n195;
  wire n196;
  wire n279;
  wire [7:0] n282;
  wire [7:0] n284;
  wire n292;
  wire n294;
  wire [3:0] n296;
  wire [3:0] n298;
  wire n306;
  wire n308;
  wire n309;
  wire n311;
  wire n313;
  wire n320;
  wire n322;
  wire n323;
  wire n324;
  wire n326;
  wire n328;
  wire n330;
  wire n337;
  wire [4:0] n339;
  wire [4:0] n341;
  wire [4:0] n348;
  wire [4:0] n350;
  wire [1:0] n351;
  wire n353;
  wire n354;
  wire n355;
  wire n356;
  wire n357;
  wire [4:0] n358;
  wire [3:0] n359;
  wire [3:0] n361;
  wire [4:0] n363;
  wire n366;
  wire [6:0] n374;
  wire [6:0] n376;
  wire n377;
  wire [6:0] n378;
  wire n380;
  wire n381;
  wire n385;
  wire n387;
  wire n388;
  wire [3:0] n390;
  wire [3:0] n391;
  wire [3:0] n393;
  wire n404;
  wire n406;
  wire n407;
  wire n408;
  wire n409;
  wire n410;
  wire n412;
  wire n414;
  wire [6:0] n422;
  wire [7:0] n424;
  wire n425;
  wire n427;
  wire n430;
  wire n431;
  wire n432;
  wire n433;
  wire n434;
  wire n435;
  wire n436;
  wire n437;
  wire n440;
  wire n442;
  wire n444;
  wire n445;
  wire n446;
  wire [4:0] n448;
  wire [4:0] n449;
  wire n451;
  wire [4:0] n452;
  wire n454;
  wire n468;
  wire [1:0] n470;
  wire [2:0] n471;
  wire n472;
  wire n473;
  wire n474;
  wire n475;
  wire n477;
  wire n479;
  wire n480;
  wire n481;
  wire n482;
  wire n485;
  wire n486;
  wire n488;
  wire n489;
  wire n490;
  wire n491;
  wire n492;
  wire n494;
  wire n496;
  wire n497;
  wire n498;
  wire n500;
  wire n502;
  wire n504;
  wire n506;
  wire n507;
  wire n508;
  wire n509;
  wire n510;
  wire n511;
  wire n512;
  wire n513;
  wire n515;
  wire n517;
  wire n549;
  wire [13:0] n551;
  wire n552;
  wire n553;
  wire [13:0] n554;
  wire [13:0] n555;
  wire [13:0] n556;
  wire [13:0] n558;
  wire [13:0] n559;
  wire [13:0] n560;
  wire [1:0] n573;
  wire n575;
  wire n576;
  wire n577;
  wire n580;
  wire n582;
  wire [3:0] n585;
  wire [4:0] n586;
  wire [4:0] n587;
  wire n590;
  wire [2:0] n592;
  wire [3:0] n593;
  wire n594;
  wire n595;
  wire n596;
  wire n597;
  wire [5:0] n598;
  wire [7:0] n599;
  wire n602;
  wire n603;
  wire n616;
  wire n617;
  wire n618;
  wire [13:0] n619;
  wire n620;
  wire n621;
  wire n622;
  wire n623;
  wire n624;
  wire n625;
  wire n626;
  wire n627;
  wire n629;
  wire n630;
  wire n631;
  wire n633;
  wire n634;
  wire n637;
  wire n638;
  wire n653;
  wire [1:0] n654;
  wire n656;
  wire n657;
  wire n658;
  wire [1:0] n660;
  wire n662;
  wire n663;
  wire [1:0] n664;
  wire n666;
  wire n667;
  wire [1:0] n668;
  wire n670;
  wire n671;
  wire [1:0] n672;
  wire n674;
  wire n675;
  wire [1:0] n676;
  wire n678;
  wire n679;
  wire n682;
  wire n683;
  wire n684;
  wire n685;
  wire n688;
  wire n689;
  wire n690;
  wire n693;
  wire n694;
  wire n695;
  wire n697;
  wire n698;
  wire n699;
  wire n702;
  wire n703;
  wire n705;
  wire n706;
  wire n707;
  wire [3:0] n710;
  wire [7:0] n711;
  reg [7:0] n712;
  wire [4:0] n713;
  reg [4:0] n714;
  wire [7:0] n715;
  reg [7:0] n716;
  wire [7:0] n717;
  reg [7:0] n718;
  wire [7:0] n719;
  reg [7:0] n720;
  wire [3:0] n721;
  reg [3:0] n722;
  wire [3:0] n723;
  reg [3:0] n724;
  wire [6:0] n725;
  reg [6:0] n726;
  wire [4:0] n727;
  reg [4:0] n728;
  wire [6:0] n729;
  reg [6:0] n730;
  wire [6:0] n731;
  reg [6:0] n732;
  wire [7:0] n733;
  reg [7:0] n734;
  wire [4:0] n735;
  reg [4:0] n736;
  wire [1:0] n737;
  reg [1:0] n738;
  wire [4:0] n739;
  reg [4:0] n740;
  wire [4:0] n741;
  reg [4:0] n742;
  wire [5:0] n743;
  reg [5:0] n744;
  wire [7:0] n745;
  reg [7:0] n746;
  wire [5:0] n747;
  reg [5:0] n748;
  wire [7:0] n749;
  reg [7:0] n750;
  wire [5:0] n751;
  reg [5:0] n752;
  wire [7:0] n753;
  reg [7:0] n754;
  wire [7:0] n755;
  reg [7:0] n756;
  wire [3:0] n757;
  reg [3:0] n758;
  wire [6:0] n759;
  reg [6:0] n760;
  wire [4:0] n761;
  reg [4:0] n762;
  wire [3:0] n763;
  reg [3:0] n764;
  reg [4:0] n765;
  reg n766;
  reg n767;
  reg n768;
  wire n769;
  wire n770;
  wire n771;
  reg n772;
  reg n773;
  wire n774;
  reg n775;
  wire n776;
  reg n777;
  wire [13:0] n778;
  reg [13:0] n779;
  wire [3:0] n780;
  reg [3:0] n781;
  wire n782;
  reg n783;
  wire n784;
  reg n785;
  wire n786;
  reg n787;
  wire n788;
  reg n789;
  wire n790;
  reg n791;
  wire [13:0] n792;
  reg [13:0] n793;
  wire n794;
  reg n795;
  wire n796;
  reg n797;
  wire [2:0] n798;
  reg [2:0] n799;
  wire n800;
  reg n801;
  wire n802;
  reg n803;
  wire n804;
  reg n805;
  wire n806;
  reg n807;
  assign DO = n712; //(module output)
  assign VSYNC = vs; //(module output)
  assign HSYNC = hs; //(module output)
  assign DE = n663; //(module output)
  assign CURSOR = n671; //(module output)
  assign MA = ma_i; //(module output)
  assign RA = n587; //(module output)
  assign test = n710; //(module output)
  /*# mc6845.vhd:90:8 */
  assign addr_reg = n714; // (signal)
  /*# mc6845.vhd:93:8 */
  assign r00_h_total = n716; // (signal)
  /*# mc6845.vhd:94:8 */
  assign r01_h_displayed = n718; // (signal)
  /*# mc6845.vhd:95:8 */
  assign r02_h_sync_pos = n720; // (signal)
  /*# mc6845.vhd:96:8 */
  assign r03_v_sync_width = n722; // (signal)
  /*# mc6845.vhd:97:8 */
  assign r03_h_sync_width = n724; // (signal)
  /*# mc6845.vhd:98:8 */
  assign r04_v_total = n726; // (signal)
  /*# mc6845.vhd:99:8 */
  assign r05_v_total_adj = n728; // (signal)
  /*# mc6845.vhd:100:8 */
  assign r06_v_displayed = n730; // (signal)
  /*# mc6845.vhd:101:8 */
  assign r07_v_sync_pos = n732; // (signal)
  /*# mc6845.vhd:102:8 */
  assign r08_interlace = n734; // (signal)
  /*# mc6845.vhd:103:8 */
  assign r09_max_scanline_addr = n736; // (signal)
  /*# mc6845.vhd:104:8 */
  assign r10_cursor_mode = n738; // (signal)
  /*# mc6845.vhd:105:8 */
  assign r10_cursor_start = n740; // (signal)
  /*# mc6845.vhd:106:8 */
  assign r11_cursor_end = n742; // (signal)
  /*# mc6845.vhd:107:8 */
  assign r12_start_addr_h = n744; // (signal)
  /*# mc6845.vhd:108:8 */
  assign r13_start_addr_l = n746; // (signal)
  /*# mc6845.vhd:110:8 */
  assign r14_cursor_h = n748; // (signal)
  /*# mc6845.vhd:111:8 */
  assign r15_cursor_l = n750; // (signal)
  /*# mc6845.vhd:113:8 */
  assign r16_light_pen_h = n752; // (signal)
  /*# mc6845.vhd:114:8 */
  assign r17_light_pen_l = n754; // (signal)
  /*# mc6845.vhd:118:8 */
  assign h_counter = n756; // (signal)
  /*# mc6845.vhd:120:8 */
  assign h_sync_counter = n758; // (signal)
  /*# mc6845.vhd:122:8 */
  assign row_counter = n760; // (signal)
  /*# mc6845.vhd:123:8 */
  assign row_counter_next = n374; // (signal)
  /*# mc6845.vhd:125:8 */
  assign line_counter = n762; // (signal)
  /*# mc6845.vhd:126:8 */
  assign line_counter_next = n348; // (signal)
  /*# mc6845.vhd:128:8 */
  assign v_sync_counter = n764; // (signal)
  /*# mc6845.vhd:130:8 */
  assign field_counter = n765; // (signal)
  /*# mc6845.vhd:133:8 */
  assign h_display = n766; // (signal)
  /*# mc6845.vhd:134:8 */
  assign hs = n767; // (signal)
  /*# mc6845.vhd:135:8 */
  assign v_display = n768; // (signal)
  /*# mc6845.vhd:136:8 */
  assign vs = n437; // (signal)
  /*# mc6845.vhd:137:8 */
  assign vs_hit = n381; // (signal)
  /*# mc6845.vhd:138:8 */
  assign vs_hit_last = n772; // (signal)
  /*# mc6845.vhd:139:8 */
  assign vs_even = n773; // (signal)
  /*# mc6845.vhd:140:8 */
  assign vs_odd = n775; // (signal)
  /*# mc6845.vhd:141:8 */
  assign odd_field = n777; // (signal)
  /*# mc6845.vhd:142:8 */
  assign ma_i = n779; // (signal)
  /*# mc6845.vhd:144:8 */
  assign lpstb_sync = n781; // (signal)
  /*# mc6845.vhd:145:8 */
  assign de0 = n658; // (signal)
  /*# mc6845.vhd:146:8 */
  assign de1 = n783; // (signal)
  /*# mc6845.vhd:147:8 */
  assign de2 = n785; // (signal)
  /*# mc6845.vhd:148:8 */
  assign cursor0 = n626; // (signal)
  /*# mc6845.vhd:149:8 */
  assign cursor1 = n787; // (signal)
  /*# mc6845.vhd:150:8 */
  assign cursor2 = n789; // (signal)
  /*# mc6845.vhd:151:8 */
  assign interlaced_video = n791; // (signal)
  /*# mc6845.vhd:152:8 */
  assign max_scanline = n10; // (signal)
  /*# mc6845.vhd:153:8 */
  assign adj_scanline = n30; // (signal)
  /*# mc6845.vhd:154:8 */
  assign ma_row = n793; // (signal)
  /*# mc6845.vhd:156:8 */
  assign in_adj = n795; // (signal)
  /*# mc6845.vhd:157:8 */
  assign adj_in_progress = n797; // (signal)
  /*# mc6845.vhd:158:8 */
  assign sol = n799; // (signal)
  /*# mc6845.vhd:159:8 */
  assign eom_latched = n801; // (signal)
  /*# mc6845.vhd:160:8 */
  assign eof_latched = n803; // (signal)
  /*# mc6845.vhd:161:8 */
  assign first_scanline = n805; // (signal)
  /*# mc6845.vhd:162:8 */
  assign extra_scanline = n807; // (signal)
  /*# mc6845.vhd:163:8 */
  assign new_frame = n46; // (signal)
  /*# mc6845.vhd:165:8 */
  assign r00_h_total_hit = n33; // (signal)
  /*# mc6845.vhd:166:8 */
  assign max_scanline_hit = n22; // (signal)
  /*# mc6845.vhd:182:43 */
  assign n9 = r09_max_scanline_addr + 5'b00001;
  /*# mc6845.vhd:182:61 */
  assign n10 = VGA ? n9 : n17;
  /*# mc6845.vhd:183:42 */
  assign n11 = r09_max_scanline_addr[4:1]; // extract
  /*# mc6845.vhd:183:55 */
  assign n13 = {n11, 1'b0};
  /*# mc6845.vhd:183:79 */
  assign n14 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:183:92 */
  assign n16 = n14 == 2'b11;
  /*# mc6845.vhd:182:99 */
  assign n17 = n16 ? n13 : r09_max_scanline_addr;
  /*# mc6845.vhd:187:47 */
  assign n19 = line_counter == max_scanline;
  /*# mc6845.vhd:187:82 */
  assign n20 = ~adj_in_progress;
  /*# mc6845.vhd:187:62 */
  assign n21 = n20 & n19;
  /*# mc6845.vhd:187:29 */
  assign n22 = n21 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:191:37 */
  assign n25 = r05_v_total_adj + 5'b00010;
  /*# mc6845.vhd:191:59 */
  assign n26 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:191:72 */
  assign n28 = n26 == 2'b11;
  /*# mc6845.vhd:191:79 */
  assign n29 = VGA & n28;
  /*# mc6845.vhd:191:41 */
  assign n30 = n29 ? n25 : r05_v_total_adj;
  /*# mc6845.vhd:195:43 */
  assign n32 = h_counter == r00_h_total;
  /*# mc6845.vhd:195:28 */
  assign n33 = n32 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:198:49 */
  assign n36 = eof_latched & r00_h_total_hit;
  /*# mc6845.vhd:198:89 */
  assign n37 = r08_interlace[0]; // extract
  /*# mc6845.vhd:198:93 */
  assign n38 = ~n37;
  /*# mc6845.vhd:198:115 */
  assign n39 = field_counter[0]; // extract
  /*# mc6845.vhd:198:119 */
  assign n40 = ~n39;
  /*# mc6845.vhd:198:99 */
  assign n41 = n38 | n40;
  /*# mc6845.vhd:198:125 */
  assign n42 = n41 | extra_scanline;
  /*# mc6845.vhd:198:149 */
  assign n43 = n42 | VGA;
  /*# mc6845.vhd:198:162 */
  assign n44 = n43 | NO_ILACE;
  /*# mc6845.vhd:198:71 */
  assign n45 = n44 & n36;
  /*# mc6845.vhd:198:22 */
  assign n46 = n45 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:208:19 */
  assign n50 = ~nRESET;
  /*# mc6845.vhd:237:36 */
  assign n53 = {2'b00, r12_start_addr_h};
  /*# mc6845.vhd:236:21 */
  assign n55 = addr_reg == 5'b01100;
  /*# mc6845.vhd:238:21 */
  assign n57 = addr_reg == 5'b01101;
  /*# mc6845.vhd:241:36 */
  assign n59 = {2'b00, r14_cursor_h};
  /*# mc6845.vhd:240:21 */
  assign n61 = addr_reg == 5'b01110;
  /*# mc6845.vhd:242:21 */
  assign n63 = addr_reg == 5'b01111;
  /*# mc6845.vhd:245:36 */
  assign n65 = {2'b00, r16_light_pen_h};
  /*# mc6845.vhd:244:21 */
  assign n67 = addr_reg == 5'b10000;
  /*# mc6845.vhd:246:21 */
  assign n69 = addr_reg == 5'b10001;
  /*# mc6845.vhd:235:21 */
  assign n70 = {n69, n67, n63, n61, n57, n55};
  /*# mc6845.vhd:235:21 */
  always @*
    case (n70)
      6'b100000: n72 = r17_light_pen_l;
      6'b010000: n72 = n65;
      6'b001000: n72 = r15_cursor_l;
      6'b000100: n72 = n59;
      6'b000010: n72 = r13_start_addr_l;
      6'b000001: n72 = n53;
      default: n72 = 8'b00000000;
    endcase
  /*# mc6845.vhd:253:27 */
  assign n73 = ~RS;
  /*# mc6845.vhd:254:39 */
  assign n74 = DI[4:0]; // extract
  /*# mc6845.vhd:257:25 */
  assign n76 = addr_reg == 5'b00000;
  /*# mc6845.vhd:259:25 */
  assign n78 = addr_reg == 5'b00001;
  /*# mc6845.vhd:261:25 */
  assign n80 = addr_reg == 5'b00010;
  /*# mc6845.vhd:264:60 */
  assign n81 = DI[7:4]; // extract
  /*# mc6845.vhd:265:60 */
  assign n82 = DI[3:0]; // extract
  /*# mc6845.vhd:263:25 */
  assign n84 = addr_reg == 5'b00011;
  /*# mc6845.vhd:267:55 */
  assign n85 = DI[6:0]; // extract
  /*# mc6845.vhd:266:25 */
  assign n87 = addr_reg == 5'b00100;
  /*# mc6845.vhd:269:59 */
  assign n88 = DI[4:0]; // extract
  /*# mc6845.vhd:268:25 */
  assign n90 = addr_reg == 5'b00101;
  /*# mc6845.vhd:271:59 */
  assign n91 = DI[6:0]; // extract
  /*# mc6845.vhd:270:25 */
  assign n93 = addr_reg == 5'b00110;
  /*# mc6845.vhd:273:58 */
  assign n94 = DI[6:0]; // extract
  /*# mc6845.vhd:272:25 */
  assign n96 = addr_reg == 5'b00111;
  /*# mc6845.vhd:274:25 */
  assign n98 = addr_reg == 5'b01000;
  /*# mc6845.vhd:277:65 */
  assign n99 = DI[4:0]; // extract
  /*# mc6845.vhd:276:25 */
  assign n101 = addr_reg == 5'b01001;
  /*# mc6845.vhd:279:50 */
  assign n102 = DI[6:5]; // extract
  /*# mc6845.vhd:280:60 */
  assign n103 = DI[4:0]; // extract
  /*# mc6845.vhd:278:25 */
  assign n105 = addr_reg == 5'b01010;
  /*# mc6845.vhd:282:58 */
  assign n106 = DI[4:0]; // extract
  /*# mc6845.vhd:281:25 */
  assign n108 = addr_reg == 5'b01011;
  /*# mc6845.vhd:284:60 */
  assign n109 = DI[5:0]; // extract
  /*# mc6845.vhd:283:25 */
  assign n111 = addr_reg == 5'b01100;
  /*# mc6845.vhd:285:25 */
  assign n113 = addr_reg == 5'b01101;
  /*# mc6845.vhd:288:56 */
  assign n114 = DI[5:0]; // extract
  /*# mc6845.vhd:287:25 */
  assign n116 = addr_reg == 5'b01110;
  /*# mc6845.vhd:289:25 */
  assign n118 = addr_reg == 5'b01111;
  /*# mc6845.vhd:256:25 */
  assign n119 = {n118, n116, n113, n111, n108, n105, n101, n98, n96, n93, n90, n87, n84, n80, n78, n76};
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n120 = r00_h_total;
      16'b0100000000000000: n120 = r00_h_total;
      16'b0010000000000000: n120 = r00_h_total;
      16'b0001000000000000: n120 = r00_h_total;
      16'b0000100000000000: n120 = r00_h_total;
      16'b0000010000000000: n120 = r00_h_total;
      16'b0000001000000000: n120 = r00_h_total;
      16'b0000000100000000: n120 = r00_h_total;
      16'b0000000010000000: n120 = r00_h_total;
      16'b0000000001000000: n120 = r00_h_total;
      16'b0000000000100000: n120 = r00_h_total;
      16'b0000000000010000: n120 = r00_h_total;
      16'b0000000000001000: n120 = r00_h_total;
      16'b0000000000000100: n120 = r00_h_total;
      16'b0000000000000010: n120 = r00_h_total;
      16'b0000000000000001: n120 = DI;
      default: n120 = r00_h_total;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n121 = r01_h_displayed;
      16'b0100000000000000: n121 = r01_h_displayed;
      16'b0010000000000000: n121 = r01_h_displayed;
      16'b0001000000000000: n121 = r01_h_displayed;
      16'b0000100000000000: n121 = r01_h_displayed;
      16'b0000010000000000: n121 = r01_h_displayed;
      16'b0000001000000000: n121 = r01_h_displayed;
      16'b0000000100000000: n121 = r01_h_displayed;
      16'b0000000010000000: n121 = r01_h_displayed;
      16'b0000000001000000: n121 = r01_h_displayed;
      16'b0000000000100000: n121 = r01_h_displayed;
      16'b0000000000010000: n121 = r01_h_displayed;
      16'b0000000000001000: n121 = r01_h_displayed;
      16'b0000000000000100: n121 = r01_h_displayed;
      16'b0000000000000010: n121 = DI;
      16'b0000000000000001: n121 = r01_h_displayed;
      default: n121 = r01_h_displayed;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n122 = r02_h_sync_pos;
      16'b0100000000000000: n122 = r02_h_sync_pos;
      16'b0010000000000000: n122 = r02_h_sync_pos;
      16'b0001000000000000: n122 = r02_h_sync_pos;
      16'b0000100000000000: n122 = r02_h_sync_pos;
      16'b0000010000000000: n122 = r02_h_sync_pos;
      16'b0000001000000000: n122 = r02_h_sync_pos;
      16'b0000000100000000: n122 = r02_h_sync_pos;
      16'b0000000010000000: n122 = r02_h_sync_pos;
      16'b0000000001000000: n122 = r02_h_sync_pos;
      16'b0000000000100000: n122 = r02_h_sync_pos;
      16'b0000000000010000: n122 = r02_h_sync_pos;
      16'b0000000000001000: n122 = r02_h_sync_pos;
      16'b0000000000000100: n122 = DI;
      16'b0000000000000010: n122 = r02_h_sync_pos;
      16'b0000000000000001: n122 = r02_h_sync_pos;
      default: n122 = r02_h_sync_pos;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n123 = r03_v_sync_width;
      16'b0100000000000000: n123 = r03_v_sync_width;
      16'b0010000000000000: n123 = r03_v_sync_width;
      16'b0001000000000000: n123 = r03_v_sync_width;
      16'b0000100000000000: n123 = r03_v_sync_width;
      16'b0000010000000000: n123 = r03_v_sync_width;
      16'b0000001000000000: n123 = r03_v_sync_width;
      16'b0000000100000000: n123 = r03_v_sync_width;
      16'b0000000010000000: n123 = r03_v_sync_width;
      16'b0000000001000000: n123 = r03_v_sync_width;
      16'b0000000000100000: n123 = r03_v_sync_width;
      16'b0000000000010000: n123 = r03_v_sync_width;
      16'b0000000000001000: n123 = n81;
      16'b0000000000000100: n123 = r03_v_sync_width;
      16'b0000000000000010: n123 = r03_v_sync_width;
      16'b0000000000000001: n123 = r03_v_sync_width;
      default: n123 = r03_v_sync_width;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n124 = r03_h_sync_width;
      16'b0100000000000000: n124 = r03_h_sync_width;
      16'b0010000000000000: n124 = r03_h_sync_width;
      16'b0001000000000000: n124 = r03_h_sync_width;
      16'b0000100000000000: n124 = r03_h_sync_width;
      16'b0000010000000000: n124 = r03_h_sync_width;
      16'b0000001000000000: n124 = r03_h_sync_width;
      16'b0000000100000000: n124 = r03_h_sync_width;
      16'b0000000010000000: n124 = r03_h_sync_width;
      16'b0000000001000000: n124 = r03_h_sync_width;
      16'b0000000000100000: n124 = r03_h_sync_width;
      16'b0000000000010000: n124 = r03_h_sync_width;
      16'b0000000000001000: n124 = n82;
      16'b0000000000000100: n124 = r03_h_sync_width;
      16'b0000000000000010: n124 = r03_h_sync_width;
      16'b0000000000000001: n124 = r03_h_sync_width;
      default: n124 = r03_h_sync_width;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n125 = r04_v_total;
      16'b0100000000000000: n125 = r04_v_total;
      16'b0010000000000000: n125 = r04_v_total;
      16'b0001000000000000: n125 = r04_v_total;
      16'b0000100000000000: n125 = r04_v_total;
      16'b0000010000000000: n125 = r04_v_total;
      16'b0000001000000000: n125 = r04_v_total;
      16'b0000000100000000: n125 = r04_v_total;
      16'b0000000010000000: n125 = r04_v_total;
      16'b0000000001000000: n125 = r04_v_total;
      16'b0000000000100000: n125 = r04_v_total;
      16'b0000000000010000: n125 = n85;
      16'b0000000000001000: n125 = r04_v_total;
      16'b0000000000000100: n125 = r04_v_total;
      16'b0000000000000010: n125 = r04_v_total;
      16'b0000000000000001: n125 = r04_v_total;
      default: n125 = r04_v_total;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n126 = r05_v_total_adj;
      16'b0100000000000000: n126 = r05_v_total_adj;
      16'b0010000000000000: n126 = r05_v_total_adj;
      16'b0001000000000000: n126 = r05_v_total_adj;
      16'b0000100000000000: n126 = r05_v_total_adj;
      16'b0000010000000000: n126 = r05_v_total_adj;
      16'b0000001000000000: n126 = r05_v_total_adj;
      16'b0000000100000000: n126 = r05_v_total_adj;
      16'b0000000010000000: n126 = r05_v_total_adj;
      16'b0000000001000000: n126 = r05_v_total_adj;
      16'b0000000000100000: n126 = n88;
      16'b0000000000010000: n126 = r05_v_total_adj;
      16'b0000000000001000: n126 = r05_v_total_adj;
      16'b0000000000000100: n126 = r05_v_total_adj;
      16'b0000000000000010: n126 = r05_v_total_adj;
      16'b0000000000000001: n126 = r05_v_total_adj;
      default: n126 = r05_v_total_adj;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n127 = r06_v_displayed;
      16'b0100000000000000: n127 = r06_v_displayed;
      16'b0010000000000000: n127 = r06_v_displayed;
      16'b0001000000000000: n127 = r06_v_displayed;
      16'b0000100000000000: n127 = r06_v_displayed;
      16'b0000010000000000: n127 = r06_v_displayed;
      16'b0000001000000000: n127 = r06_v_displayed;
      16'b0000000100000000: n127 = r06_v_displayed;
      16'b0000000010000000: n127 = r06_v_displayed;
      16'b0000000001000000: n127 = n91;
      16'b0000000000100000: n127 = r06_v_displayed;
      16'b0000000000010000: n127 = r06_v_displayed;
      16'b0000000000001000: n127 = r06_v_displayed;
      16'b0000000000000100: n127 = r06_v_displayed;
      16'b0000000000000010: n127 = r06_v_displayed;
      16'b0000000000000001: n127 = r06_v_displayed;
      default: n127 = r06_v_displayed;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n128 = r07_v_sync_pos;
      16'b0100000000000000: n128 = r07_v_sync_pos;
      16'b0010000000000000: n128 = r07_v_sync_pos;
      16'b0001000000000000: n128 = r07_v_sync_pos;
      16'b0000100000000000: n128 = r07_v_sync_pos;
      16'b0000010000000000: n128 = r07_v_sync_pos;
      16'b0000001000000000: n128 = r07_v_sync_pos;
      16'b0000000100000000: n128 = r07_v_sync_pos;
      16'b0000000010000000: n128 = n94;
      16'b0000000001000000: n128 = r07_v_sync_pos;
      16'b0000000000100000: n128 = r07_v_sync_pos;
      16'b0000000000010000: n128 = r07_v_sync_pos;
      16'b0000000000001000: n128 = r07_v_sync_pos;
      16'b0000000000000100: n128 = r07_v_sync_pos;
      16'b0000000000000010: n128 = r07_v_sync_pos;
      16'b0000000000000001: n128 = r07_v_sync_pos;
      default: n128 = r07_v_sync_pos;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n129 = r08_interlace;
      16'b0100000000000000: n129 = r08_interlace;
      16'b0010000000000000: n129 = r08_interlace;
      16'b0001000000000000: n129 = r08_interlace;
      16'b0000100000000000: n129 = r08_interlace;
      16'b0000010000000000: n129 = r08_interlace;
      16'b0000001000000000: n129 = r08_interlace;
      16'b0000000100000000: n129 = DI;
      16'b0000000010000000: n129 = r08_interlace;
      16'b0000000001000000: n129 = r08_interlace;
      16'b0000000000100000: n129 = r08_interlace;
      16'b0000000000010000: n129 = r08_interlace;
      16'b0000000000001000: n129 = r08_interlace;
      16'b0000000000000100: n129 = r08_interlace;
      16'b0000000000000010: n129 = r08_interlace;
      16'b0000000000000001: n129 = r08_interlace;
      default: n129 = r08_interlace;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n130 = r09_max_scanline_addr;
      16'b0100000000000000: n130 = r09_max_scanline_addr;
      16'b0010000000000000: n130 = r09_max_scanline_addr;
      16'b0001000000000000: n130 = r09_max_scanline_addr;
      16'b0000100000000000: n130 = r09_max_scanline_addr;
      16'b0000010000000000: n130 = r09_max_scanline_addr;
      16'b0000001000000000: n130 = n99;
      16'b0000000100000000: n130 = r09_max_scanline_addr;
      16'b0000000010000000: n130 = r09_max_scanline_addr;
      16'b0000000001000000: n130 = r09_max_scanline_addr;
      16'b0000000000100000: n130 = r09_max_scanline_addr;
      16'b0000000000010000: n130 = r09_max_scanline_addr;
      16'b0000000000001000: n130 = r09_max_scanline_addr;
      16'b0000000000000100: n130 = r09_max_scanline_addr;
      16'b0000000000000010: n130 = r09_max_scanline_addr;
      16'b0000000000000001: n130 = r09_max_scanline_addr;
      default: n130 = r09_max_scanline_addr;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n131 = r10_cursor_mode;
      16'b0100000000000000: n131 = r10_cursor_mode;
      16'b0010000000000000: n131 = r10_cursor_mode;
      16'b0001000000000000: n131 = r10_cursor_mode;
      16'b0000100000000000: n131 = r10_cursor_mode;
      16'b0000010000000000: n131 = n102;
      16'b0000001000000000: n131 = r10_cursor_mode;
      16'b0000000100000000: n131 = r10_cursor_mode;
      16'b0000000010000000: n131 = r10_cursor_mode;
      16'b0000000001000000: n131 = r10_cursor_mode;
      16'b0000000000100000: n131 = r10_cursor_mode;
      16'b0000000000010000: n131 = r10_cursor_mode;
      16'b0000000000001000: n131 = r10_cursor_mode;
      16'b0000000000000100: n131 = r10_cursor_mode;
      16'b0000000000000010: n131 = r10_cursor_mode;
      16'b0000000000000001: n131 = r10_cursor_mode;
      default: n131 = r10_cursor_mode;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n132 = r10_cursor_start;
      16'b0100000000000000: n132 = r10_cursor_start;
      16'b0010000000000000: n132 = r10_cursor_start;
      16'b0001000000000000: n132 = r10_cursor_start;
      16'b0000100000000000: n132 = r10_cursor_start;
      16'b0000010000000000: n132 = n103;
      16'b0000001000000000: n132 = r10_cursor_start;
      16'b0000000100000000: n132 = r10_cursor_start;
      16'b0000000010000000: n132 = r10_cursor_start;
      16'b0000000001000000: n132 = r10_cursor_start;
      16'b0000000000100000: n132 = r10_cursor_start;
      16'b0000000000010000: n132 = r10_cursor_start;
      16'b0000000000001000: n132 = r10_cursor_start;
      16'b0000000000000100: n132 = r10_cursor_start;
      16'b0000000000000010: n132 = r10_cursor_start;
      16'b0000000000000001: n132 = r10_cursor_start;
      default: n132 = r10_cursor_start;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n133 = r11_cursor_end;
      16'b0100000000000000: n133 = r11_cursor_end;
      16'b0010000000000000: n133 = r11_cursor_end;
      16'b0001000000000000: n133 = r11_cursor_end;
      16'b0000100000000000: n133 = n106;
      16'b0000010000000000: n133 = r11_cursor_end;
      16'b0000001000000000: n133 = r11_cursor_end;
      16'b0000000100000000: n133 = r11_cursor_end;
      16'b0000000010000000: n133 = r11_cursor_end;
      16'b0000000001000000: n133 = r11_cursor_end;
      16'b0000000000100000: n133 = r11_cursor_end;
      16'b0000000000010000: n133 = r11_cursor_end;
      16'b0000000000001000: n133 = r11_cursor_end;
      16'b0000000000000100: n133 = r11_cursor_end;
      16'b0000000000000010: n133 = r11_cursor_end;
      16'b0000000000000001: n133 = r11_cursor_end;
      default: n133 = r11_cursor_end;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n134 = r12_start_addr_h;
      16'b0100000000000000: n134 = r12_start_addr_h;
      16'b0010000000000000: n134 = r12_start_addr_h;
      16'b0001000000000000: n134 = n109;
      16'b0000100000000000: n134 = r12_start_addr_h;
      16'b0000010000000000: n134 = r12_start_addr_h;
      16'b0000001000000000: n134 = r12_start_addr_h;
      16'b0000000100000000: n134 = r12_start_addr_h;
      16'b0000000010000000: n134 = r12_start_addr_h;
      16'b0000000001000000: n134 = r12_start_addr_h;
      16'b0000000000100000: n134 = r12_start_addr_h;
      16'b0000000000010000: n134 = r12_start_addr_h;
      16'b0000000000001000: n134 = r12_start_addr_h;
      16'b0000000000000100: n134 = r12_start_addr_h;
      16'b0000000000000010: n134 = r12_start_addr_h;
      16'b0000000000000001: n134 = r12_start_addr_h;
      default: n134 = r12_start_addr_h;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n135 = r13_start_addr_l;
      16'b0100000000000000: n135 = r13_start_addr_l;
      16'b0010000000000000: n135 = DI;
      16'b0001000000000000: n135 = r13_start_addr_l;
      16'b0000100000000000: n135 = r13_start_addr_l;
      16'b0000010000000000: n135 = r13_start_addr_l;
      16'b0000001000000000: n135 = r13_start_addr_l;
      16'b0000000100000000: n135 = r13_start_addr_l;
      16'b0000000010000000: n135 = r13_start_addr_l;
      16'b0000000001000000: n135 = r13_start_addr_l;
      16'b0000000000100000: n135 = r13_start_addr_l;
      16'b0000000000010000: n135 = r13_start_addr_l;
      16'b0000000000001000: n135 = r13_start_addr_l;
      16'b0000000000000100: n135 = r13_start_addr_l;
      16'b0000000000000010: n135 = r13_start_addr_l;
      16'b0000000000000001: n135 = r13_start_addr_l;
      default: n135 = r13_start_addr_l;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n136 = r14_cursor_h;
      16'b0100000000000000: n136 = n114;
      16'b0010000000000000: n136 = r14_cursor_h;
      16'b0001000000000000: n136 = r14_cursor_h;
      16'b0000100000000000: n136 = r14_cursor_h;
      16'b0000010000000000: n136 = r14_cursor_h;
      16'b0000001000000000: n136 = r14_cursor_h;
      16'b0000000100000000: n136 = r14_cursor_h;
      16'b0000000010000000: n136 = r14_cursor_h;
      16'b0000000001000000: n136 = r14_cursor_h;
      16'b0000000000100000: n136 = r14_cursor_h;
      16'b0000000000010000: n136 = r14_cursor_h;
      16'b0000000000001000: n136 = r14_cursor_h;
      16'b0000000000000100: n136 = r14_cursor_h;
      16'b0000000000000010: n136 = r14_cursor_h;
      16'b0000000000000001: n136 = r14_cursor_h;
      default: n136 = r14_cursor_h;
    endcase
  /*# mc6845.vhd:256:25 */
  always @*
    case (n119)
      16'b1000000000000000: n137 = DI;
      16'b0100000000000000: n137 = r15_cursor_l;
      16'b0010000000000000: n137 = r15_cursor_l;
      16'b0001000000000000: n137 = r15_cursor_l;
      16'b0000100000000000: n137 = r15_cursor_l;
      16'b0000010000000000: n137 = r15_cursor_l;
      16'b0000001000000000: n137 = r15_cursor_l;
      16'b0000000100000000: n137 = r15_cursor_l;
      16'b0000000010000000: n137 = r15_cursor_l;
      16'b0000000001000000: n137 = r15_cursor_l;
      16'b0000000000100000: n137 = r15_cursor_l;
      16'b0000000000010000: n137 = r15_cursor_l;
      16'b0000000000001000: n137 = r15_cursor_l;
      16'b0000000000000100: n137 = r15_cursor_l;
      16'b0000000000000010: n137 = r15_cursor_l;
      16'b0000000000000001: n137 = r15_cursor_l;
      default: n137 = r15_cursor_l;
    endcase
  /*# mc6845.vhd:251:17 */
  assign n138 = n157 ? n74 : addr_reg;
  /*# mc6845.vhd:253:21 */
  assign n139 = n73 ? r00_h_total : n120;
  /*# mc6845.vhd:253:21 */
  assign n140 = n73 ? r01_h_displayed : n121;
  /*# mc6845.vhd:253:21 */
  assign n141 = n73 ? r02_h_sync_pos : n122;
  /*# mc6845.vhd:253:21 */
  assign n142 = n73 ? r03_v_sync_width : n123;
  /*# mc6845.vhd:253:21 */
  assign n143 = n73 ? r03_h_sync_width : n124;
  /*# mc6845.vhd:253:21 */
  assign n144 = n73 ? r04_v_total : n125;
  /*# mc6845.vhd:253:21 */
  assign n145 = n73 ? r05_v_total_adj : n126;
  /*# mc6845.vhd:253:21 */
  assign n146 = n73 ? r06_v_displayed : n127;
  /*# mc6845.vhd:253:21 */
  assign n147 = n73 ? r07_v_sync_pos : n128;
  /*# mc6845.vhd:253:21 */
  assign n148 = n73 ? r08_interlace : n129;
  /*# mc6845.vhd:253:21 */
  assign n149 = n73 ? r09_max_scanline_addr : n130;
  /*# mc6845.vhd:253:21 */
  assign n150 = n73 ? r10_cursor_mode : n131;
  /*# mc6845.vhd:253:21 */
  assign n151 = n73 ? r10_cursor_start : n132;
  /*# mc6845.vhd:253:21 */
  assign n152 = n73 ? r11_cursor_end : n133;
  /*# mc6845.vhd:253:21 */
  assign n153 = n73 ? r12_start_addr_h : n134;
  /*# mc6845.vhd:253:21 */
  assign n154 = n73 ? r13_start_addr_l : n135;
  /*# mc6845.vhd:253:21 */
  assign n155 = n73 ? r14_cursor_h : n136;
  /*# mc6845.vhd:253:21 */
  assign n156 = n73 ? r15_cursor_l : n137;
  /*# mc6845.vhd:251:17 */
  assign n157 = n73 & CLKEN_CPU;
  /*# mc6845.vhd:251:17 */
  assign n158 = CLKEN_CPU ? n139 : r00_h_total;
  /*# mc6845.vhd:251:17 */
  assign n159 = CLKEN_CPU ? n140 : r01_h_displayed;
  /*# mc6845.vhd:251:17 */
  assign n160 = CLKEN_CPU ? n141 : r02_h_sync_pos;
  /*# mc6845.vhd:251:17 */
  assign n161 = CLKEN_CPU ? n142 : r03_v_sync_width;
  /*# mc6845.vhd:251:17 */
  assign n162 = CLKEN_CPU ? n143 : r03_h_sync_width;
  /*# mc6845.vhd:251:17 */
  assign n163 = CLKEN_CPU ? n144 : r04_v_total;
  /*# mc6845.vhd:251:17 */
  assign n164 = CLKEN_CPU ? n145 : r05_v_total_adj;
  /*# mc6845.vhd:251:17 */
  assign n165 = CLKEN_CPU ? n146 : r06_v_displayed;
  /*# mc6845.vhd:251:17 */
  assign n166 = CLKEN_CPU ? n147 : r07_v_sync_pos;
  /*# mc6845.vhd:251:17 */
  assign n167 = CLKEN_CPU ? n148 : r08_interlace;
  /*# mc6845.vhd:251:17 */
  assign n168 = CLKEN_CPU ? n149 : r09_max_scanline_addr;
  /*# mc6845.vhd:251:17 */
  assign n169 = CLKEN_CPU ? n150 : r10_cursor_mode;
  /*# mc6845.vhd:251:17 */
  assign n170 = CLKEN_CPU ? n151 : r10_cursor_start;
  /*# mc6845.vhd:251:17 */
  assign n171 = CLKEN_CPU ? n152 : r11_cursor_end;
  /*# mc6845.vhd:251:17 */
  assign n172 = CLKEN_CPU ? n153 : r12_start_addr_h;
  /*# mc6845.vhd:251:17 */
  assign n173 = CLKEN_CPU ? n154 : r13_start_addr_l;
  /*# mc6845.vhd:251:17 */
  assign n174 = CLKEN_CPU ? n155 : r14_cursor_h;
  /*# mc6845.vhd:251:17 */
  assign n175 = CLKEN_CPU ? n156 : r15_cursor_l;
  /*# mc6845.vhd:233:17 */
  assign n177 = R_nW ? addr_reg : n138;
  /*# mc6845.vhd:233:17 */
  assign n178 = R_nW ? r00_h_total : n158;
  /*# mc6845.vhd:233:17 */
  assign n179 = R_nW ? r01_h_displayed : n159;
  /*# mc6845.vhd:233:17 */
  assign n180 = R_nW ? r02_h_sync_pos : n160;
  /*# mc6845.vhd:233:17 */
  assign n181 = R_nW ? r03_v_sync_width : n161;
  /*# mc6845.vhd:233:17 */
  assign n182 = R_nW ? r03_h_sync_width : n162;
  /*# mc6845.vhd:233:17 */
  assign n183 = R_nW ? r04_v_total : n163;
  /*# mc6845.vhd:233:17 */
  assign n184 = R_nW ? r05_v_total_adj : n164;
  /*# mc6845.vhd:233:17 */
  assign n185 = R_nW ? r06_v_displayed : n165;
  /*# mc6845.vhd:233:17 */
  assign n186 = R_nW ? r07_v_sync_pos : n166;
  /*# mc6845.vhd:233:17 */
  assign n187 = R_nW ? r08_interlace : n167;
  /*# mc6845.vhd:233:17 */
  assign n188 = R_nW ? r09_max_scanline_addr : n168;
  /*# mc6845.vhd:233:17 */
  assign n189 = R_nW ? r10_cursor_mode : n169;
  /*# mc6845.vhd:233:17 */
  assign n190 = R_nW ? r10_cursor_start : n170;
  /*# mc6845.vhd:233:17 */
  assign n191 = R_nW ? r11_cursor_end : n171;
  /*# mc6845.vhd:233:17 */
  assign n192 = R_nW ? r12_start_addr_h : n172;
  /*# mc6845.vhd:233:17 */
  assign n193 = R_nW ? r13_start_addr_l : n173;
  /*# mc6845.vhd:233:17 */
  assign n194 = R_nW ? r14_cursor_h : n174;
  /*# mc6845.vhd:233:17 */
  assign n195 = R_nW ? r15_cursor_l : n175;
  /*# mc6845.vhd:232:13 */
  assign n196 = R_nW & ENABLE;
  /*# mc6845.vhd:309:19 */
  assign n279 = ~nRESET;
  /*# mc6845.vhd:316:44 */
  assign n282 = h_counter + 8'b00000001;
  /*# mc6845.vhd:313:17 */
  assign n284 = r00_h_total_hit ? 8'b00000000 : n282;
  /*# mc6845.vhd:337:19 */
  assign n292 = ~nRESET;
  /*# mc6845.vhd:341:23 */
  assign n294 = ~hs;
  /*# mc6845.vhd:344:54 */
  assign n296 = h_sync_counter + 4'b0001;
  /*# mc6845.vhd:341:17 */
  assign n298 = n294 ? 4'b0000 : n296;
  /*# mc6845.vhd:358:19 */
  assign n306 = ~nRESET;
  /*# mc6845.vhd:361:31 */
  assign n308 = h_sync_counter == r03_h_sync_width;
  /*# mc6845.vhd:363:29 */
  assign n309 = h_counter == r02_h_sync_pos;
  /*# mc6845.vhd:363:13 */
  assign n311 = n309 ? 1'b1 : hs;
  /*# mc6845.vhd:361:13 */
  assign n313 = n308 ? 1'b0 : n311;
  /*# mc6845.vhd:379:19 */
  assign n320 = ~nRESET;
  /*# mc6845.vhd:382:26 */
  assign n322 = h_counter == r01_h_displayed;
  /*# mc6845.vhd:382:57 */
  assign n323 = h_counter == r00_h_total;
  /*# mc6845.vhd:382:44 */
  assign n324 = n322 | n323;
  /*# mc6845.vhd:384:29 */
  assign n326 = h_counter == 8'b00000000;
  /*# mc6845.vhd:384:13 */
  assign n328 = n326 ? 1'b1 : h_display;
  /*# mc6845.vhd:382:13 */
  assign n330 = n324 ? 1'b0 : n328;
  /*# mc6845.vhd:402:19 */
  assign n337 = ~nRESET;
  /*# mc6845.vhd:408:17 */
  assign n339 = r00_h_total_hit ? line_counter_next : line_counter;
  /*# mc6845.vhd:406:17 */
  assign n341 = new_frame ? 5'b00000 : n339;
  /*# mc6845.vhd:415:42 */
  assign n348 = max_scanline_hit ? 5'b00000 : n358;
  /*# mc6845.vhd:416:39 */
  assign n350 = line_counter + 5'b00001;
  /*# mc6845.vhd:416:90 */
  assign n351 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:416:103 */
  assign n353 = n351 == 2'b11;
  /*# mc6845.vhd:416:118 */
  assign n354 = ~VGA;
  /*# mc6845.vhd:416:110 */
  assign n355 = n354 & n353;
  /*# mc6845.vhd:416:73 */
  assign n356 = ~n355;
  /*# mc6845.vhd:416:70 */
  assign n357 = adj_in_progress | n356;
  /*# mc6845.vhd:415:70 */
  assign n358 = n357 ? n350 : n363;
  /*# mc6845.vhd:417:38 */
  assign n359 = line_counter[4:1]; // extract
  /*# mc6845.vhd:417:51 */
  assign n361 = n359 + 4'b0001;
  /*# mc6845.vhd:417:55 */
  assign n363 = {n361, 1'b0};
  /*# mc6845.vhd:423:19 */
  assign n366 = ~nRESET;
  /*# mc6845.vhd:432:41 */
  assign n374 = new_frame ? 7'b0000000 : n378;
  /*# mc6845.vhd:433:37 */
  assign n376 = row_counter + 7'b0000001;
  /*# mc6845.vhd:433:68 */
  assign n377 = max_scanline_hit & r00_h_total_hit;
  /*# mc6845.vhd:432:62 */
  assign n378 = n377 ? n376 : row_counter;
  /*# mc6845.vhd:457:36 */
  assign n380 = row_counter == r07_v_sync_pos;
  /*# mc6845.vhd:457:19 */
  assign n381 = n380 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:462:19 */
  assign n385 = ~nRESET;
  /*# mc6845.vhd:466:49 */
  assign n387 = ~vs_hit_last;
  /*# mc6845.vhd:466:33 */
  assign n388 = n387 & vs_hit;
  /*# mc6845.vhd:469:54 */
  assign n390 = v_sync_counter + 4'b0001;
  /*# mc6845.vhd:468:17 */
  assign n391 = r00_h_total_hit ? n390 : v_sync_counter;
  /*# mc6845.vhd:466:17 */
  assign n393 = n388 ? 4'b0000 : n391;
  /*# mc6845.vhd:480:19 */
  assign n404 = ~nRESET;
  /*# mc6845.vhd:483:45 */
  assign n406 = ~vs_hit_last;
  /*# mc6845.vhd:483:29 */
  assign n407 = n406 & vs_hit;
  /*# mc6845.vhd:486:34 */
  assign n408 = v_sync_counter == r03_v_sync_width;
  /*# mc6845.vhd:486:60 */
  assign n409 = sol[0]; // extract
  /*# mc6845.vhd:486:53 */
  assign n410 = n409 & n408;
  /*# mc6845.vhd:486:13 */
  assign n412 = n410 ? 1'b0 : vs_even;
  /*# mc6845.vhd:483:13 */
  assign n414 = n407 ? 1'b1 : n412;
  /*# mc6845.vhd:498:50 */
  assign n422 = r00_h_total[7:1]; // extract
  /*# mc6845.vhd:498:37 */
  assign n424 = {1'b0, n422};
  /*# mc6845.vhd:498:30 */
  assign n425 = h_counter == n424;
  /*# mc6845.vhd:497:13 */
  assign n427 = n425 & CLKEN;
  /*# mc6845.vhd:506:36 */
  assign n430 = r08_interlace[0]; // extract
  /*# mc6845.vhd:506:54 */
  assign n431 = ~VGA;
  /*# mc6845.vhd:506:46 */
  assign n432 = n431 & n430;
  /*# mc6845.vhd:506:73 */
  assign n433 = ~NO_ILACE;
  /*# mc6845.vhd:506:60 */
  assign n434 = n433 & n432;
  /*# mc6845.vhd:506:93 */
  assign n435 = ~odd_field;
  /*# mc6845.vhd:506:79 */
  assign n436 = n435 & n434;
  /*# mc6845.vhd:506:18 */
  assign n437 = n436 ? vs_odd : vs_even;
  /*# mc6845.vhd:525:19 */
  assign n440 = ~nRESET;
  /*# mc6845.vhd:537:47 */
  assign n442 = field_counter[0]; // extract
  /*# mc6845.vhd:534:17 */
  assign n444 = NO_ILACE ? 1'b0 : n442;
  /*# mc6845.vhd:539:31 */
  assign n445 = row_counter == r06_v_displayed;
  /*# mc6845.vhd:539:49 */
  assign n446 = v_display & n445;
  /*# mc6845.vhd:543:48 */
  assign n448 = field_counter + 5'b00001;
  /*# mc6845.vhd:539:13 */
  assign n449 = n446 ? n448 : field_counter;
  /*# mc6845.vhd:539:13 */
  assign n451 = n446 ? 1'b0 : v_display;
  /*# mc6845.vhd:530:13 */
  assign n452 = first_scanline ? field_counter : n449;
  /*# mc6845.vhd:530:13 */
  assign n454 = first_scanline ? 1'b1 : n451;
  /*# mc6845.vhd:556:19 */
  assign n468 = ~nRESET;
  /*# mc6845.vhd:606:27 */
  assign n470 = sol[1:0]; // extract
  /*# mc6845.vhd:606:53 */
  assign n471 = {n470, r00_h_total_hit};
  /*# mc6845.vhd:611:26 */
  assign n472 = sol[0]; // extract
  /*# mc6845.vhd:611:36 */
  assign n473 = max_scanline_hit & n472;
  /*# mc6845.vhd:611:79 */
  assign n474 = row_counter == r04_v_total;
  /*# mc6845.vhd:611:63 */
  assign n475 = n474 & n473;
  /*# mc6845.vhd:611:17 */
  assign n477 = n475 ? 1'b1 : eom_latched;
  /*# mc6845.vhd:609:17 */
  assign n479 = new_frame ? 1'b0 : n477;
  /*# mc6845.vhd:618:26 */
  assign n480 = sol[1]; // extract
  /*# mc6845.vhd:618:36 */
  assign n481 = eom_latched & n480;
  /*# mc6845.vhd:619:42 */
  assign n482 = line_counter_next == adj_scanline;
  /*# mc6845.vhd:619:21 */
  assign n485 = n482 ? 1'b0 : 1'b1;
  /*# mc6845.vhd:618:17 */
  assign n486 = n481 ? n485 : in_adj;
  /*# mc6845.vhd:616:17 */
  assign n488 = new_frame ? 1'b0 : n486;
  /*# mc6845.vhd:629:26 */
  assign n489 = sol[2]; // extract
  /*# mc6845.vhd:629:36 */
  assign n490 = eom_latched & n489;
  /*# mc6845.vhd:629:69 */
  assign n491 = ~in_adj;
  /*# mc6845.vhd:629:58 */
  assign n492 = n491 & n490;
  /*# mc6845.vhd:629:17 */
  assign n494 = n492 ? 1'b1 : eof_latched;
  /*# mc6845.vhd:627:17 */
  assign n496 = new_frame ? 1'b0 : n494;
  /*# mc6845.vhd:637:45 */
  assign n497 = eom_latched & r00_h_total_hit;
  /*# mc6845.vhd:637:67 */
  assign n498 = in_adj & n497;
  /*# mc6845.vhd:637:17 */
  assign n500 = n498 ? 1'b1 : adj_in_progress;
  /*# mc6845.vhd:635:17 */
  assign n502 = new_frame ? 1'b0 : n500;
  /*# mc6845.vhd:644:17 */
  assign n504 = r00_h_total_hit ? 1'b0 : first_scanline;
  /*# mc6845.vhd:642:17 */
  assign n506 = new_frame ? 1'b1 : n504;
  /*# mc6845.vhd:649:42 */
  assign n507 = eof_latched & r00_h_total_hit;
  /*# mc6845.vhd:649:81 */
  assign n508 = r08_interlace[0]; // extract
  /*# mc6845.vhd:649:64 */
  assign n509 = n508 & n507;
  /*# mc6845.vhd:649:108 */
  assign n510 = field_counter[0]; // extract
  /*# mc6845.vhd:649:91 */
  assign n511 = n510 & n509;
  /*# mc6845.vhd:649:137 */
  assign n512 = ~extra_scanline;
  /*# mc6845.vhd:649:118 */
  assign n513 = n512 & n511;
  /*# mc6845.vhd:651:17 */
  assign n515 = r00_h_total_hit ? 1'b0 : extra_scanline;
  /*# mc6845.vhd:649:17 */
  assign n517 = n513 ? 1'b1 : n515;
  /*# mc6845.vhd:667:19 */
  assign n549 = ~nRESET;
  /*# mc6845.vhd:674:48 */
  assign n551 = {r12_start_addr_h, r13_start_addr_l};
  /*# mc6845.vhd:675:33 */
  assign n552 = h_counter == r01_h_displayed;
  /*# mc6845.vhd:675:51 */
  assign n553 = max_scanline_hit & n552;
  /*# mc6845.vhd:675:17 */
  assign n554 = n553 ? ma_i : ma_row;
  /*# mc6845.vhd:672:17 */
  assign n555 = new_frame ? n551 : n554;
  /*# mc6845.vhd:681:46 */
  assign n556 = {r12_start_addr_h, r13_start_addr_l};
  /*# mc6845.vhd:687:34 */
  assign n558 = ma_i + 14'b00000000000001;
  /*# mc6845.vhd:682:17 */
  assign n559 = r00_h_total_hit ? ma_row : n558;
  /*# mc6845.vhd:679:17 */
  assign n560 = new_frame ? n556 : n559;
  /*# mc6845.vhd:706:37 */
  assign n573 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:706:50 */
  assign n575 = n573 == 2'b11;
  /*# mc6845.vhd:706:65 */
  assign n576 = ~VGA;
  /*# mc6845.vhd:706:57 */
  assign n577 = n576 & n575;
  /*# mc6845.vhd:706:21 */
  assign n580 = n577 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:697:13 */
  assign n582 = r00_h_total_hit & CLKEN;
  /*# mc6845.vhd:716:40 */
  assign n585 = line_counter[4:1]; // extract
  /*# mc6845.vhd:716:54 */
  assign n586 = {n585, odd_field};
  /*# mc6845.vhd:716:66 */
  assign n587 = interlaced_video ? n586 : line_counter;
  /*# mc6845.vhd:730:19 */
  assign n590 = ~nRESET;
  /*# mc6845.vhd:737:49 */
  assign n592 = lpstb_sync[3:1]; // extract
  /*# mc6845.vhd:737:37 */
  assign n593 = {LPSTB, n592};
  /*# mc6845.vhd:739:30 */
  assign n594 = lpstb_sync[1]; // extract
  /*# mc6845.vhd:739:54 */
  assign n595 = lpstb_sync[0]; // extract
  /*# mc6845.vhd:739:58 */
  assign n596 = ~n595;
  /*# mc6845.vhd:739:40 */
  assign n597 = n596 & n594;
  /*# mc6845.vhd:740:44 */
  assign n598 = ma_i[13:8]; // extract
  /*# mc6845.vhd:741:44 */
  assign n599 = ma_i[7:0]; // extract
  /*# mc6845.vhd:735:13 */
  assign n602 = n597 & CLKEN;
  /*# mc6845.vhd:735:13 */
  assign n603 = n597 & CLKEN;
  /*# mc6845.vhd:753:35 */
  assign n616 = ~h_display;
  /*# mc6845.vhd:753:54 */
  assign n617 = ~v_display;
  /*# mc6845.vhd:753:41 */
  assign n618 = n616 | n617;
  /*# mc6845.vhd:753:84 */
  assign n619 = {r14_cursor_h, r15_cursor_l};
  /*# mc6845.vhd:753:68 */
  assign n620 = ma_i != n619;
  /*# mc6845.vhd:753:60 */
  assign n621 = n618 | n620;
  /*# mc6845.vhd:753:115 */
  assign n622 = $unsigned(line_counter) < $unsigned(r10_cursor_start);
  /*# mc6845.vhd:753:99 */
  assign n623 = n621 | n622;
  /*# mc6845.vhd:753:150 */
  assign n624 = $unsigned(line_counter) > $unsigned(r11_cursor_end);
  /*# mc6845.vhd:753:134 */
  assign n625 = n623 | n624;
  /*# mc6845.vhd:753:20 */
  assign n626 = n625 ? 1'b0 : n630;
  /*# mc6845.vhd:754:29 */
  assign n627 = field_counter[4]; // extract
  /*# mc6845.vhd:754:54 */
  assign n629 = r10_cursor_mode == 2'b11;
  /*# mc6845.vhd:753:167 */
  assign n630 = n629 ? n627 : n634;
  /*# mc6845.vhd:755:29 */
  assign n631 = field_counter[3]; // extract
  /*# mc6845.vhd:755:54 */
  assign n633 = r10_cursor_mode == 2'b10;
  /*# mc6845.vhd:754:61 */
  assign n634 = n633 ? n631 : n638;
  /*# mc6845.vhd:756:54 */
  assign n637 = r10_cursor_mode == 2'b00;
  /*# mc6845.vhd:755:61 */
  assign n638 = n637 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:777:37 */
  assign n653 = v_display & h_display;
  /*# mc6845.vhd:777:74 */
  assign n654 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:777:87 */
  assign n656 = n654 != 2'b11;
  /*# mc6845.vhd:777:57 */
  assign n657 = n656 & n653;
  /*# mc6845.vhd:777:16 */
  assign n658 = n657 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:779:33 */
  assign n660 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:779:46 */
  assign n662 = n660 == 2'b01;
  /*# mc6845.vhd:779:15 */
  assign n663 = n662 ? de1 : n667;
  /*# mc6845.vhd:780:33 */
  assign n664 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:780:46 */
  assign n666 = n664 == 2'b10;
  /*# mc6845.vhd:779:53 */
  assign n667 = n666 ? de2 : de0;
  /*# mc6845.vhd:784:41 */
  assign n668 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:784:54 */
  assign n670 = n668 == 2'b00;
  /*# mc6845.vhd:784:23 */
  assign n671 = n670 ? cursor0 : n675;
  /*# mc6845.vhd:785:41 */
  assign n672 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:785:54 */
  assign n674 = n672 == 2'b01;
  /*# mc6845.vhd:784:61 */
  assign n675 = n674 ? cursor1 : n679;
  /*# mc6845.vhd:786:41 */
  assign n676 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:786:54 */
  assign n678 = n676 == 2'b10;
  /*# mc6845.vhd:785:61 */
  assign n679 = n678 ? cursor2 : 1'b0;
  /*# mc6845.vhd:795:41 */
  assign n682 = ENABLE & CLKEN_CPU;
  /*# mc6845.vhd:795:67 */
  assign n683 = ~R_nW;
  /*# mc6845.vhd:795:58 */
  assign n684 = n683 & n682;
  /*# mc6845.vhd:795:20 */
  assign n685 = n684 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:796:67 */
  assign n688 = ~R_nW;
  /*# mc6845.vhd:796:58 */
  assign n689 = n688 & ENABLE;
  /*# mc6845.vhd:796:20 */
  assign n690 = n689 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:797:41 */
  assign n693 = ENABLE & CLKEN_CPU;
  /*# mc6845.vhd:797:67 */
  assign n694 = ~R_nW;
  /*# mc6845.vhd:797:58 */
  assign n695 = n694 & n693;
  /*# mc6845.vhd:797:86 */
  assign n697 = addr_reg == 5'b00000;
  /*# mc6845.vhd:797:73 */
  assign n698 = n697 & n695;
  /*# mc6845.vhd:797:20 */
  assign n699 = n698 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:798:67 */
  assign n702 = ~R_nW;
  /*# mc6845.vhd:798:58 */
  assign n703 = n702 & ENABLE;
  /*# mc6845.vhd:798:86 */
  assign n705 = addr_reg == 5'b00000;
  /*# mc6845.vhd:798:73 */
  assign n706 = n705 & n703;
  /*# mc6845.vhd:798:20 */
  assign n707 = n706 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:83:5 */
  assign n710 = {n707, n699, n690, n685};
  /*# mc6845.vhd:231:9 */
  assign n711 = n196 ? n72 : n712;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n712 <= 8'b00000000;
    else
      n712 <= n711;
  /*# mc6845.vhd:231:9 */
  assign n713 = ENABLE ? n177 : addr_reg;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n714 <= 5'b00000;
    else
      n714 <= n713;
  /*# mc6845.vhd:231:9 */
  assign n715 = ENABLE ? n178 : r00_h_total;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n716 <= 8'b00000000;
    else
      n716 <= n715;
  /*# mc6845.vhd:231:9 */
  assign n717 = ENABLE ? n179 : r01_h_displayed;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n718 <= 8'b00000000;
    else
      n718 <= n717;
  /*# mc6845.vhd:231:9 */
  assign n719 = ENABLE ? n180 : r02_h_sync_pos;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n720 <= 8'b00000000;
    else
      n720 <= n719;
  /*# mc6845.vhd:231:9 */
  assign n721 = ENABLE ? n181 : r03_v_sync_width;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n722 <= 4'b0000;
    else
      n722 <= n721;
  /*# mc6845.vhd:231:9 */
  assign n723 = ENABLE ? n182 : r03_h_sync_width;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n724 <= 4'b0000;
    else
      n724 <= n723;
  /*# mc6845.vhd:231:9 */
  assign n725 = ENABLE ? n183 : r04_v_total;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n726 <= 7'b0000000;
    else
      n726 <= n725;
  /*# mc6845.vhd:231:9 */
  assign n727 = ENABLE ? n184 : r05_v_total_adj;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n728 <= 5'b00000;
    else
      n728 <= n727;
  /*# mc6845.vhd:231:9 */
  assign n729 = ENABLE ? n185 : r06_v_displayed;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n730 <= 7'b0000000;
    else
      n730 <= n729;
  /*# mc6845.vhd:231:9 */
  assign n731 = ENABLE ? n186 : r07_v_sync_pos;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n732 <= 7'b0000000;
    else
      n732 <= n731;
  /*# mc6845.vhd:231:9 */
  assign n733 = ENABLE ? n187 : r08_interlace;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n734 <= 8'b00000000;
    else
      n734 <= n733;
  /*# mc6845.vhd:231:9 */
  assign n735 = ENABLE ? n188 : r09_max_scanline_addr;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n736 <= 5'b00000;
    else
      n736 <= n735;
  /*# mc6845.vhd:231:9 */
  assign n737 = ENABLE ? n189 : r10_cursor_mode;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n738 <= 2'b00;
    else
      n738 <= n737;
  /*# mc6845.vhd:231:9 */
  assign n739 = ENABLE ? n190 : r10_cursor_start;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n740 <= 5'b00000;
    else
      n740 <= n739;
  /*# mc6845.vhd:231:9 */
  assign n741 = ENABLE ? n191 : r11_cursor_end;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n742 <= 5'b00000;
    else
      n742 <= n741;
  /*# mc6845.vhd:231:9 */
  assign n743 = ENABLE ? n192 : r12_start_addr_h;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n744 <= 6'b000000;
    else
      n744 <= n743;
  /*# mc6845.vhd:231:9 */
  assign n745 = ENABLE ? n193 : r13_start_addr_l;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n746 <= 8'b00000000;
    else
      n746 <= n745;
  /*# mc6845.vhd:231:9 */
  assign n747 = ENABLE ? n194 : r14_cursor_h;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n748 <= 6'b000000;
    else
      n748 <= n747;
  /*# mc6845.vhd:231:9 */
  assign n749 = ENABLE ? n195 : r15_cursor_l;
  /*# mc6845.vhd:231:9 */
  always @(posedge CLOCK or posedge n50)
    if (n50)
      n750 <= 8'b00000000;
    else
      n750 <= n749;
  /*# mc6845.vhd:734:9 */
  assign n751 = n602 ? n598 : r16_light_pen_h;
  /*# mc6845.vhd:734:9 */
  always @(posedge CLOCK or posedge n590)
    if (n590)
      n752 <= 6'b000000;
    else
      n752 <= n751;
  /*# mc6845.vhd:734:9 */
  assign n753 = n603 ? n599 : r17_light_pen_l;
  /*# mc6845.vhd:734:9 */
  always @(posedge CLOCK or posedge n590)
    if (n590)
      n754 <= 8'b00000000;
    else
      n754 <= n753;
  /*# mc6845.vhd:311:9 */
  assign n755 = CLKEN ? n284 : h_counter;
  /*# mc6845.vhd:311:9 */
  always @(posedge CLOCK or posedge n279)
    if (n279)
      n756 <= 8'b00000000;
    else
      n756 <= n755;
  /*# mc6845.vhd:339:9 */
  assign n757 = CLKEN ? n298 : h_sync_counter;
  /*# mc6845.vhd:339:9 */
  always @(posedge CLOCK or posedge n292)
    if (n292)
      n758 <= 4'b0000;
    else
      n758 <= n757;
  /*# mc6845.vhd:425:9 */
  assign n759 = CLKEN ? row_counter_next : row_counter;
  /*# mc6845.vhd:425:9 */
  always @(posedge CLOCK or posedge n366)
    if (n366)
      n760 <= 7'b0000000;
    else
      n760 <= n759;
  /*# mc6845.vhd:404:9 */
  assign n761 = CLKEN ? n341 : line_counter;
  /*# mc6845.vhd:404:9 */
  always @(posedge CLOCK or posedge n337)
    if (n337)
      n762 <= 5'b00000;
    else
      n762 <= n761;
  /*# mc6845.vhd:464:9 */
  assign n763 = CLKEN ? n393 : v_sync_counter;
  /*# mc6845.vhd:464:9 */
  always @(posedge CLOCK or posedge n385)
    if (n385)
      n764 <= 4'b0000;
    else
      n764 <= n763;
  /*# mc6845.vhd:529:9 */
  always @(posedge CLOCK or posedge n440)
    if (n440)
      n765 <= 5'b00000;
    else
      n765 <= n452;
  /*# mc6845.vhd:381:9 */
  always @(posedge CLOCK or posedge n320)
    if (n320)
      n766 <= 1'b0;
    else
      n766 <= n330;
  /*# mc6845.vhd:360:9 */
  always @(posedge CLOCK or posedge n306)
    if (n306)
      n767 <= 1'b0;
    else
      n767 <= n313;
  /*# mc6845.vhd:529:9 */
  always @(posedge CLOCK or posedge n440)
    if (n440)
      n768 <= 1'b0;
    else
      n768 <= n454;
  /*# mc6845.vhd:138:8 */
  assign n769 = ~n385;
  /*# mc6845.vhd:138:8 */
  assign n770 = CLKEN & n769;
  /*# mc6845.vhd:464:9 */
  assign n771 = n770 ? vs_hit : vs_hit_last;
  /*# mc6845.vhd:464:9 */
  always @(posedge CLOCK)
    n772 <= n771;
  /*# mc6845.vhd:482:9 */
  always @(posedge CLOCK or posedge n404)
    if (n404)
      n773 <= 1'b0;
    else
      n773 <= n414;
  /*# mc6845.vhd:496:9 */
  assign n774 = n427 ? vs_even : vs_odd;
  /*# mc6845.vhd:496:9 */
  always @(posedge CLOCK)
    n775 <= n774;
  /*# mc6845.vhd:529:9 */
  assign n776 = first_scanline ? n444 : odd_field;
  /*# mc6845.vhd:529:9 */
  always @(posedge CLOCK or posedge n440)
    if (n440)
      n777 <= 1'b0;
    else
      n777 <= n776;
  /*# mc6845.vhd:670:9 */
  assign n778 = CLKEN ? n560 : ma_i;
  /*# mc6845.vhd:670:9 */
  always @(posedge CLOCK or posedge n549)
    if (n549)
      n779 <= 14'b00000000000000;
    else
      n779 <= n778;
  /*# mc6845.vhd:734:9 */
  assign n780 = CLKEN ? n593 : lpstb_sync;
  /*# mc6845.vhd:734:9 */
  always @(posedge CLOCK or posedge n590)
    if (n590)
      n781 <= 4'b0000;
    else
      n781 <= n780;
  /*# mc6845.vhd:767:9 */
  assign n782 = CLKEN ? de0 : de1;
  /*# mc6845.vhd:767:9 */
  always @(posedge CLOCK)
    n783 <= n782;
  /*# mc6845.vhd:767:9 */
  assign n784 = CLKEN ? de1 : de2;
  /*# mc6845.vhd:767:9 */
  always @(posedge CLOCK)
    n785 <= n784;
  /*# mc6845.vhd:767:9 */
  assign n786 = CLKEN ? cursor0 : cursor1;
  /*# mc6845.vhd:767:9 */
  always @(posedge CLOCK)
    n787 <= n786;
  /*# mc6845.vhd:767:9 */
  assign n788 = CLKEN ? cursor1 : cursor2;
  /*# mc6845.vhd:767:9 */
  always @(posedge CLOCK)
    n789 <= n788;
  /*# mc6845.vhd:696:9 */
  assign n790 = n582 ? n580 : interlaced_video;
  /*# mc6845.vhd:696:9 */
  always @(posedge CLOCK)
    n791 <= n790;
  /*# mc6845.vhd:670:9 */
  assign n792 = CLKEN ? n555 : ma_row;
  /*# mc6845.vhd:670:9 */
  always @(posedge CLOCK or posedge n549)
    if (n549)
      n793 <= 14'b00000000000000;
    else
      n793 <= n792;
  /*# mc6845.vhd:564:9 */
  assign n794 = CLKEN ? n488 : in_adj;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n795 <= 1'b0;
    else
      n795 <= n794;
  /*# mc6845.vhd:564:9 */
  assign n796 = CLKEN ? n502 : adj_in_progress;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n797 <= 1'b0;
    else
      n797 <= n796;
  /*# mc6845.vhd:564:9 */
  assign n798 = CLKEN ? n471 : sol;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n799 <= 3'b000;
    else
      n799 <= n798;
  /*# mc6845.vhd:564:9 */
  assign n800 = CLKEN ? n479 : eom_latched;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n801 <= 1'b0;
    else
      n801 <= n800;
  /*# mc6845.vhd:564:9 */
  assign n802 = CLKEN ? n496 : eof_latched;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n803 <= 1'b0;
    else
      n803 <= n802;
  /*# mc6845.vhd:564:9 */
  assign n804 = CLKEN ? n506 : first_scanline;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n805 <= 1'b0;
    else
      n805 <= n804;
  /*# mc6845.vhd:564:9 */
  assign n806 = CLKEN ? n517 : extra_scanline;
  /*# mc6845.vhd:564:9 */
  always @(posedge CLOCK or posedge n468)
    if (n468)
      n807 <= 1'b0;
    else
      n807 <= n806;
endmodule


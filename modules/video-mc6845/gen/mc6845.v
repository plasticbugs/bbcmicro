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
  wire n49;
  wire [7:0] n52;
  wire n54;
  wire n56;
  wire [7:0] n58;
  wire n60;
  wire n62;
  wire [7:0] n64;
  wire n66;
  wire n68;
  wire [5:0] n69;
  reg [7:0] n71;
  wire n72;
  wire [4:0] n73;
  wire n75;
  wire n77;
  wire n79;
  wire [3:0] n80;
  wire [3:0] n81;
  wire n83;
  wire [6:0] n84;
  wire n86;
  wire [4:0] n87;
  wire n89;
  wire [6:0] n90;
  wire n92;
  wire [6:0] n93;
  wire n95;
  wire n97;
  wire [4:0] n98;
  wire n100;
  wire [1:0] n101;
  wire [4:0] n102;
  wire n104;
  wire [4:0] n105;
  wire n107;
  wire [5:0] n108;
  wire n110;
  wire n112;
  wire [5:0] n113;
  wire n115;
  wire n117;
  wire [15:0] n118;
  reg [7:0] n119;
  reg [7:0] n120;
  reg [7:0] n121;
  reg [3:0] n122;
  reg [3:0] n123;
  reg [6:0] n124;
  reg [4:0] n125;
  reg [6:0] n126;
  reg [6:0] n127;
  reg [7:0] n128;
  reg [4:0] n129;
  reg [1:0] n130;
  reg [4:0] n131;
  reg [4:0] n132;
  reg [5:0] n133;
  reg [7:0] n134;
  reg [5:0] n135;
  reg [7:0] n136;
  wire [4:0] n137;
  wire [7:0] n138;
  wire [7:0] n139;
  wire [7:0] n140;
  wire [3:0] n141;
  wire [3:0] n142;
  wire [6:0] n143;
  wire [4:0] n144;
  wire [6:0] n145;
  wire [6:0] n146;
  wire [7:0] n147;
  wire [4:0] n148;
  wire [1:0] n149;
  wire [4:0] n150;
  wire [4:0] n151;
  wire [5:0] n152;
  wire [7:0] n153;
  wire [5:0] n154;
  wire [7:0] n155;
  wire n156;
  wire [7:0] n157;
  wire [7:0] n158;
  wire [7:0] n159;
  wire [3:0] n160;
  wire [3:0] n161;
  wire [6:0] n162;
  wire [4:0] n163;
  wire [6:0] n164;
  wire [6:0] n165;
  wire [7:0] n166;
  wire [4:0] n167;
  wire [1:0] n168;
  wire [4:0] n169;
  wire [4:0] n170;
  wire [5:0] n171;
  wire [7:0] n172;
  wire [5:0] n173;
  wire [7:0] n174;
  wire [4:0] n176;
  wire [7:0] n177;
  wire [7:0] n178;
  wire [7:0] n179;
  wire [3:0] n180;
  wire [3:0] n181;
  wire [6:0] n182;
  wire [4:0] n183;
  wire [6:0] n184;
  wire [6:0] n185;
  wire [7:0] n186;
  wire [4:0] n187;
  wire [1:0] n188;
  wire [4:0] n189;
  wire [4:0] n190;
  wire [5:0] n191;
  wire [7:0] n192;
  wire [5:0] n193;
  wire [7:0] n194;
  wire n195;
  wire n278;
  wire [7:0] n281;
  wire [7:0] n283;
  wire n291;
  wire n293;
  wire [3:0] n295;
  wire [3:0] n297;
  wire n305;
  wire n307;
  wire n308;
  wire n310;
  wire n312;
  wire n319;
  wire n321;
  wire n322;
  wire n323;
  wire n325;
  wire n327;
  wire n329;
  wire n336;
  wire [4:0] n338;
  wire [4:0] n340;
  wire [4:0] n347;
  wire [4:0] n349;
  wire [1:0] n350;
  wire n352;
  wire n353;
  wire n354;
  wire n355;
  wire n356;
  wire [4:0] n357;
  wire [3:0] n358;
  wire [3:0] n360;
  wire [4:0] n362;
  wire n365;
  wire [6:0] n373;
  wire [6:0] n375;
  wire n376;
  wire [6:0] n377;
  wire n379;
  wire n380;
  wire n384;
  wire n386;
  wire n387;
  wire [3:0] n389;
  wire [3:0] n390;
  wire [3:0] n392;
  wire n403;
  wire n405;
  wire n406;
  wire n407;
  wire n408;
  wire n409;
  wire n411;
  wire n413;
  wire [6:0] n421;
  wire [7:0] n423;
  wire n424;
  wire n426;
  wire n429;
  wire n430;
  wire n431;
  wire n432;
  wire n433;
  wire n434;
  wire n437;
  wire n439;
  wire n440;
  wire n441;
  wire [4:0] n443;
  wire [4:0] n444;
  wire n446;
  wire [4:0] n447;
  wire n449;
  wire n463;
  wire [1:0] n465;
  wire [2:0] n466;
  wire n467;
  wire n468;
  wire n469;
  wire n470;
  wire n472;
  wire n474;
  wire n475;
  wire n476;
  wire n477;
  wire n480;
  wire n481;
  wire n483;
  wire n484;
  wire n485;
  wire n486;
  wire n487;
  wire n489;
  wire n491;
  wire n492;
  wire n493;
  wire n495;
  wire n497;
  wire n499;
  wire n501;
  wire n502;
  wire n503;
  wire n504;
  wire n505;
  wire n506;
  wire n507;
  wire n508;
  wire n510;
  wire n512;
  wire n544;
  wire [13:0] n546;
  wire n547;
  wire n548;
  wire [13:0] n549;
  wire [13:0] n550;
  wire [13:0] n551;
  wire [13:0] n553;
  wire [13:0] n554;
  wire [13:0] n555;
  wire [1:0] n568;
  wire n570;
  wire n571;
  wire n572;
  wire n575;
  wire n577;
  wire [3:0] n580;
  wire [4:0] n581;
  wire [4:0] n582;
  wire n585;
  wire [2:0] n587;
  wire [3:0] n588;
  wire n589;
  wire n590;
  wire n591;
  wire n592;
  wire [5:0] n593;
  wire [7:0] n594;
  wire n597;
  wire n598;
  wire n611;
  wire n612;
  wire n613;
  wire [13:0] n614;
  wire n615;
  wire n616;
  wire n617;
  wire n618;
  wire n619;
  wire n620;
  wire n621;
  wire n622;
  wire n624;
  wire n625;
  wire n626;
  wire n628;
  wire n629;
  wire n632;
  wire n633;
  wire n648;
  wire [1:0] n649;
  wire n651;
  wire n652;
  wire n653;
  wire [1:0] n655;
  wire n657;
  wire n658;
  wire [1:0] n659;
  wire n661;
  wire n662;
  wire [1:0] n663;
  wire n665;
  wire n666;
  wire [1:0] n667;
  wire n669;
  wire n670;
  wire [1:0] n671;
  wire n673;
  wire n674;
  wire n677;
  wire n678;
  wire n679;
  wire n680;
  wire n683;
  wire n684;
  wire n685;
  wire n688;
  wire n689;
  wire n690;
  wire n692;
  wire n693;
  wire n694;
  wire n697;
  wire n698;
  wire n700;
  wire n701;
  wire n702;
  wire [3:0] n705;
  wire [7:0] n706;
  reg [7:0] n707;
  wire [4:0] n708;
  reg [4:0] n709;
  wire [7:0] n710;
  reg [7:0] n711;
  wire [7:0] n712;
  reg [7:0] n713;
  wire [7:0] n714;
  reg [7:0] n715;
  wire [3:0] n716;
  reg [3:0] n717;
  wire [3:0] n718;
  reg [3:0] n719;
  wire [6:0] n720;
  reg [6:0] n721;
  wire [4:0] n722;
  reg [4:0] n723;
  wire [6:0] n724;
  reg [6:0] n725;
  wire [6:0] n726;
  reg [6:0] n727;
  wire [7:0] n728;
  reg [7:0] n729;
  wire [4:0] n730;
  reg [4:0] n731;
  wire [1:0] n732;
  reg [1:0] n733;
  wire [4:0] n734;
  reg [4:0] n735;
  wire [4:0] n736;
  reg [4:0] n737;
  wire [5:0] n738;
  reg [5:0] n739;
  wire [7:0] n740;
  reg [7:0] n741;
  wire [5:0] n742;
  reg [5:0] n743;
  wire [7:0] n744;
  reg [7:0] n745;
  wire [5:0] n746;
  reg [5:0] n747;
  wire [7:0] n748;
  reg [7:0] n749;
  wire [7:0] n750;
  reg [7:0] n751;
  wire [3:0] n752;
  reg [3:0] n753;
  wire [6:0] n754;
  reg [6:0] n755;
  wire [4:0] n756;
  reg [4:0] n757;
  wire [3:0] n758;
  reg [3:0] n759;
  reg [4:0] n760;
  reg n761;
  reg n762;
  reg n763;
  wire n764;
  wire n765;
  wire n766;
  reg n767;
  reg n768;
  wire n769;
  reg n770;
  wire n771;
  reg n772;
  wire [13:0] n773;
  reg [13:0] n774;
  wire [3:0] n775;
  reg [3:0] n776;
  wire n777;
  reg n778;
  wire n779;
  reg n780;
  wire n781;
  reg n782;
  wire n783;
  reg n784;
  wire n785;
  reg n786;
  wire [13:0] n787;
  reg [13:0] n788;
  wire n789;
  reg n790;
  wire n791;
  reg n792;
  wire [2:0] n793;
  reg [2:0] n794;
  wire n795;
  reg n796;
  wire n797;
  reg n798;
  wire n799;
  reg n800;
  wire n801;
  reg n802;
  assign DO = n707; //(module output)
  assign VSYNC = vs; //(module output)
  assign HSYNC = hs; //(module output)
  assign DE = n658; //(module output)
  assign CURSOR = n666; //(module output)
  assign MA = ma_i; //(module output)
  assign RA = n582; //(module output)
  assign test = n705; //(module output)
  /*# mc6845.vhd:80:8 */
  assign addr_reg = n709; // (signal)
  /*# mc6845.vhd:83:8 */
  assign r00_h_total = n711; // (signal)
  /*# mc6845.vhd:84:8 */
  assign r01_h_displayed = n713; // (signal)
  /*# mc6845.vhd:85:8 */
  assign r02_h_sync_pos = n715; // (signal)
  /*# mc6845.vhd:86:8 */
  assign r03_v_sync_width = n717; // (signal)
  /*# mc6845.vhd:87:8 */
  assign r03_h_sync_width = n719; // (signal)
  /*# mc6845.vhd:88:8 */
  assign r04_v_total = n721; // (signal)
  /*# mc6845.vhd:89:8 */
  assign r05_v_total_adj = n723; // (signal)
  /*# mc6845.vhd:90:8 */
  assign r06_v_displayed = n725; // (signal)
  /*# mc6845.vhd:91:8 */
  assign r07_v_sync_pos = n727; // (signal)
  /*# mc6845.vhd:92:8 */
  assign r08_interlace = n729; // (signal)
  /*# mc6845.vhd:93:8 */
  assign r09_max_scanline_addr = n731; // (signal)
  /*# mc6845.vhd:94:8 */
  assign r10_cursor_mode = n733; // (signal)
  /*# mc6845.vhd:95:8 */
  assign r10_cursor_start = n735; // (signal)
  /*# mc6845.vhd:96:8 */
  assign r11_cursor_end = n737; // (signal)
  /*# mc6845.vhd:97:8 */
  assign r12_start_addr_h = n739; // (signal)
  /*# mc6845.vhd:98:8 */
  assign r13_start_addr_l = n741; // (signal)
  /*# mc6845.vhd:100:8 */
  assign r14_cursor_h = n743; // (signal)
  /*# mc6845.vhd:101:8 */
  assign r15_cursor_l = n745; // (signal)
  /*# mc6845.vhd:103:8 */
  assign r16_light_pen_h = n747; // (signal)
  /*# mc6845.vhd:104:8 */
  assign r17_light_pen_l = n749; // (signal)
  /*# mc6845.vhd:108:8 */
  assign h_counter = n751; // (signal)
  /*# mc6845.vhd:110:8 */
  assign h_sync_counter = n753; // (signal)
  /*# mc6845.vhd:112:8 */
  assign row_counter = n755; // (signal)
  /*# mc6845.vhd:113:8 */
  assign row_counter_next = n373; // (signal)
  /*# mc6845.vhd:115:8 */
  assign line_counter = n757; // (signal)
  /*# mc6845.vhd:116:8 */
  assign line_counter_next = n347; // (signal)
  /*# mc6845.vhd:118:8 */
  assign v_sync_counter = n759; // (signal)
  /*# mc6845.vhd:120:8 */
  assign field_counter = n760; // (signal)
  /*# mc6845.vhd:123:8 */
  assign h_display = n761; // (signal)
  /*# mc6845.vhd:124:8 */
  assign hs = n762; // (signal)
  /*# mc6845.vhd:125:8 */
  assign v_display = n763; // (signal)
  /*# mc6845.vhd:126:8 */
  assign vs = n434; // (signal)
  /*# mc6845.vhd:127:8 */
  assign vs_hit = n380; // (signal)
  /*# mc6845.vhd:128:8 */
  assign vs_hit_last = n767; // (signal)
  /*# mc6845.vhd:129:8 */
  assign vs_even = n768; // (signal)
  /*# mc6845.vhd:130:8 */
  assign vs_odd = n770; // (signal)
  /*# mc6845.vhd:131:8 */
  assign odd_field = n772; // (signal)
  /*# mc6845.vhd:132:8 */
  assign ma_i = n774; // (signal)
  /*# mc6845.vhd:134:8 */
  assign lpstb_sync = n776; // (signal)
  /*# mc6845.vhd:135:8 */
  assign de0 = n653; // (signal)
  /*# mc6845.vhd:136:8 */
  assign de1 = n778; // (signal)
  /*# mc6845.vhd:137:8 */
  assign de2 = n780; // (signal)
  /*# mc6845.vhd:138:8 */
  assign cursor0 = n621; // (signal)
  /*# mc6845.vhd:139:8 */
  assign cursor1 = n782; // (signal)
  /*# mc6845.vhd:140:8 */
  assign cursor2 = n784; // (signal)
  /*# mc6845.vhd:141:8 */
  assign interlaced_video = n786; // (signal)
  /*# mc6845.vhd:142:8 */
  assign max_scanline = n10; // (signal)
  /*# mc6845.vhd:143:8 */
  assign adj_scanline = n30; // (signal)
  /*# mc6845.vhd:144:8 */
  assign ma_row = n788; // (signal)
  /*# mc6845.vhd:146:8 */
  assign in_adj = n790; // (signal)
  /*# mc6845.vhd:147:8 */
  assign adj_in_progress = n792; // (signal)
  /*# mc6845.vhd:148:8 */
  assign sol = n794; // (signal)
  /*# mc6845.vhd:149:8 */
  assign eom_latched = n796; // (signal)
  /*# mc6845.vhd:150:8 */
  assign eof_latched = n798; // (signal)
  /*# mc6845.vhd:151:8 */
  assign first_scanline = n800; // (signal)
  /*# mc6845.vhd:152:8 */
  assign extra_scanline = n802; // (signal)
  /*# mc6845.vhd:153:8 */
  assign new_frame = n45; // (signal)
  /*# mc6845.vhd:155:8 */
  assign r00_h_total_hit = n33; // (signal)
  /*# mc6845.vhd:156:8 */
  assign max_scanline_hit = n22; // (signal)
  /*# mc6845.vhd:172:43 */
  assign n9 = r09_max_scanline_addr + 5'b00001;
  /*# mc6845.vhd:172:61 */
  assign n10 = VGA ? n9 : n17;
  /*# mc6845.vhd:173:42 */
  assign n11 = r09_max_scanline_addr[4:1]; // extract
  /*# mc6845.vhd:173:55 */
  assign n13 = {n11, 1'b0};
  /*# mc6845.vhd:173:79 */
  assign n14 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:173:92 */
  assign n16 = n14 == 2'b11;
  /*# mc6845.vhd:172:99 */
  assign n17 = n16 ? n13 : r09_max_scanline_addr;
  /*# mc6845.vhd:177:47 */
  assign n19 = line_counter == max_scanline;
  /*# mc6845.vhd:177:82 */
  assign n20 = ~adj_in_progress;
  /*# mc6845.vhd:177:62 */
  assign n21 = n20 & n19;
  /*# mc6845.vhd:177:29 */
  assign n22 = n21 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:181:37 */
  assign n25 = r05_v_total_adj + 5'b00010;
  /*# mc6845.vhd:181:59 */
  assign n26 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:181:72 */
  assign n28 = n26 == 2'b11;
  /*# mc6845.vhd:181:79 */
  assign n29 = VGA & n28;
  /*# mc6845.vhd:181:41 */
  assign n30 = n29 ? n25 : r05_v_total_adj;
  /*# mc6845.vhd:185:43 */
  assign n32 = h_counter == r00_h_total;
  /*# mc6845.vhd:185:28 */
  assign n33 = n32 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:188:49 */
  assign n36 = eof_latched & r00_h_total_hit;
  /*# mc6845.vhd:188:89 */
  assign n37 = r08_interlace[0]; // extract
  /*# mc6845.vhd:188:93 */
  assign n38 = ~n37;
  /*# mc6845.vhd:188:115 */
  assign n39 = field_counter[0]; // extract
  /*# mc6845.vhd:188:119 */
  assign n40 = ~n39;
  /*# mc6845.vhd:188:99 */
  assign n41 = n38 | n40;
  /*# mc6845.vhd:188:125 */
  assign n42 = n41 | extra_scanline;
  /*# mc6845.vhd:188:149 */
  assign n43 = n42 | VGA;
  /*# mc6845.vhd:188:71 */
  assign n44 = n43 & n36;
  /*# mc6845.vhd:188:22 */
  assign n45 = n44 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:198:19 */
  assign n49 = ~nRESET;
  /*# mc6845.vhd:227:36 */
  assign n52 = {2'b00, r12_start_addr_h};
  /*# mc6845.vhd:226:21 */
  assign n54 = addr_reg == 5'b01100;
  /*# mc6845.vhd:228:21 */
  assign n56 = addr_reg == 5'b01101;
  /*# mc6845.vhd:231:36 */
  assign n58 = {2'b00, r14_cursor_h};
  /*# mc6845.vhd:230:21 */
  assign n60 = addr_reg == 5'b01110;
  /*# mc6845.vhd:232:21 */
  assign n62 = addr_reg == 5'b01111;
  /*# mc6845.vhd:235:36 */
  assign n64 = {2'b00, r16_light_pen_h};
  /*# mc6845.vhd:234:21 */
  assign n66 = addr_reg == 5'b10000;
  /*# mc6845.vhd:236:21 */
  assign n68 = addr_reg == 5'b10001;
  /*# mc6845.vhd:225:21 */
  assign n69 = {n68, n66, n62, n60, n56, n54};
  /*# mc6845.vhd:225:21 */
  always @*
    case (n69)
      6'b100000: n71 = r17_light_pen_l;
      6'b010000: n71 = n64;
      6'b001000: n71 = r15_cursor_l;
      6'b000100: n71 = n58;
      6'b000010: n71 = r13_start_addr_l;
      6'b000001: n71 = n52;
      default: n71 = 8'b00000000;
    endcase
  /*# mc6845.vhd:243:27 */
  assign n72 = ~RS;
  /*# mc6845.vhd:244:39 */
  assign n73 = DI[4:0]; // extract
  /*# mc6845.vhd:247:25 */
  assign n75 = addr_reg == 5'b00000;
  /*# mc6845.vhd:249:25 */
  assign n77 = addr_reg == 5'b00001;
  /*# mc6845.vhd:251:25 */
  assign n79 = addr_reg == 5'b00010;
  /*# mc6845.vhd:254:60 */
  assign n80 = DI[7:4]; // extract
  /*# mc6845.vhd:255:60 */
  assign n81 = DI[3:0]; // extract
  /*# mc6845.vhd:253:25 */
  assign n83 = addr_reg == 5'b00011;
  /*# mc6845.vhd:257:55 */
  assign n84 = DI[6:0]; // extract
  /*# mc6845.vhd:256:25 */
  assign n86 = addr_reg == 5'b00100;
  /*# mc6845.vhd:259:59 */
  assign n87 = DI[4:0]; // extract
  /*# mc6845.vhd:258:25 */
  assign n89 = addr_reg == 5'b00101;
  /*# mc6845.vhd:261:59 */
  assign n90 = DI[6:0]; // extract
  /*# mc6845.vhd:260:25 */
  assign n92 = addr_reg == 5'b00110;
  /*# mc6845.vhd:263:58 */
  assign n93 = DI[6:0]; // extract
  /*# mc6845.vhd:262:25 */
  assign n95 = addr_reg == 5'b00111;
  /*# mc6845.vhd:264:25 */
  assign n97 = addr_reg == 5'b01000;
  /*# mc6845.vhd:267:65 */
  assign n98 = DI[4:0]; // extract
  /*# mc6845.vhd:266:25 */
  assign n100 = addr_reg == 5'b01001;
  /*# mc6845.vhd:269:50 */
  assign n101 = DI[6:5]; // extract
  /*# mc6845.vhd:270:60 */
  assign n102 = DI[4:0]; // extract
  /*# mc6845.vhd:268:25 */
  assign n104 = addr_reg == 5'b01010;
  /*# mc6845.vhd:272:58 */
  assign n105 = DI[4:0]; // extract
  /*# mc6845.vhd:271:25 */
  assign n107 = addr_reg == 5'b01011;
  /*# mc6845.vhd:274:60 */
  assign n108 = DI[5:0]; // extract
  /*# mc6845.vhd:273:25 */
  assign n110 = addr_reg == 5'b01100;
  /*# mc6845.vhd:275:25 */
  assign n112 = addr_reg == 5'b01101;
  /*# mc6845.vhd:278:56 */
  assign n113 = DI[5:0]; // extract
  /*# mc6845.vhd:277:25 */
  assign n115 = addr_reg == 5'b01110;
  /*# mc6845.vhd:279:25 */
  assign n117 = addr_reg == 5'b01111;
  /*# mc6845.vhd:246:25 */
  assign n118 = {n117, n115, n112, n110, n107, n104, n100, n97, n95, n92, n89, n86, n83, n79, n77, n75};
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n119 = r00_h_total;
      16'b0100000000000000: n119 = r00_h_total;
      16'b0010000000000000: n119 = r00_h_total;
      16'b0001000000000000: n119 = r00_h_total;
      16'b0000100000000000: n119 = r00_h_total;
      16'b0000010000000000: n119 = r00_h_total;
      16'b0000001000000000: n119 = r00_h_total;
      16'b0000000100000000: n119 = r00_h_total;
      16'b0000000010000000: n119 = r00_h_total;
      16'b0000000001000000: n119 = r00_h_total;
      16'b0000000000100000: n119 = r00_h_total;
      16'b0000000000010000: n119 = r00_h_total;
      16'b0000000000001000: n119 = r00_h_total;
      16'b0000000000000100: n119 = r00_h_total;
      16'b0000000000000010: n119 = r00_h_total;
      16'b0000000000000001: n119 = DI;
      default: n119 = r00_h_total;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n120 = r01_h_displayed;
      16'b0100000000000000: n120 = r01_h_displayed;
      16'b0010000000000000: n120 = r01_h_displayed;
      16'b0001000000000000: n120 = r01_h_displayed;
      16'b0000100000000000: n120 = r01_h_displayed;
      16'b0000010000000000: n120 = r01_h_displayed;
      16'b0000001000000000: n120 = r01_h_displayed;
      16'b0000000100000000: n120 = r01_h_displayed;
      16'b0000000010000000: n120 = r01_h_displayed;
      16'b0000000001000000: n120 = r01_h_displayed;
      16'b0000000000100000: n120 = r01_h_displayed;
      16'b0000000000010000: n120 = r01_h_displayed;
      16'b0000000000001000: n120 = r01_h_displayed;
      16'b0000000000000100: n120 = r01_h_displayed;
      16'b0000000000000010: n120 = DI;
      16'b0000000000000001: n120 = r01_h_displayed;
      default: n120 = r01_h_displayed;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n121 = r02_h_sync_pos;
      16'b0100000000000000: n121 = r02_h_sync_pos;
      16'b0010000000000000: n121 = r02_h_sync_pos;
      16'b0001000000000000: n121 = r02_h_sync_pos;
      16'b0000100000000000: n121 = r02_h_sync_pos;
      16'b0000010000000000: n121 = r02_h_sync_pos;
      16'b0000001000000000: n121 = r02_h_sync_pos;
      16'b0000000100000000: n121 = r02_h_sync_pos;
      16'b0000000010000000: n121 = r02_h_sync_pos;
      16'b0000000001000000: n121 = r02_h_sync_pos;
      16'b0000000000100000: n121 = r02_h_sync_pos;
      16'b0000000000010000: n121 = r02_h_sync_pos;
      16'b0000000000001000: n121 = r02_h_sync_pos;
      16'b0000000000000100: n121 = DI;
      16'b0000000000000010: n121 = r02_h_sync_pos;
      16'b0000000000000001: n121 = r02_h_sync_pos;
      default: n121 = r02_h_sync_pos;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n122 = r03_v_sync_width;
      16'b0100000000000000: n122 = r03_v_sync_width;
      16'b0010000000000000: n122 = r03_v_sync_width;
      16'b0001000000000000: n122 = r03_v_sync_width;
      16'b0000100000000000: n122 = r03_v_sync_width;
      16'b0000010000000000: n122 = r03_v_sync_width;
      16'b0000001000000000: n122 = r03_v_sync_width;
      16'b0000000100000000: n122 = r03_v_sync_width;
      16'b0000000010000000: n122 = r03_v_sync_width;
      16'b0000000001000000: n122 = r03_v_sync_width;
      16'b0000000000100000: n122 = r03_v_sync_width;
      16'b0000000000010000: n122 = r03_v_sync_width;
      16'b0000000000001000: n122 = n80;
      16'b0000000000000100: n122 = r03_v_sync_width;
      16'b0000000000000010: n122 = r03_v_sync_width;
      16'b0000000000000001: n122 = r03_v_sync_width;
      default: n122 = r03_v_sync_width;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n123 = r03_h_sync_width;
      16'b0100000000000000: n123 = r03_h_sync_width;
      16'b0010000000000000: n123 = r03_h_sync_width;
      16'b0001000000000000: n123 = r03_h_sync_width;
      16'b0000100000000000: n123 = r03_h_sync_width;
      16'b0000010000000000: n123 = r03_h_sync_width;
      16'b0000001000000000: n123 = r03_h_sync_width;
      16'b0000000100000000: n123 = r03_h_sync_width;
      16'b0000000010000000: n123 = r03_h_sync_width;
      16'b0000000001000000: n123 = r03_h_sync_width;
      16'b0000000000100000: n123 = r03_h_sync_width;
      16'b0000000000010000: n123 = r03_h_sync_width;
      16'b0000000000001000: n123 = n81;
      16'b0000000000000100: n123 = r03_h_sync_width;
      16'b0000000000000010: n123 = r03_h_sync_width;
      16'b0000000000000001: n123 = r03_h_sync_width;
      default: n123 = r03_h_sync_width;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n124 = r04_v_total;
      16'b0100000000000000: n124 = r04_v_total;
      16'b0010000000000000: n124 = r04_v_total;
      16'b0001000000000000: n124 = r04_v_total;
      16'b0000100000000000: n124 = r04_v_total;
      16'b0000010000000000: n124 = r04_v_total;
      16'b0000001000000000: n124 = r04_v_total;
      16'b0000000100000000: n124 = r04_v_total;
      16'b0000000010000000: n124 = r04_v_total;
      16'b0000000001000000: n124 = r04_v_total;
      16'b0000000000100000: n124 = r04_v_total;
      16'b0000000000010000: n124 = n84;
      16'b0000000000001000: n124 = r04_v_total;
      16'b0000000000000100: n124 = r04_v_total;
      16'b0000000000000010: n124 = r04_v_total;
      16'b0000000000000001: n124 = r04_v_total;
      default: n124 = r04_v_total;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n125 = r05_v_total_adj;
      16'b0100000000000000: n125 = r05_v_total_adj;
      16'b0010000000000000: n125 = r05_v_total_adj;
      16'b0001000000000000: n125 = r05_v_total_adj;
      16'b0000100000000000: n125 = r05_v_total_adj;
      16'b0000010000000000: n125 = r05_v_total_adj;
      16'b0000001000000000: n125 = r05_v_total_adj;
      16'b0000000100000000: n125 = r05_v_total_adj;
      16'b0000000010000000: n125 = r05_v_total_adj;
      16'b0000000001000000: n125 = r05_v_total_adj;
      16'b0000000000100000: n125 = n87;
      16'b0000000000010000: n125 = r05_v_total_adj;
      16'b0000000000001000: n125 = r05_v_total_adj;
      16'b0000000000000100: n125 = r05_v_total_adj;
      16'b0000000000000010: n125 = r05_v_total_adj;
      16'b0000000000000001: n125 = r05_v_total_adj;
      default: n125 = r05_v_total_adj;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n126 = r06_v_displayed;
      16'b0100000000000000: n126 = r06_v_displayed;
      16'b0010000000000000: n126 = r06_v_displayed;
      16'b0001000000000000: n126 = r06_v_displayed;
      16'b0000100000000000: n126 = r06_v_displayed;
      16'b0000010000000000: n126 = r06_v_displayed;
      16'b0000001000000000: n126 = r06_v_displayed;
      16'b0000000100000000: n126 = r06_v_displayed;
      16'b0000000010000000: n126 = r06_v_displayed;
      16'b0000000001000000: n126 = n90;
      16'b0000000000100000: n126 = r06_v_displayed;
      16'b0000000000010000: n126 = r06_v_displayed;
      16'b0000000000001000: n126 = r06_v_displayed;
      16'b0000000000000100: n126 = r06_v_displayed;
      16'b0000000000000010: n126 = r06_v_displayed;
      16'b0000000000000001: n126 = r06_v_displayed;
      default: n126 = r06_v_displayed;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n127 = r07_v_sync_pos;
      16'b0100000000000000: n127 = r07_v_sync_pos;
      16'b0010000000000000: n127 = r07_v_sync_pos;
      16'b0001000000000000: n127 = r07_v_sync_pos;
      16'b0000100000000000: n127 = r07_v_sync_pos;
      16'b0000010000000000: n127 = r07_v_sync_pos;
      16'b0000001000000000: n127 = r07_v_sync_pos;
      16'b0000000100000000: n127 = r07_v_sync_pos;
      16'b0000000010000000: n127 = n93;
      16'b0000000001000000: n127 = r07_v_sync_pos;
      16'b0000000000100000: n127 = r07_v_sync_pos;
      16'b0000000000010000: n127 = r07_v_sync_pos;
      16'b0000000000001000: n127 = r07_v_sync_pos;
      16'b0000000000000100: n127 = r07_v_sync_pos;
      16'b0000000000000010: n127 = r07_v_sync_pos;
      16'b0000000000000001: n127 = r07_v_sync_pos;
      default: n127 = r07_v_sync_pos;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n128 = r08_interlace;
      16'b0100000000000000: n128 = r08_interlace;
      16'b0010000000000000: n128 = r08_interlace;
      16'b0001000000000000: n128 = r08_interlace;
      16'b0000100000000000: n128 = r08_interlace;
      16'b0000010000000000: n128 = r08_interlace;
      16'b0000001000000000: n128 = r08_interlace;
      16'b0000000100000000: n128 = DI;
      16'b0000000010000000: n128 = r08_interlace;
      16'b0000000001000000: n128 = r08_interlace;
      16'b0000000000100000: n128 = r08_interlace;
      16'b0000000000010000: n128 = r08_interlace;
      16'b0000000000001000: n128 = r08_interlace;
      16'b0000000000000100: n128 = r08_interlace;
      16'b0000000000000010: n128 = r08_interlace;
      16'b0000000000000001: n128 = r08_interlace;
      default: n128 = r08_interlace;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n129 = r09_max_scanline_addr;
      16'b0100000000000000: n129 = r09_max_scanline_addr;
      16'b0010000000000000: n129 = r09_max_scanline_addr;
      16'b0001000000000000: n129 = r09_max_scanline_addr;
      16'b0000100000000000: n129 = r09_max_scanline_addr;
      16'b0000010000000000: n129 = r09_max_scanline_addr;
      16'b0000001000000000: n129 = n98;
      16'b0000000100000000: n129 = r09_max_scanline_addr;
      16'b0000000010000000: n129 = r09_max_scanline_addr;
      16'b0000000001000000: n129 = r09_max_scanline_addr;
      16'b0000000000100000: n129 = r09_max_scanline_addr;
      16'b0000000000010000: n129 = r09_max_scanline_addr;
      16'b0000000000001000: n129 = r09_max_scanline_addr;
      16'b0000000000000100: n129 = r09_max_scanline_addr;
      16'b0000000000000010: n129 = r09_max_scanline_addr;
      16'b0000000000000001: n129 = r09_max_scanline_addr;
      default: n129 = r09_max_scanline_addr;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n130 = r10_cursor_mode;
      16'b0100000000000000: n130 = r10_cursor_mode;
      16'b0010000000000000: n130 = r10_cursor_mode;
      16'b0001000000000000: n130 = r10_cursor_mode;
      16'b0000100000000000: n130 = r10_cursor_mode;
      16'b0000010000000000: n130 = n101;
      16'b0000001000000000: n130 = r10_cursor_mode;
      16'b0000000100000000: n130 = r10_cursor_mode;
      16'b0000000010000000: n130 = r10_cursor_mode;
      16'b0000000001000000: n130 = r10_cursor_mode;
      16'b0000000000100000: n130 = r10_cursor_mode;
      16'b0000000000010000: n130 = r10_cursor_mode;
      16'b0000000000001000: n130 = r10_cursor_mode;
      16'b0000000000000100: n130 = r10_cursor_mode;
      16'b0000000000000010: n130 = r10_cursor_mode;
      16'b0000000000000001: n130 = r10_cursor_mode;
      default: n130 = r10_cursor_mode;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n131 = r10_cursor_start;
      16'b0100000000000000: n131 = r10_cursor_start;
      16'b0010000000000000: n131 = r10_cursor_start;
      16'b0001000000000000: n131 = r10_cursor_start;
      16'b0000100000000000: n131 = r10_cursor_start;
      16'b0000010000000000: n131 = n102;
      16'b0000001000000000: n131 = r10_cursor_start;
      16'b0000000100000000: n131 = r10_cursor_start;
      16'b0000000010000000: n131 = r10_cursor_start;
      16'b0000000001000000: n131 = r10_cursor_start;
      16'b0000000000100000: n131 = r10_cursor_start;
      16'b0000000000010000: n131 = r10_cursor_start;
      16'b0000000000001000: n131 = r10_cursor_start;
      16'b0000000000000100: n131 = r10_cursor_start;
      16'b0000000000000010: n131 = r10_cursor_start;
      16'b0000000000000001: n131 = r10_cursor_start;
      default: n131 = r10_cursor_start;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n132 = r11_cursor_end;
      16'b0100000000000000: n132 = r11_cursor_end;
      16'b0010000000000000: n132 = r11_cursor_end;
      16'b0001000000000000: n132 = r11_cursor_end;
      16'b0000100000000000: n132 = n105;
      16'b0000010000000000: n132 = r11_cursor_end;
      16'b0000001000000000: n132 = r11_cursor_end;
      16'b0000000100000000: n132 = r11_cursor_end;
      16'b0000000010000000: n132 = r11_cursor_end;
      16'b0000000001000000: n132 = r11_cursor_end;
      16'b0000000000100000: n132 = r11_cursor_end;
      16'b0000000000010000: n132 = r11_cursor_end;
      16'b0000000000001000: n132 = r11_cursor_end;
      16'b0000000000000100: n132 = r11_cursor_end;
      16'b0000000000000010: n132 = r11_cursor_end;
      16'b0000000000000001: n132 = r11_cursor_end;
      default: n132 = r11_cursor_end;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n133 = r12_start_addr_h;
      16'b0100000000000000: n133 = r12_start_addr_h;
      16'b0010000000000000: n133 = r12_start_addr_h;
      16'b0001000000000000: n133 = n108;
      16'b0000100000000000: n133 = r12_start_addr_h;
      16'b0000010000000000: n133 = r12_start_addr_h;
      16'b0000001000000000: n133 = r12_start_addr_h;
      16'b0000000100000000: n133 = r12_start_addr_h;
      16'b0000000010000000: n133 = r12_start_addr_h;
      16'b0000000001000000: n133 = r12_start_addr_h;
      16'b0000000000100000: n133 = r12_start_addr_h;
      16'b0000000000010000: n133 = r12_start_addr_h;
      16'b0000000000001000: n133 = r12_start_addr_h;
      16'b0000000000000100: n133 = r12_start_addr_h;
      16'b0000000000000010: n133 = r12_start_addr_h;
      16'b0000000000000001: n133 = r12_start_addr_h;
      default: n133 = r12_start_addr_h;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n134 = r13_start_addr_l;
      16'b0100000000000000: n134 = r13_start_addr_l;
      16'b0010000000000000: n134 = DI;
      16'b0001000000000000: n134 = r13_start_addr_l;
      16'b0000100000000000: n134 = r13_start_addr_l;
      16'b0000010000000000: n134 = r13_start_addr_l;
      16'b0000001000000000: n134 = r13_start_addr_l;
      16'b0000000100000000: n134 = r13_start_addr_l;
      16'b0000000010000000: n134 = r13_start_addr_l;
      16'b0000000001000000: n134 = r13_start_addr_l;
      16'b0000000000100000: n134 = r13_start_addr_l;
      16'b0000000000010000: n134 = r13_start_addr_l;
      16'b0000000000001000: n134 = r13_start_addr_l;
      16'b0000000000000100: n134 = r13_start_addr_l;
      16'b0000000000000010: n134 = r13_start_addr_l;
      16'b0000000000000001: n134 = r13_start_addr_l;
      default: n134 = r13_start_addr_l;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n135 = r14_cursor_h;
      16'b0100000000000000: n135 = n113;
      16'b0010000000000000: n135 = r14_cursor_h;
      16'b0001000000000000: n135 = r14_cursor_h;
      16'b0000100000000000: n135 = r14_cursor_h;
      16'b0000010000000000: n135 = r14_cursor_h;
      16'b0000001000000000: n135 = r14_cursor_h;
      16'b0000000100000000: n135 = r14_cursor_h;
      16'b0000000010000000: n135 = r14_cursor_h;
      16'b0000000001000000: n135 = r14_cursor_h;
      16'b0000000000100000: n135 = r14_cursor_h;
      16'b0000000000010000: n135 = r14_cursor_h;
      16'b0000000000001000: n135 = r14_cursor_h;
      16'b0000000000000100: n135 = r14_cursor_h;
      16'b0000000000000010: n135 = r14_cursor_h;
      16'b0000000000000001: n135 = r14_cursor_h;
      default: n135 = r14_cursor_h;
    endcase
  /*# mc6845.vhd:246:25 */
  always @*
    case (n118)
      16'b1000000000000000: n136 = DI;
      16'b0100000000000000: n136 = r15_cursor_l;
      16'b0010000000000000: n136 = r15_cursor_l;
      16'b0001000000000000: n136 = r15_cursor_l;
      16'b0000100000000000: n136 = r15_cursor_l;
      16'b0000010000000000: n136 = r15_cursor_l;
      16'b0000001000000000: n136 = r15_cursor_l;
      16'b0000000100000000: n136 = r15_cursor_l;
      16'b0000000010000000: n136 = r15_cursor_l;
      16'b0000000001000000: n136 = r15_cursor_l;
      16'b0000000000100000: n136 = r15_cursor_l;
      16'b0000000000010000: n136 = r15_cursor_l;
      16'b0000000000001000: n136 = r15_cursor_l;
      16'b0000000000000100: n136 = r15_cursor_l;
      16'b0000000000000010: n136 = r15_cursor_l;
      16'b0000000000000001: n136 = r15_cursor_l;
      default: n136 = r15_cursor_l;
    endcase
  /*# mc6845.vhd:241:17 */
  assign n137 = n156 ? n73 : addr_reg;
  /*# mc6845.vhd:243:21 */
  assign n138 = n72 ? r00_h_total : n119;
  /*# mc6845.vhd:243:21 */
  assign n139 = n72 ? r01_h_displayed : n120;
  /*# mc6845.vhd:243:21 */
  assign n140 = n72 ? r02_h_sync_pos : n121;
  /*# mc6845.vhd:243:21 */
  assign n141 = n72 ? r03_v_sync_width : n122;
  /*# mc6845.vhd:243:21 */
  assign n142 = n72 ? r03_h_sync_width : n123;
  /*# mc6845.vhd:243:21 */
  assign n143 = n72 ? r04_v_total : n124;
  /*# mc6845.vhd:243:21 */
  assign n144 = n72 ? r05_v_total_adj : n125;
  /*# mc6845.vhd:243:21 */
  assign n145 = n72 ? r06_v_displayed : n126;
  /*# mc6845.vhd:243:21 */
  assign n146 = n72 ? r07_v_sync_pos : n127;
  /*# mc6845.vhd:243:21 */
  assign n147 = n72 ? r08_interlace : n128;
  /*# mc6845.vhd:243:21 */
  assign n148 = n72 ? r09_max_scanline_addr : n129;
  /*# mc6845.vhd:243:21 */
  assign n149 = n72 ? r10_cursor_mode : n130;
  /*# mc6845.vhd:243:21 */
  assign n150 = n72 ? r10_cursor_start : n131;
  /*# mc6845.vhd:243:21 */
  assign n151 = n72 ? r11_cursor_end : n132;
  /*# mc6845.vhd:243:21 */
  assign n152 = n72 ? r12_start_addr_h : n133;
  /*# mc6845.vhd:243:21 */
  assign n153 = n72 ? r13_start_addr_l : n134;
  /*# mc6845.vhd:243:21 */
  assign n154 = n72 ? r14_cursor_h : n135;
  /*# mc6845.vhd:243:21 */
  assign n155 = n72 ? r15_cursor_l : n136;
  /*# mc6845.vhd:241:17 */
  assign n156 = n72 & CLKEN_CPU;
  /*# mc6845.vhd:241:17 */
  assign n157 = CLKEN_CPU ? n138 : r00_h_total;
  /*# mc6845.vhd:241:17 */
  assign n158 = CLKEN_CPU ? n139 : r01_h_displayed;
  /*# mc6845.vhd:241:17 */
  assign n159 = CLKEN_CPU ? n140 : r02_h_sync_pos;
  /*# mc6845.vhd:241:17 */
  assign n160 = CLKEN_CPU ? n141 : r03_v_sync_width;
  /*# mc6845.vhd:241:17 */
  assign n161 = CLKEN_CPU ? n142 : r03_h_sync_width;
  /*# mc6845.vhd:241:17 */
  assign n162 = CLKEN_CPU ? n143 : r04_v_total;
  /*# mc6845.vhd:241:17 */
  assign n163 = CLKEN_CPU ? n144 : r05_v_total_adj;
  /*# mc6845.vhd:241:17 */
  assign n164 = CLKEN_CPU ? n145 : r06_v_displayed;
  /*# mc6845.vhd:241:17 */
  assign n165 = CLKEN_CPU ? n146 : r07_v_sync_pos;
  /*# mc6845.vhd:241:17 */
  assign n166 = CLKEN_CPU ? n147 : r08_interlace;
  /*# mc6845.vhd:241:17 */
  assign n167 = CLKEN_CPU ? n148 : r09_max_scanline_addr;
  /*# mc6845.vhd:241:17 */
  assign n168 = CLKEN_CPU ? n149 : r10_cursor_mode;
  /*# mc6845.vhd:241:17 */
  assign n169 = CLKEN_CPU ? n150 : r10_cursor_start;
  /*# mc6845.vhd:241:17 */
  assign n170 = CLKEN_CPU ? n151 : r11_cursor_end;
  /*# mc6845.vhd:241:17 */
  assign n171 = CLKEN_CPU ? n152 : r12_start_addr_h;
  /*# mc6845.vhd:241:17 */
  assign n172 = CLKEN_CPU ? n153 : r13_start_addr_l;
  /*# mc6845.vhd:241:17 */
  assign n173 = CLKEN_CPU ? n154 : r14_cursor_h;
  /*# mc6845.vhd:241:17 */
  assign n174 = CLKEN_CPU ? n155 : r15_cursor_l;
  /*# mc6845.vhd:223:17 */
  assign n176 = R_nW ? addr_reg : n137;
  /*# mc6845.vhd:223:17 */
  assign n177 = R_nW ? r00_h_total : n157;
  /*# mc6845.vhd:223:17 */
  assign n178 = R_nW ? r01_h_displayed : n158;
  /*# mc6845.vhd:223:17 */
  assign n179 = R_nW ? r02_h_sync_pos : n159;
  /*# mc6845.vhd:223:17 */
  assign n180 = R_nW ? r03_v_sync_width : n160;
  /*# mc6845.vhd:223:17 */
  assign n181 = R_nW ? r03_h_sync_width : n161;
  /*# mc6845.vhd:223:17 */
  assign n182 = R_nW ? r04_v_total : n162;
  /*# mc6845.vhd:223:17 */
  assign n183 = R_nW ? r05_v_total_adj : n163;
  /*# mc6845.vhd:223:17 */
  assign n184 = R_nW ? r06_v_displayed : n164;
  /*# mc6845.vhd:223:17 */
  assign n185 = R_nW ? r07_v_sync_pos : n165;
  /*# mc6845.vhd:223:17 */
  assign n186 = R_nW ? r08_interlace : n166;
  /*# mc6845.vhd:223:17 */
  assign n187 = R_nW ? r09_max_scanline_addr : n167;
  /*# mc6845.vhd:223:17 */
  assign n188 = R_nW ? r10_cursor_mode : n168;
  /*# mc6845.vhd:223:17 */
  assign n189 = R_nW ? r10_cursor_start : n169;
  /*# mc6845.vhd:223:17 */
  assign n190 = R_nW ? r11_cursor_end : n170;
  /*# mc6845.vhd:223:17 */
  assign n191 = R_nW ? r12_start_addr_h : n171;
  /*# mc6845.vhd:223:17 */
  assign n192 = R_nW ? r13_start_addr_l : n172;
  /*# mc6845.vhd:223:17 */
  assign n193 = R_nW ? r14_cursor_h : n173;
  /*# mc6845.vhd:223:17 */
  assign n194 = R_nW ? r15_cursor_l : n174;
  /*# mc6845.vhd:222:13 */
  assign n195 = R_nW & ENABLE;
  /*# mc6845.vhd:299:19 */
  assign n278 = ~nRESET;
  /*# mc6845.vhd:306:44 */
  assign n281 = h_counter + 8'b00000001;
  /*# mc6845.vhd:303:17 */
  assign n283 = r00_h_total_hit ? 8'b00000000 : n281;
  /*# mc6845.vhd:327:19 */
  assign n291 = ~nRESET;
  /*# mc6845.vhd:331:23 */
  assign n293 = ~hs;
  /*# mc6845.vhd:334:54 */
  assign n295 = h_sync_counter + 4'b0001;
  /*# mc6845.vhd:331:17 */
  assign n297 = n293 ? 4'b0000 : n295;
  /*# mc6845.vhd:348:19 */
  assign n305 = ~nRESET;
  /*# mc6845.vhd:351:31 */
  assign n307 = h_sync_counter == r03_h_sync_width;
  /*# mc6845.vhd:353:29 */
  assign n308 = h_counter == r02_h_sync_pos;
  /*# mc6845.vhd:353:13 */
  assign n310 = n308 ? 1'b1 : hs;
  /*# mc6845.vhd:351:13 */
  assign n312 = n307 ? 1'b0 : n310;
  /*# mc6845.vhd:369:19 */
  assign n319 = ~nRESET;
  /*# mc6845.vhd:372:26 */
  assign n321 = h_counter == r01_h_displayed;
  /*# mc6845.vhd:372:57 */
  assign n322 = h_counter == r00_h_total;
  /*# mc6845.vhd:372:44 */
  assign n323 = n321 | n322;
  /*# mc6845.vhd:374:29 */
  assign n325 = h_counter == 8'b00000000;
  /*# mc6845.vhd:374:13 */
  assign n327 = n325 ? 1'b1 : h_display;
  /*# mc6845.vhd:372:13 */
  assign n329 = n323 ? 1'b0 : n327;
  /*# mc6845.vhd:392:19 */
  assign n336 = ~nRESET;
  /*# mc6845.vhd:398:17 */
  assign n338 = r00_h_total_hit ? line_counter_next : line_counter;
  /*# mc6845.vhd:396:17 */
  assign n340 = new_frame ? 5'b00000 : n338;
  /*# mc6845.vhd:405:42 */
  assign n347 = max_scanline_hit ? 5'b00000 : n357;
  /*# mc6845.vhd:406:39 */
  assign n349 = line_counter + 5'b00001;
  /*# mc6845.vhd:406:90 */
  assign n350 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:406:103 */
  assign n352 = n350 == 2'b11;
  /*# mc6845.vhd:406:118 */
  assign n353 = ~VGA;
  /*# mc6845.vhd:406:110 */
  assign n354 = n353 & n352;
  /*# mc6845.vhd:406:73 */
  assign n355 = ~n354;
  /*# mc6845.vhd:406:70 */
  assign n356 = adj_in_progress | n355;
  /*# mc6845.vhd:405:70 */
  assign n357 = n356 ? n349 : n362;
  /*# mc6845.vhd:407:38 */
  assign n358 = line_counter[4:1]; // extract
  /*# mc6845.vhd:407:51 */
  assign n360 = n358 + 4'b0001;
  /*# mc6845.vhd:407:55 */
  assign n362 = {n360, 1'b0};
  /*# mc6845.vhd:413:19 */
  assign n365 = ~nRESET;
  /*# mc6845.vhd:422:41 */
  assign n373 = new_frame ? 7'b0000000 : n377;
  /*# mc6845.vhd:423:37 */
  assign n375 = row_counter + 7'b0000001;
  /*# mc6845.vhd:423:68 */
  assign n376 = max_scanline_hit & r00_h_total_hit;
  /*# mc6845.vhd:422:62 */
  assign n377 = n376 ? n375 : row_counter;
  /*# mc6845.vhd:447:36 */
  assign n379 = row_counter == r07_v_sync_pos;
  /*# mc6845.vhd:447:19 */
  assign n380 = n379 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:452:19 */
  assign n384 = ~nRESET;
  /*# mc6845.vhd:456:49 */
  assign n386 = ~vs_hit_last;
  /*# mc6845.vhd:456:33 */
  assign n387 = n386 & vs_hit;
  /*# mc6845.vhd:459:54 */
  assign n389 = v_sync_counter + 4'b0001;
  /*# mc6845.vhd:458:17 */
  assign n390 = r00_h_total_hit ? n389 : v_sync_counter;
  /*# mc6845.vhd:456:17 */
  assign n392 = n387 ? 4'b0000 : n390;
  /*# mc6845.vhd:470:19 */
  assign n403 = ~nRESET;
  /*# mc6845.vhd:473:45 */
  assign n405 = ~vs_hit_last;
  /*# mc6845.vhd:473:29 */
  assign n406 = n405 & vs_hit;
  /*# mc6845.vhd:476:34 */
  assign n407 = v_sync_counter == r03_v_sync_width;
  /*# mc6845.vhd:476:60 */
  assign n408 = sol[0]; // extract
  /*# mc6845.vhd:476:53 */
  assign n409 = n408 & n407;
  /*# mc6845.vhd:476:13 */
  assign n411 = n409 ? 1'b0 : vs_even;
  /*# mc6845.vhd:473:13 */
  assign n413 = n406 ? 1'b1 : n411;
  /*# mc6845.vhd:488:50 */
  assign n421 = r00_h_total[7:1]; // extract
  /*# mc6845.vhd:488:37 */
  assign n423 = {1'b0, n421};
  /*# mc6845.vhd:488:30 */
  assign n424 = h_counter == n423;
  /*# mc6845.vhd:487:13 */
  assign n426 = n424 & CLKEN;
  /*# mc6845.vhd:496:36 */
  assign n429 = r08_interlace[0]; // extract
  /*# mc6845.vhd:496:54 */
  assign n430 = ~VGA;
  /*# mc6845.vhd:496:46 */
  assign n431 = n430 & n429;
  /*# mc6845.vhd:496:74 */
  assign n432 = ~odd_field;
  /*# mc6845.vhd:496:60 */
  assign n433 = n432 & n431;
  /*# mc6845.vhd:496:18 */
  assign n434 = n433 ? vs_odd : vs_even;
  /*# mc6845.vhd:515:19 */
  assign n437 = ~nRESET;
  /*# mc6845.vhd:524:43 */
  assign n439 = field_counter[0]; // extract
  /*# mc6845.vhd:525:31 */
  assign n440 = row_counter == r06_v_displayed;
  /*# mc6845.vhd:525:49 */
  assign n441 = v_display & n440;
  /*# mc6845.vhd:529:48 */
  assign n443 = field_counter + 5'b00001;
  /*# mc6845.vhd:525:13 */
  assign n444 = n441 ? n443 : field_counter;
  /*# mc6845.vhd:525:13 */
  assign n446 = n441 ? 1'b0 : v_display;
  /*# mc6845.vhd:520:13 */
  assign n447 = first_scanline ? field_counter : n444;
  /*# mc6845.vhd:520:13 */
  assign n449 = first_scanline ? 1'b1 : n446;
  /*# mc6845.vhd:542:19 */
  assign n463 = ~nRESET;
  /*# mc6845.vhd:592:27 */
  assign n465 = sol[1:0]; // extract
  /*# mc6845.vhd:592:53 */
  assign n466 = {n465, r00_h_total_hit};
  /*# mc6845.vhd:597:26 */
  assign n467 = sol[0]; // extract
  /*# mc6845.vhd:597:36 */
  assign n468 = max_scanline_hit & n467;
  /*# mc6845.vhd:597:79 */
  assign n469 = row_counter == r04_v_total;
  /*# mc6845.vhd:597:63 */
  assign n470 = n469 & n468;
  /*# mc6845.vhd:597:17 */
  assign n472 = n470 ? 1'b1 : eom_latched;
  /*# mc6845.vhd:595:17 */
  assign n474 = new_frame ? 1'b0 : n472;
  /*# mc6845.vhd:604:26 */
  assign n475 = sol[1]; // extract
  /*# mc6845.vhd:604:36 */
  assign n476 = eom_latched & n475;
  /*# mc6845.vhd:605:42 */
  assign n477 = line_counter_next == adj_scanline;
  /*# mc6845.vhd:605:21 */
  assign n480 = n477 ? 1'b0 : 1'b1;
  /*# mc6845.vhd:604:17 */
  assign n481 = n476 ? n480 : in_adj;
  /*# mc6845.vhd:602:17 */
  assign n483 = new_frame ? 1'b0 : n481;
  /*# mc6845.vhd:615:26 */
  assign n484 = sol[2]; // extract
  /*# mc6845.vhd:615:36 */
  assign n485 = eom_latched & n484;
  /*# mc6845.vhd:615:69 */
  assign n486 = ~in_adj;
  /*# mc6845.vhd:615:58 */
  assign n487 = n486 & n485;
  /*# mc6845.vhd:615:17 */
  assign n489 = n487 ? 1'b1 : eof_latched;
  /*# mc6845.vhd:613:17 */
  assign n491 = new_frame ? 1'b0 : n489;
  /*# mc6845.vhd:623:45 */
  assign n492 = eom_latched & r00_h_total_hit;
  /*# mc6845.vhd:623:67 */
  assign n493 = in_adj & n492;
  /*# mc6845.vhd:623:17 */
  assign n495 = n493 ? 1'b1 : adj_in_progress;
  /*# mc6845.vhd:621:17 */
  assign n497 = new_frame ? 1'b0 : n495;
  /*# mc6845.vhd:630:17 */
  assign n499 = r00_h_total_hit ? 1'b0 : first_scanline;
  /*# mc6845.vhd:628:17 */
  assign n501 = new_frame ? 1'b1 : n499;
  /*# mc6845.vhd:635:42 */
  assign n502 = eof_latched & r00_h_total_hit;
  /*# mc6845.vhd:635:81 */
  assign n503 = r08_interlace[0]; // extract
  /*# mc6845.vhd:635:64 */
  assign n504 = n503 & n502;
  /*# mc6845.vhd:635:108 */
  assign n505 = field_counter[0]; // extract
  /*# mc6845.vhd:635:91 */
  assign n506 = n505 & n504;
  /*# mc6845.vhd:635:137 */
  assign n507 = ~extra_scanline;
  /*# mc6845.vhd:635:118 */
  assign n508 = n507 & n506;
  /*# mc6845.vhd:637:17 */
  assign n510 = r00_h_total_hit ? 1'b0 : extra_scanline;
  /*# mc6845.vhd:635:17 */
  assign n512 = n508 ? 1'b1 : n510;
  /*# mc6845.vhd:653:19 */
  assign n544 = ~nRESET;
  /*# mc6845.vhd:660:48 */
  assign n546 = {r12_start_addr_h, r13_start_addr_l};
  /*# mc6845.vhd:661:33 */
  assign n547 = h_counter == r01_h_displayed;
  /*# mc6845.vhd:661:51 */
  assign n548 = max_scanline_hit & n547;
  /*# mc6845.vhd:661:17 */
  assign n549 = n548 ? ma_i : ma_row;
  /*# mc6845.vhd:658:17 */
  assign n550 = new_frame ? n546 : n549;
  /*# mc6845.vhd:667:46 */
  assign n551 = {r12_start_addr_h, r13_start_addr_l};
  /*# mc6845.vhd:673:34 */
  assign n553 = ma_i + 14'b00000000000001;
  /*# mc6845.vhd:668:17 */
  assign n554 = r00_h_total_hit ? ma_row : n553;
  /*# mc6845.vhd:665:17 */
  assign n555 = new_frame ? n551 : n554;
  /*# mc6845.vhd:692:37 */
  assign n568 = r08_interlace[1:0]; // extract
  /*# mc6845.vhd:692:50 */
  assign n570 = n568 == 2'b11;
  /*# mc6845.vhd:692:65 */
  assign n571 = ~VGA;
  /*# mc6845.vhd:692:57 */
  assign n572 = n571 & n570;
  /*# mc6845.vhd:692:21 */
  assign n575 = n572 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:683:13 */
  assign n577 = r00_h_total_hit & CLKEN;
  /*# mc6845.vhd:702:40 */
  assign n580 = line_counter[4:1]; // extract
  /*# mc6845.vhd:702:54 */
  assign n581 = {n580, odd_field};
  /*# mc6845.vhd:702:66 */
  assign n582 = interlaced_video ? n581 : line_counter;
  /*# mc6845.vhd:716:19 */
  assign n585 = ~nRESET;
  /*# mc6845.vhd:723:49 */
  assign n587 = lpstb_sync[3:1]; // extract
  /*# mc6845.vhd:723:37 */
  assign n588 = {LPSTB, n587};
  /*# mc6845.vhd:725:30 */
  assign n589 = lpstb_sync[1]; // extract
  /*# mc6845.vhd:725:54 */
  assign n590 = lpstb_sync[0]; // extract
  /*# mc6845.vhd:725:58 */
  assign n591 = ~n590;
  /*# mc6845.vhd:725:40 */
  assign n592 = n591 & n589;
  /*# mc6845.vhd:726:44 */
  assign n593 = ma_i[13:8]; // extract
  /*# mc6845.vhd:727:44 */
  assign n594 = ma_i[7:0]; // extract
  /*# mc6845.vhd:721:13 */
  assign n597 = n592 & CLKEN;
  /*# mc6845.vhd:721:13 */
  assign n598 = n592 & CLKEN;
  /*# mc6845.vhd:739:35 */
  assign n611 = ~h_display;
  /*# mc6845.vhd:739:54 */
  assign n612 = ~v_display;
  /*# mc6845.vhd:739:41 */
  assign n613 = n611 | n612;
  /*# mc6845.vhd:739:84 */
  assign n614 = {r14_cursor_h, r15_cursor_l};
  /*# mc6845.vhd:739:68 */
  assign n615 = ma_i != n614;
  /*# mc6845.vhd:739:60 */
  assign n616 = n613 | n615;
  /*# mc6845.vhd:739:115 */
  assign n617 = $unsigned(line_counter) < $unsigned(r10_cursor_start);
  /*# mc6845.vhd:739:99 */
  assign n618 = n616 | n617;
  /*# mc6845.vhd:739:150 */
  assign n619 = $unsigned(line_counter) > $unsigned(r11_cursor_end);
  /*# mc6845.vhd:739:134 */
  assign n620 = n618 | n619;
  /*# mc6845.vhd:739:20 */
  assign n621 = n620 ? 1'b0 : n625;
  /*# mc6845.vhd:740:29 */
  assign n622 = field_counter[4]; // extract
  /*# mc6845.vhd:740:54 */
  assign n624 = r10_cursor_mode == 2'b11;
  /*# mc6845.vhd:739:167 */
  assign n625 = n624 ? n622 : n629;
  /*# mc6845.vhd:741:29 */
  assign n626 = field_counter[3]; // extract
  /*# mc6845.vhd:741:54 */
  assign n628 = r10_cursor_mode == 2'b10;
  /*# mc6845.vhd:740:61 */
  assign n629 = n628 ? n626 : n633;
  /*# mc6845.vhd:742:54 */
  assign n632 = r10_cursor_mode == 2'b00;
  /*# mc6845.vhd:741:61 */
  assign n633 = n632 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:763:37 */
  assign n648 = v_display & h_display;
  /*# mc6845.vhd:763:74 */
  assign n649 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:763:87 */
  assign n651 = n649 != 2'b11;
  /*# mc6845.vhd:763:57 */
  assign n652 = n651 & n648;
  /*# mc6845.vhd:763:16 */
  assign n653 = n652 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:765:33 */
  assign n655 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:765:46 */
  assign n657 = n655 == 2'b01;
  /*# mc6845.vhd:765:15 */
  assign n658 = n657 ? de1 : n662;
  /*# mc6845.vhd:766:33 */
  assign n659 = r08_interlace[5:4]; // extract
  /*# mc6845.vhd:766:46 */
  assign n661 = n659 == 2'b10;
  /*# mc6845.vhd:765:53 */
  assign n662 = n661 ? de2 : de0;
  /*# mc6845.vhd:770:41 */
  assign n663 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:770:54 */
  assign n665 = n663 == 2'b00;
  /*# mc6845.vhd:770:23 */
  assign n666 = n665 ? cursor0 : n670;
  /*# mc6845.vhd:771:41 */
  assign n667 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:771:54 */
  assign n669 = n667 == 2'b01;
  /*# mc6845.vhd:770:61 */
  assign n670 = n669 ? cursor1 : n674;
  /*# mc6845.vhd:772:41 */
  assign n671 = r08_interlace[7:6]; // extract
  /*# mc6845.vhd:772:54 */
  assign n673 = n671 == 2'b10;
  /*# mc6845.vhd:771:61 */
  assign n674 = n673 ? cursor2 : 1'b0;
  /*# mc6845.vhd:781:41 */
  assign n677 = ENABLE & CLKEN_CPU;
  /*# mc6845.vhd:781:67 */
  assign n678 = ~R_nW;
  /*# mc6845.vhd:781:58 */
  assign n679 = n678 & n677;
  /*# mc6845.vhd:781:20 */
  assign n680 = n679 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:782:67 */
  assign n683 = ~R_nW;
  /*# mc6845.vhd:782:58 */
  assign n684 = n683 & ENABLE;
  /*# mc6845.vhd:782:20 */
  assign n685 = n684 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:783:41 */
  assign n688 = ENABLE & CLKEN_CPU;
  /*# mc6845.vhd:783:67 */
  assign n689 = ~R_nW;
  /*# mc6845.vhd:783:58 */
  assign n690 = n689 & n688;
  /*# mc6845.vhd:783:86 */
  assign n692 = addr_reg == 5'b00000;
  /*# mc6845.vhd:783:73 */
  assign n693 = n692 & n690;
  /*# mc6845.vhd:783:20 */
  assign n694 = n693 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:784:67 */
  assign n697 = ~R_nW;
  /*# mc6845.vhd:784:58 */
  assign n698 = n697 & ENABLE;
  /*# mc6845.vhd:784:86 */
  assign n700 = addr_reg == 5'b00000;
  /*# mc6845.vhd:784:73 */
  assign n701 = n700 & n698;
  /*# mc6845.vhd:784:20 */
  assign n702 = n701 ? 1'b1 : 1'b0;
  /*# mc6845.vhd:73:5 */
  assign n705 = {n702, n694, n685, n680};
  /*# mc6845.vhd:221:9 */
  assign n706 = n195 ? n71 : n707;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n707 <= 8'b00000000;
    else
      n707 <= n706;
  /*# mc6845.vhd:221:9 */
  assign n708 = ENABLE ? n176 : addr_reg;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n709 <= 5'b00000;
    else
      n709 <= n708;
  /*# mc6845.vhd:221:9 */
  assign n710 = ENABLE ? n177 : r00_h_total;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n711 <= 8'b00000000;
    else
      n711 <= n710;
  /*# mc6845.vhd:221:9 */
  assign n712 = ENABLE ? n178 : r01_h_displayed;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n713 <= 8'b00000000;
    else
      n713 <= n712;
  /*# mc6845.vhd:221:9 */
  assign n714 = ENABLE ? n179 : r02_h_sync_pos;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n715 <= 8'b00000000;
    else
      n715 <= n714;
  /*# mc6845.vhd:221:9 */
  assign n716 = ENABLE ? n180 : r03_v_sync_width;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n717 <= 4'b0000;
    else
      n717 <= n716;
  /*# mc6845.vhd:221:9 */
  assign n718 = ENABLE ? n181 : r03_h_sync_width;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n719 <= 4'b0000;
    else
      n719 <= n718;
  /*# mc6845.vhd:221:9 */
  assign n720 = ENABLE ? n182 : r04_v_total;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n721 <= 7'b0000000;
    else
      n721 <= n720;
  /*# mc6845.vhd:221:9 */
  assign n722 = ENABLE ? n183 : r05_v_total_adj;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n723 <= 5'b00000;
    else
      n723 <= n722;
  /*# mc6845.vhd:221:9 */
  assign n724 = ENABLE ? n184 : r06_v_displayed;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n725 <= 7'b0000000;
    else
      n725 <= n724;
  /*# mc6845.vhd:221:9 */
  assign n726 = ENABLE ? n185 : r07_v_sync_pos;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n727 <= 7'b0000000;
    else
      n727 <= n726;
  /*# mc6845.vhd:221:9 */
  assign n728 = ENABLE ? n186 : r08_interlace;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n729 <= 8'b00000000;
    else
      n729 <= n728;
  /*# mc6845.vhd:221:9 */
  assign n730 = ENABLE ? n187 : r09_max_scanline_addr;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n731 <= 5'b00000;
    else
      n731 <= n730;
  /*# mc6845.vhd:221:9 */
  assign n732 = ENABLE ? n188 : r10_cursor_mode;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n733 <= 2'b00;
    else
      n733 <= n732;
  /*# mc6845.vhd:221:9 */
  assign n734 = ENABLE ? n189 : r10_cursor_start;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n735 <= 5'b00000;
    else
      n735 <= n734;
  /*# mc6845.vhd:221:9 */
  assign n736 = ENABLE ? n190 : r11_cursor_end;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n737 <= 5'b00000;
    else
      n737 <= n736;
  /*# mc6845.vhd:221:9 */
  assign n738 = ENABLE ? n191 : r12_start_addr_h;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n739 <= 6'b000000;
    else
      n739 <= n738;
  /*# mc6845.vhd:221:9 */
  assign n740 = ENABLE ? n192 : r13_start_addr_l;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n741 <= 8'b00000000;
    else
      n741 <= n740;
  /*# mc6845.vhd:221:9 */
  assign n742 = ENABLE ? n193 : r14_cursor_h;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n743 <= 6'b000000;
    else
      n743 <= n742;
  /*# mc6845.vhd:221:9 */
  assign n744 = ENABLE ? n194 : r15_cursor_l;
  /*# mc6845.vhd:221:9 */
  always @(posedge CLOCK or posedge n49)
    if (n49)
      n745 <= 8'b00000000;
    else
      n745 <= n744;
  /*# mc6845.vhd:720:9 */
  assign n746 = n597 ? n593 : r16_light_pen_h;
  /*# mc6845.vhd:720:9 */
  always @(posedge CLOCK or posedge n585)
    if (n585)
      n747 <= 6'b000000;
    else
      n747 <= n746;
  /*# mc6845.vhd:720:9 */
  assign n748 = n598 ? n594 : r17_light_pen_l;
  /*# mc6845.vhd:720:9 */
  always @(posedge CLOCK or posedge n585)
    if (n585)
      n749 <= 8'b00000000;
    else
      n749 <= n748;
  /*# mc6845.vhd:301:9 */
  assign n750 = CLKEN ? n283 : h_counter;
  /*# mc6845.vhd:301:9 */
  always @(posedge CLOCK or posedge n278)
    if (n278)
      n751 <= 8'b00000000;
    else
      n751 <= n750;
  /*# mc6845.vhd:329:9 */
  assign n752 = CLKEN ? n297 : h_sync_counter;
  /*# mc6845.vhd:329:9 */
  always @(posedge CLOCK or posedge n291)
    if (n291)
      n753 <= 4'b0000;
    else
      n753 <= n752;
  /*# mc6845.vhd:415:9 */
  assign n754 = CLKEN ? row_counter_next : row_counter;
  /*# mc6845.vhd:415:9 */
  always @(posedge CLOCK or posedge n365)
    if (n365)
      n755 <= 7'b0000000;
    else
      n755 <= n754;
  /*# mc6845.vhd:394:9 */
  assign n756 = CLKEN ? n340 : line_counter;
  /*# mc6845.vhd:394:9 */
  always @(posedge CLOCK or posedge n336)
    if (n336)
      n757 <= 5'b00000;
    else
      n757 <= n756;
  /*# mc6845.vhd:454:9 */
  assign n758 = CLKEN ? n392 : v_sync_counter;
  /*# mc6845.vhd:454:9 */
  always @(posedge CLOCK or posedge n384)
    if (n384)
      n759 <= 4'b0000;
    else
      n759 <= n758;
  /*# mc6845.vhd:519:9 */
  always @(posedge CLOCK or posedge n437)
    if (n437)
      n760 <= 5'b00000;
    else
      n760 <= n447;
  /*# mc6845.vhd:371:9 */
  always @(posedge CLOCK or posedge n319)
    if (n319)
      n761 <= 1'b0;
    else
      n761 <= n329;
  /*# mc6845.vhd:350:9 */
  always @(posedge CLOCK or posedge n305)
    if (n305)
      n762 <= 1'b0;
    else
      n762 <= n312;
  /*# mc6845.vhd:519:9 */
  always @(posedge CLOCK or posedge n437)
    if (n437)
      n763 <= 1'b0;
    else
      n763 <= n449;
  /*# mc6845.vhd:128:8 */
  assign n764 = ~n384;
  /*# mc6845.vhd:128:8 */
  assign n765 = CLKEN & n764;
  /*# mc6845.vhd:454:9 */
  assign n766 = n765 ? vs_hit : vs_hit_last;
  /*# mc6845.vhd:454:9 */
  always @(posedge CLOCK)
    n767 <= n766;
  /*# mc6845.vhd:472:9 */
  always @(posedge CLOCK or posedge n403)
    if (n403)
      n768 <= 1'b0;
    else
      n768 <= n413;
  /*# mc6845.vhd:486:9 */
  assign n769 = n426 ? vs_even : vs_odd;
  /*# mc6845.vhd:486:9 */
  always @(posedge CLOCK)
    n770 <= n769;
  /*# mc6845.vhd:519:9 */
  assign n771 = first_scanline ? n439 : odd_field;
  /*# mc6845.vhd:519:9 */
  always @(posedge CLOCK or posedge n437)
    if (n437)
      n772 <= 1'b0;
    else
      n772 <= n771;
  /*# mc6845.vhd:656:9 */
  assign n773 = CLKEN ? n555 : ma_i;
  /*# mc6845.vhd:656:9 */
  always @(posedge CLOCK or posedge n544)
    if (n544)
      n774 <= 14'b00000000000000;
    else
      n774 <= n773;
  /*# mc6845.vhd:720:9 */
  assign n775 = CLKEN ? n588 : lpstb_sync;
  /*# mc6845.vhd:720:9 */
  always @(posedge CLOCK or posedge n585)
    if (n585)
      n776 <= 4'b0000;
    else
      n776 <= n775;
  /*# mc6845.vhd:753:9 */
  assign n777 = CLKEN ? de0 : de1;
  /*# mc6845.vhd:753:9 */
  always @(posedge CLOCK)
    n778 <= n777;
  /*# mc6845.vhd:753:9 */
  assign n779 = CLKEN ? de1 : de2;
  /*# mc6845.vhd:753:9 */
  always @(posedge CLOCK)
    n780 <= n779;
  /*# mc6845.vhd:753:9 */
  assign n781 = CLKEN ? cursor0 : cursor1;
  /*# mc6845.vhd:753:9 */
  always @(posedge CLOCK)
    n782 <= n781;
  /*# mc6845.vhd:753:9 */
  assign n783 = CLKEN ? cursor1 : cursor2;
  /*# mc6845.vhd:753:9 */
  always @(posedge CLOCK)
    n784 <= n783;
  /*# mc6845.vhd:682:9 */
  assign n785 = n577 ? n575 : interlaced_video;
  /*# mc6845.vhd:682:9 */
  always @(posedge CLOCK)
    n786 <= n785;
  /*# mc6845.vhd:656:9 */
  assign n787 = CLKEN ? n550 : ma_row;
  /*# mc6845.vhd:656:9 */
  always @(posedge CLOCK or posedge n544)
    if (n544)
      n788 <= 14'b00000000000000;
    else
      n788 <= n787;
  /*# mc6845.vhd:550:9 */
  assign n789 = CLKEN ? n483 : in_adj;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n790 <= 1'b0;
    else
      n790 <= n789;
  /*# mc6845.vhd:550:9 */
  assign n791 = CLKEN ? n497 : adj_in_progress;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n792 <= 1'b0;
    else
      n792 <= n791;
  /*# mc6845.vhd:550:9 */
  assign n793 = CLKEN ? n466 : sol;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n794 <= 3'b000;
    else
      n794 <= n793;
  /*# mc6845.vhd:550:9 */
  assign n795 = CLKEN ? n474 : eom_latched;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n796 <= 1'b0;
    else
      n796 <= n795;
  /*# mc6845.vhd:550:9 */
  assign n797 = CLKEN ? n491 : eof_latched;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n798 <= 1'b0;
    else
      n798 <= n797;
  /*# mc6845.vhd:550:9 */
  assign n799 = CLKEN ? n501 : first_scanline;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n800 <= 1'b0;
    else
      n800 <= n799;
  /*# mc6845.vhd:550:9 */
  assign n801 = CLKEN ? n512 : extra_scanline;
  /*# mc6845.vhd:550:9 */
  always @(posedge CLOCK or posedge n463)
    if (n463)
      n802 <= 1'b0;
    else
      n802 <= n801;
endmodule


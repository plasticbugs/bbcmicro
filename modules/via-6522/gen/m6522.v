module M6522
  (input  [3:0] I_RS,
   input  [7:0] I_DATA,
   output [7:0] O_DATA,
   output O_DATA_OE_L,
   input  I_RW_L,
   input  I_CS1,
   input  I_CS2_L,
   output O_IRQ_L,
   input  I_CA1,
   input  I_CA2,
   output O_CA2,
   output O_CA2_OE_L,
   input  [7:0] I_PA,
   output [7:0] O_PA,
   output [7:0] O_PA_OE_L,
   input  I_CB1,
   output O_CB1,
   output O_CB1_OE_L,
   input  I_CB2,
   output O_CB2,
   output O_CB2_OE_L,
   input  [7:0] I_PB,
   output [7:0] O_PB,
   output [7:0] O_PB_OE_L,
   input  I_P2_H,
   input  RESET_L,
   input  ENA_4,
   input  CLK);
  reg [1:0] phase;
  wire p2_h_t1;
  wire cs;
  wire [7:0] r_ddra;
  wire [7:0] r_ora;
  wire [7:0] r_ira;
  wire [7:0] r_ddrb;
  wire [7:0] r_orb;
  wire [7:0] r_irb;
  wire [7:0] r_t1l_l;
  wire [7:0] r_t1l_h;
  wire [7:0] r_t2l_l;
  wire [7:0] r_t2l_h;
  wire [7:0] r_sr;
  wire [7:0] r_acr;
  wire [7:0] r_pcr;
  wire [7:0] r_ifr;
  wire [6:0] r_ier;
  wire sr_write_ena;
  wire sr_read_ena;
  wire ifr_write_ena;
  wire ier_write_ena;
  wire [7:0] clear_irq;
  wire [7:0] load_data;
  reg [15:0] t1c;
  wire t1c_active;
  wire t1c_done;
  wire t1_w_reset_int;
  wire t1_r_reset_int;
  wire t1_load_counter;
  wire t1_reload_counter;
  reg t1_int_enable;
  wire t1_toggle;
  reg t1_irq;
  reg t1_pb7;
  wire t1_pb7_en_c;
  wire t1_pb7_en_d;
  reg [15:0] t2c;
  wire t2c_active;
  wire t2c_done;
  wire t2_pb6;
  wire t2_pb6_t1;
  reg t2_cnt_clk;
  wire t2_w_reset_int;
  wire t2_r_reset_int;
  wire t2_load_counter;
  wire t2_reload_counter;
  reg t2_int_enable;
  reg t2_irq;
  wire t2_sr_ena;
  wire [3:0] sr_cnt;
  wire sr_cb1_oe_l;
  wire sr_cb1_out;
  wire sr_drive_cb2;
  wire sr_strobe;
  reg sr_do_shift;
  wire sr_strobe_t1;
  wire sr_strobe_falling;
  wire sr_strobe_rising;
  wire sr_irq;
  wire sr_out;
  wire sr_active;
  wire w_orb_hs;
  wire w_ora_hs;
  wire r_irb_hs;
  wire r_ira_hs;
  wire ca_hs_sr;
  wire ca_hs_pulse;
  wire cb_hs_sr;
  wire cb_hs_pulse;
  wire cb1_in_mux;
  wire ca1_ip_reg_c;
  wire cb1_ip_reg_c;
  wire cb1_ip_reg_d;
  wire ca1_int;
  wire cb1_int;
  wire ca1_irq;
  wire cb1_irq;
  wire ca2_ip_reg_c;
  wire ca2_ip_reg_d;
  wire cb2_ip_reg_c;
  wire cb2_ip_reg_d;
  wire ca2_int;
  wire cb2_int;
  wire ca2_irq;
  wire cb2_irq;
  wire final_irq;
  wire n25;
  wire n26;
  wire [1:0] n28;
  wire [1:0] n30;
  wire n37;
  wire n38;
  wire n39;
  wire n42;
  wire n46;
  wire n48;
  wire n49;
  wire n51;
  wire n53;
  wire n55;
  wire n57;
  wire n59;
  wire n61;
  wire n63;
  wire [6:0] n64;
  reg [7:0] n65;
  reg [7:0] n66;
  reg [7:0] n67;
  reg [7:0] n68;
  reg [7:0] n69;
  reg [7:0] n70;
  reg n73;
  reg n76;
  wire n84;
  wire n87;
  wire n89;
  wire n90;
  wire n92;
  wire n93;
  wire n94;
  wire n96;
  wire n97;
  wire n98;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n134;
  wire n136;
  wire n137;
  wire n139;
  wire n141;
  wire n143;
  wire n145;
  wire n147;
  wire n149;
  wire n151;
  wire n153;
  wire n155;
  wire [8:0] n156;
  reg [7:0] n157;
  reg [7:0] n158;
  reg [7:0] n159;
  reg [7:0] n160;
  reg n163;
  reg n166;
  reg n169;
  reg n173;
  reg n176;
  reg n179;
  reg n182;
  wire n188;
  wire n191;
  wire n194;
  wire [7:0] n197;
  wire n200;
  wire n203;
  wire n206;
  wire n209;
  wire n211;
  wire n212;
  wire n213;
  wire n214;
  wire n253;
  wire n256;
  wire [7:0] n261;
  wire [7:0] n262;
  wire [7:0] n263;
  wire [7:0] n264;
  wire n265;
  wire n266;
  wire [6:0] n267;
  wire n268;
  wire [7:0] n269;
  wire n271;
  wire [7:0] n272;
  wire [7:0] n273;
  wire [7:0] n274;
  wire [7:0] n275;
  wire n277;
  wire n279;
  wire n281;
  wire [7:0] n282;
  wire n284;
  wire [7:0] n285;
  wire n287;
  wire n289;
  wire n291;
  wire [7:0] n292;
  wire n294;
  wire [7:0] n295;
  wire n297;
  wire n299;
  wire n301;
  wire n303;
  wire n305;
  wire [7:0] n307;
  wire n309;
  wire n311;
  wire [15:0] n312;
  reg [7:0] n314;
  reg n317;
  reg n320;
  reg n323;
  reg n326;
  reg n329;
  wire [7:0] n331;
  wire n334;
  wire n337;
  wire n340;
  wire n343;
  wire n346;
  wire n352;
  wire n355;
  wire n356;
  wire n357;
  wire n358;
  wire n359;
  wire n360;
  wire n361;
  wire n362;
  wire n363;
  wire n364;
  wire n365;
  wire n366;
  wire n367;
  wire n368;
  wire n371;
  wire n372;
  wire n373;
  wire n374;
  wire n375;
  wire n376;
  wire n377;
  wire n378;
  wire n379;
  wire n381;
  wire n383;
  wire n384;
  wire n385;
  wire n386;
  wire n387;
  wire n388;
  wire n389;
  wire n390;
  wire n391;
  wire n393;
  wire n397;
  wire n400;
  wire n401;
  wire n402;
  wire n404;
  wire n406;
  wire n408;
  wire n409;
  wire n411;
  wire n412;
  wire [2:0] n413;
  wire n415;
  wire n417;
  wire n419;
  wire n421;
  wire n422;
  wire n424;
  wire n425;
  wire n427;
  wire n429;
  wire n431;
  wire [7:0] n432;
  reg n435;
  wire n437;
  wire n438;
  wire n440;
  wire n442;
  wire n444;
  wire n446;
  wire n447;
  wire n448;
  wire [2:0] n449;
  wire n451;
  wire n453;
  wire n455;
  wire n457;
  wire n458;
  wire n460;
  wire n461;
  wire n463;
  wire n465;
  wire n467;
  wire [7:0] n468;
  reg n471;
  wire n472;
  wire n478;
  wire n480;
  wire n507;
  wire n509;
  wire n510;
  wire n511;
  wire n513;
  wire n515;
  wire n516;
  wire n517;
  wire n518;
  wire n519;
  wire n520;
  wire n521;
  wire n523;
  wire n525;
  wire n526;
  wire n527;
  wire n528;
  wire n530;
  wire n532;
  wire n533;
  wire n534;
  wire n535;
  wire n536;
  wire n537;
  wire n538;
  wire n540;
  wire n542;
  wire n561;
  wire n563;
  wire n564;
  wire [7:0] n565;
  wire [7:0] n566;
  wire n567;
  wire n568;
  wire [7:0] n569;
  wire [7:0] n570;
  wire [7:0] n613;
  wire [6:0] n614;
  wire [7:0] n615;
  wire [7:0] n616;
  wire [7:0] n617;
  wire n621;
  wire n631;
  wire n633;
  wire n634;
  wire n636;
  wire n637;
  wire n638;
  wire n640;
  wire n641;
  wire n643;
  wire n654;
  wire n655;
  wire n656;
  wire n658;
  wire n660;
  wire [15:0] n662;
  wire [15:0] n663;
  wire [15:0] n664;
  wire [15:0] n665;
  wire n666;
  wire n667;
  wire n669;
  wire n671;
  wire n672;
  wire n673;
  wire n674;
  wire n676;
  wire n677;
  wire n680;
  wire n682;
  wire n683;
  wire n684;
  wire n685;
  wire n687;
  wire n688;
  wire n690;
  wire n692;
  wire n694;
  wire n709;
  wire n710;
  wire n713;
  wire n714;
  wire n720;
  wire n721;
  wire n722;
  wire n723;
  wire n726;
  wire n728;
  wire n736;
  wire [7:0] n737;
  wire n739;
  wire n741;
  wire n742;
  wire n744;
  wire n747;
  wire n749;
  wire n760;
  wire n761;
  wire n763;
  wire n765;
  wire n766;
  wire [2:0] n767;
  wire n769;
  wire [2:0] n770;
  wire n772;
  wire n773;
  wire [2:0] n774;
  wire n776;
  wire n777;
  wire n778;
  wire n780;
  wire n781;
  wire [15:0] n783;
  wire [15:0] n784;
  wire [15:0] n785;
  wire [15:0] n786;
  wire n788;
  wire [7:0] n789;
  wire [7:0] n790;
  wire [7:0] n791;
  wire [7:0] n792;
  wire [7:0] n793;
  wire n794;
  wire [7:0] n795;
  wire n797;
  wire n799;
  wire n800;
  wire n802;
  wire n804;
  wire n805;
  wire n806;
  wire n807;
  wire n808;
  wire n809;
  wire n811;
  wire n813;
  wire n815;
  wire n817;
  wire [15:0] n818;
  reg p_sr_ena;
  wire n840;
  wire n842;
  wire [2:0] n843;
  wire n845;
  wire n847;
  wire n849;
  wire n851;
  wire n853;
  wire n855;
  wire n857;
  wire n859;
  wire [7:0] n860;
  reg n869;
  reg n876;
  reg n882;
  reg n888;
  reg n892;
  wire n894;
  wire n895;
  wire n896;
  wire n897;
  wire n898;
  wire n899;
  wire n901;
  wire n902;
  wire n903;
  wire n904;
  wire n905;
  wire n907;
  wire n908;
  wire n909;
  wire n910;
  wire n911;
  wire n912;
  wire n913;
  wire [6:0] n914;
  wire [6:0] n915;
  wire [6:0] n916;
  wire n918;
  wire n919;
  wire n920;
  wire [6:0] n921;
  wire [6:0] n922;
  wire n924;
  wire [7:0] n925;
  wire [7:0] n926;
  wire n927;
  wire n928;
  wire n929;
  wire n930;
  wire n931;
  wire n932;
  wire [6:0] n933;
  wire n934;
  wire [7:0] n935;
  wire [7:0] n936;
  wire n938;
  wire [7:0] n939;
  wire n941;
  wire n942;
  wire [7:0] n943;
  wire n944;
  wire n945;
  wire [7:0] n946;
  wire n947;
  wire n948;
  wire [7:0] n949;
  wire n950;
  wire n951;
  wire n952;
  wire n953;
  wire n954;
  wire n955;
  wire n956;
  wire n958;
  wire n959;
  wire n961;
  wire n963;
  wire n964;
  wire n965;
  wire n966;
  wire n967;
  wire n968;
  wire n969;
  wire [3:0] n971;
  wire [3:0] n972;
  wire [3:0] n974;
  wire n976;
  wire n977;
  wire n978;
  wire n979;
  wire n980;
  wire n981;
  wire n982;
  wire n983;
  wire n985;
  wire n987;
  wire n988;
  wire n1053;
  wire n1054;
  wire n1055;
  wire n1056;
  wire n1065;
  wire n1067;
  wire [6:0] n1068;
  wire [6:0] n1069;
  wire [6:0] n1070;
  wire [6:0] n1071;
  wire [6:0] n1072;
  wire [6:0] n1073;
  wire n1075;
  wire n1081;
  wire n1084;
  wire [6:0] n1086;
  wire [6:0] n1087;
  wire n1089;
  wire n1092;
  wire [7:0] n1100;
  wire [7:0] n1103;
  wire n1104;
  reg n1105;
  wire n1106;
  reg n1107;
  wire n1108;
  reg n1109;
  wire n1110;
  reg n1111;
  wire [1:0] n1112;
  reg [1:0] n1113;
  wire n1114;
  reg n1115;
  wire [7:0] n1116;
  reg [7:0] n1117;
  wire [7:0] n1118;
  reg [7:0] n1119;
  wire [7:0] n1120;
  reg [7:0] n1121;
  wire [7:0] n1122;
  reg [7:0] n1123;
  wire [7:0] n1124;
  reg [7:0] n1125;
  wire [7:0] n1126;
  reg [7:0] n1127;
  wire [7:0] n1128;
  reg [7:0] n1129;
  wire [7:0] n1130;
  reg [7:0] n1131;
  wire [7:0] n1132;
  reg [7:0] n1133;
  wire [7:0] n1134;
  reg [7:0] n1135;
  wire [7:0] n1136;
  reg [7:0] n1137;
  wire [7:0] n1138;
  reg [7:0] n1139;
  wire [7:0] n1140;
  reg [7:0] n1141;
  wire [6:0] n1142;
  reg [6:0] n1143;
  wire n1144;
  wire n1145;
  wire n1146;
  reg n1147;
  wire n1148;
  wire n1149;
  wire n1150;
  reg n1151;
  wire n1152;
  wire n1153;
  wire n1154;
  reg n1155;
  wire n1156;
  wire n1157;
  wire [7:0] n1158;
  reg [7:0] n1159;
  wire [15:0] n1160;
  reg [15:0] n1161;
  wire n1162;
  reg n1163;
  wire n1164;
  reg n1165;
  wire n1166;
  wire n1167;
  wire n1168;
  reg n1169;
  wire n1170;
  wire n1171;
  wire n1172;
  reg n1173;
  wire n1174;
  reg n1175;
  wire n1176;
  reg n1177;
  wire n1178;
  reg n1179;
  wire n1180;
  reg n1181;
  wire n1182;
  wire n1183;
  wire n1184;
  reg n1185;
  wire n1186;
  reg n1187;
  wire n1188;
  reg n1189;
  wire [15:0] n1190;
  reg [15:0] n1191;
  wire n1192;
  reg n1193;
  wire n1194;
  reg n1195;
  wire n1196;
  reg n1197;
  wire n1198;
  reg n1199;
  wire n1200;
  reg n1201;
  wire n1202;
  wire n1203;
  wire n1204;
  reg n1205;
  wire n1206;
  wire n1207;
  wire n1208;
  reg n1209;
  wire n1210;
  reg n1211;
  wire n1212;
  reg n1213;
  wire n1214;
  reg n1215;
  wire n1216;
  reg n1217;
  wire [3:0] n1218;
  reg [3:0] n1219;
  wire n1220;
  reg n1221;
  wire n1222;
  reg n1223;
  wire n1224;
  reg n1225;
  wire n1226;
  reg n1227;
  wire n1228;
  reg n1229;
  wire n1230;
  reg n1231;
  wire n1232;
  reg n1233;
  wire n1234;
  reg n1235;
  wire n1236;
  reg n1237;
  wire n1238;
  reg n1239;
  wire n1240;
  reg n1241;
  wire n1242;
  reg n1243;
  wire n1244;
  reg n1245;
  wire n1246;
  reg n1247;
  wire n1248;
  reg n1249;
  wire n1250;
  reg n1251;
  wire n1252;
  reg n1253;
  wire n1254;
  reg n1255;
  wire n1256;
  reg n1257;
  wire n1258;
  reg n1259;
  wire n1260;
  reg n1261;
  wire n1262;
  reg n1263;
  wire n1264;
  reg n1265;
  wire n1266;
  reg n1267;
  wire n1268;
  reg n1269;
  wire n1270;
  reg n1271;
  wire n1272;
  reg n1273;
  wire n1274;
  reg n1275;
  wire n1276;
  reg n1277;
  wire n1278;
  wire n1279;
  wire n1280;
  reg n1281;
  assign O_DATA = n331; //(module output)
  assign O_DATA_OE_L = n256; //(module output)
  assign O_IRQ_L = n1081; //(module output)
  assign O_CA2 = n1105; //(module output)
  assign O_CA2_OE_L = n1107; //(module output)
  assign O_PA = r_ora; //(module output)
  assign O_PA_OE_L = n613; //(module output)
  assign O_CB1 = sr_cb1_out; //(module output)
  assign O_CB1_OE_L = sr_cb1_oe_l; //(module output)
  assign O_CB2 = n1109; //(module output)
  assign O_CB2_OE_L = n1111; //(module output)
  assign O_PB = n616; //(module output)
  assign O_PB_OE_L = n617; //(module output)
  /*# m6522.vhd:103:11 */
  always @*
    phase = n1113; // (isignal)
  initial
    phase = 2'b00;
  /*# m6522.vhd:104:11 */
  assign p2_h_t1 = n1115; // (signal)
  /*# m6522.vhd:105:11 */
  assign cs = n42; // (signal)
  /*# m6522.vhd:108:11 */
  assign r_ddra = n1117; // (signal)
  /*# m6522.vhd:109:11 */
  assign r_ora = n1119; // (signal)
  /*# m6522.vhd:110:11 */
  assign r_ira = n1121; // (signal)
  /*# m6522.vhd:112:11 */
  assign r_ddrb = n1123; // (signal)
  /*# m6522.vhd:113:11 */
  assign r_orb = n1125; // (signal)
  /*# m6522.vhd:114:11 */
  assign r_irb = n1127; // (signal)
  /*# m6522.vhd:116:11 */
  assign r_t1l_l = n1129; // (signal)
  /*# m6522.vhd:117:11 */
  assign r_t1l_h = n1131; // (signal)
  /*# m6522.vhd:118:11 */
  assign r_t2l_l = n1133; // (signal)
  /*# m6522.vhd:119:11 */
  assign r_t2l_h = n1135; // (signal)
  /*# m6522.vhd:120:11 */
  assign r_sr = n1137; // (signal)
  /*# m6522.vhd:121:11 */
  assign r_acr = n1139; // (signal)
  /*# m6522.vhd:122:11 */
  assign r_pcr = n1141; // (signal)
  /*# m6522.vhd:123:11 */
  assign r_ifr = n1103; // (signal)
  /*# m6522.vhd:124:11 */
  assign r_ier = n1143; // (signal)
  /*# m6522.vhd:126:11 */
  assign sr_write_ena = n1147; // (signal)
  /*# m6522.vhd:127:11 */
  assign sr_read_ena = n334; // (signal)
  /*# m6522.vhd:128:11 */
  assign ifr_write_ena = n1151; // (signal)
  /*# m6522.vhd:129:11 */
  assign ier_write_ena = n1155; // (signal)
  /*# m6522.vhd:130:11 */
  assign clear_irq = n1100; // (signal)
  /*# m6522.vhd:131:11 */
  assign load_data = n1159; // (signal)
  /*# m6522.vhd:134:11 */
  always @*
    t1c = n1161; // (isignal)
  initial
    t1c = 16'b1111111111111111;
  /*# m6522.vhd:135:11 */
  assign t1c_active = n1163; // (signal)
  /*# m6522.vhd:136:11 */
  assign t1c_done = n1165; // (signal)
  /*# m6522.vhd:137:11 */
  assign t1_w_reset_int = n1169; // (signal)
  /*# m6522.vhd:138:11 */
  assign t1_r_reset_int = n337; // (signal)
  /*# m6522.vhd:139:11 */
  assign t1_load_counter = n1173; // (signal)
  /*# m6522.vhd:140:11 */
  assign t1_reload_counter = n1175; // (signal)
  /*# m6522.vhd:141:11 */
  always @*
    t1_int_enable = n1177; // (isignal)
  initial
    t1_int_enable = 1'b0;
  /*# m6522.vhd:142:11 */
  assign t1_toggle = n1179; // (signal)
  /*# m6522.vhd:143:11 */
  always @*
    t1_irq = n1181; // (isignal)
  initial
    t1_irq = 1'b0;
  /*# m6522.vhd:144:11 */
  always @*
    t1_pb7 = n1185; // (isignal)
  initial
    t1_pb7 = 1'b1;
  /*# m6522.vhd:145:11 */
  assign t1_pb7_en_c = n1187; // (signal)
  /*# m6522.vhd:146:11 */
  assign t1_pb7_en_d = n1189; // (signal)
  /*# m6522.vhd:149:11 */
  always @*
    t2c = n1191; // (isignal)
  initial
    t2c = 16'b1111111111111111;
  /*# m6522.vhd:150:11 */
  assign t2c_active = n1193; // (signal)
  /*# m6522.vhd:151:11 */
  assign t2c_done = n1195; // (signal)
  /*# m6522.vhd:152:11 */
  assign t2_pb6 = n1197; // (signal)
  /*# m6522.vhd:153:11 */
  assign t2_pb6_t1 = n1199; // (signal)
  /*# m6522.vhd:154:11 */
  always @*
    t2_cnt_clk = n1201; // (isignal)
  initial
    t2_cnt_clk = 1'b1;
  /*# m6522.vhd:155:11 */
  assign t2_w_reset_int = n1205; // (signal)
  /*# m6522.vhd:156:11 */
  assign t2_r_reset_int = n340; // (signal)
  /*# m6522.vhd:157:11 */
  assign t2_load_counter = n1209; // (signal)
  /*# m6522.vhd:158:11 */
  assign t2_reload_counter = n1211; // (signal)
  /*# m6522.vhd:159:11 */
  always @*
    t2_int_enable = n1213; // (isignal)
  initial
    t2_int_enable = 1'b0;
  /*# m6522.vhd:160:11 */
  always @*
    t2_irq = n1215; // (isignal)
  initial
    t2_irq = 1'b0;
  /*# m6522.vhd:161:11 */
  assign t2_sr_ena = n1217; // (signal)
  /*# m6522.vhd:164:11 */
  assign sr_cnt = n1219; // (signal)
  /*# m6522.vhd:165:11 */
  assign sr_cb1_oe_l = n1221; // (signal)
  /*# m6522.vhd:166:11 */
  assign sr_cb1_out = n1223; // (signal)
  /*# m6522.vhd:167:11 */
  assign sr_drive_cb2 = n1225; // (signal)
  /*# m6522.vhd:168:11 */
  assign sr_strobe = n1227; // (signal)
  /*# m6522.vhd:169:11 */
  always @*
    sr_do_shift = n1229; // (isignal)
  initial
    sr_do_shift = 1'b0;
  /*# m6522.vhd:170:11 */
  assign sr_strobe_t1 = n1231; // (signal)
  /*# m6522.vhd:171:11 */
  assign sr_strobe_falling = n1233; // (signal)
  /*# m6522.vhd:172:11 */
  assign sr_strobe_rising = n1235; // (signal)
  /*# m6522.vhd:173:11 */
  assign sr_irq = n1237; // (signal)
  /*# m6522.vhd:174:11 */
  assign sr_out = n1239; // (signal)
  /*# m6522.vhd:175:11 */
  assign sr_active = n1241; // (signal)
  /*# m6522.vhd:178:11 */
  assign w_orb_hs = n1243; // (signal)
  /*# m6522.vhd:179:11 */
  assign w_ora_hs = n1245; // (signal)
  /*# m6522.vhd:180:11 */
  assign r_irb_hs = n343; // (signal)
  /*# m6522.vhd:181:11 */
  assign r_ira_hs = n346; // (signal)
  /*# m6522.vhd:183:11 */
  assign ca_hs_sr = n1247; // (signal)
  /*# m6522.vhd:184:11 */
  assign ca_hs_pulse = n1249; // (signal)
  /*# m6522.vhd:185:11 */
  assign cb_hs_sr = n1251; // (signal)
  /*# m6522.vhd:186:11 */
  assign cb_hs_pulse = n1253; // (signal)
  /*# m6522.vhd:188:11 */
  assign cb1_in_mux = n352; // (signal)
  /*# m6522.vhd:189:11 */
  assign ca1_ip_reg_c = n1255; // (signal)
  /*# m6522.vhd:191:11 */
  assign cb1_ip_reg_c = n1257; // (signal)
  /*# m6522.vhd:192:11 */
  assign cb1_ip_reg_d = n1259; // (signal)
  /*# m6522.vhd:193:11 */
  assign ca1_int = n361; // (signal)
  /*# m6522.vhd:194:11 */
  assign cb1_int = n368; // (signal)
  /*# m6522.vhd:195:11 */
  assign ca1_irq = n1261; // (signal)
  /*# m6522.vhd:196:11 */
  assign cb1_irq = n1263; // (signal)
  /*# m6522.vhd:198:11 */
  assign ca2_ip_reg_c = n1265; // (signal)
  /*# m6522.vhd:199:11 */
  assign ca2_ip_reg_d = n1267; // (signal)
  /*# m6522.vhd:200:11 */
  assign cb2_ip_reg_c = n1269; // (signal)
  /*# m6522.vhd:201:11 */
  assign cb2_ip_reg_d = n1271; // (signal)
  /*# m6522.vhd:202:11 */
  assign ca2_int = n381; // (signal)
  /*# m6522.vhd:203:11 */
  assign cb2_int = n393; // (signal)
  /*# m6522.vhd:204:11 */
  assign ca2_irq = n1273; // (signal)
  /*# m6522.vhd:205:11 */
  assign cb2_irq = n1275; // (signal)
  /*# m6522.vhd:207:11 */
  assign final_irq = n1277; // (signal)
  /*# m6522.vhd:216:22 */
  assign n25 = ~p2_h_t1;
  /*# m6522.vhd:216:29 */
  assign n26 = I_P2_H & n25;
  /*# m6522.vhd:219:55 */
  assign n28 = phase + 2'b01;
  /*# m6522.vhd:216:10 */
  assign n30 = n26 ? 2'b11 : n28;
  /*# m6522.vhd:227:37 */
  assign n37 = ~I_CS2_L;
  /*# m6522.vhd:227:24 */
  assign n38 = n37 & I_CS1;
  /*# m6522.vhd:227:44 */
  assign n39 = I_P2_H & n38;
  /*# m6522.vhd:227:7 */
  assign n42 = n39 ? 1'b1 : 1'b0;
  /*# m6522.vhd:267:19 */
  assign n46 = ~RESET_L;
  /*# m6522.vhd:278:39 */
  assign n48 = ~I_RW_L;
  /*# m6522.vhd:278:27 */
  assign n49 = n48 & cs;
  /*# m6522.vhd:280:19 */
  assign n51 = I_RS == 4'b0000;
  /*# m6522.vhd:281:19 */
  assign n53 = I_RS == 4'b0001;
  /*# m6522.vhd:282:19 */
  assign n55 = I_RS == 4'b0010;
  /*# m6522.vhd:283:19 */
  assign n57 = I_RS == 4'b0011;
  /*# m6522.vhd:285:19 */
  assign n59 = I_RS == 4'b1011;
  /*# m6522.vhd:286:19 */
  assign n61 = I_RS == 4'b1100;
  /*# m6522.vhd:287:19 */
  assign n63 = I_RS == 4'b1111;
  /*# m6522.vhd:279:16 */
  assign n64 = {n63, n61, n59, n57, n55, n53, n51};
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n65 = r_ddra;
      7'b0100000: n65 = r_ddra;
      7'b0010000: n65 = r_ddra;
      7'b0001000: n65 = I_DATA;
      7'b0000100: n65 = r_ddra;
      7'b0000010: n65 = r_ddra;
      7'b0000001: n65 = r_ddra;
      default: n65 = r_ddra;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n66 = I_DATA;
      7'b0100000: n66 = r_ora;
      7'b0010000: n66 = r_ora;
      7'b0001000: n66 = r_ora;
      7'b0000100: n66 = r_ora;
      7'b0000010: n66 = I_DATA;
      7'b0000001: n66 = r_ora;
      default: n66 = r_ora;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n67 = r_ddrb;
      7'b0100000: n67 = r_ddrb;
      7'b0010000: n67 = r_ddrb;
      7'b0001000: n67 = r_ddrb;
      7'b0000100: n67 = I_DATA;
      7'b0000010: n67 = r_ddrb;
      7'b0000001: n67 = r_ddrb;
      default: n67 = r_ddrb;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n68 = r_orb;
      7'b0100000: n68 = r_orb;
      7'b0010000: n68 = r_orb;
      7'b0001000: n68 = r_orb;
      7'b0000100: n68 = r_orb;
      7'b0000010: n68 = r_orb;
      7'b0000001: n68 = I_DATA;
      default: n68 = r_orb;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n69 = r_acr;
      7'b0100000: n69 = r_acr;
      7'b0010000: n69 = I_DATA;
      7'b0001000: n69 = r_acr;
      7'b0000100: n69 = r_acr;
      7'b0000010: n69 = r_acr;
      7'b0000001: n69 = r_acr;
      default: n69 = r_acr;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n70 = r_pcr;
      7'b0100000: n70 = I_DATA;
      7'b0010000: n70 = r_pcr;
      7'b0001000: n70 = r_pcr;
      7'b0000100: n70 = r_pcr;
      7'b0000010: n70 = r_pcr;
      7'b0000001: n70 = r_pcr;
      default: n70 = r_pcr;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n73 = 1'b0;
      7'b0100000: n73 = 1'b0;
      7'b0010000: n73 = 1'b0;
      7'b0001000: n73 = 1'b0;
      7'b0000100: n73 = 1'b0;
      7'b0000010: n73 = 1'b0;
      7'b0000001: n73 = 1'b1;
      default: n73 = 1'b0;
    endcase
  /*# m6522.vhd:279:16 */
  always @*
    case (n64)
      7'b1000000: n76 = 1'b0;
      7'b0100000: n76 = 1'b0;
      7'b0010000: n76 = 1'b0;
      7'b0001000: n76 = 1'b0;
      7'b0000100: n76 = 1'b0;
      7'b0000010: n76 = 1'b1;
      7'b0000001: n76 = 1'b0;
      default: n76 = 1'b0;
    endcase
  /*# m6522.vhd:278:13 */
  assign n84 = n49 ? n73 : 1'b0;
  /*# m6522.vhd:278:13 */
  assign n87 = n49 ? n76 : 1'b0;
  /*# m6522.vhd:294:30 */
  assign n89 = ~t1_pb7_en_d;
  /*# m6522.vhd:294:37 */
  assign n90 = t1_pb7_en_c & n89;
  /*# m6522.vhd:294:13 */
  assign n92 = n90 ? 1'b1 : t1_pb7;
  /*# m6522.vhd:301:26 */
  assign n93 = ~t1_pb7;
  /*# m6522.vhd:300:13 */
  assign n94 = t1_toggle ? n93 : n92;
  /*# m6522.vhd:298:13 */
  assign n96 = t1_load_counter ? 1'b0 : n94;
  /*# m6522.vhd:275:10 */
  assign n97 = n49 & ENA_4;
  /*# m6522.vhd:275:10 */
  assign n98 = n49 & ENA_4;
  /*# m6522.vhd:275:10 */
  assign n99 = n49 & ENA_4;
  /*# m6522.vhd:275:10 */
  assign n100 = n49 & ENA_4;
  /*# m6522.vhd:275:10 */
  assign n101 = n49 & ENA_4;
  /*# m6522.vhd:275:10 */
  assign n102 = n49 & ENA_4;
  /*# m6522.vhd:309:19 */
  assign n134 = ~RESET_L;
  /*# m6522.vhd:330:39 */
  assign n136 = ~I_RW_L;
  /*# m6522.vhd:330:27 */
  assign n137 = n136 & cs;
  /*# m6522.vhd:333:19 */
  assign n139 = I_RS == 4'b0100;
  /*# m6522.vhd:334:19 */
  assign n141 = I_RS == 4'b0101;
  /*# m6522.vhd:337:19 */
  assign n143 = I_RS == 4'b0110;
  /*# m6522.vhd:338:19 */
  assign n145 = I_RS == 4'b0111;
  /*# m6522.vhd:340:19 */
  assign n147 = I_RS == 4'b1000;
  /*# m6522.vhd:341:19 */
  assign n149 = I_RS == 4'b1001;
  /*# m6522.vhd:344:19 */
  assign n151 = I_RS == 4'b1010;
  /*# m6522.vhd:345:19 */
  assign n153 = I_RS == 4'b1101;
  /*# m6522.vhd:346:19 */
  assign n155 = I_RS == 4'b1110;
  /*# m6522.vhd:332:16 */
  assign n156 = {n155, n153, n151, n149, n147, n145, n143, n141, n139};
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n157 = r_t1l_l;
      9'b010000000: n157 = r_t1l_l;
      9'b001000000: n157 = r_t1l_l;
      9'b000100000: n157 = r_t1l_l;
      9'b000010000: n157 = r_t1l_l;
      9'b000001000: n157 = r_t1l_l;
      9'b000000100: n157 = I_DATA;
      9'b000000010: n157 = r_t1l_l;
      9'b000000001: n157 = I_DATA;
      default: n157 = r_t1l_l;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n158 = r_t1l_h;
      9'b010000000: n158 = r_t1l_h;
      9'b001000000: n158 = r_t1l_h;
      9'b000100000: n158 = r_t1l_h;
      9'b000010000: n158 = r_t1l_h;
      9'b000001000: n158 = I_DATA;
      9'b000000100: n158 = r_t1l_h;
      9'b000000010: n158 = I_DATA;
      9'b000000001: n158 = r_t1l_h;
      default: n158 = r_t1l_h;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n159 = r_t2l_l;
      9'b010000000: n159 = r_t2l_l;
      9'b001000000: n159 = r_t2l_l;
      9'b000100000: n159 = r_t2l_l;
      9'b000010000: n159 = I_DATA;
      9'b000001000: n159 = r_t2l_l;
      9'b000000100: n159 = r_t2l_l;
      9'b000000010: n159 = r_t2l_l;
      9'b000000001: n159 = r_t2l_l;
      default: n159 = r_t2l_l;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n160 = r_t2l_h;
      9'b010000000: n160 = r_t2l_h;
      9'b001000000: n160 = r_t2l_h;
      9'b000100000: n160 = I_DATA;
      9'b000010000: n160 = r_t2l_h;
      9'b000001000: n160 = r_t2l_h;
      9'b000000100: n160 = r_t2l_h;
      9'b000000010: n160 = r_t2l_h;
      9'b000000001: n160 = r_t2l_h;
      default: n160 = r_t2l_h;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n163 = 1'b0;
      9'b010000000: n163 = 1'b0;
      9'b001000000: n163 = 1'b1;
      9'b000100000: n163 = 1'b0;
      9'b000010000: n163 = 1'b0;
      9'b000001000: n163 = 1'b0;
      9'b000000100: n163 = 1'b0;
      9'b000000010: n163 = 1'b0;
      9'b000000001: n163 = 1'b0;
      default: n163 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n166 = 1'b0;
      9'b010000000: n166 = 1'b1;
      9'b001000000: n166 = 1'b0;
      9'b000100000: n166 = 1'b0;
      9'b000010000: n166 = 1'b0;
      9'b000001000: n166 = 1'b0;
      9'b000000100: n166 = 1'b0;
      9'b000000010: n166 = 1'b0;
      9'b000000001: n166 = 1'b0;
      default: n166 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n169 = 1'b1;
      9'b010000000: n169 = 1'b0;
      9'b001000000: n169 = 1'b0;
      9'b000100000: n169 = 1'b0;
      9'b000010000: n169 = 1'b0;
      9'b000001000: n169 = 1'b0;
      9'b000000100: n169 = 1'b0;
      9'b000000010: n169 = 1'b0;
      9'b000000001: n169 = 1'b0;
      default: n169 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n173 = 1'b0;
      9'b010000000: n173 = 1'b0;
      9'b001000000: n173 = 1'b0;
      9'b000100000: n173 = 1'b0;
      9'b000010000: n173 = 1'b0;
      9'b000001000: n173 = 1'b1;
      9'b000000100: n173 = 1'b0;
      9'b000000010: n173 = 1'b1;
      9'b000000001: n173 = 1'b0;
      default: n173 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n176 = 1'b0;
      9'b010000000: n176 = 1'b0;
      9'b001000000: n176 = 1'b0;
      9'b000100000: n176 = 1'b0;
      9'b000010000: n176 = 1'b0;
      9'b000001000: n176 = 1'b0;
      9'b000000100: n176 = 1'b0;
      9'b000000010: n176 = 1'b1;
      9'b000000001: n176 = 1'b0;
      default: n176 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n179 = 1'b0;
      9'b010000000: n179 = 1'b0;
      9'b001000000: n179 = 1'b0;
      9'b000100000: n179 = 1'b1;
      9'b000010000: n179 = 1'b0;
      9'b000001000: n179 = 1'b0;
      9'b000000100: n179 = 1'b0;
      9'b000000010: n179 = 1'b0;
      9'b000000001: n179 = 1'b0;
      default: n179 = 1'b0;
    endcase
  /*# m6522.vhd:332:16 */
  always @*
    case (n156)
      9'b100000000: n182 = 1'b0;
      9'b010000000: n182 = 1'b0;
      9'b001000000: n182 = 1'b0;
      9'b000100000: n182 = 1'b1;
      9'b000010000: n182 = 1'b0;
      9'b000001000: n182 = 1'b0;
      9'b000000100: n182 = 1'b0;
      9'b000000010: n182 = 1'b0;
      9'b000000001: n182 = 1'b0;
      default: n182 = 1'b0;
    endcase
  /*# m6522.vhd:330:13 */
  assign n188 = n137 ? n163 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n191 = n137 ? n166 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n194 = n137 ? n169 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n197 = n137 ? I_DATA : 8'b00000000;
  /*# m6522.vhd:330:13 */
  assign n200 = n137 ? n173 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n203 = n137 ? n176 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n206 = n137 ? n179 : 1'b0;
  /*# m6522.vhd:330:13 */
  assign n209 = n137 ? n182 : 1'b0;
  /*# m6522.vhd:318:10 */
  assign n211 = n137 & ENA_4;
  /*# m6522.vhd:318:10 */
  assign n212 = n137 & ENA_4;
  /*# m6522.vhd:318:10 */
  assign n213 = n137 & ENA_4;
  /*# m6522.vhd:318:10 */
  assign n214 = n137 & ENA_4;
  /*# m6522.vhd:358:21 */
  assign n253 = I_RW_L & cs;
  /*# m6522.vhd:358:7 */
  assign n256 = n253 ? 1'b0 : 1'b1;
  /*# m6522.vhd:373:25 */
  assign n261 = ~r_ddrb;
  /*# m6522.vhd:373:21 */
  assign n262 = r_irb & n261;
  /*# m6522.vhd:373:47 */
  assign n263 = r_orb & r_ddrb;
  /*# m6522.vhd:373:37 */
  assign n264 = n262 | n263;
  /*# m6522.vhd:365:16 */
  assign n265 = n264[7]; // extract
  /*# m6522.vhd:376:7 */
  assign n266 = t1_pb7_en_d ? t1_pb7 : n265;
  /*# m6522.vhd:365:16 */
  assign n267 = n264[6:0]; // extract
  /*# m6522.vhd:380:21 */
  assign n268 = I_RW_L & cs;
  /*# m6522.vhd:365:16 */
  assign n269 = {n266, n267};
  /*# m6522.vhd:382:13 */
  assign n271 = I_RS == 4'b0000;
  /*# m6522.vhd:383:47 */
  assign n272 = ~r_ddra;
  /*# m6522.vhd:383:43 */
  assign n273 = r_ira & n272;
  /*# m6522.vhd:383:69 */
  assign n274 = r_ora & r_ddra;
  /*# m6522.vhd:383:59 */
  assign n275 = n273 | n274;
  /*# m6522.vhd:383:13 */
  assign n277 = I_RS == 4'b0001;
  /*# m6522.vhd:384:13 */
  assign n279 = I_RS == 4'b0010;
  /*# m6522.vhd:385:13 */
  assign n281 = I_RS == 4'b0011;
  /*# m6522.vhd:386:39 */
  assign n282 = t1c[7:0]; // extract
  /*# m6522.vhd:386:13 */
  assign n284 = I_RS == 4'b0100;
  /*# m6522.vhd:387:39 */
  assign n285 = t1c[15:8]; // extract
  /*# m6522.vhd:387:13 */
  assign n287 = I_RS == 4'b0101;
  /*# m6522.vhd:388:13 */
  assign n289 = I_RS == 4'b0110;
  /*# m6522.vhd:389:13 */
  assign n291 = I_RS == 4'b0111;
  /*# m6522.vhd:390:39 */
  assign n292 = t2c[7:0]; // extract
  /*# m6522.vhd:390:13 */
  assign n294 = I_RS == 4'b1000;
  /*# m6522.vhd:391:39 */
  assign n295 = t2c[15:8]; // extract
  /*# m6522.vhd:391:13 */
  assign n297 = I_RS == 4'b1001;
  /*# m6522.vhd:392:13 */
  assign n299 = I_RS == 4'b1010;
  /*# m6522.vhd:393:13 */
  assign n301 = I_RS == 4'b1011;
  /*# m6522.vhd:394:13 */
  assign n303 = I_RS == 4'b1100;
  /*# m6522.vhd:395:13 */
  assign n305 = I_RS == 4'b1101;
  /*# m6522.vhd:397:41 */
  assign n307 = {1'b1, r_ier};
  /*# m6522.vhd:397:13 */
  assign n309 = I_RS == 4'b1110;
  /*# m6522.vhd:398:13 */
  assign n311 = I_RS == 4'b1111;
  /*# m6522.vhd:381:10 */
  assign n312 = {n311, n309, n305, n303, n301, n299, n297, n294, n291, n289, n287, n284, n281, n279, n277, n271};
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n314 = r_ira;
      16'b0100000000000000: n314 = n307;
      16'b0010000000000000: n314 = r_ifr;
      16'b0001000000000000: n314 = r_pcr;
      16'b0000100000000000: n314 = r_acr;
      16'b0000010000000000: n314 = r_sr;
      16'b0000001000000000: n314 = n295;
      16'b0000000100000000: n314 = n292;
      16'b0000000010000000: n314 = r_t1l_h;
      16'b0000000001000000: n314 = r_t1l_l;
      16'b0000000000100000: n314 = n285;
      16'b0000000000010000: n314 = n282;
      16'b0000000000001000: n314 = r_ddra;
      16'b0000000000000100: n314 = r_ddrb;
      16'b0000000000000010: n314 = n275;
      16'b0000000000000001: n314 = n269;
      default: n314 = 8'b00000000;
    endcase
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n317 = 1'b0;
      16'b0100000000000000: n317 = 1'b0;
      16'b0010000000000000: n317 = 1'b0;
      16'b0001000000000000: n317 = 1'b0;
      16'b0000100000000000: n317 = 1'b0;
      16'b0000010000000000: n317 = 1'b1;
      16'b0000001000000000: n317 = 1'b0;
      16'b0000000100000000: n317 = 1'b0;
      16'b0000000010000000: n317 = 1'b0;
      16'b0000000001000000: n317 = 1'b0;
      16'b0000000000100000: n317 = 1'b0;
      16'b0000000000010000: n317 = 1'b0;
      16'b0000000000001000: n317 = 1'b0;
      16'b0000000000000100: n317 = 1'b0;
      16'b0000000000000010: n317 = 1'b0;
      16'b0000000000000001: n317 = 1'b0;
      default: n317 = 1'b0;
    endcase
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n320 = 1'b0;
      16'b0100000000000000: n320 = 1'b0;
      16'b0010000000000000: n320 = 1'b0;
      16'b0001000000000000: n320 = 1'b0;
      16'b0000100000000000: n320 = 1'b0;
      16'b0000010000000000: n320 = 1'b0;
      16'b0000001000000000: n320 = 1'b0;
      16'b0000000100000000: n320 = 1'b0;
      16'b0000000010000000: n320 = 1'b0;
      16'b0000000001000000: n320 = 1'b0;
      16'b0000000000100000: n320 = 1'b0;
      16'b0000000000010000: n320 = 1'b1;
      16'b0000000000001000: n320 = 1'b0;
      16'b0000000000000100: n320 = 1'b0;
      16'b0000000000000010: n320 = 1'b0;
      16'b0000000000000001: n320 = 1'b0;
      default: n320 = 1'b0;
    endcase
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n323 = 1'b0;
      16'b0100000000000000: n323 = 1'b0;
      16'b0010000000000000: n323 = 1'b0;
      16'b0001000000000000: n323 = 1'b0;
      16'b0000100000000000: n323 = 1'b0;
      16'b0000010000000000: n323 = 1'b0;
      16'b0000001000000000: n323 = 1'b0;
      16'b0000000100000000: n323 = 1'b1;
      16'b0000000010000000: n323 = 1'b0;
      16'b0000000001000000: n323 = 1'b0;
      16'b0000000000100000: n323 = 1'b0;
      16'b0000000000010000: n323 = 1'b0;
      16'b0000000000001000: n323 = 1'b0;
      16'b0000000000000100: n323 = 1'b0;
      16'b0000000000000010: n323 = 1'b0;
      16'b0000000000000001: n323 = 1'b0;
      default: n323 = 1'b0;
    endcase
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n326 = 1'b0;
      16'b0100000000000000: n326 = 1'b0;
      16'b0010000000000000: n326 = 1'b0;
      16'b0001000000000000: n326 = 1'b0;
      16'b0000100000000000: n326 = 1'b0;
      16'b0000010000000000: n326 = 1'b0;
      16'b0000001000000000: n326 = 1'b0;
      16'b0000000100000000: n326 = 1'b0;
      16'b0000000010000000: n326 = 1'b0;
      16'b0000000001000000: n326 = 1'b0;
      16'b0000000000100000: n326 = 1'b0;
      16'b0000000000010000: n326 = 1'b0;
      16'b0000000000001000: n326 = 1'b0;
      16'b0000000000000100: n326 = 1'b0;
      16'b0000000000000010: n326 = 1'b0;
      16'b0000000000000001: n326 = 1'b1;
      default: n326 = 1'b0;
    endcase
  /*# m6522.vhd:381:10 */
  always @*
    case (n312)
      16'b1000000000000000: n329 = 1'b0;
      16'b0100000000000000: n329 = 1'b0;
      16'b0010000000000000: n329 = 1'b0;
      16'b0001000000000000: n329 = 1'b0;
      16'b0000100000000000: n329 = 1'b0;
      16'b0000010000000000: n329 = 1'b0;
      16'b0000001000000000: n329 = 1'b0;
      16'b0000000100000000: n329 = 1'b0;
      16'b0000000010000000: n329 = 1'b0;
      16'b0000000001000000: n329 = 1'b0;
      16'b0000000000100000: n329 = 1'b0;
      16'b0000000000010000: n329 = 1'b0;
      16'b0000000000001000: n329 = 1'b0;
      16'b0000000000000100: n329 = 1'b0;
      16'b0000000000000010: n329 = 1'b1;
      16'b0000000000000001: n329 = 1'b0;
      default: n329 = 1'b0;
    endcase
  /*# m6522.vhd:380:7 */
  assign n331 = n268 ? n314 : 8'b00000000;
  /*# m6522.vhd:380:7 */
  assign n334 = n268 ? n317 : 1'b0;
  /*# m6522.vhd:380:7 */
  assign n337 = n268 ? n320 : 1'b0;
  /*# m6522.vhd:380:7 */
  assign n340 = n268 ? n323 : 1'b0;
  /*# m6522.vhd:380:7 */
  assign n343 = n268 ? n326 : 1'b0;
  /*# m6522.vhd:380:7 */
  assign n346 = n268 ? n329 : 1'b0;
  /*# m6522.vhd:414:7 */
  assign n352 = sr_cb1_oe_l ? I_CB1 : 1'b1;
  /*# m6522.vhd:423:16 */
  assign n355 = r_pcr[0]; // extract
  /*# m6522.vhd:423:20 */
  assign n356 = ~n355;
  /*# m6522.vhd:425:53 */
  assign n357 = ~I_CA1;
  /*# m6522.vhd:425:42 */
  assign n358 = n357 & ca1_ip_reg_c;
  /*# m6522.vhd:428:35 */
  assign n359 = ~ca1_ip_reg_c;
  /*# m6522.vhd:428:42 */
  assign n360 = I_CA1 & n359;
  /*# m6522.vhd:423:7 */
  assign n361 = n356 ? n358 : n360;
  /*# m6522.vhd:431:16 */
  assign n362 = r_pcr[4]; // extract
  /*# m6522.vhd:431:20 */
  assign n363 = ~n362;
  /*# m6522.vhd:433:60 */
  assign n364 = ~cb1_ip_reg_c;
  /*# m6522.vhd:433:42 */
  assign n365 = n364 & cb1_ip_reg_d;
  /*# m6522.vhd:436:35 */
  assign n366 = ~cb1_ip_reg_d;
  /*# m6522.vhd:436:42 */
  assign n367 = cb1_ip_reg_c & n366;
  /*# m6522.vhd:431:7 */
  assign n368 = n363 ? n365 : n367;
  /*# m6522.vhd:443:16 */
  assign n371 = r_pcr[3]; // extract
  /*# m6522.vhd:443:20 */
  assign n372 = ~n371;
  /*# m6522.vhd:444:19 */
  assign n373 = r_pcr[2]; // extract
  /*# m6522.vhd:444:23 */
  assign n374 = ~n373;
  /*# m6522.vhd:446:60 */
  assign n375 = ~ca2_ip_reg_c;
  /*# m6522.vhd:446:42 */
  assign n376 = n375 & ca2_ip_reg_d;
  /*# m6522.vhd:449:35 */
  assign n377 = ~ca2_ip_reg_d;
  /*# m6522.vhd:449:42 */
  assign n378 = ca2_ip_reg_c & n377;
  /*# m6522.vhd:444:10 */
  assign n379 = n374 ? n376 : n378;
  /*# m6522.vhd:443:7 */
  assign n381 = n372 ? n379 : 1'b0;
  /*# m6522.vhd:454:16 */
  assign n383 = r_pcr[7]; // extract
  /*# m6522.vhd:454:20 */
  assign n384 = ~n383;
  /*# m6522.vhd:455:19 */
  assign n385 = r_pcr[6]; // extract
  /*# m6522.vhd:455:23 */
  assign n386 = ~n385;
  /*# m6522.vhd:457:63 */
  assign n387 = ~cb2_ip_reg_c;
  /*# m6522.vhd:457:45 */
  assign n388 = n387 & cb2_ip_reg_d;
  /*# m6522.vhd:460:38 */
  assign n389 = ~cb2_ip_reg_d;
  /*# m6522.vhd:460:45 */
  assign n390 = cb2_ip_reg_c & n389;
  /*# m6522.vhd:455:10 */
  assign n391 = n386 ? n388 : n390;
  /*# m6522.vhd:454:7 */
  assign n393 = n384 ? n391 : 1'b0;
  /*# m6522.vhd:467:19 */
  assign n397 = ~RESET_L;
  /*# m6522.vhd:480:23 */
  assign n400 = phase == 2'b00;
  /*# m6522.vhd:480:53 */
  assign n401 = w_ora_hs | r_ira_hs;
  /*# m6522.vhd:480:31 */
  assign n402 = n401 & n400;
  /*# m6522.vhd:482:13 */
  assign n404 = ca1_int ? 1'b0 : ca_hs_sr;
  /*# m6522.vhd:480:13 */
  assign n406 = n402 ? 1'b1 : n404;
  /*# m6522.vhd:486:23 */
  assign n408 = phase == 2'b00;
  /*# m6522.vhd:487:40 */
  assign n409 = w_ora_hs | r_ira_hs;
  /*# m6522.vhd:490:36 */
  assign n411 = r_pcr[3]; // extract
  /*# m6522.vhd:490:27 */
  assign n412 = ~n411;
  /*# m6522.vhd:491:23 */
  assign n413 = r_pcr[3:1]; // extract
  /*# m6522.vhd:492:16 */
  assign n415 = n413 == 3'b000;
  /*# m6522.vhd:493:16 */
  assign n417 = n413 == 3'b001;
  /*# m6522.vhd:494:16 */
  assign n419 = n413 == 3'b010;
  /*# m6522.vhd:495:16 */
  assign n421 = n413 == 3'b011;
  /*# m6522.vhd:496:39 */
  assign n422 = ~ca_hs_sr;
  /*# m6522.vhd:496:16 */
  assign n424 = n413 == 3'b100;
  /*# m6522.vhd:497:39 */
  assign n425 = ~ca_hs_pulse;
  /*# m6522.vhd:497:16 */
  assign n427 = n413 == 3'b101;
  /*# m6522.vhd:498:16 */
  assign n429 = n413 == 3'b110;
  /*# m6522.vhd:499:16 */
  assign n431 = n413 == 3'b111;
  /*# m6522.vhd:491:13 */
  assign n432 = {n431, n429, n427, n424, n421, n419, n417, n415};
  /*# m6522.vhd:491:13 */
  always @*
    case (n432)
      8'b10000000: n435 = 1'b1;
      8'b01000000: n435 = 1'b0;
      8'b00100000: n435 = n425;
      8'b00010000: n435 = n422;
      8'b00001000: n435 = I_CA2;
      8'b00000100: n435 = I_CA2;
      8'b00000010: n435 = I_CA2;
      8'b00000001: n435 = I_CA2;
      default: n435 = n1105;
    endcase
  /*# m6522.vhd:504:23 */
  assign n437 = phase == 2'b00;
  /*# m6522.vhd:504:31 */
  assign n438 = w_orb_hs & n437;
  /*# m6522.vhd:506:13 */
  assign n440 = cb1_int ? 1'b0 : cb_hs_sr;
  /*# m6522.vhd:504:13 */
  assign n442 = n438 ? 1'b1 : n440;
  /*# m6522.vhd:510:23 */
  assign n444 = phase == 2'b00;
  /*# m6522.vhd:514:37 */
  assign n446 = r_pcr[7]; // extract
  /*# m6522.vhd:514:41 */
  assign n447 = n446 | sr_drive_cb2;
  /*# m6522.vhd:514:27 */
  assign n448 = ~n447;
  /*# m6522.vhd:518:26 */
  assign n449 = r_pcr[7:5]; // extract
  /*# m6522.vhd:519:19 */
  assign n451 = n449 == 3'b000;
  /*# m6522.vhd:520:19 */
  assign n453 = n449 == 3'b001;
  /*# m6522.vhd:521:19 */
  assign n455 = n449 == 3'b010;
  /*# m6522.vhd:522:19 */
  assign n457 = n449 == 3'b011;
  /*# m6522.vhd:523:42 */
  assign n458 = ~cb_hs_sr;
  /*# m6522.vhd:523:19 */
  assign n460 = n449 == 3'b100;
  /*# m6522.vhd:524:42 */
  assign n461 = ~cb_hs_pulse;
  /*# m6522.vhd:524:19 */
  assign n463 = n449 == 3'b101;
  /*# m6522.vhd:525:19 */
  assign n465 = n449 == 3'b110;
  /*# m6522.vhd:526:19 */
  assign n467 = n449 == 3'b111;
  /*# m6522.vhd:518:16 */
  assign n468 = {n467, n465, n463, n460, n457, n455, n453, n451};
  /*# m6522.vhd:518:16 */
  always @*
    case (n468)
      8'b10000000: n471 = 1'b1;
      8'b01000000: n471 = 1'b0;
      8'b00100000: n471 = n461;
      8'b00010000: n471 = n458;
      8'b00001000: n471 = I_CB2;
      8'b00000100: n471 = I_CB2;
      8'b00000010: n471 = I_CB2;
      8'b00000001: n471 = I_CB2;
      default: n471 = n1109;
    endcase
  /*# m6522.vhd:515:13 */
  assign n472 = sr_drive_cb2 ? sr_out : n471;
  /*# m6522.vhd:478:10 */
  assign n478 = n408 & ENA_4;
  /*# m6522.vhd:478:10 */
  assign n480 = n444 & ENA_4;
  /*# m6522.vhd:539:19 */
  assign n507 = ~RESET_L;
  /*# m6522.vhd:549:36 */
  assign n509 = r_ira_hs | w_ora_hs;
  /*# m6522.vhd:549:69 */
  assign n510 = clear_irq[1]; // extract
  /*# m6522.vhd:549:56 */
  assign n511 = n509 | n510;
  /*# m6522.vhd:549:13 */
  assign n513 = n511 ? 1'b0 : ca1_irq;
  /*# m6522.vhd:547:13 */
  assign n515 = ca1_int ? 1'b1 : n513;
  /*# m6522.vhd:556:38 */
  assign n516 = r_ira_hs | w_ora_hs;
  /*# m6522.vhd:556:69 */
  assign n517 = r_pcr[1]; // extract
  /*# m6522.vhd:556:73 */
  assign n518 = ~n517;
  /*# m6522.vhd:556:59 */
  assign n519 = n518 & n516;
  /*# m6522.vhd:557:29 */
  assign n520 = clear_irq[0]; // extract
  /*# m6522.vhd:556:81 */
  assign n521 = n519 | n520;
  /*# m6522.vhd:556:16 */
  assign n523 = n521 ? 1'b0 : ca2_irq;
  /*# m6522.vhd:553:13 */
  assign n525 = ca2_int ? 1'b1 : n523;
  /*# m6522.vhd:564:36 */
  assign n526 = r_irb_hs | w_orb_hs;
  /*# m6522.vhd:564:69 */
  assign n527 = clear_irq[4]; // extract
  /*# m6522.vhd:564:56 */
  assign n528 = n526 | n527;
  /*# m6522.vhd:564:13 */
  assign n530 = n528 ? 1'b0 : cb1_irq;
  /*# m6522.vhd:562:13 */
  assign n532 = cb1_int ? 1'b1 : n530;
  /*# m6522.vhd:571:38 */
  assign n533 = r_irb_hs | w_orb_hs;
  /*# m6522.vhd:571:69 */
  assign n534 = r_pcr[5]; // extract
  /*# m6522.vhd:571:73 */
  assign n535 = ~n534;
  /*# m6522.vhd:571:59 */
  assign n536 = n535 & n533;
  /*# m6522.vhd:572:29 */
  assign n537 = clear_irq[3]; // extract
  /*# m6522.vhd:571:81 */
  assign n538 = n536 | n537;
  /*# m6522.vhd:571:16 */
  assign n540 = n538 ? 1'b0 : cb2_irq;
  /*# m6522.vhd:568:13 */
  assign n542 = cb2_int ? 1'b1 : n540;
  /*# m6522.vhd:582:19 */
  assign n561 = ~RESET_L;
  /*# m6522.vhd:613:22 */
  assign n563 = r_acr[0]; // extract
  /*# m6522.vhd:613:26 */
  assign n564 = ~n563;
  /*# m6522.vhd:616:16 */
  assign n565 = ca1_int ? I_PA : r_ira;
  /*# m6522.vhd:613:13 */
  assign n566 = n564 ? I_PA : n565;
  /*# m6522.vhd:621:22 */
  assign n567 = r_acr[1]; // extract
  /*# m6522.vhd:621:26 */
  assign n568 = ~n567;
  /*# m6522.vhd:624:16 */
  assign n569 = cb1_int ? I_PB : r_irb;
  /*# m6522.vhd:621:13 */
  assign n570 = n568 ? I_PB : n569;
  /*# m6522.vhd:636:20 */
  assign n613 = ~r_ddra;
  /*# m6522.vhd:640:32 */
  assign n614 = r_orb[6:0]; // extract
  /*# m6522.vhd:640:25 */
  assign n615 = {t1_pb7, n614};
  /*# m6522.vhd:639:7 */
  assign n616 = t1_pb7_en_d ? n615 : r_orb;
  /*# m6522.vhd:646:20 */
  assign n617 = ~r_ddrb;
  /*# m6522.vhd:658:30 */
  assign n621 = r_acr[7]; // extract
  /*# m6522.vhd:668:23 */
  assign n631 = t1c == 16'b0000000000000000;
  /*# m6522.vhd:669:38 */
  assign n633 = phase == 2'b11;
  /*# m6522.vhd:669:27 */
  assign n634 = n633 & n631;
  /*# m6522.vhd:670:20 */
  assign n636 = phase == 2'b11;
  /*# m6522.vhd:670:32 */
  assign n637 = ~t1_load_counter;
  /*# m6522.vhd:670:28 */
  assign n638 = n637 & n636;
  /*# m6522.vhd:672:10 */
  assign n640 = t1_load_counter ? 1'b0 : t1_reload_counter;
  /*# m6522.vhd:670:10 */
  assign n641 = n638 ? n631 : n640;
  /*# m6522.vhd:675:10 */
  assign n643 = t1_load_counter ? 1'b0 : n634;
  /*# m6522.vhd:685:61 */
  assign n654 = phase == 2'b11;
  /*# m6522.vhd:685:51 */
  assign n655 = n654 & t1_reload_counter;
  /*# m6522.vhd:685:29 */
  assign n656 = t1_load_counter | n655;
  /*# m6522.vhd:685:10 */
  assign n658 = n666 ? 1'b1 : t1_int_enable;
  /*# m6522.vhd:692:22 */
  assign n660 = phase == 2'b11;
  /*# m6522.vhd:693:51 */
  assign n662 = t1c - 16'b0000000000000001;
  /*# m6522.vhd:692:10 */
  assign n663 = n660 ? n662 : t1c;
  /*# m6522.vhd:685:10 */
  assign n664 = {r_t1l_h, r_t1l_l};
  /*# m6522.vhd:685:10 */
  assign n665 = n656 ? n664 : n663;
  /*# m6522.vhd:685:10 */
  assign n666 = t1_load_counter & n656;
  /*# m6522.vhd:696:29 */
  assign n667 = t1_load_counter | t1_reload_counter;
  /*# m6522.vhd:698:10 */
  assign n669 = t1c_done ? 1'b0 : t1c_active;
  /*# m6522.vhd:696:10 */
  assign n671 = n667 ? 1'b1 : n669;
  /*# m6522.vhd:703:24 */
  assign n672 = t1c_done & t1c_active;
  /*# m6522.vhd:707:25 */
  assign n673 = r_acr[6]; // extract
  /*# m6522.vhd:707:29 */
  assign n674 = ~n673;
  /*# m6522.vhd:703:10 */
  assign n676 = n688 ? 1'b0 : n658;
  /*# m6522.vhd:704:13 */
  assign n677 = n674 & t1_int_enable;
  /*# m6522.vhd:704:13 */
  assign n680 = t1_int_enable ? 1'b1 : 1'b0;
  /*# m6522.vhd:704:13 */
  assign n682 = t1_int_enable ? 1'b1 : t1_irq;
  /*# m6522.vhd:711:31 */
  assign n683 = t1_w_reset_int | t1_r_reset_int;
  /*# m6522.vhd:711:62 */
  assign n684 = clear_irq[6]; // extract
  /*# m6522.vhd:711:49 */
  assign n685 = n683 | n684;
  /*# m6522.vhd:711:10 */
  assign n687 = n685 ? 1'b0 : t1_irq;
  /*# m6522.vhd:703:10 */
  assign n688 = n677 & n672;
  /*# m6522.vhd:703:10 */
  assign n690 = n672 ? n680 : 1'b0;
  /*# m6522.vhd:703:10 */
  assign n692 = n672 ? n682 : n687;
  /*# m6522.vhd:714:10 */
  assign n694 = t1_load_counter ? 1'b0 : n692;
  /*# m6522.vhd:728:20 */
  assign n709 = phase == 2'b01;
  /*# m6522.vhd:729:30 */
  assign n710 = I_PB[6]; // extract
  /*# m6522.vhd:727:7 */
  assign n713 = n709 & ENA_4;
  /*# m6522.vhd:727:7 */
  assign n714 = n709 & ENA_4;
  /*# m6522.vhd:740:22 */
  assign n720 = ~p2_h_t1;
  /*# m6522.vhd:740:29 */
  assign n721 = I_P2_H & n720;
  /*# m6522.vhd:741:22 */
  assign n722 = r_acr[5]; // extract
  /*# m6522.vhd:741:26 */
  assign n723 = ~n722;
  /*# m6522.vhd:741:14 */
  assign n726 = n723 ? 1'b1 : 1'b0;
  /*# m6522.vhd:739:7 */
  assign n728 = n721 & ENA_4;
  /*# m6522.vhd:756:23 */
  assign n736 = t2c == 16'b0000000000000000;
  /*# m6522.vhd:757:25 */
  assign n737 = t2c[7:0]; // extract
  /*# m6522.vhd:757:38 */
  assign n739 = n737 == 8'b00000000;
  /*# m6522.vhd:758:38 */
  assign n741 = phase == 2'b11;
  /*# m6522.vhd:758:27 */
  assign n742 = n741 & n736;
  /*# m6522.vhd:759:20 */
  assign n744 = phase == 2'b11;
  /*# m6522.vhd:762:10 */
  assign n747 = t2_load_counter ? 1'b0 : n742;
  /*# m6522.vhd:755:7 */
  assign n749 = n744 & ENA_4;
  /*# m6522.vhd:781:50 */
  assign n760 = ~t2_pb6;
  /*# m6522.vhd:781:38 */
  assign n761 = n760 & t2_pb6_t1;
  /*# m6522.vhd:773:10 */
  assign n763 = t2_cnt_clk ? 1'b1 : n761;
  /*# m6522.vhd:785:41 */
  assign n765 = phase == 2'b11;
  /*# m6522.vhd:785:31 */
  assign n766 = n765 & t2_reload_counter;
  /*# m6522.vhd:785:59 */
  assign n767 = r_acr[4:2]; // extract
  /*# m6522.vhd:785:72 */
  assign n769 = n767 == 3'b001;
  /*# m6522.vhd:785:90 */
  assign n770 = r_acr[4:2]; // extract
  /*# m6522.vhd:785:103 */
  assign n772 = n770 == 3'b100;
  /*# m6522.vhd:785:81 */
  assign n773 = n769 | n772;
  /*# m6522.vhd:785:121 */
  assign n774 = r_acr[4:2]; // extract
  /*# m6522.vhd:785:134 */
  assign n776 = n774 == 3'b101;
  /*# m6522.vhd:785:112 */
  assign n777 = n773 | n776;
  /*# m6522.vhd:785:48 */
  assign n778 = n777 & n766;
  /*# m6522.vhd:792:22 */
  assign n780 = phase == 2'b11;
  /*# m6522.vhd:792:29 */
  assign n781 = n763 & n780;
  /*# m6522.vhd:793:54 */
  assign n783 = t2c - 16'b0000000000000001;
  /*# m6522.vhd:792:13 */
  assign n784 = n781 ? n783 : t2c;
  /*# m6522.vhd:787:10 */
  assign n785 = {r_t2l_h, r_t2l_l};
  /*# m6522.vhd:787:10 */
  assign n786 = t2_load_counter ? n785 : n784;
  /*# m6522.vhd:787:10 */
  assign n788 = t2_load_counter ? 1'b1 : t2_int_enable;
  /*# m6522.vhd:787:10 */
  assign n789 = n786[7:0]; // extract
  /*# m6522.vhd:785:10 */
  assign n790 = n778 ? r_t2l_l : n789;
  /*# m6522.vhd:787:10 */
  assign n791 = n786[15:8]; // extract
  /*# m6522.vhd:149:11 */
  assign n792 = t2c[15:8]; // extract
  /*# m6522.vhd:785:10 */
  assign n793 = n778 ? n792 : n791;
  /*# m6522.vhd:785:10 */
  assign n794 = n778 ? t2_int_enable : n788;
  /*# m6522.vhd:799:27 */
  assign n795 = t2c[7:0]; // extract
  /*# m6522.vhd:799:40 */
  assign n797 = n795 == 8'b11111111;
  /*# m6522.vhd:799:60 */
  assign n799 = phase == 2'b11;
  /*# m6522.vhd:799:49 */
  assign n800 = n799 & n797;
  /*# m6522.vhd:803:10 */
  assign n802 = t2c_done ? 1'b0 : t2c_active;
  /*# m6522.vhd:801:10 */
  assign n804 = t2_load_counter ? 1'b1 : n802;
  /*# m6522.vhd:807:24 */
  assign n805 = t2c_done & t2c_active;
  /*# m6522.vhd:807:37 */
  assign n806 = t2_int_enable & n805;
  /*# m6522.vhd:810:31 */
  assign n807 = t2_w_reset_int | t2_r_reset_int;
  /*# m6522.vhd:810:62 */
  assign n808 = clear_irq[5]; // extract
  /*# m6522.vhd:810:49 */
  assign n809 = n807 | n808;
  /*# m6522.vhd:810:10 */
  assign n811 = n809 ? 1'b0 : t2_irq;
  /*# m6522.vhd:807:10 */
  assign n813 = n806 ? 1'b0 : n794;
  /*# m6522.vhd:807:10 */
  assign n815 = n806 ? 1'b1 : n811;
  /*# m6522.vhd:813:10 */
  assign n817 = t2_load_counter ? 1'b0 : n815;
  /*# m6522.vhd:772:7 */
  assign n818 = {n793, n790};
  /*# m6522.vhd:825:16 */
  always @*
    p_sr_ena = n1281; // (isignal)
  initial
    p_sr_ena = 1'bX;
  /*# m6522.vhd:832:19 */
  assign n840 = ~RESET_L;
  /*# m6522.vhd:846:30 */
  assign n842 = r_acr[4]; // extract
  /*# m6522.vhd:856:23 */
  assign n843 = r_acr[4:2]; // extract
  /*# m6522.vhd:858:16 */
  assign n845 = n843 == 3'b000;
  /*# m6522.vhd:859:16 */
  assign n847 = n843 == 3'b001;
  /*# m6522.vhd:860:16 */
  assign n849 = n843 == 3'b010;
  /*# m6522.vhd:861:16 */
  assign n851 = n843 == 3'b011;
  /*# m6522.vhd:862:16 */
  assign n853 = n843 == 3'b100;
  /*# m6522.vhd:863:16 */
  assign n855 = n843 == 3'b101;
  /*# m6522.vhd:864:16 */
  assign n857 = n843 == 3'b110;
  /*# m6522.vhd:865:16 */
  assign n859 = n843 == 3'b111;
  /*# m6522.vhd:856:13 */
  assign n860 = {n859, n857, n855, n853, n851, n849, n847, n845};
  /*# m6522.vhd:856:13 */
  always @*
    case (n860)
      8'b10000000: n869 = 1'b1;
      8'b01000000: n869 = 1'b1;
      8'b00100000: n869 = 1'b1;
      8'b00010000: n869 = 1'b1;
      8'b00001000: n869 = 1'b1;
      8'b00000100: n869 = 1'b1;
      8'b00000010: n869 = 1'b1;
      8'b00000001: n869 = 1'b0;
      default: n869 = p_sr_ena;
    endcase
  /*# m6522.vhd:856:13 */
  always @*
    case (n860)
      8'b10000000: n876 = 1'b0;
      8'b01000000: n876 = 1'b1;
      8'b00100000: n876 = 1'b1;
      8'b00010000: n876 = 1'b1;
      8'b00001000: n876 = 1'b0;
      8'b00000100: n876 = 1'b1;
      8'b00000010: n876 = 1'b1;
      8'b00000001: n876 = 1'b0;
      default: n876 = 1'b0;
    endcase
  /*# m6522.vhd:856:13 */
  always @*
    case (n860)
      8'b10000000: n882 = 1'b1;
      8'b01000000: n882 = 1'b0;
      8'b00100000: n882 = 1'b0;
      8'b00010000: n882 = 1'b0;
      8'b00001000: n882 = 1'b1;
      8'b00000100: n882 = 1'b0;
      8'b00000010: n882 = 1'b0;
      8'b00000001: n882 = 1'b1;
      default: n882 = 1'b0;
    endcase
  /*# m6522.vhd:856:13 */
  always @*
    case (n860)
      8'b10000000: n888 = 1'b0;
      8'b01000000: n888 = 1'b0;
      8'b00100000: n888 = 1'b1;
      8'b00010000: n888 = 1'b1;
      8'b00001000: n888 = 1'b0;
      8'b00000100: n888 = 1'b0;
      8'b00000010: n888 = 1'b1;
      8'b00000001: n888 = 1'b0;
      default: n888 = 1'b0;
    endcase
  /*# m6522.vhd:856:13 */
  always @*
    case (n860)
      8'b10000000: n892 = 1'b0;
      8'b01000000: n892 = 1'b0;
      8'b00100000: n892 = 1'b0;
      8'b00010000: n892 = 1'b1;
      8'b00001000: n892 = 1'b0;
      8'b00000100: n892 = 1'b0;
      8'b00000010: n892 = 1'b0;
      8'b00000001: n892 = 1'b0;
      default: n892 = 1'b0;
    endcase
  /*# m6522.vhd:874:26 */
  assign n894 = sr_cnt[3]; // extract
  /*# m6522.vhd:874:30 */
  assign n895 = ~n894;
  /*# m6522.vhd:874:51 */
  assign n896 = ~n892;
  /*# m6522.vhd:874:37 */
  assign n897 = n896 & n895;
  /*# m6522.vhd:877:38 */
  assign n898 = t2_sr_ena & n888;
  /*# m6522.vhd:878:31 */
  assign n899 = ~n888;
  /*# m6522.vhd:878:49 */
  assign n901 = phase == 2'b00;
  /*# m6522.vhd:878:38 */
  assign n902 = n901 & n899;
  /*# m6522.vhd:877:53 */
  assign n903 = n898 | n902;
  /*# m6522.vhd:879:35 */
  assign n904 = ~sr_strobe;
  /*# m6522.vhd:877:19 */
  assign n905 = n903 ? n904 : sr_strobe;
  /*# m6522.vhd:874:16 */
  assign n907 = n897 ? 1'b1 : n905;
  /*# m6522.vhd:871:13 */
  assign n908 = n882 ? I_CB1 : n907;
  /*# m6522.vhd:887:30 */
  assign n909 = r_sr[7]; // extract
  /*# m6522.vhd:891:28 */
  assign n910 = ~n842;
  /*# m6522.vhd:893:29 */
  assign n911 = sr_cnt[3]; // extract
  /*# m6522.vhd:893:40 */
  assign n912 = n911 | n882;
  /*# m6522.vhd:899:40 */
  assign n913 = sr_strobe_falling & sr_do_shift;
  /*# m6522.vhd:901:49 */
  assign n914 = r_sr[6:0]; // extract
  /*# m6522.vhd:120:11 */
  assign n915 = r_sr[7:1]; // extract
  /*# m6522.vhd:899:22 */
  assign n916 = n913 ? n914 : n915;
  /*# m6522.vhd:899:22 */
  assign n918 = n913 ? 1'b0 : sr_do_shift;
  /*# m6522.vhd:120:11 */
  assign n919 = r_sr[0]; // extract
  /*# m6522.vhd:894:22 */
  assign n920 = sr_strobe_rising ? I_CB2 : n919;
  /*# m6522.vhd:120:11 */
  assign n921 = r_sr[7:1]; // extract
  /*# m6522.vhd:894:22 */
  assign n922 = sr_strobe_rising ? n921 : n916;
  /*# m6522.vhd:894:22 */
  assign n924 = sr_strobe_rising ? 1'b1 : n918;
  /*# m6522.vhd:893:19 */
  assign n925 = {n922, n920};
  /*# m6522.vhd:893:19 */
  assign n926 = n912 ? n925 : r_sr;
  /*# m6522.vhd:893:19 */
  assign n927 = n912 ? n924 : sr_do_shift;
  /*# m6522.vhd:906:29 */
  assign n928 = sr_cnt[3]; // extract
  /*# m6522.vhd:906:40 */
  assign n929 = n928 | n882;
  /*# m6522.vhd:906:58 */
  assign n930 = n929 | n892;
  /*# m6522.vhd:908:39 */
  assign n931 = r_sr[7]; // extract
  /*# m6522.vhd:912:40 */
  assign n932 = sr_strobe_rising & sr_do_shift;
  /*# m6522.vhd:914:37 */
  assign n933 = r_sr[6:0]; // extract
  /*# m6522.vhd:914:56 */
  assign n934 = r_sr[7]; // extract
  /*# m6522.vhd:914:50 */
  assign n935 = {n933, n934};
  /*# m6522.vhd:912:22 */
  assign n936 = n932 ? n935 : r_sr;
  /*# m6522.vhd:912:22 */
  assign n938 = n932 ? 1'b0 : sr_do_shift;
  /*# m6522.vhd:907:22 */
  assign n939 = sr_strobe_falling ? r_sr : n936;
  /*# m6522.vhd:907:22 */
  assign n941 = sr_strobe_falling ? 1'b1 : n938;
  /*# m6522.vhd:906:19 */
  assign n942 = n945 ? n931 : sr_out;
  /*# m6522.vhd:906:19 */
  assign n943 = n930 ? n939 : r_sr;
  /*# m6522.vhd:906:19 */
  assign n944 = n930 ? n941 : sr_do_shift;
  /*# m6522.vhd:906:19 */
  assign n945 = sr_strobe_falling & n930;
  /*# m6522.vhd:891:16 */
  assign n946 = n910 ? n926 : n943;
  /*# m6522.vhd:891:16 */
  assign n947 = n910 ? n927 : n944;
  /*# m6522.vhd:891:16 */
  assign n948 = n910 ? sr_out : n942;
  /*# m6522.vhd:885:13 */
  assign n949 = sr_write_ena ? load_data : n946;
  /*# m6522.vhd:885:13 */
  assign n950 = sr_write_ena ? sr_do_shift : n947;
  /*# m6522.vhd:885:13 */
  assign n951 = sr_write_ena ? n909 : n948;
  /*# m6522.vhd:921:39 */
  assign n952 = sr_cnt[3]; // extract
  /*# m6522.vhd:921:28 */
  assign n953 = n952 & n869;
  /*# m6522.vhd:923:42 */
  assign n954 = sr_cnt[3]; // extract
  /*# m6522.vhd:923:46 */
  assign n955 = ~n954;
  /*# m6522.vhd:923:31 */
  assign n956 = n955 & n869;
  /*# m6522.vhd:923:63 */
  assign n958 = phase == 2'b11;
  /*# m6522.vhd:923:53 */
  assign n959 = n958 & n956;
  /*# m6522.vhd:923:13 */
  assign n961 = n959 ? 1'b0 : sr_active;
  /*# m6522.vhd:921:13 */
  assign n963 = n953 ? 1'b1 : n961;
  /*# m6522.vhd:932:46 */
  assign n964 = sr_write_ena | sr_read_ena;
  /*# m6522.vhd:932:28 */
  assign n965 = n964 & n869;
  /*# m6522.vhd:932:67 */
  assign n966 = ~sr_active;
  /*# m6522.vhd:932:62 */
  assign n967 = n966 & n965;
  /*# m6522.vhd:935:43 */
  assign n968 = sr_cnt[3]; // extract
  /*# m6522.vhd:935:32 */
  assign n969 = n968 & sr_strobe_rising;
  /*# m6522.vhd:936:60 */
  assign n971 = sr_cnt + 4'b0001;
  /*# m6522.vhd:935:13 */
  assign n972 = n969 ? n971 : sr_cnt;
  /*# m6522.vhd:932:13 */
  assign n974 = n967 ? 4'b1000 : n972;
  /*# m6522.vhd:939:41 */
  assign n976 = sr_cnt == 4'b1111;
  /*# m6522.vhd:939:29 */
  assign n977 = n976 & sr_strobe_rising;
  /*# m6522.vhd:939:51 */
  assign n978 = n869 & n977;
  /*# m6522.vhd:939:81 */
  assign n979 = ~n892;
  /*# m6522.vhd:939:67 */
  assign n980 = n979 & n978;
  /*# m6522.vhd:941:32 */
  assign n981 = sr_write_ena | sr_read_ena;
  /*# m6522.vhd:941:60 */
  assign n982 = clear_irq[2]; // extract
  /*# m6522.vhd:941:47 */
  assign n983 = n981 | n982;
  /*# m6522.vhd:941:13 */
  assign n985 = n983 ? 1'b0 : sr_irq;
  /*# m6522.vhd:939:13 */
  assign n987 = n980 ? 1'b1 : n985;
  /*# m6522.vhd:947:29 */
  assign n988 = ~n876;
  /*# m6522.vhd:958:45 */
  assign n1053 = ~sr_strobe_t1;
  /*# m6522.vhd:958:52 */
  assign n1054 = sr_strobe & n1053;
  /*# m6522.vhd:959:67 */
  assign n1055 = ~sr_strobe;
  /*# m6522.vhd:959:52 */
  assign n1056 = n1055 & sr_strobe_t1;
  /*# m6522.vhd:969:19 */
  assign n1065 = ~RESET_L;
  /*# m6522.vhd:974:29 */
  assign n1067 = load_data[7]; // extract
  /*# m6522.vhd:976:46 */
  assign n1068 = load_data[6:0]; // extract
  /*# m6522.vhd:976:34 */
  assign n1069 = r_ier | n1068;
  /*# m6522.vhd:979:51 */
  assign n1070 = load_data[6:0]; // extract
  /*# m6522.vhd:979:38 */
  assign n1071 = ~n1070;
  /*# m6522.vhd:979:34 */
  assign n1072 = r_ier & n1071;
  /*# m6522.vhd:974:16 */
  assign n1073 = n1067 ? n1069 : n1072;
  /*# m6522.vhd:972:10 */
  assign n1075 = ier_write_ena & ENA_4;
  /*# m6522.vhd:998:18 */
  assign n1081 = ~final_irq;
  /*# m6522.vhd:1003:19 */
  assign n1084 = ~RESET_L;
  /*# m6522.vhd:1007:23 */
  assign n1086 = r_ifr[6:0]; // extract
  /*# m6522.vhd:1007:36 */
  assign n1087 = n1086 & r_ier;
  /*# m6522.vhd:1007:59 */
  assign n1089 = n1087 == 7'b0000000;
  /*# m6522.vhd:1007:13 */
  assign n1092 = n1089 ? 1'b0 : 1'b1;
  /*# m6522.vhd:1019:7 */
  assign n1100 = ifr_write_ena ? load_data : 8'b00000000;
  /*# m6522.vhd:123:11 */
  assign n1103 = {final_irq, t1_irq, t2_irq, cb1_irq, cb2_irq, sr_irq, ca1_irq, ca2_irq};
  /*# m6522.vhd:477:7 */
  assign n1104 = ENA_4 ? n435 : n1105;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1105 <= 1'b1;
    else
      n1105 <= n1104;
  /*# m6522.vhd:477:7 */
  assign n1106 = ENA_4 ? n412 : n1107;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1107 <= 1'b1;
    else
      n1107 <= n1106;
  /*# m6522.vhd:477:7 */
  assign n1108 = ENA_4 ? n472 : n1109;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1109 <= 1'b1;
    else
      n1109 <= n1108;
  /*# m6522.vhd:477:7 */
  assign n1110 = ENA_4 ? n448 : n1111;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1111 <= 1'b1;
    else
      n1111 <= n1110;
  /*# m6522.vhd:213:7 */
  assign n1112 = ENA_4 ? n30 : phase;
  /*# m6522.vhd:213:7 */
  always @(posedge CLK)
    n1113 <= n1112;
  initial
    n1113 = 2'b00;
  /*# m6522.vhd:213:7 */
  assign n1114 = ENA_4 ? I_P2_H : p2_h_t1;
  /*# m6522.vhd:213:7 */
  always @(posedge CLK)
    n1115 <= n1114;
  /*# m6522.vhd:274:7 */
  assign n1116 = n97 ? n65 : r_ddra;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1117 <= 8'b00000000;
    else
      n1117 <= n1116;
  /*# m6522.vhd:274:7 */
  assign n1118 = n98 ? n66 : r_ora;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1119 <= 8'b00000000;
    else
      n1119 <= n1118;
  /*# m6522.vhd:598:7 */
  assign n1120 = ENA_4 ? n566 : r_ira;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1121 <= 8'b00000000;
    else
      n1121 <= n1120;
  /*# m6522.vhd:274:7 */
  assign n1122 = n99 ? n67 : r_ddrb;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1123 <= 8'b00000000;
    else
      n1123 <= n1122;
  /*# m6522.vhd:274:7 */
  assign n1124 = n100 ? n68 : r_orb;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1125 <= 8'b00000000;
    else
      n1125 <= n1124;
  /*# m6522.vhd:598:7 */
  assign n1126 = ENA_4 ? n570 : r_irb;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1127 <= 8'b00000000;
    else
      n1127 <= n1126;
  /*# m6522.vhd:317:7 */
  assign n1128 = n211 ? n157 : r_t1l_l;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK or posedge n134)
    if (n134)
      n1129 <= 8'b11111111;
    else
      n1129 <= n1128;
  /*# m6522.vhd:317:7 */
  assign n1130 = n212 ? n158 : r_t1l_h;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK or posedge n134)
    if (n134)
      n1131 <= 8'b11111111;
    else
      n1131 <= n1130;
  /*# m6522.vhd:317:7 */
  assign n1132 = n213 ? n159 : r_t2l_l;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK or posedge n134)
    if (n134)
      n1133 <= 8'b11111111;
    else
      n1133 <= n1132;
  /*# m6522.vhd:317:7 */
  assign n1134 = n214 ? n160 : r_t2l_h;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK or posedge n134)
    if (n134)
      n1135 <= 8'b11111111;
    else
      n1135 <= n1134;
  /*# m6522.vhd:843:7 */
  assign n1136 = ENA_4 ? n949 : r_sr;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1137 <= 8'b00000000;
    else
      n1137 <= n1136;
  /*# m6522.vhd:274:7 */
  assign n1138 = n101 ? n69 : r_acr;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1139 <= 8'b00000000;
    else
      n1139 <= n1138;
  /*# m6522.vhd:274:7 */
  assign n1140 = n102 ? n70 : r_pcr;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1141 <= 8'b00000000;
    else
      n1141 <= n1140;
  /*# m6522.vhd:971:7 */
  assign n1142 = n1075 ? n1073 : r_ier;
  /*# m6522.vhd:971:7 */
  always @(posedge CLK or posedge n1065)
    if (n1065)
      n1143 <= 7'b0000000;
    else
      n1143 <= n1142;
  /*# m6522.vhd:126:11 */
  assign n1144 = ~n134;
  /*# m6522.vhd:126:11 */
  assign n1145 = ENA_4 & n1144;
  /*# m6522.vhd:317:7 */
  assign n1146 = n1145 ? n188 : sr_write_ena;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1147 <= n1146;
  /*# m6522.vhd:128:11 */
  assign n1148 = ~n134;
  /*# m6522.vhd:128:11 */
  assign n1149 = ENA_4 & n1148;
  /*# m6522.vhd:317:7 */
  assign n1150 = n1149 ? n191 : ifr_write_ena;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1151 <= n1150;
  /*# m6522.vhd:129:11 */
  assign n1152 = ~n134;
  /*# m6522.vhd:129:11 */
  assign n1153 = ENA_4 & n1152;
  /*# m6522.vhd:317:7 */
  assign n1154 = n1153 ? n194 : ier_write_ena;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1155 <= n1154;
  /*# m6522.vhd:131:11 */
  assign n1156 = ~n134;
  /*# m6522.vhd:131:11 */
  assign n1157 = ENA_4 & n1156;
  /*# m6522.vhd:317:7 */
  assign n1158 = n1157 ? n197 : load_data;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1159 <= n1158;
  /*# m6522.vhd:683:7 */
  assign n1160 = ENA_4 ? n665 : t1c;
  /*# m6522.vhd:683:7 */
  always @(posedge CLK)
    n1161 <= n1160;
  initial
    n1161 = 16'b1111111111111111;
  /*# m6522.vhd:683:7 */
  assign n1162 = ENA_4 ? n671 : t1c_active;
  /*# m6522.vhd:683:7 */
  always @(posedge CLK)
    n1163 <= n1162;
  /*# m6522.vhd:666:7 */
  assign n1164 = ENA_4 ? n643 : t1c_done;
  /*# m6522.vhd:666:7 */
  always @(posedge CLK)
    n1165 <= n1164;
  /*# m6522.vhd:137:11 */
  assign n1166 = ~n134;
  /*# m6522.vhd:137:11 */
  assign n1167 = ENA_4 & n1166;
  /*# m6522.vhd:317:7 */
  assign n1168 = n1167 ? n200 : t1_w_reset_int;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1169 <= n1168;
  /*# m6522.vhd:139:11 */
  assign n1170 = ~n134;
  /*# m6522.vhd:139:11 */
  assign n1171 = ENA_4 & n1170;
  /*# m6522.vhd:317:7 */
  assign n1172 = n1171 ? n203 : t1_load_counter;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1173 <= n1172;
  /*# m6522.vhd:666:7 */
  assign n1174 = ENA_4 ? n641 : t1_reload_counter;
  /*# m6522.vhd:666:7 */
  always @(posedge CLK)
    n1175 <= n1174;
  /*# m6522.vhd:683:7 */
  assign n1176 = ENA_4 ? n676 : t1_int_enable;
  /*# m6522.vhd:683:7 */
  always @(posedge CLK)
    n1177 <= n1176;
  initial
    n1177 = 1'b0;
  /*# m6522.vhd:683:7 */
  assign n1178 = ENA_4 ? n690 : t1_toggle;
  /*# m6522.vhd:683:7 */
  always @(posedge CLK)
    n1179 <= n1178;
  /*# m6522.vhd:683:7 */
  assign n1180 = ENA_4 ? n694 : t1_irq;
  /*# m6522.vhd:683:7 */
  always @(posedge CLK)
    n1181 <= n1180;
  initial
    n1181 = 1'b0;
  /*# m6522.vhd:144:11 */
  assign n1182 = ~n46;
  /*# m6522.vhd:144:11 */
  assign n1183 = ENA_4 & n1182;
  /*# m6522.vhd:274:7 */
  assign n1184 = n1183 ? n96 : t1_pb7;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK)
    n1185 <= n1184;
  initial
    n1185 = 1'b1;
  /*# m6522.vhd:656:7 */
  assign n1186 = ENA_4 ? n621 : t1_pb7_en_c;
  /*# m6522.vhd:656:7 */
  always @(posedge CLK)
    n1187 <= n1186;
  /*# m6522.vhd:656:7 */
  assign n1188 = ENA_4 ? t1_pb7_en_c : t1_pb7_en_d;
  /*# m6522.vhd:656:7 */
  always @(posedge CLK)
    n1189 <= n1188;
  /*# m6522.vhd:771:7 */
  assign n1190 = ENA_4 ? n818 : t2c;
  /*# m6522.vhd:771:7 */
  always @(posedge CLK)
    n1191 <= n1190;
  initial
    n1191 = 16'b1111111111111111;
  /*# m6522.vhd:771:7 */
  assign n1192 = ENA_4 ? n804 : t2c_active;
  /*# m6522.vhd:771:7 */
  always @(posedge CLK)
    n1193 <= n1192;
  /*# m6522.vhd:754:7 */
  assign n1194 = ENA_4 ? n747 : t2c_done;
  /*# m6522.vhd:754:7 */
  always @(posedge CLK)
    n1195 <= n1194;
  /*# m6522.vhd:726:7 */
  assign n1196 = n713 ? n710 : t2_pb6;
  /*# m6522.vhd:726:7 */
  always @(posedge CLK)
    n1197 <= n1196;
  /*# m6522.vhd:726:7 */
  assign n1198 = n714 ? t2_pb6 : t2_pb6_t1;
  /*# m6522.vhd:726:7 */
  always @(posedge CLK)
    n1199 <= n1198;
  /*# m6522.vhd:738:7 */
  assign n1200 = n728 ? n726 : t2_cnt_clk;
  /*# m6522.vhd:738:7 */
  always @(posedge CLK)
    n1201 <= n1200;
  initial
    n1201 = 1'b1;
  /*# m6522.vhd:155:11 */
  assign n1202 = ~n134;
  /*# m6522.vhd:155:11 */
  assign n1203 = ENA_4 & n1202;
  /*# m6522.vhd:317:7 */
  assign n1204 = n1203 ? n206 : t2_w_reset_int;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1205 <= n1204;
  /*# m6522.vhd:157:11 */
  assign n1206 = ~n134;
  /*# m6522.vhd:157:11 */
  assign n1207 = ENA_4 & n1206;
  /*# m6522.vhd:317:7 */
  assign n1208 = n1207 ? n209 : t2_load_counter;
  /*# m6522.vhd:317:7 */
  always @(posedge CLK)
    n1209 <= n1208;
  /*# m6522.vhd:754:7 */
  assign n1210 = n749 ? n739 : t2_reload_counter;
  /*# m6522.vhd:754:7 */
  always @(posedge CLK)
    n1211 <= n1210;
  /*# m6522.vhd:771:7 */
  assign n1212 = ENA_4 ? n813 : t2_int_enable;
  /*# m6522.vhd:771:7 */
  always @(posedge CLK)
    n1213 <= n1212;
  initial
    n1213 = 1'b0;
  /*# m6522.vhd:771:7 */
  assign n1214 = ENA_4 ? n817 : t2_irq;
  /*# m6522.vhd:771:7 */
  always @(posedge CLK)
    n1215 <= n1214;
  initial
    n1215 = 1'b0;
  /*# m6522.vhd:771:7 */
  assign n1216 = ENA_4 ? n800 : t2_sr_ena;
  /*# m6522.vhd:771:7 */
  always @(posedge CLK)
    n1217 <= n1216;
  /*# m6522.vhd:843:7 */
  assign n1218 = ENA_4 ? n974 : sr_cnt;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1219 <= 4'b0000;
    else
      n1219 <= n1218;
  /*# m6522.vhd:843:7 */
  assign n1220 = ENA_4 ? n988 : sr_cb1_oe_l;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1221 <= 1'b1;
    else
      n1221 <= n1220;
  /*# m6522.vhd:843:7 */
  assign n1222 = ENA_4 ? sr_strobe : sr_cb1_out;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1223 <= 1'b0;
    else
      n1223 <= n1222;
  /*# m6522.vhd:843:7 */
  assign n1224 = ENA_4 ? n842 : sr_drive_cb2;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1225 <= 1'b0;
    else
      n1225 <= n1224;
  /*# m6522.vhd:843:7 */
  assign n1226 = ENA_4 ? n908 : sr_strobe;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1227 <= 1'b1;
    else
      n1227 <= n1226;
  /*# m6522.vhd:843:7 */
  assign n1228 = ENA_4 ? n950 : sr_do_shift;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1229 <= 1'b0;
    else
      n1229 <= n1228;
  /*# m6522.vhd:955:7 */
  assign n1230 = ENA_4 ? sr_strobe : sr_strobe_t1;
  /*# m6522.vhd:955:7 */
  always @(posedge CLK)
    n1231 <= n1230;
  /*# m6522.vhd:955:7 */
  assign n1232 = ENA_4 ? n1056 : sr_strobe_falling;
  /*# m6522.vhd:955:7 */
  always @(posedge CLK)
    n1233 <= n1232;
  /*# m6522.vhd:955:7 */
  assign n1234 = ENA_4 ? n1054 : sr_strobe_rising;
  /*# m6522.vhd:955:7 */
  always @(posedge CLK)
    n1235 <= n1234;
  /*# m6522.vhd:843:7 */
  assign n1236 = ENA_4 ? n987 : sr_irq;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1237 <= 1'b0;
    else
      n1237 <= n1236;
  /*# m6522.vhd:843:7 */
  assign n1238 = ENA_4 ? n951 : sr_out;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1239 <= 1'b0;
    else
      n1239 <= n1238;
  /*# m6522.vhd:843:7 */
  assign n1240 = ENA_4 ? n963 : sr_active;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK or posedge n840)
    if (n840)
      n1241 <= 1'b0;
    else
      n1241 <= n1240;
  /*# m6522.vhd:274:7 */
  assign n1242 = ENA_4 ? n84 : w_orb_hs;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1243 <= 1'b0;
    else
      n1243 <= n1242;
  /*# m6522.vhd:274:7 */
  assign n1244 = ENA_4 ? n87 : w_ora_hs;
  /*# m6522.vhd:274:7 */
  always @(posedge CLK or posedge n46)
    if (n46)
      n1245 <= 1'b0;
    else
      n1245 <= n1244;
  /*# m6522.vhd:477:7 */
  assign n1246 = ENA_4 ? n406 : ca_hs_sr;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1247 <= 1'b0;
    else
      n1247 <= n1246;
  /*# m6522.vhd:477:7 */
  assign n1248 = n478 ? n409 : ca_hs_pulse;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1249 <= 1'b0;
    else
      n1249 <= n1248;
  /*# m6522.vhd:477:7 */
  assign n1250 = ENA_4 ? n442 : cb_hs_sr;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1251 <= 1'b0;
    else
      n1251 <= n1250;
  /*# m6522.vhd:477:7 */
  assign n1252 = n480 ? w_orb_hs : cb_hs_pulse;
  /*# m6522.vhd:477:7 */
  always @(posedge CLK or posedge n397)
    if (n397)
      n1253 <= 1'b0;
    else
      n1253 <= n1252;
  /*# m6522.vhd:598:7 */
  assign n1254 = ENA_4 ? I_CA1 : ca1_ip_reg_c;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1255 <= 1'b0;
    else
      n1255 <= n1254;
  /*# m6522.vhd:598:7 */
  assign n1256 = ENA_4 ? cb1_in_mux : cb1_ip_reg_c;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1257 <= 1'b0;
    else
      n1257 <= n1256;
  /*# m6522.vhd:598:7 */
  assign n1258 = ENA_4 ? cb1_ip_reg_c : cb1_ip_reg_d;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1259 <= 1'b0;
    else
      n1259 <= n1258;
  /*# m6522.vhd:544:7 */
  assign n1260 = ENA_4 ? n515 : ca1_irq;
  /*# m6522.vhd:544:7 */
  always @(posedge CLK or posedge n507)
    if (n507)
      n1261 <= 1'b0;
    else
      n1261 <= n1260;
  /*# m6522.vhd:544:7 */
  assign n1262 = ENA_4 ? n532 : cb1_irq;
  /*# m6522.vhd:544:7 */
  always @(posedge CLK or posedge n507)
    if (n507)
      n1263 <= 1'b0;
    else
      n1263 <= n1262;
  /*# m6522.vhd:598:7 */
  assign n1264 = ENA_4 ? I_CA2 : ca2_ip_reg_c;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1265 <= 1'b0;
    else
      n1265 <= n1264;
  /*# m6522.vhd:598:7 */
  assign n1266 = ENA_4 ? ca2_ip_reg_c : ca2_ip_reg_d;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1267 <= 1'b0;
    else
      n1267 <= n1266;
  /*# m6522.vhd:598:7 */
  assign n1268 = ENA_4 ? I_CB2 : cb2_ip_reg_c;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1269 <= 1'b0;
    else
      n1269 <= n1268;
  /*# m6522.vhd:598:7 */
  assign n1270 = ENA_4 ? cb2_ip_reg_c : cb2_ip_reg_d;
  /*# m6522.vhd:598:7 */
  always @(posedge CLK or posedge n561)
    if (n561)
      n1271 <= 1'b0;
    else
      n1271 <= n1270;
  /*# m6522.vhd:544:7 */
  assign n1272 = ENA_4 ? n525 : ca2_irq;
  /*# m6522.vhd:544:7 */
  always @(posedge CLK or posedge n507)
    if (n507)
      n1273 <= 1'b0;
    else
      n1273 <= n1272;
  /*# m6522.vhd:544:7 */
  assign n1274 = ENA_4 ? n542 : cb2_irq;
  /*# m6522.vhd:544:7 */
  always @(posedge CLK or posedge n507)
    if (n507)
      n1275 <= 1'b0;
    else
      n1275 <= n1274;
  /*# m6522.vhd:1005:7 */
  assign n1276 = ENA_4 ? n1092 : final_irq;
  /*# m6522.vhd:1005:7 */
  always @(posedge CLK or posedge n1084)
    if (n1084)
      n1277 <= 1'b0;
    else
      n1277 <= n1276;
  /*# m6522.vhd:825:16 */
  assign n1278 = ~n840;
  /*# m6522.vhd:825:16 */
  assign n1279 = ENA_4 & n1278;
  /*# m6522.vhd:843:7 */
  assign n1280 = n1279 ? n869 : p_sr_ena;
  /*# m6522.vhd:843:7 */
  always @(posedge CLK)
    n1281 <= n1280;
endmodule


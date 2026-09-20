module t65_alu_Brtl
  (input  [1:0] mode,
   input  [4:0] op,
   input  [7:0] busa,
   input  [7:0] busb,
   input  [7:0] p_in,
   output [7:0] p_out,
   output [7:0] q);
  wire adc_z;
  wire adc_c;
  wire adc_v;
  wire adc_n;
  wire [7:0] adc_q;
  wire sbc_z;
  wire sbc_c;
  wire sbc_v;
  wire sbc_n;
  wire [7:0] sbc_q;
  wire [7:0] sbx_q;
  wire [3:0] n3110;
  wire n3111;
  wire [4:0] n3112;
  wire [6:0] n3113;
  wire [3:0] n3114;
  wire [4:0] n3116;
  wire [6:0] n3117;
  wire [6:0] n3118;
  wire [3:0] n3119;
  wire n3120;
  wire [4:0] n3121;
  wire [6:0] n3122;
  wire [3:0] n3123;
  wire [4:0] n3125;
  wire [6:0] n3126;
  wire [6:0] n3127;
  wire [3:0] n3128;
  wire n3130;
  wire [3:0] n3131;
  wire n3133;
  wire n3134;
  wire n3137;
  wire [4:0] n3138;
  wire n3140;
  wire n3141;
  wire n3142;
  wire [5:0] n3143;
  wire [5:0] n3145;
  wire [5:0] n3146;
  wire [5:0] n3147;
  wire n3148;
  wire [6:0] n3149;
  wire n3150;
  wire [6:0] n3151;
  wire n3152;
  wire n3153;
  wire [3:0] n3154;
  wire [4:0] n3155;
  wire [6:0] n3156;
  wire [3:0] n3157;
  wire [4:0] n3159;
  wire [6:0] n3160;
  wire [6:0] n3161;
  wire n3162;
  wire n3163;
  wire n3164;
  wire n3165;
  wire n3166;
  wire n3167;
  wire n3168;
  wire n3169;
  wire n3170;
  wire [4:0] n3171;
  wire n3173;
  wire n3174;
  wire n3175;
  wire [5:0] n3176;
  wire [5:0] n3178;
  wire [5:0] n3179;
  wire [5:0] n3180;
  wire n3181;
  wire [6:0] n3182;
  wire n3183;
  wire [6:0] n3184;
  wire n3185;
  wire n3186;
  wire [6:0] n3187;
  wire [3:0] n3188;
  wire [6:0] n3189;
  wire [3:0] n3190;
  wire [7:0] n3191;
  wire n3202;
  wire n3204;
  wire n3205;
  wire n3207;
  wire n3208;
  wire n3210;
  wire n3211;
  wire n3213;
  wire n3214;
  wire n3216;
  wire n3217;
  wire n3219;
  wire n3220;
  wire n3223;
  wire n3225;
  wire n3226;
  wire n3227;
  wire [3:0] n3228;
  wire [4:0] n3229;
  wire [6:0] n3230;
  wire [3:0] n3231;
  wire [4:0] n3233;
  wire [5:0] n3234;
  wire [6:0] n3235;
  wire [6:0] n3236;
  wire [3:0] n3237;
  wire [4:0] n3239;
  wire [5:0] n3240;
  wire [3:0] n3241;
  wire n3242;
  wire [4:0] n3243;
  wire [5:0] n3244;
  wire [5:0] n3245;
  wire [3:0] n3246;
  wire n3248;
  wire [3:0] n3249;
  wire n3251;
  wire n3252;
  wire n3255;
  wire n3256;
  wire n3257;
  wire n3258;
  wire n3259;
  wire n3260;
  wire n3261;
  wire n3262;
  wire n3263;
  wire n3264;
  wire n3265;
  wire [3:0] n3266;
  wire [3:0] n3267;
  wire [7:0] n3268;
  wire n3269;
  wire n3270;
  wire [4:0] n3271;
  wire [4:0] n3273;
  wire [4:0] n3274;
  wire [4:0] n3275;
  wire [3:0] n3276;
  wire [4:0] n3278;
  wire [5:0] n3279;
  wire [3:0] n3280;
  wire n3281;
  wire n3282;
  wire [6:0] n3283;
  wire n3284;
  wire [4:0] n3285;
  wire [5:0] n3286;
  wire [5:0] n3287;
  wire n3288;
  wire [4:0] n3289;
  wire [4:0] n3291;
  wire [4:0] n3292;
  wire [4:0] n3293;
  wire n3294;
  wire [4:0] n3295;
  wire [4:0] n3296;
  wire n3297;
  wire n3298;
  wire [5:0] n3299;
  wire [5:0] n3300;
  wire [3:0] n3301;
  wire [6:0] n3302;
  wire [3:0] n3303;
  wire [7:0] n3304;
  wire [7:0] n3311;
  wire n3313;
  wire [7:0] n3314;
  wire n3316;
  wire [7:0] n3317;
  wire n3319;
  wire n3321;
  wire n3323;
  wire n3325;
  wire n3327;
  wire [6:0] n3328;
  wire [7:0] n3330;
  wire n3331;
  wire n3333;
  wire [6:0] n3334;
  wire n3335;
  wire [7:0] n3336;
  wire n3337;
  wire n3339;
  wire [6:0] n3340;
  wire [7:0] n3342;
  wire n3343;
  wire n3345;
  wire n3346;
  wire [6:0] n3347;
  wire [7:0] n3348;
  wire n3349;
  wire n3351;
  wire n3352;
  wire [6:0] n3353;
  wire [6:0] n3354;
  wire [6:0] n3355;
  wire [7:0] n3356;
  wire n3357;
  wire n3358;
  wire n3359;
  wire n3360;
  wire [3:0] n3361;
  wire [3:0] n3362;
  wire [3:0] n3363;
  wire n3365;
  wire [3:0] n3366;
  wire [3:0] n3368;
  wire [3:0] n3369;
  wire [3:0] n3370;
  wire [3:0] n3371;
  wire [3:0] n3372;
  wire [3:0] n3373;
  wire n3375;
  wire [3:0] n3376;
  wire [3:0] n3378;
  wire n3381;
  wire [3:0] n3382;
  wire [3:0] n3383;
  wire n3384;
  wire n3385;
  wire [7:0] n3386;
  wire [7:0] n3387;
  wire n3389;
  wire n3390;
  wire n3392;
  wire [7:0] n3394;
  wire n3396;
  wire [7:0] n3398;
  wire n3400;
  wire [14:0] n3401;
  wire n3402;
  reg n3403;
  wire n3404;
  reg n3405;
  wire n3407;
  reg [7:0] n3409;
  reg [7:0] n3410;
  wire n3412;
  wire n3414;
  wire n3416;
  wire n3417;
  wire n3419;
  wire n3420;
  wire n3422;
  wire n3423;
  wire [7:0] n3424;
  wire n3426;
  wire n3429;
  wire n3431;
  wire n3432;
  wire n3433;
  wire n3435;
  wire n3438;
  wire n3440;
  wire n3441;
  wire n3443;
  wire n3446;
  wire [4:0] n3447;
  reg n3448;
  wire n3449;
  reg n3450;
  reg n3451;
  wire [3:0] n3452;
  wire n3454;
  wire [7:0] n3455;
  wire [7:0] n3457;
  assign p_out = n3457; //(module output)
  assign q = n3455; //(module output)
  /*# T65_ALU.vhd:72:15 */
  assign adc_z = n3137; // (signal)
  /*# T65_ALU.vhd:73:15 */
  assign adc_c = n3186; // (signal)
  /*# T65_ALU.vhd:74:15 */
  assign adc_v = n3170; // (signal)
  /*# T65_ALU.vhd:75:15 */
  assign adc_n = n3162; // (signal)
  /*# T65_ALU.vhd:76:15 */
  assign adc_q = n3191; // (signal)
  /*# T65_ALU.vhd:77:15 */
  assign sbc_z = n3255; // (signal)
  /*# T65_ALU.vhd:78:15 */
  assign sbc_c = n3257; // (signal)
  /*# T65_ALU.vhd:79:15 */
  assign sbc_v = n3264; // (signal)
  /*# T65_ALU.vhd:80:15 */
  assign sbc_n = n3265; // (signal)
  /*# T65_ALU.vhd:81:15 */
  assign sbc_q = n3304; // (signal)
  /*# T65_ALU.vhd:82:15 */
  assign sbx_q = n3268; // (signal)
  /*# T65_ALU.vhd:91:31 */
  assign n3110 = busa[3:0]; // extract
  /*# T65_ALU.vhd:91:50 */
  assign n3111 = p_in[0]; // extract
  /*# T65_ALU.vhd:91:44 */
  assign n3112 = {n3110, n3111};
  /*# T65_ALU.vhd:91:11 */
  assign n3113 = {2'b0, n3112};  // uext
  /*# T65_ALU.vhd:91:86 */
  assign n3114 = busb[3:0]; // extract
  /*# T65_ALU.vhd:91:99 */
  assign n3116 = {n3114, 1'b1};
  /*# T65_ALU.vhd:91:66 */
  assign n3117 = {2'b0, n3116};  // uext
  /*# T65_ALU.vhd:91:64 */
  assign n3118 = n3113 + n3117;
  /*# T65_ALU.vhd:92:31 */
  assign n3119 = busa[7:4]; // extract
  /*# T65_ALU.vhd:92:48 */
  assign n3120 = n3118[5]; // extract
  /*# T65_ALU.vhd:92:44 */
  assign n3121 = {n3119, n3120};
  /*# T65_ALU.vhd:92:11 */
  assign n3122 = {2'b0, n3121};  // uext
  /*# T65_ALU.vhd:92:79 */
  assign n3123 = busb[7:4]; // extract
  /*# T65_ALU.vhd:92:92 */
  assign n3125 = {n3123, 1'b1};
  /*# T65_ALU.vhd:92:59 */
  assign n3126 = {2'b0, n3125};  // uext
  /*# T65_ALU.vhd:92:57 */
  assign n3127 = n3122 + n3126;
  /*# T65_ALU.vhd:99:10 */
  assign n3128 = n3118[4:1]; // extract
  /*# T65_ALU.vhd:99:23 */
  assign n3130 = n3128 == 4'b0000;
  /*# T65_ALU.vhd:99:33 */
  assign n3131 = n3127[4:1]; // extract
  /*# T65_ALU.vhd:99:46 */
  assign n3133 = n3131 == 4'b0000;
  /*# T65_ALU.vhd:99:27 */
  assign n3134 = n3133 & n3130;
  /*# T65_ALU.vhd:99:5 */
  assign n3137 = n3134 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:105:10 */
  assign n3138 = n3118[5:1]; // extract
  /*# T65_ALU.vhd:105:23 */
  assign n3140 = $unsigned(n3138) > $unsigned(5'b01001);
  /*# T65_ALU.vhd:105:35 */
  assign n3141 = p_in[3]; // extract
  /*# T65_ALU.vhd:105:27 */
  assign n3142 = n3141 & n3140;
  /*# T65_ALU.vhd:106:27 */
  assign n3143 = n3118[6:1]; // extract
  /*# T65_ALU.vhd:106:40 */
  assign n3145 = n3143 + 6'b000110;
  /*# T65_ALU.vhd:87:14 */
  assign n3146 = n3118[6:1]; // extract
  /*# T65_ALU.vhd:105:5 */
  assign n3147 = n3142 ? n3145 : n3146;
  /*# T65_ALU.vhd:87:14 */
  assign n3148 = n3118[0]; // extract
  /*# T65_ALU.vhd:87:14 */
  assign n3149 = {n3147, n3148};
  /*# T65_ALU.vhd:109:12 */
  assign n3150 = n3149[6]; // extract
  /*# T65_ALU.vhd:87:14 */
  assign n3151 = {n3147, n3148};
  /*# T65_ALU.vhd:109:21 */
  assign n3152 = n3151[5]; // extract
  /*# T65_ALU.vhd:109:16 */
  assign n3153 = n3150 | n3152;
  /*# T65_ALU.vhd:110:31 */
  assign n3154 = busa[7:4]; // extract
  /*# T65_ALU.vhd:110:44 */
  assign n3155 = {n3154, n3153};
  /*# T65_ALU.vhd:110:11 */
  assign n3156 = {2'b0, n3155};  // uext
  /*# T65_ALU.vhd:110:75 */
  assign n3157 = busb[7:4]; // extract
  /*# T65_ALU.vhd:110:88 */
  assign n3159 = {n3157, 1'b1};
  /*# T65_ALU.vhd:110:55 */
  assign n3160 = {2'b0, n3159};  // uext
  /*# T65_ALU.vhd:110:53 */
  assign n3161 = n3156 + n3160;
  /*# T65_ALU.vhd:112:16 */
  assign n3162 = n3161[4]; // extract
  /*# T65_ALU.vhd:113:17 */
  assign n3163 = n3161[4]; // extract
  /*# T65_ALU.vhd:113:29 */
  assign n3164 = busa[7]; // extract
  /*# T65_ALU.vhd:113:21 */
  assign n3165 = n3163 ^ n3164;
  /*# T65_ALU.vhd:113:47 */
  assign n3166 = busa[7]; // extract
  /*# T65_ALU.vhd:113:59 */
  assign n3167 = busb[7]; // extract
  /*# T65_ALU.vhd:113:51 */
  assign n3168 = n3166 ^ n3167;
  /*# T65_ALU.vhd:113:38 */
  assign n3169 = ~n3168;
  /*# T65_ALU.vhd:113:34 */
  assign n3170 = n3165 & n3169;
  /*# T65_ALU.vhd:119:10 */
  assign n3171 = n3161[5:1]; // extract
  /*# T65_ALU.vhd:119:23 */
  assign n3173 = $unsigned(n3171) > $unsigned(5'b01001);
  /*# T65_ALU.vhd:119:35 */
  assign n3174 = p_in[3]; // extract
  /*# T65_ALU.vhd:119:27 */
  assign n3175 = n3174 & n3173;
  /*# T65_ALU.vhd:120:27 */
  assign n3176 = n3161[6:1]; // extract
  /*# T65_ALU.vhd:120:40 */
  assign n3178 = n3176 + 6'b000110;
  /*# T65_ALU.vhd:88:14 */
  assign n3179 = n3161[6:1]; // extract
  /*# T65_ALU.vhd:119:5 */
  assign n3180 = n3175 ? n3178 : n3179;
  /*# T65_ALU.vhd:88:14 */
  assign n3181 = n3161[0]; // extract
  /*# T65_ALU.vhd:88:14 */
  assign n3182 = {n3180, n3181};
  /*# T65_ALU.vhd:123:16 */
  assign n3183 = n3182[6]; // extract
  /*# T65_ALU.vhd:88:14 */
  assign n3184 = {n3180, n3181};
  /*# T65_ALU.vhd:123:25 */
  assign n3185 = n3184[5]; // extract
  /*# T65_ALU.vhd:123:20 */
  assign n3186 = n3183 | n3185;
  /*# T65_ALU.vhd:88:14 */
  assign n3187 = {n3180, n3181};
  /*# T65_ALU.vhd:125:33 */
  assign n3188 = n3187[4:1]; // extract
  /*# T65_ALU.vhd:87:14 */
  assign n3189 = {n3147, n3148};
  /*# T65_ALU.vhd:125:50 */
  assign n3190 = n3189[4:1]; // extract
  /*# T65_ALU.vhd:125:46 */
  assign n3191 = {n3188, n3190};
  /*# T65_ALU.vhd:135:12 */
  assign n3202 = op == 5'b00001;
  /*# T65_ALU.vhd:136:12 */
  assign n3204 = op == 5'b00011;
  /*# T65_ALU.vhd:135:24 */
  assign n3205 = n3202 | n3204;
  /*# T65_ALU.vhd:137:12 */
  assign n3207 = op == 5'b00101;
  /*# T65_ALU.vhd:136:24 */
  assign n3208 = n3205 | n3207;
  /*# T65_ALU.vhd:138:12 */
  assign n3210 = op == 5'b00111;
  /*# T65_ALU.vhd:137:24 */
  assign n3211 = n3208 | n3210;
  /*# T65_ALU.vhd:139:12 */
  assign n3213 = op == 5'b01001;
  /*# T65_ALU.vhd:138:24 */
  assign n3214 = n3211 | n3213;
  /*# T65_ALU.vhd:140:12 */
  assign n3216 = op == 5'b01011;
  /*# T65_ALU.vhd:139:24 */
  assign n3217 = n3214 | n3216;
  /*# T65_ALU.vhd:142:12 */
  assign n3219 = op == 5'b01110;
  /*# T65_ALU.vhd:140:24 */
  assign n3220 = n3217 | n3219;
  /*# T65_ALU.vhd:135:5 */
  assign n3223 = n3220 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:147:14 */
  assign n3225 = p_in[0]; // extract
  /*# T65_ALU.vhd:147:26 */
  assign n3226 = ~n3223;
  /*# T65_ALU.vhd:147:23 */
  assign n3227 = n3225 | n3226;
  /*# T65_ALU.vhd:148:31 */
  assign n3228 = busa[3:0]; // extract
  /*# T65_ALU.vhd:148:44 */
  assign n3229 = {n3228, n3227};
  /*# T65_ALU.vhd:148:11 */
  assign n3230 = {2'b0, n3229};  // uext
  /*# T65_ALU.vhd:148:75 */
  assign n3231 = busb[3:0]; // extract
  /*# T65_ALU.vhd:148:88 */
  assign n3233 = {n3231, 1'b1};
  /*# T65_ALU.vhd:148:55 */
  assign n3234 = {1'b0, n3233};  // uext
  /*# T65_ALU.vhd:148:53 */
  assign n3235 = {1'b0, n3234};  // uext
  /*# T65_ALU.vhd:148:53 */
  assign n3236 = n3230 - n3235;
  /*# T65_ALU.vhd:149:31 */
  assign n3237 = busa[7:4]; // extract
  /*# T65_ALU.vhd:149:44 */
  assign n3239 = {n3237, 1'b0};
  /*# T65_ALU.vhd:149:11 */
  assign n3240 = {1'b0, n3239};  // uext
  /*# T65_ALU.vhd:149:77 */
  assign n3241 = busb[7:4]; // extract
  /*# T65_ALU.vhd:149:94 */
  assign n3242 = n3236[5]; // extract
  /*# T65_ALU.vhd:149:90 */
  assign n3243 = {n3241, n3242};
  /*# T65_ALU.vhd:149:57 */
  assign n3244 = {1'b0, n3243};  // uext
  /*# T65_ALU.vhd:149:55 */
  assign n3245 = n3240 - n3244;
  /*# T65_ALU.vhd:156:10 */
  assign n3246 = n3236[4:1]; // extract
  /*# T65_ALU.vhd:156:23 */
  assign n3248 = n3246 == 4'b0000;
  /*# T65_ALU.vhd:156:33 */
  assign n3249 = n3245[4:1]; // extract
  /*# T65_ALU.vhd:156:46 */
  assign n3251 = n3249 == 4'b0000;
  /*# T65_ALU.vhd:156:27 */
  assign n3252 = n3251 & n3248;
  /*# T65_ALU.vhd:156:5 */
  assign n3255 = n3252 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:162:20 */
  assign n3256 = n3245[5]; // extract
  /*# T65_ALU.vhd:162:14 */
  assign n3257 = ~n3256;
  /*# T65_ALU.vhd:163:17 */
  assign n3258 = n3245[4]; // extract
  /*# T65_ALU.vhd:163:29 */
  assign n3259 = busa[7]; // extract
  /*# T65_ALU.vhd:163:21 */
  assign n3260 = n3258 ^ n3259;
  /*# T65_ALU.vhd:163:43 */
  assign n3261 = busa[7]; // extract
  /*# T65_ALU.vhd:163:55 */
  assign n3262 = busb[7]; // extract
  /*# T65_ALU.vhd:163:47 */
  assign n3263 = n3261 ^ n3262;
  /*# T65_ALU.vhd:163:34 */
  assign n3264 = n3260 & n3263;
  /*# T65_ALU.vhd:164:16 */
  assign n3265 = n3245[4]; // extract
  /*# T65_ALU.vhd:166:33 */
  assign n3266 = n3245[4:1]; // extract
  /*# T65_ALU.vhd:166:50 */
  assign n3267 = n3236[4:1]; // extract
  /*# T65_ALU.vhd:166:46 */
  assign n3268 = {n3266, n3267};
  /*# T65_ALU.vhd:168:12 */
  assign n3269 = p_in[3]; // extract
  /*# T65_ALU.vhd:169:12 */
  assign n3270 = n3236[5]; // extract
  /*# T65_ALU.vhd:170:29 */
  assign n3271 = n3236[5:1]; // extract
  /*# T65_ALU.vhd:170:42 */
  assign n3273 = n3271 - 5'b00110;
  /*# T65_ALU.vhd:129:14 */
  assign n3274 = n3236[5:1]; // extract
  /*# T65_ALU.vhd:169:7 */
  assign n3275 = n3270 ? n3273 : n3274;
  /*# T65_ALU.vhd:172:33 */
  assign n3276 = busa[7:4]; // extract
  /*# T65_ALU.vhd:172:46 */
  assign n3278 = {n3276, 1'b0};
  /*# T65_ALU.vhd:172:13 */
  assign n3279 = {1'b0, n3278};  // uext
  /*# T65_ALU.vhd:172:79 */
  assign n3280 = busb[7:4]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3281 = n3236[0]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3282 = n3236[6]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3283 = {n3282, n3275, n3281};
  /*# T65_ALU.vhd:172:96 */
  assign n3284 = n3283[6]; // extract
  /*# T65_ALU.vhd:172:92 */
  assign n3285 = {n3280, n3284};
  /*# T65_ALU.vhd:172:59 */
  assign n3286 = {1'b0, n3285};  // uext
  /*# T65_ALU.vhd:172:57 */
  assign n3287 = n3279 - n3286;
  /*# T65_ALU.vhd:173:12 */
  assign n3288 = n3287[5]; // extract
  /*# T65_ALU.vhd:174:29 */
  assign n3289 = n3287[5:1]; // extract
  /*# T65_ALU.vhd:174:42 */
  assign n3291 = n3289 - 5'b00110;
  /*# T65_ALU.vhd:130:14 */
  assign n3292 = n3287[5:1]; // extract
  /*# T65_ALU.vhd:173:7 */
  assign n3293 = n3288 ? n3291 : n3292;
  /*# T65_ALU.vhd:130:14 */
  assign n3294 = n3287[0]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3295 = n3236[5:1]; // extract
  /*# T65_ALU.vhd:168:5 */
  assign n3296 = n3269 ? n3275 : n3295;
  /*# T65_ALU.vhd:129:14 */
  assign n3297 = n3236[6]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3298 = n3236[0]; // extract
  /*# T65_ALU.vhd:168:5 */
  assign n3299 = {n3293, n3294};
  /*# T65_ALU.vhd:168:5 */
  assign n3300 = n3269 ? n3299 : n3245;
  /*# T65_ALU.vhd:178:33 */
  assign n3301 = n3300[4:1]; // extract
  /*# T65_ALU.vhd:129:14 */
  assign n3302 = {n3297, n3296, n3298};
  /*# T65_ALU.vhd:178:50 */
  assign n3303 = n3302[4:1]; // extract
  /*# T65_ALU.vhd:178:46 */
  assign n3304 = {n3301, n3303};
  /*# T65_ALU.vhd:195:21 */
  assign n3311 = busa | busb;
  /*# T65_ALU.vhd:194:7 */
  assign n3313 = op == 5'b00000;
  /*# T65_ALU.vhd:197:21 */
  assign n3314 = busa & busb;
  /*# T65_ALU.vhd:196:7 */
  assign n3316 = op == 5'b00001;
  /*# T65_ALU.vhd:199:21 */
  assign n3317 = busa ^ busb;
  /*# T65_ALU.vhd:198:7 */
  assign n3319 = op == 5'b00010;
  /*# T65_ALU.vhd:200:7 */
  assign n3321 = op == 5'b00011;
  /*# T65_ALU.vhd:204:7 */
  assign n3323 = op == 5'b00110;
  /*# T65_ALU.vhd:206:7 */
  assign n3325 = op == 5'b10001;
  /*# T65_ALU.vhd:209:7 */
  assign n3327 = op == 5'b00111;
  /*# T65_ALU.vhd:214:20 */
  assign n3328 = busa[6:0]; // extract
  /*# T65_ALU.vhd:214:33 */
  assign n3330 = {n3328, 1'b0};
  /*# T65_ALU.vhd:215:30 */
  assign n3331 = busa[7]; // extract
  /*# T65_ALU.vhd:213:7 */
  assign n3333 = op == 5'b01000;
  /*# T65_ALU.vhd:217:20 */
  assign n3334 = busa[6:0]; // extract
  /*# T65_ALU.vhd:217:39 */
  assign n3335 = p_in[0]; // extract
  /*# T65_ALU.vhd:217:33 */
  assign n3336 = {n3334, n3335};
  /*# T65_ALU.vhd:218:30 */
  assign n3337 = busa[7]; // extract
  /*# T65_ALU.vhd:216:7 */
  assign n3339 = op == 5'b01001;
  /*# T65_ALU.vhd:220:26 */
  assign n3340 = busa[7:1]; // extract
  /*# T65_ALU.vhd:220:20 */
  assign n3342 = {1'b0, n3340};
  /*# T65_ALU.vhd:221:30 */
  assign n3343 = busa[0]; // extract
  /*# T65_ALU.vhd:219:7 */
  assign n3345 = op == 5'b01010;
  /*# T65_ALU.vhd:223:20 */
  assign n3346 = p_in[0]; // extract
  /*# T65_ALU.vhd:223:35 */
  assign n3347 = busa[7:1]; // extract
  /*# T65_ALU.vhd:223:29 */
  assign n3348 = {n3346, n3347};
  /*# T65_ALU.vhd:224:30 */
  assign n3349 = busa[0]; // extract
  /*# T65_ALU.vhd:222:7 */
  assign n3351 = op == 5'b01011;
  /*# T65_ALU.vhd:226:20 */
  assign n3352 = p_in[0]; // extract
  /*# T65_ALU.vhd:226:36 */
  assign n3353 = busa[7:1]; // extract
  /*# T65_ALU.vhd:226:57 */
  assign n3354 = busb[7:1]; // extract
  /*# T65_ALU.vhd:226:49 */
  assign n3355 = n3353 & n3354;
  /*# T65_ALU.vhd:226:29 */
  assign n3356 = {n3352, n3355};
  /*# T65_ALU.vhd:227:29 */
  assign n3357 = n3356[5]; // extract
  /*# T65_ALU.vhd:227:40 */
  assign n3358 = n3356[6]; // extract
  /*# T65_ALU.vhd:227:33 */
  assign n3359 = n3357 ^ n3358;
  /*# T65_ALU.vhd:229:16 */
  assign n3360 = p_in[3]; // extract
  /*# T65_ALU.vhd:230:19 */
  assign n3361 = busa[3:0]; // extract
  /*# T65_ALU.vhd:230:40 */
  assign n3362 = busb[3:0]; // extract
  /*# T65_ALU.vhd:230:32 */
  assign n3363 = n3361 & n3362;
  /*# T65_ALU.vhd:230:54 */
  assign n3365 = $unsigned(n3363) > $unsigned(4'b0100);
  /*# T65_ALU.vhd:231:62 */
  assign n3366 = n3356[3:0]; // extract
  /*# T65_ALU.vhd:231:76 */
  assign n3368 = n3366 + 4'b0110;
  /*# T65_ALU.vhd:186:14 */
  assign n3369 = n3356[3:0]; // extract
  /*# T65_ALU.vhd:230:11 */
  assign n3370 = n3365 ? n3368 : n3369;
  /*# T65_ALU.vhd:233:19 */
  assign n3371 = busa[7:4]; // extract
  /*# T65_ALU.vhd:233:40 */
  assign n3372 = busb[7:4]; // extract
  /*# T65_ALU.vhd:233:32 */
  assign n3373 = n3371 & n3372;
  /*# T65_ALU.vhd:233:54 */
  assign n3375 = $unsigned(n3373) > $unsigned(4'b0100);
  /*# T65_ALU.vhd:234:62 */
  assign n3376 = n3356[7:4]; // extract
  /*# T65_ALU.vhd:234:76 */
  assign n3378 = n3376 + 4'b0110;
  /*# T65_ALU.vhd:233:11 */
  assign n3381 = n3375 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:186:14 */
  assign n3382 = n3356[7:4]; // extract
  /*# T65_ALU.vhd:233:11 */
  assign n3383 = n3375 ? n3378 : n3382;
  /*# T65_ALU.vhd:240:31 */
  assign n3384 = n3356[6]; // extract
  /*# T65_ALU.vhd:229:9 */
  assign n3385 = n3360 ? n3381 : n3384;
  /*# T65_ALU.vhd:229:9 */
  assign n3386 = {n3383, n3370};
  /*# T65_ALU.vhd:229:9 */
  assign n3387 = n3360 ? n3386 : n3356;
  /*# T65_ALU.vhd:225:7 */
  assign n3389 = op == 5'b01111;
  /*# T65_ALU.vhd:243:30 */
  assign n3390 = busb[6]; // extract
  /*# T65_ALU.vhd:242:7 */
  assign n3392 = op == 5'b01100;
  /*# T65_ALU.vhd:245:48 */
  assign n3394 = busa - 8'b00000001;
  /*# T65_ALU.vhd:244:7 */
  assign n3396 = op == 5'b01101;
  /*# T65_ALU.vhd:247:48 */
  assign n3398 = busa + 8'b00000001;
  /*# T65_ALU.vhd:246:7 */
  assign n3400 = op == 5'b01110;
  /*# T65_ALU.vhd:193:5 */
  assign n3401 = {n3400, n3396, n3392, n3389, n3351, n3345, n3339, n3333, n3327, n3325, n3323, n3321, n3319, n3316, n3313};
  /*# T65_ALU.vhd:64:5 */
  assign n3402 = p_in[0]; // extract
  /*# T65_ALU.vhd:193:5 */
  always @*
    case (n3401)
      15'b100000000000000: n3403 = n3402;
      15'b010000000000000: n3403 = n3402;
      15'b001000000000000: n3403 = n3402;
      15'b000100000000000: n3403 = n3385;
      15'b000010000000000: n3403 = n3349;
      15'b000001000000000: n3403 = n3343;
      15'b000000100000000: n3403 = n3337;
      15'b000000010000000: n3403 = n3331;
      15'b000000001000000: n3403 = sbc_c;
      15'b000000000100000: n3403 = sbc_c;
      15'b000000000010000: n3403 = sbc_c;
      15'b000000000001000: n3403 = adc_c;
      15'b000000000000100: n3403 = n3402;
      15'b000000000000010: n3403 = n3402;
      15'b000000000000001: n3403 = n3402;
      default: n3403 = n3402;
    endcase
  /*# T65_ALU.vhd:64:5 */
  assign n3404 = p_in[6]; // extract
  /*# T65_ALU.vhd:193:5 */
  always @*
    case (n3401)
      15'b100000000000000: n3405 = n3404;
      15'b010000000000000: n3405 = n3404;
      15'b001000000000000: n3405 = n3390;
      15'b000100000000000: n3405 = n3359;
      15'b000010000000000: n3405 = n3404;
      15'b000001000000000: n3405 = n3404;
      15'b000000100000000: n3405 = n3404;
      15'b000000010000000: n3405 = n3404;
      15'b000000001000000: n3405 = sbc_v;
      15'b000000000100000: n3405 = n3404;
      15'b000000000010000: n3405 = n3404;
      15'b000000000001000: n3405 = adc_v;
      15'b000000000000100: n3405 = n3404;
      15'b000000000000010: n3405 = n3404;
      15'b000000000000001: n3405 = n3404;
      default: n3405 = n3404;
    endcase
  /*# T65_ALU.vhd:64:5 */
  assign n3407 = p_in[7]; // extract
  /*# T65_ALU.vhd:193:5 */
  always @*
    case (n3401)
      15'b100000000000000: n3409 = n3398;
      15'b010000000000000: n3409 = n3394;
      15'b001000000000000: n3409 = busa;
      15'b000100000000000: n3409 = n3356;
      15'b000010000000000: n3409 = n3348;
      15'b000001000000000: n3409 = n3342;
      15'b000000100000000: n3409 = n3336;
      15'b000000010000000: n3409 = n3330;
      15'b000000001000000: n3409 = sbc_q;
      15'b000000000100000: n3409 = sbx_q;
      15'b000000000010000: n3409 = busa;
      15'b000000000001000: n3409 = adc_q;
      15'b000000000000100: n3409 = n3317;
      15'b000000000000010: n3409 = n3314;
      15'b000000000000001: n3409 = n3311;
      default: n3409 = busa;
    endcase
  /*# T65_ALU.vhd:193:5 */
  always @*
    case (n3401)
      15'b100000000000000: n3410 = busa;
      15'b010000000000000: n3410 = busa;
      15'b001000000000000: n3410 = busa;
      15'b000100000000000: n3410 = n3387;
      15'b000010000000000: n3410 = busa;
      15'b000001000000000: n3410 = busa;
      15'b000000100000000: n3410 = busa;
      15'b000000010000000: n3410 = busa;
      15'b000000001000000: n3410 = busa;
      15'b000000000100000: n3410 = busa;
      15'b000000000010000: n3410 = busa;
      15'b000000000001000: n3410 = busa;
      15'b000000000000100: n3410 = busa;
      15'b000000000000010: n3410 = busa;
      15'b000000000000001: n3410 = busa;
      default: n3410 = busa;
    endcase
  /*# T65_ALU.vhd:254:7 */
  assign n3412 = op == 5'b00011;
  /*# T65_ALU.vhd:257:7 */
  assign n3414 = op == 5'b00110;
  /*# T65_ALU.vhd:257:22 */
  assign n3416 = op == 5'b00111;
  /*# T65_ALU.vhd:257:22 */
  assign n3417 = n3414 | n3416;
  /*# T65_ALU.vhd:257:33 */
  assign n3419 = op == 5'b10001;
  /*# T65_ALU.vhd:257:33 */
  assign n3420 = n3417 | n3419;
  /*# T65_ALU.vhd:260:7 */
  assign n3422 = op == 5'b00100;
  /*# T65_ALU.vhd:262:30 */
  assign n3423 = busb[7]; // extract
  /*# T65_ALU.vhd:263:18 */
  assign n3424 = busa & busb;
  /*# T65_ALU.vhd:263:28 */
  assign n3426 = n3424 == 8'b00000000;
  /*# T65_ALU.vhd:263:9 */
  assign n3429 = n3426 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:261:7 */
  assign n3431 = op == 5'b01100;
  /*# T65_ALU.vhd:269:29 */
  assign n3432 = n3409[7]; // extract
  /*# T65_ALU.vhd:270:29 */
  assign n3433 = n3409[7]; // extract
  /*# T65_ALU.vhd:271:16 */
  assign n3435 = n3409 == 8'b00000000;
  /*# T65_ALU.vhd:271:9 */
  assign n3438 = n3435 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:268:7 */
  assign n3440 = op == 5'b10000;
  /*# T65_ALU.vhd:277:29 */
  assign n3441 = n3409[7]; // extract
  /*# T65_ALU.vhd:278:16 */
  assign n3443 = n3409 == 8'b00000000;
  /*# T65_ALU.vhd:278:9 */
  assign n3446 = n3443 ? 1'b1 : 1'b0;
  /*# T65_ALU.vhd:253:5 */
  assign n3447 = {n3440, n3431, n3422, n3420, n3412};
  /*# T65_ALU.vhd:253:5 */
  always @*
    case (n3447)
      5'b10000: n3448 = n3433;
      5'b01000: n3448 = n3403;
      5'b00100: n3448 = n3403;
      5'b00010: n3448 = n3403;
      5'b00001: n3448 = n3403;
      default: n3448 = n3403;
    endcase
  /*# T65_ALU.vhd:64:5 */
  assign n3449 = p_in[1]; // extract
  /*# T65_ALU.vhd:253:5 */
  always @*
    case (n3447)
      5'b10000: n3450 = n3438;
      5'b01000: n3450 = n3429;
      5'b00100: n3450 = n3449;
      5'b00010: n3450 = sbc_z;
      5'b00001: n3450 = adc_z;
      default: n3450 = n3446;
    endcase
  /*# T65_ALU.vhd:253:5 */
  always @*
    case (n3447)
      5'b10000: n3451 = n3432;
      5'b01000: n3451 = n3423;
      5'b00100: n3451 = n3407;
      5'b00010: n3451 = sbc_n;
      5'b00001: n3451 = adc_n;
      default: n3451 = n3441;
    endcase
  /*# T65_ALU.vhd:64:5 */
  assign n3452 = p_in[5:2]; // extract
  /*# T65_ALU.vhd:285:10 */
  assign n3454 = op == 5'b01111;
  /*# T65_ALU.vhd:285:5 */
  assign n3455 = n3454 ? n3410 : n3409;
  /*# T65_ALU.vhd:64:5 */
  assign n3457 = {n3451, n3405, n3452, n3450, n3448};
endmodule

module t65_mcode_Brtl
  (input  [1:0] mode,
   input  [7:0] ir,
   input  [2:0] mcycle,
   input  [7:0] p,
   input  rdy_mod,
   output [2:0] lcycle,
   output [4:0] alu_op,
   output [3:0] set_busa_to,
   output [1:0] set_addr_to,
   output [3:0] write_data,
   output [1:0] jump,
   output [1:0] baadd,
   output [1:0] baquirk,
   output breakatna,
   output adadd,
   output addy,
   output pcadd,
   output inc_s,
   output dec_s,
   output lda,
   output ldp,
   output ldx,
   output ldy,
   output lds,
   output lddi,
   output ldalu,
   output ldad,
   output ldbal,
   output ldbah,
   output savep,
   output write);
  wire branch;
  wire alumore;
  wire [2:0] n912;
  wire n913;
  wire n914;
  wire n916;
  wire n917;
  wire n919;
  wire n920;
  wire n921;
  wire n923;
  wire n924;
  wire n926;
  wire n927;
  wire n928;
  wire n930;
  wire n931;
  wire n933;
  wire n934;
  wire n935;
  wire n937;
  wire n938;
  wire [6:0] n939;
  reg n940;
  wire [2:0] n943;
  wire [1:0] n944;
  wire [2:0] n945;
  wire n947;
  wire n948;
  wire [3:0] n951;
  wire [3:0] n953;
  wire n955;
  wire [2:0] n956;
  wire n958;
  wire n959;
  wire [3:0] n962;
  wire [3:0] n964;
  wire n966;
  wire [2:0] n967;
  wire n969;
  wire [3:0] n972;
  wire n975;
  wire [2:0] n976;
  wire n978;
  wire [2:0] n979;
  wire n981;
  wire n982;
  wire [2:0] n983;
  wire n985;
  wire n986;
  wire n987;
  wire [3:0] n990;
  wire [3:0] n992;
  wire n994;
  wire [2:0] n995;
  reg [3:0] n999;
  reg [3:0] n1001;
  reg n1003;
  wire n1005;
  wire [1:0] n1006;
  wire n1007;
  wire n1009;
  wire n1010;
  wire n1012;
  wire n1013;
  wire n1016;
  wire n1018;
  wire n1020;
  wire n1022;
  wire [2:0] n1023;
  wire n1025;
  wire [3:0] n1028;
  wire n1031;
  wire [2:0] n1032;
  reg [3:0] n1034;
  reg n1039;
  reg n1043;
  reg n1045;
  reg n1047;
  wire n1049;
  wire [1:0] n1050;
  wire n1051;
  wire n1052;
  wire n1055;
  wire n1057;
  reg [3:0] n1060;
  reg n1062;
  wire n1064;
  wire [1:0] n1065;
  wire n1066;
  wire n1067;
  wire n1070;
  wire n1072;
  reg [3:0] n1075;
  reg n1077;
  wire n1079;
  wire [3:0] n1080;
  reg [3:0] n1082;
  reg [3:0] n1085;
  reg n1088;
  reg n1091;
  reg n1094;
  reg n1097;
  wire [1:0] n1099;
  wire n1101;
  wire n1102;
  wire n1103;
  wire n1105;
  wire n1106;
  wire n1107;
  wire n1108;
  wire n1109;
  wire n1111;
  wire [3:0] n1114;
  wire [3:0] n1115;
  wire [4:0] n1116;
  wire n1118;
  wire n1120;
  wire n1122;
  wire n1124;
  wire n1126;
  wire n1128;
  wire [5:0] n1129;
  reg [1:0] n1136;
  reg [3:0] n1140;
  reg [1:0] n1143;
  reg n1148;
  reg n1151;
  reg n1156;
  wire n1158;
  wire n1160;
  wire n1162;
  wire n1164;
  wire n1166;
  wire n1168;
  wire [4:0] n1169;
  reg [1:0] n1174;
  reg [3:0] n1177;
  reg [1:0] n1181;
  reg n1185;
  reg n1188;
  reg n1192;
  wire n1194;
  wire n1196;
  wire n1198;
  wire n1200;
  wire n1202;
  wire n1204;
  wire [4:0] n1205;
  reg [3:0] n1207;
  reg [1:0] n1213;
  reg [1:0] n1216;
  reg n1221;
  reg n1224;
  reg n1227;
  wire n1229;
  wire n1231;
  wire n1233;
  wire n1235;
  wire n1237;
  wire n1239;
  wire [4:0] n1240;
  reg [1:0] n1245;
  reg [1:0] n1249;
  reg n1253;
  reg n1256;
  wire n1258;
  wire n1260;
  wire n1261;
  wire n1262;
  wire [2:0] n1265;
  wire n1268;
  wire n1269;
  wire n1270;
  wire n1271;
  wire [3:0] n1272;
  wire n1274;
  wire n1276;
  wire n1278;
  wire [3:0] n1280;
  wire n1283;
  wire n1285;
  wire n1287;
  wire [3:0] n1289;
  wire n1292;
  wire n1294;
  wire [3:0] n1295;
  reg [3:0] n1298;
  reg n1300;
  wire [1:0] n1304;
  wire [3:0] n1305;
  wire n1307;
  wire n1309;
  wire n1311;
  wire [1:0] n1312;
  reg [1:0] n1314;
  reg [3:0] n1315;
  reg n1318;
  reg n1320;
  wire n1322;
  wire n1324;
  wire n1325;
  wire n1327;
  wire n1328;
  wire n1330;
  wire n1331;
  wire n1333;
  wire n1334;
  wire n1335;
  wire [2:0] n1338;
  wire [3:0] n1340;
  wire n1342;
  wire n1344;
  wire n1346;
  wire n1348;
  wire n1350;
  wire n1352;
  wire n1354;
  wire n1356;
  wire [3:0] n1357;
  reg n1359;
  reg n1362;
  reg n1363;
  reg n1364;
  wire n1366;
  wire n1367;
  wire n1368;
  wire n1369;
  wire n1372;
  wire n1374;
  wire n1376;
  wire n1377;
  wire n1378;
  wire n1379;
  wire [1:0] n1382;
  wire n1384;
  wire n1386;
  wire n1388;
  wire n1390;
  wire [3:0] n1391;
  reg [3:0] n1393;
  reg [1:0] n1396;
  reg n1399;
  reg n1401;
  reg n1403;
  wire n1405;
  wire n1407;
  wire n1408;
  wire n1410;
  wire n1411;
  wire n1413;
  wire n1414;
  wire n1416;
  wire n1418;
  wire [1:0] n1419;
  reg [1:0] n1422;
  wire n1424;
  wire n1426;
  wire n1427;
  wire n1429;
  wire n1430;
  wire n1432;
  wire n1434;
  wire [1:0] n1435;
  reg [3:0] n1437;
  wire n1439;
  wire n1441;
  wire n1443;
  wire [1:0] n1444;
  reg [3:0] n1446;
  wire n1448;
  wire n1450;
  wire n1452;
  wire n1454;
  wire n1456;
  wire [1:0] n1457;
  reg [3:0] n1459;
  wire n1461;
  wire n1463;
  wire n1464;
  wire n1471;
  wire n1473;
  wire n1474;
  wire n1476;
  wire n1477;
  wire n1479;
  wire n1480;
  wire n1487;
  wire n1489;
  wire n1490;
  wire n1492;
  wire n1494;
  wire [1:0] n1495;
  reg [3:0] n1497;
  wire n1499;
  wire n1501;
  wire n1502;
  wire n1504;
  wire n1506;
  wire n1508;
  wire [1:0] n1509;
  reg [3:0] n1511;
  wire n1513;
  wire n1515;
  wire n1517;
  wire [1:0] n1518;
  reg [1:0] n1521;
  wire n1523;
  wire [15:0] n1526;
  reg [2:0] n1532;
  reg [3:0] n1534;
  reg [1:0] n1536;
  reg [3:0] n1537;
  reg [1:0] n1539;
  reg n1541;
  reg n1543;
  reg n1546;
  reg n1548;
  reg n1551;
  reg n1553;
  reg n1555;
  reg n1557;
  reg n1559;
  reg n1561;
  wire n1563;
  wire n1565;
  wire n1566;
  wire n1568;
  wire n1569;
  wire n1571;
  wire n1572;
  wire n1574;
  wire n1575;
  wire [1:0] n1576;
  wire n1578;
  wire n1580;
  wire n1581;
  wire n1582;
  wire [2:0] n1585;
  wire [2:0] n1587;
  wire n1590;
  wire n1592;
  wire n1594;
  wire n1596;
  wire [2:0] n1597;
  wire n1599;
  wire n1602;
  wire n1604;
  wire n1606;
  wire n1607;
  wire n1608;
  wire [1:0] n1609;
  wire n1611;
  wire n1612;
  wire [1:0] n1615;
  wire n1618;
  wire n1621;
  wire n1623;
  wire n1625;
  wire n1627;
  wire [6:0] n1628;
  reg [3:0] n1630;
  reg [1:0] n1637;
  reg [1:0] n1640;
  reg [1:0] n1643;
  reg n1646;
  reg n1648;
  reg n1651;
  reg n1654;
  reg n1657;
  reg n1660;
  reg n1663;
  reg n1666;
  reg n1669;
  wire n1671;
  wire n1673;
  wire n1674;
  wire [2:0] n1675;
  wire n1677;
  wire n1679;
  wire n1681;
  reg [1:0] n1684;
  wire n1686;
  wire n1688;
  wire [2:0] n1689;
  wire n1691;
  wire n1693;
  wire n1694;
  wire n1696;
  wire n1697;
  wire n1699;
  wire n1700;
  wire n1702;
  wire n1704;
  wire n1706;
  wire [3:0] n1707;
  reg [3:0] n1712;
  reg n1717;
  reg n1719;
  wire n1721;
  reg [1:0] n1724;
  wire [3:0] n1725;
  wire [1:0] n1727;
  wire n1728;
  wire n1729;
  wire n1731;
  wire n1733;
  wire n1735;
  wire [3:0] n1736;
  wire n1738;
  wire [3:0] n1739;
  wire n1741;
  wire n1742;
  wire [3:0] n1743;
  wire n1745;
  wire n1746;
  wire [1:0] n1749;
  wire [1:0] n1751;
  wire n1753;
  wire n1755;
  wire [1:0] n1756;
  reg [1:0] n1758;
  reg n1759;
  wire n1761;
  wire n1763;
  wire n1764;
  wire [2:0] n1765;
  wire n1767;
  wire n1770;
  wire n1772;
  wire [2:0] n1773;
  wire n1775;
  wire n1778;
  wire n1780;
  wire n1782;
  wire [2:0] n1783;
  reg [1:0] n1786;
  reg [1:0] n1789;
  reg n1792;
  reg n1794;
  reg n1796;
  wire n1798;
  wire [1:0] n1799;
  wire n1801;
  wire n1802;
  wire n1803;
  wire n1805;
  wire n1806;
  wire n1807;
  wire n1808;
  wire n1809;
  wire n1811;
  wire n1812;
  wire n1813;
  wire n1815;
  wire n1817;
  wire n1819;
  wire n1822;
  wire n1824;
  wire n1826;
  wire n1828;
  wire n1829;
  wire n1830;
  wire [3:0] n1832;
  wire n1835;
  wire n1838;
  wire n1840;
  wire [3:0] n1841;
  reg [3:0] n1842;
  reg [1:0] n1847;
  reg [1:0] n1850;
  reg n1853;
  reg n1856;
  reg n1859;
  reg n1862;
  reg n1865;
  reg n1867;
  wire [1:0] n1868;
  wire n1870;
  wire n1872;
  wire n1874;
  wire [2:0] n1875;
  wire n1877;
  wire n1880;
  wire n1882;
  wire n1884;
  wire [2:0] n1885;
  reg [1:0] n1888;
  reg [1:0] n1891;
  reg n1894;
  reg n1896;
  wire [2:0] n1899;
  wire [3:0] n1900;
  wire [1:0] n1901;
  wire [1:0] n1902;
  wire n1903;
  wire n1905;
  wire n1907;
  wire n1908;
  wire n1910;
  wire n1911;
  wire n1913;
  wire n1915;
  wire n1917;
  wire n1918;
  wire n1920;
  wire n1921;
  wire [1:0] n1922;
  wire n1924;
  wire [4:0] n1925;
  wire n1927;
  wire n1928;
  wire n1929;
  wire n1930;
  wire n1932;
  wire n1934;
  wire [1:0] n1935;
  reg [1:0] n1939;
  reg n1942;
  wire n1944;
  wire n1946;
  wire [1:0] n1949;
  wire n1951;
  wire [1:0] n1954;
  wire n1956;
  wire n1958;
  wire [1:0] n1961;
  wire [1:0] n1964;
  wire [1:0] n1967;
  wire n1969;
  wire n1971;
  wire [3:0] n1972;
  reg [1:0] n1974;
  reg [1:0] n1978;
  reg [1:0] n1980;
  reg n1984;
  reg n1987;
  reg n1990;
  wire [2:0] n1993;
  wire [1:0] n1995;
  wire [1:0] n1996;
  wire [1:0] n1998;
  wire n1999;
  wire n2001;
  wire n2003;
  wire [2:0] n2004;
  wire n2006;
  wire n2009;
  wire n2011;
  wire n2013;
  wire [2:0] n2014;
  wire n2016;
  wire n2019;
  wire n2021;
  wire n2023;
  wire [3:0] n2024;
  reg [1:0] n2027;
  reg [1:0] n2031;
  reg n2034;
  reg n2037;
  reg n2039;
  reg n2041;
  wire [2:0] n2043;
  wire [1:0] n2044;
  wire [1:0] n2045;
  wire [1:0] n2047;
  wire n2049;
  wire n2050;
  wire n2051;
  wire n2053;
  wire n2055;
  wire n2057;
  wire [1:0] n2058;
  wire n2060;
  wire n2061;
  wire n2062;
  wire n2064;
  wire n2065;
  wire n2066;
  wire n2067;
  wire n2068;
  wire n2070;
  wire n2071;
  wire n2072;
  wire n2074;
  wire n2076;
  wire n2078;
  wire n2080;
  wire n2083;
  wire n2085;
  wire n2087;
  wire n2089;
  wire n2090;
  wire n2091;
  wire [3:0] n2093;
  wire n2096;
  wire n2098;
  wire [4:0] n2099;
  reg [3:0] n2100;
  reg [1:0] n2105;
  reg [1:0] n2109;
  reg n2112;
  reg n2115;
  reg n2118;
  reg n2121;
  reg n2124;
  reg n2127;
  reg n2129;
  wire [1:0] n2130;
  wire n2132;
  wire n2134;
  wire n2136;
  wire n2138;
  wire [2:0] n2139;
  wire n2141;
  wire n2144;
  wire n2146;
  wire n2148;
  wire [3:0] n2149;
  reg [1:0] n2152;
  reg [1:0] n2156;
  reg n2159;
  reg n2162;
  reg n2164;
  wire [2:0] n2167;
  wire [3:0] n2168;
  wire [1:0] n2169;
  wire [1:0] n2170;
  wire n2171;
  wire n2173;
  wire n2175;
  wire n2176;
  wire n2177;
  wire n2179;
  wire n2180;
  wire n2182;
  wire n2184;
  wire n2186;
  wire n2187;
  wire n2189;
  wire n2190;
  wire [2:0] n2193;
  wire n2195;
  wire n2197;
  wire n2199;
  wire [2:0] n2200;
  reg [1:0] n2204;
  reg n2207;
  reg n2210;
  wire n2212;
  wire [1:0] n2213;
  wire n2215;
  wire n2217;
  wire n2218;
  wire n2219;
  wire [2:0] n2222;
  wire [2:0] n2224;
  wire n2227;
  wire n2229;
  wire n2231;
  wire n2233;
  wire [2:0] n2234;
  wire n2236;
  wire [3:0] n2237;
  wire n2239;
  wire [1:0] n2242;
  wire n2243;
  wire n2244;
  wire n2246;
  wire n2247;
  wire n2250;
  wire [1:0] n2252;
  wire n2254;
  wire n2257;
  wire n2259;
  wire n2261;
  wire n2262;
  wire n2263;
  wire [1:0] n2264;
  wire n2266;
  wire n2267;
  wire [1:0] n2270;
  wire n2273;
  wire n2276;
  wire n2278;
  wire n2280;
  wire n2282;
  wire [6:0] n2283;
  reg [3:0] n2286;
  reg [1:0] n2293;
  reg [1:0] n2296;
  reg [1:0] n2301;
  reg [1:0] n2303;
  reg n2305;
  reg n2307;
  reg n2310;
  reg n2313;
  reg n2316;
  reg n2319;
  reg n2322;
  reg n2325;
  reg n2328;
  wire n2330;
  wire n2332;
  wire n2333;
  wire [1:0] n2334;
  wire n2336;
  wire n2337;
  wire n2338;
  wire n2340;
  wire n2341;
  wire n2342;
  wire n2343;
  wire n2344;
  wire n2346;
  wire n2347;
  wire n2348;
  wire n2350;
  wire n2352;
  wire n2354;
  wire n2356;
  wire n2359;
  wire n2361;
  wire n2363;
  wire n2364;
  wire n2365;
  wire n2368;
  wire n2370;
  wire n2372;
  wire n2373;
  wire n2374;
  wire [3:0] n2376;
  wire n2379;
  wire n2381;
  wire [4:0] n2382;
  reg [3:0] n2383;
  reg [1:0] n2389;
  reg [1:0] n2392;
  reg n2395;
  reg n2398;
  reg n2401;
  reg n2404;
  reg n2407;
  reg n2410;
  reg n2412;
  wire [1:0] n2413;
  wire n2415;
  wire n2416;
  wire n2417;
  wire n2419;
  wire n2421;
  wire n2423;
  wire [2:0] n2424;
  wire n2426;
  wire n2429;
  wire [2:0] n2430;
  wire n2432;
  wire n2435;
  wire n2437;
  wire n2439;
  wire [3:0] n2440;
  reg [1:0] n2444;
  reg [1:0] n2447;
  reg n2450;
  reg n2452;
  reg n2455;
  reg n2457;
  wire [2:0] n2460;
  wire [3:0] n2461;
  wire [1:0] n2462;
  wire [1:0] n2463;
  wire n2464;
  wire n2466;
  wire n2467;
  wire n2469;
  wire n2471;
  wire n2472;
  wire n2474;
  wire n2475;
  wire n2477;
  wire n2479;
  wire n2481;
  wire n2482;
  wire n2484;
  wire n2485;
  wire n2487;
  wire n2488;
  wire [1:0] n2489;
  wire n2491;
  wire n2493;
  wire n2494;
  wire n2495;
  wire [2:0] n2498;
  wire [2:0] n2500;
  wire n2503;
  wire n2505;
  wire n2507;
  wire [2:0] n2508;
  wire n2510;
  wire [3:0] n2511;
  wire n2513;
  wire [1:0] n2516;
  wire n2517;
  wire n2518;
  wire n2520;
  wire n2521;
  wire n2524;
  wire [1:0] n2526;
  wire n2528;
  wire n2531;
  wire n2533;
  wire n2535;
  wire n2536;
  wire n2537;
  wire [1:0] n2538;
  wire n2540;
  wire n2541;
  wire [1:0] n2544;
  wire n2547;
  wire n2550;
  wire n2552;
  wire n2554;
  wire n2556;
  wire [5:0] n2557;
  reg [3:0] n2560;
  reg [1:0] n2565;
  reg [1:0] n2569;
  reg [1:0] n2573;
  reg [1:0] n2575;
  reg n2577;
  reg n2579;
  reg n2582;
  reg n2585;
  reg n2588;
  reg n2591;
  reg n2594;
  reg n2597;
  wire n2599;
  wire n2601;
  wire n2602;
  wire [1:0] n2603;
  wire n2605;
  wire n2606;
  wire n2607;
  wire n2609;
  wire n2610;
  wire n2611;
  wire n2612;
  wire n2613;
  wire n2615;
  wire n2616;
  wire n2617;
  wire n2619;
  wire n2621;
  wire n2623;
  wire n2625;
  wire n2627;
  wire n2630;
  wire n2632;
  wire n2634;
  wire n2636;
  wire n2637;
  wire n2638;
  wire [3:0] n2640;
  wire n2643;
  wire n2645;
  wire [5:0] n2646;
  reg [3:0] n2648;
  reg [1:0] n2654;
  reg [1:0] n2658;
  reg [1:0] n2662;
  reg n2665;
  reg n2668;
  reg n2671;
  reg n2674;
  reg n2677;
  reg n2680;
  reg n2682;
  wire [1:0] n2683;
  wire n2685;
  wire n2687;
  wire n2688;
  wire n2689;
  wire n2690;
  wire [1:0] n2691;
  wire n2693;
  wire n2694;
  wire n2696;
  wire n2697;
  wire n2699;
  wire n2701;
  wire [1:0] n2702;
  wire n2704;
  wire [3:0] n2705;
  wire n2707;
  wire n2708;
  wire [3:0] n2711;
  wire n2713;
  wire [2:0] n2714;
  wire n2716;
  wire [1:0] n2717;
  wire n2719;
  wire n2721;
  wire n2722;
  wire n2724;
  wire [1:0] n2725;
  reg [1:0] n2729;
  wire [1:0] n2731;
  wire n2734;
  wire n2737;
  wire n2739;
  wire n2741;
  wire [4:0] n2742;
  reg [3:0] n2743;
  reg [1:0] n2747;
  reg [1:0] n2751;
  reg [1:0] n2755;
  reg [1:0] n2757;
  reg n2759;
  reg n2762;
  reg n2765;
  reg n2767;
  wire [2:0] n2770;
  wire [3:0] n2771;
  wire [1:0] n2772;
  wire [1:0] n2773;
  wire [1:0] n2774;
  wire [1:0] n2776;
  wire n2778;
  wire n2779;
  wire n2781;
  wire n2783;
  wire n2784;
  wire n2785;
  wire n2787;
  wire n2788;
  wire n2790;
  wire n2792;
  wire n2794;
  wire n2795;
  wire n2797;
  wire n2798;
  wire n2800;
  wire n2801;
  wire [13:0] n2802;
  reg [2:0] n2805;
  reg [3:0] n2807;
  reg [1:0] n2809;
  reg [3:0] n2811;
  reg [1:0] n2813;
  reg [1:0] n2816;
  reg [1:0] n2819;
  reg n2822;
  reg n2825;
  reg n2828;
  reg n2831;
  reg n2834;
  reg n2837;
  reg n2839;
  reg n2841;
  reg n2843;
  reg n2844;
  reg n2845;
  reg n2847;
  reg n2850;
  reg n2853;
  reg n2856;
  reg n2859;
  reg n2862;
  reg n2865;
  reg n2868;
  wire [1:0] n2873;
  wire [2:0] n2874;
  wire [2:0] n2875;
  wire n2877;
  wire n2879;
  wire n2880;
  wire n2882;
  wire n2884;
  wire [2:0] n2885;
  reg [4:0] n2890;
  wire n2892;
  wire n2894;
  wire n2895;
  wire n2897;
  wire n2898;
  wire [2:0] n2899;
  wire n2901;
  wire n2903;
  wire n2904;
  wire n2906;
  wire [1:0] n2907;
  reg [4:0] n2911;
  wire n2913;
  wire [2:0] n2914;
  wire n2916;
  reg [4:0] n2919;
  wire n2921;
  wire [2:0] n2922;
  wire n2924;
  reg [4:0] n2927;
  wire [2:0] n2928;
  reg [4:0] n2929;
  wire n2931;
  wire [2:0] n2932;
  wire [30:0] n2933;
  wire n2935;
  wire n2937;
  wire n2939;
  wire n2941;
  wire n2943;
  wire n2945;
  wire n2947;
  wire [6:0] n2948;
  reg [4:0] n2957;
  wire n2959;
  wire [2:0] n2960;
  wire [30:0] n2961;
  wire [2:0] n2962;
  wire n2964;
  wire n2966;
  wire n2967;
  wire [4:0] n2970;
  wire n2973;
  wire [2:0] n2974;
  wire n2976;
  wire n2978;
  wire n2979;
  wire [4:0] n2982;
  wire n2985;
  wire n2987;
  wire n2989;
  wire [2:0] n2990;
  wire n2992;
  wire [4:0] n2995;
  wire n2998;
  wire n3000;
  wire n3002;
  wire [6:0] n3003;
  reg [4:0] n3009;
  wire n3011;
  wire [2:0] n3012;
  wire [30:0] n3013;
  wire n3015;
  wire [4:0] n3018;
  wire n3020;
  wire n3022;
  wire n3024;
  wire n3026;
  wire n3028;
  wire n3029;
  wire n3031;
  wire [2:0] n3032;
  wire [30:0] n3033;
  wire n3035;
  wire n3037;
  wire n3039;
  wire n3041;
  wire n3043;
  wire n3045;
  wire n3047;
  wire [6:0] n3048;
  reg [4:0] n3057;
  wire [2:0] n3058;
  wire [30:0] n3059;
  wire n3061;
  wire n3063;
  wire n3065;
  wire n3067;
  wire n3069;
  wire n3071;
  wire [2:0] n3072;
  wire n3074;
  wire [4:0] n3077;
  wire n3080;
  wire [6:0] n3081;
  reg [4:0] n3089;
  wire [4:0] n3090;
  wire [4:0] n3092;
  wire [4:0] n3094;
  wire [4:0] n3096;
  wire [4:0] n3098;
  reg [4:0] n3099;
  wire [2:0] n3100;
  reg [4:0] n3101;
  assign lcycle = n2805; //(module output)
  assign alu_op = n3101; //(module output)
  assign set_busa_to = n2807; //(module output)
  assign set_addr_to = n2809; //(module output)
  assign write_data = n2811; //(module output)
  assign jump = n2813; //(module output)
  assign baadd = n2816; //(module output)
  assign baquirk = n2819; //(module output)
  assign breakatna = n2822; //(module output)
  assign adadd = n2825; //(module output)
  assign addy = n2828; //(module output)
  assign pcadd = n2831; //(module output)
  assign inc_s = n2834; //(module output)
  assign dec_s = n2837; //(module output)
  assign lda = n2839; //(module output)
  assign ldp = n2841; //(module output)
  assign ldx = n2843; //(module output)
  assign ldy = n2844; //(module output)
  assign lds = n2845; //(module output)
  assign lddi = n2847; //(module output)
  assign ldalu = n2850; //(module output)
  assign ldad = n2853; //(module output)
  assign ldbal = n2856; //(module output)
  assign ldbah = n2859; //(module output)
  assign savep = n2862; //(module output)
  assign write = n2865; //(module output)
  /*# T65_MCode.vhd:96:10 */
  assign branch = n940; // (signal)
  /*# T65_MCode.vhd:97:10 */
  assign alumore = n2868; // (signal)
  /*# T65_MCode.vhd:101:10 */
  assign n912 = ir[7:5]; // extract
  /*# T65_MCode.vhd:102:20 */
  assign n913 = p[7]; // extract
  /*# T65_MCode.vhd:102:15 */
  assign n914 = ~n913;
  /*# T65_MCode.vhd:102:29 */
  assign n916 = n912 == 3'b000;
  /*# T65_MCode.vhd:103:20 */
  assign n917 = p[7]; // extract
  /*# T65_MCode.vhd:103:29 */
  assign n919 = n912 == 3'b001;
  /*# T65_MCode.vhd:104:20 */
  assign n920 = p[6]; // extract
  /*# T65_MCode.vhd:104:15 */
  assign n921 = ~n920;
  /*# T65_MCode.vhd:104:29 */
  assign n923 = n912 == 3'b010;
  /*# T65_MCode.vhd:105:20 */
  assign n924 = p[6]; // extract
  /*# T65_MCode.vhd:105:29 */
  assign n926 = n912 == 3'b011;
  /*# T65_MCode.vhd:106:20 */
  assign n927 = p[0]; // extract
  /*# T65_MCode.vhd:106:15 */
  assign n928 = ~n927;
  /*# T65_MCode.vhd:106:29 */
  assign n930 = n912 == 3'b100;
  /*# T65_MCode.vhd:107:20 */
  assign n931 = p[0]; // extract
  /*# T65_MCode.vhd:107:29 */
  assign n933 = n912 == 3'b101;
  /*# T65_MCode.vhd:108:20 */
  assign n934 = p[1]; // extract
  /*# T65_MCode.vhd:108:15 */
  assign n935 = ~n934;
  /*# T65_MCode.vhd:108:29 */
  assign n937 = n912 == 3'b110;
  /*# T65_MCode.vhd:109:20 */
  assign n938 = p[1]; // extract
  /*# T65_MCode.vhd:101:3 */
  assign n939 = {n937, n933, n930, n926, n923, n919, n916};
  /*# T65_MCode.vhd:101:3 */
  always @*
    case (n939)
      7'b1000000: n940 = n935;
      7'b0100000: n940 = n931;
      7'b0010000: n940 = n928;
      7'b0001000: n940 = n924;
      7'b0000100: n940 = n921;
      7'b0000010: n940 = n917;
      7'b0000001: n940 = n914;
      default: n940 = n938;
    endcase
  /*# T65_MCode.vhd:140:12 */
  assign n943 = ir[7:5]; // extract
  /*# T65_MCode.vhd:142:16 */
  assign n944 = ir[1:0]; // extract
  /*# T65_MCode.vhd:145:18 */
  assign n945 = ir[4:2]; // extract
  /*# T65_MCode.vhd:145:30 */
  assign n947 = n945 == 3'b111;
  /*# T65_MCode.vhd:146:26 */
  assign n948 = ~rdy_mod;
  /*# T65_MCode.vhd:146:15 */
  assign n951 = n948 ? 4'b1011 : 4'b0011;
  /*# T65_MCode.vhd:145:13 */
  assign n953 = n947 ? n951 : 4'b0011;
  /*# T65_MCode.vhd:143:11 */
  assign n955 = n944 == 2'b00;
  /*# T65_MCode.vhd:156:18 */
  assign n956 = ir[4:2]; // extract
  /*# T65_MCode.vhd:156:30 */
  assign n958 = n956 == 3'b111;
  /*# T65_MCode.vhd:157:26 */
  assign n959 = ~rdy_mod;
  /*# T65_MCode.vhd:157:15 */
  assign n962 = n959 ? 4'b1010 : 4'b0010;
  /*# T65_MCode.vhd:156:13 */
  assign n964 = n958 ? n962 : 4'b0010;
  /*# T65_MCode.vhd:154:11 */
  assign n966 = n944 == 2'b10;
  /*# T65_MCode.vhd:166:18 */
  assign n967 = ir[4:2]; // extract
  /*# T65_MCode.vhd:166:30 */
  assign n969 = n967 == 3'b110;
  /*# T65_MCode.vhd:166:13 */
  assign n972 = n969 ? 4'b1001 : 4'b0001;
  /*# T65_MCode.vhd:166:13 */
  assign n975 = n969 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:172:18 */
  assign n976 = ir[4:2]; // extract
  /*# T65_MCode.vhd:172:30 */
  assign n978 = n976 == 3'b111;
  /*# T65_MCode.vhd:172:42 */
  assign n979 = ir[4:2]; // extract
  /*# T65_MCode.vhd:172:54 */
  assign n981 = n979 == 3'b110;
  /*# T65_MCode.vhd:172:37 */
  assign n982 = n978 | n981;
  /*# T65_MCode.vhd:172:66 */
  assign n983 = ir[4:2]; // extract
  /*# T65_MCode.vhd:172:78 */
  assign n985 = n983 == 3'b100;
  /*# T65_MCode.vhd:172:61 */
  assign n986 = n982 | n985;
  /*# T65_MCode.vhd:173:26 */
  assign n987 = ~rdy_mod;
  /*# T65_MCode.vhd:173:15 */
  assign n990 = n987 ? 4'b1001 : 4'b1000;
  /*# T65_MCode.vhd:172:13 */
  assign n992 = n986 ? n990 : 4'b1000;
  /*# T65_MCode.vhd:165:11 */
  assign n994 = n944 == 2'b11;
  /*# T65_MCode.vhd:142:9 */
  assign n995 = {n994, n966, n955};
  /*# T65_MCode.vhd:142:9 */
  always @*
    case (n995)
      3'b100: n999 = n972;
      3'b010: n999 = 4'b0010;
      3'b001: n999 = 4'b0011;
      default: n999 = 4'b0001;
    endcase
  /*# T65_MCode.vhd:142:9 */
  always @*
    case (n995)
      3'b100: n1001 = n992;
      3'b010: n1001 = n964;
      3'b001: n1001 = n953;
      default: n1001 = 4'b0001;
    endcase
  /*# T65_MCode.vhd:142:9 */
  always @*
    case (n995)
      3'b100: n1003 = n975;
      3'b010: n1003 = 1'b0;
      3'b001: n1003 = 1'b0;
      default: n1003 = 1'b0;
    endcase
  /*# T65_MCode.vhd:141:7 */
  assign n1005 = n943 == 3'b100;
  /*# T65_MCode.vhd:186:16 */
  assign n1006 = ir[1:0]; // extract
  /*# T65_MCode.vhd:188:18 */
  assign n1007 = ir[4]; // extract
  /*# T65_MCode.vhd:188:22 */
  assign n1009 = n1007 != 1'b1;
  /*# T65_MCode.vhd:188:34 */
  assign n1010 = ir[2]; // extract
  /*# T65_MCode.vhd:188:38 */
  assign n1012 = n1010 != 1'b0;
  /*# T65_MCode.vhd:188:29 */
  assign n1013 = n1009 | n1012;
  /*# T65_MCode.vhd:188:13 */
  assign n1016 = n1013 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:187:11 */
  assign n1018 = n1006 == 2'b00;
  /*# T65_MCode.vhd:191:11 */
  assign n1020 = n1006 == 2'b01;
  /*# T65_MCode.vhd:193:11 */
  assign n1022 = n1006 == 2'b10;
  /*# T65_MCode.vhd:198:18 */
  assign n1023 = ir[4:2]; // extract
  /*# T65_MCode.vhd:198:30 */
  assign n1025 = n1023 == 3'b110;
  /*# T65_MCode.vhd:198:13 */
  assign n1028 = n1025 ? 4'b0100 : 4'b0000;
  /*# T65_MCode.vhd:198:13 */
  assign n1031 = n1025 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:186:9 */
  assign n1032 = {n1022, n1020, n1018};
  /*# T65_MCode.vhd:186:9 */
  always @*
    case (n1032)
      3'b100: n1034 = 4'b0000;
      3'b010: n1034 = 4'b0000;
      3'b001: n1034 = 4'b0000;
      default: n1034 = n1028;
    endcase
  /*# T65_MCode.vhd:186:9 */
  always @*
    case (n1032)
      3'b100: n1039 = 1'b0;
      3'b010: n1039 = 1'b1;
      3'b001: n1039 = 1'b0;
      default: n1039 = 1'b1;
    endcase
  /*# T65_MCode.vhd:186:9 */
  always @*
    case (n1032)
      3'b100: n1043 = 1'b1;
      3'b010: n1043 = 1'b0;
      3'b001: n1043 = 1'b0;
      default: n1043 = 1'b1;
    endcase
  /*# T65_MCode.vhd:186:9 */
  always @*
    case (n1032)
      3'b100: n1045 = 1'b0;
      3'b010: n1045 = 1'b0;
      3'b001: n1045 = n1016;
      default: n1045 = 1'b0;
    endcase
  /*# T65_MCode.vhd:186:9 */
  always @*
    case (n1032)
      3'b100: n1047 = 1'b0;
      3'b010: n1047 = 1'b0;
      3'b001: n1047 = 1'b0;
      default: n1047 = n1031;
    endcase
  /*# T65_MCode.vhd:184:7 */
  assign n1049 = n943 == 3'b101;
  /*# T65_MCode.vhd:204:16 */
  assign n1050 = ir[1:0]; // extract
  /*# T65_MCode.vhd:206:18 */
  assign n1051 = ir[4]; // extract
  /*# T65_MCode.vhd:206:22 */
  assign n1052 = ~n1051;
  /*# T65_MCode.vhd:206:13 */
  assign n1055 = n1052 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:205:11 */
  assign n1057 = n1050 == 2'b00;
  /*# T65_MCode.vhd:204:9 */
  always @*
    case (n1057)
      1'b1: n1060 = 4'b0011;
      default: n1060 = 4'b0001;
    endcase
  /*# T65_MCode.vhd:204:9 */
  always @*
    case (n1057)
      1'b1: n1062 = n1055;
      default: n1062 = 1'b0;
    endcase
  /*# T65_MCode.vhd:203:7 */
  assign n1064 = n943 == 3'b110;
  /*# T65_MCode.vhd:214:16 */
  assign n1065 = ir[1:0]; // extract
  /*# T65_MCode.vhd:216:16 */
  assign n1066 = ir[4]; // extract
  /*# T65_MCode.vhd:216:20 */
  assign n1067 = ~n1066;
  /*# T65_MCode.vhd:216:11 */
  assign n1070 = n1067 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:215:9 */
  assign n1072 = n1065 == 2'b00;
  /*# T65_MCode.vhd:214:9 */
  always @*
    case (n1072)
      1'b1: n1075 = 4'b0010;
      default: n1075 = 4'b0001;
    endcase
  /*# T65_MCode.vhd:214:9 */
  always @*
    case (n1072)
      1'b1: n1077 = n1070;
      default: n1077 = 1'b0;
    endcase
  /*# T65_MCode.vhd:213:7 */
  assign n1079 = n943 == 3'b111;
  /*# T65_MCode.vhd:140:5 */
  assign n1080 = {n1079, n1064, n1049, n1005};
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1082 = n1075;
      4'b0100: n1082 = n1060;
      4'b0010: n1082 = n1034;
      4'b0001: n1082 = n999;
      default: n1082 = 4'b0001;
    endcase
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1085 = 4'b0000;
      4'b0100: n1085 = 4'b0000;
      4'b0010: n1085 = 4'b0000;
      4'b0001: n1085 = n1001;
      default: n1085 = 4'b0000;
    endcase
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1088 = 1'b0;
      4'b0100: n1088 = 1'b0;
      4'b0010: n1088 = n1039;
      4'b0001: n1088 = 1'b0;
      default: n1088 = 1'b0;
    endcase
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1091 = n1077;
      4'b0100: n1091 = 1'b0;
      4'b0010: n1091 = n1043;
      4'b0001: n1091 = 1'b0;
      default: n1091 = 1'b0;
    endcase
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1094 = 1'b0;
      4'b0100: n1094 = n1062;
      4'b0010: n1094 = n1045;
      4'b0001: n1094 = 1'b0;
      default: n1094 = 1'b0;
    endcase
  /*# T65_MCode.vhd:140:5 */
  always @*
    case (n1080)
      4'b1000: n1097 = 1'b0;
      4'b0100: n1097 = 1'b0;
      4'b0010: n1097 = n1047;
      4'b0001: n1097 = n1003;
      default: n1097 = 1'b0;
    endcase
  /*# T65_MCode.vhd:226:10 */
  assign n1099 = ir[7:6]; // extract
  /*# T65_MCode.vhd:226:23 */
  assign n1101 = n1099 != 2'b10;
  /*# T65_MCode.vhd:226:37 */
  assign n1102 = ir[1]; // extract
  /*# T65_MCode.vhd:226:31 */
  assign n1103 = n1102 & n1101;
  /*# T65_MCode.vhd:226:56 */
  assign n1105 = mode == 2'b00;
  /*# T65_MCode.vhd:226:67 */
  assign n1106 = ir[0]; // extract
  /*# T65_MCode.vhd:226:70 */
  assign n1107 = ~n1106;
  /*# T65_MCode.vhd:226:62 */
  assign n1108 = n1105 | n1107;
  /*# T65_MCode.vhd:226:47 */
  assign n1109 = n1108 & n1103;
  /*# T65_MCode.vhd:227:12 */
  assign n1111 = ir == 8'b11101011;
  /*# T65_MCode.vhd:227:7 */
  assign n1114 = n1111 ? 4'b0001 : 4'b0000;
  /*# T65_MCode.vhd:226:5 */
  assign n1115 = n1109 ? n1114 : n1082;
  /*# T65_MCode.vhd:234:12 */
  assign n1116 = ir[4:0]; // extract
  /*# T65_MCode.vhd:247:15 */
  assign n1118 = mcycle == 3'b001;
  /*# T65_MCode.vhd:251:15 */
  assign n1120 = mcycle == 3'b010;
  /*# T65_MCode.vhd:256:15 */
  assign n1122 = mcycle == 3'b011;
  /*# T65_MCode.vhd:261:15 */
  assign n1124 = mcycle == 3'b100;
  /*# T65_MCode.vhd:264:15 */
  assign n1126 = mcycle == 3'b101;
  /*# T65_MCode.vhd:267:15 */
  assign n1128 = mcycle == 3'b110;
  /*# T65_MCode.vhd:246:13 */
  assign n1129 = {n1128, n1126, n1124, n1122, n1120, n1118};
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1136 = 2'b00;
      6'b010000: n1136 = 2'b11;
      6'b001000: n1136 = 2'b11;
      6'b000100: n1136 = 2'b01;
      6'b000010: n1136 = 2'b01;
      6'b000001: n1136 = 2'b01;
      default: n1136 = 2'b00;
    endcase
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1140 = n1085;
      6'b010000: n1140 = n1085;
      6'b001000: n1140 = n1085;
      6'b000100: n1140 = 4'b0101;
      6'b000010: n1140 = 4'b0110;
      6'b000001: n1140 = 4'b0111;
      default: n1140 = n1085;
    endcase
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1143 = 2'b10;
      6'b010000: n1143 = 2'b00;
      6'b001000: n1143 = 2'b00;
      6'b000100: n1143 = 2'b00;
      6'b000010: n1143 = 2'b00;
      6'b000001: n1143 = 2'b00;
      default: n1143 = 2'b00;
    endcase
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1148 = 1'b0;
      6'b010000: n1148 = 1'b0;
      6'b001000: n1148 = 1'b1;
      6'b000100: n1148 = 1'b1;
      6'b000010: n1148 = 1'b1;
      6'b000001: n1148 = 1'b0;
      default: n1148 = 1'b0;
    endcase
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1151 = 1'b0;
      6'b010000: n1151 = 1'b1;
      6'b001000: n1151 = 1'b0;
      6'b000100: n1151 = 1'b0;
      6'b000010: n1151 = 1'b0;
      6'b000001: n1151 = 1'b0;
      default: n1151 = 1'b0;
    endcase
  /*# T65_MCode.vhd:246:13 */
  always @*
    case (n1129)
      6'b100000: n1156 = 1'b0;
      6'b010000: n1156 = 1'b0;
      6'b001000: n1156 = 1'b0;
      6'b000100: n1156 = 1'b1;
      6'b000010: n1156 = 1'b1;
      6'b000001: n1156 = 1'b1;
      default: n1156 = 1'b0;
    endcase
  /*# T65_MCode.vhd:243:11 */
  assign n1158 = ir == 8'b00000000;
  /*# T65_MCode.vhd:274:15 */
  assign n1160 = mcycle == 3'b001;
  /*# T65_MCode.vhd:278:15 */
  assign n1162 = mcycle == 3'b010;
  /*# T65_MCode.vhd:282:15 */
  assign n1164 = mcycle == 3'b011;
  /*# T65_MCode.vhd:287:15 */
  assign n1166 = mcycle == 3'b100;
  /*# T65_MCode.vhd:289:15 */
  assign n1168 = mcycle == 3'b101;
  /*# T65_MCode.vhd:273:13 */
  assign n1169 = {n1168, n1166, n1164, n1162, n1160};
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1174 = 2'b00;
      5'b01000: n1174 = 2'b00;
      5'b00100: n1174 = 2'b01;
      5'b00010: n1174 = 2'b01;
      5'b00001: n1174 = 2'b01;
      default: n1174 = 2'b00;
    endcase
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1177 = n1085;
      5'b01000: n1177 = n1085;
      5'b00100: n1177 = 4'b0110;
      5'b00010: n1177 = 4'b0111;
      5'b00001: n1177 = n1085;
      default: n1177 = n1085;
    endcase
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1181 = 2'b10;
      5'b01000: n1181 = 2'b00;
      5'b00100: n1181 = 2'b00;
      5'b00010: n1181 = 2'b00;
      5'b00001: n1181 = 2'b01;
      default: n1181 = 2'b00;
    endcase
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1185 = 1'b0;
      5'b01000: n1185 = 1'b1;
      5'b00100: n1185 = 1'b1;
      5'b00010: n1185 = 1'b0;
      5'b00001: n1185 = 1'b0;
      default: n1185 = 1'b0;
    endcase
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1188 = 1'b0;
      5'b01000: n1188 = 1'b0;
      5'b00100: n1188 = 1'b0;
      5'b00010: n1188 = 1'b0;
      5'b00001: n1188 = 1'b1;
      default: n1188 = 1'b0;
    endcase
  /*# T65_MCode.vhd:273:13 */
  always @*
    case (n1169)
      5'b10000: n1192 = 1'b0;
      5'b01000: n1192 = 1'b0;
      5'b00100: n1192 = 1'b1;
      5'b00010: n1192 = 1'b1;
      5'b00001: n1192 = 1'b0;
      default: n1192 = 1'b0;
    endcase
  /*# T65_MCode.vhd:271:11 */
  assign n1194 = ir == 8'b00100000;
  /*# T65_MCode.vhd:296:15 */
  assign n1196 = mcycle == 3'b001;
  /*# T65_MCode.vhd:298:15 */
  assign n1198 = mcycle == 3'b010;
  /*# T65_MCode.vhd:301:15 */
  assign n1200 = mcycle == 3'b011;
  /*# T65_MCode.vhd:305:15 */
  assign n1202 = mcycle == 3'b100;
  /*# T65_MCode.vhd:310:15 */
  assign n1204 = mcycle == 3'b101;
  /*# T65_MCode.vhd:295:15 */
  assign n1205 = {n1204, n1202, n1200, n1198, n1196};
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1207 = n1115;
      5'b01000: n1207 = n1115;
      5'b00100: n1207 = 4'b0000;
      5'b00010: n1207 = n1115;
      5'b00001: n1207 = n1115;
      default: n1207 = n1115;
    endcase
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1213 = 2'b00;
      5'b01000: n1213 = 2'b01;
      5'b00100: n1213 = 2'b01;
      5'b00010: n1213 = 2'b01;
      5'b00001: n1213 = 2'b01;
      default: n1213 = 2'b00;
    endcase
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1216 = 2'b10;
      5'b01000: n1216 = 2'b00;
      5'b00100: n1216 = 2'b00;
      5'b00010: n1216 = 2'b00;
      5'b00001: n1216 = 2'b00;
      default: n1216 = 2'b00;
    endcase
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1221 = 1'b0;
      5'b01000: n1221 = 1'b1;
      5'b00100: n1221 = 1'b1;
      5'b00010: n1221 = 1'b1;
      5'b00001: n1221 = 1'b0;
      default: n1221 = 1'b0;
    endcase
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1224 = 1'b0;
      5'b01000: n1224 = 1'b1;
      5'b00100: n1224 = 1'b0;
      5'b00010: n1224 = 1'b0;
      5'b00001: n1224 = 1'b0;
      default: n1224 = 1'b0;
    endcase
  /*# T65_MCode.vhd:295:15 */
  always @*
    case (n1205)
      5'b10000: n1227 = 1'b0;
      5'b01000: n1227 = 1'b1;
      5'b00100: n1227 = 1'b0;
      5'b00010: n1227 = 1'b0;
      5'b00001: n1227 = 1'b0;
      default: n1227 = 1'b0;
    endcase
  /*# T65_MCode.vhd:293:13 */
  assign n1229 = ir == 8'b01000000;
  /*# T65_MCode.vhd:317:15 */
  assign n1231 = mcycle == 3'b001;
  /*# T65_MCode.vhd:319:15 */
  assign n1233 = mcycle == 3'b010;
  /*# T65_MCode.vhd:322:15 */
  assign n1235 = mcycle == 3'b011;
  /*# T65_MCode.vhd:326:15 */
  assign n1237 = mcycle == 3'b100;
  /*# T65_MCode.vhd:328:15 */
  assign n1239 = mcycle == 3'b101;
  /*# T65_MCode.vhd:316:13 */
  assign n1240 = {n1239, n1237, n1235, n1233, n1231};
  /*# T65_MCode.vhd:316:13 */
  always @*
    case (n1240)
      5'b10000: n1245 = 2'b00;
      5'b01000: n1245 = 2'b00;
      5'b00100: n1245 = 2'b01;
      5'b00010: n1245 = 2'b01;
      5'b00001: n1245 = 2'b01;
      default: n1245 = 2'b00;
    endcase
  /*# T65_MCode.vhd:316:13 */
  always @*
    case (n1240)
      5'b10000: n1249 = 2'b01;
      5'b01000: n1249 = 2'b10;
      5'b00100: n1249 = 2'b00;
      5'b00010: n1249 = 2'b00;
      5'b00001: n1249 = 2'b00;
      default: n1249 = 2'b00;
    endcase
  /*# T65_MCode.vhd:316:13 */
  always @*
    case (n1240)
      5'b10000: n1253 = 1'b0;
      5'b01000: n1253 = 1'b0;
      5'b00100: n1253 = 1'b1;
      5'b00010: n1253 = 1'b1;
      5'b00001: n1253 = 1'b0;
      default: n1253 = 1'b0;
    endcase
  /*# T65_MCode.vhd:316:13 */
  always @*
    case (n1240)
      5'b10000: n1256 = 1'b0;
      5'b01000: n1256 = 1'b0;
      5'b00100: n1256 = 1'b1;
      5'b00010: n1256 = 1'b0;
      5'b00001: n1256 = 1'b0;
      default: n1256 = 1'b0;
    endcase
  /*# T65_MCode.vhd:314:11 */
  assign n1258 = ir == 8'b01100000;
  /*# T65_MCode.vhd:334:23 */
  assign n1260 = mode == 2'b00;
  /*# T65_MCode.vhd:334:36 */
  assign n1261 = ir[1]; // extract
  /*# T65_MCode.vhd:334:30 */
  assign n1262 = n1261 & n1260;
  /*# T65_MCode.vhd:334:15 */
  assign n1265 = n1262 ? 3'b001 : 3'b010;
  /*# T65_MCode.vhd:339:24 */
  assign n1268 = mode != 2'b00;
  /*# T65_MCode.vhd:339:36 */
  assign n1269 = ir[1]; // extract
  /*# T65_MCode.vhd:339:39 */
  assign n1270 = ~n1269;
  /*# T65_MCode.vhd:339:31 */
  assign n1271 = n1268 | n1270;
  /*# T65_MCode.vhd:341:26 */
  assign n1272 = ir[7:4]; // extract
  /*# T65_MCode.vhd:342:19 */
  assign n1274 = n1272 == 4'b0000;
  /*# T65_MCode.vhd:344:19 */
  assign n1276 = n1272 == 4'b0100;
  /*# T65_MCode.vhd:347:29 */
  assign n1278 = mode != 2'b00;
  /*# T65_MCode.vhd:347:21 */
  assign n1280 = n1278 ? 4'b0011 : n1085;
  /*# T65_MCode.vhd:347:21 */
  assign n1283 = n1278 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:346:19 */
  assign n1285 = n1272 == 4'b0101;
  /*# T65_MCode.vhd:353:29 */
  assign n1287 = mode != 2'b00;
  /*# T65_MCode.vhd:353:21 */
  assign n1289 = n1287 ? 4'b0010 : n1085;
  /*# T65_MCode.vhd:353:21 */
  assign n1292 = n1287 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:352:19 */
  assign n1294 = n1272 == 4'b1101;
  /*# T65_MCode.vhd:341:19 */
  assign n1295 = {n1294, n1285, n1276, n1274};
  /*# T65_MCode.vhd:341:19 */
  always @*
    case (n1295)
      4'b1000: n1298 = n1289;
      4'b0100: n1298 = n1280;
      4'b0010: n1298 = 4'b0001;
      4'b0001: n1298 = 4'b0101;
      default: n1298 = n1085;
    endcase
  /*# T65_MCode.vhd:341:19 */
  always @*
    case (n1295)
      4'b1000: n1300 = n1292;
      4'b0100: n1300 = n1283;
      4'b0010: n1300 = 1'b1;
      4'b0001: n1300 = 1'b1;
      default: n1300 = 1'b1;
    endcase
  /*# T65_MCode.vhd:339:17 */
  assign n1304 = n1271 ? 2'b01 : 2'b00;
  /*# T65_MCode.vhd:339:17 */
  assign n1305 = n1271 ? n1298 : n1085;
  /*# T65_MCode.vhd:339:17 */
  assign n1307 = n1271 ? n1300 : 1'b0;
  /*# T65_MCode.vhd:338:15 */
  assign n1309 = mcycle == 3'b001;
  /*# T65_MCode.vhd:362:15 */
  assign n1311 = mcycle == 3'b010;
  /*# T65_MCode.vhd:337:15 */
  assign n1312 = {n1311, n1309};
  /*# T65_MCode.vhd:337:15 */
  always @*
    case (n1312)
      2'b10: n1314 = 2'b00;
      2'b01: n1314 = n1304;
      default: n1314 = 2'b00;
    endcase
  /*# T65_MCode.vhd:337:15 */
  always @*
    case (n1312)
      2'b10: n1315 = n1085;
      2'b01: n1315 = n1305;
      default: n1315 = n1085;
    endcase
  /*# T65_MCode.vhd:337:15 */
  always @*
    case (n1312)
      2'b10: n1318 = 1'b1;
      2'b01: n1318 = 1'b0;
      default: n1318 = 1'b0;
    endcase
  /*# T65_MCode.vhd:337:15 */
  always @*
    case (n1312)
      2'b10: n1320 = 1'b0;
      2'b01: n1320 = n1307;
      default: n1320 = 1'b0;
    endcase
  /*# T65_MCode.vhd:332:13 */
  assign n1322 = ir == 8'b00001000;
  /*# T65_MCode.vhd:332:24 */
  assign n1324 = ir == 8'b01001000;
  /*# T65_MCode.vhd:332:24 */
  assign n1325 = n1322 | n1324;
  /*# T65_MCode.vhd:332:32 */
  assign n1327 = ir == 8'b01011010;
  /*# T65_MCode.vhd:332:32 */
  assign n1328 = n1325 | n1327;
  /*# T65_MCode.vhd:332:40 */
  assign n1330 = ir == 8'b11011010;
  /*# T65_MCode.vhd:332:40 */
  assign n1331 = n1328 | n1330;
  /*# T65_MCode.vhd:368:21 */
  assign n1333 = mode == 2'b00;
  /*# T65_MCode.vhd:368:34 */
  assign n1334 = ir[1]; // extract
  /*# T65_MCode.vhd:368:28 */
  assign n1335 = n1334 & n1333;
  /*# T65_MCode.vhd:368:13 */
  assign n1338 = n1335 ? 3'b001 : 3'b011;
  /*# T65_MCode.vhd:371:20 */
  assign n1340 = ir[7:4]; // extract
  /*# T65_MCode.vhd:372:15 */
  assign n1342 = n1340 == 4'b0010;
  /*# T65_MCode.vhd:374:15 */
  assign n1344 = n1340 == 4'b0110;
  /*# T65_MCode.vhd:377:25 */
  assign n1346 = mode != 2'b00;
  /*# T65_MCode.vhd:377:17 */
  assign n1348 = n1346 ? 1'b1 : n1094;
  /*# T65_MCode.vhd:376:15 */
  assign n1350 = n1340 == 4'b0111;
  /*# T65_MCode.vhd:381:25 */
  assign n1352 = mode != 2'b00;
  /*# T65_MCode.vhd:381:17 */
  assign n1354 = n1352 ? 1'b1 : n1091;
  /*# T65_MCode.vhd:380:15 */
  assign n1356 = n1340 == 4'b1111;
  /*# T65_MCode.vhd:371:13 */
  assign n1357 = {n1356, n1350, n1344, n1342};
  /*# T65_MCode.vhd:371:13 */
  always @*
    case (n1357)
      4'b1000: n1359 = n1088;
      4'b0100: n1359 = n1088;
      4'b0010: n1359 = 1'b1;
      4'b0001: n1359 = n1088;
      default: n1359 = n1088;
    endcase
  /*# T65_MCode.vhd:371:13 */
  always @*
    case (n1357)
      4'b1000: n1362 = 1'b0;
      4'b0100: n1362 = 1'b0;
      4'b0010: n1362 = 1'b0;
      4'b0001: n1362 = 1'b1;
      default: n1362 = 1'b0;
    endcase
  /*# T65_MCode.vhd:371:13 */
  always @*
    case (n1357)
      4'b1000: n1363 = n1354;
      4'b0100: n1363 = n1091;
      4'b0010: n1363 = n1091;
      4'b0001: n1363 = n1091;
      default: n1363 = n1091;
    endcase
  /*# T65_MCode.vhd:371:13 */
  always @*
    case (n1357)
      4'b1000: n1364 = n1094;
      4'b0100: n1364 = n1348;
      4'b0010: n1364 = n1094;
      4'b0001: n1364 = n1094;
      default: n1364 = n1094;
    endcase
  /*# T65_MCode.vhd:388:25 */
  assign n1366 = mode != 2'b00;
  /*# T65_MCode.vhd:388:38 */
  assign n1367 = ir[1]; // extract
  /*# T65_MCode.vhd:388:42 */
  assign n1368 = ~n1367;
  /*# T65_MCode.vhd:388:33 */
  assign n1369 = n1366 | n1368;
  /*# T65_MCode.vhd:388:17 */
  assign n1372 = n1369 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:387:15 */
  assign n1374 = mcycle == 3'b000;
  /*# T65_MCode.vhd:392:25 */
  assign n1376 = mode != 2'b00;
  /*# T65_MCode.vhd:392:38 */
  assign n1377 = ir[1]; // extract
  /*# T65_MCode.vhd:392:42 */
  assign n1378 = ~n1377;
  /*# T65_MCode.vhd:392:33 */
  assign n1379 = n1376 | n1378;
  /*# T65_MCode.vhd:392:17 */
  assign n1382 = n1379 ? 2'b01 : 2'b00;
  /*# T65_MCode.vhd:392:17 */
  assign n1384 = n1379 ? 1'b0 : n1362;
  /*# T65_MCode.vhd:391:15 */
  assign n1386 = mcycle == 3'b001;
  /*# T65_MCode.vhd:396:15 */
  assign n1388 = mcycle == 3'b010;
  /*# T65_MCode.vhd:400:15 */
  assign n1390 = mcycle == 3'b011;
  /*# T65_MCode.vhd:386:13 */
  assign n1391 = {n1390, n1388, n1386, n1374};
  /*# T65_MCode.vhd:386:13 */
  always @*
    case (n1391)
      4'b1000: n1393 = 4'b0000;
      4'b0100: n1393 = n1115;
      4'b0010: n1393 = n1115;
      4'b0001: n1393 = n1115;
      default: n1393 = n1115;
    endcase
  /*# T65_MCode.vhd:386:13 */
  always @*
    case (n1391)
      4'b1000: n1396 = 2'b00;
      4'b0100: n1396 = 2'b01;
      4'b0010: n1396 = n1382;
      4'b0001: n1396 = 2'b00;
      default: n1396 = 2'b00;
    endcase
  /*# T65_MCode.vhd:386:13 */
  always @*
    case (n1391)
      4'b1000: n1399 = 1'b0;
      4'b0100: n1399 = 1'b1;
      4'b0010: n1399 = 1'b0;
      4'b0001: n1399 = 1'b0;
      default: n1399 = 1'b0;
    endcase
  /*# T65_MCode.vhd:386:13 */
  always @*
    case (n1391)
      4'b1000: n1401 = n1362;
      4'b0100: n1401 = 1'b0;
      4'b0010: n1401 = n1384;
      4'b0001: n1401 = n1362;
      default: n1401 = n1362;
    endcase
  /*# T65_MCode.vhd:386:13 */
  always @*
    case (n1391)
      4'b1000: n1403 = 1'b0;
      4'b0100: n1403 = 1'b0;
      4'b0010: n1403 = 1'b0;
      4'b0001: n1403 = n1372;
      default: n1403 = 1'b0;
    endcase
  /*# T65_MCode.vhd:366:11 */
  assign n1405 = ir == 8'b00101000;
  /*# T65_MCode.vhd:366:23 */
  assign n1407 = ir == 8'b01101000;
  /*# T65_MCode.vhd:366:23 */
  assign n1408 = n1405 | n1407;
  /*# T65_MCode.vhd:366:31 */
  assign n1410 = ir == 8'b01111010;
  /*# T65_MCode.vhd:366:31 */
  assign n1411 = n1408 | n1410;
  /*# T65_MCode.vhd:366:39 */
  assign n1413 = ir == 8'b11111010;
  /*# T65_MCode.vhd:366:39 */
  assign n1414 = n1411 | n1413;
  /*# T65_MCode.vhd:407:15 */
  assign n1416 = mcycle == 3'b000;
  /*# T65_MCode.vhd:408:15 */
  assign n1418 = mcycle == 3'b001;
  /*# T65_MCode.vhd:406:13 */
  assign n1419 = {n1418, n1416};
  /*# T65_MCode.vhd:406:13 */
  always @*
    case (n1419)
      2'b10: n1422 = 2'b01;
      2'b01: n1422 = 2'b00;
      default: n1422 = 2'b00;
    endcase
  /*# T65_MCode.vhd:404:11 */
  assign n1424 = ir == 8'b10100000;
  /*# T65_MCode.vhd:404:22 */
  assign n1426 = ir == 8'b11000000;
  /*# T65_MCode.vhd:404:22 */
  assign n1427 = n1424 | n1426;
  /*# T65_MCode.vhd:404:30 */
  assign n1429 = ir == 8'b11100000;
  /*# T65_MCode.vhd:404:30 */
  assign n1430 = n1427 | n1429;
  /*# T65_MCode.vhd:415:15 */
  assign n1432 = mcycle == 3'b000;
  /*# T65_MCode.vhd:416:15 */
  assign n1434 = mcycle == 3'b001;
  /*# T65_MCode.vhd:414:13 */
  assign n1435 = {n1434, n1432};
  /*# T65_MCode.vhd:414:13 */
  always @*
    case (n1435)
      2'b10: n1437 = 4'b0011;
      2'b01: n1437 = n1115;
      default: n1437 = n1115;
    endcase
  /*# T65_MCode.vhd:412:11 */
  assign n1439 = ir == 8'b10001000;
  /*# T65_MCode.vhd:423:15 */
  assign n1441 = mcycle == 3'b000;
  /*# T65_MCode.vhd:424:15 */
  assign n1443 = mcycle == 3'b001;
  /*# T65_MCode.vhd:422:13 */
  assign n1444 = {n1443, n1441};
  /*# T65_MCode.vhd:422:13 */
  always @*
    case (n1444)
      2'b10: n1446 = 4'b0010;
      2'b01: n1446 = n1115;
      default: n1446 = n1115;
    endcase
  /*# T65_MCode.vhd:420:11 */
  assign n1448 = ir == 8'b11001010;
  /*# T65_MCode.vhd:429:21 */
  assign n1450 = mode != 2'b00;
  /*# T65_MCode.vhd:429:13 */
  assign n1452 = n1450 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:435:15 */
  assign n1454 = mcycle == 3'b000;
  /*# T65_MCode.vhd:436:15 */
  assign n1456 = mcycle == 3'b001;
  /*# T65_MCode.vhd:434:13 */
  assign n1457 = {n1456, n1454};
  /*# T65_MCode.vhd:434:13 */
  always @*
    case (n1457)
      2'b10: n1459 = 4'b0100;
      2'b01: n1459 = n1115;
      default: n1459 = n1115;
    endcase
  /*# T65_MCode.vhd:428:11 */
  assign n1461 = ir == 8'b00011010;
  /*# T65_MCode.vhd:428:22 */
  assign n1463 = ir == 8'b00111010;
  /*# T65_MCode.vhd:428:22 */
  assign n1464 = n1461 | n1463;
  /*# T65_MCode.vhd:440:11 */
  assign n1471 = ir == 8'b00001010;
  /*# T65_MCode.vhd:440:22 */
  assign n1473 = ir == 8'b00101010;
  /*# T65_MCode.vhd:440:22 */
  assign n1474 = n1471 | n1473;
  /*# T65_MCode.vhd:440:30 */
  assign n1476 = ir == 8'b01001010;
  /*# T65_MCode.vhd:440:30 */
  assign n1477 = n1474 | n1476;
  /*# T65_MCode.vhd:440:38 */
  assign n1479 = ir == 8'b01101010;
  /*# T65_MCode.vhd:440:38 */
  assign n1480 = n1477 | n1479;
  /*# T65_MCode.vhd:448:11 */
  assign n1487 = ir == 8'b10001010;
  /*# T65_MCode.vhd:448:22 */
  assign n1489 = ir == 8'b10011000;
  /*# T65_MCode.vhd:448:22 */
  assign n1490 = n1487 | n1489;
  /*# T65_MCode.vhd:457:15 */
  assign n1492 = mcycle == 3'b000;
  /*# T65_MCode.vhd:458:15 */
  assign n1494 = mcycle == 3'b001;
  /*# T65_MCode.vhd:456:13 */
  assign n1495 = {n1494, n1492};
  /*# T65_MCode.vhd:456:13 */
  always @*
    case (n1495)
      2'b10: n1497 = 4'b0001;
      2'b01: n1497 = n1115;
      default: n1497 = n1115;
    endcase
  /*# T65_MCode.vhd:455:11 */
  assign n1499 = ir == 8'b10101010;
  /*# T65_MCode.vhd:455:22 */
  assign n1501 = ir == 8'b10101000;
  /*# T65_MCode.vhd:455:22 */
  assign n1502 = n1499 | n1501;
  /*# T65_MCode.vhd:462:11 */
  assign n1504 = ir == 8'b10011010;
  /*# T65_MCode.vhd:467:15 */
  assign n1506 = mcycle == 3'b000;
  /*# T65_MCode.vhd:468:15 */
  assign n1508 = mcycle == 3'b001;
  /*# T65_MCode.vhd:466:13 */
  assign n1509 = {n1508, n1506};
  /*# T65_MCode.vhd:466:13 */
  always @*
    case (n1509)
      2'b10: n1511 = 4'b0100;
      2'b01: n1511 = n1115;
      default: n1511 = n1115;
    endcase
  /*# T65_MCode.vhd:464:11 */
  assign n1513 = ir == 8'b10111010;
  /*# T65_MCode.vhd:474:15 */
  assign n1515 = mcycle == 3'b000;
  /*# T65_MCode.vhd:475:15 */
  assign n1517 = mcycle == 3'b001;
  /*# T65_MCode.vhd:473:13 */
  assign n1518 = {n1517, n1515};
  /*# T65_MCode.vhd:473:13 */
  always @*
    case (n1518)
      2'b10: n1521 = 2'b01;
      2'b01: n1521 = 2'b00;
      default: n1521 = 2'b00;
    endcase
  /*# T65_MCode.vhd:472:11 */
  assign n1523 = ir == 8'b10000000;
  /*# T65_MCode.vhd:242:9 */
  assign n1526 = {n1523, n1513, n1504, n1502, n1490, n1480, n1464, n1448, n1439, n1430, n1414, n1331, n1258, n1229, n1194, n1158};
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1532 = 3'b001;
      16'b0100000000000000: n1532 = 3'b001;
      16'b0010000000000000: n1532 = 3'b001;
      16'b0001000000000000: n1532 = 3'b001;
      16'b0000100000000000: n1532 = 3'b001;
      16'b0000010000000000: n1532 = 3'b001;
      16'b0000001000000000: n1532 = 3'b001;
      16'b0000000100000000: n1532 = 3'b001;
      16'b0000000010000000: n1532 = 3'b001;
      16'b0000000001000000: n1532 = 3'b001;
      16'b0000000000100000: n1532 = n1338;
      16'b0000000000010000: n1532 = n1265;
      16'b0000000000001000: n1532 = 3'b101;
      16'b0000000000000100: n1532 = 3'b101;
      16'b0000000000000010: n1532 = 3'b101;
      16'b0000000000000001: n1532 = 3'b110;
      default: n1532 = 3'b001;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1534 = n1115;
      16'b0100000000000000: n1534 = n1511;
      16'b0010000000000000: n1534 = n1115;
      16'b0001000000000000: n1534 = n1497;
      16'b0000100000000000: n1534 = n1115;
      16'b0000010000000000: n1534 = 4'b0001;
      16'b0000001000000000: n1534 = n1459;
      16'b0000000100000000: n1534 = n1446;
      16'b0000000010000000: n1534 = n1437;
      16'b0000000001000000: n1534 = n1115;
      16'b0000000000100000: n1534 = n1393;
      16'b0000000000010000: n1534 = n1115;
      16'b0000000000001000: n1534 = n1115;
      16'b0000000000000100: n1534 = n1207;
      16'b0000000000000010: n1534 = n1115;
      16'b0000000000000001: n1534 = n1115;
      default: n1534 = n1115;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1536 = 2'b00;
      16'b0100000000000000: n1536 = 2'b00;
      16'b0010000000000000: n1536 = 2'b00;
      16'b0001000000000000: n1536 = 2'b00;
      16'b0000100000000000: n1536 = 2'b00;
      16'b0000010000000000: n1536 = 2'b00;
      16'b0000001000000000: n1536 = 2'b00;
      16'b0000000100000000: n1536 = 2'b00;
      16'b0000000010000000: n1536 = 2'b00;
      16'b0000000001000000: n1536 = 2'b00;
      16'b0000000000100000: n1536 = n1396;
      16'b0000000000010000: n1536 = n1314;
      16'b0000000000001000: n1536 = n1245;
      16'b0000000000000100: n1536 = n1213;
      16'b0000000000000010: n1536 = n1174;
      16'b0000000000000001: n1536 = n1136;
      default: n1536 = 2'b00;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1537 = n1085;
      16'b0100000000000000: n1537 = n1085;
      16'b0010000000000000: n1537 = n1085;
      16'b0001000000000000: n1537 = n1085;
      16'b0000100000000000: n1537 = n1085;
      16'b0000010000000000: n1537 = n1085;
      16'b0000001000000000: n1537 = n1085;
      16'b0000000100000000: n1537 = n1085;
      16'b0000000010000000: n1537 = n1085;
      16'b0000000001000000: n1537 = n1085;
      16'b0000000000100000: n1537 = n1085;
      16'b0000000000010000: n1537 = n1315;
      16'b0000000000001000: n1537 = n1085;
      16'b0000000000000100: n1537 = n1085;
      16'b0000000000000010: n1537 = n1177;
      16'b0000000000000001: n1537 = n1140;
      default: n1537 = n1085;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1539 = n1521;
      16'b0100000000000000: n1539 = 2'b00;
      16'b0010000000000000: n1539 = 2'b00;
      16'b0001000000000000: n1539 = 2'b00;
      16'b0000100000000000: n1539 = 2'b00;
      16'b0000010000000000: n1539 = 2'b00;
      16'b0000001000000000: n1539 = 2'b00;
      16'b0000000100000000: n1539 = 2'b00;
      16'b0000000010000000: n1539 = 2'b00;
      16'b0000000001000000: n1539 = n1422;
      16'b0000000000100000: n1539 = 2'b00;
      16'b0000000000010000: n1539 = 2'b00;
      16'b0000000000001000: n1539 = n1249;
      16'b0000000000000100: n1539 = n1216;
      16'b0000000000000010: n1539 = n1181;
      16'b0000000000000001: n1539 = n1143;
      default: n1539 = 2'b00;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1541 = 1'b0;
      16'b0100000000000000: n1541 = 1'b0;
      16'b0010000000000000: n1541 = 1'b0;
      16'b0001000000000000: n1541 = 1'b0;
      16'b0000100000000000: n1541 = 1'b0;
      16'b0000010000000000: n1541 = 1'b0;
      16'b0000001000000000: n1541 = 1'b0;
      16'b0000000100000000: n1541 = 1'b0;
      16'b0000000010000000: n1541 = 1'b0;
      16'b0000000001000000: n1541 = 1'b0;
      16'b0000000000100000: n1541 = n1399;
      16'b0000000000010000: n1541 = 1'b0;
      16'b0000000000001000: n1541 = n1253;
      16'b0000000000000100: n1541 = n1221;
      16'b0000000000000010: n1541 = 1'b0;
      16'b0000000000000001: n1541 = 1'b0;
      default: n1541 = 1'b0;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1543 = 1'b0;
      16'b0100000000000000: n1543 = 1'b0;
      16'b0010000000000000: n1543 = 1'b0;
      16'b0001000000000000: n1543 = 1'b0;
      16'b0000100000000000: n1543 = 1'b0;
      16'b0000010000000000: n1543 = 1'b0;
      16'b0000001000000000: n1543 = 1'b0;
      16'b0000000100000000: n1543 = 1'b0;
      16'b0000000010000000: n1543 = 1'b0;
      16'b0000000001000000: n1543 = 1'b0;
      16'b0000000000100000: n1543 = 1'b0;
      16'b0000000000010000: n1543 = n1318;
      16'b0000000000001000: n1543 = 1'b0;
      16'b0000000000000100: n1543 = 1'b0;
      16'b0000000000000010: n1543 = n1185;
      16'b0000000000000001: n1543 = n1148;
      default: n1543 = 1'b0;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1546 = n1088;
      16'b0100000000000000: n1546 = n1088;
      16'b0010000000000000: n1546 = n1088;
      16'b0001000000000000: n1546 = n1088;
      16'b0000100000000000: n1546 = 1'b1;
      16'b0000010000000000: n1546 = 1'b1;
      16'b0000001000000000: n1546 = n1452;
      16'b0000000100000000: n1546 = n1088;
      16'b0000000010000000: n1546 = n1088;
      16'b0000000001000000: n1546 = n1088;
      16'b0000000000100000: n1546 = n1359;
      16'b0000000000010000: n1546 = n1088;
      16'b0000000000001000: n1546 = n1088;
      16'b0000000000000100: n1546 = n1088;
      16'b0000000000000010: n1546 = n1088;
      16'b0000000000000001: n1546 = n1088;
      default: n1546 = n1088;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1548 = 1'b0;
      16'b0100000000000000: n1548 = 1'b0;
      16'b0010000000000000: n1548 = 1'b0;
      16'b0001000000000000: n1548 = 1'b0;
      16'b0000100000000000: n1548 = 1'b0;
      16'b0000010000000000: n1548 = 1'b0;
      16'b0000001000000000: n1548 = 1'b0;
      16'b0000000100000000: n1548 = 1'b0;
      16'b0000000010000000: n1548 = 1'b0;
      16'b0000000001000000: n1548 = 1'b0;
      16'b0000000000100000: n1548 = n1401;
      16'b0000000000010000: n1548 = 1'b0;
      16'b0000000000001000: n1548 = 1'b0;
      16'b0000000000000100: n1548 = n1224;
      16'b0000000000000010: n1548 = 1'b0;
      16'b0000000000000001: n1548 = 1'b0;
      default: n1548 = 1'b0;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1551 = n1091;
      16'b0100000000000000: n1551 = 1'b1;
      16'b0010000000000000: n1551 = n1091;
      16'b0001000000000000: n1551 = n1091;
      16'b0000100000000000: n1551 = n1091;
      16'b0000010000000000: n1551 = n1091;
      16'b0000001000000000: n1551 = n1091;
      16'b0000000100000000: n1551 = 1'b1;
      16'b0000000010000000: n1551 = n1091;
      16'b0000000001000000: n1551 = n1091;
      16'b0000000000100000: n1551 = n1363;
      16'b0000000000010000: n1551 = n1091;
      16'b0000000000001000: n1551 = n1091;
      16'b0000000000000100: n1551 = n1091;
      16'b0000000000000010: n1551 = n1091;
      16'b0000000000000001: n1551 = n1091;
      default: n1551 = n1091;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1553 = n1094;
      16'b0100000000000000: n1553 = n1094;
      16'b0010000000000000: n1553 = n1094;
      16'b0001000000000000: n1553 = n1094;
      16'b0000100000000000: n1553 = n1094;
      16'b0000010000000000: n1553 = n1094;
      16'b0000001000000000: n1553 = n1094;
      16'b0000000100000000: n1553 = n1094;
      16'b0000000010000000: n1553 = 1'b1;
      16'b0000000001000000: n1553 = n1094;
      16'b0000000000100000: n1553 = n1364;
      16'b0000000000010000: n1553 = n1094;
      16'b0000000000001000: n1553 = n1094;
      16'b0000000000000100: n1553 = n1094;
      16'b0000000000000010: n1553 = n1094;
      16'b0000000000000001: n1553 = n1094;
      default: n1553 = n1094;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1555 = n1097;
      16'b0100000000000000: n1555 = n1097;
      16'b0010000000000000: n1555 = 1'b1;
      16'b0001000000000000: n1555 = n1097;
      16'b0000100000000000: n1555 = n1097;
      16'b0000010000000000: n1555 = n1097;
      16'b0000001000000000: n1555 = n1097;
      16'b0000000100000000: n1555 = n1097;
      16'b0000000010000000: n1555 = n1097;
      16'b0000000001000000: n1555 = n1097;
      16'b0000000000100000: n1555 = n1097;
      16'b0000000000010000: n1555 = n1097;
      16'b0000000000001000: n1555 = n1097;
      16'b0000000000000100: n1555 = n1097;
      16'b0000000000000010: n1555 = n1097;
      16'b0000000000000001: n1555 = n1097;
      default: n1555 = n1097;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1557 = 1'b0;
      16'b0100000000000000: n1557 = 1'b0;
      16'b0010000000000000: n1557 = 1'b0;
      16'b0001000000000000: n1557 = 1'b0;
      16'b0000100000000000: n1557 = 1'b0;
      16'b0000010000000000: n1557 = 1'b0;
      16'b0000001000000000: n1557 = 1'b0;
      16'b0000000100000000: n1557 = 1'b0;
      16'b0000000010000000: n1557 = 1'b0;
      16'b0000000001000000: n1557 = 1'b0;
      16'b0000000000100000: n1557 = 1'b0;
      16'b0000000000010000: n1557 = 1'b0;
      16'b0000000000001000: n1557 = n1256;
      16'b0000000000000100: n1557 = n1227;
      16'b0000000000000010: n1557 = n1188;
      16'b0000000000000001: n1557 = n1151;
      default: n1557 = 1'b0;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1559 = 1'b0;
      16'b0100000000000000: n1559 = 1'b0;
      16'b0010000000000000: n1559 = 1'b0;
      16'b0001000000000000: n1559 = 1'b0;
      16'b0000100000000000: n1559 = 1'b0;
      16'b0000010000000000: n1559 = 1'b0;
      16'b0000001000000000: n1559 = 1'b0;
      16'b0000000100000000: n1559 = 1'b0;
      16'b0000000010000000: n1559 = 1'b0;
      16'b0000000001000000: n1559 = 1'b0;
      16'b0000000000100000: n1559 = n1403;
      16'b0000000000010000: n1559 = 1'b0;
      16'b0000000000001000: n1559 = 1'b0;
      16'b0000000000000100: n1559 = 1'b0;
      16'b0000000000000010: n1559 = 1'b0;
      16'b0000000000000001: n1559 = 1'b0;
      default: n1559 = 1'b0;
    endcase
  /*# T65_MCode.vhd:242:9 */
  always @*
    case (n1526)
      16'b1000000000000000: n1561 = 1'b0;
      16'b0100000000000000: n1561 = 1'b0;
      16'b0010000000000000: n1561 = 1'b0;
      16'b0001000000000000: n1561 = 1'b0;
      16'b0000100000000000: n1561 = 1'b0;
      16'b0000010000000000: n1561 = 1'b0;
      16'b0000001000000000: n1561 = 1'b0;
      16'b0000000100000000: n1561 = 1'b0;
      16'b0000000010000000: n1561 = 1'b0;
      16'b0000000001000000: n1561 = 1'b0;
      16'b0000000000100000: n1561 = 1'b0;
      16'b0000000000010000: n1561 = n1320;
      16'b0000000000001000: n1561 = 1'b0;
      16'b0000000000000100: n1561 = 1'b0;
      16'b0000000000000010: n1561 = n1192;
      16'b0000000000000001: n1561 = n1156;
      default: n1561 = 1'b0;
    endcase
  /*# T65_MCode.vhd:240:7 */
  assign n1563 = n1116 == 5'b00000;
  /*# T65_MCode.vhd:240:20 */
  assign n1565 = n1116 == 5'b01000;
  /*# T65_MCode.vhd:240:20 */
  assign n1566 = n1563 | n1565;
  /*# T65_MCode.vhd:240:30 */
  assign n1568 = n1116 == 5'b01010;
  /*# T65_MCode.vhd:240:30 */
  assign n1569 = n1566 | n1568;
  /*# T65_MCode.vhd:240:40 */
  assign n1571 = n1116 == 5'b11000;
  /*# T65_MCode.vhd:240:40 */
  assign n1572 = n1569 | n1571;
  /*# T65_MCode.vhd:240:50 */
  assign n1574 = n1116 == 5'b11010;
  /*# T65_MCode.vhd:240:50 */
  assign n1575 = n1572 | n1574;
  /*# T65_MCode.vhd:491:14 */
  assign n1576 = ir[7:6]; // extract
  /*# T65_MCode.vhd:491:27 */
  assign n1578 = n1576 != 2'b10;
  /*# T65_MCode.vhd:493:18 */
  assign n1580 = mode == 2'b00;
  /*# T65_MCode.vhd:493:30 */
  assign n1581 = ir[1]; // extract
  /*# T65_MCode.vhd:493:24 */
  assign n1582 = n1581 & n1580;
  /*# T65_MCode.vhd:493:11 */
  assign n1585 = n1582 ? 3'b111 : 3'b101;
  /*# T65_MCode.vhd:491:9 */
  assign n1587 = n1578 ? n1585 : 3'b101;
  /*# T65_MCode.vhd:491:9 */
  assign n1590 = n1578 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:498:11 */
  assign n1592 = mcycle == 3'b001;
  /*# T65_MCode.vhd:502:11 */
  assign n1594 = mcycle == 3'b010;
  /*# T65_MCode.vhd:505:11 */
  assign n1596 = mcycle == 3'b011;
  /*# T65_MCode.vhd:511:18 */
  assign n1597 = ir[7:5]; // extract
  /*# T65_MCode.vhd:511:31 */
  assign n1599 = n1597 == 3'b100;
  /*# T65_MCode.vhd:511:13 */
  assign n1602 = n1599 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:509:11 */
  assign n1604 = mcycle == 3'b100;
  /*# T65_MCode.vhd:516:20 */
  assign n1606 = mode == 2'b00;
  /*# T65_MCode.vhd:516:32 */
  assign n1607 = ir[1]; // extract
  /*# T65_MCode.vhd:516:26 */
  assign n1608 = n1607 & n1606;
  /*# T65_MCode.vhd:516:46 */
  assign n1609 = ir[7:6]; // extract
  /*# T65_MCode.vhd:516:58 */
  assign n1611 = n1609 != 2'b10;
  /*# T65_MCode.vhd:516:40 */
  assign n1612 = n1611 & n1608;
  /*# T65_MCode.vhd:516:13 */
  assign n1615 = n1612 ? 2'b11 : 2'b00;
  /*# T65_MCode.vhd:516:13 */
  assign n1618 = n1612 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:516:13 */
  assign n1621 = n1612 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:515:11 */
  assign n1623 = mcycle == 3'b101;
  /*# T65_MCode.vhd:521:11 */
  assign n1625 = mcycle == 3'b110;
  /*# T65_MCode.vhd:526:11 */
  assign n1627 = mcycle == 3'b111;
  /*# T65_MCode.vhd:497:9 */
  assign n1628 = {n1627, n1625, n1623, n1604, n1596, n1594, n1592};
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1630 = 4'b0001;
      7'b0100000: n1630 = n1115;
      7'b0010000: n1630 = n1115;
      7'b0001000: n1630 = n1115;
      7'b0000100: n1630 = n1115;
      7'b0000010: n1630 = n1115;
      7'b0000001: n1630 = n1115;
      default: n1630 = n1115;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1637 = 2'b00;
      7'b0100000: n1637 = 2'b11;
      7'b0010000: n1637 = n1615;
      7'b0001000: n1637 = 2'b11;
      7'b0000100: n1637 = 2'b10;
      7'b0000010: n1637 = 2'b10;
      7'b0000001: n1637 = 2'b10;
      default: n1637 = 2'b00;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1640 = 2'b00;
      7'b0100000: n1640 = 2'b00;
      7'b0010000: n1640 = 2'b00;
      7'b0001000: n1640 = 2'b00;
      7'b0000100: n1640 = 2'b00;
      7'b0000010: n1640 = 2'b00;
      7'b0000001: n1640 = 2'b01;
      default: n1640 = 2'b00;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1643 = 2'b00;
      7'b0100000: n1643 = 2'b00;
      7'b0010000: n1643 = 2'b00;
      7'b0001000: n1643 = 2'b00;
      7'b0000100: n1643 = 2'b01;
      7'b0000010: n1643 = 2'b00;
      7'b0000001: n1643 = 2'b00;
      default: n1643 = 2'b00;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1646 = 1'b0;
      7'b0100000: n1646 = 1'b0;
      7'b0010000: n1646 = 1'b0;
      7'b0001000: n1646 = 1'b0;
      7'b0000100: n1646 = 1'b0;
      7'b0000010: n1646 = 1'b1;
      7'b0000001: n1646 = 1'b0;
      default: n1646 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1648 = 1'b0;
      7'b0100000: n1648 = 1'b0;
      7'b0010000: n1648 = n1618;
      7'b0001000: n1648 = 1'b0;
      7'b0000100: n1648 = 1'b0;
      7'b0000010: n1648 = 1'b0;
      7'b0000001: n1648 = 1'b0;
      default: n1648 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1651 = 1'b0;
      7'b0100000: n1651 = 1'b1;
      7'b0010000: n1651 = 1'b0;
      7'b0001000: n1651 = 1'b0;
      7'b0000100: n1651 = 1'b0;
      7'b0000010: n1651 = 1'b0;
      7'b0000001: n1651 = 1'b0;
      default: n1651 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1654 = 1'b0;
      7'b0100000: n1654 = 1'b0;
      7'b0010000: n1654 = 1'b0;
      7'b0001000: n1654 = 1'b0;
      7'b0000100: n1654 = 1'b0;
      7'b0000010: n1654 = 1'b0;
      7'b0000001: n1654 = 1'b1;
      default: n1654 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1657 = 1'b0;
      7'b0100000: n1657 = 1'b0;
      7'b0010000: n1657 = 1'b0;
      7'b0001000: n1657 = 1'b0;
      7'b0000100: n1657 = 1'b1;
      7'b0000010: n1657 = 1'b0;
      7'b0000001: n1657 = 1'b0;
      default: n1657 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1660 = 1'b0;
      7'b0100000: n1660 = 1'b0;
      7'b0010000: n1660 = 1'b0;
      7'b0001000: n1660 = 1'b1;
      7'b0000100: n1660 = 1'b0;
      7'b0000010: n1660 = 1'b0;
      7'b0000001: n1660 = 1'b0;
      default: n1660 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1663 = 1'b0;
      7'b0100000: n1663 = 1'b1;
      7'b0010000: n1663 = 1'b0;
      7'b0001000: n1663 = 1'b0;
      7'b0000100: n1663 = 1'b0;
      7'b0000010: n1663 = 1'b0;
      7'b0000001: n1663 = 1'b0;
      default: n1663 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1666 = 1'b0;
      7'b0100000: n1666 = 1'b1;
      7'b0010000: n1666 = n1621;
      7'b0001000: n1666 = n1602;
      7'b0000100: n1666 = 1'b0;
      7'b0000010: n1666 = 1'b0;
      7'b0000001: n1666 = 1'b0;
      default: n1666 = 1'b0;
    endcase
  /*# T65_MCode.vhd:497:9 */
  always @*
    case (n1628)
      7'b1000000: n1669 = 1'b1;
      7'b0100000: n1669 = 1'b0;
      7'b0010000: n1669 = 1'b0;
      7'b0001000: n1669 = 1'b0;
      7'b0000100: n1669 = 1'b0;
      7'b0000010: n1669 = 1'b0;
      7'b0000001: n1669 = 1'b0;
      default: n1669 = 1'b0;
    endcase
  /*# T65_MCode.vhd:488:7 */
  assign n1671 = n1116 == 5'b00001;
  /*# T65_MCode.vhd:488:20 */
  assign n1673 = n1116 == 5'b00011;
  /*# T65_MCode.vhd:488:20 */
  assign n1674 = n1671 | n1673;
  /*# T65_MCode.vhd:535:14 */
  assign n1675 = ir[7:5]; // extract
  /*# T65_MCode.vhd:535:26 */
  assign n1677 = n1675 != 3'b100;
  /*# T65_MCode.vhd:535:9 */
  assign n1679 = n1677 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:539:11 */
  assign n1681 = mcycle == 3'b001;
  /*# T65_MCode.vhd:538:9 */
  always @*
    case (n1681)
      1'b1: n1684 = 2'b01;
      default: n1684 = 2'b00;
    endcase
  /*# T65_MCode.vhd:533:7 */
  assign n1686 = n1116 == 5'b01001;
  /*# T65_MCode.vhd:546:16 */
  assign n1688 = mode == 2'b00;
  /*# T65_MCode.vhd:548:18 */
  assign n1689 = ir[7:5]; // extract
  /*# T65_MCode.vhd:549:13 */
  assign n1691 = n1689 == 3'b010;
  /*# T65_MCode.vhd:549:23 */
  assign n1693 = n1689 == 3'b011;
  /*# T65_MCode.vhd:549:23 */
  assign n1694 = n1691 | n1693;
  /*# T65_MCode.vhd:549:29 */
  assign n1696 = n1689 == 3'b000;
  /*# T65_MCode.vhd:549:29 */
  assign n1697 = n1694 | n1696;
  /*# T65_MCode.vhd:549:35 */
  assign n1699 = n1689 == 3'b001;
  /*# T65_MCode.vhd:549:35 */
  assign n1700 = n1697 | n1699;
  /*# T65_MCode.vhd:552:13 */
  assign n1702 = n1689 == 3'b100;
  /*# T65_MCode.vhd:555:13 */
  assign n1704 = n1689 == 3'b110;
  /*# T65_MCode.vhd:558:13 */
  assign n1706 = n1689 == 3'b101;
  /*# T65_MCode.vhd:548:11 */
  assign n1707 = {n1706, n1704, n1702, n1700};
  /*# T65_MCode.vhd:548:11 */
  always @*
    case (n1707)
      4'b1000: n1712 = 4'b0111;
      4'b0100: n1712 = 4'b1001;
      4'b0010: n1712 = 4'b1000;
      4'b0001: n1712 = 4'b0110;
      default: n1712 = n1115;
    endcase
  /*# T65_MCode.vhd:548:11 */
  always @*
    case (n1707)
      4'b1000: n1717 = 1'b1;
      4'b0100: n1717 = n1088;
      4'b0010: n1717 = 1'b1;
      4'b0001: n1717 = 1'b1;
      default: n1717 = 1'b1;
    endcase
  /*# T65_MCode.vhd:548:11 */
  always @*
    case (n1707)
      4'b1000: n1719 = n1091;
      4'b0100: n1719 = 1'b1;
      4'b0010: n1719 = n1091;
      4'b0001: n1719 = n1091;
      default: n1719 = n1091;
    endcase
  /*# T65_MCode.vhd:565:13 */
  assign n1721 = mcycle == 3'b001;
  /*# T65_MCode.vhd:564:11 */
  always @*
    case (n1721)
      1'b1: n1724 = 2'b01;
      default: n1724 = 2'b00;
    endcase
  /*# T65_MCode.vhd:546:9 */
  assign n1725 = n1688 ? n1712 : n1115;
  /*# T65_MCode.vhd:546:9 */
  assign n1727 = n1688 ? n1724 : 2'b00;
  /*# T65_MCode.vhd:546:9 */
  assign n1728 = n1688 ? n1717 : n1088;
  /*# T65_MCode.vhd:546:9 */
  assign n1729 = n1688 ? n1719 : n1091;
  /*# T65_MCode.vhd:545:7 */
  assign n1731 = n1116 == 5'b01011;
  /*# T65_MCode.vhd:576:11 */
  assign n1733 = mcycle == 3'b000;
  /*# T65_MCode.vhd:578:19 */
  assign n1735 = ir == 8'b10100010;
  /*# T65_MCode.vhd:582:21 */
  assign n1736 = ir[7:4]; // extract
  /*# T65_MCode.vhd:582:33 */
  assign n1738 = n1736 == 4'b1000;
  /*# T65_MCode.vhd:582:46 */
  assign n1739 = ir[7:4]; // extract
  /*# T65_MCode.vhd:582:58 */
  assign n1741 = n1739 == 4'b1100;
  /*# T65_MCode.vhd:582:41 */
  assign n1742 = n1738 | n1741;
  /*# T65_MCode.vhd:582:71 */
  assign n1743 = ir[7:4]; // extract
  /*# T65_MCode.vhd:582:83 */
  assign n1745 = n1743 == 4'b1110;
  /*# T65_MCode.vhd:582:66 */
  assign n1746 = n1742 | n1745;
  /*# T65_MCode.vhd:582:13 */
  assign n1749 = n1746 ? 2'b01 : 2'b00;
  /*# T65_MCode.vhd:578:13 */
  assign n1751 = n1735 ? 2'b01 : n1749;
  /*# T65_MCode.vhd:578:13 */
  assign n1753 = n1735 ? 1'b1 : n1091;
  /*# T65_MCode.vhd:577:11 */
  assign n1755 = mcycle == 3'b001;
  /*# T65_MCode.vhd:575:9 */
  assign n1756 = {n1755, n1733};
  /*# T65_MCode.vhd:575:9 */
  always @*
    case (n1756)
      2'b10: n1758 = n1751;
      2'b01: n1758 = 2'b00;
      default: n1758 = 2'b00;
    endcase
  /*# T65_MCode.vhd:575:9 */
  always @*
    case (n1756)
      2'b10: n1759 = n1753;
      2'b01: n1759 = n1091;
      default: n1759 = n1091;
    endcase
  /*# T65_MCode.vhd:573:7 */
  assign n1761 = n1116 == 5'b00010;
  /*# T65_MCode.vhd:573:20 */
  assign n1763 = n1116 == 5'b10010;
  /*# T65_MCode.vhd:573:20 */
  assign n1764 = n1761 | n1763;
  /*# T65_MCode.vhd:597:18 */
  assign n1765 = ir[7:5]; // extract
  /*# T65_MCode.vhd:597:31 */
  assign n1767 = n1765 == 3'b001;
  /*# T65_MCode.vhd:597:13 */
  assign n1770 = n1767 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:596:11 */
  assign n1772 = mcycle == 3'b000;
  /*# T65_MCode.vhd:603:18 */
  assign n1773 = ir[7:5]; // extract
  /*# T65_MCode.vhd:603:31 */
  assign n1775 = n1773 == 3'b100;
  /*# T65_MCode.vhd:603:13 */
  assign n1778 = n1775 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:600:11 */
  assign n1780 = mcycle == 3'b001;
  /*# T65_MCode.vhd:607:11 */
  assign n1782 = mcycle == 3'b010;
  /*# T65_MCode.vhd:595:9 */
  assign n1783 = {n1782, n1780, n1772};
  /*# T65_MCode.vhd:595:9 */
  always @*
    case (n1783)
      3'b100: n1786 = 2'b00;
      3'b010: n1786 = 2'b10;
      3'b001: n1786 = 2'b00;
      default: n1786 = 2'b00;
    endcase
  /*# T65_MCode.vhd:595:9 */
  always @*
    case (n1783)
      3'b100: n1789 = 2'b00;
      3'b010: n1789 = 2'b01;
      3'b001: n1789 = 2'b00;
      default: n1789 = 2'b00;
    endcase
  /*# T65_MCode.vhd:595:9 */
  always @*
    case (n1783)
      3'b100: n1792 = 1'b0;
      3'b010: n1792 = 1'b1;
      3'b001: n1792 = 1'b0;
      default: n1792 = 1'b0;
    endcase
  /*# T65_MCode.vhd:595:9 */
  always @*
    case (n1783)
      3'b100: n1794 = 1'b0;
      3'b010: n1794 = 1'b0;
      3'b001: n1794 = n1770;
      default: n1794 = 1'b0;
    endcase
  /*# T65_MCode.vhd:595:9 */
  always @*
    case (n1783)
      3'b100: n1796 = 1'b0;
      3'b010: n1796 = n1778;
      3'b001: n1796 = 1'b0;
      default: n1796 = 1'b0;
    endcase
  /*# T65_MCode.vhd:592:7 */
  assign n1798 = n1116 == 5'b00100;
  /*# T65_MCode.vhd:616:14 */
  assign n1799 = ir[7:6]; // extract
  /*# T65_MCode.vhd:616:27 */
  assign n1801 = n1799 != 2'b10;
  /*# T65_MCode.vhd:616:41 */
  assign n1802 = ir[1]; // extract
  /*# T65_MCode.vhd:616:35 */
  assign n1803 = n1802 & n1801;
  /*# T65_MCode.vhd:616:60 */
  assign n1805 = mode == 2'b00;
  /*# T65_MCode.vhd:616:71 */
  assign n1806 = ir[0]; // extract
  /*# T65_MCode.vhd:616:74 */
  assign n1807 = ~n1806;
  /*# T65_MCode.vhd:616:66 */
  assign n1808 = n1805 | n1807;
  /*# T65_MCode.vhd:616:51 */
  assign n1809 = n1808 & n1803;
  /*# T65_MCode.vhd:619:18 */
  assign n1811 = mode == 2'b00;
  /*# T65_MCode.vhd:619:30 */
  assign n1812 = ir[0]; // extract
  /*# T65_MCode.vhd:619:24 */
  assign n1813 = n1812 & n1811;
  /*# T65_MCode.vhd:619:11 */
  assign n1815 = n1813 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:623:13 */
  assign n1817 = mcycle == 3'b001;
  /*# T65_MCode.vhd:629:22 */
  assign n1819 = mode == 2'b00;
  /*# T65_MCode.vhd:629:15 */
  assign n1822 = n1819 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:627:13 */
  assign n1824 = mcycle == 3'b010;
  /*# T65_MCode.vhd:633:13 */
  assign n1826 = mcycle == 3'b011;
  /*# T65_MCode.vhd:639:22 */
  assign n1828 = mode == 2'b00;
  /*# T65_MCode.vhd:639:34 */
  assign n1829 = ir[0]; // extract
  /*# T65_MCode.vhd:639:28 */
  assign n1830 = n1829 & n1828;
  /*# T65_MCode.vhd:639:15 */
  assign n1832 = n1830 ? 4'b0001 : n1115;
  /*# T65_MCode.vhd:639:15 */
  assign n1835 = n1830 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:639:15 */
  assign n1838 = n1830 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:638:13 */
  assign n1840 = mcycle == 3'b100;
  /*# T65_MCode.vhd:622:11 */
  assign n1841 = {n1840, n1826, n1824, n1817};
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1842 = n1832;
      4'b0100: n1842 = n1115;
      4'b0010: n1842 = n1115;
      4'b0001: n1842 = n1115;
      default: n1842 = n1115;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1847 = 2'b00;
      4'b0100: n1847 = 2'b10;
      4'b0010: n1847 = 2'b10;
      4'b0001: n1847 = 2'b10;
      default: n1847 = 2'b00;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1850 = 2'b00;
      4'b0100: n1850 = 2'b00;
      4'b0010: n1850 = 2'b00;
      4'b0001: n1850 = 2'b01;
      default: n1850 = 2'b00;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1853 = n1835;
      4'b0100: n1853 = 1'b0;
      4'b0010: n1853 = 1'b1;
      4'b0001: n1853 = 1'b0;
      default: n1853 = 1'b0;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1856 = 1'b0;
      4'b0100: n1856 = 1'b1;
      4'b0010: n1856 = 1'b0;
      4'b0001: n1856 = 1'b0;
      default: n1856 = 1'b0;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1859 = 1'b0;
      4'b0100: n1859 = 1'b0;
      4'b0010: n1859 = 1'b0;
      4'b0001: n1859 = 1'b1;
      default: n1859 = 1'b0;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1862 = 1'b0;
      4'b0100: n1862 = 1'b1;
      4'b0010: n1862 = 1'b0;
      4'b0001: n1862 = 1'b0;
      default: n1862 = 1'b0;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1865 = 1'b0;
      4'b0100: n1865 = 1'b1;
      4'b0010: n1865 = n1822;
      4'b0001: n1865 = 1'b0;
      default: n1865 = 1'b0;
    endcase
  /*# T65_MCode.vhd:622:11 */
  always @*
    case (n1841)
      4'b1000: n1867 = n1838;
      4'b0100: n1867 = 1'b0;
      4'b0010: n1867 = 1'b0;
      4'b0001: n1867 = 1'b0;
      default: n1867 = 1'b0;
    endcase
  /*# T65_MCode.vhd:648:16 */
  assign n1868 = ir[7:6]; // extract
  /*# T65_MCode.vhd:648:29 */
  assign n1870 = n1868 != 2'b10;
  /*# T65_MCode.vhd:648:11 */
  assign n1872 = n1870 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:652:13 */
  assign n1874 = mcycle == 3'b000;
  /*# T65_MCode.vhd:656:20 */
  assign n1875 = ir[7:5]; // extract
  /*# T65_MCode.vhd:656:33 */
  assign n1877 = n1875 == 3'b100;
  /*# T65_MCode.vhd:656:15 */
  assign n1880 = n1877 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:653:13 */
  assign n1882 = mcycle == 3'b001;
  /*# T65_MCode.vhd:660:13 */
  assign n1884 = mcycle == 3'b010;
  /*# T65_MCode.vhd:651:11 */
  assign n1885 = {n1884, n1882, n1874};
  /*# T65_MCode.vhd:651:11 */
  always @*
    case (n1885)
      3'b100: n1888 = 2'b00;
      3'b010: n1888 = 2'b10;
      3'b001: n1888 = 2'b00;
      default: n1888 = 2'b00;
    endcase
  /*# T65_MCode.vhd:651:11 */
  always @*
    case (n1885)
      3'b100: n1891 = 2'b00;
      3'b010: n1891 = 2'b01;
      3'b001: n1891 = 2'b00;
      default: n1891 = 2'b00;
    endcase
  /*# T65_MCode.vhd:651:11 */
  always @*
    case (n1885)
      3'b100: n1894 = 1'b0;
      3'b010: n1894 = 1'b1;
      3'b001: n1894 = 1'b0;
      default: n1894 = 1'b0;
    endcase
  /*# T65_MCode.vhd:651:11 */
  always @*
    case (n1885)
      3'b100: n1896 = 1'b0;
      3'b010: n1896 = n1880;
      3'b001: n1896 = 1'b0;
      default: n1896 = 1'b0;
    endcase
  /*# T65_MCode.vhd:616:9 */
  assign n1899 = n1809 ? 3'b100 : 3'b010;
  /*# T65_MCode.vhd:616:9 */
  assign n1900 = n1809 ? n1842 : n1115;
  /*# T65_MCode.vhd:616:9 */
  assign n1901 = n1809 ? n1847 : n1888;
  /*# T65_MCode.vhd:616:9 */
  assign n1902 = n1809 ? n1850 : n1891;
  /*# T65_MCode.vhd:616:9 */
  assign n1903 = n1809 ? n1815 : n1872;
  /*# T65_MCode.vhd:616:9 */
  assign n1905 = n1809 ? n1853 : 1'b0;
  /*# T65_MCode.vhd:616:9 */
  assign n1907 = n1809 ? n1856 : 1'b0;
  /*# T65_MCode.vhd:616:9 */
  assign n1908 = n1809 ? n1859 : n1894;
  /*# T65_MCode.vhd:616:9 */
  assign n1910 = n1809 ? n1862 : 1'b0;
  /*# T65_MCode.vhd:616:9 */
  assign n1911 = n1809 ? n1865 : n1896;
  /*# T65_MCode.vhd:616:9 */
  assign n1913 = n1809 ? n1867 : 1'b0;
  /*# T65_MCode.vhd:614:7 */
  assign n1915 = n1116 == 5'b00101;
  /*# T65_MCode.vhd:614:20 */
  assign n1917 = n1116 == 5'b00110;
  /*# T65_MCode.vhd:614:20 */
  assign n1918 = n1915 | n1917;
  /*# T65_MCode.vhd:614:30 */
  assign n1920 = n1116 == 5'b00111;
  /*# T65_MCode.vhd:614:30 */
  assign n1921 = n1918 | n1920;
  /*# T65_MCode.vhd:668:14 */
  assign n1922 = ir[7:6]; // extract
  /*# T65_MCode.vhd:668:27 */
  assign n1924 = n1922 == 2'b01;
  /*# T65_MCode.vhd:668:40 */
  assign n1925 = ir[4:0]; // extract
  /*# T65_MCode.vhd:668:53 */
  assign n1927 = n1925 == 5'b01100;
  /*# T65_MCode.vhd:668:34 */
  assign n1928 = n1927 & n1924;
  /*# T65_MCode.vhd:669:16 */
  assign n1929 = ir[5]; // extract
  /*# T65_MCode.vhd:669:20 */
  assign n1930 = ~n1929;
  /*# T65_MCode.vhd:672:15 */
  assign n1932 = mcycle == 3'b001;
  /*# T65_MCode.vhd:675:15 */
  assign n1934 = mcycle == 3'b010;
  /*# T65_MCode.vhd:671:13 */
  assign n1935 = {n1934, n1932};
  /*# T65_MCode.vhd:671:13 */
  always @*
    case (n1935)
      2'b10: n1939 = 2'b10;
      2'b01: n1939 = 2'b01;
      default: n1939 = 2'b00;
    endcase
  /*# T65_MCode.vhd:671:13 */
  always @*
    case (n1935)
      2'b10: n1942 = 1'b0;
      2'b01: n1942 = 1'b1;
      default: n1942 = 1'b0;
    endcase
  /*# T65_MCode.vhd:682:15 */
  assign n1944 = mcycle == 3'b001;
  /*# T65_MCode.vhd:688:25 */
  assign n1946 = mode != 2'b00;
  /*# T65_MCode.vhd:688:17 */
  assign n1949 = n1946 ? 2'b10 : 2'b00;
  /*# T65_MCode.vhd:691:25 */
  assign n1951 = mode == 2'b00;
  /*# T65_MCode.vhd:691:17 */
  assign n1954 = n1951 ? 2'b11 : 2'b00;
  /*# T65_MCode.vhd:686:15 */
  assign n1956 = mcycle == 3'b010;
  /*# T65_MCode.vhd:696:25 */
  assign n1958 = mode == 2'b00;
  /*# T65_MCode.vhd:696:17 */
  assign n1961 = n1958 ? 2'b11 : 2'b00;
  /*# T65_MCode.vhd:696:17 */
  assign n1964 = n1958 ? 2'b00 : 2'b01;
  /*# T65_MCode.vhd:696:17 */
  assign n1967 = n1958 ? 2'b01 : 2'b00;
  /*# T65_MCode.vhd:694:15 */
  assign n1969 = mcycle == 3'b011;
  /*# T65_MCode.vhd:702:15 */
  assign n1971 = mcycle == 3'b100;
  /*# T65_MCode.vhd:681:13 */
  assign n1972 = {n1971, n1969, n1956, n1944};
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1974 = 2'b00;
      4'b0100: n1974 = n1961;
      4'b0010: n1974 = n1954;
      4'b0001: n1974 = 2'b00;
      default: n1974 = 2'b00;
    endcase
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1978 = 2'b10;
      4'b0100: n1978 = n1964;
      4'b0010: n1978 = n1949;
      4'b0001: n1978 = 2'b01;
      default: n1978 = 2'b00;
    endcase
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1980 = 2'b00;
      4'b0100: n1980 = n1967;
      4'b0010: n1980 = 2'b00;
      4'b0001: n1980 = 2'b00;
      default: n1980 = 2'b00;
    endcase
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1984 = 1'b0;
      4'b0100: n1984 = 1'b1;
      4'b0010: n1984 = 1'b0;
      4'b0001: n1984 = 1'b1;
      default: n1984 = 1'b0;
    endcase
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1987 = 1'b0;
      4'b0100: n1987 = 1'b0;
      4'b0010: n1987 = 1'b0;
      4'b0001: n1987 = 1'b1;
      default: n1987 = 1'b0;
    endcase
  /*# T65_MCode.vhd:681:13 */
  always @*
    case (n1972)
      4'b1000: n1990 = 1'b0;
      4'b0100: n1990 = 1'b0;
      4'b0010: n1990 = 1'b1;
      4'b0001: n1990 = 1'b0;
      default: n1990 = 1'b0;
    endcase
  /*# T65_MCode.vhd:669:11 */
  assign n1993 = n1930 ? 3'b010 : 3'b100;
  /*# T65_MCode.vhd:669:11 */
  assign n1995 = n1930 ? 2'b00 : n1974;
  /*# T65_MCode.vhd:669:11 */
  assign n1996 = n1930 ? n1939 : n1978;
  /*# T65_MCode.vhd:669:11 */
  assign n1998 = n1930 ? 2'b00 : n1980;
  /*# T65_MCode.vhd:669:11 */
  assign n1999 = n1930 ? n1942 : n1984;
  /*# T65_MCode.vhd:669:11 */
  assign n2001 = n1930 ? 1'b0 : n1987;
  /*# T65_MCode.vhd:669:11 */
  assign n2003 = n1930 ? 1'b0 : n1990;
  /*# T65_MCode.vhd:711:20 */
  assign n2004 = ir[7:5]; // extract
  /*# T65_MCode.vhd:711:33 */
  assign n2006 = n2004 == 3'b001;
  /*# T65_MCode.vhd:711:15 */
  assign n2009 = n2006 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:710:13 */
  assign n2011 = mcycle == 3'b000;
  /*# T65_MCode.vhd:714:13 */
  assign n2013 = mcycle == 3'b001;
  /*# T65_MCode.vhd:720:20 */
  assign n2014 = ir[7:5]; // extract
  /*# T65_MCode.vhd:720:33 */
  assign n2016 = n2014 == 3'b100;
  /*# T65_MCode.vhd:720:15 */
  assign n2019 = n2016 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:717:13 */
  assign n2021 = mcycle == 3'b010;
  /*# T65_MCode.vhd:724:13 */
  assign n2023 = mcycle == 3'b011;
  /*# T65_MCode.vhd:709:11 */
  assign n2024 = {n2023, n2021, n2013, n2011};
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2027 = 2'b00;
      4'b0100: n2027 = 2'b11;
      4'b0010: n2027 = 2'b00;
      4'b0001: n2027 = 2'b00;
      default: n2027 = 2'b00;
    endcase
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2031 = 2'b00;
      4'b0100: n2031 = 2'b01;
      4'b0010: n2031 = 2'b01;
      4'b0001: n2031 = 2'b00;
      default: n2031 = 2'b00;
    endcase
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2034 = 1'b0;
      4'b0100: n2034 = 1'b0;
      4'b0010: n2034 = 1'b1;
      4'b0001: n2034 = 1'b0;
      default: n2034 = 1'b0;
    endcase
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2037 = 1'b0;
      4'b0100: n2037 = 1'b1;
      4'b0010: n2037 = 1'b0;
      4'b0001: n2037 = 1'b0;
      default: n2037 = 1'b0;
    endcase
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2039 = 1'b0;
      4'b0100: n2039 = 1'b0;
      4'b0010: n2039 = 1'b0;
      4'b0001: n2039 = n2009;
      default: n2039 = 1'b0;
    endcase
  /*# T65_MCode.vhd:709:11 */
  always @*
    case (n2024)
      4'b1000: n2041 = 1'b0;
      4'b0100: n2041 = n2019;
      4'b0010: n2041 = 1'b0;
      4'b0001: n2041 = 1'b0;
      default: n2041 = 1'b0;
    endcase
  /*# T65_MCode.vhd:668:9 */
  assign n2043 = n1928 ? n1993 : 3'b011;
  /*# T65_MCode.vhd:668:9 */
  assign n2044 = n1928 ? n1995 : n2027;
  /*# T65_MCode.vhd:668:9 */
  assign n2045 = n1928 ? n1996 : n2031;
  /*# T65_MCode.vhd:668:9 */
  assign n2047 = n1928 ? n1998 : 2'b00;
  /*# T65_MCode.vhd:668:9 */
  assign n2049 = n1928 ? n1999 : 1'b0;
  /*# T65_MCode.vhd:668:9 */
  assign n2050 = n1928 ? n2001 : n2034;
  /*# T65_MCode.vhd:668:9 */
  assign n2051 = n1928 ? n2003 : n2037;
  /*# T65_MCode.vhd:668:9 */
  assign n2053 = n1928 ? 1'b0 : n2039;
  /*# T65_MCode.vhd:668:9 */
  assign n2055 = n1928 ? 1'b0 : n2041;
  /*# T65_MCode.vhd:666:7 */
  assign n2057 = n1116 == 5'b01100;
  /*# T65_MCode.vhd:734:14 */
  assign n2058 = ir[7:6]; // extract
  /*# T65_MCode.vhd:734:27 */
  assign n2060 = n2058 != 2'b10;
  /*# T65_MCode.vhd:734:41 */
  assign n2061 = ir[1]; // extract
  /*# T65_MCode.vhd:734:35 */
  assign n2062 = n2061 & n2060;
  /*# T65_MCode.vhd:734:60 */
  assign n2064 = mode == 2'b00;
  /*# T65_MCode.vhd:734:71 */
  assign n2065 = ir[0]; // extract
  /*# T65_MCode.vhd:734:74 */
  assign n2066 = ~n2065;
  /*# T65_MCode.vhd:734:66 */
  assign n2067 = n2064 | n2066;
  /*# T65_MCode.vhd:734:51 */
  assign n2068 = n2067 & n2062;
  /*# T65_MCode.vhd:737:18 */
  assign n2070 = mode == 2'b00;
  /*# T65_MCode.vhd:737:30 */
  assign n2071 = ir[0]; // extract
  /*# T65_MCode.vhd:737:24 */
  assign n2072 = n2071 & n2070;
  /*# T65_MCode.vhd:737:11 */
  assign n2074 = n2072 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:741:13 */
  assign n2076 = mcycle == 3'b001;
  /*# T65_MCode.vhd:744:13 */
  assign n2078 = mcycle == 3'b010;
  /*# T65_MCode.vhd:750:22 */
  assign n2080 = mode == 2'b00;
  /*# T65_MCode.vhd:750:15 */
  assign n2083 = n2080 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:748:13 */
  assign n2085 = mcycle == 3'b011;
  /*# T65_MCode.vhd:754:13 */
  assign n2087 = mcycle == 3'b100;
  /*# T65_MCode.vhd:760:22 */
  assign n2089 = mode == 2'b00;
  /*# T65_MCode.vhd:760:34 */
  assign n2090 = ir[0]; // extract
  /*# T65_MCode.vhd:760:28 */
  assign n2091 = n2090 & n2089;
  /*# T65_MCode.vhd:760:15 */
  assign n2093 = n2091 ? 4'b0001 : n1115;
  /*# T65_MCode.vhd:760:15 */
  assign n2096 = n2091 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:759:13 */
  assign n2098 = mcycle == 3'b101;
  /*# T65_MCode.vhd:740:11 */
  assign n2099 = {n2098, n2087, n2085, n2078, n2076};
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2100 = n2093;
      5'b01000: n2100 = n1115;
      5'b00100: n2100 = n1115;
      5'b00010: n2100 = n1115;
      5'b00001: n2100 = n1115;
      default: n2100 = n1115;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2105 = 2'b00;
      5'b01000: n2105 = 2'b11;
      5'b00100: n2105 = 2'b11;
      5'b00010: n2105 = 2'b11;
      5'b00001: n2105 = 2'b00;
      default: n2105 = 2'b00;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2109 = 2'b00;
      5'b01000: n2109 = 2'b00;
      5'b00100: n2109 = 2'b00;
      5'b00010: n2109 = 2'b01;
      5'b00001: n2109 = 2'b01;
      default: n2109 = 2'b00;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2112 = 1'b0;
      5'b01000: n2112 = 1'b0;
      5'b00100: n2112 = 1'b1;
      5'b00010: n2112 = 1'b0;
      5'b00001: n2112 = 1'b0;
      default: n2112 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2115 = 1'b0;
      5'b01000: n2115 = 1'b1;
      5'b00100: n2115 = 1'b0;
      5'b00010: n2115 = 1'b0;
      5'b00001: n2115 = 1'b0;
      default: n2115 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2118 = 1'b0;
      5'b01000: n2118 = 1'b0;
      5'b00100: n2118 = 1'b0;
      5'b00010: n2118 = 1'b0;
      5'b00001: n2118 = 1'b1;
      default: n2118 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2121 = 1'b0;
      5'b01000: n2121 = 1'b0;
      5'b00100: n2121 = 1'b0;
      5'b00010: n2121 = 1'b1;
      5'b00001: n2121 = 1'b0;
      default: n2121 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2124 = 1'b0;
      5'b01000: n2124 = 1'b1;
      5'b00100: n2124 = 1'b0;
      5'b00010: n2124 = 1'b0;
      5'b00001: n2124 = 1'b0;
      default: n2124 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2127 = 1'b0;
      5'b01000: n2127 = 1'b1;
      5'b00100: n2127 = n2083;
      5'b00010: n2127 = 1'b0;
      5'b00001: n2127 = 1'b0;
      default: n2127 = 1'b0;
    endcase
  /*# T65_MCode.vhd:740:11 */
  always @*
    case (n2099)
      5'b10000: n2129 = n2096;
      5'b01000: n2129 = 1'b0;
      5'b00100: n2129 = 1'b0;
      5'b00010: n2129 = 1'b0;
      5'b00001: n2129 = 1'b0;
      default: n2129 = 1'b0;
    endcase
  /*# T65_MCode.vhd:768:16 */
  assign n2130 = ir[7:6]; // extract
  /*# T65_MCode.vhd:768:29 */
  assign n2132 = n2130 != 2'b10;
  /*# T65_MCode.vhd:768:11 */
  assign n2134 = n2132 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:772:13 */
  assign n2136 = mcycle == 3'b000;
  /*# T65_MCode.vhd:773:13 */
  assign n2138 = mcycle == 3'b001;
  /*# T65_MCode.vhd:779:20 */
  assign n2139 = ir[7:5]; // extract
  /*# T65_MCode.vhd:779:33 */
  assign n2141 = n2139 == 3'b100;
  /*# T65_MCode.vhd:779:15 */
  assign n2144 = n2141 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:776:13 */
  assign n2146 = mcycle == 3'b010;
  /*# T65_MCode.vhd:783:13 */
  assign n2148 = mcycle == 3'b011;
  /*# T65_MCode.vhd:771:11 */
  assign n2149 = {n2148, n2146, n2138, n2136};
  /*# T65_MCode.vhd:771:11 */
  always @*
    case (n2149)
      4'b1000: n2152 = 2'b00;
      4'b0100: n2152 = 2'b11;
      4'b0010: n2152 = 2'b00;
      4'b0001: n2152 = 2'b00;
      default: n2152 = 2'b00;
    endcase
  /*# T65_MCode.vhd:771:11 */
  always @*
    case (n2149)
      4'b1000: n2156 = 2'b00;
      4'b0100: n2156 = 2'b01;
      4'b0010: n2156 = 2'b01;
      4'b0001: n2156 = 2'b00;
      default: n2156 = 2'b00;
    endcase
  /*# T65_MCode.vhd:771:11 */
  always @*
    case (n2149)
      4'b1000: n2159 = 1'b0;
      4'b0100: n2159 = 1'b0;
      4'b0010: n2159 = 1'b1;
      4'b0001: n2159 = 1'b0;
      default: n2159 = 1'b0;
    endcase
  /*# T65_MCode.vhd:771:11 */
  always @*
    case (n2149)
      4'b1000: n2162 = 1'b0;
      4'b0100: n2162 = 1'b1;
      4'b0010: n2162 = 1'b0;
      4'b0001: n2162 = 1'b0;
      default: n2162 = 1'b0;
    endcase
  /*# T65_MCode.vhd:771:11 */
  always @*
    case (n2149)
      4'b1000: n2164 = 1'b0;
      4'b0100: n2164 = n2144;
      4'b0010: n2164 = 1'b0;
      4'b0001: n2164 = 1'b0;
      default: n2164 = 1'b0;
    endcase
  /*# T65_MCode.vhd:734:9 */
  assign n2167 = n2068 ? 3'b101 : 3'b011;
  /*# T65_MCode.vhd:734:9 */
  assign n2168 = n2068 ? n2100 : n1115;
  /*# T65_MCode.vhd:734:9 */
  assign n2169 = n2068 ? n2105 : n2152;
  /*# T65_MCode.vhd:734:9 */
  assign n2170 = n2068 ? n2109 : n2156;
  /*# T65_MCode.vhd:734:9 */
  assign n2171 = n2068 ? n2074 : n2134;
  /*# T65_MCode.vhd:734:9 */
  assign n2173 = n2068 ? n2112 : 1'b0;
  /*# T65_MCode.vhd:734:9 */
  assign n2175 = n2068 ? n2115 : 1'b0;
  /*# T65_MCode.vhd:734:9 */
  assign n2176 = n2068 ? n2118 : n2159;
  /*# T65_MCode.vhd:734:9 */
  assign n2177 = n2068 ? n2121 : n2162;
  /*# T65_MCode.vhd:734:9 */
  assign n2179 = n2068 ? n2124 : 1'b0;
  /*# T65_MCode.vhd:734:9 */
  assign n2180 = n2068 ? n2127 : n2164;
  /*# T65_MCode.vhd:734:9 */
  assign n2182 = n2068 ? n2129 : 1'b0;
  /*# T65_MCode.vhd:732:7 */
  assign n2184 = n1116 == 5'b01101;
  /*# T65_MCode.vhd:732:20 */
  assign n2186 = n1116 == 5'b01110;
  /*# T65_MCode.vhd:732:20 */
  assign n2187 = n2184 | n2186;
  /*# T65_MCode.vhd:732:30 */
  assign n2189 = n1116 == 5'b01111;
  /*# T65_MCode.vhd:732:30 */
  assign n2190 = n2187 | n2189;
  /*# T65_MCode.vhd:795:9 */
  assign n2193 = branch ? 3'b011 : 3'b001;
  /*# T65_MCode.vhd:809:11 */
  assign n2195 = mcycle == 3'b001;
  /*# T65_MCode.vhd:820:11 */
  assign n2197 = mcycle == 3'b010;
  /*# T65_MCode.vhd:829:11 */
  assign n2199 = mcycle == 3'b011;
  /*# T65_MCode.vhd:804:9 */
  assign n2200 = {n2199, n2197, n2195};
  /*# T65_MCode.vhd:804:9 */
  always @*
    case (n2200)
      3'b100: n2204 = 2'b00;
      3'b010: n2204 = 2'b11;
      3'b001: n2204 = 2'b01;
      default: n2204 = 2'b00;
    endcase
  /*# T65_MCode.vhd:804:9 */
  always @*
    case (n2200)
      3'b100: n2207 = 1'b0;
      3'b010: n2207 = 1'b1;
      3'b001: n2207 = 1'b0;
      default: n2207 = 1'b0;
    endcase
  /*# T65_MCode.vhd:804:9 */
  always @*
    case (n2200)
      3'b100: n2210 = 1'b0;
      3'b010: n2210 = 1'b0;
      3'b001: n2210 = 1'b1;
      default: n2210 = 1'b0;
    endcase
  /*# T65_MCode.vhd:789:7 */
  assign n2212 = n1116 == 5'b10000;
  /*# T65_MCode.vhd:837:14 */
  assign n2213 = ir[7:6]; // extract
  /*# T65_MCode.vhd:837:27 */
  assign n2215 = n2213 != 2'b10;
  /*# T65_MCode.vhd:839:18 */
  assign n2217 = mode == 2'b00;
  /*# T65_MCode.vhd:839:30 */
  assign n2218 = ir[1]; // extract
  /*# T65_MCode.vhd:839:24 */
  assign n2219 = n2218 & n2217;
  /*# T65_MCode.vhd:839:11 */
  assign n2222 = n2219 ? 3'b111 : 3'b101;
  /*# T65_MCode.vhd:837:9 */
  assign n2224 = n2215 ? n2222 : 3'b101;
  /*# T65_MCode.vhd:837:9 */
  assign n2227 = n2215 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:844:11 */
  assign n2229 = mcycle == 3'b001;
  /*# T65_MCode.vhd:848:11 */
  assign n2231 = mcycle == 3'b010;
  /*# T65_MCode.vhd:852:11 */
  assign n2233 = mcycle == 3'b011;
  /*# T65_MCode.vhd:859:18 */
  assign n2234 = ir[7:5]; // extract
  /*# T65_MCode.vhd:859:31 */
  assign n2236 = n2234 == 3'b100;
  /*# T65_MCode.vhd:861:20 */
  assign n2237 = ir[3:0]; // extract
  /*# T65_MCode.vhd:861:33 */
  assign n2239 = n2237 == 4'b0011;
  /*# T65_MCode.vhd:861:15 */
  assign n2242 = n2239 ? 2'b10 : 2'b00;
  /*# T65_MCode.vhd:864:21 */
  assign n2243 = ir[1]; // extract
  /*# T65_MCode.vhd:864:24 */
  assign n2244 = ~n2243;
  /*# T65_MCode.vhd:864:34 */
  assign n2246 = ir == 8'b10110011;
  /*# T65_MCode.vhd:864:29 */
  assign n2247 = n2244 | n2246;
  /*# T65_MCode.vhd:864:13 */
  assign n2250 = n2247 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:859:13 */
  assign n2252 = n2236 ? n2242 : 2'b00;
  /*# T65_MCode.vhd:859:13 */
  assign n2254 = n2236 ? 1'b0 : n2250;
  /*# T65_MCode.vhd:859:13 */
  assign n2257 = n2236 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:857:11 */
  assign n2259 = mcycle == 3'b100;
  /*# T65_MCode.vhd:869:20 */
  assign n2261 = mode == 2'b00;
  /*# T65_MCode.vhd:869:32 */
  assign n2262 = ir[1]; // extract
  /*# T65_MCode.vhd:869:26 */
  assign n2263 = n2262 & n2261;
  /*# T65_MCode.vhd:869:46 */
  assign n2264 = ir[7:6]; // extract
  /*# T65_MCode.vhd:869:58 */
  assign n2266 = n2264 != 2'b10;
  /*# T65_MCode.vhd:869:40 */
  assign n2267 = n2266 & n2263;
  /*# T65_MCode.vhd:869:13 */
  assign n2270 = n2267 ? 2'b11 : 2'b00;
  /*# T65_MCode.vhd:869:13 */
  assign n2273 = n2267 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:869:13 */
  assign n2276 = n2267 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:868:11 */
  assign n2278 = mcycle == 3'b101;
  /*# T65_MCode.vhd:874:11 */
  assign n2280 = mcycle == 3'b110;
  /*# T65_MCode.vhd:879:11 */
  assign n2282 = mcycle == 3'b111;
  /*# T65_MCode.vhd:843:9 */
  assign n2283 = {n2282, n2280, n2278, n2259, n2233, n2231, n2229};
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2286 = 4'b0001;
      7'b0100000: n2286 = n1115;
      7'b0010000: n2286 = n1115;
      7'b0001000: n2286 = n1115;
      7'b0000100: n2286 = 4'b0011;
      7'b0000010: n2286 = n1115;
      7'b0000001: n2286 = n1115;
      default: n2286 = n1115;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2293 = 2'b00;
      7'b0100000: n2293 = 2'b11;
      7'b0010000: n2293 = n2270;
      7'b0001000: n2293 = 2'b11;
      7'b0000100: n2293 = 2'b11;
      7'b0000010: n2293 = 2'b10;
      7'b0000001: n2293 = 2'b10;
      default: n2293 = 2'b00;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2296 = 2'b00;
      7'b0100000: n2296 = 2'b00;
      7'b0010000: n2296 = 2'b00;
      7'b0001000: n2296 = 2'b00;
      7'b0000100: n2296 = 2'b00;
      7'b0000010: n2296 = 2'b00;
      7'b0000001: n2296 = 2'b01;
      default: n2296 = 2'b00;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2301 = 2'b00;
      7'b0100000: n2301 = 2'b00;
      7'b0010000: n2301 = 2'b00;
      7'b0001000: n2301 = 2'b11;
      7'b0000100: n2301 = 2'b10;
      7'b0000010: n2301 = 2'b01;
      7'b0000001: n2301 = 2'b00;
      default: n2301 = 2'b00;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2303 = 2'b00;
      7'b0100000: n2303 = 2'b00;
      7'b0010000: n2303 = 2'b00;
      7'b0001000: n2303 = n2252;
      7'b0000100: n2303 = 2'b00;
      7'b0000010: n2303 = 2'b00;
      7'b0000001: n2303 = 2'b00;
      default: n2303 = 2'b00;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2305 = 1'b0;
      7'b0100000: n2305 = 1'b0;
      7'b0010000: n2305 = 1'b0;
      7'b0001000: n2305 = n2254;
      7'b0000100: n2305 = 1'b0;
      7'b0000010: n2305 = 1'b0;
      7'b0000001: n2305 = 1'b0;
      default: n2305 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2307 = 1'b0;
      7'b0100000: n2307 = 1'b0;
      7'b0010000: n2307 = n2273;
      7'b0001000: n2307 = 1'b0;
      7'b0000100: n2307 = 1'b0;
      7'b0000010: n2307 = 1'b0;
      7'b0000001: n2307 = 1'b0;
      default: n2307 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2310 = 1'b0;
      7'b0100000: n2310 = 1'b1;
      7'b0010000: n2310 = 1'b0;
      7'b0001000: n2310 = 1'b0;
      7'b0000100: n2310 = 1'b0;
      7'b0000010: n2310 = 1'b0;
      7'b0000001: n2310 = 1'b0;
      default: n2310 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2313 = 1'b0;
      7'b0100000: n2313 = 1'b0;
      7'b0010000: n2313 = 1'b0;
      7'b0001000: n2313 = 1'b0;
      7'b0000100: n2313 = 1'b0;
      7'b0000010: n2313 = 1'b0;
      7'b0000001: n2313 = 1'b1;
      default: n2313 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2316 = 1'b0;
      7'b0100000: n2316 = 1'b0;
      7'b0010000: n2316 = 1'b0;
      7'b0001000: n2316 = 1'b0;
      7'b0000100: n2316 = 1'b0;
      7'b0000010: n2316 = 1'b1;
      7'b0000001: n2316 = 1'b0;
      default: n2316 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2319 = 1'b0;
      7'b0100000: n2319 = 1'b0;
      7'b0010000: n2319 = 1'b0;
      7'b0001000: n2319 = 1'b0;
      7'b0000100: n2319 = 1'b1;
      7'b0000010: n2319 = 1'b0;
      7'b0000001: n2319 = 1'b0;
      default: n2319 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2322 = 1'b0;
      7'b0100000: n2322 = 1'b1;
      7'b0010000: n2322 = 1'b0;
      7'b0001000: n2322 = 1'b0;
      7'b0000100: n2322 = 1'b0;
      7'b0000010: n2322 = 1'b0;
      7'b0000001: n2322 = 1'b0;
      default: n2322 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2325 = 1'b0;
      7'b0100000: n2325 = 1'b1;
      7'b0010000: n2325 = n2276;
      7'b0001000: n2325 = n2257;
      7'b0000100: n2325 = 1'b0;
      7'b0000010: n2325 = 1'b0;
      7'b0000001: n2325 = 1'b0;
      default: n2325 = 1'b0;
    endcase
  /*# T65_MCode.vhd:843:9 */
  always @*
    case (n2283)
      7'b1000000: n2328 = 1'b1;
      7'b0100000: n2328 = 1'b0;
      7'b0010000: n2328 = 1'b0;
      7'b0001000: n2328 = 1'b0;
      7'b0000100: n2328 = 1'b0;
      7'b0000010: n2328 = 1'b0;
      7'b0000001: n2328 = 1'b0;
      default: n2328 = 1'b0;
    endcase
  /*# T65_MCode.vhd:835:7 */
  assign n2330 = n1116 == 5'b10001;
  /*# T65_MCode.vhd:835:20 */
  assign n2332 = n1116 == 5'b10011;
  /*# T65_MCode.vhd:835:20 */
  assign n2333 = n2330 | n2332;
  /*# T65_MCode.vhd:891:14 */
  assign n2334 = ir[7:6]; // extract
  /*# T65_MCode.vhd:891:27 */
  assign n2336 = n2334 != 2'b10;
  /*# T65_MCode.vhd:891:41 */
  assign n2337 = ir[1]; // extract
  /*# T65_MCode.vhd:891:35 */
  assign n2338 = n2337 & n2336;
  /*# T65_MCode.vhd:891:60 */
  assign n2340 = mode == 2'b00;
  /*# T65_MCode.vhd:891:71 */
  assign n2341 = ir[0]; // extract
  /*# T65_MCode.vhd:891:74 */
  assign n2342 = ~n2341;
  /*# T65_MCode.vhd:891:66 */
  assign n2343 = n2340 | n2342;
  /*# T65_MCode.vhd:891:51 */
  assign n2344 = n2343 & n2338;
  /*# T65_MCode.vhd:893:18 */
  assign n2346 = mode == 2'b00;
  /*# T65_MCode.vhd:893:30 */
  assign n2347 = ir[0]; // extract
  /*# T65_MCode.vhd:893:24 */
  assign n2348 = n2347 & n2346;
  /*# T65_MCode.vhd:893:11 */
  assign n2350 = n2348 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:898:13 */
  assign n2352 = mcycle == 3'b001;
  /*# T65_MCode.vhd:902:13 */
  assign n2354 = mcycle == 3'b010;
  /*# T65_MCode.vhd:907:22 */
  assign n2356 = mode == 2'b00;
  /*# T65_MCode.vhd:907:15 */
  assign n2359 = n2356 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:905:13 */
  assign n2361 = mcycle == 3'b011;
  /*# T65_MCode.vhd:916:22 */
  assign n2363 = mode == 2'b00;
  /*# T65_MCode.vhd:916:34 */
  assign n2364 = ir[0]; // extract
  /*# T65_MCode.vhd:916:28 */
  assign n2365 = n2364 & n2363;
  /*# T65_MCode.vhd:916:15 */
  assign n2368 = n2365 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:911:13 */
  assign n2370 = mcycle == 3'b100;
  /*# T65_MCode.vhd:920:22 */
  assign n2372 = mode == 2'b00;
  /*# T65_MCode.vhd:920:34 */
  assign n2373 = ir[0]; // extract
  /*# T65_MCode.vhd:920:28 */
  assign n2374 = n2373 & n2372;
  /*# T65_MCode.vhd:920:15 */
  assign n2376 = n2374 ? 4'b0001 : n1115;
  /*# T65_MCode.vhd:920:15 */
  assign n2379 = n2374 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:919:13 */
  assign n2381 = mcycle == 3'b101;
  /*# T65_MCode.vhd:897:11 */
  assign n2382 = {n2381, n2370, n2361, n2354, n2352};
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2383 = n2376;
      5'b01000: n2383 = n1115;
      5'b00100: n2383 = n1115;
      5'b00010: n2383 = n1115;
      5'b00001: n2383 = n1115;
      default: n2383 = n1115;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2389 = 2'b00;
      5'b01000: n2389 = 2'b10;
      5'b00100: n2389 = 2'b10;
      5'b00010: n2389 = 2'b10;
      5'b00001: n2389 = 2'b10;
      default: n2389 = 2'b00;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2392 = 2'b00;
      5'b01000: n2392 = 2'b00;
      5'b00100: n2392 = 2'b00;
      5'b00010: n2392 = 2'b00;
      5'b00001: n2392 = 2'b01;
      default: n2392 = 2'b00;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2395 = 1'b0;
      5'b01000: n2395 = 1'b0;
      5'b00100: n2395 = 1'b0;
      5'b00010: n2395 = 1'b1;
      5'b00001: n2395 = 1'b0;
      default: n2395 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2398 = 1'b0;
      5'b01000: n2398 = n2368;
      5'b00100: n2398 = 1'b1;
      5'b00010: n2398 = 1'b0;
      5'b00001: n2398 = 1'b0;
      default: n2398 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2401 = 1'b0;
      5'b01000: n2401 = 1'b1;
      5'b00100: n2401 = 1'b0;
      5'b00010: n2401 = 1'b0;
      5'b00001: n2401 = 1'b0;
      default: n2401 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2404 = 1'b0;
      5'b01000: n2404 = 1'b0;
      5'b00100: n2404 = 1'b0;
      5'b00010: n2404 = 1'b0;
      5'b00001: n2404 = 1'b1;
      default: n2404 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2407 = 1'b0;
      5'b01000: n2407 = 1'b1;
      5'b00100: n2407 = 1'b0;
      5'b00010: n2407 = 1'b0;
      5'b00001: n2407 = 1'b0;
      default: n2407 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2410 = 1'b0;
      5'b01000: n2410 = 1'b1;
      5'b00100: n2410 = n2359;
      5'b00010: n2410 = 1'b0;
      5'b00001: n2410 = 1'b0;
      default: n2410 = 1'b0;
    endcase
  /*# T65_MCode.vhd:897:11 */
  always @*
    case (n2382)
      5'b10000: n2412 = n2379;
      5'b01000: n2412 = 1'b0;
      5'b00100: n2412 = 1'b0;
      5'b00010: n2412 = 1'b0;
      5'b00001: n2412 = 1'b0;
      default: n2412 = 1'b0;
    endcase
  /*# T65_MCode.vhd:928:16 */
  assign n2413 = ir[7:6]; // extract
  /*# T65_MCode.vhd:928:29 */
  assign n2415 = n2413 != 2'b10;
  /*# T65_MCode.vhd:928:43 */
  assign n2416 = ir[0]; // extract
  /*# T65_MCode.vhd:928:37 */
  assign n2417 = n2416 & n2415;
  /*# T65_MCode.vhd:928:11 */
  assign n2419 = n2417 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:932:13 */
  assign n2421 = mcycle == 3'b000;
  /*# T65_MCode.vhd:933:13 */
  assign n2423 = mcycle == 3'b001;
  /*# T65_MCode.vhd:940:21 */
  assign n2424 = ir[3:1]; // extract
  /*# T65_MCode.vhd:940:34 */
  assign n2426 = n2424 == 3'b011;
  /*# T65_MCode.vhd:940:15 */
  assign n2429 = n2426 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:943:20 */
  assign n2430 = ir[7:5]; // extract
  /*# T65_MCode.vhd:943:33 */
  assign n2432 = n2430 == 3'b100;
  /*# T65_MCode.vhd:943:15 */
  assign n2435 = n2432 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:937:13 */
  assign n2437 = mcycle == 3'b010;
  /*# T65_MCode.vhd:947:13 */
  assign n2439 = mcycle == 3'b011;
  /*# T65_MCode.vhd:931:11 */
  assign n2440 = {n2439, n2437, n2423, n2421};
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2444 = 2'b00;
      4'b0100: n2444 = 2'b10;
      4'b0010: n2444 = 2'b10;
      4'b0001: n2444 = 2'b00;
      default: n2444 = 2'b00;
    endcase
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2447 = 2'b00;
      4'b0100: n2447 = 2'b00;
      4'b0010: n2447 = 2'b01;
      4'b0001: n2447 = 2'b00;
      default: n2447 = 2'b00;
    endcase
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2450 = 1'b0;
      4'b0100: n2450 = 1'b1;
      4'b0010: n2450 = 1'b0;
      4'b0001: n2450 = 1'b0;
      default: n2450 = 1'b0;
    endcase
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2452 = 1'b0;
      4'b0100: n2452 = n2429;
      4'b0010: n2452 = 1'b0;
      4'b0001: n2452 = 1'b0;
      default: n2452 = 1'b0;
    endcase
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2455 = 1'b0;
      4'b0100: n2455 = 1'b0;
      4'b0010: n2455 = 1'b1;
      4'b0001: n2455 = 1'b0;
      default: n2455 = 1'b0;
    endcase
  /*# T65_MCode.vhd:931:11 */
  always @*
    case (n2440)
      4'b1000: n2457 = 1'b0;
      4'b0100: n2457 = n2435;
      4'b0010: n2457 = 1'b0;
      4'b0001: n2457 = 1'b0;
      default: n2457 = 1'b0;
    endcase
  /*# T65_MCode.vhd:891:9 */
  assign n2460 = n2344 ? 3'b101 : 3'b011;
  /*# T65_MCode.vhd:891:9 */
  assign n2461 = n2344 ? n2383 : n1115;
  /*# T65_MCode.vhd:891:9 */
  assign n2462 = n2344 ? n2389 : n2444;
  /*# T65_MCode.vhd:891:9 */
  assign n2463 = n2344 ? n2392 : n2447;
  /*# T65_MCode.vhd:891:9 */
  assign n2464 = n2344 ? n2395 : n2450;
  /*# T65_MCode.vhd:891:9 */
  assign n2466 = n2344 ? 1'b0 : n2452;
  /*# T65_MCode.vhd:891:9 */
  assign n2467 = n2344 ? n2350 : n2419;
  /*# T65_MCode.vhd:891:9 */
  assign n2469 = n2344 ? n2398 : 1'b0;
  /*# T65_MCode.vhd:891:9 */
  assign n2471 = n2344 ? n2401 : 1'b0;
  /*# T65_MCode.vhd:891:9 */
  assign n2472 = n2344 ? n2404 : n2455;
  /*# T65_MCode.vhd:891:9 */
  assign n2474 = n2344 ? n2407 : 1'b0;
  /*# T65_MCode.vhd:891:9 */
  assign n2475 = n2344 ? n2410 : n2457;
  /*# T65_MCode.vhd:891:9 */
  assign n2477 = n2344 ? n2412 : 1'b0;
  /*# T65_MCode.vhd:889:7 */
  assign n2479 = n1116 == 5'b10100;
  /*# T65_MCode.vhd:889:20 */
  assign n2481 = n1116 == 5'b10101;
  /*# T65_MCode.vhd:889:20 */
  assign n2482 = n2479 | n2481;
  /*# T65_MCode.vhd:889:30 */
  assign n2484 = n1116 == 5'b10110;
  /*# T65_MCode.vhd:889:30 */
  assign n2485 = n2482 | n2484;
  /*# T65_MCode.vhd:889:40 */
  assign n2487 = n1116 == 5'b10111;
  /*# T65_MCode.vhd:889:40 */
  assign n2488 = n2485 | n2487;
  /*# T65_MCode.vhd:957:14 */
  assign n2489 = ir[7:6]; // extract
  /*# T65_MCode.vhd:957:27 */
  assign n2491 = n2489 != 2'b10;
  /*# T65_MCode.vhd:959:18 */
  assign n2493 = mode == 2'b00;
  /*# T65_MCode.vhd:959:30 */
  assign n2494 = ir[1]; // extract
  /*# T65_MCode.vhd:959:24 */
  assign n2495 = n2494 & n2493;
  /*# T65_MCode.vhd:959:11 */
  assign n2498 = n2495 ? 3'b110 : 3'b100;
  /*# T65_MCode.vhd:957:9 */
  assign n2500 = n2491 ? n2498 : 3'b100;
  /*# T65_MCode.vhd:957:9 */
  assign n2503 = n2491 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:964:11 */
  assign n2505 = mcycle == 3'b001;
  /*# T65_MCode.vhd:967:11 */
  assign n2507 = mcycle == 3'b010;
  /*# T65_MCode.vhd:975:18 */
  assign n2508 = ir[7:5]; // extract
  /*# T65_MCode.vhd:975:31 */
  assign n2510 = n2508 == 3'b100;
  /*# T65_MCode.vhd:977:20 */
  assign n2511 = ir[3:0]; // extract
  /*# T65_MCode.vhd:977:33 */
  assign n2513 = n2511 == 4'b1011;
  /*# T65_MCode.vhd:977:15 */
  assign n2516 = n2513 ? 2'b01 : 2'b00;
  /*# T65_MCode.vhd:980:21 */
  assign n2517 = ir[1]; // extract
  /*# T65_MCode.vhd:980:24 */
  assign n2518 = ~n2517;
  /*# T65_MCode.vhd:980:34 */
  assign n2520 = ir == 8'b10111011;
  /*# T65_MCode.vhd:980:29 */
  assign n2521 = n2518 | n2520;
  /*# T65_MCode.vhd:980:13 */
  assign n2524 = n2521 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:975:13 */
  assign n2526 = n2510 ? n2516 : 2'b00;
  /*# T65_MCode.vhd:975:13 */
  assign n2528 = n2510 ? 1'b0 : n2524;
  /*# T65_MCode.vhd:975:13 */
  assign n2531 = n2510 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:973:11 */
  assign n2533 = mcycle == 3'b011;
  /*# T65_MCode.vhd:985:20 */
  assign n2535 = mode == 2'b00;
  /*# T65_MCode.vhd:985:32 */
  assign n2536 = ir[1]; // extract
  /*# T65_MCode.vhd:985:26 */
  assign n2537 = n2536 & n2535;
  /*# T65_MCode.vhd:985:46 */
  assign n2538 = ir[7:6]; // extract
  /*# T65_MCode.vhd:985:58 */
  assign n2540 = n2538 != 2'b10;
  /*# T65_MCode.vhd:985:40 */
  assign n2541 = n2540 & n2537;
  /*# T65_MCode.vhd:985:13 */
  assign n2544 = n2541 ? 2'b11 : 2'b00;
  /*# T65_MCode.vhd:985:13 */
  assign n2547 = n2541 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:985:13 */
  assign n2550 = n2541 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:984:11 */
  assign n2552 = mcycle == 3'b100;
  /*# T65_MCode.vhd:990:11 */
  assign n2554 = mcycle == 3'b101;
  /*# T65_MCode.vhd:995:11 */
  assign n2556 = mcycle == 3'b110;
  /*# T65_MCode.vhd:963:9 */
  assign n2557 = {n2556, n2554, n2552, n2533, n2507, n2505};
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2560 = 4'b0001;
      6'b010000: n2560 = n1115;
      6'b001000: n2560 = n1115;
      6'b000100: n2560 = n1115;
      6'b000010: n2560 = 4'b0011;
      6'b000001: n2560 = n1115;
      default: n2560 = n1115;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2565 = 2'b00;
      6'b010000: n2565 = 2'b11;
      6'b001000: n2565 = n2544;
      6'b000100: n2565 = 2'b11;
      6'b000010: n2565 = 2'b11;
      6'b000001: n2565 = 2'b00;
      default: n2565 = 2'b00;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2569 = 2'b00;
      6'b010000: n2569 = 2'b00;
      6'b001000: n2569 = 2'b00;
      6'b000100: n2569 = 2'b00;
      6'b000010: n2569 = 2'b01;
      6'b000001: n2569 = 2'b01;
      default: n2569 = 2'b00;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2573 = 2'b00;
      6'b010000: n2573 = 2'b00;
      6'b001000: n2573 = 2'b00;
      6'b000100: n2573 = 2'b11;
      6'b000010: n2573 = 2'b10;
      6'b000001: n2573 = 2'b00;
      default: n2573 = 2'b00;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2575 = 2'b00;
      6'b010000: n2575 = 2'b00;
      6'b001000: n2575 = 2'b00;
      6'b000100: n2575 = n2526;
      6'b000010: n2575 = 2'b00;
      6'b000001: n2575 = 2'b00;
      default: n2575 = 2'b00;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2577 = 1'b0;
      6'b010000: n2577 = 1'b0;
      6'b001000: n2577 = 1'b0;
      6'b000100: n2577 = n2528;
      6'b000010: n2577 = 1'b0;
      6'b000001: n2577 = 1'b0;
      default: n2577 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2579 = 1'b0;
      6'b010000: n2579 = 1'b0;
      6'b001000: n2579 = n2547;
      6'b000100: n2579 = 1'b0;
      6'b000010: n2579 = 1'b0;
      6'b000001: n2579 = 1'b0;
      default: n2579 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2582 = 1'b0;
      6'b010000: n2582 = 1'b1;
      6'b001000: n2582 = 1'b0;
      6'b000100: n2582 = 1'b0;
      6'b000010: n2582 = 1'b0;
      6'b000001: n2582 = 1'b0;
      default: n2582 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2585 = 1'b0;
      6'b010000: n2585 = 1'b0;
      6'b001000: n2585 = 1'b0;
      6'b000100: n2585 = 1'b0;
      6'b000010: n2585 = 1'b0;
      6'b000001: n2585 = 1'b1;
      default: n2585 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2588 = 1'b0;
      6'b010000: n2588 = 1'b0;
      6'b001000: n2588 = 1'b0;
      6'b000100: n2588 = 1'b0;
      6'b000010: n2588 = 1'b1;
      6'b000001: n2588 = 1'b0;
      default: n2588 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2591 = 1'b0;
      6'b010000: n2591 = 1'b1;
      6'b001000: n2591 = 1'b0;
      6'b000100: n2591 = 1'b0;
      6'b000010: n2591 = 1'b0;
      6'b000001: n2591 = 1'b0;
      default: n2591 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2594 = 1'b0;
      6'b010000: n2594 = 1'b1;
      6'b001000: n2594 = n2550;
      6'b000100: n2594 = n2531;
      6'b000010: n2594 = 1'b0;
      6'b000001: n2594 = 1'b0;
      default: n2594 = 1'b0;
    endcase
  /*# T65_MCode.vhd:963:9 */
  always @*
    case (n2557)
      6'b100000: n2597 = 1'b1;
      6'b010000: n2597 = 1'b0;
      6'b001000: n2597 = 1'b0;
      6'b000100: n2597 = 1'b0;
      6'b000010: n2597 = 1'b0;
      6'b000001: n2597 = 1'b0;
      default: n2597 = 1'b0;
    endcase
  /*# T65_MCode.vhd:954:7 */
  assign n2599 = n1116 == 5'b11001;
  /*# T65_MCode.vhd:954:20 */
  assign n2601 = n1116 == 5'b11011;
  /*# T65_MCode.vhd:954:20 */
  assign n2602 = n2599 | n2601;
  /*# T65_MCode.vhd:1007:14 */
  assign n2603 = ir[7:6]; // extract
  /*# T65_MCode.vhd:1007:27 */
  assign n2605 = n2603 != 2'b10;
  /*# T65_MCode.vhd:1007:41 */
  assign n2606 = ir[1]; // extract
  /*# T65_MCode.vhd:1007:35 */
  assign n2607 = n2606 & n2605;
  /*# T65_MCode.vhd:1007:60 */
  assign n2609 = mode == 2'b00;
  /*# T65_MCode.vhd:1007:71 */
  assign n2610 = ir[0]; // extract
  /*# T65_MCode.vhd:1007:74 */
  assign n2611 = ~n2610;
  /*# T65_MCode.vhd:1007:66 */
  assign n2612 = n2609 | n2611;
  /*# T65_MCode.vhd:1007:51 */
  assign n2613 = n2612 & n2607;
  /*# T65_MCode.vhd:1010:18 */
  assign n2615 = mode == 2'b00;
  /*# T65_MCode.vhd:1010:30 */
  assign n2616 = ir[0]; // extract
  /*# T65_MCode.vhd:1010:24 */
  assign n2617 = n2616 & n2615;
  /*# T65_MCode.vhd:1010:11 */
  assign n2619 = n2617 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:1014:13 */
  assign n2621 = mcycle == 3'b001;
  /*# T65_MCode.vhd:1017:13 */
  assign n2623 = mcycle == 3'b010;
  /*# T65_MCode.vhd:1023:13 */
  assign n2625 = mcycle == 3'b011;
  /*# T65_MCode.vhd:1028:22 */
  assign n2627 = mode == 2'b00;
  /*# T65_MCode.vhd:1028:15 */
  assign n2630 = n2627 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:1026:13 */
  assign n2632 = mcycle == 3'b100;
  /*# T65_MCode.vhd:1032:13 */
  assign n2634 = mcycle == 3'b101;
  /*# T65_MCode.vhd:1038:22 */
  assign n2636 = mode == 2'b00;
  /*# T65_MCode.vhd:1038:34 */
  assign n2637 = ir[0]; // extract
  /*# T65_MCode.vhd:1038:28 */
  assign n2638 = n2637 & n2636;
  /*# T65_MCode.vhd:1038:15 */
  assign n2640 = n2638 ? 4'b0001 : n1115;
  /*# T65_MCode.vhd:1038:15 */
  assign n2643 = n2638 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:1037:13 */
  assign n2645 = mcycle == 3'b110;
  /*# T65_MCode.vhd:1013:11 */
  assign n2646 = {n2645, n2634, n2632, n2625, n2623, n2621};
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2648 = n2640;
      6'b010000: n2648 = n1115;
      6'b001000: n2648 = n1115;
      6'b000100: n2648 = n1115;
      6'b000010: n2648 = 4'b0010;
      6'b000001: n2648 = n1115;
      default: n2648 = n1115;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2654 = 2'b00;
      6'b010000: n2654 = 2'b11;
      6'b001000: n2654 = 2'b11;
      6'b000100: n2654 = 2'b11;
      6'b000010: n2654 = 2'b11;
      6'b000001: n2654 = 2'b00;
      default: n2654 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2658 = 2'b00;
      6'b010000: n2658 = 2'b00;
      6'b001000: n2658 = 2'b00;
      6'b000100: n2658 = 2'b00;
      6'b000010: n2658 = 2'b01;
      6'b000001: n2658 = 2'b01;
      default: n2658 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2662 = 2'b00;
      6'b010000: n2662 = 2'b00;
      6'b001000: n2662 = 2'b00;
      6'b000100: n2662 = 2'b11;
      6'b000010: n2662 = 2'b10;
      6'b000001: n2662 = 2'b00;
      default: n2662 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2665 = 1'b0;
      6'b010000: n2665 = 1'b0;
      6'b001000: n2665 = 1'b1;
      6'b000100: n2665 = 1'b0;
      6'b000010: n2665 = 1'b0;
      6'b000001: n2665 = 1'b0;
      default: n2665 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2668 = 1'b0;
      6'b010000: n2668 = 1'b1;
      6'b001000: n2668 = 1'b0;
      6'b000100: n2668 = 1'b0;
      6'b000010: n2668 = 1'b0;
      6'b000001: n2668 = 1'b0;
      default: n2668 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2671 = 1'b0;
      6'b010000: n2671 = 1'b0;
      6'b001000: n2671 = 1'b0;
      6'b000100: n2671 = 1'b0;
      6'b000010: n2671 = 1'b0;
      6'b000001: n2671 = 1'b1;
      default: n2671 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2674 = 1'b0;
      6'b010000: n2674 = 1'b0;
      6'b001000: n2674 = 1'b0;
      6'b000100: n2674 = 1'b0;
      6'b000010: n2674 = 1'b1;
      6'b000001: n2674 = 1'b0;
      default: n2674 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2677 = 1'b0;
      6'b010000: n2677 = 1'b1;
      6'b001000: n2677 = 1'b0;
      6'b000100: n2677 = 1'b0;
      6'b000010: n2677 = 1'b0;
      6'b000001: n2677 = 1'b0;
      default: n2677 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2680 = 1'b0;
      6'b010000: n2680 = 1'b1;
      6'b001000: n2680 = n2630;
      6'b000100: n2680 = 1'b0;
      6'b000010: n2680 = 1'b0;
      6'b000001: n2680 = 1'b0;
      default: n2680 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1013:11 */
  always @*
    case (n2646)
      6'b100000: n2682 = n2643;
      6'b010000: n2682 = 1'b0;
      6'b001000: n2682 = 1'b0;
      6'b000100: n2682 = 1'b0;
      6'b000010: n2682 = 1'b0;
      6'b000001: n2682 = 1'b0;
      default: n2682 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1046:16 */
  assign n2683 = ir[7:6]; // extract
  /*# T65_MCode.vhd:1046:29 */
  assign n2685 = n2683 != 2'b10;
  /*# T65_MCode.vhd:1047:20 */
  assign n2687 = mode != 2'b00;
  /*# T65_MCode.vhd:1047:32 */
  assign n2688 = ir[4]; // extract
  /*# T65_MCode.vhd:1047:35 */
  assign n2689 = ~n2688;
  /*# T65_MCode.vhd:1047:27 */
  assign n2690 = n2687 | n2689;
  /*# T65_MCode.vhd:1047:45 */
  assign n2691 = ir[1:0]; // extract
  /*# T65_MCode.vhd:1047:57 */
  assign n2693 = n2691 != 2'b00;
  /*# T65_MCode.vhd:1047:40 */
  assign n2694 = n2690 | n2693;
  /*# T65_MCode.vhd:1046:11 */
  assign n2696 = n2697 ? 1'b1 : n1088;
  /*# T65_MCode.vhd:1046:11 */
  assign n2697 = n2694 & n2685;
  /*# T65_MCode.vhd:1052:13 */
  assign n2699 = mcycle == 3'b000;
  /*# T65_MCode.vhd:1053:13 */
  assign n2701 = mcycle == 3'b001;
  /*# T65_MCode.vhd:1059:20 */
  assign n2702 = ir[7:6]; // extract
  /*# T65_MCode.vhd:1059:32 */
  assign n2704 = n2702 == 2'b10;
  /*# T65_MCode.vhd:1059:44 */
  assign n2705 = ir[4:1]; // extract
  /*# T65_MCode.vhd:1059:56 */
  assign n2707 = n2705 == 4'b1111;
  /*# T65_MCode.vhd:1059:38 */
  assign n2708 = n2707 & n2704;
  /*# T65_MCode.vhd:1059:15 */
  assign n2711 = n2708 ? 4'b0011 : 4'b0010;
  /*# T65_MCode.vhd:1056:13 */
  assign n2713 = mcycle == 3'b010;
  /*# T65_MCode.vhd:1069:20 */
  assign n2714 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1069:33 */
  assign n2716 = n2714 == 3'b100;
  /*# T65_MCode.vhd:1071:24 */
  assign n2717 = ir[1:0]; // extract
  /*# T65_MCode.vhd:1072:17 */
  assign n2719 = n2717 == 2'b00;
  /*# T65_MCode.vhd:1072:26 */
  assign n2721 = n2717 == 2'b10;
  /*# T65_MCode.vhd:1072:26 */
  assign n2722 = n2719 | n2721;
  /*# T65_MCode.vhd:1073:17 */
  assign n2724 = n2717 == 2'b11;
  /*# T65_MCode.vhd:1071:17 */
  assign n2725 = {n2724, n2722};
  /*# T65_MCode.vhd:1071:17 */
  always @*
    case (n2725)
      2'b10: n2729 = 2'b10;
      2'b01: n2729 = 2'b01;
      default: n2729 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1069:15 */
  assign n2731 = n2716 ? n2729 : 2'b00;
  /*# T65_MCode.vhd:1069:15 */
  assign n2734 = n2716 ? 1'b0 : 1'b1;
  /*# T65_MCode.vhd:1069:15 */
  assign n2737 = n2716 ? 1'b1 : 1'b0;
  /*# T65_MCode.vhd:1067:13 */
  assign n2739 = mcycle == 3'b011;
  /*# T65_MCode.vhd:1080:13 */
  assign n2741 = mcycle == 3'b100;
  /*# T65_MCode.vhd:1051:11 */
  assign n2742 = {n2741, n2739, n2713, n2701, n2699};
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2743 = n1115;
      5'b01000: n2743 = n1115;
      5'b00100: n2743 = n2711;
      5'b00010: n2743 = n1115;
      5'b00001: n2743 = n1115;
      default: n2743 = n1115;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2747 = 2'b00;
      5'b01000: n2747 = 2'b11;
      5'b00100: n2747 = 2'b11;
      5'b00010: n2747 = 2'b00;
      5'b00001: n2747 = 2'b00;
      default: n2747 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2751 = 2'b00;
      5'b01000: n2751 = 2'b00;
      5'b00100: n2751 = 2'b01;
      5'b00010: n2751 = 2'b01;
      5'b00001: n2751 = 2'b00;
      default: n2751 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2755 = 2'b00;
      5'b01000: n2755 = 2'b11;
      5'b00100: n2755 = 2'b10;
      5'b00010: n2755 = 2'b00;
      5'b00001: n2755 = 2'b00;
      default: n2755 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2757 = 2'b00;
      5'b01000: n2757 = n2731;
      5'b00100: n2757 = 2'b00;
      5'b00010: n2757 = 2'b00;
      5'b00001: n2757 = 2'b00;
      default: n2757 = 2'b00;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2759 = 1'b0;
      5'b01000: n2759 = n2734;
      5'b00100: n2759 = 1'b0;
      5'b00010: n2759 = 1'b0;
      5'b00001: n2759 = 1'b0;
      default: n2759 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2762 = 1'b0;
      5'b01000: n2762 = 1'b0;
      5'b00100: n2762 = 1'b0;
      5'b00010: n2762 = 1'b1;
      5'b00001: n2762 = 1'b0;
      default: n2762 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2765 = 1'b0;
      5'b01000: n2765 = 1'b0;
      5'b00100: n2765 = 1'b1;
      5'b00010: n2765 = 1'b0;
      5'b00001: n2765 = 1'b0;
      default: n2765 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1051:11 */
  always @*
    case (n2742)
      5'b10000: n2767 = 1'b0;
      5'b01000: n2767 = n2737;
      5'b00100: n2767 = 1'b0;
      5'b00010: n2767 = 1'b0;
      5'b00001: n2767 = 1'b0;
      default: n2767 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1007:9 */
  assign n2770 = n2613 ? 3'b110 : 3'b100;
  /*# T65_MCode.vhd:1007:9 */
  assign n2771 = n2613 ? n2648 : n2743;
  /*# T65_MCode.vhd:1007:9 */
  assign n2772 = n2613 ? n2654 : n2747;
  /*# T65_MCode.vhd:1007:9 */
  assign n2773 = n2613 ? n2658 : n2751;
  /*# T65_MCode.vhd:1007:9 */
  assign n2774 = n2613 ? n2662 : n2755;
  /*# T65_MCode.vhd:1007:9 */
  assign n2776 = n2613 ? 2'b00 : n2757;
  /*# T65_MCode.vhd:1007:9 */
  assign n2778 = n2613 ? 1'b0 : n2759;
  /*# T65_MCode.vhd:1007:9 */
  assign n2779 = n2613 ? n2619 : n2696;
  /*# T65_MCode.vhd:1007:9 */
  assign n2781 = n2613 ? n2665 : 1'b0;
  /*# T65_MCode.vhd:1007:9 */
  assign n2783 = n2613 ? n2668 : 1'b0;
  /*# T65_MCode.vhd:1007:9 */
  assign n2784 = n2613 ? n2671 : n2762;
  /*# T65_MCode.vhd:1007:9 */
  assign n2785 = n2613 ? n2674 : n2765;
  /*# T65_MCode.vhd:1007:9 */
  assign n2787 = n2613 ? n2677 : 1'b0;
  /*# T65_MCode.vhd:1007:9 */
  assign n2788 = n2613 ? n2680 : n2767;
  /*# T65_MCode.vhd:1007:9 */
  assign n2790 = n2613 ? n2682 : 1'b0;
  /*# T65_MCode.vhd:1005:7 */
  assign n2792 = n1116 == 5'b11100;
  /*# T65_MCode.vhd:1005:20 */
  assign n2794 = n1116 == 5'b11101;
  /*# T65_MCode.vhd:1005:20 */
  assign n2795 = n2792 | n2794;
  /*# T65_MCode.vhd:1005:30 */
  assign n2797 = n1116 == 5'b11110;
  /*# T65_MCode.vhd:1005:30 */
  assign n2798 = n2795 | n2797;
  /*# T65_MCode.vhd:1005:40 */
  assign n2800 = n1116 == 5'b11111;
  /*# T65_MCode.vhd:1005:40 */
  assign n2801 = n2798 | n2800;
  /*# T65_MCode.vhd:234:5 */
  assign n2802 = {n2801, n2602, n2488, n2333, n2212, n2190, n2057, n1921, n1798, n1764, n1731, n1686, n1674, n1575};
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2805 = n2770;
      14'b01000000000000: n2805 = n2500;
      14'b00100000000000: n2805 = n2460;
      14'b00010000000000: n2805 = n2224;
      14'b00001000000000: n2805 = n2193;
      14'b00000100000000: n2805 = n2167;
      14'b00000010000000: n2805 = n2043;
      14'b00000001000000: n2805 = n1899;
      14'b00000000100000: n2805 = 3'b010;
      14'b00000000010000: n2805 = 3'b001;
      14'b00000000001000: n2805 = 3'b001;
      14'b00000000000100: n2805 = 3'b001;
      14'b00000000000010: n2805 = n1587;
      14'b00000000000001: n2805 = n1532;
      default: n2805 = 3'b001;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2807 = n2771;
      14'b01000000000000: n2807 = n2560;
      14'b00100000000000: n2807 = n2461;
      14'b00010000000000: n2807 = n2286;
      14'b00001000000000: n2807 = n1115;
      14'b00000100000000: n2807 = n2168;
      14'b00000010000000: n2807 = n1115;
      14'b00000001000000: n2807 = n1900;
      14'b00000000100000: n2807 = n1115;
      14'b00000000010000: n2807 = n1115;
      14'b00000000001000: n2807 = n1725;
      14'b00000000000100: n2807 = n1115;
      14'b00000000000010: n2807 = n1630;
      14'b00000000000001: n2807 = n1534;
      default: n2807 = n1115;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2809 = n2772;
      14'b01000000000000: n2809 = n2565;
      14'b00100000000000: n2809 = n2462;
      14'b00010000000000: n2809 = n2293;
      14'b00001000000000: n2809 = 2'b00;
      14'b00000100000000: n2809 = n2169;
      14'b00000010000000: n2809 = n2044;
      14'b00000001000000: n2809 = n1901;
      14'b00000000100000: n2809 = n1786;
      14'b00000000010000: n2809 = 2'b00;
      14'b00000000001000: n2809 = 2'b00;
      14'b00000000000100: n2809 = 2'b00;
      14'b00000000000010: n2809 = n1637;
      14'b00000000000001: n2809 = n1536;
      default: n2809 = 2'b00;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2811 = n1085;
      14'b01000000000000: n2811 = n1085;
      14'b00100000000000: n2811 = n1085;
      14'b00010000000000: n2811 = n1085;
      14'b00001000000000: n2811 = n1085;
      14'b00000100000000: n2811 = n1085;
      14'b00000010000000: n2811 = n1085;
      14'b00000001000000: n2811 = n1085;
      14'b00000000100000: n2811 = n1085;
      14'b00000000010000: n2811 = n1085;
      14'b00000000001000: n2811 = n1085;
      14'b00000000000100: n2811 = n1085;
      14'b00000000000010: n2811 = n1085;
      14'b00000000000001: n2811 = n1537;
      default: n2811 = n1085;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2813 = n2773;
      14'b01000000000000: n2813 = n2569;
      14'b00100000000000: n2813 = n2463;
      14'b00010000000000: n2813 = n2296;
      14'b00001000000000: n2813 = n2204;
      14'b00000100000000: n2813 = n2170;
      14'b00000010000000: n2813 = n2045;
      14'b00000001000000: n2813 = n1902;
      14'b00000000100000: n2813 = n1789;
      14'b00000000010000: n2813 = n1758;
      14'b00000000001000: n2813 = n1727;
      14'b00000000000100: n2813 = n1684;
      14'b00000000000010: n2813 = n1640;
      14'b00000000000001: n2813 = n1539;
      default: n2813 = 2'b00;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2816 = n2774;
      14'b01000000000000: n2816 = n2573;
      14'b00100000000000: n2816 = 2'b00;
      14'b00010000000000: n2816 = n2301;
      14'b00001000000000: n2816 = 2'b00;
      14'b00000100000000: n2816 = 2'b00;
      14'b00000010000000: n2816 = n2047;
      14'b00000001000000: n2816 = 2'b00;
      14'b00000000100000: n2816 = 2'b00;
      14'b00000000010000: n2816 = 2'b00;
      14'b00000000001000: n2816 = 2'b00;
      14'b00000000000100: n2816 = 2'b00;
      14'b00000000000010: n2816 = n1643;
      14'b00000000000001: n2816 = 2'b00;
      default: n2816 = 2'b00;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2819 = n2776;
      14'b01000000000000: n2819 = n2575;
      14'b00100000000000: n2819 = 2'b00;
      14'b00010000000000: n2819 = n2303;
      14'b00001000000000: n2819 = 2'b00;
      14'b00000100000000: n2819 = 2'b00;
      14'b00000010000000: n2819 = 2'b00;
      14'b00000001000000: n2819 = 2'b00;
      14'b00000000100000: n2819 = 2'b00;
      14'b00000000010000: n2819 = 2'b00;
      14'b00000000001000: n2819 = 2'b00;
      14'b00000000000100: n2819 = 2'b00;
      14'b00000000000010: n2819 = 2'b00;
      14'b00000000000001: n2819 = 2'b00;
      default: n2819 = 2'b00;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2822 = n2778;
      14'b01000000000000: n2822 = n2577;
      14'b00100000000000: n2822 = 1'b0;
      14'b00010000000000: n2822 = n2305;
      14'b00001000000000: n2822 = 1'b0;
      14'b00000100000000: n2822 = 1'b0;
      14'b00000010000000: n2822 = 1'b0;
      14'b00000001000000: n2822 = 1'b0;
      14'b00000000100000: n2822 = 1'b0;
      14'b00000000010000: n2822 = 1'b0;
      14'b00000000001000: n2822 = 1'b0;
      14'b00000000000100: n2822 = 1'b0;
      14'b00000000000010: n2822 = 1'b0;
      14'b00000000000001: n2822 = 1'b0;
      default: n2822 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2825 = 1'b0;
      14'b01000000000000: n2825 = 1'b0;
      14'b00100000000000: n2825 = n2464;
      14'b00010000000000: n2825 = 1'b0;
      14'b00001000000000: n2825 = 1'b0;
      14'b00000100000000: n2825 = 1'b0;
      14'b00000010000000: n2825 = 1'b0;
      14'b00000001000000: n2825 = 1'b0;
      14'b00000000100000: n2825 = 1'b0;
      14'b00000000010000: n2825 = 1'b0;
      14'b00000000001000: n2825 = 1'b0;
      14'b00000000000100: n2825 = 1'b0;
      14'b00000000000010: n2825 = n1646;
      14'b00000000000001: n2825 = 1'b0;
      default: n2825 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2828 = 1'b0;
      14'b01000000000000: n2828 = 1'b0;
      14'b00100000000000: n2828 = n2466;
      14'b00010000000000: n2828 = 1'b0;
      14'b00001000000000: n2828 = 1'b0;
      14'b00000100000000: n2828 = 1'b0;
      14'b00000010000000: n2828 = 1'b0;
      14'b00000001000000: n2828 = 1'b0;
      14'b00000000100000: n2828 = 1'b0;
      14'b00000000010000: n2828 = 1'b0;
      14'b00000000001000: n2828 = 1'b0;
      14'b00000000000100: n2828 = 1'b0;
      14'b00000000000010: n2828 = 1'b0;
      14'b00000000000001: n2828 = 1'b0;
      default: n2828 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2831 = 1'b0;
      14'b01000000000000: n2831 = 1'b0;
      14'b00100000000000: n2831 = 1'b0;
      14'b00010000000000: n2831 = 1'b0;
      14'b00001000000000: n2831 = n2207;
      14'b00000100000000: n2831 = 1'b0;
      14'b00000010000000: n2831 = 1'b0;
      14'b00000001000000: n2831 = 1'b0;
      14'b00000000100000: n2831 = 1'b0;
      14'b00000000010000: n2831 = 1'b0;
      14'b00000000001000: n2831 = 1'b0;
      14'b00000000000100: n2831 = 1'b0;
      14'b00000000000010: n2831 = 1'b0;
      14'b00000000000001: n2831 = 1'b0;
      default: n2831 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2834 = 1'b0;
      14'b01000000000000: n2834 = 1'b0;
      14'b00100000000000: n2834 = 1'b0;
      14'b00010000000000: n2834 = 1'b0;
      14'b00001000000000: n2834 = 1'b0;
      14'b00000100000000: n2834 = 1'b0;
      14'b00000010000000: n2834 = 1'b0;
      14'b00000001000000: n2834 = 1'b0;
      14'b00000000100000: n2834 = 1'b0;
      14'b00000000010000: n2834 = 1'b0;
      14'b00000000001000: n2834 = 1'b0;
      14'b00000000000100: n2834 = 1'b0;
      14'b00000000000010: n2834 = 1'b0;
      14'b00000000000001: n2834 = n1541;
      default: n2834 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2837 = 1'b0;
      14'b01000000000000: n2837 = 1'b0;
      14'b00100000000000: n2837 = 1'b0;
      14'b00010000000000: n2837 = 1'b0;
      14'b00001000000000: n2837 = 1'b0;
      14'b00000100000000: n2837 = 1'b0;
      14'b00000010000000: n2837 = 1'b0;
      14'b00000001000000: n2837 = 1'b0;
      14'b00000000100000: n2837 = 1'b0;
      14'b00000000010000: n2837 = 1'b0;
      14'b00000000001000: n2837 = 1'b0;
      14'b00000000000100: n2837 = 1'b0;
      14'b00000000000010: n2837 = 1'b0;
      14'b00000000000001: n2837 = n1543;
      default: n2837 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2839 = n2779;
      14'b01000000000000: n2839 = n2503;
      14'b00100000000000: n2839 = n2467;
      14'b00010000000000: n2839 = n2227;
      14'b00001000000000: n2839 = n1088;
      14'b00000100000000: n2839 = n2171;
      14'b00000010000000: n2839 = n1088;
      14'b00000001000000: n2839 = n1903;
      14'b00000000100000: n2839 = n1088;
      14'b00000000010000: n2839 = n1088;
      14'b00000000001000: n2839 = n1728;
      14'b00000000000100: n2839 = n1679;
      14'b00000000000010: n2839 = n1590;
      14'b00000000000001: n2839 = n1546;
      default: n2839 = n1088;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2841 = 1'b0;
      14'b01000000000000: n2841 = 1'b0;
      14'b00100000000000: n2841 = 1'b0;
      14'b00010000000000: n2841 = 1'b0;
      14'b00001000000000: n2841 = 1'b0;
      14'b00000100000000: n2841 = 1'b0;
      14'b00000010000000: n2841 = 1'b0;
      14'b00000001000000: n2841 = 1'b0;
      14'b00000000100000: n2841 = 1'b0;
      14'b00000000010000: n2841 = 1'b0;
      14'b00000000001000: n2841 = 1'b0;
      14'b00000000000100: n2841 = 1'b0;
      14'b00000000000010: n2841 = 1'b0;
      14'b00000000000001: n2841 = n1548;
      default: n2841 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2843 = n1091;
      14'b01000000000000: n2843 = n1091;
      14'b00100000000000: n2843 = n1091;
      14'b00010000000000: n2843 = n1091;
      14'b00001000000000: n2843 = n1091;
      14'b00000100000000: n2843 = n1091;
      14'b00000010000000: n2843 = n1091;
      14'b00000001000000: n2843 = n1091;
      14'b00000000100000: n2843 = n1091;
      14'b00000000010000: n2843 = n1759;
      14'b00000000001000: n2843 = n1729;
      14'b00000000000100: n2843 = n1091;
      14'b00000000000010: n2843 = n1091;
      14'b00000000000001: n2843 = n1551;
      default: n2843 = n1091;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2844 = n1094;
      14'b01000000000000: n2844 = n1094;
      14'b00100000000000: n2844 = n1094;
      14'b00010000000000: n2844 = n1094;
      14'b00001000000000: n2844 = n1094;
      14'b00000100000000: n2844 = n1094;
      14'b00000010000000: n2844 = n1094;
      14'b00000001000000: n2844 = n1094;
      14'b00000000100000: n2844 = n1094;
      14'b00000000010000: n2844 = n1094;
      14'b00000000001000: n2844 = n1094;
      14'b00000000000100: n2844 = n1094;
      14'b00000000000010: n2844 = n1094;
      14'b00000000000001: n2844 = n1553;
      default: n2844 = n1094;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2845 = n1097;
      14'b01000000000000: n2845 = n1097;
      14'b00100000000000: n2845 = n1097;
      14'b00010000000000: n2845 = n1097;
      14'b00001000000000: n2845 = n1097;
      14'b00000100000000: n2845 = n1097;
      14'b00000010000000: n2845 = n1097;
      14'b00000001000000: n2845 = n1097;
      14'b00000000100000: n2845 = n1097;
      14'b00000000010000: n2845 = n1097;
      14'b00000000001000: n2845 = n1097;
      14'b00000000000100: n2845 = n1097;
      14'b00000000000010: n2845 = n1097;
      14'b00000000000001: n2845 = n1555;
      default: n2845 = n1097;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2847 = n2781;
      14'b01000000000000: n2847 = n2579;
      14'b00100000000000: n2847 = n2469;
      14'b00010000000000: n2847 = n2307;
      14'b00001000000000: n2847 = n2210;
      14'b00000100000000: n2847 = n2173;
      14'b00000010000000: n2847 = n2049;
      14'b00000001000000: n2847 = n1905;
      14'b00000000100000: n2847 = 1'b0;
      14'b00000000010000: n2847 = 1'b0;
      14'b00000000001000: n2847 = 1'b0;
      14'b00000000000100: n2847 = 1'b0;
      14'b00000000000010: n2847 = n1648;
      14'b00000000000001: n2847 = n1557;
      default: n2847 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2850 = n2783;
      14'b01000000000000: n2850 = n2582;
      14'b00100000000000: n2850 = n2471;
      14'b00010000000000: n2850 = n2310;
      14'b00001000000000: n2850 = 1'b0;
      14'b00000100000000: n2850 = n2175;
      14'b00000010000000: n2850 = 1'b0;
      14'b00000001000000: n2850 = n1907;
      14'b00000000100000: n2850 = 1'b0;
      14'b00000000010000: n2850 = 1'b0;
      14'b00000000001000: n2850 = 1'b0;
      14'b00000000000100: n2850 = 1'b0;
      14'b00000000000010: n2850 = n1651;
      14'b00000000000001: n2850 = 1'b0;
      default: n2850 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2853 = 1'b0;
      14'b01000000000000: n2853 = 1'b0;
      14'b00100000000000: n2853 = n2472;
      14'b00010000000000: n2853 = n2313;
      14'b00001000000000: n2853 = 1'b0;
      14'b00000100000000: n2853 = 1'b0;
      14'b00000010000000: n2853 = 1'b0;
      14'b00000001000000: n2853 = n1908;
      14'b00000000100000: n2853 = n1792;
      14'b00000000010000: n2853 = 1'b0;
      14'b00000000001000: n2853 = 1'b0;
      14'b00000000000100: n2853 = 1'b0;
      14'b00000000000010: n2853 = n1654;
      14'b00000000000001: n2853 = 1'b0;
      default: n2853 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2856 = n2784;
      14'b01000000000000: n2856 = n2585;
      14'b00100000000000: n2856 = 1'b0;
      14'b00010000000000: n2856 = n2316;
      14'b00001000000000: n2856 = 1'b0;
      14'b00000100000000: n2856 = n2176;
      14'b00000010000000: n2856 = n2050;
      14'b00000001000000: n2856 = 1'b0;
      14'b00000000100000: n2856 = 1'b0;
      14'b00000000010000: n2856 = 1'b0;
      14'b00000000001000: n2856 = 1'b0;
      14'b00000000000100: n2856 = 1'b0;
      14'b00000000000010: n2856 = n1657;
      14'b00000000000001: n2856 = 1'b0;
      default: n2856 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2859 = n2785;
      14'b01000000000000: n2859 = n2588;
      14'b00100000000000: n2859 = 1'b0;
      14'b00010000000000: n2859 = n2319;
      14'b00001000000000: n2859 = 1'b0;
      14'b00000100000000: n2859 = n2177;
      14'b00000010000000: n2859 = n2051;
      14'b00000001000000: n2859 = 1'b0;
      14'b00000000100000: n2859 = 1'b0;
      14'b00000000010000: n2859 = 1'b0;
      14'b00000000001000: n2859 = 1'b0;
      14'b00000000000100: n2859 = 1'b0;
      14'b00000000000010: n2859 = n1660;
      14'b00000000000001: n2859 = 1'b0;
      default: n2859 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2862 = n2787;
      14'b01000000000000: n2862 = n2591;
      14'b00100000000000: n2862 = n2474;
      14'b00010000000000: n2862 = n2322;
      14'b00001000000000: n2862 = 1'b0;
      14'b00000100000000: n2862 = n2179;
      14'b00000010000000: n2862 = n2053;
      14'b00000001000000: n2862 = n1910;
      14'b00000000100000: n2862 = n1794;
      14'b00000000010000: n2862 = 1'b0;
      14'b00000000001000: n2862 = 1'b0;
      14'b00000000000100: n2862 = 1'b0;
      14'b00000000000010: n2862 = n1663;
      14'b00000000000001: n2862 = n1559;
      default: n2862 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2865 = n2788;
      14'b01000000000000: n2865 = n2594;
      14'b00100000000000: n2865 = n2475;
      14'b00010000000000: n2865 = n2325;
      14'b00001000000000: n2865 = 1'b0;
      14'b00000100000000: n2865 = n2180;
      14'b00000010000000: n2865 = n2055;
      14'b00000001000000: n2865 = n1911;
      14'b00000000100000: n2865 = n1796;
      14'b00000000010000: n2865 = 1'b0;
      14'b00000000001000: n2865 = 1'b0;
      14'b00000000000100: n2865 = 1'b0;
      14'b00000000000010: n2865 = n1666;
      14'b00000000000001: n2865 = n1561;
      default: n2865 = 1'b0;
    endcase
  /*# T65_MCode.vhd:234:5 */
  always @*
    case (n2802)
      14'b10000000000000: n2868 = n2790;
      14'b01000000000000: n2868 = n2597;
      14'b00100000000000: n2868 = n2477;
      14'b00010000000000: n2868 = n2328;
      14'b00001000000000: n2868 = 1'b0;
      14'b00000100000000: n2868 = n2182;
      14'b00000010000000: n2868 = 1'b0;
      14'b00000001000000: n2868 = n1913;
      14'b00000000100000: n2868 = 1'b0;
      14'b00000000010000: n2868 = 1'b0;
      14'b00000000001000: n2868 = 1'b0;
      14'b00000000000100: n2868 = 1'b0;
      14'b00000000000010: n2868 = n1669;
      14'b00000000000001: n2868 = 1'b0;
      default: n2868 = 1'b0;
    endcase
  /*# T65_MCode.vhd:1092:12 */
  assign n2873 = ir[1:0]; // extract
  /*# T65_MCode.vhd:1094:16 */
  assign n2874 = ir[4:2]; // extract
  /*# T65_MCode.vhd:1099:18 */
  assign n2875 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1100:13 */
  assign n2877 = n2875 == 3'b110;
  /*# T65_MCode.vhd:1100:24 */
  assign n2879 = n2875 == 3'b111;
  /*# T65_MCode.vhd:1100:24 */
  assign n2880 = n2877 | n2879;
  /*# T65_MCode.vhd:1102:13 */
  assign n2882 = n2875 == 3'b101;
  /*# T65_MCode.vhd:1104:13 */
  assign n2884 = n2875 == 3'b001;
  /*# T65_MCode.vhd:1099:11 */
  assign n2885 = {n2884, n2882, n2880};
  /*# T65_MCode.vhd:1099:11 */
  always @*
    case (n2885)
      3'b100: n2890 = 5'b01100;
      3'b010: n2890 = 5'b00101;
      3'b001: n2890 = 5'b00110;
      default: n2890 = 5'b00100;
    endcase
  /*# T65_MCode.vhd:1098:9 */
  assign n2892 = n2874 == 3'b000;
  /*# T65_MCode.vhd:1098:20 */
  assign n2894 = n2874 == 3'b001;
  /*# T65_MCode.vhd:1098:20 */
  assign n2895 = n2892 | n2894;
  /*# T65_MCode.vhd:1098:28 */
  assign n2897 = n2874 == 3'b011;
  /*# T65_MCode.vhd:1098:28 */
  assign n2898 = n2895 | n2897;
  /*# T65_MCode.vhd:1112:18 */
  assign n2899 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1113:13 */
  assign n2901 = n2899 == 3'b111;
  /*# T65_MCode.vhd:1113:24 */
  assign n2903 = n2899 == 3'b110;
  /*# T65_MCode.vhd:1113:24 */
  assign n2904 = n2901 | n2903;
  /*# T65_MCode.vhd:1115:13 */
  assign n2906 = n2899 == 3'b100;
  /*# T65_MCode.vhd:1112:11 */
  assign n2907 = {n2906, n2904};
  /*# T65_MCode.vhd:1112:11 */
  always @*
    case (n2907)
      2'b10: n2911 = 5'b01101;
      2'b01: n2911 = 5'b01110;
      default: n2911 = 5'b00101;
    endcase
  /*# T65_MCode.vhd:1111:9 */
  assign n2913 = n2874 == 3'b010;
  /*# T65_MCode.vhd:1123:18 */
  assign n2914 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1124:13 */
  assign n2916 = n2914 == 3'b100;
  /*# T65_MCode.vhd:1123:11 */
  always @*
    case (n2916)
      1'b1: n2919 = 5'b00101;
      default: n2919 = 5'b00100;
    endcase
  /*# T65_MCode.vhd:1122:9 */
  assign n2921 = n2874 == 3'b110;
  /*# T65_MCode.vhd:1134:18 */
  assign n2922 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1135:13 */
  assign n2924 = n2922 == 3'b101;
  /*# T65_MCode.vhd:1134:11 */
  always @*
    case (n2924)
      1'b1: n2927 = 5'b00101;
      default: n2927 = 5'b00100;
    endcase
  /*# T65_MCode.vhd:1094:9 */
  assign n2928 = {n2921, n2913, n2898};
  /*# T65_MCode.vhd:1094:9 */
  always @*
    case (n2928)
      3'b100: n2929 = n2919;
      3'b010: n2929 = n2911;
      3'b001: n2929 = n2890;
      default: n2929 = n2927;
    endcase
  /*# T65_MCode.vhd:1093:7 */
  assign n2931 = n2873 == 2'b00;
  /*# T65_MCode.vhd:1143:36 */
  assign n2932 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1143:14 */
  assign n2933 = {28'b0, n2932};  // uext
  /*# T65_MCode.vhd:1144:11 */
  assign n2935 = n2933 == 31'b0000000000000000000000000000000;
  /*# T65_MCode.vhd:1146:11 */
  assign n2937 = n2933 == 31'b0000000000000000000000000000001;
  /*# T65_MCode.vhd:1148:11 */
  assign n2939 = n2933 == 31'b0000000000000000000000000000010;
  /*# T65_MCode.vhd:1150:11 */
  assign n2941 = n2933 == 31'b0000000000000000000000000000011;
  /*# T65_MCode.vhd:1152:11 */
  assign n2943 = n2933 == 31'b0000000000000000000000000000100;
  /*# T65_MCode.vhd:1154:11 */
  assign n2945 = n2933 == 31'b0000000000000000000000000000101;
  /*# T65_MCode.vhd:1156:11 */
  assign n2947 = n2933 == 31'b0000000000000000000000000000110;
  /*# T65_MCode.vhd:1143:9 */
  assign n2948 = {n2947, n2945, n2943, n2941, n2939, n2937, n2935};
  /*# T65_MCode.vhd:1143:9 */
  always @*
    case (n2948)
      7'b1000000: n2957 = 5'b00110;
      7'b0100000: n2957 = 5'b00101;
      7'b0010000: n2957 = 5'b00100;
      7'b0001000: n2957 = 5'b00011;
      7'b0000100: n2957 = 5'b00010;
      7'b0000010: n2957 = 5'b00001;
      7'b0000001: n2957 = 5'b00000;
      default: n2957 = 5'b00111;
    endcase
  /*# T65_MCode.vhd:1142:7 */
  assign n2959 = n2873 == 2'b01;
  /*# T65_MCode.vhd:1163:36 */
  assign n2960 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1163:14 */
  assign n2961 = {28'b0, n2960};  // uext
  /*# T65_MCode.vhd:1166:18 */
  assign n2962 = ir[4:2]; // extract
  /*# T65_MCode.vhd:1166:31 */
  assign n2964 = n2962 == 3'b110;
  /*# T65_MCode.vhd:1166:47 */
  assign n2966 = mode != 2'b00;
  /*# T65_MCode.vhd:1166:39 */
  assign n2967 = n2966 & n2964;
  /*# T65_MCode.vhd:1166:13 */
  assign n2970 = n2967 ? 5'b01110 : 5'b01000;
  /*# T65_MCode.vhd:1164:11 */
  assign n2973 = n2961 == 31'b0000000000000000000000000000000;
  /*# T65_MCode.vhd:1171:18 */
  assign n2974 = ir[4:2]; // extract
  /*# T65_MCode.vhd:1171:31 */
  assign n2976 = n2974 == 3'b110;
  /*# T65_MCode.vhd:1171:47 */
  assign n2978 = mode != 2'b00;
  /*# T65_MCode.vhd:1171:39 */
  assign n2979 = n2978 & n2976;
  /*# T65_MCode.vhd:1171:13 */
  assign n2982 = n2979 ? 5'b01101 : 5'b01001;
  /*# T65_MCode.vhd:1169:11 */
  assign n2985 = n2961 == 31'b0000000000000000000000000000001;
  /*# T65_MCode.vhd:1174:11 */
  assign n2987 = n2961 == 31'b0000000000000000000000000000010;
  /*# T65_MCode.vhd:1176:11 */
  assign n2989 = n2961 == 31'b0000000000000000000000000000011;
  /*# T65_MCode.vhd:1180:18 */
  assign n2990 = ir[4:2]; // extract
  /*# T65_MCode.vhd:1180:31 */
  assign n2992 = n2990 == 3'b010;
  /*# T65_MCode.vhd:1180:13 */
  assign n2995 = n2992 ? 5'b00101 : 5'b00100;
  /*# T65_MCode.vhd:1178:11 */
  assign n2998 = n2961 == 31'b0000000000000000000000000000100;
  /*# T65_MCode.vhd:1185:11 */
  assign n3000 = n2961 == 31'b0000000000000000000000000000101;
  /*# T65_MCode.vhd:1187:11 */
  assign n3002 = n2961 == 31'b0000000000000000000000000000110;
  /*# T65_MCode.vhd:1163:9 */
  assign n3003 = {n3002, n3000, n2998, n2989, n2987, n2985, n2973};
  /*# T65_MCode.vhd:1163:9 */
  always @*
    case (n3003)
      7'b1000000: n3009 = 5'b01101;
      7'b0100000: n3009 = 5'b00101;
      7'b0010000: n3009 = n2995;
      7'b0001000: n3009 = 5'b01011;
      7'b0000100: n3009 = 5'b01010;
      7'b0000010: n3009 = n2982;
      7'b0000001: n3009 = n2970;
      default: n3009 = 5'b01110;
    endcase
  /*# T65_MCode.vhd:1162:7 */
  assign n3011 = n2873 == 2'b10;
  /*# T65_MCode.vhd:1194:36 */
  assign n3012 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1194:14 */
  assign n3013 = {28'b0, n3012};  // uext
  /*# T65_MCode.vhd:1197:18 */
  assign n3015 = ir == 8'b10111011;
  /*# T65_MCode.vhd:1197:13 */
  assign n3018 = n3015 ? 5'b00001 : 5'b00101;
  /*# T65_MCode.vhd:1196:11 */
  assign n3020 = n3013 == 31'b0000000000000000000000000000101;
  /*# T65_MCode.vhd:1211:18 */
  assign n3022 = ir == 8'b01101011;
  /*# T65_MCode.vhd:1213:21 */
  assign n3024 = ir == 8'b10001011;
  /*# T65_MCode.vhd:1215:21 */
  assign n3026 = ir == 8'b00001011;
  /*# T65_MCode.vhd:1215:33 */
  assign n3028 = ir == 8'b00101011;
  /*# T65_MCode.vhd:1215:28 */
  assign n3029 = n3026 | n3028;
  /*# T65_MCode.vhd:1217:21 */
  assign n3031 = ir == 8'b11101011;
  /*# T65_MCode.vhd:1220:42 */
  assign n3032 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1220:20 */
  assign n3033 = {28'b0, n3032};  // uext
  /*# T65_MCode.vhd:1221:17 */
  assign n3035 = n3033 == 31'b0000000000000000000000000000000;
  /*# T65_MCode.vhd:1223:17 */
  assign n3037 = n3033 == 31'b0000000000000000000000000000001;
  /*# T65_MCode.vhd:1225:17 */
  assign n3039 = n3033 == 31'b0000000000000000000000000000010;
  /*# T65_MCode.vhd:1227:17 */
  assign n3041 = n3033 == 31'b0000000000000000000000000000011;
  /*# T65_MCode.vhd:1229:17 */
  assign n3043 = n3033 == 31'b0000000000000000000000000000100;
  /*# T65_MCode.vhd:1231:17 */
  assign n3045 = n3033 == 31'b0000000000000000000000000000101;
  /*# T65_MCode.vhd:1233:17 */
  assign n3047 = n3033 == 31'b0000000000000000000000000000110;
  /*# T65_MCode.vhd:1220:15 */
  assign n3048 = {n3047, n3045, n3043, n3041, n3039, n3037, n3035};
  /*# T65_MCode.vhd:1220:15 */
  always @*
    case (n3048)
      7'b1000000: n3057 = 5'b00110;
      7'b0100000: n3057 = 5'b00101;
      7'b0010000: n3057 = 5'b00100;
      7'b0001000: n3057 = 5'b00011;
      7'b0000100: n3057 = 5'b00010;
      7'b0000010: n3057 = 5'b00001;
      7'b0000001: n3057 = 5'b00000;
      default: n3057 = 5'b00111;
    endcase
  /*# T65_MCode.vhd:1239:42 */
  assign n3058 = ir[7:5]; // extract
  /*# T65_MCode.vhd:1239:20 */
  assign n3059 = {28'b0, n3058};  // uext
  /*# T65_MCode.vhd:1240:17 */
  assign n3061 = n3059 == 31'b0000000000000000000000000000000;
  /*# T65_MCode.vhd:1242:17 */
  assign n3063 = n3059 == 31'b0000000000000000000000000000001;
  /*# T65_MCode.vhd:1244:17 */
  assign n3065 = n3059 == 31'b0000000000000000000000000000010;
  /*# T65_MCode.vhd:1246:17 */
  assign n3067 = n3059 == 31'b0000000000000000000000000000011;
  /*# T65_MCode.vhd:1248:17 */
  assign n3069 = n3059 == 31'b0000000000000000000000000000100;
  /*# T65_MCode.vhd:1250:17 */
  assign n3071 = n3059 == 31'b0000000000000000000000000000101;
  /*# T65_MCode.vhd:1254:24 */
  assign n3072 = ir[4:2]; // extract
  /*# T65_MCode.vhd:1254:36 */
  assign n3074 = n3072 == 3'b010;
  /*# T65_MCode.vhd:1254:19 */
  assign n3077 = n3074 ? 5'b10001 : 5'b01101;
  /*# T65_MCode.vhd:1252:17 */
  assign n3080 = n3059 == 31'b0000000000000000000000000000110;
  /*# T65_MCode.vhd:1239:15 */
  assign n3081 = {n3080, n3071, n3069, n3067, n3065, n3063, n3061};
  /*# T65_MCode.vhd:1239:15 */
  always @*
    case (n3081)
      7'b1000000: n3089 = n3077;
      7'b0100000: n3089 = 5'b00101;
      7'b0010000: n3089 = 5'b01100;
      7'b0001000: n3089 = 5'b01011;
      7'b0000100: n3089 = 5'b01010;
      7'b0000010: n3089 = 5'b01001;
      7'b0000001: n3089 = 5'b01000;
      default: n3089 = 5'b01110;
    endcase
  /*# T65_MCode.vhd:1219:13 */
  assign n3090 = alumore ? n3057 : n3089;
  /*# T65_MCode.vhd:1217:13 */
  assign n3092 = n3031 ? 5'b00111 : n3090;
  /*# T65_MCode.vhd:1215:13 */
  assign n3094 = n3029 ? 5'b10000 : n3092;
  /*# T65_MCode.vhd:1213:13 */
  assign n3096 = n3024 ? 5'b10010 : n3094;
  /*# T65_MCode.vhd:1211:13 */
  assign n3098 = n3022 ? 5'b01111 : n3096;
  /*# T65_MCode.vhd:1194:9 */
  always @*
    case (n3020)
      1'b1: n3099 = n3018;
      default: n3099 = n3098;
    endcase
  /*# T65_MCode.vhd:1092:5 */
  assign n3100 = {n3011, n2959, n2931};
  /*# T65_MCode.vhd:1092:5 */
  always @*
    case (n3100)
      3'b100: n3101 = n3009;
      3'b010: n3101 = n2957;
      3'b001: n3101 = n2929;
      default: n3101 = n3099;
    endcase
endmodule

module T65
  (input  [1:0] Mode,
   input  Res_n,
   input  Enable,
   input  Clk,
   input  Rdy,
   input  Abort_n,
   input  IRQ_n,
   input  NMI_n,
   input  SO_n,
   output R_W_n,
   output Sync,
   output EF,
   output MF,
   output XF,
   output ML_n,
   output VP_n,
   output VDA,
   output VPA,
   output [23:0] A,
   input  [7:0] DI,
   output [7:0] DO,
   output [63:0] Regs,
   output [7:0] \DEBUG[I] ,
   output [7:0] \DEBUG[A] ,
   output [7:0] \DEBUG[X] ,
   output [7:0] \DEBUG[Y] ,
   output [7:0] \DEBUG[S] ,
   output [7:0] \DEBUG[P] ,
   output NMI_ack);
  wire [7:0] n13;
  wire [7:0] n14;
  wire [7:0] n15;
  wire [7:0] n16;
  wire [7:0] n17;
  wire [7:0] n18;
  wire [15:0] abc;
  wire [15:0] x;
  wire [15:0] y;
  reg [7:0] p;
  reg [7:0] ad;
  reg [7:0] dl;
  wire [7:0] pwithb;
  wire [7:0] bah;
  wire [8:0] bal;
  wire [7:0] pbr;
  wire [7:0] dbr;
  wire [15:0] pc;
  wire [15:0] s;
  wire ef_i;
  wire mf_i;
  wire xf_i;
  wire [7:0] ir;
  wire [2:0] mcycle;
  wire [7:0] do_r;
  wire [1:0] mode_r;
  wire [4:0] alu_op_r;
  wire [3:0] write_data_r;
  wire [1:0] set_addr_to_r;
  wire [8:0] pcadder;
  wire rstcycle;
  wire irqcycle;
  wire nmicycle;
  wire so_n_o;
  wire irq_n_o;
  wire nmi_n_o;
  wire nmiact;
  wire brk_n;
  wire [7:0] busa;
  wire [7:0] busa_r;
  wire [7:0] busb;
  wire [7:0] busb_r;
  wire [7:0] alu_q;
  wire [7:0] p_out;
  wire [2:0] lcycle;
  wire [4:0] alu_op;
  wire [3:0] set_busa_to;
  wire [1:0] set_addr_to;
  wire [3:0] write_data;
  wire [1:0] jump;
  wire [1:0] baadd;
  wire [1:0] baquirk;
  wire breakatna;
  wire adadd;
  wire addy;
  wire pcadd;
  wire inc_s;
  wire dec_s;
  wire lda;
  wire ldp;
  wire ldx;
  wire ldy;
  wire lds;
  wire lddi;
  wire ldalu;
  wire ldad;
  wire ldbal;
  wire ldbah;
  wire savep;
  wire write;
  wire res_n_i;
  wire res_n_d;
  wire rdy_mod;
  wire really_rdy;
  wire wrn_i;
  wire nmi_entered;
  wire n23;
  wire n24;
  wire n27;
  wire n28;
  wire [1:0] n31;
  wire n33;
  wire [1:0] n34;
  wire n36;
  wire n37;
  wire [1:0] n38;
  wire n40;
  wire n41;
  wire n42;
  wire n46;
  wire n48;
  wire n49;
  wire n50;
  wire n51;
  wire n55;
  wire n56;
  wire n59;
  wire n60;
  wire n61;
  wire [7:0] n63;
  wire [7:0] n64;
  wire [7:0] n65;
  wire [7:0] n66;
  wire [31:0] n67;
  wire [39:0] n68;
  wire [7:0] n69;
  wire [47:0] n70;
  wire [7:0] n71;
  wire [55:0] n72;
  wire [7:0] n73;
  wire [63:0] n74;
  wire n105;
  wire n117;
  wire n120;
  wire n122;
  wire n124;
  wire n125;
  wire n127;
  wire n129;
  wire n130;
  wire n131;
  wire n132;
  wire n133;
  wire n135;
  wire n137;
  wire n138;
  wire n139;
  wire n141;
  wire n142;
  wire n143;
  wire n144;
  wire [15:0] n146;
  wire [15:0] n147;
  wire n148;
  wire [7:0] n150;
  wire [7:0] n151;
  wire [7:0] n152;
  wire n153;
  wire n155;
  wire [1:0] n159;
  wire [15:0] n161;
  wire [7:0] n162;
  wire [15:0] n163;
  wire [15:0] n164;
  wire n165;
  wire n166;
  wire [15:0] n168;
  wire [15:0] n169;
  wire n171;
  wire n173;
  wire n174;
  wire n175;
  wire n176;
  wire n177;
  wire n178;
  wire [15:0] n180;
  wire [15:0] n181;
  wire [15:0] n183;
  wire n185;
  wire [15:0] n186;
  wire n188;
  wire n189;
  wire n190;
  wire n191;
  wire [7:0] n192;
  wire [7:0] n194;
  wire [7:0] n195;
  wire [7:0] n197;
  wire [7:0] n198;
  wire [7:0] n199;
  wire [7:0] n200;
  wire [7:0] n201;
  wire n203;
  wire [2:0] n204;
  wire [7:0] n205;
  wire [7:0] n206;
  wire [7:0] n207;
  reg [7:0] n208;
  wire [7:0] n209;
  wire [7:0] n210;
  wire [7:0] n211;
  reg [7:0] n212;
  wire [15:0] n218;
  wire n227;
  wire n228;
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
  wire n246;
  wire [7:0] n289;
  wire [8:0] n290;
  wire n291;
  wire [8:0] n292;
  wire [8:0] n293;
  wire [8:0] n294;
  wire [7:0] n295;
  wire [8:0] n297;
  wire n301;
  wire n304;
  wire n311;
  wire n312;
  wire [7:0] n313;
  wire n315;
  wire n317;
  wire n319;
  wire n320;
  wire [7:0] n321;
  wire [7:0] n322;
  wire [4:0] n323;
  wire n325;
  wire [2:0] n326;
  wire n329;
  wire n332;
  wire n335;
  wire n338;
  wire n341;
  wire n344;
  wire n347;
  wire [6:0] n348;
  wire n349;
  reg n350;
  wire n351;
  reg n352;
  wire n353;
  reg n354;
  wire n355;
  reg n356;
  wire [1:0] n357;
  wire n358;
  wire n359;
  wire [1:0] n360;
  wire [1:0] n361;
  wire n362;
  wire n363;
  wire n366;
  wire n367;
  wire n372;
  wire n374;
  wire n375;
  wire n376;
  wire n377;
  wire n379;
  wire n380;
  wire n381;
  wire [1:0] n384;
  wire [1:0] n385;
  wire [1:0] n386;
  wire [7:0] n388;
  wire n390;
  wire n392;
  wire n394;
  wire [7:0] n395;
  wire [4:0] n398;
  wire n400;
  wire n402;
  wire n403;
  wire n404;
  wire n405;
  wire [4:0] n407;
  wire n409;
  wire n411;
  wire n412;
  wire n415;
  wire n417;
  wire n419;
  wire n420;
  wire n421;
  wire n422;
  wire n424;
  wire n425;
  wire n427;
  wire n428;
  wire n429;
  wire [5:0] n430;
  wire [7:0] n437;
  wire n458;
  wire n461;
  wire n463;
  wire n464;
  wire [7:0] n466;
  wire [7:0] n469;
  wire [8:0] n471;
  wire n473;
  wire [7:0] n474;
  wire [8:0] n475;
  wire [8:0] n476;
  wire [8:0] n477;
  wire n479;
  wire n480;
  wire [7:0] n482;
  wire n484;
  wire [7:0] n486;
  wire [7:0] n487;
  wire n489;
  wire n491;
  wire [2:0] n492;
  reg [7:0] n493;
  wire [7:0] n494;
  wire n496;
  wire [2:0] n497;
  reg [7:0] n498;
  reg [7:0] n499;
  reg [8:0] n500;
  wire [7:0] n501;
  wire [7:0] n502;
  wire [7:0] n503;
  wire [7:0] n504;
  wire [7:0] n505;
  wire [7:0] n506;
  wire n508;
  wire n511;
  wire n512;
  wire n513;
  wire n514;
  wire n517;
  wire n520;
  wire [2:0] n522;
  wire n524;
  wire [2:0] n525;
  localparam [8:0] n526 = 9'b111111111;
  wire [5:0] n527;
  wire n529;
  wire n531;
  wire n533;
  wire n534;
  wire [1:0] n535;
  wire [7:0] n537;
  wire [8:0] n538;
  wire [8:0] n539;
  wire n541;
  wire [7:0] n543;
  wire [7:0] n544;
  wire [7:0] n545;
  wire [7:0] n546;
  wire [7:0] n547;
  wire n548;
  wire [7:0] n549;
  wire [8:0] n553;
  wire n557;
  wire n559;
  wire n560;
  wire n561;
  wire n562;
  wire n563;
  wire n564;
  wire n565;
  wire n566;
  wire n591;
  wire n592;
  wire n593;
  wire n594;
  wire n595;
  wire n596;
  wire n597;
  wire n599;
  wire [7:0] n600;
  wire n602;
  wire [7:0] n603;
  wire n605;
  wire [7:0] n606;
  wire n608;
  wire [7:0] n609;
  wire n611;
  wire n613;
  wire [7:0] n614;
  wire [7:0] n615;
  wire n617;
  wire [7:0] n618;
  wire [7:0] n620;
  wire [7:0] n621;
  wire n623;
  wire [7:0] n624;
  wire [7:0] n626;
  wire [7:0] n627;
  wire [7:0] n628;
  wire [7:0] n629;
  wire n631;
  wire [7:0] n632;
  wire [7:0] n633;
  wire [7:0] n634;
  wire n636;
  wire n639;
  wire [10:0] n640;
  reg [7:0] n642;
  wire [7:0] n643;
  wire [23:0] n645;
  wire n647;
  wire [15:0] n649;
  wire [23:0] n650;
  wire n652;
  wire [15:0] n654;
  wire [7:0] n655;
  wire [23:0] n656;
  wire n658;
  wire [7:0] n659;
  wire [15:0] n660;
  wire [7:0] n661;
  wire [23:0] n662;
  wire n664;
  wire [3:0] n665;
  reg [23:0] n667;
  wire [7:0] n669;
  wire n670;
  wire [7:0] n671;
  wire n673;
  wire [7:0] n674;
  wire n676;
  wire [7:0] n677;
  wire n679;
  wire [7:0] n680;
  wire n682;
  wire [7:0] n683;
  wire n685;
  wire n687;
  wire [7:0] n688;
  wire n690;
  wire [7:0] n691;
  wire n693;
  wire [7:0] n694;
  wire [7:0] n695;
  wire [7:0] n696;
  wire n698;
  wire [7:0] n699;
  wire [7:0] n700;
  wire [7:0] n701;
  wire [7:0] n702;
  wire n704;
  wire [7:0] n705;
  wire [7:0] n706;
  wire n708;
  wire [7:0] n709;
  wire [7:0] n710;
  wire n712;
  wire n715;
  wire [12:0] n716;
  reg [7:0] n718;
  wire n721;
  wire n723;
  wire n724;
  wire n726;
  wire n727;
  wire n728;
  wire n729;
  wire n730;
  wire n731;
  wire n734;
  wire n736;
  wire n740;
  wire n743;
  wire [2:0] n745;
  wire [2:0] n747;
  wire n752;
  wire n754;
  wire n755;
  wire n756;
  wire n757;
  wire n758;
  wire [4:0] n759;
  wire n761;
  wire n763;
  wire n764;
  wire n765;
  wire n766;
  wire n768;
  wire n770;
  wire n771;
  wire n772;
  wire n773;
  wire n774;
  wire [15:0] n793;
  wire [15:0] n795;
  wire [15:0] n797;
  wire [47:0] n798;
  wire n799;
  wire n800;
  wire [7:0] n801;
  wire [7:0] n802;
  reg [7:0] n803;
  wire n804;
  wire n805;
  wire [7:0] n806;
  wire [7:0] n807;
  reg [7:0] n808;
  wire n809;
  wire n810;
  wire [7:0] n811;
  wire [7:0] n812;
  reg [7:0] n813;
  reg [7:0] n814;
  wire [7:0] n815;
  reg [7:0] n816;
  wire [7:0] n817;
  reg [7:0] n818;
  wire [7:0] n819;
  reg [7:0] n820;
  wire [8:0] n821;
  reg [8:0] n822;
  wire [7:0] n823;
  reg [7:0] n824;
  wire [7:0] n825;
  reg [7:0] n826;
  wire [15:0] n827;
  reg [15:0] n828;
  wire [15:0] n829;
  reg [15:0] n830;
  wire n831;
  reg n832;
  wire n833;
  reg n834;
  wire n835;
  reg n836;
  wire [7:0] n837;
  reg [7:0] n838;
  wire [2:0] n839;
  reg [2:0] n840;
  wire [1:0] n841;
  reg [1:0] n842;
  wire [4:0] n843;
  reg [4:0] n844;
  wire [3:0] n845;
  reg [3:0] n846;
  wire [1:0] n847;
  reg [1:0] n848;
  wire n849;
  reg n850;
  wire n851;
  reg n852;
  wire n853;
  reg n854;
  wire n855;
  wire n856;
  reg n857;
  wire n858;
  wire n859;
  wire n860;
  reg n861;
  wire n862;
  wire n863;
  wire n864;
  reg n865;
  wire n866;
  reg n867;
  wire [7:0] n868;
  reg [7:0] n869;
  wire [7:0] n870;
  reg [7:0] n871;
  wire [7:0] n872;
  reg [7:0] n873;
  reg n874;
  reg n875;
  wire n876;
  wire n877;
  wire n878;
  reg n879;
  wire n880;
  reg n881;
  wire n882;
  wire n883;
  wire n884;
  reg n885;
  assign R_W_n = wrn_i; //(module output)
  assign Sync = n28; //(module output)
  assign EF = ef_i; //(module output)
  assign MF = mf_i; //(module output)
  assign XF = xf_i; //(module output)
  assign ML_n = n42; //(module output)
  assign VP_n = n51; //(module output)
  assign VDA = n56; //(module output)
  assign VPA = n61; //(module output)
  assign A = n667; //(module output)
  assign DO = do_r; //(module output)
  assign Regs = n74; //(module output)
  assign \DEBUG[I]  = n13; //(module output)
  assign \DEBUG[A]  = n14; //(module output)
  assign \DEBUG[X]  = n15; //(module output)
  assign \DEBUG[Y]  = n16; //(module output)
  assign \DEBUG[S]  = n17; //(module output)
  assign \DEBUG[P]  = n18; //(module output)
  assign NMI_ack = nmiact; //(module output)
  /*# T65.vhd:134:8 */
  assign n13 = n798[7:0]; // extract
  /*# T65.vhd:134:8 */
  assign n14 = n798[15:8]; // extract
  /*# T65.vhd:134:8 */
  assign n15 = n798[23:16]; // extract
  /*# T65.vhd:134:8 */
  assign n16 = n798[31:24]; // extract
  /*# T65.vhd:134:8 */
  assign n17 = n798[39:32]; // extract
  /*# T65.vhd:134:8 */
  assign n18 = n798[47:40]; // extract
  /*# T65.vhd:167:10 */
  assign abc = n793; // (signal)
  /*# T65.vhd:167:15 */
  assign x = n795; // (signal)
  /*# T65.vhd:167:18 */
  assign y = n797; // (signal)
  /*# T65.vhd:168:10 */
  always @*
    p = n814; // (isignal)
  initial
    p = 8'b00000000;
  /*# T65.vhd:168:13 */
  always @*
    ad = n816; // (isignal)
  initial
    ad = 8'b00000000;
  /*# T65.vhd:168:17 */
  always @*
    dl = n818; // (isignal)
  initial
    dl = 8'b00000000;
  /*# T65.vhd:169:10 */
  assign pwithb = n671; // (signal)
  /*# T65.vhd:170:10 */
  assign bah = n820; // (signal)
  /*# T65.vhd:171:10 */
  assign bal = n822; // (signal)
  /*# T65.vhd:172:10 */
  assign pbr = n824; // (signal)
  /*# T65.vhd:173:10 */
  assign dbr = n826; // (signal)
  /*# T65.vhd:174:10 */
  assign pc = n828; // (signal)
  /*# T65.vhd:175:10 */
  assign s = n830; // (signal)
  /*# T65.vhd:176:10 */
  assign ef_i = n832; // (signal)
  /*# T65.vhd:177:10 */
  assign mf_i = n834; // (signal)
  /*# T65.vhd:178:10 */
  assign xf_i = n836; // (signal)
  /*# T65.vhd:180:10 */
  assign ir = n838; // (signal)
  /*# T65.vhd:181:10 */
  assign mcycle = n840; // (signal)
  /*# T65.vhd:183:10 */
  assign do_r = n718; // (signal)
  /*# T65.vhd:185:10 */
  assign mode_r = n842; // (signal)
  /*# T65.vhd:186:10 */
  assign alu_op_r = n844; // (signal)
  /*# T65.vhd:187:10 */
  assign write_data_r = n846; // (signal)
  /*# T65.vhd:188:10 */
  assign set_addr_to_r = n848; // (signal)
  /*# T65.vhd:189:10 */
  assign pcadder = n294; // (signal)
  /*# T65.vhd:191:10 */
  assign rstcycle = n850; // (signal)
  /*# T65.vhd:192:10 */
  assign irqcycle = n852; // (signal)
  /*# T65.vhd:193:10 */
  assign nmicycle = n854; // (signal)
  /*# T65.vhd:195:10 */
  assign so_n_o = n857; // (signal)
  /*# T65.vhd:196:10 */
  assign irq_n_o = n861; // (signal)
  /*# T65.vhd:197:10 */
  assign nmi_n_o = n865; // (signal)
  /*# T65.vhd:198:10 */
  assign nmiact = n867; // (signal)
  /*# T65.vhd:200:10 */
  assign brk_n = n597; // (signal)
  /*# T65.vhd:203:10 */
  assign busa = n642; // (signal)
  /*# T65.vhd:204:10 */
  assign busa_r = n869; // (signal)
  /*# T65.vhd:205:10 */
  assign busb = n871; // (signal)
  /*# T65.vhd:206:10 */
  assign busb_r = n873; // (signal)
  /*# T65.vhd:238:10 */
  assign res_n_i = n874; // (signal)
  /*# T65.vhd:239:10 */
  assign res_n_d = n875; // (signal)
  /*# T65.vhd:241:10 */
  assign rdy_mod = n879; // (signal)
  /*# T65.vhd:242:10 */
  assign really_rdy = n24; // (signal)
  /*# T65.vhd:243:10 */
  assign wrn_i = n881; // (signal)
  /*# T65.vhd:245:10 */
  assign nmi_entered = n885; // (signal)
  /*# T65.vhd:251:24 */
  assign n23 = ~wrn_i;
  /*# T65.vhd:251:21 */
  assign n24 = Rdy | n23;
  /*# T65.vhd:252:27 */
  assign n27 = mcycle == 3'b000;
  /*# T65.vhd:252:15 */
  assign n28 = n27 ? 1'b1 : 1'b0;
  /*# T65.vhd:257:22 */
  assign n31 = ir[7:6]; // extract
  /*# T65.vhd:257:35 */
  assign n33 = n31 != 2'b10;
  /*# T65.vhd:257:49 */
  assign n34 = ir[2:1]; // extract
  /*# T65.vhd:257:62 */
  assign n36 = n34 == 2'b11;
  /*# T65.vhd:257:43 */
  assign n37 = n36 & n33;
  /*# T65.vhd:257:79 */
  assign n38 = mcycle[2:1]; // extract
  /*# T65.vhd:257:92 */
  assign n40 = n38 != 2'b00;
  /*# T65.vhd:257:69 */
  assign n41 = n40 & n37;
  /*# T65.vhd:257:15 */
  assign n42 = n41 ? 1'b0 : 1'b1;
  /*# T65.vhd:258:47 */
  assign n46 = mcycle == 3'b101;
  /*# T65.vhd:258:65 */
  assign n48 = mcycle == 3'b110;
  /*# T65.vhd:258:55 */
  assign n49 = n46 | n48;
  /*# T65.vhd:258:35 */
  assign n50 = n49 & irqcycle;
  /*# T65.vhd:258:15 */
  assign n51 = n50 ? 1'b0 : 1'b1;
  /*# T65.vhd:259:33 */
  assign n55 = set_addr_to_r != 2'b00;
  /*# T65.vhd:259:14 */
  assign n56 = n55 ? 1'b1 : 1'b0;
  /*# T65.vhd:260:23 */
  assign n59 = jump[1]; // extract
  /*# T65.vhd:260:27 */
  assign n60 = ~n59;
  /*# T65.vhd:260:14 */
  assign n61 = n60 ? 1'b1 : 1'b0;
  /*# T65.vhd:264:17 */
  assign n63 = abc[7:0]; // extract
  /*# T65.vhd:265:15 */
  assign n64 = x[7:0]; // extract
  /*# T65.vhd:266:15 */
  assign n65 = y[7:0]; // extract
  /*# T65.vhd:267:32 */
  assign n66 = s[7:0]; // extract
  /*# T65.vhd:270:32 */
  assign n67 = {pc, s};
  /*# T65.vhd:270:53 */
  assign n68 = {n67, p};
  /*# T65.vhd:270:60 */
  assign n69 = y[7:0]; // extract
  /*# T65.vhd:270:57 */
  assign n70 = {n68, n69};
  /*# T65.vhd:270:76 */
  assign n71 = x[7:0]; // extract
  /*# T65.vhd:270:73 */
  assign n72 = {n70, n71};
  /*# T65.vhd:270:94 */
  assign n73 = abc[7:0]; // extract
  /*# T65.vhd:270:89 */
  assign n74 = {n72, n73};
  /*# T65.vhd:272:3 */
  t65_mcode_Brtl mcode (
    .mode(mode_r),
    .ir(ir),
    .mcycle(mcycle),
    .p(p),
    .rdy_mod(rdy_mod),
    .lcycle(lcycle),
    .alu_op(alu_op),
    .set_busa_to(set_busa_to),
    .set_addr_to(set_addr_to),
    .write_data(write_data),
    .jump(jump),
    .baadd(baadd),
    .baquirk(baquirk),
    .breakatna(breakatna),
    .adadd(adadd),
    .addy(addy),
    .pcadd(pcadd),
    .inc_s(inc_s),
    .dec_s(dec_s),
    .lda(lda),
    .ldp(ldp),
    .ldx(ldx),
    .ldy(ldy),
    .lds(lds),
    .lddi(lddi),
    .ldalu(ldalu),
    .ldad(ldad),
    .ldbal(ldbal),
    .ldbah(ldbah),
    .savep(savep),
    .write(write));
  /*# T65.vhd:309:3 */
  t65_alu_Brtl alu (
    .mode(mode_r),
    .op(alu_op_r),
    .busa(busa_r),
    .busb(busb),
    .p_in(p),
    .p_out(p_out),
    .q(alu_q));
  /*# T65.vhd:324:14 */
  assign n105 = ~Res_n;
  /*# T65.vhd:335:16 */
  assign n117 = ~res_n_i;
  /*# T65.vhd:355:20 */
  assign n120 = mcycle == 3'b000;
  /*# T65.vhd:357:24 */
  assign n122 = mcycle == 3'b011;
  /*# T65.vhd:357:39 */
  assign n124 = ir != 8'b10010011;
  /*# T65.vhd:357:32 */
  assign n125 = n124 & n122;
  /*# T65.vhd:357:60 */
  assign n127 = mcycle == 3'b100;
  /*# T65.vhd:357:75 */
  assign n129 = ir == 8'b10010011;
  /*# T65.vhd:357:68 */
  assign n130 = n129 & n127;
  /*# T65.vhd:357:49 */
  assign n131 = n125 | n130;
  /*# T65.vhd:357:93 */
  assign n132 = ~Rdy;
  /*# T65.vhd:357:85 */
  assign n133 = n132 & n131;
  /*# T65.vhd:357:9 */
  assign n135 = n133 ? 1'b1 : rdy_mod;
  /*# T65.vhd:355:9 */
  assign n137 = n120 ? 1'b0 : n135;
  /*# T65.vhd:362:20 */
  assign n138 = ~write;
  /*# T65.vhd:362:30 */
  assign n139 = n138 | rstcycle;
  /*# T65.vhd:370:22 */
  assign n141 = mcycle == 3'b000;
  /*# T65.vhd:373:25 */
  assign n142 = ~irqcycle;
  /*# T65.vhd:373:44 */
  assign n143 = ~nmicycle;
  /*# T65.vhd:373:31 */
  assign n144 = n143 & n142;
  /*# T65.vhd:374:24 */
  assign n146 = pc + 16'b0000000000000001;
  /*# T65.vhd:370:11 */
  assign n147 = n153 ? n146 : pc;
  /*# T65.vhd:377:31 */
  assign n148 = irqcycle | nmicycle;
  /*# T65.vhd:377:13 */
  assign n150 = n148 ? 8'b00000000 : DI;
  /*# T65.vhd:175:10 */
  assign n151 = s[7:0]; // extract
  /*# T65.vhd:370:11 */
  assign n152 = n155 ? alu_q : n151;
  /*# T65.vhd:370:11 */
  assign n153 = n144 & n141;
  /*# T65.vhd:370:11 */
  assign n155 = lds & n141;
  /*# T65.vhd:390:11 */
  assign n159 = brk_n ? 2'b00 : set_addr_to;
  /*# T65.vhd:397:20 */
  assign n161 = s + 16'b0000000000000001;
  /*# T65.vhd:175:10 */
  assign n162 = s[15:8]; // extract
  /*# T65.vhd:175:10 */
  assign n163 = {n162, n152};
  /*# T65.vhd:396:11 */
  assign n164 = inc_s ? n161 : n163;
  /*# T65.vhd:399:39 */
  assign n165 = ~rstcycle;
  /*# T65.vhd:399:26 */
  assign n166 = n165 & dec_s;
  /*# T65.vhd:400:20 */
  assign n168 = s - 16'b0000000000000001;
  /*# T65.vhd:399:11 */
  assign n169 = n166 ? n168 : n164;
  /*# T65.vhd:403:17 */
  assign n171 = ir == 8'b00000000;
  /*# T65.vhd:403:41 */
  assign n173 = mcycle == 3'b001;
  /*# T65.vhd:403:30 */
  assign n174 = n173 & n171;
  /*# T65.vhd:403:62 */
  assign n175 = ~irqcycle;
  /*# T65.vhd:403:49 */
  assign n176 = n175 & n174;
  /*# T65.vhd:403:81 */
  assign n177 = ~nmicycle;
  /*# T65.vhd:403:68 */
  assign n178 = n177 & n176;
  /*# T65.vhd:404:22 */
  assign n180 = pc + 16'b0000000000000001;
  /*# T65.vhd:403:11 */
  assign n181 = n178 ? n180 : n147;
  /*# T65.vhd:411:24 */
  assign n183 = pc + 16'b0000000000000001;
  /*# T65.vhd:410:13 */
  assign n185 = jump == 2'b01;
  /*# T65.vhd:413:33 */
  assign n186 = {DI, dl};
  /*# T65.vhd:412:13 */
  assign n188 = jump == 2'b10;
  /*# T65.vhd:415:25 */
  assign n189 = pcadder[8]; // extract
  /*# T65.vhd:416:22 */
  assign n190 = dl[7]; // extract
  /*# T65.vhd:416:26 */
  assign n191 = ~n190;
  /*# T65.vhd:417:40 */
  assign n192 = pc[15:8]; // extract
  /*# T65.vhd:417:54 */
  assign n194 = n192 + 8'b00000001;
  /*# T65.vhd:419:40 */
  assign n195 = pc[15:8]; // extract
  /*# T65.vhd:419:54 */
  assign n197 = n195 - 8'b00000001;
  /*# T65.vhd:416:17 */
  assign n198 = n191 ? n194 : n197;
  /*# T65.vhd:174:10 */
  assign n199 = n181[15:8]; // extract
  /*# T65.vhd:415:15 */
  assign n200 = n189 ? n198 : n199;
  /*# T65.vhd:422:40 */
  assign n201 = pcadder[7:0]; // extract
  /*# T65.vhd:414:13 */
  assign n203 = jump == 2'b11;
  /*# T65.vhd:409:11 */
  assign n204 = {n203, n188, n185};
  /*# T65.vhd:411:24 */
  assign n205 = n183[7:0]; // extract
  /*# T65.vhd:413:33 */
  assign n206 = n186[7:0]; // extract
  /*# T65.vhd:174:10 */
  assign n207 = n181[7:0]; // extract
  /*# T65.vhd:409:11 */
  always @*
    case (n204)
      3'b100: n208 = n201;
      3'b010: n208 = n206;
      3'b001: n208 = n205;
      default: n208 = n207;
    endcase
  /*# T65.vhd:411:24 */
  assign n209 = n183[15:8]; // extract
  /*# T65.vhd:413:33 */
  assign n210 = n186[15:8]; // extract
  /*# T65.vhd:174:10 */
  assign n211 = n181[15:8]; // extract
  /*# T65.vhd:409:11 */
  always @*
    case (n204)
      3'b100: n212 = n200;
      3'b010: n212 = n210;
      3'b001: n212 = n209;
      default: n212 = n211;
    endcase
  /*# T65.vhd:361:9 */
  assign n218 = {n212, n208};
  /*# T65.vhd:361:9 */
  assign n227 = n141 & really_rdy;
  /*# T65.vhd:361:9 */
  assign n228 = n141 & really_rdy;
  /*# T65.vhd:353:7 */
  assign n233 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n234 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n235 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n236 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n237 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n238 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n239 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n240 = n227 & Enable;
  /*# T65.vhd:353:7 */
  assign n241 = n228 & Enable;
  /*# T65.vhd:353:7 */
  assign n242 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n243 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n244 = really_rdy & Enable;
  /*# T65.vhd:353:7 */
  assign n246 = really_rdy & Enable;
  /*# T65.vhd:430:23 */
  assign n289 = pc[7:0]; // extract
  /*# T65.vhd:430:14 */
  assign n290 = {1'b0, n289};  // uext
  /*# T65.vhd:430:59 */
  assign n291 = dl[7]; // extract
  /*# T65.vhd:430:63 */
  assign n292 = {n291, dl};
  /*# T65.vhd:430:39 */
  assign n293 = n290 + n292;
  /*# T65.vhd:430:72 */
  assign n294 = pcadd ? n293 : n297;
  /*# T65.vhd:431:23 */
  assign n295 = pc[7:0]; // extract
  /*# T65.vhd:431:19 */
  assign n297 = {1'b0, n295};
  /*# T65.vhd:436:16 */
  assign n301 = ~res_n_i;
  /*# T65.vhd:442:21 */
  assign n304 = mcycle == 3'b000;
  /*# T65.vhd:452:21 */
  assign n311 = lda | ldx;
  /*# T65.vhd:452:28 */
  assign n312 = n311 | ldy;
  /*# T65.vhd:442:11 */
  assign n313 = n320 ? p_out : p;
  /*# T65.vhd:442:11 */
  assign n315 = lda & n304;
  /*# T65.vhd:442:11 */
  assign n317 = ldx & n304;
  /*# T65.vhd:442:11 */
  assign n319 = ldy & n304;
  /*# T65.vhd:442:11 */
  assign n320 = n312 & n304;
  /*# T65.vhd:456:11 */
  assign n321 = savep ? p_out : n313;
  /*# T65.vhd:459:11 */
  assign n322 = ldp ? alu_q : n321;
  /*# T65.vhd:462:16 */
  assign n323 = ir[4:0]; // extract
  /*# T65.vhd:462:29 */
  assign n325 = n323 == 5'b11000;
  /*# T65.vhd:463:20 */
  assign n326 = ir[7:5]; // extract
  /*# T65.vhd:464:13 */
  assign n329 = n326 == 3'b000;
  /*# T65.vhd:466:13 */
  assign n332 = n326 == 3'b001;
  /*# T65.vhd:468:13 */
  assign n335 = n326 == 3'b010;
  /*# T65.vhd:470:13 */
  assign n338 = n326 == 3'b011;
  /*# T65.vhd:472:13 */
  assign n341 = n326 == 3'b101;
  /*# T65.vhd:474:13 */
  assign n344 = n326 == 3'b110;
  /*# T65.vhd:476:13 */
  assign n347 = n326 == 3'b111;
  /*# T65.vhd:463:13 */
  assign n348 = {n347, n344, n341, n338, n335, n332, n329};
  /*# T65.vhd:434:14 */
  assign n349 = n322[0]; // extract
  /*# T65.vhd:463:13 */
  always @*
    case (n348)
      7'b1000000: n350 = n349;
      7'b0100000: n350 = n349;
      7'b0010000: n350 = n349;
      7'b0001000: n350 = n349;
      7'b0000100: n350 = n349;
      7'b0000010: n350 = 1'b1;
      7'b0000001: n350 = 1'b0;
      default: n350 = n349;
    endcase
  /*# T65.vhd:434:14 */
  assign n351 = n322[2]; // extract
  /*# T65.vhd:463:13 */
  always @*
    case (n348)
      7'b1000000: n352 = n351;
      7'b0100000: n352 = n351;
      7'b0010000: n352 = n351;
      7'b0001000: n352 = 1'b1;
      7'b0000100: n352 = 1'b0;
      7'b0000010: n352 = n351;
      7'b0000001: n352 = n351;
      default: n352 = n351;
    endcase
  /*# T65.vhd:434:14 */
  assign n353 = n322[3]; // extract
  /*# T65.vhd:463:13 */
  always @*
    case (n348)
      7'b1000000: n354 = 1'b1;
      7'b0100000: n354 = 1'b0;
      7'b0010000: n354 = n353;
      7'b0001000: n354 = n353;
      7'b0000100: n354 = n353;
      7'b0000010: n354 = n353;
      7'b0000001: n354 = n353;
      default: n354 = n353;
    endcase
  /*# T65.vhd:434:14 */
  assign n355 = n322[6]; // extract
  /*# T65.vhd:463:13 */
  always @*
    case (n348)
      7'b1000000: n356 = n355;
      7'b0100000: n356 = n355;
      7'b0010000: n356 = 1'b0;
      7'b0001000: n356 = n355;
      7'b0000100: n356 = n355;
      7'b0000010: n356 = n355;
      7'b0000001: n356 = n355;
      default: n356 = n355;
    endcase
  /*# T65.vhd:462:11 */
  assign n357 = {n354, n352};
  /*# T65.vhd:434:14 */
  assign n358 = n322[0]; // extract
  /*# T65.vhd:462:11 */
  assign n359 = n325 ? n350 : n358;
  /*# T65.vhd:434:14 */
  assign n360 = n322[3:2]; // extract
  /*# T65.vhd:462:11 */
  assign n361 = n325 ? n357 : n360;
  /*# T65.vhd:434:14 */
  assign n362 = n322[6]; // extract
  /*# T65.vhd:462:11 */
  assign n363 = n325 ? n356 : n362;
  /*# T65.vhd:434:14 */
  assign n366 = n322[1]; // extract
  /*# T65.vhd:434:14 */
  assign n367 = n322[7]; // extract
  /*# T65.vhd:482:17 */
  assign n372 = ir == 8'b00000000;
  /*# T65.vhd:482:41 */
  assign n374 = mcycle == 3'b100;
  /*# T65.vhd:482:30 */
  assign n375 = n374 & n372;
  /*# T65.vhd:482:62 */
  assign n376 = ~rstcycle;
  /*# T65.vhd:482:49 */
  assign n377 = n376 & n375;
  /*# T65.vhd:434:14 */
  assign n379 = n361[0]; // extract
  /*# T65.vhd:482:11 */
  assign n380 = n377 ? 1'b1 : n379;
  /*# T65.vhd:434:14 */
  assign n381 = n361[1]; // extract
  /*# T65.vhd:486:11 */
  assign n384 = {1'b0, 1'b1};
  /*# T65.vhd:434:14 */
  assign n385 = {n381, n380};
  /*# T65.vhd:486:11 */
  assign n386 = rstcycle ? n384 : n385;
  /*# T65.vhd:434:14 */
  assign n388 = {n367, n363, 1'b1, 1'b1, n386, n366, n359};
  /*# T65.vhd:441:9 */
  assign n390 = n315 & really_rdy;
  /*# T65.vhd:441:9 */
  assign n392 = n317 & really_rdy;
  /*# T65.vhd:441:9 */
  assign n394 = n319 & really_rdy;
  /*# T65.vhd:440:7 */
  assign n395 = n420 ? n388 : p;
  /*# T65.vhd:497:14 */
  assign n398 = ir[4:0]; // extract
  /*# T65.vhd:497:26 */
  assign n400 = n398 != 5'b10000;
  /*# T65.vhd:497:43 */
  assign n402 = jump != 2'b01;
  /*# T65.vhd:497:36 */
  assign n403 = n400 | n402;
  /*# T65.vhd:497:64 */
  assign n404 = ~really_rdy;
  /*# T65.vhd:497:50 */
  assign n405 = n403 | n404;
  /*# T65.vhd:501:14 */
  assign n407 = ir[4:0]; // extract
  /*# T65.vhd:501:26 */
  assign n409 = n407 != 5'b10000;
  /*# T65.vhd:501:43 */
  assign n411 = jump != 2'b01;
  /*# T65.vhd:501:36 */
  assign n412 = n409 | n411;
  /*# T65.vhd:440:7 */
  assign n415 = n390 & Enable;
  /*# T65.vhd:440:7 */
  assign n417 = n392 & Enable;
  /*# T65.vhd:440:7 */
  assign n419 = n394 & Enable;
  /*# T65.vhd:440:7 */
  assign n420 = really_rdy & Enable;
  /*# T65.vhd:440:7 */
  assign n421 = n405 & Enable;
  /*# T65.vhd:440:7 */
  assign n422 = n412 & Enable;
  /*# T65.vhd:508:42 */
  assign n424 = ~SO_n;
  /*# T65.vhd:508:33 */
  assign n425 = n424 & so_n_o;
  /*# T65.vhd:168:10 */
  assign n427 = n395[6]; // extract
  /*# T65.vhd:508:17 */
  assign n428 = n425 ? 1'b1 : n427;
  /*# T65.vhd:168:10 */
  assign n429 = n395[7]; // extract
  /*# T65.vhd:168:10 */
  assign n430 = n395[5:0]; // extract
  /*# T65.vhd:438:5 */
  assign n437 = {n429, n428, n430};
  /*# T65.vhd:523:16 */
  assign n458 = ~res_n_i;
  /*# T65.vhd:539:28 */
  assign n461 = set_addr_to_r == 2'b00;
  /*# T65.vhd:539:63 */
  assign n463 = set_addr_to_r == 2'b10;
  /*# T65.vhd:539:46 */
  assign n464 = n461 | n463;
  /*# T65.vhd:540:65 */
  assign n466 = DI + 8'b00000001;
  /*# T65.vhd:546:49 */
  assign n469 = ad + 8'b00000001;
  /*# T65.vhd:547:51 */
  assign n471 = bal + 9'b000000001;
  /*# T65.vhd:544:11 */
  assign n473 = baadd == 2'b01;
  /*# T65.vhd:550:56 */
  assign n474 = bal[7:0]; // extract
  /*# T65.vhd:550:37 */
  assign n475 = {1'b0, n474};  // uext
  /*# T65.vhd:550:75 */
  assign n476 = {1'b0, busa};  // uext
  /*# T65.vhd:550:73 */
  assign n477 = n475 + n476;
  /*# T65.vhd:548:11 */
  assign n479 = baadd == 2'b10;
  /*# T65.vhd:553:19 */
  assign n480 = bal[8]; // extract
  /*# T65.vhd:556:66 */
  assign n482 = bah + 8'b00000001;
  /*# T65.vhd:556:15 */
  assign n484 = baquirk == 2'b00;
  /*# T65.vhd:557:66 */
  assign n486 = bah + 8'b00000001;
  /*# T65.vhd:557:71 */
  assign n487 = n486 & do_r;
  /*# T65.vhd:557:15 */
  assign n489 = baquirk == 2'b01;
  /*# T65.vhd:558:15 */
  assign n491 = baquirk == 2'b10;
  /*# T65.vhd:555:15 */
  assign n492 = {n491, n489, n484};
  /*# T65.vhd:555:15 */
  always @*
    case (n492)
      3'b100: n493 = do_r;
      3'b010: n493 = n487;
      3'b001: n493 = n482;
      default: n493 = bah;
    endcase
  /*# T65.vhd:553:13 */
  assign n494 = n480 ? n493 : bah;
  /*# T65.vhd:551:11 */
  assign n496 = baadd == 2'b11;
  /*# T65.vhd:543:11 */
  assign n497 = {n496, n479, n473};
  /*# T65.vhd:543:11 */
  always @*
    case (n497)
      3'b100: n498 = ad;
      3'b010: n498 = ad;
      3'b001: n498 = n469;
      default: n498 = ad;
    endcase
  /*# T65.vhd:543:11 */
  always @*
    case (n497)
      3'b100: n499 = n494;
      3'b010: n499 = bah;
      3'b001: n499 = bah;
      default: n499 = bah;
    endcase
  /*# T65.vhd:543:11 */
  always @*
    case (n497)
      3'b100: n500 = bal;
      3'b010: n500 = n477;
      3'b001: n500 = n471;
      default: n500 = bal;
    endcase
  /*# T65.vhd:568:63 */
  assign n501 = y[7:0]; // extract
  /*# T65.vhd:568:51 */
  assign n502 = ad + n501;
  /*# T65.vhd:570:63 */
  assign n503 = x[7:0]; // extract
  /*# T65.vhd:570:51 */
  assign n504 = ad + n503;
  /*# T65.vhd:567:13 */
  assign n505 = addy ? n502 : n504;
  /*# T65.vhd:566:11 */
  assign n506 = adadd ? n505 : n498;
  /*# T65.vhd:574:17 */
  assign n508 = ir == 8'b00000000;
  /*# T65.vhd:579:61 */
  assign n511 = mcycle == 3'b100;
  /*# T65.vhd:579:51 */
  assign n512 = n511 & nmiact;
  /*# T65.vhd:579:34 */
  assign n513 = nmicycle | n512;
  /*# T65.vhd:579:69 */
  assign n514 = n513 | nmi_entered;
  /*# T65.vhd:581:24 */
  assign n517 = mcycle == 3'b100;
  /*# T65.vhd:581:15 */
  assign n520 = n517 ? 1'b1 : 1'b0;
  /*# T65.vhd:579:13 */
  assign n522 = n514 ? 3'b010 : 3'b110;
  /*# T65.vhd:579:13 */
  assign n524 = n514 ? n520 : 1'b0;
  /*# T65.vhd:577:13 */
  assign n525 = rstcycle ? 3'b100 : n522;
  /*# T65.vhd:171:10 */
  assign n527 = n526[8:3]; // extract
  /*# T65.vhd:577:13 */
  assign n529 = rstcycle ? 1'b0 : n524;
  /*# T65.vhd:587:30 */
  assign n531 = set_addr_to_r == 2'b11;
  /*# T65.vhd:171:10 */
  assign n533 = n525[0]; // extract
  /*# T65.vhd:587:13 */
  assign n534 = n531 ? 1'b1 : n533;
  /*# T65.vhd:171:10 */
  assign n535 = n525[2:1]; // extract
  /*# T65.vhd:574:11 */
  assign n537 = n508 ? 8'b11111111 : n499;
  /*# T65.vhd:574:11 */
  assign n538 = {n527, n535, n534};
  /*# T65.vhd:574:11 */
  assign n539 = n508 ? n538 : n500;
  /*# T65.vhd:574:11 */
  assign n541 = n508 ? n529 : 1'b0;
  /*# T65.vhd:592:11 */
  assign n543 = lddi ? DI : dl;
  /*# T65.vhd:595:11 */
  assign n544 = ldalu ? alu_q : n543;
  /*# T65.vhd:598:11 */
  assign n545 = ldad ? DI : n506;
  /*# T65.vhd:171:10 */
  assign n546 = n539[7:0]; // extract
  /*# T65.vhd:601:11 */
  assign n547 = ldbal ? DI : n546;
  /*# T65.vhd:171:10 */
  assign n548 = n539[8]; // extract
  /*# T65.vhd:604:11 */
  assign n549 = ldbah ? DI : n537;
  /*# T65.vhd:533:9 */
  assign n553 = {n548, n547};
  /*# T65.vhd:533:9 */
  assign n557 = n464 & really_rdy;
  /*# T65.vhd:532:7 */
  assign n559 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n560 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n561 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n562 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n563 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n564 = really_rdy & Enable;
  /*# T65.vhd:532:7 */
  assign n565 = n557 & Enable;
  /*# T65.vhd:532:7 */
  assign n566 = really_rdy & Enable;
  /*# T65.vhd:612:34 */
  assign n591 = bal[8]; // extract
  /*# T65.vhd:612:27 */
  assign n592 = ~n591;
  /*# T65.vhd:612:23 */
  assign n593 = breakatna & n592;
  /*# T65.vhd:612:64 */
  assign n594 = pcadder[8]; // extract
  /*# T65.vhd:612:53 */
  assign n595 = ~n594;
  /*# T65.vhd:612:49 */
  assign n596 = pcadd & n595;
  /*# T65.vhd:612:39 */
  assign n597 = n593 | n596;
  /*# T65.vhd:616:45 */
  assign n599 = set_busa_to == 4'b0000;
  /*# T65.vhd:617:10 */
  assign n600 = abc[7:0]; // extract
  /*# T65.vhd:617:45 */
  assign n602 = set_busa_to == 4'b0001;
  /*# T65.vhd:618:8 */
  assign n603 = x[7:0]; // extract
  /*# T65.vhd:618:45 */
  assign n605 = set_busa_to == 4'b0010;
  /*# T65.vhd:619:8 */
  assign n606 = y[7:0]; // extract
  /*# T65.vhd:619:45 */
  assign n608 = set_busa_to == 4'b0011;
  /*# T65.vhd:620:25 */
  assign n609 = s[7:0]; // extract
  /*# T65.vhd:620:45 */
  assign n611 = set_busa_to == 4'b0100;
  /*# T65.vhd:621:45 */
  assign n613 = set_busa_to == 4'b0101;
  /*# T65.vhd:622:10 */
  assign n614 = abc[7:0]; // extract
  /*# T65.vhd:622:23 */
  assign n615 = n614 & DI;
  /*# T65.vhd:622:45 */
  assign n617 = set_busa_to == 4'b0110;
  /*# T65.vhd:623:11 */
  assign n618 = abc[7:0]; // extract
  /*# T65.vhd:623:24 */
  assign n620 = n618 | 8'b11101110;
  /*# T65.vhd:623:34 */
  assign n621 = n620 & DI;
  /*# T65.vhd:623:45 */
  assign n623 = set_busa_to == 4'b0111;
  /*# T65.vhd:624:11 */
  assign n624 = abc[7:0]; // extract
  /*# T65.vhd:624:24 */
  assign n626 = n624 | 8'b11101110;
  /*# T65.vhd:624:34 */
  assign n627 = n626 & DI;
  /*# T65.vhd:624:46 */
  assign n628 = x[7:0]; // extract
  /*# T65.vhd:624:41 */
  assign n629 = n627 & n628;
  /*# T65.vhd:624:62 */
  assign n631 = set_busa_to == 4'b1000;
  /*# T65.vhd:625:10 */
  assign n632 = abc[7:0]; // extract
  /*# T65.vhd:625:28 */
  assign n633 = x[7:0]; // extract
  /*# T65.vhd:625:23 */
  assign n634 = n632 & n633;
  /*# T65.vhd:625:45 */
  assign n636 = set_busa_to == 4'b1001;
  /*# T65.vhd:626:45 */
  assign n639 = set_busa_to == 4'b1010;
  /*# T65.vhd:614:3 */
  assign n640 = {n639, n636, n631, n623, n617, n613, n611, n608, n605, n602, n599};
  /*# T65.vhd:614:3 */
  always @*
    case (n640)
      11'b10000000000: n642 = 8'bX;
      11'b01000000000: n642 = n634;
      11'b00100000000: n642 = n629;
      11'b00010000000: n642 = n621;
      11'b00001000000: n642 = n615;
      11'b00000100000: n642 = p;
      11'b00000010000: n642 = n609;
      11'b00000001000: n642 = n606;
      11'b00000000100: n642 = n603;
      11'b00000000010: n642 = n600;
      11'b00000000001: n642 = DI;
      default: n642 = 8'bX;
    endcase
  /*# T65.vhd:630:46 */
  assign n643 = s[7:0]; // extract
  /*# T65.vhd:630:26 */
  assign n645 = {16'b0000000000000001, n643};
  /*# T65.vhd:630:87 */
  assign n647 = set_addr_to_r == 2'b01;
  /*# T65.vhd:631:11 */
  assign n649 = {dbr, 8'b00000000};
  /*# T65.vhd:631:24 */
  assign n650 = {n649, ad};
  /*# T65.vhd:631:87 */
  assign n652 = set_addr_to_r == 2'b10;
  /*# T65.vhd:632:18 */
  assign n654 = {8'b00000000, bah};
  /*# T65.vhd:632:29 */
  assign n655 = bal[7:0]; // extract
  /*# T65.vhd:632:24 */
  assign n656 = {n654, n655};
  /*# T65.vhd:632:87 */
  assign n658 = set_addr_to_r == 2'b11;
  /*# T65.vhd:633:32 */
  assign n659 = pc[15:8]; // extract
  /*# T65.vhd:633:11 */
  assign n660 = {pbr, n659};
  /*# T65.vhd:633:73 */
  assign n661 = pcadder[7:0]; // extract
  /*# T65.vhd:633:47 */
  assign n662 = {n660, n661};
  /*# T65.vhd:633:87 */
  assign n664 = set_addr_to_r == 2'b00;
  /*# T65.vhd:628:3 */
  assign n665 = {n664, n658, n652, n647};
  /*# T65.vhd:628:3 */
  always @*
    case (n665)
      4'b1000: n667 = n662;
      4'b0100: n667 = n656;
      4'b0010: n667 = n650;
      4'b0001: n667 = n645;
      default: n667 = 24'bX;
    endcase
  /*# T65.vhd:636:14 */
  assign n669 = p & 8'b11101111;
  /*# T65.vhd:636:44 */
  assign n670 = irqcycle | nmicycle;
  /*# T65.vhd:636:25 */
  assign n671 = n670 ? n669 : p;
  /*# T65.vhd:642:43 */
  assign n673 = write_data_r == 4'b0000;
  /*# T65.vhd:643:10 */
  assign n674 = abc[7:0]; // extract
  /*# T65.vhd:643:43 */
  assign n676 = write_data_r == 4'b0001;
  /*# T65.vhd:644:8 */
  assign n677 = x[7:0]; // extract
  /*# T65.vhd:644:43 */
  assign n679 = write_data_r == 4'b0010;
  /*# T65.vhd:645:8 */
  assign n680 = y[7:0]; // extract
  /*# T65.vhd:645:43 */
  assign n682 = write_data_r == 4'b0011;
  /*# T65.vhd:646:25 */
  assign n683 = s[7:0]; // extract
  /*# T65.vhd:646:43 */
  assign n685 = write_data_r == 4'b0100;
  /*# T65.vhd:647:43 */
  assign n687 = write_data_r == 4'b0101;
  /*# T65.vhd:648:26 */
  assign n688 = pc[7:0]; // extract
  /*# T65.vhd:648:43 */
  assign n690 = write_data_r == 4'b0110;
  /*# T65.vhd:649:26 */
  assign n691 = pc[15:8]; // extract
  /*# T65.vhd:649:43 */
  assign n693 = write_data_r == 4'b0111;
  /*# T65.vhd:650:10 */
  assign n694 = abc[7:0]; // extract
  /*# T65.vhd:650:28 */
  assign n695 = x[7:0]; // extract
  /*# T65.vhd:650:23 */
  assign n696 = n694 & n695;
  /*# T65.vhd:650:43 */
  assign n698 = write_data_r == 4'b1000;
  /*# T65.vhd:651:10 */
  assign n699 = abc[7:0]; // extract
  /*# T65.vhd:651:28 */
  assign n700 = x[7:0]; // extract
  /*# T65.vhd:651:23 */
  assign n701 = n699 & n700;
  /*# T65.vhd:651:41 */
  assign n702 = n701 & busb_r;
  /*# T65.vhd:651:64 */
  assign n704 = write_data_r == 4'b1001;
  /*# T65.vhd:652:8 */
  assign n705 = x[7:0]; // extract
  /*# T65.vhd:652:21 */
  assign n706 = n705 & busb_r;
  /*# T65.vhd:652:44 */
  assign n708 = write_data_r == 4'b1010;
  /*# T65.vhd:653:8 */
  assign n709 = y[7:0]; // extract
  /*# T65.vhd:653:21 */
  assign n710 = n709 & busb_r;
  /*# T65.vhd:653:44 */
  assign n712 = write_data_r == 4'b1011;
  /*# T65.vhd:654:43 */
  assign n715 = write_data_r == 4'b1100;
  /*# T65.vhd:640:3 */
  assign n716 = {n715, n712, n708, n704, n698, n693, n690, n687, n685, n682, n679, n676, n673};
  /*# T65.vhd:640:3 */
  always @*
    case (n716)
      13'b1000000000000: n718 = 8'bX;
      13'b0100000000000: n718 = n710;
      13'b0010000000000: n718 = n706;
      13'b0001000000000: n718 = n702;
      13'b0000100000000: n718 = n696;
      13'b0000010000000: n718 = n691;
      13'b0000001000000: n718 = n688;
      13'b0000000100000: n718 = pwithb;
      13'b0000000010000: n718 = n683;
      13'b0000000001000: n718 = n680;
      13'b0000000000100: n718 = n677;
      13'b0000000000010: n718 = n674;
      13'b0000000000001: n718 = dl;
      default: n718 = 8'bX;
    endcase
  /*# T65.vhd:665:16 */
  assign n721 = ~res_n_i;
  /*# T65.vhd:674:21 */
  assign n723 = mcycle == lcycle;
  /*# T65.vhd:674:30 */
  assign n724 = n723 | brk_n;
  /*# T65.vhd:679:35 */
  assign n726 = ir != 8'b00000000;
  /*# T65.vhd:679:29 */
  assign n727 = n726 & nmiact;
  /*# T65.vhd:682:27 */
  assign n728 = ~irq_n_o;
  /*# T65.vhd:682:38 */
  assign n729 = p[2]; // extract
  /*# T65.vhd:682:47 */
  assign n730 = ~n729;
  /*# T65.vhd:682:33 */
  assign n731 = n730 & n728;
  /*# T65.vhd:682:13 */
  assign n734 = n731 ? 1'b1 : 1'b0;
  /*# T65.vhd:679:13 */
  assign n736 = n727 ? 1'b0 : n734;
  /*# T65.vhd:679:13 */
  assign n740 = n727 ? 1'b1 : 1'b0;
  /*# T65.vhd:673:9 */
  assign n743 = n757 ? 1'b0 : nmiact;
  /*# T65.vhd:686:57 */
  assign n745 = mcycle + 3'b001;
  /*# T65.vhd:674:11 */
  assign n747 = n724 ? 3'b000 : n745;
  /*# T65.vhd:674:11 */
  assign n752 = n727 & n724;
  /*# T65.vhd:673:9 */
  assign n754 = n724 & really_rdy;
  /*# T65.vhd:673:9 */
  assign n755 = n724 & really_rdy;
  /*# T65.vhd:673:9 */
  assign n756 = n724 & really_rdy;
  /*# T65.vhd:673:9 */
  assign n757 = n752 & really_rdy;
  /*# T65.vhd:690:37 */
  assign n758 = ~NMI_n;
  /*# T65.vhd:690:50 */
  assign n759 = ir[4:0]; // extract
  /*# T65.vhd:690:62 */
  assign n761 = n759 != 5'b10000;
  /*# T65.vhd:690:79 */
  assign n763 = jump != 2'b01;
  /*# T65.vhd:690:72 */
  assign n764 = n761 | n763;
  /*# T65.vhd:690:43 */
  assign n765 = n764 & n758;
  /*# T65.vhd:690:26 */
  assign n766 = n765 & nmi_n_o;
  /*# T65.vhd:690:9 */
  assign n768 = n766 ? 1'b1 : n743;
  /*# T65.vhd:694:9 */
  assign n770 = nmi_entered ? 1'b0 : n768;
  /*# T65.vhd:672:7 */
  assign n771 = really_rdy & Enable;
  /*# T65.vhd:672:7 */
  assign n772 = n754 & Enable;
  /*# T65.vhd:672:7 */
  assign n773 = n755 & Enable;
  /*# T65.vhd:672:7 */
  assign n774 = n756 & Enable;
  /*# T65.vhd:167:10 */
  assign n793 = {8'bZ, n803};
  /*# T65.vhd:167:15 */
  assign n795 = {8'bZ, n808};
  /*# T65.vhd:167:18 */
  assign n797 = {8'bZ, n813};
  /*# T65.vhd:159:5 */
  assign n798 = {p, n66, n65, n64, n63, ir};
  /*# T65.vhd:167:10 */
  assign n799 = ~n301;
  /*# T65.vhd:167:10 */
  assign n800 = n415 & n799;
  /*# T65.vhd:438:5 */
  assign n801 = abc[7:0]; // extract
  /*# T65.vhd:438:5 */
  assign n802 = n800 ? alu_q : n801;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n803 <= n802;
  /*# T65.vhd:167:15 */
  assign n804 = ~n301;
  /*# T65.vhd:167:15 */
  assign n805 = n417 & n804;
  /*# T65.vhd:438:5 */
  assign n806 = x[7:0]; // extract
  /*# T65.vhd:438:5 */
  assign n807 = n805 ? alu_q : n806;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n808 <= n807;
  /*# T65.vhd:167:18 */
  assign n809 = ~n301;
  /*# T65.vhd:167:18 */
  assign n810 = n419 & n809;
  /*# T65.vhd:438:5 */
  assign n811 = y[7:0]; // extract
  /*# T65.vhd:438:5 */
  assign n812 = n810 ? alu_q : n811;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n813 <= n812;
  /*# T65.vhd:438:5 */
  always @(posedge Clk or posedge n301)
    if (n301)
      n814 <= 8'b00000000;
    else
      n814 <= n437;
  /*# T65.vhd:531:5 */
  assign n815 = n559 ? n545 : ad;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n816 <= 8'b00000000;
    else
      n816 <= n815;
  /*# T65.vhd:531:5 */
  assign n817 = n560 ? n544 : dl;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n818 <= 8'b00000000;
    else
      n818 <= n817;
  /*# T65.vhd:531:5 */
  assign n819 = n561 ? n549 : bah;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n820 <= 8'b00000000;
    else
      n820 <= n819;
  /*# T65.vhd:531:5 */
  assign n821 = n562 ? n553 : bal;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n822 <= 9'b000000000;
    else
      n822 <= n821;
  /*# T65.vhd:352:5 */
  assign n823 = n233 ? 8'b11111111 : pbr;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n824 <= 8'b00000000;
    else
      n824 <= n823;
  /*# T65.vhd:352:5 */
  assign n825 = n234 ? 8'b11111111 : dbr;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n826 <= 8'b00000000;
    else
      n826 <= n825;
  /*# T65.vhd:352:5 */
  assign n827 = n235 ? n218 : pc;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n828 <= 16'b0000000000000000;
    else
      n828 <= n827;
  /*# T65.vhd:352:5 */
  assign n829 = n236 ? n169 : s;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n830 <= 16'b0000000000000000;
    else
      n830 <= n829;
  /*# T65.vhd:352:5 */
  assign n831 = n237 ? 1'b0 : ef_i;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n832 <= 1'b1;
    else
      n832 <= n831;
  /*# T65.vhd:352:5 */
  assign n833 = n238 ? 1'b0 : mf_i;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n834 <= 1'b1;
    else
      n834 <= n833;
  /*# T65.vhd:352:5 */
  assign n835 = n239 ? 1'b0 : xf_i;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n836 <= 1'b1;
    else
      n836 <= n835;
  /*# T65.vhd:352:5 */
  assign n837 = n240 ? n150 : ir;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n838 <= 8'b00000000;
    else
      n838 <= n837;
  /*# T65.vhd:671:5 */
  assign n839 = n771 ? n747 : mcycle;
  /*# T65.vhd:671:5 */
  always @(posedge Clk or posedge n721)
    if (n721)
      n840 <= 3'b001;
    else
      n840 <= n839;
  /*# T65.vhd:352:5 */
  assign n841 = n241 ? Mode : mode_r;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n842 <= 2'b00;
    else
      n842 <= n841;
  /*# T65.vhd:352:5 */
  assign n843 = n242 ? alu_op : alu_op_r;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n844 <= 5'b01100;
    else
      n844 <= n843;
  /*# T65.vhd:352:5 */
  assign n845 = n243 ? write_data : write_data_r;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n846 <= 4'b0000;
    else
      n846 <= n845;
  /*# T65.vhd:352:5 */
  assign n847 = n244 ? n159 : set_addr_to_r;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n848 <= 2'b00;
    else
      n848 <= n847;
  /*# T65.vhd:671:5 */
  assign n849 = n772 ? 1'b0 : rstcycle;
  /*# T65.vhd:671:5 */
  always @(posedge Clk or posedge n721)
    if (n721)
      n850 <= 1'b1;
    else
      n850 <= n849;
  /*# T65.vhd:671:5 */
  assign n851 = n773 ? n736 : irqcycle;
  /*# T65.vhd:671:5 */
  always @(posedge Clk or posedge n721)
    if (n721)
      n852 <= 1'b0;
    else
      n852 <= n851;
  /*# T65.vhd:671:5 */
  assign n853 = n774 ? n740 : nmicycle;
  /*# T65.vhd:671:5 */
  always @(posedge Clk or posedge n721)
    if (n721)
      n854 <= 1'b0;
    else
      n854 <= n853;
  /*# T65.vhd:195:10 */
  assign n855 = ~n301;
  /*# T65.vhd:438:5 */
  assign n856 = n855 ? SO_n : so_n_o;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n857 <= n856;
  /*# T65.vhd:196:10 */
  assign n858 = ~n301;
  /*# T65.vhd:196:10 */
  assign n859 = n421 & n858;
  /*# T65.vhd:438:5 */
  assign n860 = n859 ? IRQ_n : irq_n_o;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n861 <= n860;
  /*# T65.vhd:197:10 */
  assign n862 = ~n301;
  /*# T65.vhd:197:10 */
  assign n863 = n422 & n862;
  /*# T65.vhd:438:5 */
  assign n864 = n863 ? NMI_n : nmi_n_o;
  /*# T65.vhd:438:5 */
  always @(posedge Clk)
    n865 <= n864;
  /*# T65.vhd:671:5 */
  assign n866 = Enable ? n770 : nmiact;
  /*# T65.vhd:671:5 */
  always @(posedge Clk or posedge n721)
    if (n721)
      n867 <= 1'b0;
    else
      n867 <= n866;
  /*# T65.vhd:531:5 */
  assign n868 = n563 ? busa : busa_r;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n869 <= 8'b00000000;
    else
      n869 <= n868;
  /*# T65.vhd:531:5 */
  assign n870 = n564 ? DI : busb;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n871 <= 8'b00000000;
    else
      n871 <= n870;
  /*# T65.vhd:531:5 */
  assign n872 = n565 ? n466 : busb_r;
  /*# T65.vhd:531:5 */
  always @(posedge Clk or posedge n458)
    if (n458)
      n873 <= 8'b00000000;
    else
      n873 <= n872;
  /*# T65.vhd:327:5 */
  always @(posedge Clk or posedge n105)
    if (n105)
      n874 <= 1'b0;
    else
      n874 <= res_n_d;
  /*# T65.vhd:327:5 */
  always @(posedge Clk or posedge n105)
    if (n105)
      n875 <= 1'b0;
    else
      n875 <= 1'b1;
  /*# T65.vhd:241:10 */
  assign n876 = ~n117;
  /*# T65.vhd:241:10 */
  assign n877 = Enable & n876;
  /*# T65.vhd:352:5 */
  assign n878 = n877 ? n137 : rdy_mod;
  /*# T65.vhd:352:5 */
  always @(posedge Clk)
    n879 <= n878;
  /*# T65.vhd:352:5 */
  assign n880 = n246 ? n139 : wrn_i;
  /*# T65.vhd:352:5 */
  always @(posedge Clk or posedge n117)
    if (n117)
      n881 <= 1'b1;
    else
      n881 <= n880;
  /*# T65.vhd:245:10 */
  assign n882 = ~n458;
  /*# T65.vhd:245:10 */
  assign n883 = n566 & n882;
  /*# T65.vhd:531:5 */
  assign n884 = n883 ? n541 : nmi_entered;
  /*# T65.vhd:531:5 */
  always @(posedge Clk)
    n885 <= n884;
endmodule


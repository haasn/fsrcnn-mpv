//!HOOK LUMA
//!DESC feature map 0
//!BIND LUMA
//!SAVE FEATURE0
//!COMPONENTS 4

vec4 hook()
{
vec4 res = vec4(0.51655,-2.40939e-2,-1.24776e-3,-5.6635e-2);
res += vec4(4.7111697495e-2,-1.27308424562e-2,-5.82339540124e-2,2.93522961438e-2) * float(LUMA_texOff(vec2(-2,-2)));
res += vec4(2.35338527709e-2,-8.07302370667e-2,-8.00238996744e-2,5.36922290921e-2) * float(LUMA_texOff(vec2(-2,-1)));
res += vec4(-1.16273574531e-2,-4.84868045896e-3,-2.18369644135e-2,-3.7047190126e-3) * float(LUMA_texOff(vec2(-2,0)));
res += vec4(-3.01540922374e-3,1.75939332694e-2,4.01100795716e-3,3.20707522333e-2) * float(LUMA_texOff(vec2(-2,1)));
res += vec4(-2.91586155072e-3,-1.21205123141e-2,1.9051078707e-2,-2.9442910105e-2) * float(LUMA_texOff(vec2(-2,2)));
res += vec4(5.05730286241e-2,-1.00671583787e-2,2.55545526743e-2,6.52065128088e-2) * float(LUMA_texOff(vec2(-1,-2)));
res += vec4(9.82784926891e-2,4.59155999124e-3,-3.86520624161e-2,1.20644774288e-2) * float(LUMA_texOff(vec2(-1,-1)));
res += vec4(5.24111762643e-2,8.87843444943e-2,3.54389706627e-3,9.38619598746e-2) * float(LUMA_texOff(vec2(-1,0)));
res += vec4(7.94024467468e-2,3.46789620817e-2,-4.75046932697e-2,-1.75459645689e-2) * float(LUMA_texOff(vec2(-1,1)));
res += vec4(8.57816729695e-3,-7.36729502678e-2,-7.35334400088e-3,3.40857729316e-2) * float(LUMA_texOff(vec2(-1,2)));
res += vec4(-1.29295326769e-2,2.56750062108e-2,-7.00067952275e-2,7.85527937114e-3) * float(LUMA_texOff(vec2(0,-2)));
res += vec4(5.7023152709e-2,3.68136563338e-4,4.65443395078e-2,6.9342918694e-2) * float(LUMA_texOff(vec2(0,-1)));
res += vec4(-0.738169431686,3.7415693514e-3,-4.97588142753e-3,1.04404520988) * float(LUMA_texOff(vec2(0,0)));
res += vec4(-9.4131808728e-3,-2.94061265886e-2,-2.26735062897e-2,1.63645055145e-2) * float(LUMA_texOff(vec2(0,1)));
res += vec4(2.56015453488e-2,-1.33246146142e-2,-1.45909776911e-2,4.26804982126e-2) * float(LUMA_texOff(vec2(0,2)));
res += vec4(1.20770670474e-2,-7.68803134561e-2,-4.16295826435e-2,3.56608070433e-2) * float(LUMA_texOff(vec2(1,-2)));
res += vec4(5.87420240045e-2,4.84516657889e-2,4.16292883456e-2,-2.02609654516e-2) * float(LUMA_texOff(vec2(1,-1)));
res += vec4(3.33527959883e-2,1.42396017909e-2,2.33772881329e-2,5.24079017341e-2) * float(LUMA_texOff(vec2(1,0)));
res += vec4(6.49727582932e-2,-9.2421611771e-3,-5.35227684304e-3,-6.37035584077e-4) * float(LUMA_texOff(vec2(1,1)));
res += vec4(2.29953732342e-2,-7.48595148325e-2,-1.72170752194e-3,4.29895594716e-2) * float(LUMA_texOff(vec2(1,2)));
res += vec4(3.6793269217e-2,-6.04014694691e-2,-2.33402401209e-2,7.45645258576e-3) * float(LUMA_texOff(vec2(2,-2)));
res += vec4(1.54589917511e-2,-2.80166640878e-2,1.25365415588e-2,4.72608059645e-2) * float(LUMA_texOff(vec2(2,-1)));
res += vec4(6.1665892601e-2,5.58976382017e-2,-8.02147611976e-2,6.14817887545e-2) * float(LUMA_texOff(vec2(2,0)));
res += vec4(1.72220245004e-2,-8.07060077786e-2,-2.8228584677e-2,5.12590222061e-2) * float(LUMA_texOff(vec2(2,1)));
res += vec4(1.58836618066e-2,1.92561972653e-4,-1.90239176154e-2,8.07460979559e-4) * float(LUMA_texOff(vec2(2,2)));
res = mix(res, vec4(9.67003e-3,-9.29752e-3,8.41814e-4,7.88548e-2) * res, lessThan(res, vec4(0.0)));
return vec4(res);
}

//!HOOK LUMA
//!DESC shrinking
//!BIND FEATURE0
//!SAVE MODEL
//!COMPONENTS 2

vec4 hook()
{
vec2 res = vec2(0.960192,-5.97092e-3);
res += mat4x2(0.758164167404,-0.238971844316,-0.591218531132,-2.72625759244e-2,-0.297585785389,3.16921137273e-2,-0.870758652687,-0.414128929377) * vec4(FEATURE0_texOff(vec2(0,0)));
res = mix(res, vec2(0.477507,-7.43882e-2) * res, lessThan(res, vec2(0.0)));
return vec4(res, 0.0, 0.0);
}

//!HOOK LUMA
//!DESC mapping 1
//!BIND MODEL
//!SAVE MODEL
//!COMPONENTS 2

vec4 hook()
{
vec2 res = vec2(0.190763,0.120393);
res += mat2(7.81123759225e-3,5.59216290712e-2,-5.25366477668e-2,0.214734464884) * vec2(MODEL_texOff(vec2(-1,-1)));
res += mat2(-0.183337047696,5.92923462391e-2,5.47977052629e-2,4.09008450806e-2) * vec2(MODEL_texOff(vec2(-1,0)));
res += mat2(1.04676233605e-2,7.04043656588e-2,0.167754843831,-6.50847330689e-2) * vec2(MODEL_texOff(vec2(-1,1)));
res += mat2(-1.04464143515e-2,-0.145912617445,7.32982456684e-2,-5.28131723404e-2) * vec2(MODEL_texOff(vec2(0,-1)));
res += mat2(0.977525293827,0.87990039587,2.0838720724e-2,-5.52164502442e-2) * vec2(MODEL_texOff(vec2(0,0)));
res += mat2(-0.146097049117,1.78662277758e-2,0.251452356577,-7.54488408566e-2) * vec2(MODEL_texOff(vec2(0,1)));
res += mat2(-0.140685722232,0.154653608799,-5.71816153824e-2,-6.65760114789e-2) * vec2(MODEL_texOff(vec2(1,-1)));
res += mat2(-8.50620046258e-2,0.142946898937,0.179678201675,6.89749559388e-3) * vec2(MODEL_texOff(vec2(1,0)));
res += mat2(-3.11551615596e-2,7.48027265072e-2,0.121399439871,6.27064034343e-2) * vec2(MODEL_texOff(vec2(1,1)));
res = mix(res, vec2(2.66747e-2,7.52121e-3) * res, lessThan(res, vec2(0.0)));
return vec4(res, 0.0, 0.0);
}

//!HOOK LUMA
//!DESC expansion 0
//!BIND MODEL
//!SAVE EXPANDED0
//!COMPONENTS 4

vec4 hook()
{
vec4 res = vec4(0.465359,-9.49314e-6,-0.202143,-2.67428e-4);
res += mat2x4(-0.298810124397,-4.3613627553e-2,0.866921067238,-0.103471674025,0.200132071972,-1.67408250272e-2,0.748284399509,-0.284485667944) * vec2(MODEL_texOff(vec2(0,0)));
res = mix(res, vec4(7.07689e-3,2.10936e-5,0.279285,-1.99172e-3) * res, lessThan(res, vec4(0.0)));
return vec4(res);
}

//!WIDTH LUMA.w 3 *
//!HEIGHT LUMA.h 3 *
//!HOOK LUMA
//!DESC reconstruction
//!BIND EXPANDED0
//!SAVE LUMA
//!COMPONENTS 1
//!LOAD NEAREST 9 9 1 4 ~~/shaders/fsrcnn/FSRCNN_4_2_1.tex

vec4 hook()
{
float res = float(0.932049);
vec2 fcoord = fract(EXPANDED0_pos * EXPANDED0_size);
vec2 base = EXPANDED0_pos + (vec2(0.5) - fcoord) * EXPANDED0_pt;
const vec2 tpt = vec2(1/9.0); // gap between 9x9 pixels
const vec2 tst = 3 * tpt;     // gap between blocks of 3x3 pixels
vec2 tbase = vec2(0.5) + tst * (fcoord - vec2(0.5));
#define get(p) dot(texture(user_tex, tbase - tst * p), EXPANDED0_tex(base + EXPANDED0_pt * p))
res += get(vec2(-1,-1));
res += get(vec2( 0,-1));
res += get(vec2( 1,-1));
res += get(vec2(-1, 0));
res += get(vec2( 0, 0));
res += get(vec2( 1, 0));
res += get(vec2(-1, 1));
res += get(vec2( 0, 1));
res += get(vec2( 1, 1));
return vec4(res, 0, 0, 1);
}

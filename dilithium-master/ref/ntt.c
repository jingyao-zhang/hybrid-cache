#include <stdint.h>
#include "params.h"
#include "ntt.h"
#include "reduce.h"

extern int ReadCC;
extern int WriteCC;
extern int LeftShiftInst;
extern int RightShiftInst;
extern int LeftShift;
extern int RightShift;
extern int OrCC;
extern int AndCC;
extern int XorCC;
extern int NotCC;
extern int EBCC;

#define BitW 32

static const int32_t zetas[N] = {
         0,    25847, -2608894,  -518909,   237124,  -777960,  -876248,   466468,
   1826347,  2353451,  -359251, -2091905,  3119733, -2884855,  3111497,  2680103,
   2725464,  1024112, -1079900,  3585928,  -549488, -1119584,  2619752, -2108549,
  -2118186, -3859737, -1399561, -3277672,  1757237,   -19422,  4010497,   280005,
   2706023,    95776,  3077325,  3530437, -1661693, -3592148, -2537516,  3915439,
  -3861115, -3043716,  3574422, -2867647,  3539968,  -300467,  2348700,  -539299,
  -1699267, -1643818,  3505694, -3821735,  3507263, -2140649, -1600420,  3699596,
    811944,   531354,   954230,  3881043,  3900724, -2556880,  2071892, -2797779,
  -3930395, -1528703, -3677745, -3041255, -1452451,  3475950,  2176455, -1585221,
  -1257611,  1939314, -4083598, -1000202, -3190144, -3157330, -3632928,   126922,
   3412210,  -983419,  2147896,  2715295, -2967645, -3693493,  -411027, -2477047,
   -671102, -1228525,   -22981, -1308169,  -381987,  1349076,  1852771, -1430430,
  -3343383,   264944,   508951,  3097992,    44288, -1100098,   904516,  3958618,
  -3724342,    -8578,  1653064, -3249728,  2389356,  -210977,   759969, -1316856,
    189548, -3553272,  3159746, -1851402, -2409325,  -177440,  1315589,  1341330,
   1285669, -1584928,  -812732, -1439742, -3019102, -3881060, -3628969,  3839961,
   2091667,  3407706,  2316500,  3817976, -3342478,  2244091, -2446433, -3562462,
    266997,  2434439, -1235728,  3513181, -3520352, -3759364, -1197226, -3193378,
    900702,  1859098,   909542,   819034,   495491, -1613174,   -43260,  -522500,
   -655327, -3122442,  2031748,  3207046, -3556995,  -525098,  -768622, -3595838,
    342297,   286988, -2437823,  4108315,  3437287, -3342277,  1735879,   203044,
   2842341,  2691481, -2590150,  1265009,  4055324,  1247620,  2486353,  1595974,
  -3767016,  1250494,  2635921, -3548272, -2994039,  1869119,  1903435, -1050970,
  -1333058,  1237275, -3318210, -1430225,  -451100,  1312455,  3306115, -1962642,
  -1279661,  1917081, -2546312, -1374803,  1500165,   777191,  2235880,  3406031,
   -542412, -2831860, -1671176, -1846953, -2584293, -3724270,   594136, -3776993,
  -2013608,  2432395,  2454455,  -164721,  1957272,  3369112,   185531, -1207385,
  -3183426,   162844,  1616392,  3014001,   810149,  1652634, -3694233, -1799107,
  -3038916,  3523897,  3866901,   269760,  2213111,  -975884,  1717735,   472078,
   -426683,  1723600, -1803090,  1910376, -1667432, -1104333,  -260646, -3833893,
  -2939036, -2235985,  -420899, -2286327,   183443,  -976891,  1612842, -3545687,
   -554416,  3919660,   -48306, -1362209,  3937738,  1400424,  -846154,  1976782
};

/*************************************************
* Name:        ntt
*
* Description: Forward NTT, in-place. No modular reduction is performed after
*              additions or subtractions. Output vector is in bitreversed order.
*
* Arguments:   - uint32_t p[N]: input/output coefficient array
**************************************************/
void ntt(int32_t a[N]) {
  unsigned int len, start, j, k;
  int32_t zeta, t;

  k = 0;
  for(len = 128; len > 0; len >>= 1) {
    for(start = 0; start < N; start = j + len) {
      zeta = zetas[++k];
      for(j = start; j < start + len; ++j) {
        t = montgomery_reduce((int64_t)zeta * a[j + len]);
        a[j + len] = a[j] - t;
        a[j] = a[j] + t;
      }
    }
  }
  // ntt data from bit-parallel_mont_mult/dilithium_ntt.cpp
  ReadCC += 34816;
  WriteCC += 34816;
  LeftShiftInst += 201735;
  LeftShift += 201735;
  RightShiftInst += 32768;
  RightShift += 32768;
  OrCC += 44039;
  AndCC += 351246;
  XorCC += 316430;
  NotCC += 0;
  EBCC += 34816;
  NotCC += 0;
}

/*************************************************
* Name:        invntt_tomont
*
* Description: Inverse NTT and multiplication by Montgomery factor 2^32.
*              In-place. No modular reductions after additions or
*              subtractions; input coefficients need to be smaller than
*              Q in absolute value. Output coefficient are smaller than Q in
*              absolute value.
*
* Arguments:   - uint32_t p[N]: input/output coefficient array
**************************************************/
void invntt_tomont(int32_t a[N]) {
  unsigned int start, len, j, k;
  int32_t t, zeta;
  const int32_t f = 41978; // mont^2/256

  k = 256;
  for(len = 1; len < N; len <<= 1) {
    for(start = 0; start < N; start = j + len) {
      zeta = -zetas[--k];
      for(j = start; j < start + len; ++j) {
        t = a[j];
        a[j] = t + a[j + len];
        a[j + len] = t - a[j + len];
        a[j + len] = montgomery_reduce((int64_t)zeta * a[j + len]);
      }
    }
  }
  // ntt data from bit-parallel_mont_mult/dilithium_ntt.cpp
  ReadCC += 34816;
  WriteCC += 34816;
  LeftShiftInst += 201735;
  LeftShift += 201735;
  RightShiftInst += 32768;
  RightShift += 32768;
  OrCC += 44039;
  AndCC += 351246;
  XorCC += 316430;
  NotCC += 0;
  EBCC += 34816;
  NotCC += 0;

  for(j = 0; j < N; ++j) {
    // check MSB, and then AND Q with all 1s or 0s to get q
    // write to a fixed row
    ReadCC += 1;
    WriteCC += 1;
    // bit extention and write back
    EBCC += 1;
    // AND bit with B
    AndCC += 1;
    // add B with q (Q or 0)
    AndCC += BitW; 
    XorCC += BitW;
    LeftShiftInst += (BitW - 1);
    LeftShift += (BitW - 1);
    a[j] = montgomery_reduce((int64_t)f * a[j]);
    // montgomery multiplication data from bit-parallel_mont_mult/dilithium_mont_mult.cpp
    ReadCC += 64;
    WriteCC += 64;
    LeftShiftInst += 63;
    LeftShift += 63;
    RightShiftInst += 32;
    RightShift += 32;
    OrCC += 64;
    AndCC += 255;
    XorCC += 191;
    NotCC += 0;
    EBCC += 64;
    // subtract Q/2 from B （B + (- Q/2)）to get b
    AndCC += BitW; 
    XorCC += BitW;
    LeftShiftInst += BitW - 1;
    LeftShift += BitW - 1;
    // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
    // write to a fixed row
    ReadCC += 1;
    WriteCC += 1;
    // bit extention and write back
    EBCC += 1;
    // AND bit with B
    AndCC += 1;
    // subtract Q/2 from B （B + (- Q/2)）to get b
    AndCC += BitW; 
    XorCC += BitW;
    LeftShiftInst += BitW - 1;
    LeftShift += BitW - 1;
  }
}

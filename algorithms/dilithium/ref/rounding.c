#include <stdint.h>
#include "params.h"
#include "rounding.h"

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
extern int CoreCycle;

#define BitW 32

/*************************************************
* Name:        power2round
*
* Description: For finite field element a, compute a0, a1 such that
*              a mod^+ Q = a1*2^D + a0 with -2^{D-1} < a0 <= 2^{D-1}.
*              Assumes a to be standard representative.
*
* Arguments:   - int32_t a: input element
*              - int32_t *a0: pointer to output element a0
*
* Returns a1.
**************************************************/
int32_t power2round(int32_t *a0, int32_t a)  {
  int32_t a1;

  a1 = (a + (1 << (D-1)) - 1) >> D;
  // a + (1 << (D - 1))
  AndCC += 1;
  XorCC += 1;
  AndCC += 20 - 1; 
  XorCC += 20 - 1;
  LeftShiftInst += 20 - 1;
  LeftShift += 20 - 1;
  // a + (1 << (D - 1)) - 1
  AndCC += 1;
  XorCC += 1;
  AndCC += BitW - 1; 
  XorCC += BitW - 1;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // >> D
  RightShiftInst += 1;
  RightShift += D;

  *a0 = a - (a1 << D);
  // a1 << D
  LeftShiftInst += 1;
  LeftShift += D;
  // - (a1 << D)
  NotCC += 1;
  AndCC += 1;
  XorCC += 1;
  AndCC += BitW - 1; 
  XorCC += BitW - 1;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // a - (a1 << D)
  AndCC += 1;
  XorCC += 1;
  AndCC += BitW - 1; 
  XorCC += BitW - 1;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;

  return a1;
}

/*************************************************
* Name:        decompose
*
* Description: For finite field element a, compute high and low bits a0, a1 such
*              that a mod^+ Q = a1*ALPHA + a0 with -ALPHA/2 < a0 <= ALPHA/2 except
*              if a1 = (Q-1)/ALPHA where we set a1 = 0 and
*              -ALPHA/2 <= a0 = a mod^+ Q - Q < 0. Assumes a to be standard
*              representative.
*
* Arguments:   - int32_t a: input element
*              - int32_t *a0: pointer to output element a0
*
* Returns a1.
**************************************************/
int32_t decompose(int32_t *a0, int32_t a) {
  int32_t a1;

  a1  = (a + 127) >> 7;
  // a + 127
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // >> 7
  RightShiftInst += 1;
  RightShift += 7;
#if GAMMA2 == (Q-1)/32
  a1  = (a1*1025 + (1 << 21)) >> 22;
  a1 &= 15;
  // a1*1025
  LeftShiftInst += 1;
  LeftShift += 10;
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // + (1 << 21)
  AndCC += 11; 
  XorCC += 11;
  LeftShiftInst += 11 - 1;
  LeftShift += 11 - 1;
  // >> 22
  RightShiftInst += 1;
  RightShift += 22;
  // & 15
  AndCC += 1;
  // a1 * (2 * GAMMA2)
  LeftShiftInst += 10;
  LeftShift += 9 + 1 * 9;
  AndCC += 22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13;
  XorCC += 22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13;
  LeftShiftInst += (22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13 - 1 * 9);
  LeftShift += (22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13 - 1 * 9);
  // - (a1 * (2 * GAMMA2))
  NotCC += 1;
  AndCC += BitW;
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // a - (a1 * (2 * GAMMA2))
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;

#elif GAMMA2 == (Q-1)/88
  a1  = (a1*11275 + (1 << 23)) >> 24;
  a1 ^= ((43 - a1) >> 31) & a1;
  // a1*11275
  LeftShiftInst += 5;
  LeftShift += 1 + 2 + 7 + 1 + 2;
  AndCC += BitW * 5;
  XorCC += BitW * 5;
  LeftShiftInst += (BitW - 1) * 5;
  LeftShift += (BitW - 1) * 5;
  // + (1 << 23)
  AndCC += 9;
  XorCC += 9;
  LeftShiftInst += (9 - 1);
  LeftShift += (9 - 1);
  // >> 24
  RightShiftInst += 1;
  RightShift += 24;
  // - ai
  NotCC += 1;
  AndCC += BitW;
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // 43 + (-ai)
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // >> 31
  RightShiftInst += 1;
  RightShift += 31;
  // & ai
  AndCC += 1;
  // ^ ai
  XorCC += 1;
  // a1 * (2 * GAMMA2)
  LeftShiftInst += 10;
  LeftShift += 10;
  LeftShiftInst += 1;
  LeftShift += 1;
  AndCC += 22; 
  XorCC += 22;
  LeftShiftInst += (22 - 1);
  LeftShift += (22 - 1);
  LeftShiftInst += 2;
  LeftShift += 2;
  AndCC += 20; 
  XorCC += 20;
  LeftShiftInst += (20 - 1);
  LeftShift += (20 - 1);
  LeftShiftInst += 1;
  LeftShift += 1;
  AndCC += 19; 
  XorCC += 19;
  LeftShiftInst += (19 - 1);
  LeftShift += (19 - 1);
  LeftShiftInst += 1;
  LeftShift += 1;
  AndCC += 18; 
  XorCC += 18;
  LeftShiftInst += (18 - 1);
  LeftShift += (18 - 1);
  LeftShiftInst += 2;
  LeftShift += 2;
  AndCC += 16; 
  XorCC += 16;
  LeftShiftInst += (16 - 1);
  LeftShift += (16 - 1);
  // - (a1 * (2 * GAMMA2))
  NotCC += 1;
  AndCC += BitW;
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // a - (a1 * (2 * GAMMA2))
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
#endif

  *a0  = a - a1*2*GAMMA2;
  *a0 -= (((Q-1)/2 - *a0) >> 31) & Q;
  // - *a0
  NotCC += 1;
  AndCC += BitW;
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // (Q - 1) / 2 - *a0
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // >> 31
  RightShiftInst += 1;
  RightShift += 31;
  // & Q
  AndCC += 1;
  // -
  NotCC += 1;
  AndCC += BitW;
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // *a0 -=
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  return a1;
}

/*************************************************
* Name:        make_hint
*
* Description: Compute hint bit indicating whether the low bits of the
*              input element overflow into the high bits.
*
* Arguments:   - int32_t a0: low bits of input element
*              - int32_t a1: high bits of input element
*
* Returns 1 if overflow.
**************************************************/
unsigned int make_hint(int32_t a0, int32_t a1) {
  if(a0 > GAMMA2 || a0 < -GAMMA2 || (a0 == -GAMMA2 && a1 != 0))
    return 1;
  CoreCycle += 7;  

  return 0;
}

/*************************************************
* Name:        use_hint
*
* Description: Correct high bits according to hint.
*
* Arguments:   - int32_t a: input element
*              - unsigned int hint: hint bit
*
* Returns corrected high bits.
**************************************************/
int32_t use_hint(int32_t a, unsigned int hint) {
  int32_t a0, a1;

  a1 = decompose(&a0, a);
  if(hint == 0)
    return a1;
  CoreCycle += 1;

#if GAMMA2 == (Q-1)/32
  if(a0 > 0)
    return (a1 + 1) & 15;
  else
    return (a1 - 1) & 15;
  CoreCycle += 3;
#elif GAMMA2 == (Q-1)/88
  if(a0 > 0)
    return (a1 == 43) ?  0 : a1 + 1;
  else
    return (a1 ==  0) ? 43 : a1 - 1;
  CoreCycle += 3;
#endif
}

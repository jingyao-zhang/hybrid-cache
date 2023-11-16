#include <stdint.h>
#include "params.h"
#include "rounding.h"

extern int ReadCC;
extern int WriteCC;
extern int LeftShiftInst;
extern int RightShiftInst;
extern int LeftShift;
extern int RightShift;
extern int ActCC;
extern int OrCC;
extern int AndCC;
extern int XorCC;
extern int NotCC;
extern int CoreCycle;
extern int EBCC;
extern int CoreCycle;

extern void ReadCC_counter(int);
extern void WriteCC_counter(int);
extern void LeftShift_counter(int, int);
extern void RightShift_counter(int, int);
extern void OrCC_counter(int);
extern void AndCC_counter(int);
extern void XorCC_counter(int);
extern void NotCC_counter(int);
extern void EBCC_counter(int);

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
  AndCC_counter(1);
  XorCC_counter(1);
  AndCC_counter(20 - 1);
  XorCC_counter(20 - 1);
  LeftShift_counter(20 - 1, 1);
  // a + (1 << (D - 1)) - 1
  AndCC_counter(1);
  XorCC_counter(1);
  AndCC_counter(BitW - 1);
  XorCC_counter(BitW - 1);
  LeftShift_counter(BitW - 1, 1);
  // >> D
  RightShift_counter(1, D);

  *a0 = a - (a1 << D);
  // a1 << D
  LeftShift_counter(1, D);
  // - (a1 << D)
  NotCC_counter(1);
  AndCC_counter(1);
  XorCC_counter(1);
  AndCC_counter(BitW - 1);
  XorCC_counter(BitW - 1);
  LeftShift_counter(BitW - 1, 1);
  // a - (a1 << D)
  AndCC_counter(1);
  XorCC_counter(1);
  AndCC_counter(BitW - 1);
  XorCC_counter(BitW - 1);
  LeftShift_counter(BitW - 1, 1);

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
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // >> 7
  RightShift_counter(1, 7);
#if GAMMA2 == (Q-1)/32
  a1  = (a1*1025 + (1 << 21)) >> 22;
  a1 &= 15;
  // a1*1025
  LeftShift_counter(1, 10);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // + (1 << 21)
  AndCC_counter(11);
  XorCC_counter(11);
  LeftShift_counter(10, 1);
  // >> 22
  RightShift_counter(1, 22);
  // & 15
  AndCC_counter(1);
  // a1 * (2 * GAMMA2)
  LeftShift_counter(1, 9);
  LeftShift_counter(9, 1);
  AndCC_counter(22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13);
  XorCC_counter(22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13);
  LeftShift_counter(22 + 21 + 19 + 18 + 17 + 16 + 15 + 14 + 13 - 1 * 9, 1);
  // - (a1 * (2 * GAMMA2))
  NotCC_counter(1);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // a - (a1 * (2 * GAMMA2))
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);

#elif GAMMA2 == (Q-1)/88
  a1  = (a1*11275 + (1 << 23)) >> 24;
  a1 ^= ((43 - a1) >> 31) & a1;
  // a1*11275
  LeftShift_counter(1, 1);
  LeftShift_counter(1, 2);
  LeftShift_counter(1, 7);
  LeftShift_counter(1, 1);
  LeftShift_counter(1, 2);
  AndCC_counter(BitW*5);
  XorCC_counter(BitW*5);
  LeftShift_counter((BitW-1)*5, 1);
  // + (1 << 23)
  AndCC_counter(9);
  XorCC_counter(9);
  LeftShift_counter(8, 1);
  // >> 24
  RightShift_counter(1, 24);
  // - ai
  NotCC_counter(1);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // 43 + (-ai)
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // >> 31
  RightShift_counter(1, 31);
  // & ai
  AndCC_counter(1);
  // ^ ai
  XorCC_counter(1);
  // a1 * (2 * GAMMA2)
  LeftShift_counter(10, 1);
  LeftShift_counter(1, 1);
  AndCC_counter(22);
  XorCC_counter(22);
  LeftShift_counter(21, 1);
  LeftShift_counter(2, 1);

  AndCC_counter(20);
  XorCC_counter(20);
  LeftShift_counter(19, 1); 
  LeftShift_counter(1, 1);

  AndCC_counter(19);
  XorCC_counter(19);
  LeftShift_counter(18, 1);
  LeftShift_counter(1, 1);

  AndCC_counter(18);
  XorCC_counter(18);
  LeftShift_counter(17, 1);
  LeftShift_counter(2, 1);

  AndCC_counter(16);
  XorCC_counter(16);
  LeftShift_counter(15, 1);
  // - (a1 * (2 * GAMMA2))
  NotCC_counter(1);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // a - (a1 * (2 * GAMMA2))
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
#endif

  *a0  = a - a1*2*GAMMA2;
  *a0 -= (((Q-1)/2 - *a0) >> 31) & Q;
  // - *a0
  NotCC_counter(1);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // (Q - 1) / 2 - *a0
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // >> 31
  RightShift_counter(1, 31);
  // & Q
  AndCC_counter(1);
  // -
  NotCC_counter(1);
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);
  // *a0 -=
  AndCC_counter(BitW);
  XorCC_counter(BitW);
  LeftShift_counter(BitW-1, 1);

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

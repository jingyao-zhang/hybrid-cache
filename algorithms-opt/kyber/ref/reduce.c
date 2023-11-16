#include <stdint.h>
#include "params.h"
#include "reduce.h"

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

extern void ReadCC_counter(int);
extern void WriteCC_counter(int);
extern void LeftShift_counter(int, int);
extern void RightShift_counter(int, int);
extern void OrCC_counter(int);
extern void AndCC_counter(int);
extern void XorCC_counter(int);
extern void NotCC_counter(int);
extern void EBCC_counter(int);

#define BitW 16

/*************************************************
* Name:        montgomery_reduce
*
* Description: Montgomery reduction; given a 32-bit integer a, computes
*              16-bit integer congruent to a * R^-1 mod q, where R=2^16
*
* Arguments:   - int32_t a: input integer to be reduced;
*                           has to be in {-q2^15,...,q2^15-1}
*
* Returns:     integer in {-q+1,...,q-1} congruent to a * R^-1 modulo q.
**************************************************/
int16_t montgomery_reduce(int32_t a)
{
  int16_t t;

  t = (int16_t)a*QINV;
  t = (a - (int32_t)t*KYBER_Q) >> 16;
  return t;
}

/*************************************************
* Name:        barrett_reduce
*
* Description: Barrett reduction; given a 16-bit integer a, computes
*              centered representative congruent to a mod q in {-(q-1)/2,...,(q-1)/2}
*
* Arguments:   - int16_t a: input integer to be reduced
*
* Returns:     integer in {-(q-1)/2,...,(q-1)/2} congruent to a modulo q.
**************************************************/
int16_t barrett_reduce(int16_t a) {
  int16_t t;
  const int16_t v = ((1<<26) + KYBER_Q/2)/KYBER_Q;

  t  = ((int32_t)v*a + (1<<25)) >> 26;
  t *= KYBER_Q;
  // write to a fixed row
  ReadCC_counter(1);
  WriteCC_counter(1);
  EBCC_counter(1);
  AndCC_counter(1);
  // add B with q (Q or 0)
  LeftShift_counter(BitW-1, 1);
  AndCC_counter(BitW-1);
  XorCC_counter(BitW);
  // montgomery multiplication data from bit-parallel_mont_mult/kyber_mont_mult.cpp
  ReadCC += 16;
  WriteCC += 227;
  LeftShiftInst += 16;
  RightShiftInst += 16;
  ActCC += 163;
  OrCC += 17;
  AndCC += 81;
  XorCC += 65;
  NotCC += 0;
  EBCC += 16;
  // subtract Q/2 from B （B + (- Q/2)）to get b
  LeftShift_counter(BitW-1, 1);
  AndCC_counter(BitW-1);
  XorCC_counter(BitW);
  // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
  ReadCC_counter(1);
  WriteCC_counter(1);
  EBCC_counter(1);
  AndCC_counter(1);
  // add B with q (-Q/2 or 0)
  LeftShift_counter(BitW-1, 1);
  AndCC_counter(BitW-1);
  XorCC_counter(BitW);

  // - t
  NotCC_counter(1);
  LeftShift_counter(BitW-1, 1);
  AndCC_counter(BitW-1);
  XorCC_counter(BitW);
  // a + (- t)
  LeftShift_counter(BitW-1, 1);
  AndCC_counter(BitW-1);
  XorCC_counter(BitW);

  return a - t;
}

#include <stdint.h>
#include "params.h"
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
extern int CoreCycle;
extern int EBCC;

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
  ReadCC += 1;
  WriteCC += 1;
  // bit extention and write back
  EBCC += 1;
  // AND bit with B
  AndCC += 1;
  // add B with q (Q or 0)
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // montgomery multiplication data from bit-parallel_mont_mult/kyber_mont_mult.cpp
  ReadCC += 16;
  WriteCC += 16;
  LeftShiftInst += 16;
  LeftShift += 16;
  RightShiftInst += 16;
  RightShift += 16;
  OrCC += 17;
  AndCC += 81;
  XorCC += 65;
  NotCC += 0;
  EBCC += 16;
  // subtract Q/2 from B （B + (- Q/2)）to get b
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;
  // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
  // extend MSB of b
  // write to a fixed row
  ReadCC += 1;
  WriteCC += 1;
  // bit extention and write back
  EBCC += 1;
  // AND bit with B
  AndCC += 1;
  // add B with q (-Q/2 or 0)
  AndCC += BitW; 
  XorCC += BitW;
  LeftShiftInst += BitW - 1;
  LeftShift += BitW - 1;


  // // t = ((int32_t)v*a + (1<<25)) >> 26;
  // AndCC += 31 + 30 + 29 + 29 + 27 + 25 + 23 + 22 + 21 + 18;
  // XorCC += 31 + 30 + 29 + 29 + 27 + 25 + 23 + 22 + 21 + 18;
  // LeftShiftInst += (31 + 30 + 29 + 29 + 27 + 25 + 23 + 22 + 21 + 18 - 1 * 10);
  // LeftShift += (31 + 30 + 29 + 29 + 27 + 25 + 23 + 22 + 21 + 18 - 1 * 10);
  // AndCC += 7;
  // XorCC += 7;
  // LeftShiftInst += (7 - 1);
  // LeftShift += (7 - 1);
  // RightShiftInst += 1;
  // RightShift += 26;
  // AndCC += 8 + 6 + 5;
  // XorCC += 8 + 6 + 5;
  // LeftShiftInst += (8 + 6 + 5 - 1 * 3);
  // LeftShift += (8 + 6 + 5 - 1 * 3);
  
  // NotCC += 1;
  // AndCC += BitW;
  // XorCC += BitW;
  // LeftShiftInst += (BitW - 1);
  // LeftShift += (BitW - 1);
  // // a + (- t)
  // AndCC += BitW;
  // XorCC += BitW;
  // LeftShiftInst += (BitW - 1);
  // LeftShift += (BitW - 1);
  return a - t;
}

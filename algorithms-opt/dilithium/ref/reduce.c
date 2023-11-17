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
* Name:        montgomery_reduce
*
* Description: For finite field element a with -2^{31}Q <= a <= Q*2^31,
*              compute r \equiv a*2^{-32} (mod Q) such that -Q < r < Q.
*
* Arguments:   - int64_t: finite field element a
*
* Returns r.
**************************************************/
int32_t montgomery_reduce(int64_t a) {
  int32_t t;

  t = (int64_t)(int32_t)a*QINV;
  t = (a - (int64_t)t*Q) >> 32;
  return t;
}

/*************************************************
* Name:        reduce32
*
* Description: For finite field element a with a <= 2^{31} - 2^{22} - 1,
*              compute r \equiv a (mod Q) such that -6283009 <= r <= 6283007.
*
* Arguments:   - int32_t: finite field element a
*
* Returns r.
**************************************************/
int32_t reduce32(int32_t a) {
  int32_t t;

  t = (a + (1 << 22)) >> 23;
  t = a - t*Q;
  // montgomery multiplication data from kernels/NTT/Montgomery_Mul_Dilithium_Fixed_R
  ReadCC += 32;
  WriteCC += 451;
  LeftShiftInst += 32;
  RightShiftInst += 32;
  ActCC += 323;
  OrCC += 33;
  AndCC += 161;
  XorCC += 129;
  NotCC += 0;
  EBCC += 32;

  // subtract Q/2 from B （B + (- Q/2)）to get b
  ReadCC_counter(1);
  WriteCC_counter(1);
  // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
  ReadCC_counter(1);
  WriteCC_counter(1);
  EBCC_counter(1);
  AndCC_counter(1);
  // add B with q (-Q/2 or 0)
  ReadCC_counter(1);
  WriteCC_counter(1);

  return t;
}

/*************************************************
* Name:        caddq
*
* Description: Add Q if input coefficient is negative.
*
* Arguments:   - int32_t: finite field element a
*
* Returns r.
**************************************************/
int32_t caddq(int32_t a) {
  a += (a >> 31) & Q;
  ReadCC_counter(1);
  WriteCC_counter(1);
  EBCC_counter(1);
  AndCC_counter(1);
  // add B with q (Q or 0)
  ReadCC_counter(1);
  WriteCC_counter(1);
  
  return a;
}

/*************************************************
* Name:        freeze
*
* Description: For finite field element a, compute standard
*              representative r = a mod^+ Q.
*
* Arguments:   - int32_t: finite field element a
*
* Returns r.
**************************************************/
int32_t freeze(int32_t a) {
  a = reduce32(a);
  a = caddq(a);
  return a;
}

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
  // +
  // AndCC += 10; 
  // XorCC += 10;
  // LeftShiftInst += (10 - 1);
  // LeftShift += (10 - 1);
  // // >> 23
  // RightShiftInst += 1;
  // RightShift += 23;

  t = a - t*Q;
  // t * Q = (23 x "0" + t[8:0]) * (9 x "0" + 10 x "1" + 12 x "0" + 1 x "1")
  // LeftShiftInst += 1;
  // LeftShift += 13;
  // XorCC += 1;
  // LeftShiftInst += (9 - 1) * 9;
  // LeftShift += (9 - 1) * 9;
  // XorCC += (9 - 1) * 9;
  // AndCC += (9 - 1) * 9;
  // // -
  // NotCC += 1;
  // AndCC += BitW; 
  // XorCC += BitW;
  // LeftShiftInst += (BitW - 1);
  // LeftShift += (BitW - 1);
  // // + 
  // AndCC += BitW; 
  // XorCC += BitW;
  // LeftShiftInst += (BitW - 1);
  // LeftShift += (BitW - 1);

  ReadCC += 32;
  WriteCC += 32;
  LeftShiftInst += 32;
  LeftShift += 32;
  RightShiftInst += 32;
  RightShift += 32;
  OrCC += 33;
  AndCC += 161;
  XorCC += 129;
  NotCC += 0;
  EBCC += 32;

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

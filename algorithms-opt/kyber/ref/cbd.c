#include <stdint.h>
#include "params.h"
#include "cbd.h"

// extern int ReadCC;
// extern int WriteCC;
// extern int LeftShiftInst;
// extern int RightShiftInst;
// extern int LeftShift;
// extern int RightShift;
// extern int OrCC;
// extern int AndCC;
// extern int XorCC;
// extern int NotCC;
// extern int CoreCycle;

extern void ReadCC_counter(int);
extern void WriteCC_counter(int);
extern void LeftShift_counter(int, int);
extern void RightShift_counter(int, int);
extern void OrCC_counter(int);
extern void AndCC_counter(int);
extern void XorCC_counter(int);
extern void NotCC_counter(int);

#define BitW 16

/*************************************************
* Name:        load32_littleendian
*
* Description: load 4 bytes into a 32-bit integer
*              in little-endian order
*
* Arguments:   - const uint8_t *x: pointer to input byte array
*
* Returns 32-bit unsigned integer loaded from x
**************************************************/
static uint32_t load32_littleendian(const uint8_t x[4])
{
  uint32_t r;
  r  = (uint32_t)x[0];
  r |= (uint32_t)x[1] << 8;
  r |= (uint32_t)x[2] << 16;
  r |= (uint32_t)x[3] << 24;
  LeftShift_counter(1, 1);
  LeftShift_counter(1, 1);
  LeftShift_counter(1, 1);
  OrCC_counter(3);
  return r;
}

/*************************************************
* Name:        load24_littleendian
*
* Description: load 3 bytes into a 32-bit integer
*              in little-endian order.
*              This function is only needed for Kyber-512
*
* Arguments:   - const uint8_t *x: pointer to input byte array
*
* Returns 32-bit unsigned integer loaded from x (most significant byte is zero)
**************************************************/
#if KYBER_ETA1 == 3
static uint32_t load24_littleendian(const uint8_t x[3])
{
  uint32_t r;
  r  = (uint32_t)x[0];
  r |= (uint32_t)x[1] << 8;
  r |= (uint32_t)x[2] << 16;
  LeftShift_counter(1, 1);
  LeftShift_counter(1, 1);
  OrCC_counter(2);
  return r;
}
#endif


/*************************************************
* Name:        cbd2
*
* Description: Given an array of uniformly random bytes, compute
*              polynomial with coefficients distributed according to
*              a centered binomial distribution with parameter eta=2
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const uint8_t *buf: pointer to input byte array
**************************************************/
static void cbd2(poly *r, const uint8_t buf[2*KYBER_N/4])
{
  unsigned int i,j;
  uint32_t t,d;
  int16_t a,b;

  for(i=0;i<KYBER_N/8;i++) {
    t  = load32_littleendian(buf+4*i);
    d  = t & 0x55555555;
    d += (t>>1) & 0x55555555;
    AndCC_counter(2);
    RightShift_counter(1, 1);
    XorCC_counter(1);

    for(j=0;j<8;j++) {
      a = (d >> (4*j+0)) & 0x3;
      b = (d >> (4*j+2)) & 0x3;
      AndCC_counter(2);
      RightShift_counter(1, 1);
      RightShift_counter(1, 1);
      r->coeffs[8*i+j] = a - b;
      // -b
      NotCC_counter(1);
      ReadCC_counter(1);
      WriteCC_counter(1);
      // a - b
      ReadCC_counter(1);
      WriteCC_counter(1);
    }
  }
}

/*************************************************
* Name:        cbd3
*
* Description: Given an array of uniformly random bytes, compute
*              polynomial with coefficients distributed according to
*              a centered binomial distribution with parameter eta=3.
*              This function is only needed for Kyber-512
*
* Arguments:   - poly *r: pointer to output polynomial
*              - const uint8_t *buf: pointer to input byte array
**************************************************/
#if KYBER_ETA1 == 3
static void cbd3(poly *r, const uint8_t buf[3*KYBER_N/4])
{
  unsigned int i,j;
  uint32_t t,d;
  int16_t a,b;

  for(i=0;i<KYBER_N/4;i++) {
    t  = load24_littleendian(buf+3*i);
    d  = t & 0x00249249;
    d += (t>>1) & 0x00249249;
    d += (t>>2) & 0x00249249;
    AndCC_counter(3);
    RightShift_counter(1, 1);
    RightShift_counter(1, 1);
    XorCC_counter(2);

    for(j=0;j<4;j++) {
      a = (d >> (6*j+0)) & 0x7;
      b = (d >> (6*j+3)) & 0x7;
      AndCC_counter(2);
      RightShift_counter(1, 1);
      RightShift_counter(1, 1);
      r->coeffs[4*i+j] = a - b;
      // -b
      NotCC_counter(1);
      ReadCC_counter(1);
      WriteCC_counter(1);
      // a - b
      ReadCC_counter(1);
      WriteCC_counter(1);
    }
  }
}
#endif

void poly_cbd_eta1(poly *r, const uint8_t buf[KYBER_ETA1*KYBER_N/4])
{
#if KYBER_ETA1 == 2
  cbd2(r, buf);
#elif KYBER_ETA1 == 3
  cbd3(r, buf);
#else
#error "This implementation requires eta1 in {2,3}"
#endif
}

void poly_cbd_eta2(poly *r, const uint8_t buf[KYBER_ETA2*KYBER_N/4])
{
#if KYBER_ETA2 == 2
  cbd2(r, buf);
#else
#error "This implementation requires eta2 = 2"
#endif
}

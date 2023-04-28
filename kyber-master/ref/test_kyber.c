#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include "kem.h"
#include "randombytes.h"

#define NTESTS 1

int ReadCC = 0;
int WriteCC = 0;
int LeftShiftInst = 0;
int RightShiftInst = 0;
int LeftShift = 0;
int RightShift = 0;
int OrCC = 0;
int AndCC = 0;
int XorCC = 0;
int NotCC = 0;
int CoreCycle = 0;
int EBCC = 0;

static int test_keys()
{
  uint8_t pk[CRYPTO_PUBLICKEYBYTES];
  uint8_t sk[CRYPTO_SECRETKEYBYTES];
  uint8_t ct[CRYPTO_CIPHERTEXTBYTES];
  uint8_t key_a[CRYPTO_BYTES];
  uint8_t key_b[CRYPTO_BYTES];

  //Alice generates a public key
  crypto_kem_keypair(pk, sk);

  //Bob derives a secret key and creates a response
  crypto_kem_enc(ct, key_b, pk);

  //Alice uses Bobs response to get her shared key
  crypto_kem_dec(key_a, ct, sk);

  if(memcmp(key_a, key_b, CRYPTO_BYTES)) {
    printf("ERROR keys\n");
    return 1;
  }

  return 0;
}

static int test_invalid_sk_a()
{
  uint8_t pk[CRYPTO_PUBLICKEYBYTES];
  uint8_t sk[CRYPTO_SECRETKEYBYTES];
  uint8_t ct[CRYPTO_CIPHERTEXTBYTES];
  uint8_t key_a[CRYPTO_BYTES];
  uint8_t key_b[CRYPTO_BYTES];

  //Alice generates a public key
  crypto_kem_keypair(pk, sk);

  //Bob derives a secret key and creates a response
  crypto_kem_enc(ct, key_b, pk);

  //Replace secret key with random values
  randombytes(sk, CRYPTO_SECRETKEYBYTES);

  //Alice uses Bobs response to get her shared key
  crypto_kem_dec(key_a, ct, sk);

  if(!memcmp(key_a, key_b, CRYPTO_BYTES)) {
    printf("ERROR invalid sk\n");
    return 1;
  }

  return 0;
}

static int test_invalid_ciphertext()
{
  uint8_t pk[CRYPTO_PUBLICKEYBYTES];
  uint8_t sk[CRYPTO_SECRETKEYBYTES];
  uint8_t ct[CRYPTO_CIPHERTEXTBYTES];
  uint8_t key_a[CRYPTO_BYTES];
  uint8_t key_b[CRYPTO_BYTES];
  uint8_t b;
  size_t pos;

  do {
    randombytes(&b, sizeof(uint8_t));
  } while(!b);
  randombytes((uint8_t *)&pos, sizeof(size_t));

  //Alice generates a public key
  crypto_kem_keypair(pk, sk);

  //Bob derives a secret key and creates a response
  crypto_kem_enc(ct, key_b, pk);

  //Change some byte in the ciphertext (i.e., encapsulated key)
  ct[pos % CRYPTO_CIPHERTEXTBYTES] ^= b;

  //Alice uses Bobs response to get her shared key
  crypto_kem_dec(key_a, ct, sk);

  if(!memcmp(key_a, key_b, CRYPTO_BYTES)) {
    printf("ERROR invalid ciphertext\n");
    return 1;
  }

  return 0;
}

int main(void)
{
  unsigned int i;
  int r;

  for(i=0;i<NTESTS;i++) {
    r  = test_keys();
    // r |= test_invalid_sk_a();
    // r |= test_invalid_ciphertext();
    if(r)
      return 1;
  }

  printf("CRYPTO_SECRETKEYBYTES:  %d\n",CRYPTO_SECRETKEYBYTES);
  printf("CRYPTO_PUBLICKEYBYTES:  %d\n",CRYPTO_PUBLICKEYBYTES);
  printf("CRYPTO_CIPHERTEXTBYTES: %d\n",CRYPTO_CIPHERTEXTBYTES);

  printf("ReadCC += %d;\n", ReadCC);
    printf("WriteCC += %d;\n", WriteCC);
    printf("LeftShiftInst += %d;\n", LeftShiftInst);
    printf("LeftShift += %d;\n", LeftShift);
    printf("RightShiftInst += %d;\n", RightShiftInst);
    printf("RightShift += %d;\n", RightShift);
    printf("OrCC += %d;\n", OrCC);
    printf("AndCC += %d;\n", AndCC);
    printf("XorCC += %d;\n", XorCC);
    printf("NotCC += %d;\n", NotCC);
    printf("EBCC += %d;\n", EBCC);
    printf("Total = %d;\n", ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3); // 1 for operation, 1 for write

    printf("\nReadCC Cycle: %d\n", ReadCC);
    printf("WriteCC Cycle: %d\n", WriteCC);
    printf("LeftShift Cycle: %d\n", LeftShift + LeftShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    printf("RightShift Cycle: %d\n", RightShift + RightShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    printf("OrCC Cycle: %d\n", OrCC * (2 + 1)); // 1 for activate, 1 for or, 1 for write
    printf("AndCC Cycle: %d\n", AndCC * (2 + 1)); // 1 for activate, 1 for and, 1 for write
    printf("XorCC Cycle: %d\n", XorCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write
    printf("NotCC Cycle: %d\n", NotCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write. Not is implemented by Xoring a constant full of 1s.
    printf("EBCC Cycle: %d\n", EBCC); // 1 for bit extention and write back
    printf("Total Cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC); // If for shift, we can avoid the write back in the middle of shifting multiple bits, the total cycle will be improved by 30%.
    // LeftShift means the cycle number of left shifting, and the LeftShiftInst means the cycle number for writing the result back. One instruction means one write back. So the total cycle number is the sum of the two.
    // The reason why the total cycle number is high is that for each rotate shift, all the 64 bits are shifted while if rotate shifter is used, only the required bits are shifted.
  printf("CoreCycle: %d\n", CoreCycle);
  printf("Total CC Cycle + Core Cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC + CoreCycle);

  printf("\nTest End\n");

  return 0;
}

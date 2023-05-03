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
  printf("Total instruction = %d;\n", ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3);

  printf("\nReadCC Cycle: %d\n", ReadCC);
  printf("WriteCC Cycle: %d\n", WriteCC);
  printf("LeftShift Cycle: %d\n", LeftShift + LeftShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
  printf("RightShift Cycle: %d\n", RightShift + RightShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
  printf("OrCC Cycle: %d\n", OrCC * (2 + 1)); // 1 for activate, 1 for or, 1 for write
  printf("AndCC Cycle: %d\n", AndCC * (2 + 1)); // 1 for activate, 1 for and, 1 for write
  printf("XorCC Cycle: %d\n", XorCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write
  printf("NotCC Cycle: %d\n", NotCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write. NOT is implemented by Xoring a constant full of 1s.
  printf("EBCC Cycle: %d\n", EBCC); // 1 for bit extention and write back
  printf("Total Cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC); 

  printf("\nTest End\n");
  
  char filename[256];
    strcpy(filename, __FILE__);
    // Find the position of the last '.' in the filename
    char *pos = strrchr(filename, '.');
    if (pos != NULL) {
        // Replace everything after the '.' with ".txt"
        strcpy(pos, ".txt");
    } else {
        // If there's no '.', just append ".txt" to the end
        strcat(filename, ".txt");
    }

    FILE *outfile = fopen(filename, "w");
    if (outfile == NULL) {
        fprintf(stderr, "Failed to open file %s for writing.\n", filename);
        return 1;
    }

    // Write output to the file
    fprintf(outfile, "ReadCC += %d;\n", ReadCC);
    fprintf(outfile, "WriteCC += %d;\n", WriteCC);
    fprintf(outfile, "LeftShiftInst += %d;\n", LeftShiftInst);
    fprintf(outfile, "LeftShift += %d;\n", LeftShift);
    fprintf(outfile, "RightShiftInst += %d;\n", RightShiftInst);
    fprintf(outfile, "RightShift += %d;\n", RightShift);
    fprintf(outfile, "OrCC += %d;\n", OrCC);
    fprintf(outfile, "AndCC += %d;\n", AndCC);
    fprintf(outfile, "XorCC += %d;\n", XorCC);
    fprintf(outfile, "NotCC += %d;\n", NotCC);
    fprintf(outfile, "EBCC += %d;\n", EBCC);
    fprintf(outfile, "Total instruction = %d;\n", ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3);

    fprintf(outfile, "\nReadCC Cycle: %d\n", ReadCC);
    fprintf(outfile, "WriteCC Cycle: %d\n", WriteCC);
    fprintf(outfile, "LeftShift Cycle: %d\n", LeftShift + LeftShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    fprintf(outfile, "RightShift Cycle: %d\n", RightShift + RightShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    fprintf(outfile, "OrCC Cycle: %d\n", OrCC * (2 + 1)); // 1 for activate, 1 for or, 1 for write
    fprintf(outfile, "AndCC Cycle: %d\n", AndCC * (2 + 1)); // 1 for activate, 1 for and, 1 for write
    fprintf(outfile, "XorCC Cycle: %d\n", XorCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write
    fprintf(outfile, "NotCC Cycle: %d\n", NotCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write. NOT is implemented by Xoring a constant full of 1s.
    fprintf(outfile, "EBCC Cycle: %d\n", EBCC); // 1 for bit extention and write back
    fprintf(outfile, "Total Cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC);

    fclose(outfile);

  return 0;
}

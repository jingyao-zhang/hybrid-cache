#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include "kem.h"
#include "randombytes.h"

#define NTESTS 1

long int ReadCC = 0;
long int WriteCC = 0;
long int LeftShiftInst = 0;
long int RightShiftInst = 0;
long int LeftShift = 0;
long int RightShift = 0;
long int ActCC = 0;
long int OrCC = 0;
long int AndCC = 0;
long int XorCC = 0;
long int NotCC = 0;
long int EBCC = 0;
long int CoreCycle = 0;

void ReadCC_counter(int num){
  ReadCC += num;
  for (int i = 0; i < num; i++)
    printf("rd; ");
}

void WriteCC_counter(int num){
  WriteCC += num;
  for (int i = 0; i < num; i++)
    printf("wr; ");
}

void LeftShift_counter(int num, int bitnum){
  LeftShiftInst += num;
  LeftShift += num * bitnum;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("lsh %d; ", bitnum);
    printf("wr; ");
  }
}

void RightShift_counter(int num, int bitnum){
  RightShiftInst += num;
  RightShift += num * bitnum;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("rsh %d; ", bitnum);
    printf("wr; ");
  }
}

void OrCC_counter(int num){
  ActCC += num;
  OrCC += num;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("act; ");
    printf("or; ");
    printf("wr; ");
  }
}

void AndCC_counter(int num){
  ActCC += num;
  AndCC += num;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("act; ");
    printf("and; ");
    printf("wr; ");
  }
}

void XorCC_counter(int num){
  ActCC += num;
  XorCC += num;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("act; ");
    printf("xor; ");
    printf("wr; ");
  }
}

void NotCC_counter(int num){
  ActCC += num;
  NotCC += num;
  WriteCC += num;
  for (int i = 0; i < num; i++){
    printf("act; ");
    printf("not; ");
    printf("wr; ");
  }
}

void EBCC_counter(int num){
    EBCC += num;
    WriteCC += num;
    for (int i = 0; i < num; i++){
        printf("eb; ");
        printf("wr; ");
    }
}

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
  // Open the file for writing
  FILE *file = fopen("output.txt", "w");
  if (file == NULL) {
      printf("Error opening the file.\n");
      return 1;
  }

  // Redirect stdout to the file
  FILE *original_stdout = stdout;
  stdout = file;

  // Your code that prints to the terminal (now redirected to the file)
  // printf("This line will be written to the output.txt file.\n");
  
  unsigned int i;
  int r;

  for(i=0;i<NTESTS;i++) {
    r  = test_keys();
    // r |= test_invalid_sk_a();
    // r |= test_invalid_ciphertext();
    if(r)
      return 1;
  }

  // Restore stdout to its original value
  stdout = original_stdout;


  printf("\n\nReadCC: %ld\n", ReadCC);
  printf("WriteCC: %ld\n", WriteCC);
  printf("LeftShiftInst: %ld\n", LeftShiftInst);
  printf("RightShiftInst: %ld\n", RightShiftInst);
  printf("ActCC: %ld\n", ActCC);
  printf("OrCC: %ld\n", OrCC);
  printf("AndCC: %ld\n", AndCC);
  printf("XorCC: %ld\n", XorCC);
  printf("NotCC: %ld\n", NotCC);
  printf("EBCC: %ld\n", EBCC);
  printf("CoreCycle: %ld\n", CoreCycle);
  printf("Total instruction: %ld\n", ReadCC + WriteCC + LeftShiftInst + RightShiftInst + ActCC + OrCC + AndCC + XorCC + NotCC + EBCC);
  printf("Total cycle: %ld\n", ReadCC + WriteCC + LeftShift + RightShift + ActCC + OrCC + AndCC + XorCC + NotCC + EBCC + CoreCycle);

  
  // Close the file
  fclose(file);

  printf("Terminal output successfully written.\n");

  printf("\nTest end\n");

  return 0;
}

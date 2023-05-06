#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include "../randombytes.h"
#include "../sign.h"
#include <string.h>

#define MLEN 59
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

  long int total_min;
  long int total;
  for (int iter = 0; iter < 1; iter++){
    ReadCC = 0;
    WriteCC = 0;
    LeftShiftInst = 0;
    RightShiftInst = 0;
    LeftShift = 0;
    RightShift = 0;
    OrCC = 0;
    AndCC = 0;
    XorCC = 0;
    NotCC = 0;
    CoreCycle = 0;
    EBCC = 0;
    size_t i, j;
    int ret;
    size_t mlen, smlen;
    uint8_t b;
    uint8_t m[MLEN + CRYPTO_BYTES];
    uint8_t m2[MLEN + CRYPTO_BYTES];
    uint8_t sm[MLEN + CRYPTO_BYTES];
    uint8_t pk[CRYPTO_PUBLICKEYBYTES];
    uint8_t sk[CRYPTO_SECRETKEYBYTES];

    for(i = 0; i < NTESTS; ++i) {
      randombytes(m, MLEN);

      crypto_sign_keypair(pk, sk);
      crypto_sign(sm, &smlen, m, MLEN, sk);
      ret = crypto_sign_open(m2, &mlen, sm, smlen, pk);

      if(ret) {
        fprintf(stderr, "Verification failed\n");
        return -1;
      }
      if(smlen != MLEN + CRYPTO_BYTES) {
        fprintf(stderr, "Signed message lengths wrong\n");
        return -1;
      }
      if(mlen != MLEN) {
        fprintf(stderr, "Message lengths wrong\n");
        return -1;
      }
      for(j = 0; j < MLEN; ++j) {
        if(m2[j] != m[j]) {
          fprintf(stderr, "Messages don't match\n");
          return -1;
        }
      }

      randombytes((uint8_t *)&j, sizeof(j));
      do {
        randombytes(&b, 1);
      } while(!b);
      sm[j % (MLEN + CRYPTO_BYTES)] += b;
      ret = crypto_sign_open(m2, &mlen, sm, smlen, pk);
      if(!ret) {
        fprintf(stderr, "Trivial forgeries possible\n");
        return -1;
      }
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

}

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
long int OrCC = 0;
long int AndCC = 0;
long int XorCC = 0;
long int NotCC = 0;
long int CoreCycle = 0;
long int EBCC = 0;

int main(void)
{
  long int total_min;
  long int total;
  for (int iter = 0; iter < 100; iter++){
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

      printf("ReadCC += %ld;\n", ReadCC);
      printf("WriteCC += %ld;\n", WriteCC);
      printf("LeftShiftInst += %ld;\n", LeftShiftInst);
      printf("LeftShift += %ld;\n", LeftShift);
      printf("RightShiftInst += %ld;\n", RightShiftInst);
      printf("RightShift += %ld;\n", RightShift);
      printf("OrCC += %ld;\n", OrCC);
      printf("AndCC += %ld;\n", AndCC);
      printf("XorCC += %ld;\n", XorCC);
      printf("NotCC += %ld;\n", NotCC);
      printf("EBCC += %ld;\n", EBCC);
      printf("Total = %ld;\n", ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3); // 1 for operation, 1 for write

      printf("\nReadCC Cycle: %ld\n", ReadCC);
      printf("WriteCC Cycle: %ld\n", WriteCC);
      printf("LeftShift Cycle: %ld\n", LeftShift + LeftShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
      printf("RightShift Cycle: %ld\n", RightShift + RightShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
      printf("OrCC Cycle: %ld\n", OrCC * (2 + 1)); // 1 for activate, 1 for or, 1 for write
      printf("AndCC Cycle: %ld\n", AndCC * (2 + 1)); // 1 for activate, 1 for and, 1 for write
      printf("XorCC Cycle: %ld\n", XorCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write
      printf("NotCC Cycle: %ld\n", NotCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write. Not is implemented by Xoring a constant full of 1s.
      printf("EBCC Cycle: %ld\n", EBCC); // 1 for bit extention and write back
      printf("Total Cycle: %ld\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC); // If for shift, we can avoid the write back in the middle of shifting multiple bits, the total cycle will be improved by 30%.
      printf("CoreCycle: %ld\n", CoreCycle);
      printf("Total CC Cycle + Core Cycle: %ld\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC + CoreCycle);

  //   total = ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC + CoreCycle;
  //   // printf("Total CC Cycle + Core Cycle: %ld\n", total);
  //   if (iter == 0){
  //     total_min = total;
  //   }
  //   else if (total < total_min){
  //     total_min = total;
  //   }
  //   // total = 0;
  // }

  // printf("total_min: %ld\n", total_min);
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
    fprintf(outfile, "ReadCC += %ld;\n", ReadCC);
    fprintf(outfile, "WriteCC += %ld;\n", WriteCC);
    fprintf(outfile, "LeftShiftInst += %ld;\n", LeftShiftInst);
    fprintf(outfile, "LeftShift += %ld;\n", LeftShift);
    fprintf(outfile, "RightShiftInst += %ld;\n", RightShiftInst);
    fprintf(outfile, "RightShift += %ld;\n", RightShift);
    fprintf(outfile, "OrCC += %ld;\n", OrCC);
    fprintf(outfile, "AndCC += %ld;\n", AndCC);
    fprintf(outfile, "XorCC += %ld;\n", XorCC);
    fprintf(outfile, "NotCC += %ld;\n", NotCC);
    fprintf(outfile, "EBCC += %ld;\n", EBCC);
    fprintf(outfile, "Total instruction = %ld;\n", ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3);

    fprintf(outfile, "\nReadCC Cycle: %ld\n", ReadCC);
    fprintf(outfile, "WriteCC Cycle: %ld\n", WriteCC);
    fprintf(outfile, "LeftShift Cycle: %ld\n", LeftShift + LeftShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    fprintf(outfile, "RightShift Cycle: %ld\n", RightShift + RightShiftInst); // 1 for shift, 1 for write, no write back in the middle of the shifting
    fprintf(outfile, "OrCC Cycle: %ld\n", OrCC * (2 + 1)); // 1 for activate, 1 for or, 1 for write
    fprintf(outfile, "AndCC Cycle: %ld\n", AndCC * (2 + 1)); // 1 for activate, 1 for and, 1 for write
    fprintf(outfile, "XorCC Cycle: %ld\n", XorCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write
    fprintf(outfile, "NotCC Cycle: %ld\n", NotCC * (2 + 1)); // 1 for activate, 1 for xor, 1 for write. NOT is implemented by Xoring a constant full of 1s.
    fprintf(outfile, "EBCC Cycle: %ld\n", EBCC); // 1 for bit extention and write back
    fprintf(outfile, "CoreCycle: %ld\n", CoreCycle);
    fprintf(outfile, "Total Cycle: %ld\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC + CoreCycle);

    fclose(outfile);

  return 0;
}

}

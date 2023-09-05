#include "aes.h"

#include <stdio.h>
#include <string.h>

int ReadCC = 0;
int WriteCC = 0;
int LeftShiftInst = 0;
int RightShiftInst = 0;
int LeftShift = 0;
int RightShift = 0;
int ActCC = 0;
int OrCC = 0;
int AndCC = 0;
int XorCC = 0;
int NotCC = 0;

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

const unsigned char msg[48] = "The quick brown fox jumps over the lazy dog!!!!";
// const unsigned char msg[48] = {0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x0};

const unsigned char stream128[67] = {
  0x36, 0x88, 0x7b, 0x28, 0x99, 0x8f, 0x4d, 0x2b, 0x37, 0xff, 0x06, 0x63, 0xfc, 0x5c, 0xef, 0x2f, 
  0x43, 0xeb, 0xeb, 0x7e, 0xc1, 0x58, 0xe4, 0xb4, 0x27, 0x78, 0x2e, 0xa7, 0x90, 0x00, 0x09, 0x91, 
  0xcd, 0x0e, 0x40, 0x18, 0x8b, 0x2b, 0x52, 0x1e, 0x8d, 0xfb, 0x0e, 0x7b, 0x80, 0xe7, 0xb6, 0xd4, 
  0xba, 0x48, 0xf5, 0x19, 0xb4, 0xbf, 0xbf, 0xb1, 0x52, 0x6f, 0x12, 0xe2, 0x7b, 0x61, 0x90, 0x0d, 
  0x95, 0x83, 0x84};

const unsigned char stream192[67] = {
  0xb0, 0x13, 0x08, 0x01, 0xfa, 0x88, 0x28, 0x98, 0xac, 0x77, 0x72, 0xaf, 0x2a, 0x8d, 0x17, 0xf3, 
  0xba, 0x37, 0xd6, 0x8e, 0x01, 0x5b, 0x25, 0xb5, 0x51, 0x40, 0xf9, 0x55, 0x73, 0x89, 0xbe, 0xd3, 
  0x5f, 0x3c, 0xde, 0xc2, 0x6b, 0xf6, 0xfc, 0x26, 0x97, 0x22, 0xfa, 0x8e, 0xcb, 0x62, 0xe8, 0xa5, 
  0x03, 0xd2, 0x8a, 0x7e, 0xaf, 0xe3, 0xe5, 0x63, 0x2e, 0xb8, 0x48, 0x20, 0x1c, 0x48, 0xd5, 0xc2, 
  0x27, 0x1e, 0x1e};

const unsigned char stream256[67] = {
  0x12, 0x39, 0x28, 0xd0, 0xda, 0xd1, 0xfd, 0xe7, 0x64, 0x74, 0x10, 0x5a, 0x29, 0x17, 0x3c, 0x62, 
  0x05, 0xde, 0x4c, 0x98, 0x22, 0x9b, 0xad, 0x16, 0x32, 0x75, 0xbf, 0x26, 0xe5, 0x84, 0x7e, 0xc8, 
  0x4e, 0x73, 0x68, 0xce, 0x9a, 0x11, 0xb6, 0x55, 0x53, 0x05, 0x39, 0xa1, 0xa7, 0x1f, 0x16, 0x55, 
  0x4a, 0xd3, 0x6c, 0xc6, 0x2c, 0xb4, 0x55, 0x9f, 0x5f, 0xa3, 0xe8, 0x39, 0xfa, 0x9d, 0x96, 0xb6, 
  0xb7, 0xc9, 0xc5};

const unsigned char ct128[48] = {
0x10, 0xdc, 0x43, 0x2b, 0x15, 0x11, 0x81, 0x36, 0x3f, 0x00, 0x51, 0x74, 0x81, 0x7c, 0x22, 0x87, 
0x3a, 0x3b, 0xfe, 0xd7, 0xb9, 0xa6, 0xf2, 0x3c, 0x81, 0x00, 0x63, 0xef, 0xe5, 0xb8, 0xbd, 0x36, 
0x11, 0xcc, 0xc9, 0xdf, 0x2b, 0xea, 0xbc, 0xe6, 0x11, 0x1c, 0x34, 0x79, 0xf9, 0x6b, 0x47, 0x7b};

const unsigned char ct192[48] = {
0x63, 0xc6, 0xde, 0x28, 0x36, 0xb4, 0x29, 0xbf, 0xbe, 0x9d, 0x15, 0x8e, 0x83, 0x04, 0xa3, 0x18, 
0x34, 0x79, 0xe8, 0x02, 0x8a, 0x34, 0x50, 0x7c, 0xa9, 0x08, 0x48, 0x47, 0xee, 0x90, 0x79, 0x13, 
0x66, 0x2d, 0xa4, 0xf1, 0x3e, 0x8b, 0x76, 0xa9, 0x50, 0xf7, 0x6e, 0xa8, 0xbf, 0x29, 0xaf, 0x84};

const unsigned char ct256[48] = {
0xdb, 0xb5, 0x44, 0x70, 0x68, 0xe6, 0xad, 0x6a, 0x09, 0xdf, 0xa6, 0xef, 0x85, 0x73, 0xff, 0xc0, 
0xc2, 0x91, 0x38, 0xbd, 0xd7, 0xd0, 0x22, 0x7e, 0x79, 0x71, 0xa1, 0x98, 0x6f, 0xd5, 0x80, 0xa8, 
0x1e, 0x97, 0xd7, 0x6d, 0xd2, 0x6b, 0x0e, 0x7b, 0x79, 0x76, 0x75, 0x86, 0xa5, 0x2f, 0x76, 0x0b};

// const unsigned char key[AES256_KEYBYTES] = {
//   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 
//   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0};

const unsigned char key[AES256_KEYBYTES] = {
  0x66, 0xd9, 0xb7, 0x60, 0x0e, 0xda, 0xaa, 0x81, 0x42, 0xa2, 0xd6, 0x3d, 0x8f, 0x51, 0x6c, 0x6f, 
  0xb6, 0xdf, 0x5b, 0x97, 0xf3, 0xf1, 0xf7, 0x0e, 0xeb, 0xe0, 0x40, 0x4d, 0xc5, 0x24, 0xa1, 0xfa};
const unsigned char nonce[AESCTR_NONCEBYTES] = {
  0x9d, 0x2d, 0x3e, 0x6e, 0x48, 0x5c, 0xf6, 0x6b, 0xb2, 0xb9, 0x25, 0xf4};

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

  
  unsigned char ct[67];
  int r = 0;
  aes128ctx ctx128_ecb, ctx128_ctr;
  aes192ctx ctx192_ecb, ctx192_ctr;
  aes256ctx ctx256_ecb, ctx256_ctr;

  aes128_ecb_keyexp(&ctx128_ecb, key);
  // for (int i = 0; i < 48; i++){
  //   printf("%x ", msg[i]);
  // }
  // printf("\n");
  // for(int i = 0; i < 88; i++)
  //   printf("%lx ", ctx128_ecb.sk_exp[i]);
  // printf("size of ctx128_ecb: %d\n", sizeof(ctx128_ecb));
  // aes192_ecb_keyexp(&ctx192_ecb, key);
  // aes256_ecb_keyexp(&ctx256_ecb, key);
  // aes128_ctr_keyexp(&ctx128_ctr, key);
  // aes192_ctr_keyexp(&ctx192_ctr, key);
  // aes256_ctr_keyexp(&ctx256_ctr, key);

  // aes128_ctr(ct, 67, nonce, &ctx128_ctr);
  // if(memcmp(ct, stream128, 67)) {
  //   printf("ERROR AES128CTR output does not match test vector.\n");
  //   r = 1;
  // }

  // aes192_ctr(ct, 67, nonce, &ctx192_ctr);
  // if(memcmp(ct, stream192, 67)) {
  //   printf("ERROR AES192CTR output does not match test vector.\n");
  //   r = 1;
  // }

  // aes256_ctr(ct, 67, nonce, &ctx256_ctr);
  // if(memcmp(ct, stream256, 67)) {
  //   printf("ERROR AES256CTR output does not match test vector.\n");
  //   r = 1;
  // }


  aes128_ecb(ct, msg, sizeof(msg) / AES_BLOCKBYTES, &ctx128_ecb);
  if(memcmp(ct, ct128, 48)) {
    printf("ERROR AES128ECB output does not match test vector.\n");
    r = 1;
  }

  // aes192_ecb(ct, msg, sizeof(msg) / AES_BLOCKBYTES, &ctx192_ecb);
  // if(memcmp(ct, ct192, 48)) {
  //   printf("ERROR AES192ECB output does not match test vector.\n");
  //   r = 1;
  // }

  // aes256_ecb(ct, msg, sizeof(msg) / AES_BLOCKBYTES, &ctx256_ecb);
  // if(memcmp(ct, ct256, 48)) {
  //   printf("ERROR AES256ECB output does not match test vector.\n");
  //   r = 1;
  // }

  aes128_ctx_release(&ctx128_ecb);
  // aes192_ctx_release(&ctx192_ecb);
  // aes256_ctx_release(&ctx256_ecb);
  // aes128_ctx_release(&ctx128_ctr);
  // aes192_ctx_release(&ctx192_ctr);
  // aes256_ctx_release(&ctx256_ctr);

  printf("\n\nReadCC: %d\n", ReadCC);
  printf("WriteCC: %d\n", WriteCC);
  printf("LeftShiftInst: %d\n", LeftShiftInst);
  printf("RightShiftInst: %d\n", RightShiftInst);
  printf("ActCC: %d\n", ActCC);
  printf("OrCC: %d\n", OrCC);
  printf("AndCC: %d\n", AndCC);
  printf("XorCC: %d\n", XorCC);
  printf("NotCC: %d\n", NotCC);
  printf("Total instruction: %d\n", ReadCC + WriteCC + LeftShiftInst + RightShiftInst + ActCC + OrCC + AndCC + XorCC + NotCC); 
  printf("Total cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + ActCC + OrCC + AndCC + XorCC + NotCC);


  // Restore stdout to its original value
  stdout = original_stdout;

  // Close the file
  fclose(file);

  printf("Terminal output successfully written.\n");

  printf("\nAES test end\n");

  return r;
}

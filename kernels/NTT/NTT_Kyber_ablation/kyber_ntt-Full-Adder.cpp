#include <iostream>
#include <bitset>
#include "stdlib.h"
#include <math.h>
#include <fstream>
#include <iostream>
#include <string>

#define BitW 16
#define PolyO 256

#define Col     256
#define Row     256
#define N       256
#define Q       3329

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
int EBCC = 0;

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

int16_t zetas[128] = {
    -1044,  -758,  -359, -1517,  1493,  1422,   287,   202,
        -171,   622,  1577,   182,   962, -1202, -1474,  1468,
        573, -1325,   264,   383,  -829,  1458, -1602,  -130,
        -681,  1017,   732,   608, -1542,   411,  -205, -1571,
        1223,   652,  -552,  1015, -1293,  1491,  -282, -1544,
        516,    -8,  -320,  -666, -1618, -1162,   126,  1469,
        -853,   -90,  -271,   830,   107, -1421,  -247,  -951,
        -398,   961, -1508,  -725,   448, -1065,   677, -1275,
        -1103,   430,   555,   843, -1251,   871,  1550,   105,
        422,   587,   177,  -235,  -291,  -460,  1574,  1653,
        -246,   778,  1159,  -147,  -777,  1483,  -602,  1119,
        -1590,   644,  -872,   349,   418,   329,  -156,   -75,
        817,  1097,   603,   610,  1322, -1285, -1465,   384,
        -1215,  -136,  1218, -1335,  -874,   220, -1187, -1659,
        -1185, -1530, -1278,   794, -1510,  -854,  -870,   478,
        -108,  -308,   996,   991,   958, -1460,  1522,  1628
    };

__int128_t Mont_Mult(__int128_t A, __int128_t B, __int128_t M){
    __int128_t m = 0;

    __int128_t Carry = 0;
    __int128_t Sum = 0;

    __int128_t c1, s1, c2, s2, c3;

    

    std::string A_b = std::bitset<BitW>(A).to_string(); //to binary
    std::string B_b = std::bitset<BitW>(B).to_string();
    std::string M_b = std::bitset<BitW>(M).to_string();
    std::string c1_b, s1_b, c2_b, s2_b, c3_b, Carry_b, Sum_b;

    for(int i = 0; i < BitW; ++i){
        if(A_b[BitW-i-1] == '1'){
            c1 = Sum & B;
            s1 = Sum ^ B;
            Carry = Carry << 1 & (((__int128_t)1 << BitW) - 1);
            c2 = Carry & s1;
            Sum = Carry ^ s1;
            Carry = c1 | c2;

            AndCC_counter(2);
            XorCC_counter(2);
            LeftShift_counter(1, 1);
            OrCC_counter(1);
            
        }

        Sum_b = std::bitset<BitW>(Sum).to_string();
        if(Sum_b[BitW-1] == '1'){
            m = M;
        }
        else{
            m = 0;
        }

        ReadCC_counter(1);
        WriteCC_counter(1);
        EBCC_counter(1);
        AndCC_counter(1);


        c1 = Sum & m;
        s1 = Sum ^ m;

        s1 = (s1 & (((__int128_t)1 << BitW) - 1)) >> 1;
        
        c2 = s1 & c1;
        s2 = s1 ^ c1;
        c3 = Carry & s2;
        Sum = Carry ^ s2;
        Carry = c2 | c3;

        AndCC_counter(3);
        XorCC_counter(3);
        // ReadCC_counter(1);
        // WriteCC_counter(1);
        RightShift_counter(1, 1);
        OrCC_counter(1);

    }

    __int128_t P = 2*Carry + Sum;
    ReadCC_counter(1);
    WriteCC_counter(1);
    // LeftShift_counter(BitW-1, 1);
    // AndCC_counter(BitW-1);
    // XorCC_counter(BitW-1);


    if(P >= M){
        P = P - M;
    }

    return P;
}

int main()
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
    
    unsigned int len, start, j, k;
    int32_t zeta, t;
    __int128_t A, B;
    __int128_t M = Q; 

    for (int i = 0; i < 128; i++){
        if (zetas[i] < 0){
            zetas[i] += Q;
        }
    }

    k = 1;
    B = pow(2,BitW-1) - 1;
    for (len = 128; len >= 2; len >>= 1) {
        for (start = 0; start < 256; start = j + len) {
            zeta = zetas[k++];
            A = zeta;
            __int128_t A_R = A;
            for (j = start; j < start + len; j++) {
                ReadCC_counter(1);
                WriteCC_counter(1);
                EBCC_counter(1);
                AndCC_counter(1);
                // add B with q (Q or 0)
                // LeftShift_counter(BitW-1, 1);
                // AndCC_counter(BitW-1);
                // XorCC_counter(BitW);
                ReadCC_counter(1);
                WriteCC_counter(1);

                Mont_Mult(A_R, B, M);

                // subtract Q/2 from B （B + (- Q/2)）to get b
                // LeftShift_counter(BitW-1, 1);
                // AndCC_counter(BitW-1);
                // XorCC_counter(BitW);
                ReadCC_counter(1);
                WriteCC_counter(1);
                // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
                ReadCC_counter(1);
                WriteCC_counter(1);
                EBCC_counter(1);
                AndCC_counter(1);
                // add B with q (-Q/2 or 0)
                // LeftShift_counter(BitW-1, 1);
                // AndCC_counter(BitW-1);
                // XorCC_counter(BitW);
                ReadCC_counter(1);
                WriteCC_counter(1);
                // a[j + len] = a[j] - t;
                // LeftShift_counter(BitW-1, 1);
                // AndCC_counter(BitW-1);
                // XorCC_counter(BitW);
                ReadCC_counter(1);
                WriteCC_counter(1);
                // a[j] = a[j] + t;
                // LeftShift_counter(BitW-1, 1);
                // AndCC_counter(BitW-1);
                // XorCC_counter(BitW);
                ReadCC_counter(1);
                WriteCC_counter(1);
            }
        }
    }

    printf("\n\nReadCC: %d;\n", ReadCC);
    printf("WriteCC: %d;\n", WriteCC);
    printf("LeftShiftInst: %d;\n", LeftShiftInst);
    printf("RightShiftInst: %d;\n", RightShiftInst);
    printf("ActCC: %d;\n", ActCC);
    printf("OrCC: %d;\n", OrCC);
    printf("AndCC: %d;\n", AndCC);
    printf("XorCC: %d;\n", XorCC);
    printf("NotCC: %d;\n", NotCC);
    printf("EBCC: %d;\n", EBCC);
    printf("Total instruction: %d;\n", ReadCC + WriteCC + LeftShiftInst + RightShiftInst + ActCC + OrCC + AndCC + XorCC + NotCC + EBCC);
    printf("Total cycle: %d;\n", ReadCC + WriteCC + LeftShift + RightShift + ActCC + OrCC + AndCC + XorCC + NotCC + EBCC);

    // Restore stdout to its original value
    stdout = original_stdout;

    // Close the file
    fclose(file);

    printf("Terminal output successfully written.\n");

    printf("\nTest end\n");

    return 0;
}
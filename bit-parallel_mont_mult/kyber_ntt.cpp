#include <iostream>
#include <bitset>
#include "stdlib.h"
#include <math.h>


#define BitW 16
#define PolyO 256

// 28nm
// #define writeE  0.121
// #define readE   1.072

// 45nm SRAM
#define writeE  0.259
#define readE   2.184

//45nm ReRAM
// #define writeE  0.879
// #define readE   0.418

#define logicE  2.5*readE
#define bitshfE readE
#define checkE  2.5*readE
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
int OrCC = 0;
int AndCC = 0;
int XorCC = 0;
int NotCC = 0;
int EBCC = 0;

double cycleC = 0;
double energyE = 0;
double shiftC = 0;

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
    // __int128_t A = 6;
    // __int128_t B = 6;
    // __int128_t M = 7;
    __int128_t m = 0;

    __int128_t Carry = 0;
    __int128_t Sum = 0;

    __int128_t c1, s1, c2, s2, c3;

    

    std::string A_b = std::bitset<BitW>(A).to_string(); //to binary
    std::string B_b = std::bitset<BitW>(B).to_string();
    std::string M_b = std::bitset<BitW>(M).to_string();
    // std::cout << "\n";
    // std::cout<< "A = " << (unsigned)A << " = " << A_b<<"\n";
    // std::cout<< "B = " << (unsigned)B << " = " << B_b<<"\n";
    // std::cout<< "M = " << (unsigned)M << " = " << M_b<<"\n";
    std::string c1_b, s1_b, c2_b, s2_b, c3_b, Carry_b, Sum_b;
    // std::cout<<B_b<<"\n";

    // c1 = Sum & B;
    // s1 = Sum ^ B;
    // Carry = Carry << 1 & 0x07;
    // c2 = Carry & s1;
    // Sum = Carry ^ s1;
    // Carry = c1 | c2;


    // Carry_b = std::bitset<BitW>(Carry).to_string();
    // Sum_b = std::bitset<BitW>(Sum).to_string();
    // std::cout<< "Carry = " << Carry_b<<"\n";
    // std::cout<< "Sum = " << Sum_b<<"\n";
    // std::cout << A_b[2] << "\n";

    for(int i = 0; i < BitW; ++i){
        // std::cout << A_b[n-i-1] << "\n";
        if(A_b[BitW-i-1] == '1'){
            c1 = Sum & B;
            s1 = Sum ^ B;
            Carry = Carry << 1 & (((__int128_t)1 << BitW) - 1);
            c2 = Carry & s1;
            Sum = Carry ^ s1;
            Carry = c1 | c2;
            // Carry_b = std::bitset<BitW>(Carry).to_string();
            // Sum_b = std::bitset<BitW>(Sum).to_string();
            // std::cout<< "Carry = " << Carry_b<<"\n";
            // std::cout<< "Sum = " << Sum_b<<"\n\n";

            AndCC += 2;
            XorCC += 2;
            LeftShiftInst += 1;
            LeftShift += 1;
            OrCC += 1;

            cycleC += 6;
            energyE += 5 * logicE + 1 * bitshfE;
            shiftC += 1;
        }

        Sum_b = std::bitset<BitW>(Sum).to_string();
        if(Sum_b[BitW-1] == '1'){
            m = M;
        }
        else{
            m = 0;
        }

        // AndCC += 1; // get LSB
        // LeftShiftInst += BitW - 1; // propagate LSB flag
        // LeftShift += BitW - 1;
        // OrCC += BitW - 1;
        // AndCC += 1; // AND with M

        // If dedicated LSB control unit is used
        // write to a fixed row
        ReadCC += 1;
        WriteCC += 1;
        // bit extention and write back
        EBCC += 1;
        // AND bit with B
        AndCC += 1;

        cycleC += 1;
        energyE += checkE;

        c1 = Sum & m;
        s1 = Sum ^ m;
        // c1_b = std::bitset<BitW>(c1).to_string();
        // std::cout<< "c1 = " << c1_b<<"\n";
        // s1_b = std::bitset<BitW>(s1).to_string();
        // std::cout<< "s1 = " << s1_b<<"\n";

        s1 = (s1 & (((__int128_t)1 << BitW) - 1)) >> 1;
        // s1_b = std::bitset<BitW>(s1).to_string();
        // std::cout<< "s1 = " << s1_b<<"\n";
        
        c2 = s1 & c1;
        s2 = s1 ^ c1;
        // c2_b = std::bitset<BitW>(c2).to_string();
        // std::cout<< "c2 = " << c2_b<<"\n";
        // s2_b = std::bitset<BitW>(s2).to_string();
        // std::cout<< "s2 = " << s2_b<<"\n";
        c3 = Carry & s2;
        Sum = Carry ^ s2;
        Carry = c2 | c3;

        AndCC += 3;
        XorCC += 3;
        RightShiftInst += 1;
        RightShift += 1;
        OrCC += 1;
        
        cycleC += 8;
        energyE += 7 * logicE + 1 * bitshfE;
        shiftC += 1;
        // Carry_b = std::bitset<BitW>(Carry).to_string();
        // Sum_b = std::bitset<BitW>(Sum).to_string();
        // std::cout<< "After B Carry = " << Carry_b<<"\n";
        // std::cout<< "After B Sum = " << Sum_b<<"\n\n";

        // else{
        //     s1 = Sum >> 1;
        //     c1 = Carry;
        //     Carry = s1 & c1;
        //     Sum = s1 ^ c1;
        // }

    }

    // Carry_b = std::bitset<BitW>(Carry).to_string();
    // Sum_b = std::bitset<BitW>(Sum).to_string();
    // std::cout<< "Carry = " << Carry_b<<"\n";
    // std::cout<< "Sum = " << Sum_b<<"\n";

    __int128_t P = 2*Carry + Sum;
    LeftShiftInst += BitW - 1;
    LeftShift += BitW - 1;
    AndCC += BitW - 1;
    XorCC += BitW - 1;

    cycleC = cycleC + (BitW - 1) * 3;
    energyE = energyE + (BitW - 1) * (1 * bitshfE + 2 * logicE);
    shiftC = shiftC + (BitW - 1) * 1;

    if(P >= M){
        P = P - M;
    }

    return P;
}

int main()
{
    unsigned int len, start, j, k;
    int32_t zeta, t;
    __int128_t A, B;
    __int128_t M = Q; 

    for (int i = 0; i < 128; i++){
        if (zetas[i] < 0){
            zetas[i] += Q;
        }
        // printf("%d, ", zetas[i]);
    }

    k = 1;
    B = pow(2,BitW-1) - 1;
    for (len = 128; len >= 2; len >>= 1) {
        for (start = 0; start < 256; start = j + len) {
            zeta = zetas[k++];
            A = zeta;
            __int128_t A_R = A;
            for (j = start; j < start + len; j++) {
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
                t = Mont_Mult(A_R, B, M);
                // subtract Q/2 from B （B + (- Q/2)）to get b
                AndCC += BitW; 
                XorCC += BitW;
                LeftShiftInst += BitW - 1;
                LeftShift += BitW - 1;
                // check MSB of b, if 1, then choose B (AND B with 1s), if 0, then choose b (AND b with 1s)
                // extend MSB of b
                // write to a fixed row
                ReadCC += 1;
                WriteCC += 1;
                // bit extention and write back
                EBCC += 1;
                // AND bit with B
                AndCC += 1;
                // add B with q (-Q/2 or 0)
                AndCC += BitW; 
                XorCC += BitW;
                LeftShiftInst += BitW - 1;
                LeftShift += BitW - 1;
                // a[j + len] = a[j] - t;
                AndCC += BitW; 
                XorCC += BitW;
                LeftShiftInst += BitW - 1;
                LeftShift += BitW - 1;
                // a[j] = a[j] + t;
                AndCC += BitW; 
                XorCC += BitW;
                LeftShiftInst += BitW - 1;
                LeftShift += BitW - 1;
            }
        }
    }

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
    printf("Total Cycle: %d\n", ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC);

    return 0;
}
#include <iostream>
#include <bitset>
#include "stdlib.h"
#include <math.h>


#define BitW 32
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
#define Q       8380417

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

int32_t zetas[N] = {
         0,    25847, -2608894,  -518909,   237124,  -777960,  -876248,   466468,
   1826347,  2353451,  -359251, -2091905,  3119733, -2884855,  3111497,  2680103,
   2725464,  1024112, -1079900,  3585928,  -549488, -1119584,  2619752, -2108549,
  -2118186, -3859737, -1399561, -3277672,  1757237,   -19422,  4010497,   280005,
   2706023,    95776,  3077325,  3530437, -1661693, -3592148, -2537516,  3915439,
  -3861115, -3043716,  3574422, -2867647,  3539968,  -300467,  2348700,  -539299,
  -1699267, -1643818,  3505694, -3821735,  3507263, -2140649, -1600420,  3699596,
    811944,   531354,   954230,  3881043,  3900724, -2556880,  2071892, -2797779,
  -3930395, -1528703, -3677745, -3041255, -1452451,  3475950,  2176455, -1585221,
  -1257611,  1939314, -4083598, -1000202, -3190144, -3157330, -3632928,   126922,
   3412210,  -983419,  2147896,  2715295, -2967645, -3693493,  -411027, -2477047,
   -671102, -1228525,   -22981, -1308169,  -381987,  1349076,  1852771, -1430430,
  -3343383,   264944,   508951,  3097992,    44288, -1100098,   904516,  3958618,
  -3724342,    -8578,  1653064, -3249728,  2389356,  -210977,   759969, -1316856,
    189548, -3553272,  3159746, -1851402, -2409325,  -177440,  1315589,  1341330,
   1285669, -1584928,  -812732, -1439742, -3019102, -3881060, -3628969,  3839961,
   2091667,  3407706,  2316500,  3817976, -3342478,  2244091, -2446433, -3562462,
    266997,  2434439, -1235728,  3513181, -3520352, -3759364, -1197226, -3193378,
    900702,  1859098,   909542,   819034,   495491, -1613174,   -43260,  -522500,
   -655327, -3122442,  2031748,  3207046, -3556995,  -525098,  -768622, -3595838,
    342297,   286988, -2437823,  4108315,  3437287, -3342277,  1735879,   203044,
   2842341,  2691481, -2590150,  1265009,  4055324,  1247620,  2486353,  1595974,
  -3767016,  1250494,  2635921, -3548272, -2994039,  1869119,  1903435, -1050970,
  -1333058,  1237275, -3318210, -1430225,  -451100,  1312455,  3306115, -1962642,
  -1279661,  1917081, -2546312, -1374803,  1500165,   777191,  2235880,  3406031,
   -542412, -2831860, -1671176, -1846953, -2584293, -3724270,   594136, -3776993,
  -2013608,  2432395,  2454455,  -164721,  1957272,  3369112,   185531, -1207385,
  -3183426,   162844,  1616392,  3014001,   810149,  1652634, -3694233, -1799107,
  -3038916,  3523897,  3866901,   269760,  2213111,  -975884,  1717735,   472078,
   -426683,  1723600, -1803090,  1910376, -1667432, -1104333,  -260646, -3833893,
  -2939036, -2235985,  -420899, -2286327,   183443,  -976891,  1612842, -3545687,
   -554416,  3919660,   -48306, -1362209,  3937738,  1400424,  -846154,  1976782
};

__int128_t Mont_Mult(__int128_t A, __int128_t B, __int128_t M){
    // __int128_t A = 6;
    // __int128_t B = 6;
    // __int128_t M = 7;
    __int128_t m = 0;
    __int128_t b = 0;

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
            b = B;
        }
        else{
            b = 0;
        }
        // write to a fixed row
        ReadCC += 1;
        WriteCC += 1;
        // bit extention and write back
        EBCC += 1;
        // AND bit with B
        AndCC += 1;

        // if(A_b[BitW-i-1] == '1'){
            c1 = Sum & b;
            s1 = Sum ^ b;
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
        // }

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

    for (int i = 0; i < N; i++){
        if (zetas[i] < 0){
            zetas[i] += Q;
        }
        // printf("%d, ", zetas[i]);
    }

    k = 0;
    B = pow(2,BitW-1) - 1;
    A = 2;
    __int128_t A_R = A;
    Mont_Mult(A_R, B, M);
    // for (len = 128; len > 0; len >>= 1) {
    //     for (start = 0; start < N; start = j + len) {
    //         zeta = zetas[++k];
    //         A = zeta;
    //         __int128_t A_R = A;
    //         for (j = start; j < start + len; ++j) {
    //             // convert B from range -Q/2 to Q/2, to range 0 to Q
    //             AndCC += 1; // get MSB
    //             RightShiftInst += BitW - 1; // propagate LSB flag
    //             RightShift += BitW - 1;
    //             OrCC += BitW - 1;
    //             AndCC += 1; // AND with Q
    //             // add B by Q or 0 according to MSB
    //             AndCC += 1;
    //             XorCC += 1;
    //             AndCC += BitW - 1; 
    //             XorCC += BitW - 1;
    //             LeftShiftInst += BitW - 1;
    //             LeftShift += BitW - 1;
    //             Mont_Mult(A_R, B, M);
    //             // convert B back to range -Q/2 to Q/2
    //             AndCC += 1; // get bit larger than Q/2 by ANDing 10 x "1" + 22 x "0"
    //             RightShiftInst += BitW - 1; // propagate large bit flag
    //             RightShift += BitW - 1;
    //             OrCC += BitW - 1; // 1st flag
    //             LeftShiftInst += 10 - 1;
    //             LeftShift += 10 - 1;
    //             OrCC += 10 - 1; // get 2nd flag
    //             OrCC += 1; // OR two flags to get final flag

    //             OrCC += 1; // get middle bits by ORing 10 x "1" + 10 x "0" + 12 x "1"
    //             RightShiftInst += 22 - 1; // propagate middle bits flag
    //             RightShift += 22 - 1;
    //             AndCC += 22 - 1; // get first flag for middle bits
    //             LeftShiftInst += 20 - 1; // propagate middle bits flag
    //             LeftShift += 20 - 1;
    //             AndCC += 20 - 1; // get second flag for middle bits
    //             AndCC += 1; // AND two flags to get final flag
    //             OrCC += 1; // OR two flags to get final flag
    //             AndCC += 1; // AND with -Q
    //             // add B by -Q or 0 according to flag
    //             AndCC += 1;
    //             XorCC += 1;
    //             AndCC += BitW - 1; 
    //             XorCC += BitW - 1;
    //             LeftShiftInst += BitW - 1;
    //             LeftShift += BitW - 1;

    //             // a[j + len] = a[j] - t;
    //             AndCC += 1;
    //             XorCC += 1;
    //             AndCC += BitW - 1; 
    //             XorCC += BitW - 1;
    //             LeftShiftInst += BitW - 1;
    //             LeftShift += BitW - 1;
    //             // a[j] = a[j] + t;
    //             AndCC += 1;
    //             XorCC += 1;
    //             AndCC += BitW - 1; 
    //             XorCC += BitW - 1;
    //             LeftShiftInst += BitW - 1;
    //             LeftShift += BitW - 1;
    //         }
    //     }
    // }
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

    // int32_t zeta = -Q/2;
    // printf("Q/2 = %d\n", Q/2);
    // for (int i = 0; i < N; i++){
    //     if (zetas[i] < 0){
    //         zetas[i] += Q;
    //     }
    //     // printf("%d, ", zetas[i]);
    // }
    // // printf("\n");
    // // exit(0);
    
    // __int128_t A, B;
    // __int128_t M = Q;
    // for(int i = 0; i < N; i++){
    //     A = zetas[i];
    //     // if(i%1048576 == 0){
    //     //     std::cout << "A = " << A << "\n";
    //     // }
    //     // std::cout << "A = " << A << "\n";
    //     // for(int j = 0; j < pow(2,BitW); j++){
    //     // for(int j = 0; j < 1; j++){
    //     B = pow(2,BitW-1) - 1;
        
    //     __int128_t A_R = A;
    //     // A_R = A;
    //     // std::cout << A_R << "\n";

    //     __int128_t P = Mont_Mult(A_R, B, M);

    //         // __int128_t ref = A*B;
    //         // ref = (__int128_t)ref % M;
    //         // // std::cout << "AB = " << ref << "\n";
    //         // // std::cout << "P = " << (unsigned)P << "\n";
    //         // if(P != ref){
    //         //     std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    //         // }
    //     // }
    // }

    // std::cout << "cycleC = "<< cycleC/256 << "\n";

    // cycleC = cycleC/(std::min(pow(2,BitW), pow(2,16))); //jy average cycleC
    // energyE = energyE/(std::min(pow(2,BitW), pow(2,16))); //jy average energyE
    // shiftC = shiftC/(std::min(pow(2,BitW), pow(2,16))); //jy average shiftC
    // std::cout << "cycleC = "<< cycleC << "\n";
    // std::cout << "energyE = "<< energyE/floor(col/BitW) << "\n";

    return 0;
}
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
    __int128_t m = 0;
    __int128_t b = 0;

    __int128_t Carry = 0;
    __int128_t Sum = 0;

    __int128_t c1, s1, c2, s2, c3;

    

    std::string A_b = std::bitset<BitW>(A).to_string(); //to binary
    std::string B_b = std::bitset<BitW>(B).to_string();
    std::string M_b = std::bitset<BitW>(M).to_string();
    std::string c1_b, s1_b, c2_b, s2_b, c3_b, Carry_b, Sum_b;

    for(int i = 0; i < BitW; ++i){
        if(A_b[BitW-i-1] == '1'){
            b = B;
        }
        else{
            b = 0;
        }

        if(A_b[BitW-i-1] == '1'){
            c1 = Sum & b;
            s1 = Sum ^ b;
            Carry = Carry << 1 & (((__int128_t)1 << BitW) - 1);
            c2 = Carry & s1;
            Sum = Carry ^ s1;
            Carry = c1 | c2;

            AndCC += 2;
            XorCC += 2;
            LeftShiftInst += 1;
            LeftShift += 1;
            OrCC += 1;
        }

        Sum_b = std::bitset<BitW>(Sum).to_string();
        if(Sum_b[BitW-1] == '1'){
            m = M;
        }
        else{
            m = 0;
        }
        ReadCC += 1;
        WriteCC += 1;
        EBCC += 1;
        AndCC += 1;

        c1 = Sum & m;
        s1 = Sum ^ m;

        s1 = (s1 & (((__int128_t)1 << BitW) - 1)) >> 1;
        
        c2 = s1 & c1;
        s2 = s1 ^ c1;
        c3 = Carry & s2;
        Sum = Carry ^ s2;
        Carry = c2 | c3;

        AndCC += 3;
        XorCC += 3;
        RightShiftInst += 1;
        RightShift += 1;
        OrCC += 1;
        

    }

    __int128_t P = 2*Carry + Sum;
    LeftShiftInst += BitW - 1;
    LeftShift += BitW - 1;
    AndCC += BitW - 1;
    XorCC += BitW - 1;

    if(P >= M){
        P = P - M;
    }

    return P;
}

int main()
{
    __int128_t A, B;
    __int128_t M = Q; 

    B = pow(2,BitW-1) - 1;
    A = 1;
    __int128_t A_R = A;
    Mont_Mult(A_R, B, M);
    
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

    std::string filename(__FILE__);
    // Find the position of the last '.' in the filename
    size_t pos = filename.rfind(".");
    // Replace everything after the '.' with ".txt"
    filename.replace(pos, filename.length() - pos, ".txt");

    std::ofstream outfile(filename);
    if (!outfile.is_open()) {
        std::cerr << "Failed to open file " << filename << " for writing.\n";
        return 1;
    } 

    // Write output to the file
    outfile << "ReadCC += " << ReadCC << ";\n";
    outfile << "WriteCC += " << WriteCC << ";\n";
    outfile << "LeftShiftInst += " << LeftShiftInst << ";\n";
    outfile << "LeftShift += " << LeftShift << ";\n";
    outfile << "RightShiftInst += " << RightShiftInst << ";\n";
    outfile << "RightShift += " << RightShift << ";\n";
    outfile << "OrCC += " << OrCC << ";\n";
    outfile << "AndCC += " << AndCC << ";\n";
    outfile << "XorCC += " << XorCC << ";\n";
    outfile << "NotCC += " << NotCC << ";\n";
    outfile << "EBCC += " << EBCC << ";\n";
    outfile << "Total instruction = " << ReadCC + WriteCC + EBCC + (LeftShiftInst + RightShiftInst) * 2 + (OrCC + AndCC + XorCC + NotCC) * 3 << ";\n";

    outfile << "\nReadCC Cycle: " << ReadCC << "\n";
    outfile << "WriteCC Cycle: " << WriteCC << "\n";
    outfile << "LeftShift Cycle: " << LeftShift + LeftShiftInst << "\n"; // 1 for shift, 1 for write, no write back in the middle of the shifting
    outfile << "RightShift Cycle: " << RightShift + RightShiftInst << "\n"; // 1 for shift, 1 for write, no write back in the middle of the shifting
    outfile << "OrCC Cycle: " << OrCC * (2 + 1) << "\n"; // 1 for activate, 1 for or, 1 for write
    outfile << "AndCC Cycle: " << AndCC * (2 + 1) << "\n"; // 1 for activate, 1 for and, 1 for write
    outfile << "XorCC Cycle: " << XorCC * (2 + 1) << "\n"; // 1 for activate, 1 for xor, 1 for write
    outfile << "NotCC Cycle: " << NotCC * (2 + 1) << "\n"; // 1 for activate, 1 for xor, 1 for write. NOT is implemented by Xoring a constant full of 1s.
    outfile << "EBCC Cycle: " << EBCC << "\n"; // 1 for bit extention and write back
    outfile << "Total Cycle: " << ReadCC + WriteCC + LeftShift + RightShift + LeftShiftInst + RightShiftInst + OrCC * (2 + 1) + AndCC * (2 + 1) + XorCC * (2 + 1) + NotCC * (2 + 1) + EBCC << "\n";

    outfile.close();

    return 0;
}
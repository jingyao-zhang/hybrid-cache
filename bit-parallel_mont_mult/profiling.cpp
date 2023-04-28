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


double cycleC = 0;
double energyE = 0;
double shiftC = 0;

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
    __int128_t A, B;
    __int128_t M = 7;
    for(int i = 0; i < std::min(pow(2,BitW), pow(2,16)); i++){
        A = i;
        // if(i%1048576 == 0){
        //     std::cout << "A = " << A << "\n";
        // }
        // std::cout << "A = " << A << "\n";
        // for(int j = 0; j < pow(2,BitW); j++){
        // for(int j = 0; j < 1; j++){
            B = pow(2,BitW-1) - 1;
            
            __int128_t A_R = (A*(int)pow(2,BitW))%M;
            // A_R = A;
            // std::cout << A_R << "\n";

            __int128_t P = Mont_Mult(A_R, B, M);

            // __int128_t ref = A*B;
            // ref = (__int128_t)ref % M;
            // // std::cout << "AB = " << ref << "\n";
            // // std::cout << "P = " << (unsigned)P << "\n";
            // if(P != ref){
            //     std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
            // }
        // }
    }

    cycleC = cycleC/(std::min(pow(2,BitW), pow(2,16))); //jy average cycleC
    energyE = energyE/(std::min(pow(2,BitW), pow(2,16))); //jy average energyE
    shiftC = shiftC/(std::min(pow(2,BitW), pow(2,16))); //jy average shiftC
    std::cout << "cycleC = "<< cycleC << "\n";
    // std::cout << "energyE = "<< energyE/floor(col/BitW) << "\n";

    if(PolyO > Row){

        double beginC = 0;
        double beginE = 0;

        for(int i = log(PolyO/Row); i > 0; i--){

            beginC += PolyO/2 * (cycleC + //jy multiply
                                i * BitW + //jy shift left
                                1 + (BitW - 1) * 3 + (BitW - 1) * 3 + //jy subtraction
                                i * BitW + //jy shift right
                                (BitW - 1) * 3
                                );

            beginE += PolyO/2 * (energyE + //jy multiply
                                i * bitshfE + //jy shift left
                                logicE + ((BitW - 1) * (1 * bitshfE + 2 * logicE)) * 2 + //jy subtraction 
                                i * bitshfE + //jy shift left
                                (BitW - 1) * (1 * bitshfE + 2 * logicE)
                                );
        }
        
        cycleC = cycleC + (BitW - 1) * 3; //jy addition
        energyE = energyE + (BitW - 1) * (1 * bitshfE + 2 * logicE);
        

        cycleC = cycleC + 1 + (BitW - 1) * 3 + (BitW - 1) * 3; //jy subtraction
        energyE = energyE + logicE + ((BitW - 1) * (1 * bitshfE + 2 * logicE)) * 2;
        
 
        cycleC = PolyO/2 * cycleC; //jy one stage
        energyE = PolyO/2 * energyE; //jy one stage
        

        cycleC = (log(PolyO)-log(PolyO/Row)) * cycleC + beginC; //jy all NTT
        energyE = (log(PolyO)-log(PolyO/Row)) * energyE + beginE; //jy all NTT

        // std::cout << "energyE = "<< floor(Col/BitW/(PolyO/Row)) << "\n";
    }
    else{
        cycleC = cycleC + (BitW - 1) * 3; //jy addition
        energyE = energyE + (BitW - 1) * (1 * bitshfE + 2 * logicE);
        shiftC = shiftC + (BitW - 1) * 1;

        cycleC = cycleC + 1 + (BitW - 1) * 3 + (BitW - 1) * 3; //jy subtraction
        energyE = energyE + logicE + ((BitW - 1) * (1 * bitshfE + 2 * logicE)) * 2;
        shiftC = shiftC + (BitW - 1) * 1 + (BitW - 1) * 1;

    
        cycleC = PolyO/2 * cycleC; //jy one stage
        energyE = PolyO/2 * energyE; //jy one stage
        shiftC = PolyO/2 * shiftC;

        cycleC = log(PolyO) * cycleC; //jy all NTT
        energyE = log(PolyO) * energyE; //jy all NTT
        shiftC = log(PolyO) * shiftC;
    }

    // std::cout << "energyE = "<< floor(Col/BitW/(PolyO/Row)) << "\n";

    double energyE_per_NTT = energyE/floor(Col/BitW/std::max((PolyO/Row),1));

    std::cout << "cycleC = "<< cycleC << "\n";
    std::cout << "energyE = "<< energyE_per_NTT << "\n";
    std::cout << "shiftC = "<< shiftC << "\n";

    // std::cout << checkE << "\n";

    // __int128_t A = 6;
    // __int128_t B = 6;
    // __int128_t M = 7;

    // __int128_t A_R = (A*(int)pow(2,BitW))%M;
    // std::cout << A_R << "\n";

    // __int128_t P = Mont_Mult(A_R, B, M);

    // float ref = A*B;
    // ref = (int)ref % M;
    // std::cout << "AB = " << ref << "\n";
    // std::cout << "P = " << (unsigned)P << "\n";
    // if(P != ref){
    //     std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    // }

    return 0;
}
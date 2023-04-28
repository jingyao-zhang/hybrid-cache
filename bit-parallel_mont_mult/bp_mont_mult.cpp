#include <iostream>
#include <bitset>
#include "stdlib.h"
#include <math.h>


#define BitW 14

uint64_t cycleC = 0;

uint64_t Mont_Mult(uint64_t A, uint64_t B, uint64_t M){
    // uint64_t A = 6;
    // uint64_t B = 6;
    // uint64_t M = 7;
    uint64_t m = 0;

    uint64_t Carry = 0;
    uint64_t Sum = 0;

    uint64_t c1, s1, c2, s2, c3;

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
            Carry = Carry << 1 & (((uint64_t)1 << BitW) - 1);
            c2 = Carry & s1;
            Sum = Carry ^ s1;
            Carry = c1 | c2;
            // Carry_b = std::bitset<BitW>(Carry).to_string();
            // Sum_b = std::bitset<BitW>(Sum).to_string();
            // std::cout<< "Carry = " << Carry_b<<"\n";
            // std::cout<< "Sum = " << Sum_b<<"\n\n";

            cycleC += 6;
        }

        Sum_b = std::bitset<BitW>(Sum).to_string();
        if(Sum_b[BitW-1] == '1'){
            m = M;
        }
        else{
            m = 0;
        }

        cycleC += 1;

        c1 = Sum & m;
        s1 = Sum ^ m;
        // c1_b = std::bitset<BitW>(c1).to_string();
        // std::cout<< "c1 = " << c1_b<<"\n";
        // s1_b = std::bitset<BitW>(s1).to_string();
        // std::cout<< "s1 = " << s1_b<<"\n";

        s1 = (s1 & (((uint64_t)1 << BitW) - 1)) >> 1;
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

    uint64_t P = 2*Carry + Sum;

    cycleC = cycleC + (BitW - 1) * 3;

    if(P >= M){
        P = P - M;
    }

    return P;
}

int main()
{
    uint64_t A, B;
    uint64_t M = 7;
    for(int i = 0; i < pow(2,BitW); i++){
        A = i;
        // std::cout << "A = " << A << "\n";
        for(int j = 0; j < pow(2,BitW); j++){
            B = j;
            
            uint64_t A_R = (A*(int)pow(2,BitW))%M;
            // A_R = A;
            // std::cout << A_R << "\n";

            uint64_t P = Mont_Mult(A_R, B, M);

            uint64_t ref = A*B;
            ref = (uint64_t)ref % M;
            // std::cout << "AB = " << ref << "\n";
            // std::cout << "P = " << (unsigned)P << "\n";
            if(P != ref){
                std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
            }
        }
    }

    std::cout << cycleC/(pow(2,BitW)*pow(2,BitW)) << "\n";

    // uint64_t A = 6;
    // uint64_t B = 6;
    // uint64_t M = 7;

    // uint64_t A_R = (A*(int)pow(2,BitW))%M;
    // std::cout << A_R << "\n";

    // uint64_t P = Mont_Mult(A_R, B, M);

    // float ref = A*B;
    // ref = (int)ref % M;
    // std::cout << "AB = " << ref << "\n";
    // std::cout << "P = " << (unsigned)P << "\n";
    // if(P != ref){
    //     std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    // }

    return 0;
}
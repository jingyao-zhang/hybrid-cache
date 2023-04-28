#include <iostream>
#include <bitset>
#include "stdlib.h"
#include <math.h>


#define BitW 4

uint8_t Mont_Mult(uint8_t A, uint8_t B, uint8_t M){
    // uint8_t A = 6;
    // uint8_t B = 6;
    // uint8_t M = 7;
    uint8_t m = 0;

    uint8_t Carry = 0;
    uint8_t Sum = 0;

    uint8_t c1, s1, c2, s2, c3;

    std::string A_b = std::bitset<BitW>(A).to_string(); //to binary
    std::string B_b = std::bitset<BitW>(B).to_string();
    std::string M_b = std::bitset<BitW>(M).to_string();
    std::cout << "\n";
    std::cout<< "A = " << (unsigned)A << " = " << A_b<<"\n";
    std::cout<< "B = " << (unsigned)B << " = " << B_b<<"\n";
    std::cout<< "M = " << (unsigned)M << " = " << M_b<<"\n";
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
        }

        Sum_b = std::bitset<BitW>(Sum).to_string();
        if(Sum_b[BitW-1] == '1'){
            m = M;
        }
        else{
            m = 0;
        }

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
        
        Carry_b = std::bitset<BitW>(Carry).to_string();
        Sum_b = std::bitset<BitW>(Sum).to_string();
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

    uint8_t P = 2*Carry + Sum;
    if(P >= M){
        P = P - M;
    }

    return P;
}

int main()
{
    uint8_t A = 15;
    uint8_t B = 15;
    uint8_t M = 11;

    uint8_t A_R = (A*(int)pow(2,BitW))%M;
    // A_R = A;
    // std::cout << A_R << "\n";

    uint8_t P = Mont_Mult(A_R, B, M);

    float ref = A*B;
    ref = (int)ref % M;
    std::cout << "AB = " << ref << "\n";
    std::cout << "P = " << (unsigned)P << "\n";
    if(P != ref){
        std::cout << "Wrong!!!!!!!!!!!!!!!!!!!!!!!!!\n";
    }

    return 0;
}
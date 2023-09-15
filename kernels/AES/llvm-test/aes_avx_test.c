#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <immintrin.h>
#include <stdalign.h>

static const uint8_t s_box[256] = {
    0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
    0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0, 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
    0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
    0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
    0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0, 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
    0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
    0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
    0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5, 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
    0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
    0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
    0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c, 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
    0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
    0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
    0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e, 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
    0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
    0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
};

static const uint8_t rcon[11] = {
    0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1B, 0x36
};

uint32_t RotWord(uint32_t word) {
    return word << 24 | word >> 8;
}

uint32_t SubWord(uint32_t temp) {
    uint8_t *byteArray = (uint8_t*)&temp;  // 转换为字节指针
    byteArray[0] = s_box[byteArray[0]];
    byteArray[1] = s_box[byteArray[1]];
    byteArray[2] = s_box[byteArray[2]];
    byteArray[3] = s_box[byteArray[3]];
    return temp;  // 返回替换后的 uint32_t 值
}

uint32_t XorWithRcon(uint32_t temp, uint8_t i) {
    uint8_t *byteArray = (uint8_t*)&temp;  // 转换为字节指针
    byteArray[0] ^= rcon[i];  // 与 rcon 进行异或
    return temp;  // 返回异或后的 uint32_t 值
}

__m128i OneRoundKeyExpansion(__m128i key, uint8_t i) {
    uint32_t temp[4];
    uint32_t *wordArray = (uint32_t*)&key;

    temp[0] = RotWord(wordArray[3]);
    temp[0] = SubWord(temp[0]);
    temp[0] = XorWithRcon(temp[0], i);
    temp[0] = temp[0] ^ wordArray[0];
    temp[1] = temp[0] ^ wordArray[1];
    temp[2] = temp[1] ^ wordArray[2];
    temp[3] = temp[2] ^ wordArray[3];

    return _mm_setr_epi32(temp[0], temp[1], temp[2], temp[3]);
}

void KeyExpansion(__m128i key, __m128i *roundKeys) {
    int i = 0;

    roundKeys[0] = key;

    roundKeys[1] = OneRoundKeyExpansion(roundKeys[0], 1);
    roundKeys[2] = OneRoundKeyExpansion(roundKeys[1], 2);
    roundKeys[3] = OneRoundKeyExpansion(roundKeys[2], 3);
    roundKeys[4] = OneRoundKeyExpansion(roundKeys[3], 4);
    roundKeys[5] = OneRoundKeyExpansion(roundKeys[4], 5);
    roundKeys[6] = OneRoundKeyExpansion(roundKeys[5], 6);
    roundKeys[7] = OneRoundKeyExpansion(roundKeys[6], 7);
    roundKeys[8] = OneRoundKeyExpansion(roundKeys[7], 8);
    roundKeys[9] = OneRoundKeyExpansion(roundKeys[8], 9);
    roundKeys[10] = OneRoundKeyExpansion(roundKeys[9], 10);

    // printf("roundKeys: \n");
    // for(int i = 0; i < 11; ++i) {
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[0]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[1]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[2]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[3]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[4]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[5]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[6]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[7]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[8]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[9]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[10]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[11]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[12]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[13]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[14]);
    //     printf("%02x ", ((uint8_t*)&roundKeys[i])[15]);
    //     printf("\n");
    // }
}

void AddRoundKey512(__m512i *state, __m128i roundKey) {
    *state = _mm512_xor_si512(*state, _mm512_broadcast_i32x4(roundKey));
}

void SubBytes512(__m512i *state) {
    uint8_t* state_bytes = (uint8_t*)state;

    state_bytes[0] = s_box[state_bytes[0]];
    state_bytes[1] = s_box[state_bytes[1]];
    state_bytes[2] = s_box[state_bytes[2]];
    state_bytes[3] = s_box[state_bytes[3]];
    state_bytes[4] = s_box[state_bytes[4]];
    state_bytes[5] = s_box[state_bytes[5]];
    state_bytes[6] = s_box[state_bytes[6]];
    state_bytes[7] = s_box[state_bytes[7]];
    state_bytes[8] = s_box[state_bytes[8]];
    state_bytes[9] = s_box[state_bytes[9]];

    state_bytes[10] = s_box[state_bytes[10]];
    state_bytes[11] = s_box[state_bytes[11]];
    state_bytes[12] = s_box[state_bytes[12]];
    state_bytes[13] = s_box[state_bytes[13]];
    state_bytes[14] = s_box[state_bytes[14]];
    state_bytes[15] = s_box[state_bytes[15]];
    state_bytes[16] = s_box[state_bytes[16]];
    state_bytes[17] = s_box[state_bytes[17]];
    state_bytes[18] = s_box[state_bytes[18]];
    state_bytes[19] = s_box[state_bytes[19]];

    state_bytes[20] = s_box[state_bytes[20]];
    state_bytes[21] = s_box[state_bytes[21]];
    state_bytes[22] = s_box[state_bytes[22]];
    state_bytes[23] = s_box[state_bytes[23]];
    state_bytes[24] = s_box[state_bytes[24]];
    state_bytes[25] = s_box[state_bytes[25]];
    state_bytes[26] = s_box[state_bytes[26]];
    state_bytes[27] = s_box[state_bytes[27]];
    state_bytes[28] = s_box[state_bytes[28]];
    state_bytes[29] = s_box[state_bytes[29]];

    state_bytes[30] = s_box[state_bytes[30]];
    state_bytes[31] = s_box[state_bytes[31]];
    state_bytes[32] = s_box[state_bytes[32]];
    state_bytes[33] = s_box[state_bytes[33]];
    state_bytes[34] = s_box[state_bytes[34]];
    state_bytes[35] = s_box[state_bytes[35]];
    state_bytes[36] = s_box[state_bytes[36]];
    state_bytes[37] = s_box[state_bytes[37]];
    state_bytes[38] = s_box[state_bytes[38]];
    state_bytes[39] = s_box[state_bytes[39]];

    state_bytes[40] = s_box[state_bytes[40]];
    state_bytes[41] = s_box[state_bytes[41]];
    state_bytes[42] = s_box[state_bytes[42]];
    state_bytes[43] = s_box[state_bytes[43]];
    state_bytes[44] = s_box[state_bytes[44]];
    state_bytes[45] = s_box[state_bytes[45]];
    state_bytes[46] = s_box[state_bytes[46]];
    state_bytes[47] = s_box[state_bytes[47]];
    state_bytes[48] = s_box[state_bytes[48]];
    state_bytes[49] = s_box[state_bytes[49]];

    state_bytes[50] = s_box[state_bytes[50]];
    state_bytes[51] = s_box[state_bytes[51]];
    state_bytes[52] = s_box[state_bytes[52]];
    state_bytes[53] = s_box[state_bytes[53]];
    state_bytes[54] = s_box[state_bytes[54]];
    state_bytes[55] = s_box[state_bytes[55]];
    state_bytes[56] = s_box[state_bytes[56]];
    state_bytes[57] = s_box[state_bytes[57]];
    state_bytes[58] = s_box[state_bytes[58]];
    state_bytes[59] = s_box[state_bytes[59]];
    
    state_bytes[60] = s_box[state_bytes[60]];
    state_bytes[61] = s_box[state_bytes[61]];
    state_bytes[62] = s_box[state_bytes[62]];
    state_bytes[63] = s_box[state_bytes[63]];
}

void ShiftRows(__m512i *state) {
    __m512i tmp1;
    __m512i tmp2;
    __m512i mask;

    __m512i shifted_0;
    __m512i shifted_1;
    __m512i shifted_2;
    __m512i shifted_3;

    // printf("state: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)state)[i]);
    // }
    // printf("\n");

    mask = _mm512_set_epi32(
        0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
        0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
        0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF,
        0x000000FF, 0x000000FF, 0x000000FF, 0x000000FF
    );
    shifted_0 = _mm512_and_epi32(*state, mask);

    // printf("shifted_0: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&shifted_0)[i]);
    // }
    // printf("\n");

    // printf("state: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)state)[i]);
    // }
    // printf("\n");

    tmp1 = _mm512_alignr_epi32(*state, *state, 1);
    // tmp1 = _mm512_bsrli_epi128(*state, 8);
    // printf("tmp1: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&tmp1)[i]);
    // }
    // printf("\n");
    mask = _mm512_set_epi32(
        0x00000000, 0x0000FF00, 0x0000FF00, 0x0000FF00, 
        0x00000000, 0x0000FF00, 0x0000FF00, 0x0000FF00, 
        0x00000000, 0x0000FF00, 0x0000FF00, 0x0000FF00, 
        0x00000000, 0x0000FF00, 0x0000FF00, 0x0000FF00
    );
    tmp1 = _mm512_and_epi32(tmp1, mask);
    // printf("tmp1: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&tmp1)[i]);
    // }
    // printf("\n");

    // printf("state: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)state)[i]);
    // }
    // printf("\n");
    tmp2 = _mm512_alignr_epi32(*state, *state, 13);
    // printf("tmp2: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&tmp2)[i]);
    // }
    // printf("\n");
    mask = _mm512_set_epi32(
        0x0000FF00, 0x00000000, 0x00000000, 0x00000000, 
        0x0000FF00, 0x00000000, 0x00000000, 0x00000000, 
        0x0000FF00, 0x00000000, 0x00000000, 0x00000000, 
        0x0000FF00, 0x00000000, 0x00000000, 0x00000000 
    );
    tmp2 = _mm512_and_epi32(tmp2, mask);
    // printf("tmp2: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&tmp2)[i]);
    // }
    // printf("\n");
    shifted_1 = _mm512_or_si512(tmp1, tmp2);

    // printf("shifted_1: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&shifted_1)[i]);
    // }
    // printf("\n");

    tmp1 = _mm512_alignr_epi32(*state, *state, 2);
    mask = _mm512_set_epi32(
        0x00000000, 0x00000000, 0x00FF0000, 0x00FF0000,
        0x00000000, 0x00000000, 0x00FF0000, 0x00FF0000,
        0x00000000, 0x00000000, 0x00FF0000, 0x00FF0000,
        0x00000000, 0x00000000, 0x00FF0000, 0x00FF0000
    );
    tmp1 = _mm512_and_epi32(tmp1, mask);
    tmp2 = _mm512_alignr_epi32(*state, *state, 14);
    mask = _mm512_set_epi32(
        0x00FF0000, 0x00FF0000, 0x00000000, 0x00000000,
        0x00FF0000, 0x00FF0000, 0x00000000, 0x00000000,
        0x00FF0000, 0x00FF0000, 0x00000000, 0x00000000,
        0x00FF0000, 0x00FF0000, 0x00000000, 0x00000000
    );
    tmp2 = _mm512_and_epi32(tmp2, mask);
    shifted_2 = _mm512_or_si512(tmp1, tmp2);

    // printf("shifted_2: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&shifted_2)[i]);
    // }
    // printf("\n");
    
    tmp1 = _mm512_alignr_epi32(*state, *state, 3);
    mask = _mm512_set_epi32(
        0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
        0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
        0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
        0x00000000, 0x00000000, 0x00000000, 0xFF000000 
    );
    tmp1 = _mm512_and_epi32(tmp1, mask);
    tmp2 = _mm512_alignr_epi32(*state, *state, 15);
    mask = _mm512_set_epi32(
        0xFF000000, 0xFF000000, 0xFF000000, 0x00000000, 
        0xFF000000, 0xFF000000, 0xFF000000, 0x00000000, 
        0xFF000000, 0xFF000000, 0xFF000000, 0x00000000, 
        0xFF000000, 0xFF000000, 0xFF000000, 0x00000000 
    );
    tmp2 = _mm512_and_epi32(tmp2, mask);
    shifted_3 = _mm512_or_si512(tmp1, tmp2);
    // printf("shifted_3: \n");
    // for(int i = 0; i < 16; ++i) {
    //     printf("%02x ", ((uint8_t*)&shifted_3)[i]);
    // }
    // printf("\n");

    *state = _mm512_or_si512(shifted_0, shifted_1);
    *state = _mm512_or_si512(*state, shifted_2);
    *state = _mm512_or_si512(*state, shifted_3);


    // tmp1 = _mm512_slli_epi32(*state, 16);
    // mask = _mm512_set_epi32(
    //     0x00000000, 0x00000000, 0xFFFF0000, 0x00000000, 
    //     0x00000000, 0x00000000, 0xFFFF0000, 0x00000000, 
    //     0x00000000, 0x00000000, 0xFFFF0000, 0x00000000, 
    //     0x00000000, 0x00000000, 0xFFFF0000, 0x00000000
    // );
    // tmp1 = _mm512_and_epi32(tmp1, mask);

    // tmp2 = _mm512_srli_epi32(*state, 16);
    // mask = _mm512_set_epi32(
    //     0x00000000, 0x00000000, 0x0000FFFF, 0x00000000, 
    //     0x00000000, 0x00000000, 0x0000FFFF, 0x00000000, 
    //     0x00000000, 0x00000000, 0x0000FFFF, 0x00000000, 
    //     0x00000000, 0x00000000, 0x0000FFFF, 0x00000000
    // );
    // tmp2 = _mm512_and_epi32(tmp2, mask);
    // shifted_2 = _mm512_or_si512(tmp1, tmp2);

    // tmp1 = _mm512_slli_epi32(*state, 24);
    // mask = _mm512_set_epi32(
    //     0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
    //     0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
    //     0x00000000, 0x00000000, 0x00000000, 0xFF000000, 
    //     0x00000000, 0x00000000, 0x00000000, 0xFF000000
    // );
    // tmp1 = _mm512_and_epi32(tmp1, mask);

    // tmp2 = _mm512_srli_epi32(*state, 8);
    // mask = _mm512_set_epi32(
    //     0x00000000, 0x00000000, 0x00000000, 0x00FFFFFF, 
    //     0x00000000, 0x00000000, 0x00000000, 0x00FFFFFF, 
    //     0x00000000, 0x00000000, 0x00000000, 0x00FFFFFF, 
    //     0x00000000, 0x00000000, 0x00000000, 0x00FFFFFF
    // );
    // tmp2 = _mm512_and_epi32(tmp2, mask);
    // shifted_3 = _mm512_or_si512(tmp1, tmp2);

    // *state = _mm512_or_si512(shifted_0, shifted_1);
    // *state = _mm512_or_si512(*state, shifted_2);
    // *state = _mm512_or_si512(*state, shifted_3);

}

__m512i AES128Encrypt_vec512(__m512i input, __m128i key) {
    __m512i state = input;
    // uint8_t state[16];
    __m128i roundKeys[11];
    // uint8_t roundKeys[176];
    __m512i output_vec;

    // Initialize state and round keys
    // memcpy(state, input, 16);
    KeyExpansion(key, roundKeys);

    AddRoundKey512(&state, roundKeys[0]);

    printf("after addroundkey: \n");
    for(int i = 0; i < 16; ++i) {
        printf("%02x ", ((uint8_t*)&state)[i]);
    }
    printf("\n");

    SubBytes512(&state);

    printf("after subbytes: \n");
    for(int i = 0; i < 16; ++i) {
        printf("%02x ", ((uint8_t*)&state)[i]);
    }
    printf("\n");

    ShiftRows(&state);
    
    printf("after shiftrows: \n");
    for(int i = 0; i < 16; ++i) {
        printf("%02x ", ((uint8_t*)&state)[i]);
    }
    printf("\n");
    
    return output_vec;
}

int main() {
    alignas(64) uint8_t input[4][16] = {{0x00, 0x00, 0x01, 0x01, 0x03, 0x03, 0x07, 0x07, 0x0f, 0x0f, 0x1f, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f}, {0x00, 0x00, 0x01, 0x01, 0x03, 0x03, 0x07, 0x07, 0x0f, 0x0f, 0x1f, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f}, {0x00, 0x00, 0x01, 0x01, 0x03, 0x03, 0x07, 0x07, 0x0f, 0x0f, 0x1f, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f}, {0x00, 0x00, 0x01, 0x01, 0x03, 0x03, 0x07, 0x07, 0x0f, 0x0f, 0x1f, 0x1f, 0x3f, 0x3f, 0x7f, 0x7f}};  // 16-byte plaintext
    // alignas(16) uint8_t key[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};    // 16-byte key
    alignas(16) uint8_t key[16] = {0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    alignas(64) uint8_t output[4][16] = {0};

    __m512i input_vec = _mm512_load_si512(input);
    __m512i output_vec = _mm512_load_si512(output);
    __m128i key_vec = _mm_load_si128((__m128i*)key);
    
    // uint8_t buffer[16];
    // memcpy(buffer, &key_vec, sizeof(__m128i));
    // for (int i = 0; i < 16; ++i) {
    //     printf("%02x ", buffer[i]);
    // }
    // printf("\n");

    output_vec = AES128Encrypt_vec512(input_vec, key_vec);


    // for (int i = 0; i < 4; ++i) {
    //     AES128Encrypt(input[i], output[i], key);
    // }

    return 0;
}
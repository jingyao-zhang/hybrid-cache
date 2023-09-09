#include <stdio.h>
#include <stdint.h>
#include <string.h>

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

void RotWord(uint8_t *word) {
    uint8_t temp = word[0];
    word[0] = word[1];
    word[1] = word[2];
    word[2] = word[3];
    word[3] = temp;
}

void SubWord(uint8_t *word) {
    for (int i = 0; i < 4; ++i) {
        word[i] = s_box[word[i]];
    }
}

void KeyExpansion(uint8_t *key, uint8_t *roundKeys) {
    int i = 0;
    uint8_t temp[4];

    // Copy the original key as the first round key
    for (i = 0; i < 16; ++i) {
        roundKeys[i] = key[i];
    }

    i = 16;

    while (i < 176) {
        // Copy the last 4 bytes to temp
        for (int j = 0; j < 4; ++j) {
            temp[j] = roundKeys[i - 4 + j];
        }

        if (i % 16 == 0) {
            RotWord(temp);
            SubWord(temp);
            temp[0] = temp[0] ^ rcon[i / 16];
        }

        for (int j = 0; j < 4; ++j) {
            roundKeys[i] = roundKeys[i - 16] ^ temp[j];
            ++i;
        }
    }
}

void AddRoundKey(uint8_t *state, uint8_t *roundKey) {
    for (int i = 0; i < 16; ++i) {
        state[i] ^= roundKey[i];
    }
}

void SubBytes(uint8_t *state) {
    for (int i = 0; i < 16; ++i) {
        state[i] = s_box[state[i]];
    }
}

void ShiftRows(uint8_t *state) {
    uint8_t temp;

    // Second row: shift one position to the left
    temp = state[1];
    state[1] = state[5];
    state[5] = state[9];
    state[9] = state[13];
    state[13] = temp;

    // Third row: shift two positions to the left
    temp = state[2];
    state[2] = state[10];
    state[10] = temp;

    temp = state[6];
    state[6] = state[14];
    state[14] = temp;

    // Fourth row: shift three positions to the left
    temp = state[3];
    state[3] = state[15];
    state[15] = state[11];
    state[11] = state[7];
    state[7] = temp;
}

// Multiply in Galois Field 2^8
uint8_t gmul(uint8_t a, uint8_t b) {
    uint8_t p = 0;
    uint8_t counter;
    uint8_t carry;
    for (counter = 0; counter < 8; counter++) {
        if ((b & 1) != 0) 
            p ^= a;
        carry = (a & 0x80);  /* detect if x^8 term is about to be generated */
        a <<= 1;
        if (carry != 0) 
            a ^= 0x1b; /* replace x^8 with x^4 + x^3 + x + 1 */
        b >>= 1;
    }
    return p;
}

void MixColumns(uint8_t *state) {
    uint8_t i, a[4], b[4];
    for (i = 0; i < 4; ++i) {
        a[0] = state[i * 4];
        a[1] = state[i * 4 + 1];
        a[2] = state[i * 4 + 2];
        a[3] = state[i * 4 + 3];

        b[0] = gmul(a[0], 0x02) ^ gmul(a[3], 0x01) ^ gmul(a[2], 0x01) ^ gmul(a[1], 0x03);
        b[1] = gmul(a[1], 0x02) ^ gmul(a[0], 0x01) ^ gmul(a[3], 0x01) ^ gmul(a[2], 0x03);
        b[2] = gmul(a[2], 0x02) ^ gmul(a[1], 0x01) ^ gmul(a[0], 0x01) ^ gmul(a[3], 0x03);
        b[3] = gmul(a[3], 0x02) ^ gmul(a[2], 0x01) ^ gmul(a[1], 0x01) ^ gmul(a[0], 0x03);

        state[i * 4] = b[0];
        state[i * 4 + 1] = b[1];
        state[i * 4 + 2] = b[2];
        state[i * 4 + 3] = b[3];
    }
}

void AES128Encrypt(uint8_t *input, uint8_t *output, uint8_t *key) {
    uint8_t state[16];
    uint8_t roundKeys[176];

    // Initialize state and round keys
    memcpy(state, input, 16);
    KeyExpansion(key, roundKeys);

    // Initial round key addition
    AddRoundKey(state, roundKeys);

    // Main rounds
    for (int i = 1; i < 10; ++i) {
        SubBytes(state);
        ShiftRows(state);
        MixColumns(state);
        AddRoundKey(state, roundKeys + 16 * i);
    }

    // Final round
    SubBytes(state);
    ShiftRows(state);
    AddRoundKey(state, roundKeys + 160);

    // Output the encrypted state
    memcpy(output, state, 16);
}

int main() {
    // uint8_t input[16] = {0};  // 16-byte plaintext
    uint8_t input[4][16] = {0};  // 16-byte plaintext
    // uint8_t key[16] = {0x66, 0xd9, 0xb7, 0x60, 0x0e, 0xda, 0xaa, 0x81, 0x42, 0xa2, 0xd6, 0x3d, 0x8f, 0x51, 0x6c, 0x6f};    // 16-byte key
    uint8_t key[16] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};    // 16-byte key
    // uint8_t output[16] = {0};
    uint8_t output[4][16] = {0};
    
    // AES128Encrypt(input, output, key);

    for (int i = 0; i < 4; ++i) {
        AES128Encrypt(input[i], output[i], key);
    }

    // // output the ciphertext
    // printf("Ciphertext: ");
    // for (int j = 0; j < 16; ++j) {
    //     printf("%02x ", output[j]);
    // }
    // printf("\n");

    // // output the ciphertext
    // for (int i = 0; i < 4; ++i) {
    //     printf("Ciphertext %d: ", i);
    //     for (int j = 0; j < 16; ++j) {
    //         printf("%02x ", output[i][j]);
    //     }
    //     printf("\n");
    // }

    return 0;
}
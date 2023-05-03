# Hybrid Cache

Welcome to the Hybrid Cache Implementation Repository! This repository contains the implementation of Kyber and Dilithium cryptographic algorithms, as well as AES, Keccak, and NTT-related kernels manually compiled to the instructions for Hybrid Cache. Please follow the instructions and guidelines mentioned below to ensure a smooth review process.

## Table of Contents

1. Repository Structure
2. Setup and Installation
3. Running the Program
4. License
5. Acknowledgements

## 1. Repository Structure

The repository is organized as follows:

- `algorithms/`: Contains the Kyber and Dilithium cryptographic algorithm implementations
    - `kyber/`: Contains the Kyber algorithm implementation
    - `dilithium/`: Contains the Dilithium algorithm implementation
- `kernels/`: Contains the kernel implementations for AES, Keccak, and NTT-related operations
    - `aes/`: Contains the AES kernel implementation
    - `keccak/`: Contains the Keccak kernel implementation
    - `ntt_related/`: Contains the NTT-related kernel implementations, such as Montgomery multiplication and NTT

## 2. Setup

Before running the program, ensure that you have the following prerequisites installed on your system:

- A C compiler
- A C++ compiler
- CMake (version 3.10 or later)

To run the project, follow these steps:

1. Clone the repository to your local machine:
```
git clone https://github.com/Ssicayoon/hybrid-cache.git
```

## 3. Running the Program

After cloning the repository, follow these steps to run the program:

1. Navigate to the root directory of the repository:
```
cd hybrid-cache
```

2. Navigate to the folder you want to run. Algorithms and kernels have two different flow of execution. 
    - To run the algorithms (e.g., Kyber), navigate to the `algorithms/kyber/ref` folder:
    ```
    cd algorithms/kyber/ref
    make test_kyber512
    ./test_kyber512
    ```
    - To run the kernels (e.g., AES), navigate to the `kernels/aes` folder:
    ```
    cd kernels/ase
    cc aes.c aes_test.c -o aes_test
    ./aes_test
    ```

## 4. License
This repository is licensed under the Apache License 2.0. Please see the [LICENSE](https://www.apache.org/licenses/LICENSE-2.0) file for more details.

## 5. Acknowledgements
This repository is based on the following repositories:
- [Reference Kyber Implimentation](https://github.com/pq-crystals/kyber)
- [Reference Dilithium Implimentation](https://github.com/pq-crystals/dilithium)
- [PQClean](https://github.com/PQClean/PQClean)


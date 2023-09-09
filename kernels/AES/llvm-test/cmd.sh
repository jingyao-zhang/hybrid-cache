clang -O3 -S -emit-llvm aes_scalar.c -o aes_scalar.ll
# opt -S -O3 -o aes_s_av.ll aes_scalar.ll
llc -mcpu=sapphirerapids aes_s_av.ll -o aes_s_av.s
llvm-mca -mcpu=sapphirerapids aes_s_av.s > aes_s_av.txt
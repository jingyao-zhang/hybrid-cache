#!/bin/bash

# 检查是否提供了输入文件
if [ -z "$1" ]; then
    echo "Usage: $0 <source_file.c>"
    exit 1
fi

# 获取输入的C文件名（不包含后缀）
filename=$(basename -- "$1")
extension="${filename##*.}"
filename="${filename%.*}"

# 使用 clang 生成汇编代码
clang -O0 -S -march=native "$1" -o "${filename}.s"
if [ $? -ne 0 ]; then
    echo "Failed to generate assembly code."
    exit 1
fi

# 使用 clang 生成 LLVM IR
clang -O0 -S -emit-llvm "$1" -o "${filename}.ll"
if [ $? -ne 0 ]; then
    echo "Failed to generate LLVM IR."
    exit 1
fi

# 使用 llvm-mca 进行性能分析，并输出到 txt 文件
llvm-mca -mcpu=sapphirerapids "${filename}.s" > "${filename}.txt"
if [ $? -ne 0 ]; then
    echo "Failed to run llvm-mca."
    exit 1
fi

# 使用 opt 加载并运行自定义 LLVM pass
opt -load-pass-plugin ./libHelloWorld.so -passes=hello-world -disable-output "${filename}.ll"
if [ $? -ne 0 ]; then
    echo "Failed to run LLVM pass."
    exit 1
fi

echo "All steps completed successfully."

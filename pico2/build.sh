#!/bin/bash
# build.sh — hello.s を Pico 2 用 UF2 にビルド
set -e
cd "$(dirname "$0")"

CC=riscv64-unknown-elf-gcc
OBJCOPY=riscv64-unknown-elf-objcopy

# RV32IMAC, no startup, no stdlib, our linker script
$CC -march=rv32imac_zicsr -mabi=ilp32 \
    -nostdlib -nostartfiles -ffreestanding \
    -Wl,-T,hello.ld -Wl,--no-relax \
    -o hello.elf hello.s

$OBJCOPY -O binary hello.elf hello.bin
python3 bin2uf2.py hello.bin hello.uf2 0x10000000

ls -la hello.elf hello.bin hello.uf2

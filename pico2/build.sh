#!/bin/bash
# pico2/build.sh — build both Pico 2 hello-world variants.
#
#   hello.uf2     : the hand-written assembly variant (pico2/hello.s).
#                   Uses riscv64-unknown-elf-gcc for assembling + linking.
#
#   hello_tc.uf2  : the TC variant (pico2/hello.tc) compiled through
#                   compile-pico2.sh (Gen2 parse/typecheck/codegen/
#                   bc2asm/asm running under qemu-riscv32). Builds the
#                   Gen2 tools into /tmp/gen2_pico2 on first run.
#
# Usage:
#   ./pico2/build.sh          # build both
#   ./pico2/build.sh hello    # hand-written only
#   ./pico2/build.sh tc       # hello.tc only
#
# Requires (depending on target):
#   riscv64-unknown-elf-gcc   — for pico2/hello.s
#   qemu-riscv32              — for hello_tc.uf2

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

build_hello_s() {
    cd "$SCRIPT_DIR"
    local CC=riscv64-unknown-elf-gcc
    local OBJCOPY=riscv64-unknown-elf-objcopy
    $CC -march=rv32imac_zicsr -mabi=ilp32 \
        -nostdlib -nostartfiles -ffreestanding \
        -Wl,-T,hello.ld -Wl,--no-relax \
        -o hello.elf hello.s
    $OBJCOPY -O binary hello.elf hello.bin
    python3 bin2uf2.py hello.bin hello.uf2 0x10000000
    ls -la hello.elf hello.bin hello.uf2
}

build_hello_tc() {
    cd "$ROOT_DIR"

    # Build Gen1 (C) tools if needed.
    make -s all

    # Build Gen2 TC tools into a cached directory so repeat runs are fast.
    local GEN2_DIR="${GEN2_DIR:-/tmp/gen2_pico2}"
    mkdir -p "$GEN2_DIR"
    local tool
    for tool in parse typecheck codegen bc2asm asm; do
        if [ ! -x "$GEN2_DIR/$tool" ] \
           || [ "$ROOT_DIR/compiler/$tool.tc" -nt "$GEN2_DIR/$tool" ]; then
            echo "  building Gen2 $tool …"
            "$ROOT_DIR/compile-gen1.sh" -o "$GEN2_DIR/$tool" \
                "$ROOT_DIR/compiler/$tool.tc"
        fi
    done

    echo "  compile-pico2.sh pico2/hello.tc → pico2/hello_tc.uf2"
    GEN2_DIR="$GEN2_DIR" "$ROOT_DIR/compile-pico2.sh" \
        -o "$SCRIPT_DIR/hello_tc.uf2" "$SCRIPT_DIR/hello.tc"
    ls -la "$SCRIPT_DIR/hello_tc.uf2"
}

case "${1:-all}" in
    all)     build_hello_s; build_hello_tc ;;
    hello)   build_hello_s ;;
    tc)      build_hello_tc ;;
    *)       echo "Usage: $0 [all|hello|tc]" >&2; exit 1 ;;
esac

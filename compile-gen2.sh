#!/bin/bash
# compile-gen2.sh — Compile .tc to RV32 ELF using Gen2 tools (via qemu) + GCC rv32
# Uses: Gen2 parse/typecheck/codegen/bc2asm (qemu), riscv64-unknown-elf-gcc, runtime_syscall.c
#
# Usage: GEN2_DIR=/path/to/gen2 ./compile-gen2.sh [-o output] file.tc
#
# NOTE: Import resolution not yet supported. Files with imports will fail at typecheck.
# TODO: Use extract-sigs + .th files for import resolution.

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QEMU="${QEMU:-qemu-riscv32}"
RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
CRT0="$ROOT_DIR/bootstrap/crt0.s"
RUNTIME="$ROOT_DIR/bootstrap/runtime_syscall.c"

OUTFILE="a.out"
TC_FILE=""

while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: GEN2_DIR=/path/to/gen2 compile-gen2.sh [-o output] file.tc" >&2
    exit 1
fi

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set. Build Gen2 tools first with compile-gen1.sh." >&2
    exit 1
fi

for tool in parse typecheck codegen bc2asm; do
    if [ ! -x "$GEN2_DIR/$tool" ]; then
        echo "Error: Gen2 tool not found: $GEN2_DIR/$tool" >&2
        exit 1
    fi
done

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Compile: Gen2 parse → typecheck → codegen → bc2asm → .s
"$QEMU" "$GEN2_DIR/parse" < "$TC_FILE" 2>/dev/null | \
    "$QEMU" "$GEN2_DIR/typecheck" 2>/dev/null | \
    "$QEMU" "$GEN2_DIR/codegen" 2>/dev/null | \
    "$QEMU" "$GEN2_DIR/bc2asm" > "$TMP/user.s" 2>/dev/null

# Link with GCC: crt0.s + user assembly + C runtime
"$RISCV_CC" $RISCV_FLAGS "$CRT0" "$TMP/user.s" "$RUNTIME" -o "$OUTFILE"

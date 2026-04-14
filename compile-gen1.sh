#!/bin/bash
# compile-gen1.sh — Compile .tc to RV32 ELF using Gen1 (C) tools + GCC rv32
# Uses: Gen1 codegen, Gen1 bc2asm, riscv64-unknown-elf-gcc, runtime_syscall.c
#
# Usage: ./compile-gen1.sh [-o output] file.tc
#
# Resolves imports automatically. Each file compiled separately, linked with GCC.

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEGEN="$ROOT_DIR/codegen"
BC2ASM="$ROOT_DIR/bc2asm"
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
    echo "Usage: compile-gen1.sh [-o output] file.tc" >&2
    exit 1
fi

# Recursive import collection
_COLLECTED=""
_collect_imports() {
    local tc_file="$1" tc_dir
    tc_dir=$(dirname "$tc_file")
    while IFS= read -r imp; do
        local full="$tc_dir/$imp"
        if [ -f "$full" ]; then
            local b; b=$(basename "$full")
            if ! echo "$_COLLECTED" | grep -qF "$b"; then
                _collect_imports "$full"
                _COLLECTED="${_COLLECTED}${full}
"
            fi
        fi
    done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
}

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Collect all source files (imports + main)
_COLLECTED=""
_collect_imports "$TC_FILE"
ALL_FILES=()
while IFS= read -r f; do
    [ -z "$f" ] && continue
    ALL_FILES+=("$f")
done <<< "$_COLLECTED"
ALL_FILES+=("$TC_FILE")

# Compile each .tc file: Gen1 codegen → Gen1 bc2asm → .s
ASM_FILES=()
for tc in "${ALL_FILES[@]}"; do
    base=$(basename "$tc" .tc)
    asm="$TMP/$base.s"
    "$CODEGEN" "$tc" | "$BC2ASM" > "$asm"
    ASM_FILES+=("$asm")
done

# Link with GCC: crt0.s + all .s files + C runtime
"$RISCV_CC" $RISCV_FLAGS "$CRT0" "${ASM_FILES[@]}" "$RUNTIME" -o "$OUTFILE"

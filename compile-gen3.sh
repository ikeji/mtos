#!/bin/bash
# compile-gen3.sh — Compile .tc to RV32 ELF using Gen3 tools (via qemu) + GCC rv32
# Uses: Gen1 parse/extract-sigs (for .th generation), Gen3 typecheck/codegen/bc2asm (qemu)
#
# Usage: GEN3_DIR=/path/to/gen3 ./compile-gen3.sh [-o output] file.tc
#
# Resolves imports via .th headers (Gen1 parse + extract-sigs).
# NOTE: Gen1 parse is used for .th extraction because Gen3 parse has a bracket
# balance issue with comment nodes. Gen3 typecheck/codegen/bc2asm handle the
# actual compilation.
#
# Requires: Gen1 tools (parse, extract-sigs), Gen3 tools in GEN3_DIR,
#           riscv64-unknown-elf-gcc, qemu-riscv32

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARSE="$ROOT_DIR/parse"
EXTRACT_SIGS="$ROOT_DIR/extract-sigs"
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
    echo "Usage: GEN3_DIR=/path/to/gen3 compile-gen3.sh [-o output] file.tc" >&2
    exit 1
fi

if [ -z "$GEN3_DIR" ]; then
    echo "Error: GEN3_DIR not set. Build Gen3 tools first with compile-gen2.sh." >&2
    exit 1
fi

for tool in typecheck codegen bc2asm; do
    if [ ! -x "$GEN3_DIR/$tool" ]; then
        echo "Error: Gen3 tool not found: $GEN3_DIR/$tool" >&2
        exit 1
    fi
done

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

# Collect import files
_COLLECTED=""
_collect_imports "$TC_FILE"
IMPORT_FILES=()
while IFS= read -r f; do
    [ -z "$f" ] && continue
    IMPORT_FILES+=("$f")
done <<< "$_COLLECTED"

ALL_FILES=("${IMPORT_FILES[@]}" "$TC_FILE")

# Generate .th for each import (using Gen1 parse + extract-sigs)
# Build (imports ...) block
if [ ${#IMPORT_FILES[@]} -gt 0 ]; then
    {
        echo "(imports"
        for imp in "${IMPORT_FILES[@]}"; do
            "$PARSE" "$imp" | "$EXTRACT_SIGS"
        done
        echo ")"
    } > "$TMP/imports.th"
fi

# Compile each .tc: Gen1 parse → (imports) → Gen3 typecheck → Gen3 codegen → Gen3 bc2asm → .s
ASM_FILES=()
for tc in "${ALL_FILES[@]}"; do
    base=$(basename "$tc" .tc)
    if [ -f "$TMP/imports.th" ]; then
        "$PARSE" "$tc" | \
            { cat "$TMP/imports.th"; cat; } | \
            "$QEMU" "$GEN3_DIR/typecheck" 2>/dev/null | \
            "$QEMU" "$GEN3_DIR/codegen" 2>/dev/null | \
            "$QEMU" "$GEN3_DIR/bc2asm" > "$TMP/$base.s" 2>/dev/null
    else
        "$PARSE" "$tc" | \
            "$QEMU" "$GEN3_DIR/typecheck" 2>/dev/null | \
            "$QEMU" "$GEN3_DIR/codegen" 2>/dev/null | \
            "$QEMU" "$GEN3_DIR/bc2asm" > "$TMP/$base.s" 2>/dev/null
    fi
    ASM_FILES+=("$TMP/$base.s")
done

# Link with GCC: crt0.s + all .s files + C runtime
"$RISCV_CC" $RISCV_FLAGS "$CRT0" "${ASM_FILES[@]}" "$RUNTIME" -o "$OUTFILE"

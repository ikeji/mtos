#!/bin/bash
# tc_build.sh — compile and link multiple .tc files into a RISC-V executable
#
# Usage: tc_build.sh [-o output] file1.tc file2.tc ...
#
# Each .tc file is compiled independently (parse → typecheck → codegen → bc2asm).
# The resulting .s files are linked together with crt0.s and runtime.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEGEN="$ROOT_DIR/codegen"
BC2ASM="$ROOT_DIR/bc2asm"
COMPILER_DIR="$ROOT_DIR/bootstrap"

RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"

OUTPUT="a.out"
TC_FILES=()

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -o)
            shift
            OUTPUT="$1"
            ;;
        *.tc)
            TC_FILES+=("$1")
            ;;
        *)
            echo "Error: unknown argument '$1'" >&2
            echo "Usage: tc_build.sh [-o output] file1.tc file2.tc ..." >&2
            exit 1
            ;;
    esac
    shift
done

if [ ${#TC_FILES[@]} -eq 0 ]; then
    echo "Usage: tc_build.sh [-o output] file1.tc file2.tc ..." >&2
    exit 1
fi

if ! command -v "$RISCV_CC" >/dev/null 2>&1; then
    echo "Error: RISC-V toolchain ($RISCV_CC) not found" >&2
    exit 1
fi

if [ ! -x "$CODEGEN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: tools (codegen, bc2asm) not found. Run 'make' first." >&2
    exit 1
fi

TMP=$(mktemp -d)
trap "rm -rf '$TMP'" EXIT

ASM_FILES=()
FAIL=0

for tc in "${TC_FILES[@]}"; do
    base=$(basename "$tc" .tc)
    asm="$TMP/$base.s"
    if ! "$CODEGEN" "$tc" 2>/dev/null | "$BC2ASM" > "$asm" 2>/dev/null; then
        echo "Error: failed to compile $tc" >&2
        FAIL=1
        break
    fi
    # Check if asm file is non-empty (codegen or bc2asm may have failed silently)
    if [ ! -s "$asm" ]; then
        echo "Error: empty output from compiling $tc" >&2
        FAIL=1
        break
    fi
    ASM_FILES+=("$asm")
done

if [ $FAIL -ne 0 ]; then
    exit 1
fi

# Link
if ! "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$RUNTIME" "${ASM_FILES[@]}" -o "$OUTPUT" 2>&1; then
    echo "Error: linking failed" >&2
    exit 1
fi

echo "Built: $OUTPUT"

#!/bin/bash
# tc_run.sh — run a .tc program using a specified execution method
#
# Usage: tc_run.sh <method> <file.tc> [stdin]
#
# Methods:
#   interp      direct AST interpreter
#   bcrun       C codegen → bytecode runner
#   rv32        C codegen → bc2asm → riscv-gcc → qemu-riscv32
#   pipeline    self-hosted: parse.tc + codegen.tc running on bcrun
#   bc2asm_tc   self-hosted: bc2asm.tc → riscv-gcc → qemu-riscv32
#
# The optional [stdin] argument is passed as the program's standard input.
# Prefix with '@' to read from a file: @tests/input.txt

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
METHOD="${1:-}"
TC_FILE="${2:-}"
STDIN_ARG="${3:-}"

INTERP="$ROOT_DIR/interp"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"
COMPILER_DIR="$ROOT_DIR/bootstrap"
TC_DIR="$ROOT_DIR/compiler"
RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"
QEMU="qemu-riscv32"

usage() {
    echo "Usage: tc_run.sh <method> <file.tc> [stdin]"
    echo ""
    echo "Methods:"
    echo "  interp      direct AST interpreter"
    echo "  bcrun       C codegen → bytecode runner"
    echo "  rv32        C codegen → bc2asm → riscv-gcc → qemu-riscv32"
    echo "  pipeline    self-hosted: parse.tc + codegen.tc on bcrun"
    echo "  bc2asm_tc   self-hosted: bc2asm.tc → riscv-gcc → qemu-riscv32"
    echo ""
    echo "  [stdin]  string passed as program stdin; prefix '@' to read from file"
    exit 1
}

if [ -z "$METHOD" ] || [ -z "$TC_FILE" ]; then usage; fi
if [ ! -f "$TC_FILE" ]; then echo "Error: not found: $TC_FILE" >&2; exit 1; fi

# Emit stdin data to stdout
emit_stdin() {
    if [ -z "$STDIN_ARG" ]; then
        return
    elif [[ "$STDIN_ARG" == @* ]]; then
        cat "${STDIN_ARG:1}"
    else
        printf '%s' "$STDIN_ARG"
    fi
}

case "$METHOD" in
    interp)
        emit_stdin | "$INTERP" "$TC_FILE"
        ;;

    bcrun)
        { "$CODEGEN" "$TC_FILE"; emit_stdin; } | "$BCRUN"
        ;;

    rv32)
        ASM=$(mktemp /tmp/tc_XXXXXX.s)
        ELF=$(mktemp /tmp/tc_XXXXXX)
        trap "rm -f '$ASM' '$ELF'" EXIT
        "$CODEGEN" "$TC_FILE" | "$BC2ASM" > "$ASM"
        "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$ASM" "$RUNTIME" -o "$ELF" >&2
        emit_stdin | "$QEMU" "$ELF"
        ;;

    pipeline)
        source "$ROOT_DIR/tests/compile_tc.sh"
        PARSE_TC_BC=$(compile_tc_to_bc "$TC_DIR/parse.tc")
        TYPECHECK_TC_BC=$(compile_tc_to_bc "$TC_DIR/typecheck.tc")
        CODEGEN_TC_BC=$(compile_tc_to_bc "$TC_DIR/codegen.tc")
        AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$TC_FILE"; } | "$BCRUN" 2>/dev/null)
        TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$AST"; } | "$BCRUN" 2>/dev/null)
        BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$TAST"; } | "$BCRUN" 2>/dev/null)
        { printf '%s\n' "$BC"; emit_stdin; } | "$BCRUN"
        ;;

    bc2asm_tc)
        source "$ROOT_DIR/tests/compile_tc.sh"
        BC2ASM_TC_BC=$(compile_tc_to_bc "$TC_DIR/bc2asm.tc")
        ASM=$(mktemp /tmp/tc_XXXXXX.s)
        ELF=$(mktemp /tmp/tc_XXXXXX)
        trap "rm -f '$ASM' '$ELF'" EXIT
        { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$TC_FILE"; } | "$BCRUN" > "$ASM"
        "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$ASM" "$RUNTIME" -o "$ELF" >&2
        emit_stdin | "$QEMU" "$ELF"
        ;;

    *)
        echo "Unknown method: $METHOD" >&2
        usage
        ;;
esac

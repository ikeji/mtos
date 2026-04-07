#!/bin/bash
# test_pipeline.sh — self-hosted compiler pipeline tests + bc2asm.tc tests

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

echo "=== Pipeline Tests ==="
echo ""

# Compile Gen2 BCs
ensure_tc_bcs

# parse.tc: fib.tc
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>&1)
check_contains "pipeline[1]: parse.tc parses fib.tc → (program" "$actual" "(program"
check_contains "pipeline[1]: parse.tc parses fib.tc → (fn fib" "$actual" "(fn fib"

# parse.tc: calc.tc
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>&1)
check_contains "pipeline[1]: parse.tc parses calc.tc → (fn main" "$actual" "(fn main"

# codegen.tc: fib.tc
FIB_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null)
FIB_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$FIB_AST"; } | "$BCRUN" 2>/dev/null)
actual=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>&1)
check_contains "pipeline[2]: codegen.tc generates .fn fib" "$actual" ".fn fib i32 i32"
check_contains "pipeline[2]: codegen.tc generates .endbc" "$actual" ".endbc"

# Full pipeline: fib(10) = 55
FIB_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>/dev/null)
actual=$(printf '%s\n' "$FIB_BC" | "$BCRUN" 2>&1)
check_output "pipeline[3]: tinyc compile+run fib(10) = 55" "55" "$actual"

# Full pipeline: calc.tc (12+34*56=1916)
CALC_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>/dev/null)
CALC_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CALC_AST"; } | "$BCRUN" 2>/dev/null)
CALC_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CALC_TAST"; } | "$BCRUN" 2>/dev/null)
actual=$({ printf '%s\n' "$CALC_BC"; printf '12 + 34 * 56'; } | "$BCRUN" 2>&1)
check_output "pipeline[3]: tinyc compile+run calc.tc (12+34*56=1916)" "1916" "$actual"

# Full pipeline: break_test.tc
BREAK_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/break_test.tc"; } | "$BCRUN" 2>/dev/null)
BREAK_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$BREAK_AST"; } | "$BCRUN" 2>/dev/null)
BREAK_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$BREAK_TAST"; } | "$BCRUN" 2>/dev/null)
printf '%s\n' "$BREAK_BC" | "$BCRUN" > /dev/null 2>&1
check_output "pipeline[3]: break exits loop at i==5" "5" "$?"

# Full pipeline: continue_test.tc
CONT_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/continue_test.tc"; } | "$BCRUN" 2>/dev/null)
CONT_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CONT_AST"; } | "$BCRUN" 2>/dev/null)
CONT_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CONT_TAST"; } | "$BCRUN" 2>/dev/null)
printf '%s\n' "$CONT_BC" | "$BCRUN" > /dev/null 2>&1
check_output "pipeline[3]: continue sums odd 1-9 = 25" "25" "$?"

echo ""
echo "=== bc2asm.tc Pipeline Tests ==="
echo ""

BC2ASM_TC_BC=$(compile_tc_to_bc "$ROOT_DIR/compiler/bc2asm.tc" 2>/dev/null)

# bc2asm.tc: fib.tc → rv32
FIB_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIB_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fib_$$.s"
    elf_file="/tmp/tc_bc2asm_fib_$$"
    printf '%s\n' "$FIB_ASM_S" > "$asm_file"
    if $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        rm -f "$asm_file" "$elf_file"
        check_output "bc2asm.tc: fib(10) = 55 via rv32" "55" "$actual"
    else
        report_fail_msg "bc2asm.tc: fib(10) rv32" "compile error"; rm -f "$asm_file"
    fi
else
    report_fail_msg "bc2asm.tc: fib(10) rv32" "no asm output"
fi

# bc2asm.tc: fizzbuzz.tc → rv32
FIZZ_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fizzbuzz.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIZZ_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fizz_$$.s"
    elf_file="/tmp/tc_bc2asm_fizz_$$"
    printf '%s\n' "$FIZZ_ASM_S" > "$asm_file"
    if $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        rm -f "$asm_file" "$elf_file"
        expected="1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz"
        check_output "bc2asm.tc: FizzBuzz(15) via rv32" "$expected" "$actual"
    else
        report_fail_msg "bc2asm.tc: FizzBuzz rv32" "compile error"; rm -f "$asm_file"
    fi
else
    report_fail_msg "bc2asm.tc: FizzBuzz rv32" "no asm output"
fi

print_results

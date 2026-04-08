#!/bin/bash
# test_pipeline.sh — self-hosted compiler pipeline tests
# Tools: Gen2 (parse.tc/typecheck.tc/codegen.tc/bc2asm.tc) via bcrun
# Tests: parse→typecheck→codegen pipeline, bc2asm.tc→rv32 execution

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

echo "=== Pipeline Tests (Gen2 via bcrun: parse.tc→typecheck.tc→codegen.tc) ==="
echo ""

ensure_tc_bcs

# parse.tc: fib.tc
t0=$(time_ms)
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>&1)
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[1]: parse.tc parses fib.tc → (program [${elapsed}ms]" "$actual" "(program"
check_contains "pipeline[1]: parse.tc parses fib.tc → (fn fib" "$actual" "(fn fib"

# parse.tc: calc.tc
t0=$(time_ms)
actual=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>&1)
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[1]: parse.tc parses calc.tc → (fn main [${elapsed}ms]" "$actual" "(fn main"

# codegen.tc: fib.tc
FIB_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null)
FIB_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$FIB_AST"; } | "$BCRUN" 2>/dev/null)
t0=$(time_ms)
actual=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>&1)
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[2]: codegen.tc generates .fn fib [${elapsed}ms]" "$actual" ".fn fib i32 i32"
check_contains "pipeline[2]: codegen.tc generates .endbc" "$actual" ".endbc"

# Full pipeline: fib(10) = 55
FIB_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$FIB_TAST"; } | "$BCRUN" 2>/dev/null)
t0=$(time_ms)
actual=$(printf '%s\n' "$FIB_BC" | "$BCRUN" 2>&1)
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: tinyc compile+run fib(10) = 55 [${elapsed}ms]" "55" "$actual"

# Full pipeline: calc.tc (12+34*56=1916)
CALC_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/calc.tc"; } | "$BCRUN" 2>/dev/null)
CALC_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CALC_AST"; } | "$BCRUN" 2>/dev/null)
CALC_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CALC_TAST"; } | "$BCRUN" 2>/dev/null)
t0=$(time_ms)
actual=$({ printf '%s\n' "$CALC_BC"; printf '12 + 34 * 56'; } | "$BCRUN" 2>&1)
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: tinyc compile+run calc.tc (12+34*56=1916) [${elapsed}ms]" "1916" "$actual"

# Full pipeline: break_test.tc
BREAK_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/break_test.tc"; } | "$BCRUN" 2>/dev/null)
BREAK_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$BREAK_AST"; } | "$BCRUN" 2>/dev/null)
BREAK_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$BREAK_TAST"; } | "$BCRUN" 2>/dev/null)
t0=$(time_ms)
printf '%s\n' "$BREAK_BC" | "$BCRUN" > /dev/null 2>&1
break_exit=$?
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: break exits loop at i==5 [${elapsed}ms]" "5" "$break_exit"

# Full pipeline: continue_test.tc
CONT_AST=$({ printf '%s\n' "$PARSE_TC_BC"; cat "$SCRIPT_DIR/continue_test.tc"; } | "$BCRUN" 2>/dev/null)
CONT_TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$CONT_AST"; } | "$BCRUN" 2>/dev/null)
CONT_BC=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$CONT_TAST"; } | "$BCRUN" 2>/dev/null)
t0=$(time_ms)
printf '%s\n' "$CONT_BC" | "$BCRUN" > /dev/null 2>&1
cont_exit=$?
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: continue sums odd 1-9 = 25 [${elapsed}ms]" "25" "$cont_exit"

echo ""
echo "=== bc2asm.tc Pipeline Tests (Gen2 bc2asm.tc via bcrun → rv32) ==="
echo ""

BC2ASM_TC_BC=$(compile_tc_to_bc "$ROOT_DIR/compiler/bc2asm.tc" 2>/dev/null)

# bc2asm.tc: fib.tc → rv32
t0=$(time_ms)
FIB_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fib.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIB_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fib_$$.s"
    elf_file="/tmp/tc_bc2asm_fib_$$"
    printf '%s\n' "$FIB_ASM_S" > "$asm_file"
    if $RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/tmp/tc_bc2asm_stderr_$$)
        elapsed=$(( $(time_ms) - t0 ))
        mem=$(awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' /tmp/tc_bc2asm_stderr_$$)
        rm -f "$asm_file" "$elf_file" /tmp/tc_bc2asm_stderr_$$
        check_output "bc2asm.tc: fib(10) = 55 via rv32${mem:+ (mem: $mem)} [${elapsed}ms]" "55" "$actual"
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "bc2asm.tc: fib(10) rv32 [${elapsed}ms]" "compile error"; rm -f "$asm_file"
    fi
else
    elapsed=$(( $(time_ms) - t0 ))
    report_fail_msg "bc2asm.tc: fib(10) rv32 [${elapsed}ms]" "no asm output"
fi

# bc2asm.tc: fizzbuzz.tc → rv32
t0=$(time_ms)
FIZZ_ASM_S=$( { printf '%s\n' "$BC2ASM_TC_BC"; "$CODEGEN" "$SCRIPT_DIR/fizzbuzz.tc"; } | "$BCRUN" 2>/dev/null )
if [ -n "$FIZZ_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fizz_$$.s"
    elf_file="/tmp/tc_bc2asm_fizz_$$"
    printf '%s\n' "$FIZZ_ASM_S" > "$asm_file"
    if $RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/tmp/tc_bc2asm_stderr_$$)
        elapsed=$(( $(time_ms) - t0 ))
        mem=$(awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' /tmp/tc_bc2asm_stderr_$$)
        rm -f "$asm_file" "$elf_file" /tmp/tc_bc2asm_stderr_$$
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
        check_output "bc2asm.tc: FizzBuzz(15) via rv32${mem:+ (mem: $mem)} [${elapsed}ms]" "$expected" "$actual"
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "bc2asm.tc: FizzBuzz rv32 [${elapsed}ms]" "compile error"; rm -f "$asm_file"
    fi
else
    elapsed=$(( $(time_ms) - t0 ))
    report_fail_msg "bc2asm.tc: FizzBuzz rv32 [${elapsed}ms]" "no asm output"
fi

print_results

#!/bin/bash
# test_pipeline.sh — self-hosted compiler pipeline tests
# Tools: Gen2 (parse.tc/typecheck.tc/codegen.tc/bc2asm.tc) via qemu rv32
# Tests: parse→typecheck→codegen pipeline, bc2asm.tc→rv32 execution

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bc2asm

ensure_gen2_tools
if [ "$USE_NATIVE" != true ]; then
    echo "=== Pipeline Tests (SKIPPED — need qemu + riscv-gcc) ==="
    echo ""
    print_results
    exit 0
fi

echo "=== Pipeline Tests (Gen2 via qemu: parse.tc→typecheck.tc→codegen.tc) ==="
echo ""

# parse.tc: fib.tc
t0=$(time_ms)
actual=$(run_parse_tc "$SCRIPT_DIR/fib.tc")
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[1]: parse.tc parses fib.tc → (program [${elapsed}ms]" "$actual" "(program"
check_contains "pipeline[1]: parse.tc parses fib.tc → (fn fib" "$actual" "(fn fib"

# parse.tc: calc.tc
t0=$(time_ms)
actual=$(run_parse_tc "$SCRIPT_DIR/calc.tc")
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[1]: parse.tc parses calc.tc → (fn main [${elapsed}ms]" "$actual" "(fn main"

# codegen.tc: fib.tc (parse → typecheck → codegen)
t0=$(time_ms)
actual=$(run_parse_tc "$SCRIPT_DIR/fib.tc" | run_typecheck_tc | run_codegen_tc)
elapsed=$(( $(time_ms) - t0 ))
check_contains "pipeline[2]: codegen.tc generates .fn fib [${elapsed}ms]" "$actual" ".fn fib i32 i32"
check_contains "pipeline[2]: codegen.tc generates .endbc" "$actual" ".endbc"

# Full pipeline: fib(10) = 55 (parse → typecheck → codegen → bc2asm → gcc → qemu)
FIB_BC=$(run_parse_tc "$SCRIPT_DIR/fib.tc" | run_typecheck_tc | run_codegen_tc)
fib_s=$(mktemp /tmp/tc_pipe_XXXXXX.s)
fib_elf=$(mktemp /tmp/tc_pipe_XXXXXX)
trap "rm -f '$fib_s' '$fib_elf'" EXIT
printf '%s\n' "$FIB_BC" | run_bc2asm_tc > "$fib_s"
t0=$(time_ms)
$RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$fib_s" "$RUNTIME" -o "$fib_elf" 2>/dev/null
actual=$($QEMU "$fib_elf" 2>/dev/null)
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: tinyc compile+run fib(10) = 55 [${elapsed}ms]" "55" "$actual"

# Full pipeline: calc.tc (12+34*56=1916)
CALC_BC=$(run_parse_tc "$SCRIPT_DIR/calc.tc" | run_typecheck_tc | run_codegen_tc)
calc_s=$(mktemp /tmp/tc_pipe_XXXXXX.s)
calc_elf=$(mktemp /tmp/tc_pipe_XXXXXX)
printf '%s\n' "$CALC_BC" | run_bc2asm_tc > "$calc_s"
t0=$(time_ms)
$RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$calc_s" "$RUNTIME" -o "$calc_elf" 2>/dev/null
actual=$(printf '12 + 34 * 56' | $QEMU "$calc_elf" 2>/dev/null)
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: tinyc compile+run calc.tc (12+34*56=1916) [${elapsed}ms]" "1916" "$actual"
rm -f "$calc_s" "$calc_elf"

# Full pipeline: break_test.tc
BREAK_BC=$(run_parse_tc "$SCRIPT_DIR/break_test.tc" | run_typecheck_tc | run_codegen_tc)
break_s=$(mktemp /tmp/tc_pipe_XXXXXX.s)
break_elf=$(mktemp /tmp/tc_pipe_XXXXXX)
printf '%s\n' "$BREAK_BC" | run_bc2asm_tc > "$break_s"
t0=$(time_ms)
$RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$break_s" "$RUNTIME" -o "$break_elf" 2>/dev/null
$QEMU "$break_elf" > /dev/null 2>&1
break_exit=$?
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: break exits loop at i==5 [${elapsed}ms]" "5" "$break_exit"
rm -f "$break_s" "$break_elf"

# Full pipeline: continue_test.tc
CONT_BC=$(run_parse_tc "$SCRIPT_DIR/continue_test.tc" | run_typecheck_tc | run_codegen_tc)
cont_s=$(mktemp /tmp/tc_pipe_XXXXXX.s)
cont_elf=$(mktemp /tmp/tc_pipe_XXXXXX)
printf '%s\n' "$CONT_BC" | run_bc2asm_tc > "$cont_s"
t0=$(time_ms)
$RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$cont_s" "$RUNTIME" -o "$cont_elf" 2>/dev/null
$QEMU "$cont_elf" > /dev/null 2>&1
cont_exit=$?
elapsed=$(( $(time_ms) - t0 ))
check_output "pipeline[3]: continue sums odd 1-9 = 25 [${elapsed}ms]" "25" "$cont_exit"
rm -f "$cont_s" "$cont_elf"

echo ""
echo "=== bc2asm.tc Pipeline Tests (Gen2 bc2asm.tc via qemu → rv32) ==="
echo ""

# bc2asm.tc: fib.tc → rv32
t0=$(time_ms)
FIB_ASM_S=$("$CODEGEN" "$SCRIPT_DIR/fib.tc" 2>/dev/null | run_bc2asm_tc)
if [ -n "$FIB_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fib_$$.s"
    elf_file="/tmp/tc_bc2asm_fib_$$"
    printf '%s\n' "$FIB_ASM_S" > "$asm_file"
    if $RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        elapsed=$(( $(time_ms) - t0 ))
        rm -f "$asm_file" "$elf_file"
        check_output "bc2asm.tc: fib(10) = 55 via rv32 [${elapsed}ms]" "55" "$actual"
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
FIZZ_ASM_S=$("$CODEGEN" "$SCRIPT_DIR/fizzbuzz.tc" 2>/dev/null | run_bc2asm_tc)
if [ -n "$FIZZ_ASM_S" ]; then
    asm_file="/tmp/tc_bc2asm_fizz_$$.s"
    elf_file="/tmp/tc_bc2asm_fizz_$$"
    printf '%s\n' "$FIZZ_ASM_S" > "$asm_file"
    if $RISCV_CC "${RISCV_FLAGS[@]}" "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
        actual=$($QEMU "$elf_file" 2>/dev/null)
        elapsed=$(( $(time_ms) - t0 ))
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
        check_output "bc2asm.tc: FizzBuzz(15) via rv32 [${elapsed}ms]" "$expected" "$actual"
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "bc2asm.tc: FizzBuzz rv32 [${elapsed}ms]" "compile error"; rm -f "$asm_file"
    fi
else
    elapsed=$(( $(time_ms) - t0 ))
    report_fail_msg "bc2asm.tc: FizzBuzz rv32 [${elapsed}ms]" "no asm output"
fi

cleanup_gen2_tools
print_results

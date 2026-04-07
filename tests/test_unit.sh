#!/bin/bash
# test_unit.sh — unit-level tests
# Tools: Gen1 (C) parse, typecheck, codegen, interp, bcrun, bc2asm, riscv-gcc, qemu
# Tests: output contains-checks, execution output/exit-code checks

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse typecheck codegen bcrun bc2asm interp

echo "=== Unit Tests (Gen1 tools: parse/typecheck/codegen/interp/bcrun/rv32) ==="
echo ""

# Helper: run command, compare output, show time
run_test() {
    local name="$1" cmd="$2" expected="$3"
    local t0 actual elapsed
    t0=$(time_ms)
    actual=$(eval "$cmd" 2>&1)
    elapsed=$(( $(time_ms) - t0 ))
    if [ "$actual" = "$expected" ]; then
        report_pass "$name" "$elapsed"
    else
        echo "FAIL: $name [${elapsed}ms]"
        echo "  expected: $(echo "$expected" | head -3)"
        echo "  actual:   $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

run_test_exit() {
    local name="$1" cmd="$2" expected_exit="$3"
    local t0 elapsed
    t0=$(time_ms)
    eval "$cmd" > /dev/null 2>&1
    local actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if [ "$actual_exit" = "$expected_exit" ]; then
        report_pass "$name" "$elapsed"
    else
        report_fail_msg "$name [${elapsed}ms]" "expected exit: $expected_exit, got: $actual_exit"
    fi
}

run_test_contains() {
    local name="$1" cmd="$2" expected="$3"
    local t0 actual elapsed
    t0=$(time_ms)
    actual=$(eval "$cmd" 2>&1)
    elapsed=$(( $(time_ms) - t0 ))
    if echo "$actual" | grep -qF "$expected"; then
        report_pass "$name" "$elapsed"
    else
        echo "FAIL: $name [${elapsed}ms]"
        echo "  expected to contain: $expected"
        echo "  actual: $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

# Helper: compile .tc → rv32 ELF and run with qemu, show time + memory
run_rv32() {
    local name="$1" tc="$2" expected="$3"
    local asm="/tmp/tc_rv32_$$.s" elf="/tmp/tc_rv32_$$"
    local t0 elapsed
    t0=$(time_ms)
    $BC2ASM <($CODEGEN "$tc") > "$asm" 2>/dev/null || { elapsed=$(( $(time_ms) - t0 )); report_fail_msg "$name [${elapsed}ms]" "codegen/bc2asm failed"; return; }
    $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm" "$RUNTIME" -o "$elf" 2>/dev/null || { elapsed=$(( $(time_ms) - t0 )); report_fail_msg "$name [${elapsed}ms]" "compile failed"; rm -f "$asm" "$elf"; return; }
    actual=$($QEMU "$elf" 2>/tmp/tc_rv32_stderr_$$ )
    elapsed=$(( $(time_ms) - t0 ))
    local mem
    mem=$(awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' /tmp/tc_rv32_stderr_$$)
    rm -f "$asm" "$elf" /tmp/tc_rv32_stderr_$$
    if [ "$actual" = "$expected" ]; then
        report_pass "$name${mem:+ (mem: $mem)}" "$elapsed"
    else
        echo "FAIL: $name [${elapsed}ms]"
        echo "  expected: $(echo "$expected" | head -3)"
        echo "  actual:   $(echo "$actual" | head -3)"
        FAIL=$((FAIL + 1))
    fi
}

# --- Parse tests ---
run_test_contains "parse hello.tc produces program" \
    "$PARSE $SCRIPT_DIR/hello.tc" "(program"
run_test_contains "parse hello.tc has fn main" \
    "$PARSE $SCRIPT_DIR/hello.tc" "(fn main"

# --- Typecheck tests ---
run_test_contains "typecheck hello.tc has :U8Array annotation" \
    "$TYPECHECK $SCRIPT_DIR/hello.tc" ":U8Array"
run_test_contains "typecheck fib.tc has :i32 annotations" \
    "$TYPECHECK $SCRIPT_DIR/fib.tc" ":i32"

# --- Interp tests ---
run_test "hello world output" "$INTERP $SCRIPT_DIR/hello.tc" "Hello, World"
run_test "fib(10) prints 55" "$INTERP $SCRIPT_DIR/fib.tc" "55"
run_test_exit "fib exit code 55" "$INTERP $SCRIPT_DIR/fib.tc" 55

# --- Codegen tests ---
run_test_contains "codegen fib.tc has .fn fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" ".fn fib i32 i32"
run_test_contains "codegen fib.tc has call fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" "call fib i32"
run_test_contains "codegen hello.tc has .fn main" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" ".fn main i32"
run_test_contains "codegen hello.tc has call sys_write" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" "call sys_write i32 U8Array i32"

# --- bcrun tests ---
run_test "bcrun hello world" "$CODEGEN $SCRIPT_DIR/hello.tc | $BCRUN" "Hello, World"
run_test "bcrun fib(10) prints 55" "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" "55"
run_test_exit "bcrun fib exit code 55" "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" 55

# --- rv32 tests ---
run_rv32 "rv32 fib(10) prints 55" "$SCRIPT_DIR/fib.tc" "55"
run_rv32 "rv32 FizzBuzz(15)" "$SCRIPT_DIR/fizzbuzz.tc" "1
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

# --- else if tests ---
run_test "interp else if chain (classify)" "$INTERP $SCRIPT_DIR/elseif_test.tc" "0
1
2
3"
run_test "bcrun else if chain (classify)" "$CODEGEN $SCRIPT_DIR/elseif_test.tc | $BCRUN" "0
1
2
3"

# --- character literal tests ---
run_test "interp character literals (A=65 Z=90 \\n=10 \\t=9 '=39)" \
    "$INTERP $SCRIPT_DIR/charliteral_test.tc" "65
90
10
9
39"
run_test "bcrun character literals (A=65 Z=90 \\n=10 \\t=9 '=39)" \
    "$CODEGEN $SCRIPT_DIR/charliteral_test.tc | $BCRUN" "65
90
10
9
39"

# --- break / continue tests ---
run_test_exit "interp break exits loop at i==5" "$INTERP $SCRIPT_DIR/break_test.tc" 5
run_test_exit "interp continue sums odd 1-9 = 25" "$INTERP $SCRIPT_DIR/continue_test.tc" 25
run_test_exit "interp nested break only exits inner loop (result=6)" "$INTERP $SCRIPT_DIR/nested_break_test.tc" 6
run_test_exit "bcrun break exits loop at i==5" "$CODEGEN $SCRIPT_DIR/break_test.tc | $BCRUN" 5
run_test_exit "bcrun continue sums odd 1-9 = 25" "$CODEGEN $SCRIPT_DIR/continue_test.tc | $BCRUN" 25
run_test_exit "bcrun nested break only exits inner loop (result=6)" "$CODEGEN $SCRIPT_DIR/nested_break_test.tc | $BCRUN" 6

print_results

#!/bin/bash
# test_unit.sh — unit-level tests: parse, typecheck, codegen, interp, bcrun, rv32

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse typecheck codegen bcrun bc2asm interp

echo "=== Unit Tests ==="
echo ""

# Helper: run command, compare output
run_test() {
    local name="$1" cmd="$2" expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    check_output "$name" "$expected" "$actual"
}

run_test_exit() {
    local name="$1" cmd="$2" expected_exit="$3"
    eval "$cmd" > /dev/null 2>&1
    local actual_exit=$?
    if [ "$actual_exit" = "$expected_exit" ]; then
        echo "PASS: $name"; PASS=$((PASS + 1))
    else
        report_fail_msg "$name" "expected exit: $expected_exit, got: $actual_exit"
    fi
}

run_test_contains() {
    local name="$1" cmd="$2" expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    check_contains "$name" "$actual" "$expected"
}

# Helper: compile .tc → rv32 ELF and run with qemu
run_rv32() {
    local name="$1" tc="$2" expected="$3"
    local asm="/tmp/tc_rv32_$$.s" elf="/tmp/tc_rv32_$$"
    $BC2ASM <($CODEGEN "$tc") > "$asm" 2>/dev/null || { report_fail_msg "$name" "codegen/bc2asm failed"; return; }
    $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm" "$RUNTIME" -o "$elf" 2>/dev/null || { report_fail_msg "$name" "compile failed"; rm -f "$asm" "$elf"; return; }
    actual=$($QEMU "$elf" 2>/dev/null)
    rm -f "$asm" "$elf"
    check_output "$name" "$expected" "$actual"
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

#!/bin/bash
# Test runner for ToyC interpreter

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
INTERP="$ROOT_DIR/interp"
PARSE="$ROOT_DIR/parse"
TYPECHECK="$ROOT_DIR/typecheck"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"
RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$ROOT_DIR/src/runtime_syscall.c"
CRT0="$ROOT_DIR/src/crt0.s"
QEMU="qemu-riscv32"

# Helper: compile .tc → rv32 ELF and run with qemu
run_rv32() {
    local name="$1" tc="$2" expected="$3"
    local asm="/tmp/tc_rv32_$$.s" elf="/tmp/tc_rv32_$$"
    $BC2ASM <($CODEGEN "$tc") > "$asm" 2>/dev/null || { echo "FAIL: $name (codegen/bc2asm)"; FAIL=$((FAIL+1)); return; }
    $RISCV_CC $RISCV_FLAGS "$CRT0" "$asm" "$RUNTIME" -o "$elf" 2>/dev/null || { echo "FAIL: $name (compile)"; FAIL=$((FAIL+1)); rm -f "$asm" "$elf"; return; }
    actual=$($QEMU "$elf" 2>/dev/null)
    rm -f "$asm" "$elf"
    if [ "$actual" = "$expected" ]; then echo "PASS: $name"; PASS=$((PASS+1));
    else echo "FAIL: $name"; echo "  expected: $(echo "$expected" | head -2)"; echo "  actual:   $(echo "$actual" | head -2)"; FAIL=$((FAIL+1)); fi
}

PASS=0
FAIL=0

run_test() {
    local name="$1"
    local cmd="$2"
    local expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    if [ "$actual" = "$expected" ]; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected: $(echo "$expected" | head -3)"
        echo "  actual:   $(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

run_test_exit() {
    local name="$1"
    local cmd="$2"
    local expected_exit="$3"
    eval "$cmd" > /dev/null 2>&1
    local actual_exit=$?
    if [ "$actual_exit" = "$expected_exit" ]; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected exit: $expected_exit, got: $actual_exit"
        FAIL=$((FAIL+1))
    fi
}

run_test_contains() {
    local name="$1"
    local cmd="$2"
    local expected="$3"
    local actual
    actual=$(eval "$cmd" 2>&1)
    if echo "$actual" | grep -qF "$expected"; then
        echo "PASS: $name"
        PASS=$((PASS+1))
    else
        echo "FAIL: $name"
        echo "  expected to contain: $expected"
        echo "  actual: $(echo "$actual" | head -3)"
        FAIL=$((FAIL+1))
    fi
}

echo "=== ToyC Test Suite ==="
echo ""

# Test: parse hello.tc produces a program node
run_test_contains "parse hello.tc produces program" \
    "$PARSE $SCRIPT_DIR/hello.tc" \
    "(program"

# Test: parse hello.tc contains fn main
run_test_contains "parse hello.tc has fn main" \
    "$PARSE $SCRIPT_DIR/hello.tc" \
    "(fn main"

# Test: typecheck hello.tc produces typed annotations
run_test_contains "typecheck hello.tc has :U8Array annotation" \
    "$TYPECHECK $SCRIPT_DIR/hello.tc" \
    ":U8Array"

# Test: typecheck fib.tc has :i32 annotations
run_test_contains "typecheck fib.tc has :i32 annotations" \
    "$TYPECHECK $SCRIPT_DIR/fib.tc" \
    ":i32"

# Test: hello world output
run_test "hello world output" \
    "$INTERP $SCRIPT_DIR/hello.tc" \
    "Hello, World"

# Test: fib(10) = 55
run_test "fib(10) prints 55" \
    "$INTERP $SCRIPT_DIR/fib.tc" \
    "55"

# Test: fib exit code
run_test_exit "fib exit code 55" \
    "$INTERP $SCRIPT_DIR/fib.tc" \
    55

# Test: codegen fib.tc produces .fn directive
run_test_contains "codegen fib.tc has .fn fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" \
    ".fn fib 1 i32"

# Test: codegen fib.tc has call instruction
run_test_contains "codegen fib.tc has call fib" \
    "$CODEGEN $SCRIPT_DIR/fib.tc" \
    "call fib 1"

# Test: codegen hello.tc produces .fn main
run_test_contains "codegen hello.tc has .fn main" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" \
    ".fn main 0 i32"

# Test: codegen hello.tc has call sys_write
run_test_contains "codegen hello.tc has call sys_write" \
    "$CODEGEN $SCRIPT_DIR/hello.tc" \
    "call sys_write 3"

# Test: codegen | bcrun pipeline — hello world
run_test "bcrun hello world" \
    "$CODEGEN $SCRIPT_DIR/hello.tc | $BCRUN" \
    "Hello, World"

# Test: codegen | bcrun pipeline — fib(10) = 55
run_test "bcrun fib(10) prints 55" \
    "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" \
    "55"

# Test: bcrun fib exit code
run_test_exit "bcrun fib exit code 55" \
    "$CODEGEN $SCRIPT_DIR/fib.tc | $BCRUN" \
    55

# Test: bc2asm pipeline — fib(10) = 55 on real RISC-V
run_rv32 "rv32 fib(10) prints 55" \
    "$SCRIPT_DIR/fib.tc" \
    "55"

# Test: bc2asm pipeline — FizzBuzz on real RISC-V
run_rv32 "rv32 FizzBuzz(15)" \
    "$SCRIPT_DIR/fizzbuzz.tc" \
    "1
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

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1

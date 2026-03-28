#!/bin/bash
# Test runner for ToyC interpreter

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
INTERP="$ROOT_DIR/interp"
PARSE="$ROOT_DIR/parse"
TYPECHECK="$ROOT_DIR/typecheck"

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

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1

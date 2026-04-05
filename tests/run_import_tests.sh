#!/bin/bash
# Tests for multi-file import support

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
IMPORT_DIR="$SCRIPT_DIR/import"
COMPILER_DIR="$ROOT_DIR/bootstrap"

CODEGEN="$ROOT_DIR/codegen"
BC2ASM="$ROOT_DIR/bc2asm"

RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"
QEMU="qemu-riscv32"

PASS=0
FAIL=0

time_ms() { date +%s%3N; }

report_pass() {
    local name="$1"
    local elapsed="$2"
    echo "PASS: $name [${elapsed}ms]"
    PASS=$((PASS + 1))
}

report_fail() {
    local name="$1"
    local msg="$2"
    local elapsed="$3"
    echo "FAIL: $name${elapsed:+ [${elapsed}ms]}"
    [ -n "$msg" ] && echo "  $msg"
    FAIL=$((FAIL + 1))
}

if [ ! -x "$CODEGEN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: tools (codegen, bc2asm) not found. Build them first." >&2
    exit 1
fi

HAS_RV=false
if command -v "$RISCV_CC" >/dev/null 2>&1 && command -v "$QEMU" >/dev/null 2>&1; then
    HAS_RV=true
fi

# compile_tc: compile a .tc file to .s
# usage: compile_tc input.tc output.s
compile_tc() {
    local input="$1"
    local output="$2"
    "$CODEGEN" "$input" 2>/dev/null | "$BC2ASM" > "$output" 2>/dev/null
}

# link_and_run: link .s files and run, capture output and exit code
# usage: link_and_run output_var exit_var file1.s file2.s ...
link_and_run() {
    local out_file="$1"; shift
    local exit_file="$1"; shift
    local elf=$(mktemp)
    if ! "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$RUNTIME" "$@" -o "$elf" 2>/dev/null; then
        echo "link failed" > "$exit_file"
        rm -f "$elf"
        return 1
    fi
    "$QEMU" "$elf" > "$out_file" 2>/dev/null
    echo $? > "$exit_file"
    rm -f "$elf"
    return 0
}

echo "=== Import Tests ==="

# --- Test 1: Basic import (export fn) ---
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/lib.tc" "$TMP/lib.s"
    compile_tc "$IMPORT_DIR/main_basic.tc" "$TMP/main.s"
    actual_out="$TMP/out"
    actual_exit="$TMP/exit"
    if link_and_run "$actual_out" "$actual_exit" "$TMP/lib.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$actual_out")
        ex=$(cat "$actual_exit")
        if [ "$out" = "14" ] && [ "$ex" = "0" ]; then
            report_pass "basic import (export fn)" "$elapsed"
        else
            report_fail "basic import (export fn)" "expected output '14' exit 0, got '$out' exit $ex" "$elapsed"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail "basic import (export fn)" "link failed" "$elapsed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: basic import (RISC-V toolchain not found)"
fi

# --- Test 2: Struct type import (compile-only, no link/run) ---
# Note: User-defined structs don't have RISC-V runtime support for auto-generated
# functions (constructor, getter/setter), so we test compilation only.
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_struct.tc" >/dev/null 2>&1
result=$?
elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -eq 0 ]; then
    report_pass "struct type import (compile)" "$elapsed"
else
    report_fail "struct type import (compile)" "codegen failed" "$elapsed"
fi

# --- Test 3: No transitive import ---
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/inner.tc" "$TMP/inner.s"
    compile_tc "$IMPORT_DIR/middle.tc" "$TMP/middle.s"
    compile_tc "$IMPORT_DIR/main_no_transitive.tc" "$TMP/main.s"
    actual_out="$TMP/out"
    actual_exit="$TMP/exit"
    if link_and_run "$actual_out" "$actual_exit" "$TMP/inner.s" "$TMP/middle.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$actual_out")
        ex=$(cat "$actual_exit")
        if [ "$out" = "77" ] && [ "$ex" = "0" ]; then
            report_pass "no transitive import (a->b->c, a sees b only)" "$elapsed"
        else
            report_fail "no transitive import" "expected output '77' exit 0, got '$out' exit $ex" "$elapsed"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail "no transitive import" "link failed" "$elapsed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: no transitive import (RISC-V toolchain not found)"
fi

# --- Test 4: Calling non-export fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_secret_fail.tc" >/dev/null 2>&1
result=$?
elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "non-export fn rejected" "$elapsed"
else
    report_fail "non-export fn rejected" "expected compile error but codegen succeeded" "$elapsed"
fi

# --- Test 5: Transitive import fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_transitive_fail.tc" >/dev/null 2>&1
result=$?
elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "transitive import fn rejected" "$elapsed"
else
    report_fail "transitive import fn rejected" "expected compile error but codegen succeeded" "$elapsed"
fi

# --- Test 6: Struct auto-generated fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_struct_fail.tc" >/dev/null 2>&1
result=$?
elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "struct auto-generated fn rejected" "$elapsed"
else
    report_fail "struct auto-generated fn rejected" "expected compile error but codegen succeeded" "$elapsed"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1

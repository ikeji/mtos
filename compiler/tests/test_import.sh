#!/bin/bash
# test_import.sh — tests for multi-file import support

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools codegen bc2asm

IMPORT_DIR="$SCRIPT_DIR/import"

HAS_RV=false
if command -v "$RISCV_CC" >/dev/null 2>&1 && command -v "$QEMU" >/dev/null 2>&1; then
    HAS_RV=true
fi

compile_tc() {
    local input="$1" output="$2"
    "$CODEGEN" "$input" 2>/dev/null | "$BC2ASM" > "$output" 2>/dev/null
}

link_and_run() {
    local out_file="$1"; shift
    local exit_file="$1"; shift
    local elf=$(mktemp)
    if ! "$RISCV_CC" "${RISCV_FLAGS[@]}" "$CRT0" "$RUNTIME" "$@" -o "$elf" 2>/dev/null; then
        echo "link failed" > "$exit_file"
        rm -f "$elf"
        return 1
    fi
    "$QEMU" "$elf" > "$out_file" 2>/dev/null
    echo $? > "$exit_file"
    rm -f "$elf"
    return 0
}

echo "=== Import Tests (multi-file import/export via rv32) ==="

# --- Test 1: Basic import (export fn) ---
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/lib.tc" "$TMP/lib.s"
    compile_tc "$IMPORT_DIR/main_basic.tc" "$TMP/main.s"
    if link_and_run "$TMP/out" "$TMP/exit" "$TMP/lib.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$TMP/out"); ex=$(cat "$TMP/exit")
        if [ "$out" = "14" ] && [ "$ex" = "0" ]; then
            report_pass "basic import (export fn)" "$elapsed"
        else
            report_fail_msg "basic import (export fn)" "expected output '14' exit 0, got '$out' exit $ex"
        fi
    else
        report_fail_msg "basic import (export fn)" "link failed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: basic import (RISC-V toolchain not found)"
fi

# --- Test 2: Struct type import (compile-only) ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_struct.tc" >/dev/null 2>&1
result=$?
elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -eq 0 ]; then
    report_pass "struct type import (compile)" "$elapsed"
else
    report_fail_msg "struct type import (compile)" "codegen failed"
fi

# --- Test 3: No transitive import ---
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/inner.tc" "$TMP/inner.s"
    compile_tc "$IMPORT_DIR/middle.tc" "$TMP/middle.s"
    compile_tc "$IMPORT_DIR/main_no_transitive.tc" "$TMP/main.s"
    if link_and_run "$TMP/out" "$TMP/exit" "$TMP/inner.s" "$TMP/middle.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$TMP/out"); ex=$(cat "$TMP/exit")
        if [ "$out" = "77" ] && [ "$ex" = "0" ]; then
            report_pass "no transitive import (a->b->c, a sees b only)" "$elapsed"
        else
            report_fail_msg "no transitive import" "expected output '77' exit 0, got '$out' exit $ex"
        fi
    else
        report_fail_msg "no transitive import" "link failed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: no transitive import (RISC-V toolchain not found)"
fi

# --- Test 4: Calling non-export fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_secret_fail.tc" >/dev/null 2>&1
result=$?; elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "non-export fn rejected" "$elapsed"
else
    report_fail_msg "non-export fn rejected" "expected compile error but codegen succeeded"
fi

# --- Test 5: Transitive import fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_transitive_fail.tc" >/dev/null 2>&1
result=$?; elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "transitive import fn rejected" "$elapsed"
else
    report_fail_msg "transitive import fn rejected" "expected compile error but codegen succeeded"
fi

# --- Test 6: Struct auto-generated fn should fail ---
t0=$(time_ms)
"$CODEGEN" "$IMPORT_DIR/main_struct_fail.tc" >/dev/null 2>&1
result=$?; elapsed=$(( $(time_ms) - t0 ))
if [ "$result" -ne 0 ]; then
    report_pass "struct auto-generated fn rejected" "$elapsed"
else
    report_fail_msg "struct auto-generated fn rejected" "expected compile error but codegen succeeded"
fi

# --- Test 7: Deep import (A → B → C, compile + run via bcrun) ---
t0=$(time_ms)
BC=$(compile_tc_to_bc "$IMPORT_DIR/main_deep.tc")
actual=$(printf '%s\n' "$BC" | "$BCRUN" 2>/dev/null)
elapsed=$(( $(time_ms) - t0 ))
if [ "$actual" = "15" ]; then
    report_pass "deep import (A→B→C via bcrun)" "$elapsed"
else
    report_fail_msg "deep import (A→B→C via bcrun)" "expected '15', got '$actual'"
fi

# --- Test 8: Deep import (A → B → C, compile + run via rv32) ---
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/deep_c.tc" "$TMP/deep_c.s"
    compile_tc "$IMPORT_DIR/deep_b.tc" "$TMP/deep_b.s"
    compile_tc "$IMPORT_DIR/main_deep.tc" "$TMP/main.s"
    if link_and_run "$TMP/out" "$TMP/exit" "$TMP/deep_c.s" "$TMP/deep_b.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$TMP/out"); ex=$(cat "$TMP/exit")
        if [ "$out" = "15" ] && [ "$ex" = "0" ]; then
            report_pass "deep import (A→B→C via rv32)" "$elapsed"
        else
            report_fail_msg "deep import (A→B→C via rv32)" "expected output '15' exit 0, got '$out' exit $ex"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "deep import (A→B→C via rv32)" "link failed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: deep import rv32 (RISC-V toolchain not found)"
fi

# --- Test 9: export forward decl exposes struct synthetic fns ---
# struct_export.tc declares `struct Point` and adds `export fn`
# forward declarations whose signatures match the parser-generated
# synthetic constructor / getters / setters. The forward decls promote
# those synthetics to export linkage, so main_struct_export.tc can
# call Point() / x(p) / y(p) / x(p, v) directly.  See
# design_decisions.md #1 for the rationale.
if [ "$HAS_RV" = true ]; then
    TMP=$(mktemp -d)
    t0=$(time_ms)
    compile_tc "$IMPORT_DIR/struct_export.tc" "$TMP/struct_export.s"
    compile_tc "$IMPORT_DIR/main_struct_export.tc" "$TMP/main.s"
    if link_and_run "$TMP/out" "$TMP/exit" "$TMP/struct_export.s" "$TMP/main.s"; then
        elapsed=$(( $(time_ms) - t0 ))
        out=$(cat "$TMP/out"); ex=$(cat "$TMP/exit")
        if [ "$ex" = "0" ]; then
            report_pass "export forward-decl exposes synthetic fn" "$elapsed"
        else
            report_fail_msg "export forward-decl exposes synthetic fn" "expected exit 0, got '$out' exit $ex"
        fi
    else
        elapsed=$(( $(time_ms) - t0 ))
        report_fail_msg "export forward-decl exposes synthetic fn" "link failed"
    fi
    rm -rf "$TMP"
else
    echo "SKIP: export forward-decl exposes synthetic fn (RISC-V toolchain not found)"
fi

print_results

#!/bin/bash
# test_golden_compiler.sh — golden tests for compiler/ source files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

ensure_gen2_tools
if [ "$USE_NATIVE" = true ]; then
    echo "Using RISC-V native execution for self-hosted tests (fast mode)"
else
    ensure_tc_bcs
fi

echo "=== Golden Tests: tc/ Compiler Sources (Gen1 C vs Gen2${USE_NATIVE:+, rv32 native}) ==="

for f in "${TC_FILES[@]}"; do
    input="$TC_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping tc/$f (not found)..."
        continue
    fi

    golden_ast="$GOLDEN_DIR/tc/$base.ast"
    golden_bc="$GOLDEN_DIR/tc/$base.bc"
    golden_s="$GOLDEN_DIR/tc/$base.s"
    golden_out="$GOLDEN_DIR/tc/$base.out"
    golden_exit="$GOLDEN_DIR/tc/$base.exit"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ] || [ ! -f "$golden_out" ] || [ ! -f "$golden_exit" ]; then
        report_fail_msg "tc/$f" "Golden files missing"
        continue
    fi

    # --- 1. AST Checks ---
    actual_ast=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual_ast" > /dev/null; then
        report_pass "tc/$f (AST - C)" "$elapsed"
    else
        report_fail_diff "tc/$f (AST - C)" "$golden_ast" "$actual_ast" "" "$elapsed"
    fi

    golden_ast_tc="$GOLDEN_DIR/tc/$base.ast.tc"
    [ -f "$golden_ast_tc" ] || golden_ast_tc="$golden_ast"
    t0=$(time_ms)
    run_parse_tc "$input" > "$actual_ast"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast_tc" "$actual_ast" > /dev/null; then
        report_pass "tc/$f (AST - parse.tc)" "$elapsed"
    else
        report_fail_diff "tc/$f (AST - parse.tc)" "$golden_ast_tc" "$actual_ast" "" "$elapsed"
    fi
    rm -f "$actual_ast"

    # --- 2. BC Checks ---
    actual_bc=$(mktemp)
    t0=$(time_ms)
    "$CODEGEN" "$input" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        report_pass "tc/$f (BC - C)" "$elapsed"
    else
        report_fail_diff "tc/$f (BC - C)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi

    golden_bc_tc="$GOLDEN_DIR/tc/$base.bc.tc"
    [ -f "$golden_bc_tc" ] || golden_bc_tc="$golden_bc"
    AST=$("$PARSE" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$AST" | run_typecheck_tc | run_codegen_tc > "$actual_bc"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc_tc" "$actual_bc" > /dev/null; then
        report_pass "tc/$f (BC - codegen.tc)" "$elapsed"
    else
        report_fail_diff "tc/$f (BC - codegen.tc)" "$golden_bc_tc" "$actual_bc" "" "$elapsed"
    fi
    rm -f "$actual_bc"

    # --- 3. ASM Checks ---
    actual_s=$(mktemp)
    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        report_pass "tc/$f (ASM - C)" "$elapsed"
    else
        report_fail_diff "tc/$f (ASM - C)" "$golden_s" "$actual_s" "" "$elapsed"
    fi

    t0=$(time_ms)
    printf '%s\n' "$bc" | run_bc2asm_tc > "$actual_s"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        report_pass "tc/$f (ASM - bc2asm.tc)" "$elapsed"
    else
        report_fail_diff "tc/$f (ASM - bc2asm.tc)" "$golden_s" "$actual_s" "" "$elapsed"
    fi
    rm -f "$actual_s"

    # --- 4. Execution Checks (bcrun) ---
    expected_exit=$(cat "$golden_exit")
    actual_out=$(mktemp)
    exec_input_file=$(get_tc_exec_input_file "$f")

    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc"; cat "$exec_input_file"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        report_pass "tc/$f (Exec - bcrun C)" "$elapsed"
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail_diff "tc/$f (Exec - bcrun C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi
    rm -f "$actual_out"
done

cleanup_gen2_tools
print_results

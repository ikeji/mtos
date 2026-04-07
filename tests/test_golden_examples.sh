#!/bin/bash
# test_golden_examples.sh — golden tests for example .tc files

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

ensure_tc_bcs

echo "=== Golden Tests: Example Files (Gen1 C vs Gen2 self-hosted, golden diff) ==="

for f in "${EXAMPLE_FILES[@]}"; do
    input="$SCRIPT_DIR/$f"
    base="${f%.tc}"

    if [ ! -f "$input" ]; then
        echo "Skipping $f (not found)..."
        continue
    fi

    golden_ast="$GOLDEN_DIR/$base.ast"
    golden_bc="$GOLDEN_DIR/$base.bc"
    golden_s="$GOLDEN_DIR/$base.s"
    golden_out="$GOLDEN_DIR/$base.out"
    golden_exit="$GOLDEN_DIR/$base.exit"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ] || [ ! -f "$golden_out" ] || [ ! -f "$golden_exit" ]; then
        report_fail_msg "$f" "Golden files missing"
        continue
    fi

    # --- 1. AST Checks ---
    actual_ast=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual_ast" > /dev/null; then
        report_pass "$f (AST - C)" "$elapsed"
    else
        report_fail_diff "$f (AST - C)" "$golden_ast" "$actual_ast" "" "$elapsed"
    fi

    golden_ast_tc="$GOLDEN_DIR/$base.ast.tc"
    [ -f "$golden_ast_tc" ] || golden_ast_tc="$golden_ast"
    t0=$(time_ms)
    { printf '%s\n' "$PARSE_TC_BC"; cat "$input"; } | "$BCRUN" > "$actual_ast" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast_tc" "$actual_ast" > /dev/null; then
        report_pass "$f (AST - parse.tc)" "$elapsed"
    else
        report_fail_diff "$f (AST - parse.tc)" "$golden_ast_tc" "$actual_ast" "" "$elapsed"
    fi
    rm -f "$actual_ast"

    # --- 2. BC Checks ---
    actual_bc=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" 2>/dev/null | "$CODEGEN" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        report_pass "$f (BC - C)" "$elapsed"
    else
        report_fail_diff "$f (BC - C)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$AST"; } | "$BCRUN" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$TAST"; } | "$BCRUN" > "$actual_bc" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual_bc" > /dev/null; then
        report_pass "$f (BC - codegen.tc)" "$elapsed"
    else
        report_fail_diff "$f (BC - codegen.tc)" "$golden_bc" "$actual_bc" "" "$elapsed"
    fi
    rm -f "$actual_bc"

    # --- 3. ASM Checks ---
    actual_s=$(mktemp)
    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        report_pass "$f (ASM - C)" "$elapsed"
    else
        report_fail_diff "$f (ASM - C)" "$golden_s" "$actual_s" "" "$elapsed"
    fi

    t0=$(time_ms)
    { printf '%s\n' "$BC2ASM_TC_BC"; printf '%s\n' "$bc"; } | "$BCRUN" > "$actual_s" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual_s" > /dev/null; then
        report_pass "$f (ASM - bc2asm.tc)" "$elapsed"
    else
        report_fail_diff "$f (ASM - bc2asm.tc)" "$golden_s" "$actual_s" "" "$elapsed"
    fi
    rm -f "$actual_s"

    # --- 4. Execution Checks (bcrun) ---
    stdin=$(get_stdin "$f")
    expected_exit=$(cat "$golden_exit")
    actual_out=$(mktemp)

    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        report_pass "$f (Exec - bcrun C)" "$elapsed"
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail_diff "$f (Exec - bcrun C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi

    AST=$("$PARSE" "$input" 2>/dev/null)
    TAST=$({ printf '%s\n' "$TYPECHECK_TC_BC"; printf '%s\n' "$AST"; } | "$BCRUN" 2>/dev/null)
    bc_tc=$({ printf '%s\n' "$CODEGEN_TC_BC"; printf '%s\n' "$TAST"; } | "$BCRUN" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc_tc"; echo -n "$stdin"; } | "$BCRUN" > "$actual_out" 2>/dev/null
    actual_exit_tc=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit_tc" -eq "$expected_exit" ]; then
        report_pass "$f (Exec - bcrun tc)" "$elapsed"
    else
        msg=""
        [ "$actual_exit_tc" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit_tc"
        report_fail_diff "$f (Exec - bcrun tc)" "$golden_out" "$actual_out" "$msg" "$elapsed"
    fi
    rm -f "$actual_out"

    # --- 5. Execution Checks (RISC-V) ---
    if command -v "$RISCV_CC" >/dev/null && command -v "$QEMU" >/dev/null; then
        asm_file=$(mktemp --suffix=.s)
        elf_file=$(mktemp)

        bc=$("$CODEGEN" "$input" 2>/dev/null)
        printf '%s\n' "$bc" | "$BC2ASM" > "$asm_file" 2>/dev/null
        if "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
            actual_out=$(mktemp)
            t0=$(time_ms)
            echo -n "$stdin" | "$QEMU" "$elf_file" > "$actual_out" 2>/dev/null
            actual_exit=$?
            elapsed=$(( $(time_ms) - t0 ))
            if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
                report_pass "$f (Exec - rv32 C)" "$elapsed"
            else
                msg=""
                [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
                report_fail_diff "$f (Exec - rv32 C)" "$golden_out" "$actual_out" "$msg" "$elapsed"
            fi
            rm -f "$actual_out"
        else
            report_fail_msg "$f (Exec - rv32 C)" "compilation error"
        fi

        bc=$("$CODEGEN" "$input" 2>/dev/null)
        { printf '%s\n' "$BC2ASM_TC_BC"; printf '%s\n' "$bc"; } | "$BCRUN" > "$asm_file" 2>/dev/null
        if "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
            actual_out=$(mktemp)
            t0=$(time_ms)
            echo -n "$stdin" | "$QEMU" "$elf_file" > "$actual_out" 2>/dev/null
            actual_exit=$?
            elapsed=$(( $(time_ms) - t0 ))
            if diff -u "$golden_out" "$actual_out" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
                report_pass "$f (Exec - rv32 tc)" "$elapsed"
            else
                msg=""
                [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
                report_fail_diff "$f (Exec - rv32 tc)" "$golden_out" "$actual_out" "$msg" "$elapsed"
            fi
            rm -f "$actual_out"
        else
            report_fail_msg "$f (Exec - rv32 tc)" "compilation error"
        fi
        rm -f "$asm_file" "$elf_file"
    fi
done

print_results

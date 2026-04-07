#!/bin/bash
# test_golden_examples.sh — golden tests for example .tc files
# Tools: Gen1 (C) parse, codegen, bc2asm, bcrun, riscv-gcc, qemu
# Tests: Gen1 output vs golden files (AST, BC, ASM, execution)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

echo "=== Golden Tests: Example Files (Gen1 C tools vs golden) ==="

for f in "${EXAMPLE_FILES[@]}"; do
    input="$SCRIPT_DIR/$f"
    base="${f%.tc}"

    [ -f "$input" ] || { echo "Skipping $f (not found)..."; continue; }

    golden_ast="$GOLDEN_DIR/$base.ast"
    golden_bc="$GOLDEN_DIR/$base.bc"
    golden_s="$GOLDEN_DIR/$base.s"
    golden_out="$GOLDEN_DIR/$base.out"
    golden_exit="$GOLDEN_DIR/$base.exit"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ] || [ ! -f "$golden_out" ] || [ ! -f "$golden_exit" ]; then
        report_fail_msg "$f" "Golden files missing"
        continue
    fi

    # --- AST ---
    actual=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual" > /dev/null; then
        report_pass "$f (AST)" "$elapsed"
    else
        report_fail_diff "$f (AST)" "$golden_ast" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # --- BC ---
    actual=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" 2>/dev/null | "$CODEGEN" > "$actual" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual" > /dev/null; then
        report_pass "$f (BC)" "$elapsed"
    else
        report_fail_diff "$f (BC)" "$golden_bc" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # --- ASM ---
    actual=$(mktemp)
    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual" > /dev/null; then
        report_pass "$f (ASM)" "$elapsed"
    else
        report_fail_diff "$f (ASM)" "$golden_s" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # --- Execution (bcrun) ---
    stdin=$(get_stdin "$f")
    expected_exit=$(cat "$golden_exit")
    actual=$(mktemp)
    bc=$("$CODEGEN" "$input" 2>/dev/null)
    t0=$(time_ms)
    { printf '%s\n' "$bc"; echo -n "$stdin"; } | "$BCRUN" > "$actual" 2>/dev/null
    actual_exit=$?
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_out" "$actual" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
        report_pass "$f (Exec - bcrun)" "$elapsed"
    else
        msg=""
        [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
        report_fail_diff "$f (Exec - bcrun)" "$golden_out" "$actual" "$msg" "$elapsed"
    fi
    rm -f "$actual"

    # --- Execution (rv32) ---
    if command -v "$RISCV_CC" >/dev/null && command -v "$QEMU" >/dev/null; then
        asm_file=$(mktemp --suffix=.s)
        elf_file=$(mktemp)
        bc=$("$CODEGEN" "$input" 2>/dev/null)
        printf '%s\n' "$bc" | "$BC2ASM" > "$asm_file" 2>/dev/null
        if "$RISCV_CC" $RISCV_FLAGS "$CRT0" "$asm_file" "$RUNTIME" -o "$elf_file" 2>/dev/null; then
            actual=$(mktemp)
            t0=$(time_ms)
            echo -n "$stdin" | "$QEMU" "$elf_file" > "$actual" 2>/tmp/tc_golden_rv32_stderr_$$
            actual_exit=$?
            elapsed=$(( $(time_ms) - t0 ))
            mem=$(awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' /tmp/tc_golden_rv32_stderr_$$)
            rm -f /tmp/tc_golden_rv32_stderr_$$
            if diff -u "$golden_out" "$actual" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
                report_pass "$f (Exec - rv32)${mem:+ (mem: $mem)}" "$elapsed"
            else
                msg=""
                [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
                report_fail_diff "$f (Exec - rv32)" "$golden_out" "$actual" "$msg" "$elapsed"
            fi
            rm -f "$actual"
        else
            report_fail_msg "$f (Exec - rv32)" "compilation error"
        fi
        rm -f "$asm_file" "$elf_file"
    fi
done

print_results

#!/bin/bash
# test_gen3.sh — compiler source golden tests + Gen2==Gen3 self-hosting verification
# Tools: Gen1 (C) + Gen2 (rv32 native or bcrun fallback)
# Tests: Gen1 output vs golden, Gen2 AST/BC/ASM vs Gen1, Gen2==Gen3 BC

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bc2asm

# Build Gen2 tools
ensure_gen2_tools
if [ "$USE_NATIVE" = true ]; then
    echo "=== Compiler Source Tests (Gen1 vs golden, Gen2 vs Gen3, rv32 native) ==="
else
    echo "=== Compiler Source Tests (Gen1 vs golden, skipping Gen2/Gen3 — need qemu + riscv-gcc) ==="
fi
echo ""

# Check RISC-V available for Gen3
HAS_GEN3=false
if [ "$USE_NATIVE" = true ]; then
    HAS_GEN3=true
fi

for f in "${TC_FILES[@]}"; do
    input="$TC_DIR/$f"
    base="${f%.tc}"

    [ -f "$input" ] || { echo "Skipping tc/$f (not found)..."; continue; }

    golden_ast="$GOLDEN_DIR/tc/$base.ast"
    golden_bc="$GOLDEN_DIR/tc/$base.bc"
    golden_s="$GOLDEN_DIR/tc/$base.s"

    if [ ! -f "$golden_ast" ] || [ ! -f "$golden_bc" ] || [ ! -f "$golden_s" ]; then
        report_fail_msg "tc/$f" "Golden files missing"
        continue
    fi

    # === Gen1 vs golden ===

    # AST
    actual=$(mktemp)
    t0=$(time_ms)
    "$PARSE" "$input" > "$actual" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_ast" "$actual" > /dev/null; then
        report_pass "tc/$f (AST - Gen1 vs golden)" "$elapsed"
    else
        report_fail_diff "tc/$f (AST - Gen1 vs golden)" "$golden_ast" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # BC (using compile_tc_to_bc for import resolution)
    bc=$(compile_tc_to_bc "$input")
    actual=$(mktemp)
    t0=$(time_ms)
    printf '%s\n' "$bc" > "$actual"
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_bc" "$actual" > /dev/null; then
        report_pass "tc/$f (BC - Gen1 vs golden)" "$elapsed"
    else
        report_fail_diff "tc/$f (BC - Gen1 vs golden)" "$golden_bc" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # ASM
    actual=$(mktemp)
    t0=$(time_ms)
    printf '%s\n' "$bc" | "$BC2ASM" > "$actual" 2>/dev/null
    elapsed=$(( $(time_ms) - t0 ))
    if diff -u "$golden_s" "$actual" > /dev/null; then
        report_pass "tc/$f (ASM - Gen1 vs golden)" "$elapsed"
    else
        report_fail_diff "tc/$f (ASM - Gen1 vs golden)" "$golden_s" "$actual" "" "$elapsed"
    fi
    rm -f "$actual"

    # Exec (bcrun with merged BC)
    golden_out="$GOLDEN_DIR/tc/$base.out"
    golden_exit="$GOLDEN_DIR/tc/$base.exit"
    if [ -f "$golden_out" ] && [ -f "$golden_exit" ]; then
        expected_exit=$(cat "$golden_exit")
        exec_input_file=$(get_tc_exec_input_file "$f")
        actual=$(mktemp)
        t0=$(time_ms)
        { printf '%s\n' "$bc"; cat "$exec_input_file"; } | "$BCRUN" > "$actual" 2>/dev/null
        actual_exit=$?
        elapsed=$(( $(time_ms) - t0 ))
        if diff -u "$golden_out" "$actual" > /dev/null && [ "$actual_exit" -eq "$expected_exit" ]; then
            report_pass "tc/$f (Exec - bcrun)" "$elapsed"
        else
            msg=""
            [ "$actual_exit" -ne "$expected_exit" ] && msg="exit code mismatch: expected $expected_exit, got $actual_exit"
            report_fail_diff "tc/$f (Exec - bcrun)" "$golden_out" "$actual" "$msg" "$elapsed"
        fi
        rm -f "$actual"
    fi

    # === Gen2 AST vs Gen1 AST (ignoring comment nodes and whitespace) ===
    actual_gen2_ast=$(mktemp)
    t0=$(time_ms)
    run_parse_tc "$input" > "$actual_gen2_ast"
    elapsed=$(( $(time_ms) - t0 ))
    gen2_ast_size=$(wc -c < "$actual_gen2_ast")
    # Normalize S-expression: strip comments, collapse whitespace around parens
    gen1_norm=$(mktemp)
    gen2_norm=$(mktemp)
    sed 's/(comment [^)]*)//' "$golden_ast" | tr -s ' \t\n' ' ' | sed 's/ )/)/g; s/( /(/g' > "$gen1_norm"
    sed 's/(comment [^)]*)//' "$actual_gen2_ast" | tr -s ' \t\n' ' ' | sed 's/ )/)/g; s/( /(/g' > "$gen2_norm"
    if diff -u "$gen1_norm" "$gen2_norm" > /dev/null 2>&1; then
        report_pass "tc/$f (AST - Gen2 vs Gen1) [${gen2_ast_size}B]" "$elapsed"
    else
        report_fail_msg "tc/$f (AST - Gen2 vs Gen1) [${elapsed}ms]" "structure mismatch"
    fi
    rm -f "$gen1_norm" "$gen2_norm"

    # === Gen2 BC/ASM and Gen3 (only for files without imports) ===
    has_import=$(grep -c '^import ' "$input" 2>/dev/null)
    [ -z "$has_import" ] && has_import=0
    actual_gen2_bc=$(mktemp)

    if [ "$has_import" -eq 0 ]; then
        # Gen2 BC: Gen2 parse → Gen2 typecheck → Gen2 codegen
        gen2_ast=$(cat "$actual_gen2_ast")
        t0=$(time_ms)
        printf '%s\n' "$gen2_ast" | run_typecheck_tc | run_codegen_tc > "$actual_gen2_bc"
        elapsed=$(( $(time_ms) - t0 ))
        if diff -u "$golden_bc" "$actual_gen2_bc" > /dev/null; then
            report_pass "tc/$f (BC - Gen2 vs golden)" "$elapsed"
        else
            diff_file="/tmp/tc_gen2_bc_diff_${base}.txt"
            diff -U10 "$golden_bc" "$actual_gen2_bc" > "$diff_file"
            echo "FAIL: tc/$f (BC - Gen2 vs golden) [${elapsed}ms] (diff: $diff_file)"
            FAIL=$((FAIL + 1))
        fi

        # Gen2 ASM
        actual_gen2_s=$(mktemp)
        t0=$(time_ms)
        printf '%s\n' "$bc" | run_bc2asm_tc > "$actual_gen2_s"
        elapsed=$(( $(time_ms) - t0 ))
        if diff -u "$golden_s" "$actual_gen2_s" > /dev/null; then
            report_pass "tc/$f (ASM - Gen2 vs golden)" "$elapsed"
        else
            diff_file="/tmp/tc_gen2_asm_diff_${base}.txt"
            diff -U10 "$golden_s" "$actual_gen2_s" > "$diff_file"
            echo "FAIL: tc/$f (ASM - Gen2 vs golden) [${elapsed}ms] (diff: $diff_file)"
            FAIL=$((FAIL + 1))
        fi
        rm -f "$actual_gen2_s"
    fi

    # === Gen3 == Gen2 (BC) ===
    if [ "$HAS_GEN3" = true ] && [ "$has_import" -eq 0 ]; then
        # Gen3: Gen2 parse → Gen2 typecheck → Gen2 codegen (from source)
        gen3_bc=$(mktemp)
        t0=$(time_ms)
        "$QEMU" "$_GEN2_TMP/parse" < "$input" 2>/tmp/tc_gen3_parse_stderr_$$ | \
        "$QEMU" "$_GEN2_TMP/typecheck" 2>/dev/null | \
        "$QEMU" "$_GEN2_TMP/codegen" > "$gen3_bc" 2>/dev/null
        elapsed=$(( $(time_ms) - t0 ))

        mem=$(awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' /tmp/tc_gen3_parse_stderr_$$)
        rm -f /tmp/tc_gen3_parse_stderr_$$

        if diff -u "$actual_gen2_bc" "$gen3_bc" > /dev/null; then
            report_pass "tc/$f (Gen2 == Gen3)${mem:+ (mem: parse=$mem)}" "$elapsed"
        else
            diff_file="/tmp/tc_gen3_bc_diff_${base}.txt"
            diff -U10 "$actual_gen2_bc" "$gen3_bc" > "$diff_file"
            echo "FAIL: tc/$f (Gen2 != Gen3) [${elapsed}ms] (diff: $diff_file)"
            FAIL=$((FAIL + 1))
        fi
        rm -f "$gen3_bc"
    fi

    rm -f "$actual_gen2_ast" "$actual_gen2_bc"
done

cleanup_gen2_tools
print_results

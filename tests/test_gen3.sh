#!/bin/bash
# test_gen3.sh — Gen2 vs Gen3 verification (true self-hosting check)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/test_common.sh"
require_tools parse codegen bcrun bc2asm

echo "=== Gen2 vs Gen3 Verification (True Self-Hosting Check, RISC-V) ==="

if ! command -v "$RISCV_CC" >/dev/null 2>&1 || ! command -v "$QEMU" >/dev/null 2>&1; then
    echo "SKIP: Gen2 vs Gen3 assembly check (RISC-V toolchain not found)"
    print_results
    exit $?
fi

ensure_gen2_tools

# Compile Gen2 BCs (for comparison)
GEN2_BC_TMP=$(mktemp -d)
"$PARSE" "$TC_DIR/parse.tc" | "$CODEGEN" > "$GEN2_BC_TMP/parse.bc" 2>/dev/null
"$PARSE" "$TC_DIR/typecheck.tc" | "$CODEGEN" > "$GEN2_BC_TMP/typecheck.bc" 2>/dev/null
"$PARSE" "$TC_DIR/codegen.tc" | "$CODEGEN" > "$GEN2_BC_TMP/codegen.bc" 2>/dev/null
"$PARSE" "$TC_DIR/bc2asm.tc" | "$CODEGEN" > "$GEN2_BC_TMP/bc2asm.bc" 2>/dev/null

GEN2_BC_FILES=("$GEN2_BC_TMP/parse.bc" "$GEN2_BC_TMP/typecheck.bc" "$GEN2_BC_TMP/codegen.bc" "$GEN2_BC_TMP/bc2asm.bc")
GEN2_BC_NAMES=("parse.tc" "typecheck.tc" "codegen.tc" "bc2asm.tc")

# Extract peak memory from pool stats (sum of peak * bucket_size)
extract_peak_mem() {
    local stderr_file="$1"
    awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' "$stderr_file"
}

for i in "${!GEN2_BC_NAMES[@]}"; do
    f="${GEN2_BC_NAMES[$i]}"
    gen2_bc_file="${GEN2_BC_FILES[$i]}"
    input="$TC_DIR/$f"

    # Gen3: parse → typecheck → codegen with Gen2 RISC-V binaries
    t0=$(time_ms)
    "$QEMU" "$_GEN2_TMP/parse" < "$input" > "$GEN2_BC_TMP/gen3_ast" 2>"$GEN2_BC_TMP/parse_stderr"
    "$QEMU" "$_GEN2_TMP/typecheck" < "$GEN2_BC_TMP/gen3_ast" > "$GEN2_BC_TMP/gen3_tast" 2>"$GEN2_BC_TMP/typecheck_stderr"
    "$QEMU" "$_GEN2_TMP/codegen" < "$GEN2_BC_TMP/gen3_tast" > "$GEN2_BC_TMP/gen3_bc" 2>"$GEN2_BC_TMP/codegen_stderr"
    elapsed=$(( $(time_ms) - t0 ))

    # Memory info
    mem_parse=$(extract_peak_mem "$GEN2_BC_TMP/parse_stderr")
    mem_tc=$(extract_peak_mem "$GEN2_BC_TMP/typecheck_stderr")
    mem_cg=$(extract_peak_mem "$GEN2_BC_TMP/codegen_stderr")
    mem_parts=""
    [ -n "$mem_parse" ] && mem_parts="parse=${mem_parse}"
    [ -n "$mem_tc" ] && mem_parts="${mem_parts:+$mem_parts }tc=${mem_tc}"
    [ -n "$mem_cg" ] && mem_parts="${mem_parts:+$mem_parts }cg=${mem_cg}"
    mem_info=""
    [ -n "$mem_parts" ] && mem_info=" (mem: ${mem_parts})"

    if diff -u "$gen2_bc_file" "$GEN2_BC_TMP/gen3_bc" > /dev/null; then
        echo "PASS: tc/$f (Gen2 == Gen3) [${elapsed}ms]${mem_info}"
        PASS=$((PASS + 1))
    else
        echo "FAIL: tc/$f (Gen2 != Gen3) [${elapsed}ms]"
        echo "  --- diff (showing first 10 lines) ---"
        diff -u "$gen2_bc_file" "$GEN2_BC_TMP/gen3_bc" | head -n 12
        echo "  ------------------------------------"
        FAIL=$((FAIL + 1))
    fi
done

rm -rf "$GEN2_BC_TMP"
cleanup_gen2_tools
print_results

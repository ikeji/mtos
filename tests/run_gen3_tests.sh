#!/bin/bash
# Gen2 vs Gen3 verification: proves the self-hosted compiler correctly compiles itself.
# Gen2 = tc/ compiled by Gen1 (C compiler)
# Gen3 = tc/ compiled by Gen2 (RISC-V assembly-compiled Gen2 tools via qemu)
# If Gen2 BC == Gen3 BC, self-hosting is verified.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TC_DIR="$ROOT_DIR/compiler"
COMPILER_DIR="$ROOT_DIR/bootstrap"

PARSE="$ROOT_DIR/parse"
CODEGEN="$ROOT_DIR/codegen"
BCRUN="$ROOT_DIR/bcrun"
BC2ASM="$ROOT_DIR/bc2asm"

RISCV_CC="riscv64-unknown-elf-gcc"
RISCV_FLAGS="-march=rv32im -mabi=ilp32 -static -nostdlib -lgcc -Wl,-Ttext-segment=0x10000"
RUNTIME="$COMPILER_DIR/runtime_syscall.c"
CRT0="$COMPILER_DIR/crt0.s"
QEMU="qemu-riscv32"

PASS=0
FAIL=0

time_ms() { date +%s%3N; }

if [ ! -x "$PARSE" ] || [ ! -x "$CODEGEN" ] || [ ! -x "$BCRUN" ] || [ ! -x "$BC2ASM" ]; then
    echo "Error: basic tools (parse, codegen, bcrun, bc2asm) not found. Build them first." >&2
    exit 1
fi

echo "=== Gen2 vs Gen3 Verification (True Self-Hosting Check, RISC-V) ==="

if ! command -v "$RISCV_CC" >/dev/null 2>&1 || ! command -v "$QEMU" >/dev/null 2>&1; then
    echo "SKIP: Gen2 vs Gen3 assembly check (RISC-V toolchain not found)"
else
    GEN2_TMP=$(mktemp -d)

    source "$SCRIPT_DIR/compile_tc.sh"

    # compile_tc_to_elf: compile a .tc file (with imports) to RISC-V ELF
    compile_tc_to_elf() {
        local tc_file="$1" out_elf="$2"
        local tc_dir tmp_dir
        tc_dir=$(dirname "$tc_file")
        tmp_dir=$(mktemp -d)
        local imports=() asm_files=()
        while IFS= read -r imp; do
            imports+=("$tc_dir/$imp")
        done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
        for imp_file in "${imports[@]}"; do
            local base=$(basename "$imp_file" .tc)
            "$CODEGEN" "$imp_file" 2>/dev/null | "$BC2ASM" > "$tmp_dir/$base.s" 2>/dev/null
            asm_files+=("$tmp_dir/$base.s")
        done
        local main_base=$(basename "$tc_file" .tc)
        "$CODEGEN" "$tc_file" 2>/dev/null | "$BC2ASM" > "$tmp_dir/$main_base.s" 2>/dev/null
        asm_files+=("$tmp_dir/$main_base.s")
        $RISCV_CC $RISCV_FLAGS "$CRT0" "$RUNTIME" "${asm_files[@]}" -o "$out_elf" 2>/dev/null
        rm -rf "$tmp_dir"
    }

    # Compile Gen2 BCs (for Gen2==Gen3 comparison)
    "$PARSE" "$TC_DIR/parse.tc" | "$CODEGEN" > "$GEN2_TMP/parse.bc" 2>/dev/null
    "$PARSE" "$TC_DIR/typecheck.tc" | "$CODEGEN" > "$GEN2_TMP/typecheck.bc" 2>/dev/null
    "$PARSE" "$TC_DIR/codegen.tc" | "$CODEGEN" > "$GEN2_TMP/codegen.bc" 2>/dev/null
    "$PARSE" "$TC_DIR/bc2asm.tc" | "$CODEGEN" > "$GEN2_TMP/bc2asm.bc" 2>/dev/null

    compile_tc_to_elf "$TC_DIR/parse.tc" "$GEN2_TMP/parse_gen2"
    compile_tc_to_elf "$TC_DIR/typecheck.tc" "$GEN2_TMP/typecheck_gen2"
    compile_tc_to_elf "$TC_DIR/codegen.tc" "$GEN2_TMP/codegen_gen2"

    GEN2_BC_FILES=("$GEN2_TMP/parse.bc" "$GEN2_TMP/typecheck.bc" "$GEN2_TMP/codegen.bc" "$GEN2_TMP/bc2asm.bc")
    GEN2_BC_NAMES=("parse.tc" "typecheck.tc" "codegen.tc" "bc2asm.tc")

    for i in "${!GEN2_BC_NAMES[@]}"; do
        f="${GEN2_BC_NAMES[$i]}"
        gen2_bc_file="${GEN2_BC_FILES[$i]}"
        input="$TC_DIR/$f"

        # Gen3: parse → typecheck → codegen, all with Gen2 RISC-V binaries
        t0=$(time_ms)
        "$QEMU" "$GEN2_TMP/parse_gen2" < "$input" > "$GEN2_TMP/gen3_ast" 2>"$GEN2_TMP/parse_stderr"
        "$QEMU" "$GEN2_TMP/typecheck_gen2" < "$GEN2_TMP/gen3_ast" > "$GEN2_TMP/gen3_tast" 2>"$GEN2_TMP/typecheck_stderr"
        "$QEMU" "$GEN2_TMP/codegen_gen2" < "$GEN2_TMP/gen3_tast" > "$GEN2_TMP/gen3_bc" 2>"$GEN2_TMP/codegen_stderr"
        elapsed=$(( $(time_ms) - t0 ))

        # Extract peak memory from pool stats (sum of peak * bucket_size)
        extract_peak_mem() {
            local stderr_file="$1"
            awk '$1 ~ /^[0-9]+$/ && $3 ~ /\// { split($3,a,"/"); total += a[1] * $1 } END { if (total>0) printf "%dKB", total/1024 }' "$stderr_file"
        }
        mem_parse=$(extract_peak_mem "$GEN2_TMP/parse_stderr")
        mem_tc=$(extract_peak_mem "$GEN2_TMP/typecheck_stderr")
        mem_cg=$(extract_peak_mem "$GEN2_TMP/codegen_stderr")
        mem_parts=""
        [ -n "$mem_parse" ] && mem_parts="parse=${mem_parse}"
        [ -n "$mem_tc" ] && mem_parts="${mem_parts:+$mem_parts }tc=${mem_tc}"
        [ -n "$mem_cg" ] && mem_parts="${mem_parts:+$mem_parts }cg=${mem_cg}"
        mem_info=""
        [ -n "$mem_parts" ] && mem_info=" (mem: ${mem_parts})"

        if diff -u "$gen2_bc_file" "$GEN2_TMP/gen3_bc" > /dev/null; then
            echo "PASS: tc/$f (Gen2 == Gen3) [${elapsed}ms]${mem_info}"
            PASS=$((PASS + 1))
        else
            echo "FAIL: tc/$f (Gen2 != Gen3) [${elapsed}ms]"
            echo "  --- diff (showing first 10 lines) ---"
            diff -u "$gen2_bc_file" "$GEN2_TMP/gen3_bc" | head -n 12
            echo "  ------------------------------------"
            FAIL=$((FAIL + 1))
        fi
    done

    rm -rf "$GEN2_TMP"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ $FAIL -eq 0 ] && exit 0 || exit 1

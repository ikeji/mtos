#!/bin/bash
# bench_pipeline.sh — measure per-stage memory peak and (host) wall-time
# for the Gen2 compile + assemble pipeline on a given .tc input.
#
# Usage: tests/bench_pipeline.sh INPUT.tc [INPUT2.tc ...]
#
# Defaults: hello.tc + bc2asm.tc (the small + realistic-worst inputs
# per docs/scaling.md). Output goes to stdout as a tab-separated
# table:
#
#   input  stage  time_ms  peak_kb  out_bytes
#
# Memory peak is read from each stage's `[kmem peak=N live=M]`
# stderr line emitted by km_dump_peak in the compiler binaries
# (sigscan/tcheck/codegen/bc2asm/asm_pass2/asm_pass3 — parse doesn't
# call it). Time is qemu-riscv32 wall-clock on the host (rough only;
# pico2 hardware timing should be measured separately via msh script).
#
# Uses Gen3 binaries for the measured stages because Gen2 binaries
# link bootstrap/runtime_syscall.c where km_dump_peak is a no-op.
# The link bundle for asm_pass2/asm_pass3 mirrors compile-gen2.sh's
# (compiler/crt0_tc.s + compiled runtime + user .s + crt0_tc_data.s)
# so peak label-table size matches production.

set -u

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

TOOLS_DIR="${TOOLS_DIR:-$ROOT_DIR/build/gen3}"
GEN2_DIR="${GEN2_DIR:-$ROOT_DIR/build/gen2}"
PARSE="$ROOT_DIR/build/gen1/parse"
QEMU="${QEMU:-qemu-riscv32}"

for tool in sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3; do
    if [ ! -x "$TOOLS_DIR/$tool" ]; then
        echo "bench: missing $TOOLS_DIR/$tool — run 'make gen3-tools' first" >&2
        exit 1
    fi
done
if [ ! -x "$GEN2_DIR/sigscan" ]; then
    echo "bench: missing $GEN2_DIR/sigscan — run 'make gen2-tools' first" >&2
    exit 1
fi
if [ ! -x "$PARSE" ]; then
    echo "bench: missing $PARSE — run 'make' first" >&2
    exit 1
fi

# Default inputs cover both ends of the size spectrum.
if [ $# -eq 0 ]; then
    set -- "$ROOT_DIR/tests/phase7_hello_world.tc" "$ROOT_DIR/compiler/bc2asm.tc"
fi

TMP=$(mktemp -d)
trap "rm -rf '$TMP'" EXIT

now_ms() { date +%s%3N; }

extract_peak_kb() {
    local f="$1" n
    n=$(grep -oE 'kmem peak=[0-9]+' "$f" | tail -1 | grep -oE '[0-9]+')
    if [ -z "$n" ]; then echo "-"; return; fi
    echo $(( (n + 1023) / 1024 ))
}

# Recursively collect transitive imports (mirrors compile-gen2.sh).
_COLLECTED=""
_collect_imports() {
    local tc_file="$1" tc_dir
    tc_dir=$(dirname "$tc_file")
    while IFS= read -r imp; do
        local full="$tc_dir/$imp"
        if [ -f "$full" ]; then
            local b; b=$(basename "$full")
            if ! echo "$_COLLECTED" | grep -qF "$b"; then
                _collect_imports "$full"
                _COLLECTED="${_COLLECTED}${full}"$'\n'
            fi
        fi
    done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
}

# Compile one .tc to .s using Gen2 pipeline (no peak measurement here;
# this is setup for the linkable bundle the asm passes will assemble).
compile_one() {
    local tc="$1" out_s="$2" imports_th="$3"
    local base; base=$(basename "$tc" .tc)
    local d; d=$(dirname "$out_s")
    "$PARSE" "$tc" > "$d/$base.ast"
    "$QEMU" "$GEN2_DIR/sigscan" < "$d/$base.ast" > "$d/$base.self.th"
    {
        cat "$imports_th"
        printf '(self\n'
        cat "$d/$base.self.th"
        printf ')\n'
        cat "$d/$base.ast"
    } > "$d/$base.wrap"
    "$QEMU" "$GEN2_DIR/tcheck" < "$d/$base.wrap" 2>/dev/null \
        | "$QEMU" "$GEN2_DIR/codegen" 2>/dev/null \
        | "$QEMU" "$GEN2_DIR/bc2asm" 2>/dev/null > "$out_s"
}

run_stage() {
    local input="$1" stage="$2" cmd="$3" outfile="$4"
    local errfile="$TMP/last.err"
    local t0 t1 elapsed peak out_bytes
    t0=$(now_ms)
    eval "$cmd" 2>"$errfile"
    t1=$(now_ms)
    elapsed=$(( t1 - t0 ))
    peak=$(extract_peak_kb "$errfile")
    if [ -f "$outfile" ]; then
        out_bytes=$(stat -c %s "$outfile" 2>/dev/null || echo "-")
    else
        out_bytes="-"
    fi
    printf '%s\t%s\t%d\t%s\t%s\n' "$(basename "$input")" "$stage" "$elapsed" "$peak" "$out_bytes"
}

printf 'input\tstage\ttime_ms\tpeak_kb\tout_bytes\n'

for input in "$@"; do
    base=$(basename "$input" .tc)
    work="$TMP/$base"
    mkdir -p "$work"

    # ------------------------------------------------------------
    # Setup (not benchmarked): collect imports, compile runtime +
    # each import to .s. This builds the link bundle prefix that
    # asm_pass2/2 will see.
    # ------------------------------------------------------------
    _COLLECTED=""
    _collect_imports "$input"
    IMPORT_FILES=()
    while IFS= read -r f; do
        [ -z "$f" ] && continue
        IMPORT_FILES+=("$f")
    done <<< "$_COLLECTED"

    if [ ${#IMPORT_FILES[@]} -gt 0 ]; then
        {
            echo "(imports"
            for imp in "${IMPORT_FILES[@]}"; do
                "$PARSE" "$imp" | "$QEMU" "$GEN2_DIR/sigscan"
            done
            echo ")"
        } > "$work/imports.th"
    else
        printf '(imports)\n' > "$work/imports.th"
    fi

    # Compile runtime + each import to .s for the link bundle.
    compile_one "$ROOT_DIR/compiler/runtime.tc" "$work/runtime.s" "$work/imports.th"
    LINK_S=("$work/runtime.s")
    for imp in "${IMPORT_FILES[@]}"; do
        ib=$(basename "$imp" .tc)
        compile_one "$imp" "$work/$ib.s" "$work/imports.th"
        LINK_S+=("$work/$ib.s")
    done

    # ------------------------------------------------------------
    # Stage 1: parse (.tc → .ast). Gen3 parse doesn't call
    # km_dump_peak so peak shows "-" but the time is comparable.
    # ------------------------------------------------------------
    run_stage "$input" parse \
        "\"$QEMU\" \"$TOOLS_DIR/parse\" < \"$input\" > \"$work/in.ast\"" \
        "$work/in.ast"

    # Stage 2: sigscan (.ast → self.th)
    run_stage "$input" sigscan \
        "\"$QEMU\" \"$TOOLS_DIR/sigscan\" < \"$work/in.ast\" > \"$work/in.self.th\"" \
        "$work/in.self.th"

    # Build the tcheck wrap input (not benched; setup).
    {
        cat "$work/imports.th"
        printf '(self\n'
        cat "$work/in.self.th"
        printf ')\n'
        cat "$work/in.ast"
    } > "$work/in.wrap"

    # Stage 3: tcheck (wrap → .tast)
    run_stage "$input" tcheck \
        "\"$QEMU\" \"$TOOLS_DIR/tcheck\" < \"$work/in.wrap\" > \"$work/in.tast\"" \
        "$work/in.tast"

    # Stage 4: codegen (.tast → .bc)
    run_stage "$input" codegen \
        "\"$QEMU\" \"$TOOLS_DIR/codegen\" < \"$work/in.tast\" > \"$work/in.bc\"" \
        "$work/in.bc"

    # Stage 5: bc2asm (.bc → .s)
    run_stage "$input" bc2asm \
        "\"$QEMU\" \"$TOOLS_DIR/bc2asm\" < \"$work/in.bc\" > \"$work/in.s\"" \
        "$work/in.s"

    # Build the full link bundle: ASM_PROLOGUE + crt0 + runtime + imports + user
    # + crt0_data, matching compile-gen2.sh's recipe.
    {
        printf '; raw\n'
        cat "$ROOT_DIR/compiler/crt0_tc.s"
        for s in "${LINK_S[@]}"; do cat "$s"; done
        cat "$work/in.s"
        cat "$ROOT_DIR/compiler/crt0_tc_data.s"
    } > "$work/full.s"

    # Stage 6: asm_pass1 (full.s → .idx + per-section .bin + .reloc).
    # LINK_MODE pre-encode: walks the source once, emits the link-
    # ready artifacts asm_pass2 --link consumes.
    run_stage "$input" asm_pass1 \
        "\"$QEMU\" \"$TOOLS_DIR/asm_pass1\" \"$work/full.s\" \
            --idx-out    \"$work/full.idx\" \
            --text-bin   \"$work/full.text.bin\" \
            --rodata-bin \"$work/full.rodata.bin\" \
            --data-bin   \"$work/full.data.bin\" \
            --reloc-out  \"$work/full.reloc\"" \
        "$work/full.idx"

    # Stage 7: asm_pass2 --link (idx + bins + reloc → .lab). Single-
    # input link (no prelude side); the whole full.s is the user.
    run_stage "$input" asm_pass2 \
        "\"$QEMU\" \"$TOOLS_DIR/asm_pass2\" --link \
            --user-idx        \"$work/full.idx\" \
            --user-text-bin   \"$work/full.text.bin\" \
            --user-rodata-bin \"$work/full.rodata.bin\" \
            --user-data-bin   \"$work/full.data.bin\" \
            --user-reloc      \"$work/full.reloc\" \
            --lab-out         \"$work/full.lab\"" \
        "$work/full.lab"

    # Stage 8: asm_pass3 (.lab + .bins → final binary). memcpy each
    # pre-encoded section bin into place + apply relocs.
    run_stage "$input" asm_pass3 \
        "\"$QEMU\" \"$TOOLS_DIR/asm_pass3\" --lab \"$work/full.lab\" --out \"$work/in.bin\"" \
        "$work/in.bin"
done

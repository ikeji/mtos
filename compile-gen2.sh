#!/bin/bash
# compile-gen2.sh — Compile .tc to RV32 ELF using Gen2 tools (via qemu).
# Uses: Gen1 parse (for import .th generation),
#       Gen2 sigscan/tcheck/codegen/bc2asm/asm_pass2/asm_pass3 (qemu).
#
# Usage: GEN2_DIR=/path/to/gen2 ./compile-gen2.sh [-o output] file.tc
#
# Pipeline (per .tc):
#   parse  < file.tc                                  > file.ast
#   sigscan < file.ast                                > file.th   (extended)
#   { (imports) + (self file.th) + file.ast } | tcheck > file.tast
#   codegen < file.tast                               > file.bc
#   bc2asm  < file.bc                                 > file.s
#
# Linking (once):
#   cat [prologue] crt0 runtime.s user1.s ... crt0_data > full.s
#   asm_pass2 < full.s > full.lab
#   cat full.lab full.s | asm_pass3 > OUTFILE
#
# The (imports) block is built from Gen1 parse + Gen2 sigscan for each
# transitively imported module. sigscan emits all top-level decls, but
# tcheck filters with export_only=true so non-export symbols are ignored.
# The (self) block is also built from sigscan for forward-reference
# resolution within a single module.
#
# Requires: Gen1 tools (parse),
#           Gen2 tools in GEN2_DIR (sigscan, tcheck, codegen, bc2asm,
#             asm_pass2, asm_pass3),
#           qemu-riscv32

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARSE="$ROOT_DIR/build/gen1/parse"
QEMU="${QEMU:-qemu-riscv32}"
CRT0="${CRT0:-$ROOT_DIR/compiler/crt0_tc.s}"
CRT0_DATA="${CRT0_DATA:-$ROOT_DIR/compiler/crt0_tc_data.s}"
RUNTIME_TC="${RUNTIME_TC:-$ROOT_DIR/compiler/runtime.tc}"
# Optional directive lines prepended to asm input (e.g. "; raw" for Pico 2 / virt).
ASM_PROLOGUE="${ASM_PROLOGUE:-}"

OUTFILE="a.out"
TC_FILE=""

while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: GEN2_DIR=/path/to/gen2 compile-gen2.sh [-o output] file.tc" >&2
    exit 1
fi

# Resolve symlinks in the input path so imports are looked up next to
# the real source, not next to the symlink. kernel/build.sh stages
# compiler/ sources as kernel/tasks/<name>/<name>.tc symlinks, and
# their imports (string_buffer.tc, ast_node.tc, ...) only exist under
# compiler/. Without the resolve step, _collect_imports would search
# kernel/tasks/<name>/ and find nothing.
if [ -L "$TC_FILE" ]; then
    TC_FILE=$(readlink -f "$TC_FILE")
fi

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set. Build Gen2 tools first with compile-gen1.sh." >&2
    exit 1
fi

for tool in sigscan tcheck codegen bc2asm asm_pass1 asm_pass2 asm_pass3; do
    if [ ! -x "$GEN2_DIR/$tool" ]; then
        echo "Error: Gen2 tool not found: $GEN2_DIR/$tool" >&2
        exit 1
    fi
done

# Stale-cache check: if any compiler/*.tc is newer than the Gen2
# tcheck binary, the user probably forgot to rebuild Gen2 after
# editing the compiler. A stale Gen2 typechecks against old overload
# tables and gives mystifying errors (historically "get: N out of
# bounds"). Warn loudly but keep running — the dev may want the stale
# build on purpose (e.g. to diff golden outputs against old vs new).
# See problem.md #15.
if find "$ROOT_DIR/compiler" -maxdepth 1 -name '*.tc' \
        -newer "$GEN2_DIR/tcheck" -print -quit 2>/dev/null | grep -q .; then
    {
        echo "warning: GEN2_DIR=$GEN2_DIR is older than compiler/*.tc"
        echo "         rebuild with:  rm -rf $GEN2_DIR && mkdir -p $GEN2_DIR &&"
        echo "           for t in parse sigscan tcheck codegen bc2asm bcrun \\"
        echo "                    asm_pass2 asm_pass3; do"
        echo "             ./compile-gen1.sh -o \$GEN2_DIR/\$t compiler/\$t.tc; done"
    } >&2
fi

# Recursive import collection
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
                _COLLECTED="${_COLLECTED}${full}
"
            fi
        fi
    done < <(grep '^import "' "$tc_file" 2>/dev/null | sed 's/^import "\(.*\)";$/\1/')
}

# 中間ファイルを build/intermediate/gen2/<basename>/ に残す。
# デバッグ時に .ast/.th/.s/.lab を直接確認できる。make clean で消える。
# (KEEP_TMP は不要になったので廃止)
_BASE=$(basename "$TC_FILE" .tc)
TMP="$ROOT_DIR/build/intermediate/gen2/$_BASE"
mkdir -p "$TMP"

# Collect import files
_COLLECTED=""
_collect_imports "$TC_FILE"
IMPORT_FILES=()
while IFS= read -r f; do
    [ -z "$f" ] && continue
    IMPORT_FILES+=("$f")
done <<< "$_COLLECTED"

ALL_FILES=("${IMPORT_FILES[@]}" "$TC_FILE")

# Generate the shared (imports …) block for every compilation unit
# using Gen1 parse + Gen2 sigscan. sigscan emits all top-level decls
# (not just :export), but tcheck filters imports with export_only=true
# so non-export symbols are harmlessly ignored.
if [ ${#IMPORT_FILES[@]} -gt 0 ]; then
    {
        echo "(imports"
        for imp in "${IMPORT_FILES[@]}"; do
            "$PARSE" "$imp" | "$QEMU" "$GEN2_DIR/sigscan"
        done
        echo ")"
    } > "$TMP/imports.th"
else
    printf '(imports)\n' > "$TMP/imports.th"
fi

# Compile helper: .tc → .s using Gen2 pipeline
# Uses Gen1 parse for AST, Gen2 sigscan/tcheck/codegen/bc2asm
#
# If CACHED_S_DIR is set and contains <basename>.s, we reuse it and
# skip the qemu pipeline. kernel/build.sh pre-compiles runtime.tc
# and libtc.tc once each and shares the .s across all task/kernel
# builds to avoid re-running the same 1.4s runtime compile seven
# times. Cache files must match by exact basename — the caller
# controls both sides, and no task is named runtime/libtc.
compile_one() {
    local tc="$1" out_s="$2"
    local base
    base=$(basename "$tc" .tc)
    if [ -n "$CACHED_S_DIR" ] && [ -f "$CACHED_S_DIR/$base.s" ]; then
        cp "$CACHED_S_DIR/$base.s" "$out_s"
        return 0
    fi
    local ast="$TMP/$base.ast"
    local self_th="$TMP/$base.self.th"
    local wrap="$TMP/$base.wrap"
    "$PARSE" "$tc" > "$ast"
    "$QEMU" "$GEN2_DIR/sigscan" < "$ast" > "$self_th"
    {
        cat "$TMP/imports.th"
        printf '(self\n'
        cat "$self_th"
        printf ')\n'
        cat "$ast"
    } > "$wrap"
    "$QEMU" "$GEN2_DIR/tcheck"  < "$wrap" | \
        "$QEMU" "$GEN2_DIR/codegen" | \
        "$QEMU" "$GEN2_DIR/bc2asm" > "$out_s"
}

# Compile runtime.tc (no imports needed)
compile_one "$RUNTIME_TC" "$TMP/runtime.s"

# Compile each user .tc file
ASM_FILES=()
for tc in "${ALL_FILES[@]}"; do
    base=$(basename "$tc" .tc)
    compile_one "$tc" "$TMP/$base.s"
    ASM_FILES+=("$TMP/$base.s")
done

# Phase 8 unification: when UNIFIED_PRELUDE=1 (the default), build
# prelude (ASM_PROLOGUE + CRT0 + runtime.s) and prelude_tail
# (CRT0_DATA) separately, pre-encode the prelude into .idx + section
# .bin + .reloc, then run the final asm_pass2 with --load-idx +
# --prelude-*. Matches the OS-side flow in tests/fixtures/pico2_*.sh,
# so host and guest both go through identical asm_pass2 / asm_pass3
# code paths.
#
# Set UNIFIED_PRELUDE=0 to fall back to the legacy stdin pipeline
# (one big full.s into asm_pass2, no pre-encode). Required when:
#   - The prelude references TC symbols defined only in user code
#     (kernel build: platform_*.s + trap_common.s call TC fns like
#     trap_handler / sched_task_exit / sys_*_handler).
#   - User code overrides a prelude-defined symbol whose call sites
#     in the prelude don't get a reloc emitted at pre-encode time
#     (asm_pass2 only emits relocs for unresolved labels — see
#     2026-05-06 print/println rename for the one symbol pair where
#     this used to bite us).
UNIFIED_PRELUDE="${UNIFIED_PRELUDE:-1}"

if [ "$UNIFIED_PRELUDE" = "1" ]; then
    # Step 1: prelude.s = ASM_PROLOGUE + CRT0 + runtime.s
    {
        [ -n "$ASM_PROLOGUE" ] && printf '%s\n' "$ASM_PROLOGUE"
        cat "$CRT0"
        cat "$TMP/runtime.s"
    } > "$TMP/prelude.s"

    # Step 2: prelude_tail.s = CRT0_DATA (BSS / data-end markers)
    cat "$CRT0_DATA" > "$TMP/prelude_tail.s"

    # Step 3: user.s = each compiled .tc + EXTRA_S + prelude_tail.s
    {
        cat "${ASM_FILES[@]}"
        for extra_s in ${EXTRA_S:-}; do cat "$extra_s"; done
        cat "$TMP/prelude_tail.s"
    } > "$TMP/user.s"

    # Step 4: emit prelude.idx + per-section .bin + .reloc in one
    # asm_pass1 invocation (Phase E of the 3-binary asm split). The
    # idx covers prelude.s alone (= the section state the final
    # asm_pass2 will inherit before scanning user.s); the .bin /
    # .reloc cover prelude.s + prelude_tail.s combined so __data_end /
    # __bss_start / __arena are in scope at encode time.
    "$QEMU" "$GEN2_DIR/asm_pass1" \
        "$TMP/prelude.s" "$TMP/prelude_tail.s" \
        --idx-out    "$TMP/prelude.idx" \
        --text-bin   "$TMP/prelude.text.bin" \
        --rodata-bin "$TMP/prelude.rodata.bin" \
        --data-bin   "$TMP/prelude.data.bin" \
        --reloc-out  "$TMP/prelude.reloc" 2>/dev/null

    # Step 5: final asm_pass2 with --load-idx + --prelude-*.
    "$QEMU" "$GEN2_DIR/asm_pass2" \
        --load-idx "$TMP/prelude.idx" \
        --idx-source "$TMP/prelude.s" \
        --prelude-text-bin "$TMP/prelude.text.bin" \
        --prelude-rodata-bin "$TMP/prelude.rodata.bin" \
        --prelude-data-bin "$TMP/prelude.data.bin" \
        --prelude-reloc "$TMP/prelude.reloc" \
        --lab-out "$TMP/full.lab" \
        "$TMP/user.s" 2>/dev/null

    # Step 6: final asm_pass3 reads the .lab + memcpys the prelude .bin
    # + encodes user.s.
    "$QEMU" "$GEN2_DIR/asm_pass3" --lab "$TMP/full.lab" --out "$OUTFILE" 2>/dev/null
else
    # Legacy: assemble everything into one full.s and let asm_pass2 +
    # asm_pass3 walk it from text. No pre-encode, no .bin reuse.
    {
        [ -n "$ASM_PROLOGUE" ] && printf '%s\n' "$ASM_PROLOGUE"
        cat "$CRT0"
        cat "$TMP/runtime.s"
        cat "${ASM_FILES[@]}"
        for extra_s in ${EXTRA_S:-}; do cat "$extra_s"; done
        cat "$CRT0_DATA"
    } > "$TMP/full.s"

    "$QEMU" "$GEN2_DIR/asm_pass2" < "$TMP/full.s" > "$TMP/full.lab"
    cat "$TMP/full.lab" "$TMP/full.s" "$TMP/full.s" "$TMP/full.s" | \
        "$QEMU" "$GEN2_DIR/asm_pass3" > "$OUTFILE"
fi

chmod +x "$OUTFILE"

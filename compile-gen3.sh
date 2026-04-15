#!/bin/bash
# compile-gen3.sh — Compile .tc to RV32 ELF using Gen3 tools (via qemu).
# Uses: Gen1 parse/extract-sigs (for import .th generation),
#       Gen3 sigscan/tcheck/codegen/bc2asm/asm_pass1/asm_pass2 (qemu).
#
# Usage: GEN3_DIR=/path/to/gen3 ./compile-gen3.sh [-o output] file.tc
#
# Mirrors compile-gen2.sh exactly; the only difference is which
# binaries it calls (GEN3_DIR instead of GEN2_DIR). Used by
# tests/test_gen3.sh to verify Gen2 == Gen3 self-hosting.
#
# Requires: Gen1 tools (parse, extract-sigs),
#           Gen3 tools in GEN3_DIR (sigscan, tcheck, codegen, bc2asm,
#             asm_pass1, asm_pass2),
#           qemu-riscv32

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARSE="$ROOT_DIR/parse"
EXTRACT_SIGS="$ROOT_DIR/extract-sigs"
QEMU="${QEMU:-qemu-riscv32}"
CRT0="$ROOT_DIR/compiler/crt0_tc.s"
CRT0_DATA="$ROOT_DIR/compiler/crt0_tc_data.s"
RUNTIME_TC="$ROOT_DIR/compiler/runtime.tc"

OUTFILE="a.out"
TC_FILE=""

while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: GEN3_DIR=/path/to/gen3 compile-gen3.sh [-o output] file.tc" >&2
    exit 1
fi

if [ -z "$GEN3_DIR" ]; then
    echo "Error: GEN3_DIR not set. Build Gen3 tools first with compile-gen2.sh." >&2
    exit 1
fi

for tool in sigscan tcheck codegen bc2asm asm_pass1 asm_pass2; do
    if [ ! -x "$GEN3_DIR/$tool" ]; then
        echo "Error: Gen3 tool not found: $GEN3_DIR/$tool" >&2
        exit 1
    fi
done

# Stale-cache check (see problem.md #15 and compile-gen2.sh for the
# same check).
if find "$ROOT_DIR/compiler" -maxdepth 1 -name '*.tc' \
        -newer "$GEN3_DIR/tcheck" -print -quit 2>/dev/null | grep -q .; then
    {
        echo "warning: GEN3_DIR=$GEN3_DIR is older than compiler/*.tc"
        echo "         rebuild with compile-gen2.sh against each compiler/*.tc"
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

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

# Collect import files
_COLLECTED=""
_collect_imports "$TC_FILE"
IMPORT_FILES=()
while IFS= read -r f; do
    [ -z "$f" ] && continue
    IMPORT_FILES+=("$f")
done <<< "$_COLLECTED"

ALL_FILES=("${IMPORT_FILES[@]}" "$TC_FILE")

# Generate the shared (imports …) block via Gen1 parse + extract-sigs
# (see compile-gen2.sh for the rationale).
if [ ${#IMPORT_FILES[@]} -gt 0 ]; then
    {
        echo "(imports"
        for imp in "${IMPORT_FILES[@]}"; do
            "$PARSE" "$imp" | "$EXTRACT_SIGS"
        done
        echo ")"
    } > "$TMP/imports.th"
else
    printf '(imports)\n' > "$TMP/imports.th"
fi

# Compile helper: .tc → .s using Gen3 pipeline
compile_one() {
    local tc="$1" out_s="$2"
    local base
    base=$(basename "$tc" .tc)
    local ast="$TMP/$base.ast"
    local self_th="$TMP/$base.self.th"
    local wrap="$TMP/$base.wrap"
    "$PARSE" "$tc" > "$ast"
    "$QEMU" "$GEN3_DIR/sigscan" < "$ast" > "$self_th"
    {
        cat "$TMP/imports.th"
        printf '(self\n'
        cat "$self_th"
        printf ')\n'
        cat "$ast"
    } > "$wrap"
    "$QEMU" "$GEN3_DIR/tcheck"  < "$wrap" | \
        "$QEMU" "$GEN3_DIR/codegen" | \
        "$QEMU" "$GEN3_DIR/bc2asm" > "$out_s"
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

# Assemble: crt0_tc.s + runtime.s + user .s files + crt0_tc_data.s → ELF via Gen3 asm split
{
    cat "$CRT0"
    cat "$TMP/runtime.s"
    cat "${ASM_FILES[@]}"
    cat "$CRT0_DATA"
} > "$TMP/full.s"

"$QEMU" "$GEN3_DIR/asm_pass1" < "$TMP/full.s" > "$TMP/full.lab"
cat "$TMP/full.lab" "$TMP/full.s" | "$QEMU" "$GEN3_DIR/asm_pass2" > "$OUTFILE"

chmod +x "$OUTFILE"

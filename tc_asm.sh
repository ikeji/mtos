#!/bin/bash
# tc_asm.sh — compile a .tc file using the asm.tc pipeline (no GCC linker)
# Usage: ./tc_asm.sh [-o output.elf] file.tc
#
# Pipeline: runtime.tc + file.tc → codegen → bc2asm → asm.tc → ELF

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEGEN="$ROOT_DIR/codegen"
BC2ASM="$ROOT_DIR/bc2asm"
BCRUN="$ROOT_DIR/bcrun"
CRT0="$ROOT_DIR/compiler/crt0_tc.s"
RUNTIME="$ROOT_DIR/compiler/runtime.tc"

SCRIPT_DIR="$ROOT_DIR/tests"
source "$ROOT_DIR/tests/test_common.sh"

# Re-set after sourcing test_common.sh (which overwrites RUNTIME/CRT0)
CRT0="$ROOT_DIR/compiler/crt0_tc.s"
RUNTIME="$ROOT_DIR/compiler/runtime.tc"

OUTFILE="a.out"
TC_FILE=""

# Parse args
while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: tc_asm.sh [-o output.elf] file.tc" >&2
    exit 1
fi

# Compile runtime.tc (--no-builtins)
RUNTIME_BC=$("$CODEGEN" --no-builtins "$RUNTIME" 2>/dev/null)

# Compile user .tc file with import resolution (same as compile_tc_to_bc)
ALL_USER_BCS=()
while IFS= read -r imp_file; do
    [ -z "$imp_file" ] && continue
    ALL_USER_BCS+=("$("$CODEGEN" "$imp_file" 2>/dev/null)")
done < <(collect_imports "$TC_FILE")
ALL_USER_BCS+=("$("$CODEGEN" "$TC_FILE" 2>/dev/null)")

# Merge all BCs (runtime + imports + main) and convert to assembly
MERGED_S=$(
    echo ".bc"
    printf '%s\n' "$RUNTIME_BC" | sed '/^\.bc$/d; /^\.endbc$/d'
    for bc in "${ALL_USER_BCS[@]}"; do
        printf '%s\n' "$bc" | sed '/^\.bc$/d; /^\.endbc$/d'
    done
    echo ".endbc"
)
USER_S=$(printf '%s\n' "$MERGED_S" | "$BC2ASM" 2>/dev/null)

# Assemble: crt0_tc.s + user.s + crt0_tc_data.s → ELF via asm.tc
# Data/BSS must come AFTER all code (asm.tc ignores section directives)
CRT0_DATA="$ROOT_DIR/compiler/crt0_tc_data.s"
ASM_BC=$(compile_tc_to_bc "$ROOT_DIR/compiler/asm.tc")
{ cat "$CRT0"; printf '%s\n' "$USER_S"; cat "$CRT0_DATA"; } | \
    { printf '%s\n' "$ASM_BC"; cat; } | "$BCRUN" > "$OUTFILE"

chmod +x "$OUTFILE"
echo "Output: $OUTFILE"

#!/bin/bash
# tc_run_all.sh — run a .tc program with all execution methods and compare results
#
# Usage: tc_run_all.sh <file.tc> [stdin]
#
#   [stdin]  string passed as program stdin; prefix '@' to read from file

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TC_RUN="$ROOT_DIR/tc_run.sh"

TC_FILE="${1:-}"
STDIN_ARG="${2:-}"

if [ -z "$TC_FILE" ]; then
    echo "Usage: tc_run_all.sh <file.tc> [stdin]"
    exit 1
fi
if [ ! -f "$TC_FILE" ]; then echo "Error: not found: $TC_FILE" >&2; exit 1; fi

METHODS=(interp bcrun rv32 pipeline bc2asm_tc)

run_method() {
    local method="$1"
    local output exit_code
    if [ -n "$STDIN_ARG" ]; then
        output=$("$TC_RUN" "$method" "$TC_FILE" "$STDIN_ARG" 2>/dev/null)
    else
        output=$("$TC_RUN" "$method" "$TC_FILE" 2>/dev/null)
    fi
    exit_code=$?
    printf '%s\n' "$output"
    return $exit_code
}

FIRST_OUTPUT=""
ALL_SAME=true

for method in "${METHODS[@]}"; do
    printf '=== %-12s ' "$method"
    output=$(run_method "$method")
    ec=$?
    printf '(exit %d) ===\n' "$ec"
    printf '%s\n' "$output"
    echo ""

    if [ -z "$FIRST_OUTPUT" ]; then
        FIRST_OUTPUT="$output"
    elif [ "$output" != "$FIRST_OUTPUT" ]; then
        ALL_SAME=false
    fi
done

if $ALL_SAME; then
    echo ">>> All methods produced identical output."
else
    echo ">>> WARNING: methods produced different output."
fi

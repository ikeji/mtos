#!/bin/bash
# tc_deps_to_d.sh — emit a Makefile `.d` fragment for a TinyC source.
#
# Usage:
#   tools/tc_deps_to_d.sh <make_target> <file.tc>
#
# Output (single line, Makefile-friendly):
#   <make_target>: file.tc imported1.tc imported2.tc ...
#
# This is what `-include build/gen2/*.d` picks up so that editing
# e.g. compiler/string_buffer.tc triggers build/gen2/parse to
# rebuild (and only that one Gen2 tool).

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <make_target> <file.tc>" >&2
    exit 1
fi

TARGET="$1"
TC_FILE="$2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

deps=$("$SCRIPT_DIR/collect_imports.sh" "$TC_FILE" | tr '\n' ' ')
printf '%s: %s\n' "$TARGET" "$deps"

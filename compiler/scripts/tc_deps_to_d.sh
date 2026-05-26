#!/bin/bash
# tc_deps_to_d.sh — emit a Makefile `.d` fragment for a TinyC source.
#
# Usage:
#   tools/tc_deps_to_d.sh <make_target> <file.tc>
#
# Output (single line, Makefile-friendly):
#   <make_target>: file.tc imported1.tc imported2.tc ...
#
# This is what `-include compiler/build/gen2/*.d` picks up so that editing
# e.g. compiler/string_buffer.tc triggers compiler/build/gen2/parse to
# rebuild (and only that one Gen2 tool).

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <make_target> <file.tc>" >&2
    exit 1
fi

TARGET="$1"
TC_FILE="$2"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Normalize each dep with realpath so paths work regardless of which dir
# Make is invoked from. Without this, deps like
# `userland/bin/cat/../../lib/libtc/libtc.tc` resolve correctly only when
# Make's CWD is the project root; `make -C userland` would see
# `userland/userland/lib/libtc/libtc.tc` and fail with "no rule to make
# target".
deps=""
while IFS= read -r dep; do
    [ -z "$dep" ] && continue
    abs=$(realpath -m "$dep" 2>/dev/null || echo "$dep")
    deps="$deps $abs"
done < <("$SCRIPT_DIR/collect_imports.sh" "$TC_FILE")
printf '%s:%s\n' "$TARGET" "$deps"

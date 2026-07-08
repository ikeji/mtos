#!/bin/bash
# compile-gen3.sh — Compile .tc to RV32 ELF using Gen3 tools (via qemu).
#
# Usage: GEN3_DIR=/path/to/gen3 ./compile-gen3.sh [-o output] file.tc
#
# Thin wrapper: compile-gen2.sh is fully parameterized by GEN2_DIR, so
# "compile with Gen3 tools" is just pointing it at the Gen3 binaries.
#
# This file used to be a full copy of compile-gen2.sh that had drifted
# far behind it (old cat-concatenated prelude flow; no per-file
# ASM_PROLOGUE / CRT0 lists, no CACHED_S_DIR, no .incbin staging)
# while its header still claimed "mirrors compile-gen2.sh exactly".
# Nothing in-tree called it — compiler/Makefile's gen3 target invokes
# compile-gen2.sh directly and test_gen3.sh drives the gen3 pipeline
# stages itself — so it survives only as the documented CLI
# (CLAUDE.md「コンパイルスクリプト」). See docs/task/
# refactor_candidates.md A3.

set -e

if [ -z "$GEN3_DIR" ]; then
    echo "Error: GEN3_DIR not set. Build Gen3 tools first (make -C compiler gen3)." >&2
    exit 1
fi

exec env GEN2_DIR="$GEN3_DIR" \
    "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/compile-gen2.sh" "$@"

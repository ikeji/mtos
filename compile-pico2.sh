#!/bin/bash
# compile-pico2.sh — compile a .tc file to a Pico 2 UF2.
#
# Wraps compile-gen2.sh with Pico 2 specific crt0 / crt0_data and a
# `; raw` asm prologue so asm.tc emits a flat binary suitable for
# Flash XIP at 0x10000000. Then converts that binary to UF2 via
# pico2/bin2uf2.py.
#
# Usage:
#   GEN2_DIR=/path/to/gen2_tools ./compile-pico2.sh -o out.uf2 file.tc

set -e
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

OUTFILE="a.uf2"
TC_FILE=""
while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  TC_FILE="$1"; shift ;;
    esac
done

if [ -z "$TC_FILE" ]; then
    echo "Usage: GEN2_DIR=... compile-pico2.sh [-o out.uf2] file.tc" >&2
    exit 1
fi

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set. Build Gen2 tools first with compile-gen1.sh." >&2
    exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

BIN="$TMP/out.bin"
CRT0="$ROOT_DIR/pico2/crt0_pico2.s" \
CRT0_DATA="$ROOT_DIR/pico2/crt0_pico2_data.s" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$BIN" "$TC_FILE"

python3 "$ROOT_DIR/pico2/bin2uf2.py" "$BIN" "$OUTFILE" 0x10000000

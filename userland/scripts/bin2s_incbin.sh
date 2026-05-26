#!/bin/bash
# bin2s_incbin.sh — emit a small .s file that uses .incbin to embed
# a binary blob in .rodata. Replaces bin2s.sh's verbose `.byte` form
# (which expands a 3.86 MB disk image into 29 MB of asm text). The
# binary file's path is baked into the .s so asm_pass3 can open it
# at link time.
#
# Usage: ./bin2s_incbin.sh input.bin SYMBOL_PREFIX BLOB_PATH > output.s
#
# Output defines:
#   SYMBOL_PREFIX_start  — label at start of data
#   SYMBOL_PREFIX_end    — label at end of data
#   SYMBOL_PREFIX_size   — .word with size in bytes
#   SYMBOL_PREFIX_addr   — .text fn returning the start address
#
# input.bin is read once at .s generation time to capture its size.
# BLOB_PATH is the path that asm_pass3 will use at link time to
# reopen the bytes (typically the same file, or a /sd/ path on pico2).

set -e

if [ $# -ne 3 ]; then
    echo "Usage: bin2s_incbin.sh input.bin SYMBOL_PREFIX BLOB_PATH" >&2
    exit 1
fi

INFILE="$1"
PREFIX="$2"
BLOB_PATH="$3"

if [ ! -f "$INFILE" ]; then
    echo "Error: $INFILE not found" >&2
    exit 1
fi

SIZE=$(wc -c < "$INFILE")
# Pad SIZE to a fixed width so the wrapper .s file's text length
# is stable across builds — the .incbin literal expands at link
# time to the exact byte count regardless of how SIZE is spelled,
# and asm_common's parse_imm_op skips leading whitespace. This
# matters when the wrapper itself is staged inside the disk image
# we're describing: a stable wrapper size lets the on-device
# self-replicate path produce bytes identical to the host build.
SIZE_PAD=$(printf '%10d' "$SIZE")

cat <<EOF
    .rodata
    .align 4
    .globl ${PREFIX}_start
${PREFIX}_start:
    .incbin $SIZE_PAD "$BLOB_PATH"
    .globl ${PREFIX}_end
${PREFIX}_end:
    .globl ${PREFIX}_size
${PREFIX}_size:
    .word $SIZE
    .text
    .globl ${PREFIX}_addr
${PREFIX}_addr:
    la   a0, ${PREFIX}_start
    ret
    .globl ${PREFIX}_size_value
${PREFIX}_size_value:
    li   a0, $SIZE
    ret
EOF

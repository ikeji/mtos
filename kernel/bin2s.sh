#!/bin/bash
# bin2s.sh — convert a raw binary to a .s file with .byte directives
# Usage: ./bin2s.sh input.bin SYMBOL_PREFIX > output.s
#
# Output defines:
#   SYMBOL_PREFIX_start  — label at start of data
#   SYMBOL_PREFIX_end    — label at end of data
#   SYMBOL_PREFIX_size   — .word with size in bytes
#
# Emits 4 bytes per .byte line (asm.tc operand limit).

set -e

if [ $# -ne 2 ]; then
    echo "Usage: bin2s.sh input.bin SYMBOL_PREFIX" >&2
    exit 1
fi

INFILE="$1"
PREFIX="$2"

if [ ! -f "$INFILE" ]; then
    echo "Error: $INFILE not found" >&2
    exit 1
fi

SIZE=$(wc -c < "$INFILE")

echo "    .rodata"
echo "    .align 4"
echo "    .globl ${PREFIX}_start"
echo "${PREFIX}_start:"

# Emit .byte directives, 4 bytes per line (asm.tc g_nops limit)
od -An -v -tx1 "$INFILE" | tr -s ' ' '\n' | grep -v '^$' | \
    paste -d' ' - - - - | while IFS=' ' read -r a b c d; do
    if [ -n "$d" ]; then
        echo "    .byte 0x$a,0x$b,0x$c,0x$d"
    elif [ -n "$c" ]; then
        echo "    .byte 0x$a,0x$b,0x$c"
    elif [ -n "$b" ]; then
        echo "    .byte 0x$a,0x$b"
    elif [ -n "$a" ]; then
        echo "    .byte 0x$a"
    fi
done

echo "    .globl ${PREFIX}_end"
echo "${PREFIX}_end:"
echo "    .globl ${PREFIX}_size"
echo "${PREFIX}_size:"
echo "    .word $SIZE"

# Assembly function returning the start address (callable from TC)
# TC declaration: fn PREFIX_addr() -> u32;
echo "    .text"
echo "    .globl ${PREFIX}_addr"
echo "${PREFIX}_addr:"
echo "    la   a0, ${PREFIX}_start"
echo "    ret"

#!/bin/bash
# kernel/build_pico2.sh — build kernel for Pico 2, output UF2
#
# Usage: GEN2_DIR=/path/to/gen2 ./kernel/build_pico2.sh [-o output.uf2]

set -e
KERN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$KERN_DIR")"

OUTFILE="kernel_pico2.uf2"
while [ $# -gt 0 ]; do
    case "$1" in
        -o) OUTFILE="$2"; shift 2 ;;
        *)  shift ;;
    esac
done

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set" >&2
    exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

TASK_CRT0="$KERN_DIR/tasks/task_crt0.s"
TASK_DATA="$KERN_DIR/tasks/task_data.s"

# Build tasks as raw binaries
echo "Building task: hello (pico2)" >&2
CRT0="$TASK_CRT0" \
CRT0_DATA="$TASK_DATA" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$TMP/hello.bin" \
    "$KERN_DIR/tasks/pico2_hello/hello.tc" 2>/dev/null

echo "Building task: hello2 (pico2)" >&2
CRT0="$TASK_CRT0" \
CRT0_DATA="$TASK_DATA" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$TMP/hello2.bin" \
    "$KERN_DIR/tasks/pico2_hello2/hello2.tc" 2>/dev/null

# Convert to .s
"$KERN_DIR/bin2s.sh" "$TMP/hello.bin" _task_hello > "$TMP/hello_task.s"
"$KERN_DIR/bin2s.sh" "$TMP/hello2.bin" _task_hello2 > "$TMP/hello2_task.s"

# Build kernel with ; raw + embedded tasks
cat "$KERN_DIR/crt0_pico2_data.s" "$TMP/hello_task.s" "$TMP/hello2_task.s" > "$TMP/kern_data.s"

echo "Building kernel (pico2)" >&2
CRT0="$KERN_DIR/crt0_pico2.s" \
CRT0_DATA="$TMP/kern_data.s" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$TMP/kernel.bin" \
    "$KERN_DIR/kernel_pico2.tc" 2>/dev/null

if [ ! -s "$TMP/kernel.bin" ]; then
    echo "Error: kernel compilation failed" >&2
    exit 1
fi

echo "kernel.bin: $(wc -c < "$TMP/kernel.bin") bytes" >&2

# Convert to UF2
python3 "$ROOT_DIR/pico2/bin2uf2.py" "$TMP/kernel.bin" "$OUTFILE"
echo "Built: $OUTFILE" >&2

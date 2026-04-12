#!/bin/bash
# kernel/build_virt.sh — build kernel + embedded tasks for qemu virt
#
# Usage: GEN2_DIR=/path/to/gen2 ./kernel/build_virt.sh [-o output.bin]
#
# Steps:
#   1. Compile each task as raw binary (task_crt0 + runtime + task.tc)
#   2. Convert task binaries to .s via bin2s.sh
#   3. Compile kernel with embedded task data

set -e
KERN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$KERN_DIR")"

OUTFILE="kernel_virt.bin"
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

QEMU="${QEMU:-qemu-riscv32}"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

TASK_CRT0="$KERN_DIR/tasks/task_crt0.s"
TASK_DATA="$KERN_DIR/tasks/task_data.s"

# --- Step 1: Build task binaries ---
echo "Building task: hello" >&2
CRT0="$TASK_CRT0" \
CRT0_DATA="$TASK_DATA" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$TMP/hello.bin" \
    "$KERN_DIR/tasks/hello/hello.tc" 2>/dev/null

if [ ! -s "$TMP/hello.bin" ]; then
    echo "Error: hello task compilation failed" >&2
    exit 1
fi

# --- Step 2: Convert to .s ---
"$KERN_DIR/bin2s.sh" "$TMP/hello.bin" _task_hello > "$TMP/hello_task.s"

# --- Step 3: Build kernel with embedded tasks ---
# We need to inject the task .s into the assembly stream.
# compile-gen2.sh concatenates: CRT0 + runtime.s + user.s + CRT0_DATA
# We put the task data in CRT0_DATA (before __arena).
cat "$KERN_DIR/crt0_data.s" "$TMP/hello_task.s" > "$TMP/kern_data.s"

CRT0="$KERN_DIR/crt0_virt.s" \
CRT0_DATA="$TMP/kern_data.s" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$OUTFILE" \
    "$KERN_DIR/kernel.tc" 2>/dev/null

if [ ! -s "$OUTFILE" ]; then
    echo "Error: kernel compilation failed" >&2
    exit 1
fi

echo "Built: $OUTFILE" >&2

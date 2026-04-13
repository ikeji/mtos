#!/bin/bash
# kernel/build.sh — unified kernel build for virt and pico2
#
# Usage: GEN2_DIR=/path/to/gen2 ./kernel/build.sh --target virt|pico2 [-o output]
#
# Targets:
#   virt   → raw bin for qemu-system-riscv32 -M virt (preemptive kernel)
#   pico2  → UF2 for RP2350 (preemptive kernel)

set -e
KERN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$KERN_DIR")"

TARGET=""
OUTFILE=""
while [ $# -gt 0 ]; do
    case "$1" in
        --target) TARGET="$2"; shift 2 ;;
        -o) OUTFILE="$2"; shift 2 ;;
        *) shift ;;
    esac
done

if [ -z "$TARGET" ]; then
    echo "Usage: build.sh --target virt|pico2 [-o output]" >&2
    exit 1
fi

if [ -z "$GEN2_DIR" ]; then
    echo "Error: GEN2_DIR not set" >&2
    exit 1
fi

case "$TARGET" in
    virt)
        PLATFORM_S="$KERN_DIR/platform_virt.s"
        DATA_S="$KERN_DIR/crt0_data.s"
        KERNEL_TC="$KERN_DIR/kernel.tc"
        : "${OUTFILE:=kernel_virt.bin}"
        ;;
    pico2)
        PLATFORM_S="$KERN_DIR/platform_pico2.s"
        DATA_S="$KERN_DIR/crt0_pico2_data.s"
        KERNEL_TC="$KERN_DIR/kernel_pico2.tc"
        : "${OUTFILE:=kernel_pico2.uf2}"
        ;;
    *)
        echo "Error: unknown target: $TARGET (use virt or pico2)" >&2
        exit 1
        ;;
esac

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

TASK_CRT0="$KERN_DIR/tasks/task_crt0.s"
TASK_DATA="$KERN_DIR/tasks/task_data.s"

# --- Step 1: Build task binaries ---
for task in hello hello2 catfile; do
    echo "Building task: $task" >&2
    CRT0="$TASK_CRT0" \
    CRT0_DATA="$TASK_DATA" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$GEN2_DIR" \
        "$ROOT_DIR/compile-gen2.sh" -o "$TMP/$task.bin" \
        "$KERN_DIR/tasks/$task/$task.tc" 2>/dev/null
    if [ ! -s "$TMP/$task.bin" ]; then
        echo "Error: $task task compilation failed" >&2
        exit 1
    fi
done

# --- Step 2: Convert tasks to .s ---
"$KERN_DIR/bin2s.sh" "$TMP/hello.bin" _task_hello > "$TMP/hello_task.s"
"$KERN_DIR/bin2s.sh" "$TMP/hello2.bin" _task_hello2 > "$TMP/hello2_task.s"
"$KERN_DIR/bin2s.sh" "$TMP/catfile.bin" _task_catfile > "$TMP/catfile_task.s"

# --- Step 2b (pico2 only): build a default mtfs disk image and embed it
# as _mtfs_image_* so block_flash.tc can read it via XIP. On virt the disk
# is supplied by qemu's -drive and read through virtio-blk. The kernel .tc
# file already picks the correct backend via its imports. ---
MTFS_S=""
if [ "$TARGET" = "pico2" ]; then
    printf 'hello, mtfs\n' > "$TMP/hello.txt"
    python3 "$ROOT_DIR/tools/mkfs.py" "$TMP/mtfs.img" "$TMP/hello.txt" >&2
    "$KERN_DIR/bin2s.sh" "$TMP/mtfs.img" _mtfs_image > "$TMP/mtfs_image.s"
    MTFS_S="$TMP/mtfs_image.s"
fi

# --- Step 3: Build kernel ---
# Concat platform.s + trap_common.s as the "crt0"
cat "$PLATFORM_S" "$KERN_DIR/trap_common.s" > "$TMP/crt0.s"
cat "$DATA_S" "$TMP/hello_task.s" "$TMP/hello2_task.s" "$TMP/catfile_task.s" \
    ${MTFS_S:+"$MTFS_S"} > "$TMP/kern_data.s"

echo "Building kernel: $TARGET" >&2
CRT0="$TMP/crt0.s" \
CRT0_DATA="$TMP/kern_data.s" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
    "$ROOT_DIR/compile-gen2.sh" -o "$TMP/kernel.bin" \
    "$KERNEL_TC" 2>/dev/null

if [ ! -s "$TMP/kernel.bin" ]; then
    echo "Error: kernel compilation failed" >&2
    exit 1
fi

# --- Step 4: Output ---
case "$TARGET" in
    virt)
        cp "$TMP/kernel.bin" "$OUTFILE"
        ;;
    pico2)
        python3 "$ROOT_DIR/pico2/bin2uf2.py" "$TMP/kernel.bin" "$OUTFILE"
        ;;
esac

echo "Built: $OUTFILE" >&2

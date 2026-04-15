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
DISK_OUT=""
while [ $# -gt 0 ]; do
    case "$1" in
        --target)   TARGET="$2"; shift 2 ;;
        -o)         OUTFILE="$2"; shift 2 ;;
        --disk-out) DISK_OUT="$2"; shift 2 ;;
        *)          shift ;;
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
        # virt slot 2 is /bin/sh; /bin/launcher is pico2-only.
        # tmpdemo exercises the tmpfs write path under /tmp/.
        # echo is used by the redirect test (echo hi > /tmp/redir).
        TASKS="hello hello2 catfile sh tmpdemo echo"
        : "${OUTFILE:=kernel_virt.bin}"
        ;;
    pico2)
        PLATFORM_S="$KERN_DIR/platform_pico2.s"
        DATA_S="$KERN_DIR/crt0_pico2_data.s"
        KERNEL_TC="$KERN_DIR/kernel_pico2.tc"
        # pico2 has no interactive stdin pipe; slot 2 uses launcher.
        TASKS="hello hello2 catfile launcher"
        : "${OUTFILE:=kernel_pico2.uf2}"
        ;;
    *)
        echo "Error: unknown target: $TARGET (use virt or pico2)" >&2
        exit 1
        ;;
esac

# Optional EXTRA_TASKS env var: append experimental tasks (e.g. the
# phase 7 compiler binaries /bin/parse, /bin/typecheck, ...) to the
# base TASKS list. `kernel/tasks/<name>/<name>.tc` may be a symlink
# into compiler/; compile-gen2.sh resolves symlinks before import
# collection so this works without copying files.
if [ -n "$EXTRA_TASKS" ]; then
    TASKS="$TASKS $EXTRA_TASKS"
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

TASK_CRT0="$KERN_DIR/tasks/task_crt0.s"
TASK_DATA="$KERN_DIR/tasks/task_data.s"

QEMU="${QEMU:-qemu-riscv32}"
PARSE="$ROOT_DIR/parse"

# --- Step 0: Pre-compile runtime.tc and libtc.tc once ---
# compile-gen2.sh compiles runtime.tc inside every task/kernel build.
# That's a ~1.4 s Gen2 pipeline (parse → sigscan → tcheck → codegen
# → bc2asm) multiplied by 7 builds here = ~10 s of redundant work.
# libtc.tc adds another 5 × 0.15 s. We run the pipeline ourselves
# once per shared module and pass the resulting .s files via
# CACHED_S_DIR so compile-gen2.sh's compile_one() copies them
# instead of recompiling. Neither runtime.tc nor libtc.tc has
# imports, so the wrapped stdin for tcheck uses an empty (imports)
# block and a (self …) block produced by sigscan from the parsed
# .ast.
CACHE_DIR="$TMP/sc"
mkdir -p "$CACHE_DIR"

precompile_shared() {
    local src="$1" out="$2"
    local ast th
    ast="$TMP/$(basename "$src").ast"
    th="$TMP/$(basename "$src").th"
    "$PARSE" "$src" > "$ast"
    "$QEMU" "$GEN2_DIR/sigscan" < "$ast" > "$th"
    {
        printf '(imports)\n(self\n'
        cat "$th"
        printf ')\n'
        cat "$ast"
    } | "$QEMU" "$GEN2_DIR/tcheck" \
      | "$QEMU" "$GEN2_DIR/codegen" \
      | "$QEMU" "$GEN2_DIR/bc2asm" > "$out"
}

echo "Pre-compiling runtime.tc (shared)" >&2
precompile_shared "$ROOT_DIR/compiler/runtime.tc" "$CACHE_DIR/runtime.s"
if [ ! -s "$CACHE_DIR/runtime.s" ]; then
    echo "Error: runtime.tc pre-compile failed" >&2
    exit 1
fi

echo "Pre-compiling libtc.tc (shared)" >&2
precompile_shared "$KERN_DIR/tasks/libtc/libtc.tc" "$CACHE_DIR/libtc.s"
if [ ! -s "$CACHE_DIR/libtc.s" ]; then
    echo "Error: libtc.tc pre-compile failed" >&2
    exit 1
fi

export CACHED_S_DIR="$CACHE_DIR"

# --- Step 1: Build task binaries ---
for task in $TASKS; do
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

# --- Step 2: Build mtfs disk image containing the task binaries ---
# Lay out a temporary root directory with /bin/<task> + /hello.txt and
# run mkfs.py against it. The resulting mtfs image is either supplied to
# qemu via -drive (virt) or embedded in .rodata via bin2s (pico2). In
# both cases the kernel reads task binaries at runtime through the VFS
# layer — no more _task_*_addr() in .rodata.
ROOT_DIR_TREE="$TMP/root"
mkdir -p "$ROOT_DIR_TREE/bin"
for task in $TASKS; do
    cp "$TMP/$task.bin" "$ROOT_DIR_TREE/bin/$task"
done
printf 'hello, mtfs\n' > "$ROOT_DIR_TREE/hello.txt"
# phase 7 test inputs: small .tc programs that compiler tasks can
# consume from /phase7*.tc. Always staged so tests/test_phase7.sh can
# use the same kernel build regardless of EXTRA_TASKS.
if [ -f "$ROOT_DIR/tests/phase7_hello.tc" ]; then
    cp "$ROOT_DIR/tests/phase7_hello.tc" "$ROOT_DIR_TREE/phase7.tc"
fi
if [ -f "$ROOT_DIR/tests/phase7_min.tc" ]; then
    cp "$ROOT_DIR/tests/phase7_min.tc" "$ROOT_DIR_TREE/phase7_min.tc"
fi
if [ -f "$ROOT_DIR/tests/phase7_hello_world.tc" ]; then
    cp "$ROOT_DIR/tests/phase7_hello_world.tc" "$ROOT_DIR_TREE/hw.tc"
fi
# Phase 7 OS-side linker prelude: the task_crt0.s + runtime.s glue
# is the same for every compile-on-OS build, so we pre-concatenate
# it into a single /prelude.s file inside the mtfs image. The OS-
# side pipeline then only needs one small `cat` step to splice the
# freshly-compiled user .s between /prelude.s and /prelude_tail.s.
#
# Having a single prelude file avoids reading tmpfs files larger
# than ~100 KB under phase 7's sh-driven pipeline, which caused
# intermittent spawn failures for asm during development.
{
    printf '; raw\n'
    cat "$TASK_CRT0"
    cat "$CACHE_DIR/runtime.s"
} > "$ROOT_DIR_TREE/prelude.s"
cp "$TASK_DATA" "$ROOT_DIR_TREE/prelude_tail.s"

# Phase 1 typecheck split (#54): tcheck consumes a wrapped stdin
# of the form (imports …) (self <a.th>) (program …). Stage three
# tiny helper files so the OS-side `cat` pipeline can glue them
# together without needing a printf builtin in sh.
printf '(imports)\n' > "$ROOT_DIR_TREE/empty_imports.txt"
printf '(self\n'    > "$ROOT_DIR_TREE/self_open.txt"
printf ')\n'        > "$ROOT_DIR_TREE/wrap_close.txt"
python3 "$ROOT_DIR/tools/mkfs.py" "$TMP/mtfs.img" "$ROOT_DIR_TREE" >&2

# Optional: copy the mtfs image out for callers that need it (e.g.
# tests/test_os.sh passes it to qemu via -drive).
if [ -n "$DISK_OUT" ]; then
    cp "$TMP/mtfs.img" "$DISK_OUT"
fi

# Pico 2 additionally embeds the image as _mtfs_image_* so block_flash.tc
# can serve it directly from XIP flash.
MTFS_S=""
if [ "$TARGET" = "pico2" ]; then
    "$KERN_DIR/bin2s.sh" "$TMP/mtfs.img" _mtfs_image > "$TMP/mtfs_image.s"
    MTFS_S="$TMP/mtfs_image.s"
fi

# --- Step 3: Build kernel ---
# Concat platform.s + trap_common.s as the "crt0".
# Task binaries no longer live in .rodata — they are read from the mtfs
# image at runtime. On Pico 2 we still append the embedded image .s.
cat "$PLATFORM_S" "$KERN_DIR/trap_common.s" > "$TMP/crt0.s"
cat "$DATA_S" ${MTFS_S:+"$MTFS_S"} > "$TMP/kern_data.s"

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
        python3 "$ROOT_DIR/tools/bin2uf2.py" "$TMP/kernel.bin" "$OUTFILE"
        ;;
esac

echo "Built: $OUTFILE" >&2

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

# Task binary 一覧と arena/stack サイズは kernel/tasks/*/task.mk から
# Makefile が build/kernel/task_sizes.sh に自動生成する。
# standalone 実行時 (make を経由しない場合) のためのフォールバックあり。
TASK_SIZES="$ROOT_DIR/build/kernel/task_sizes.sh"
if [ -f "$TASK_SIZES" ]; then
    source "$TASK_SIZES"
else
    TASKS="hello hello2 catfile sh tmpdemo echo launcher cat"
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

# Optional EXTRA_TASKS env var: append experimental tasks (e.g. the
# phase 7 compiler binaries /bin/parse, /bin/typecheck, ...) to the
# base TASKS list. `kernel/tasks/<name>/<name>.tc` may be a symlink
# into compiler/; compile-gen2.sh resolves symlinks before import
# collection so this works without copying files.
if [ -n "$EXTRA_TASKS" ]; then
    TASKS="$TASKS $EXTRA_TASKS"
fi

TMP=$(mktemp -d)
if [ -z "$KEEP_TMP" ]; then
    trap 'rm -rf "$TMP"' EXIT
else
    echo "KEEP_TMP set: leaving $TMP after build" >&2
fi

TASK_CRT0="$KERN_DIR/tasks/task_crt0.s"
TASK_DATA="$KERN_DIR/tasks/task_data.s"

# ===== Per-task arena / stack sizes (K3) =====
#
# Each task binary starts with an 8-byte header (2 × .word) that
# declares its required arena size (kmalloc pool) and stack size.
# kernel/loader.tc reads this at load time. Sizes are defined in
# kernel/tasks/*/task.mk and auto-generated into task_sizes.sh by
# the Makefile. task_arena_size / task_stack_size are defined there.
# Standalone fallback (no task_sizes.sh) uses defaults below.
if ! type task_arena_size >/dev/null 2>&1; then
    task_arena_size() { echo 32768; }
    task_stack_size() { echo 8192; }
fi

# Emit a 2-word `.text` header file for the given task. When this is
# linked first (before task_crt0.s), asm_pass2/asm_pass3 places the
# two .word entries at offsets 0 and 4 of .text, and _start ends up at
# offset 8. loader.tc adds 8 to the entry address so the CPU skips the
# header words.
emit_task_header() {
    local name="$1" out="$2"
    local arena stack
    arena=$(task_arena_size "$name")
    stack=$(task_stack_size "$name")
    {
        echo "    .text"
        echo "    .word $arena"
        echo "    .word $stack"
    } > "$out"
}

QEMU="${QEMU:-qemu-riscv32}"
PARSE="$ROOT_DIR/build/gen1/parse"

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
    # Emit a per-task 8-byte header + prepend to task_crt0.s via a
    # temp CRT0 file. This puts `.word arena_size; .word stack_size`
    # at offsets 0 and 4 of the binary, with _start at offset 8.
    emit_task_header "$task" "$TMP/${task}_hdr.s"
    cat "$TMP/${task}_hdr.s" "$TASK_CRT0" > "$TMP/${task}_crt0.s"
    # Collect per-task extra .s files (e.g. vi/tut_data.s)
    _extra_s=""
    for _es in "$KERN_DIR/tasks/$task"/*.s; do
        [ -f "$_es" ] && [ "$_es" != "$KERN_DIR/tasks/$task/$task.s" ] && _extra_s="$_extra_s $_es"
    done
    CRT0="$TMP/${task}_crt0.s" \
    CRT0_DATA="$TASK_DATA" \
    ASM_PROLOGUE="; raw" \
    GEN2_DIR="$GEN2_DIR" \
    EXTRA_S="$_extra_s" \
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
# msh script-mode fixtures: smoke / abort tests + the per-stage
# pipeline benchmark driven by tests/test_pico2_bench.sh. Always
# staged so the same kernel build can be exercised without rebuilding.
for f in msh_smoke.sh msh_abort.sh pico2_bench.sh pico2_pass1_phases.sh pico2_compile_sb.sh pico2_bench_idx.sh; do
    if [ -f "$ROOT_DIR/tests/fixtures/$f" ]; then
        cp "$ROOT_DIR/tests/fixtures/$f" "$ROOT_DIR_TREE/$f"
    fi
done
# Phase 7 OS-side linker prelude: the task_crt0.s + runtime.s glue
# is the same for every compile-on-OS build, so we pre-concatenate
# it into a single /prelude.s file inside the mtfs image. The OS-
# side pipeline then only needs one small `cat` step to splice the
# freshly-compiled user .s between /prelude.s and /prelude_tail.s.
#
# Having a single prelude file avoids reading tmpfs files larger
# than ~100 KB under phase 7's sh-driven pipeline, which caused
# intermittent spawn failures for asm during development.
#
# K3: the prelude also carries the 8-byte task header (arena_size /
# stack_size as two .word directives). The OS-side pipeline currently
# only compiles Hello World-sized programs, so we use sh-sized
# defaults — a big enough arena for the test programs without
# starving the kernel of free memory while they run.
# M7 以降、OS 上でコンパイルしたバイナリが parse.tc 級 (peak ~14 KB)
# の arena を使うので 64 KB に拡大。hello world は 4 KB で収まるので無害。
PRELUDE_ARENA=65536
PRELUDE_STACK=8192
{
    printf '; raw\n'
    echo "    .text"
    echo "    .word $PRELUDE_ARENA"
    echo "    .word $PRELUDE_STACK"
    cat "$TASK_CRT0"
    cat "$CACHE_DIR/runtime.s"
} > "$ROOT_DIR_TREE/prelude.s"
cp "$TASK_DATA" "$ROOT_DIR_TREE/prelude_tail.s"

# Pre-link + pre-encode the prelude in one shot (Phase C/D/E of the
# 3-binary asm split): asm_pass1 walks prelude.s alone for the .idx,
# then walks prelude.s + prelude_tail.s combined for the .lab and per-
# section .bin / .reloc. The OS-side asm_pass2 --load-idx skips the
# prelude source walk (~95 s on pico2 phase 7); the OS-side asm_pass3
# memcpies the .bin straight into the output instead of re-tokenising
# the ~10000-line prelude (original 56 s → ~15 s win).
GEN2_ASM_PASS1_TOOL="${GEN2_DIR:-build/gen2}/asm_pass1"
if [ -x "$GEN2_ASM_PASS1_TOOL" ] && command -v qemu-riscv32 >/dev/null 2>&1; then
    qemu-riscv32 "$GEN2_ASM_PASS1_TOOL" \
        "$ROOT_DIR_TREE/prelude.s" \
        --idx-out    "$ROOT_DIR_TREE/prelude.idx" \
        --text-bin   "$ROOT_DIR_TREE/prelude.text.bin" \
        --rodata-bin "$ROOT_DIR_TREE/prelude.rodata.bin" \
        --data-bin   "$ROOT_DIR_TREE/prelude.data.bin" \
        --reloc-out  "$ROOT_DIR_TREE/prelude.reloc" \
        2>/dev/null \
        || echo "WARNING: prelude pre-encode failed" >&2
    if [ -s "$ROOT_DIR_TREE/prelude.idx" ]; then
        chmod 644 "$ROOT_DIR_TREE/prelude.idx" 2>/dev/null || true
        echo "prelude.idx: $(wc -c < "$ROOT_DIR_TREE/prelude.idx") bytes" >&2
    fi
    if [ -s "$ROOT_DIR_TREE/prelude.text.bin" ]; then
        chmod 644 "$ROOT_DIR_TREE/prelude.text.bin" \
                  "$ROOT_DIR_TREE/prelude.rodata.bin" \
                  "$ROOT_DIR_TREE/prelude.data.bin" \
                  "$ROOT_DIR_TREE/prelude.reloc" 2>/dev/null || true
        echo "prelude.text.bin:   $(wc -c < "$ROOT_DIR_TREE/prelude.text.bin") bytes" >&2
        echo "prelude.rodata.bin: $(wc -c < "$ROOT_DIR_TREE/prelude.rodata.bin") bytes" >&2
        echo "prelude.data.bin:   $(wc -c < "$ROOT_DIR_TREE/prelude.data.bin") bytes" >&2
        echo "prelude.reloc:      $(wc -l < "$ROOT_DIR_TREE/prelude.reloc") relocs" >&2
    fi
fi

# Phase 1 typecheck split (#54): tcheck consumes a wrapped stdin
# of the form (imports …) (self <a.th>) (program …). Stage three
# tiny helper files so the OS-side `cat` pipeline can glue them
# together without needing a printf builtin in sh.
printf '(imports)\n'  > "$ROOT_DIR_TREE/empty_imports.txt"
printf '(imports\n'   > "$ROOT_DIR_TREE/imports_open.txt"
printf '(self\n'      > "$ROOT_DIR_TREE/self_open.txt"
printf ')\n'          > "$ROOT_DIR_TREE/wrap_close.txt"

# Optional /etc/kern.conf. Copied from $KERN_CONFIG if set, or from
# kernel/kern.conf if that file exists. When neither exists the kernel
# falls back to its hardcoded init list (hello / hello2 / sh) and
# mux-off, matching legacy behavior.
if [ -n "$KERN_CONFIG" ] && [ -f "$KERN_CONFIG" ]; then
    mkdir -p "$ROOT_DIR_TREE/etc"
    cp "$KERN_CONFIG" "$ROOT_DIR_TREE/etc/kern.conf"
    echo "kern.conf: staged from $KERN_CONFIG" >&2
elif [ -f "$KERN_DIR/kern.conf" ]; then
    mkdir -p "$ROOT_DIR_TREE/etc"
    cp "$KERN_DIR/kern.conf" "$ROOT_DIR_TREE/etc/kern.conf"
    echo "kern.conf: staged from kernel/kern.conf" >&2
fi

# M7: stage compiler source under /src so the OS can self-compile
# parse.tc + its imports. Only staged when EXTRA_TASKS is set
# (phase 7 testing) since these files are large.
if [ -n "$EXTRA_TASKS" ]; then
    mkdir -p "$ROOT_DIR_TREE/src"
    for src in string_buffer.tc source_reader.tc strlib.tc parse.tc; do
        cp "$ROOT_DIR/compiler/$src" "$ROOT_DIR_TREE/src/$src"
    done
    echo "M7: staged /src/*.tc" >&2
fi

if [ ! -x "$ROOT_DIR/build/gen2/mkfs" ]; then
    echo "kernel/build.sh: build/gen2/mkfs missing — run 'make build/gen2/mkfs' first" >&2
    exit 1
fi
qemu-riscv32 "$ROOT_DIR/build/gen2/mkfs" "$TMP/mtfs.img" "$ROOT_DIR_TREE" >&2

# Optional: copy the mtfs image out for callers that need it (e.g.
# tests/test_os.sh passes it to qemu via -drive).
if [ -n "$DISK_OUT" ]; then
    cp "$TMP/mtfs.img" "$DISK_OUT"
fi

# Optional PRELUDE_OUT_DIR: export the staged prelude.s / prelude_tail.s
# + the pre-encoded prelude.idx / prelude.{text,rodata,data}.bin /
# prelude.reloc to the given directory so host-side drivers (the
# pico2 hello-world pipeline, the phase3-verify reference generator)
# can replay the exact linker prelude bytes the OS will see.
if [ -n "$PRELUDE_OUT_DIR" ]; then
    mkdir -p "$PRELUDE_OUT_DIR"
    cp "$ROOT_DIR_TREE/prelude.s"         "$PRELUDE_OUT_DIR/"
    cp "$ROOT_DIR_TREE/prelude_tail.s"    "$PRELUDE_OUT_DIR/"
    for f in prelude.idx prelude.text.bin prelude.rodata.bin \
             prelude.data.bin prelude.reloc; do
        [ -s "$ROOT_DIR_TREE/$f" ] && cp "$ROOT_DIR_TREE/$f" "$PRELUDE_OUT_DIR/"
    done
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
# Kernel uses UNIFIED_PRELUDE=1 (split flow): each .s goes through
# its own asm_pass1, then asm_pass2 --link merges N inputs. Cross-
# input la references — including kernel.tc's `la rd, _trap_frame`
# whose target lives in user-defined sections — are emitted as
# kind=3 (auto-la) and resolved at link time into kind=1 (pc-rel)
# or kind=2 (gp-rel) based on the target's final section. Verified
# byte-exact against KERN_UNIFIED_PRELUDE=0 for both virt and pico2
# kernels at the time of switchover. Override =0 only when bisecting
# asm_pass1 changes.
CRT0="$TMP/crt0.s" \
CRT0_DATA="$TMP/kern_data.s" \
ASM_PROLOGUE="; raw" \
GEN2_DIR="$GEN2_DIR" \
UNIFIED_PRELUDE="${KERN_UNIFIED_PRELUDE:-1}" \
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
        # Phase 8: bin2uf2 ported to TC at tools/bin2uf2.tc, built to
        # build/gen2/bin2uf2 (RV32 ELF) and run via qemu-riscv32.
        # tools/bin2uf2.py has been retired.
        if [ ! -x "$ROOT_DIR/build/gen2/bin2uf2" ]; then
            echo "kernel/build.sh: build/gen2/bin2uf2 missing — run 'make build/gen2/bin2uf2' first" >&2
            exit 1
        fi
        qemu-riscv32 "$ROOT_DIR/build/gen2/bin2uf2" "$TMP/kernel.bin" "$OUTFILE"
        ;;
esac

echo "Built: $OUTFILE" >&2

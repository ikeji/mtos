# gcc_doom — doomgeneric DOOM port (K22).
#
# EXTRA_GUEST_TASKS only — not in the default seed list and currently
# does not compile. Phase 1 sets up vendor tree + DG_* stubs +
# Makefile plumbing; phase 2 picks up the libc work.
#
# What's needed before this compiles:
#   * picolibc headers — install `picolibc-riscv64-unknown-elf`
#     from Debian for `<stdio.h>`, `<string.h>`, `<math.h>`, etc.
#     (the bundled gcc-riscv64-unknown-elf ships freestanding only).
#   * gcc_libc.c needs printf / malloc / free / memcpy / memset /
#     strlen / strcpy / strcmp / fopen / fread / fseek / ftell /
#     fclose plus the math functions (sin / cos / atan2). Plan in
#     docs/task/doom_port.md phase 2.
#   * GCC_CFLAGS needs to add `--specs=picolibc.specs` (or the
#     equivalent paths) once the package is installed.
EXTRA_GUEST_TASKS += gcc_doom
GCC_TASKS         += gcc_doom

# 256 KB arena leaves DOOM zone allocator room to breathe; we don't
# expect to actually fit a vanilla zone here, but giving it some
# slack lets us see how far it gets in phase 1 smoke testing.
TASK_ARENA_gcc_doom := 262144
TASK_STACK_gcc_doom := 16384

# Sources: our two top-level files plus every vendored .c except
# mus2mid.c (it has its own main(), it's a standalone host-side
# utility, not part of the runtime).
GCC_SOURCES_gcc_doom := \
    $(ROOT)/userland/gcc-bin/gcc_doom/gcc_doom.c \
    $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric_tcos.c \
    $(filter-out %/mus2mid.c, \
        $(wildcard $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/*.c))

# DOOM headers are looked up relative to doomgeneric/ in many places.
GCC_INCLUDES_gcc_doom := -I$(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric

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

# 8 MB arena so DOOM's Z_Init can grab its 5 MiB zone (vanilla
# Z_Init asks for 5 MiB up front and bails if malloc returns NULL).
# 64 KB stack covers the deep R_DrawColumn recursion. Both come out
# of the kernel's 96 MB kmalloc pool — generous on qemu virt, won't
# fit on pico2's 520 KB SRAM (Phase 5 deals with that diet).
TASK_ARENA_gcc_doom := 8388608
TASK_STACK_gcc_doom := 65536

# Sources: our two top-level files plus every vendored .c except
#   * mus2mid.c — standalone host-side utility with its own main()
#   * i_allegro{music,sound}.c, i_sdl{music,sound}.c — sound backends
#     that need libraries we don't ship; #undef FEATURE_SOUND in
#     doomfeatures.h drops the references to their DG_*_module
#     symbols so the link still works without them.
GCC_DOOM_EXCLUDE := mus2mid.c i_allegromusic.c i_allegrosound.c \
                    i_sdlmusic.c i_sdlsound.c
GCC_SOURCES_gcc_doom := \
    $(ROOT)/userland/gcc-bin/gcc_doom/gcc_doom.c \
    $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric_tcos.c \
    $(filter-out $(foreach f,$(GCC_DOOM_EXCLUDE), \
                     $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/$(f)), \
        $(wildcard $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/*.c))

# DOOM headers are looked up relative to doomgeneric/ in many places.
GCC_INCLUDES_gcc_doom := -I$(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric

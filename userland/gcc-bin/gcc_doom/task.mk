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
# Pico 2 variant — text + GOT in flash, .data + .bss live at the
# fixed link-time SRAM VMA carved out of the kernel arena
# (__gcc_sram in kernel/platform/pico2/crt0_pico2_data.s).
# In GUEST_TASKS rather than EXTRA so it ships in the small disk.img
# (and therefore pico2_kernel.uf2 fits in the 4 MB flash). The qemu
# virt disk also picks it up but that build never spawns it; the
# binary's link-time addresses don't match qemu virt's RAM map.
GUEST_TASKS       += gcc_doom_pico2
GCC_TASKS         += gcc_doom_pico2

# 8 MB arena so DOOM's Z_Init can grab its 5 MiB zone (vanilla
# Z_Init asks for 5 MiB up front and bails if malloc returns NULL).
# 64 KB stack covers the deep R_DrawColumn recursion. Both come out
# of the kernel's 96 MB kmalloc pool — generous on qemu virt, won't
# fit on pico2's 520 KB SRAM (Phase 5 deals with that diet).
TASK_ARENA_gcc_doom := 8388608
TASK_STACK_gcc_doom := 65536
# Pico 2 variant: 64 KB arena fits inside the shrunken pico2 kernel
# kmalloc pool (~191 KB after __gcc_sram reservation). DOOM's Z_Init
# wants 6 MiB, so this build is expected to print the DOOM banner
# and bail at "Unable to allocate 5 MiB of RAM for zone" — that's
# the Phase 3c smoke-test endpoint. Phase 5 lifts it.
# K22 Phase 5 stage 9: kernel-side task arena needs only enough to
# hold the task struct + a few small kernel-internal buffers. Our
# gcc_crt0_pico2 hands the arena to _libc_init_heap, but picolibc's
# actual malloc uses its own sbrk that walks the gcc_task_pico2.ld
# __heap_start / __heap_end region (= the __gcc_sram block), not
# this arena. With __arena trimmed to 128 KB and the kmalloc bucket
# tree topping out around 64 KB, an 80 KB combined arena+stack
# spawn won't fit — drop the arena to 8 KB to keep the spawn cost
# small. K22 Phase 6: stack also halved to 8 KB after arena went down
# to 64 KB (gcc_sram grew to 448 KB) — total spawn allocation must fit
# in ~20 KB of kmalloc headroom after sh, so we trade R_DrawColumn
# recursion margin for a chance at booting at all.
TASK_ARENA_gcc_doom_pico2 := 4096
TASK_STACK_gcc_doom_pico2 := 1024

# Sources: our two top-level files plus every vendored .c except
#   * mus2mid.c — standalone host-side utility with its own main()
#   * i_allegro{music,sound}.c, i_sdl{music,sound}.c — sound backends
#     that need libraries we don't ship; #undef FEATURE_SOUND in
#     doomfeatures.h drops the references to their DG_*_module
#     symbols so the link still works without them.
GCC_DOOM_EXCLUDE := mus2mid.c i_allegromusic.c i_allegrosound.c \
                    i_sdlmusic.c i_sdlsound.c
GCC_DOOM_SOURCES := \
    $(ROOT)/userland/gcc-bin/gcc_doom/gcc_doom.c \
    $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric_tcos.c \
    $(filter-out $(foreach f,$(GCC_DOOM_EXCLUDE), \
                     $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/$(f)), \
        $(wildcard $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/*.c))

# DOOM headers are looked up relative to doomgeneric/ in many places.
GCC_DOOM_INCLUDES := -I$(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric

GCC_SOURCES_gcc_doom  := $(GCC_DOOM_SOURCES)
GCC_INCLUDES_gcc_doom := $(GCC_DOOM_INCLUDES)

# Pico 2 variant: same sources, swap the linker script + crt0 to the
# flash/SRAM split layout. .bss stays NOLOAD (gcc_crt0_pico2.s zeros
# it from crt0 instead of carrying ~240 KB of zero bytes in the flash
# image), so the .data.zero rewrite is dropped.
# Phase 5 stage 1 also pulls the whd-runtime building blocks
# (tiny_huff, image_decoder) into the source list. They have no
# in-tree callers yet (USE_WHD wiring lands in stage 2+), so the
# linker's --gc-sections drops them out of the final binary — but
# the build still proves they compile clean under our gcc_libc.c +
# picolibc stack.
GCC_DOOM_WHD_SOURCES := \
    $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/whd/tiny_huff.c \
    $(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/whd/image_decoder.c
GCC_SOURCES_gcc_doom_pico2  := $(GCC_DOOM_SOURCES) $(GCC_DOOM_WHD_SOURCES)
# -DPICO2_TINY_ZONE switches i_system.c's zone unit from MiB to KiB.
# -DPICO2_TINY_BUFFERS halves r_plane.c's MAXVISPLANES (128→64) and
# OPENINGS_FACTOR (64→32) so the resulting .bss leaves ~50 KB more
# heap (visplanes 84→32 KB, openings 40→20 KB). Combined: the
# picolibc heap goes from ~28 KB to ~78 KB, which fits a 64 KB DOOM
# zone for early bootstrap (lumpinfo + a couple of PU_STATIC allocs).
# -DUSE_WHD=1 turns the WHD code paths on inside whddata.h. None of
# our existing .c calls into them yet — stage 1 just verifies that
# the runtime whd files compile + link under our toolchain.
GCC_INCLUDES_gcc_doom_pico2 := $(GCC_DOOM_INCLUDES) \
    -I$(ROOT)/userland/gcc-bin/gcc_doom/doomgeneric/whd \
    -DPICO2_TINY_ZONE -DPICO2_TINY_BUFFERS -DPICO2_TINY_BUFFERS_HARDER \
    -DPICO2_R_INIT_LITE -DPICO2_LUMPINFO_SHRUNK -DPICO2_TINY_BACKUPTICS \
    -DPICO2_TINY_HUD -DUSE_WHD=1 \
    -DDOOMGENERIC_RESX=320 -DDOOMGENERIC_RESY=200 \
    -DCMAP256=1
GCC_LD_gcc_doom_pico2       := $(ROOT)/compiler/runtime/mtos/gcc_task_pico2.ld
GCC_CRT0_gcc_doom_pico2     := $(ROOT)/compiler/runtime/mtos/gcc_crt0_pico2.s
GCC_OBJCOPY_FLAGS_gcc_doom_pico2 :=

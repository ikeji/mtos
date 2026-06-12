/*
 * gcc_task.ld — linker script for GCC-compiled guest tasks.
 *
 * Strategy (Phase 0.5 + 2 evolution): text/rodata stays
 * position-independent (-fPIE keeps auipc+addi pairs for .rodata
 * references — those targets live in flash next to the access, so
 * PC-relative resolution is correct at any load address). Data is
 * trickier:
 *
 *   * SMALL globals (within ±2 KB of gp) — relaxed by the linker
 *     from `auipc + lw/sw` to a single `lw/sw rd, off(gp)`. Works at
 *     any load address since gp is set by the kernel at runtime.
 *
 *   * LARGE / FAR globals (anything beyond ±2 KB of gp) — the relaxer
 *     can't fold these, so they stay as `auipc + lw/sw` PC-relative
 *     pairs that bake in the LINK-TIME (text → data) offset. For
 *     these to work at runtime we need the kernel loader to honour
 *     the link-time VMAs: the task arena RAM is placed at exactly
 *     the address the linker assumed for `.data` (0x10000000 here),
 *     so the PC-rel math resolves to the right RAM slot.
 *
 * Two non-obvious knobs:
 *
 *   * FLASH ORIGIN at 0x20000000 keeps every .text / .rodata symbol's
 *     VMA outside the 12-bit signed window, so the relaxer can't
 *     collapse PC-rel pairs into a single absolute `li` (which would
 *     bake the link-time VMA into the binary instead of letting the
 *     PC-rel math resolve to a runtime-correct value).
 *
 *   * `__global_pointer$` is defined with `=` not `PROVIDE`. PROVIDE
 *     only fires when something references the symbol but leaves it
 *     undefined; with no explicit reference (the relax pass is the
 *     only would-be consumer), PROVIDE silently no-ops and the linker
 *     falls back to PC-relative codegen for everything.
 *
 *   * Heap state lives at the start of the kernel-provided arena, not
 *     in .bss. `gcc_crt0.s` sets `tp = a0` (arena addr) and libc
 *     reads `base/brk/end` through tp directly. Keeping the heap
 *     pointers out of .bss means we don't have to keep them within
 *     gp's ±2 KB window — a constraint we'd lose anyway once .data
 *     grows past 4 KB (which it does the moment picolibc shows up).
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

MEMORY {
    FLASH (rx) : ORIGIN = 0x20000000, LENGTH = 8M
    /* RAM is large enough to hold picolibc + DOOM-sized .data/.bss.
       The kernel maps the task's arena to ORIGIN at load time so
       far-data PC-rel relocations resolve correctly. */
    RAM   (rwx): ORIGIN = 0x10000000, LENGTH = 1M
}

SECTIONS {
    .text : {
        /* K3 header (hdr.s, .section .text.k3) must occupy the first
           8 bytes of the binary so the kernel's loader can read
           arena/stack sizes off it. _start follows immediately. */
        KEEP(*(.text.k3))
        KEEP(*(.text.start))
        *(.text .text.*)
    } > FLASH

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    } > FLASH

    /* .data + .sdata: VMA in RAM, LMA in FLASH (bytes live in the
       binary right after .rodata so _start can memcpy them across).
       .sdata goes FIRST so small globals stay closest to gp and
       benefit from the gp-relative relaxation pass. */
    .data : ALIGN(4) {
        __data_start = .;
        *(.sdata .sdata.* .sdata2 .sdata2.*)
        *(.data .data.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT > FLASH

    __data_lma = LOADADDR(.data);

    /* Explicit = (not PROVIDE) so the linker definitely picks this
       value during gp-relative relaxation. Placed 0x800 into .data
       so the small-data window (±2 KB) covers .sdata + the first
       0x800 bytes of .data. */
    __global_pointer$ = __data_start + 0x800;

    .bss (NOLOAD) : ALIGN(4) {
        __bss_start = .;
        *(.sbss .sbss.*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /* picolibc's _sbrk uses __heap_start / __heap_end if our libc
       shim doesn't provide _sbrk first. Leave them defined so the
       link doesn't fail; we override _sbrk anyway. */
    PROVIDE(__heap_start = __bss_end);
    PROVIDE(__heap_end   = ORIGIN(RAM) + LENGTH(RAM));

    __data_size = __data_end - __data_start;
    __bss_size  = __bss_end  - __bss_start;

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

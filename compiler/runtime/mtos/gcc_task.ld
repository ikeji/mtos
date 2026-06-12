/*
 * gcc_task.ld — linker script for GCC-compiled guest tasks.
 *
 * Single-segment layout: text + rodata + data + bss are laid out as
 * one contiguous block of RAM. The kernel loads the whole binary into
 * an arbitrary RAM address, and -fPIE PC-relative addressing handles
 * the runtime relocation automatically: every auipc+lw/sw or
 * auipc+addi pair encodes a LINK-TIME relative offset, and because
 * text and data move together (we link them in one block), the same
 * relative offset is correct at runtime no matter where the kernel
 * placed us.
 *
 *   Run-time math:
 *     PC_runtime  + (link_target - link_PC)  == target_runtime
 *                      ^^^^^^^^^^^^^^^^^^^^^^
 *                      encoded in auipc/lo12 — fixed at link time
 *
 * Why this works for tasks of any size:
 *   - All globals are PC-relative regardless of distance from gp; we
 *     don't depend on the binutils gp-relax pass folding far refs
 *     (which it can't beyond ±2 KB of gp).
 *   - .bss is emitted as zero bytes inside the binary (LOAD, not
 *     NOLOAD), so the kernel only needs to know "load this many
 *     bytes" — no extra header field for bss_size, no crt0 bss-zero
 *     loop, no separate per-task RAM block for data/bss.
 *
 * Cost: the binary on disk is `text + rodata + data + bss` bytes,
 * including the zero bytes for .bss. For DOOM that's ~620 KB on disk
 * instead of ~376 KB. Acceptable on virtio (slow path) and on the
 * pico2 4 MB flash (DOOM is one game, not the whole disk).
 *
 * Heap state: stays at `tp = arena addr` (gcc_crt0.s sets it).
 * The kernel-allocated arena (via make_task) is independent of this
 * binary block; it's where _sbrk hands out pages, addressed entirely
 * through tp + small immediate offsets.
 *
 * Why VMA at 0x10000000 (not 0): no real reason for `> 0` anymore
 * since the relaxer's "zero-rel fold" concern went away with the
 * single-segment layout. Kept at a high address so casual `lui`
 * folds don't accidentally match the 12-bit absolute window.
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

MEMORY {
    /* picolibc objects use absolute lui+addi for their internal
       globals, so the binary only runs at the link-time VMA. On
       qemu virt we reserved 0x87000000 (the slot kernel/src/loader.tc
       uses for any image > 256 KB — above the 96 MB kmalloc arena,
       below the boot stack top at 0x88000000); the kernel copies the
       binary there before scheduling the task. The pico2 port will
       pick a different VMA inside SRAM.

       LENGTH covers binary + heap. picolibc's malloc reads
       __heap_start / __heap_end from the linker script (NOT our
       arena-based _sbrk shim), so the heap window has to fit DOOM's
       6 MiB zone + working set. Stopping at 14 MB leaves a 2 MB
       guard below the boot stack top (qemu virt sp starts at
       0x88000000 and descends only a few KB during early kernel
       setup, but the slack is cheap insurance). */
    RAM (rwx) : ORIGIN = 0x87000000, LENGTH = 14M
}

SECTIONS {
    .text : {
        /* K3 header (hdr.s, .section .text.k3) must occupy the first
           8 bytes of the binary so the kernel's loader can read
           arena/stack sizes off it. _start follows immediately. */
        KEEP(*(.text.k3))
        KEEP(*(.text.start))
        *(.text .text.*)
    } > RAM

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    } > RAM

    .data : ALIGN(4) {
        __data_start = .;
        *(.sdata .sdata.* .sdata2 .sdata2.*)
        *(.data .data.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM

    /* Explicit = (not PROVIDE) so the linker definitely picks this
       value during gp-relative relaxation. Placed 0x800 into .data
       so the small-data window (±2 KB) covers .sdata + the first
       0x800 bytes of .data. (Still useful for small statics even
       though we no longer rely on it for far globals.) */
    __global_pointer$ = __data_start + 0x800;

    /* Rename what would normally be .bss to .data.zero so ld marks it
       as SHT_PROGBITS instead of SHT_NOBITS — otherwise `objcopy -O
       binary` would skip it and the raw binary would be missing the
       zeroed bss region. With this trick the binary on disk grows by
       the .bss size (zero bytes), but the kernel can then load
       text+rodata+data+bss as one contiguous blob without needing
       to know the bss size separately. */
    .data.zero : ALIGN(4) {
        __bss_start = .;
        *(.sbss .sbss.*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /* picolibc's _sbrk fallback references these; we override _sbrk
       in gcc_libc.c so they're never actually read, but the link
       fails without something definitions. */
    PROVIDE(__heap_start = __bss_end);
    PROVIDE(__heap_end   = ORIGIN(RAM) + LENGTH(RAM));

    __data_size = __data_end - __data_start;
    __bss_size  = __bss_end  - __bss_start;

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

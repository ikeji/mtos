/*
 * gcc_task.ld — linker script for GCC-compiled guest tasks.
 *
 * Output is a raw .bin where:
 *
 *   [0..7]   K3 header (arena_size, stack_size) — supplied by hdr.s
 *            prepended as the very first input file
 *   [8..]    .text   (crt0._start + libc shim + task code)
 *            .rodata (string literals + const tables)
 *            .data   (LMA copy — _start memcpys this into RAM at boot)
 *
 * .bss / .sbss are not in the binary; _start zeros them in RAM.
 *
 * Runtime layout (per kernel's make_task):
 *
 *   ram_base + 0x000 .. ram_base + 0x1000  gp-relative data area
 *                                          (.data + .sdata + .bss + .sbss
 *                                           combined; must fit in 4 KB)
 *   ram_base + 0x1000 .. ram_base + ram_size
 *                                          task heap (sbrk pool)
 *   ram_base + ram_size .. + stack_size    task stack
 *
 * The kernel sets gp = ram_base + 0x800 before jumping to _start, so any
 * symbol in [.data, .sbss] is reachable via 12-bit signed gp-relative
 * offsets (-msmall-data-limit lets gcc pick that addressing form).
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

MEMORY {
    /* Binary image (text + rodata + LMA of data). VMA-side address
       is irrelevant here because all accesses go via PC-relative
       (-fPIE) — what matters is the layout / LMA. */
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 4M

    /* RAM region. Sets the link-time VMA so that __data_start = 0
       and __global_pointer$ = 0x800; runtime gp = ram_base + 0x800
       gives 12-bit gp-relative reach across the full .data+.bss
       region (capped at 4 KB by the kernel's per-task layout). */
    RAM   (rwx): ORIGIN = 0x00000000, LENGTH = 4K
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

    /* .data + .sdata merged into a single output section so the LMA
       chunk gcc_crt0 has to copy is contiguous. VMA in RAM (so they
       resolve gp-relatively), LMA in FLASH (so the bytes live in the
       binary file). */
    .data : ALIGN(4) {
        __data_start = .;
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT > FLASH

    /* LMA address of .data — _start uses la (PC-relative) to find
       this in the loaded binary. */
    PROVIDE(__data_lma = LOADADDR(.data));

    PROVIDE(__global_pointer$ = __data_start + 0x800);

    .bss (NOLOAD) : ALIGN(4) {
        __bss_start = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /* Linker-computed sizes. Used by _start as `li tN, __data_size`
       so the copy / zero loops know when to stop without needing a
       second gp-relative offset that might fall outside the 12-bit
       addi window for tasks whose data sits across the 0x800
       boundary. */
    PROVIDE(__data_size = __data_end - __data_start);
    PROVIDE(__bss_size  = __bss_end  - __bss_start);

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

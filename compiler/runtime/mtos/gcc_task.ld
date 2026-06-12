/*
 * gcc_task.ld — linker script for GCC-compiled guest tasks.
 *
 * Layout in the output .bin (raw, no ELF header):
 *
 *   [0..7]   K3 header: arena_size (u32), stack_size (u32)
 *            — provided by hdr.s prepended at the start of the input list
 *   [8..]    .text (gcc_crt0._start + main + code)
 *   ...      .rodata
 *   ...      .data — copied into RAM by gcc_crt0._start
 *
 * .bss is allocated at runtime in RAM (kernel pre-cleared via the U8Array
 * allocator) and zeroed again by _start for safety. It does NOT live in
 * the binary.
 *
 * __global_pointer$ sits at .data + 0x800 so RV32 -mcmodel=medlow can
 * reach the data area with ±2KB gp-relative offsets. The kernel sets
 * gp = ram_base + 0x800 before jumping to _start.
 *
 * VMA vs LMA: text + rodata + data have LMA = binary offset (they live
 * in flash / mtfs); .data has VMA = ram_base + offset (where _start
 * copies it). bss has VMA following data in RAM, no LMA.
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

MEMORY {
    /* Binary image — text, rodata, and the LMA copy of data.
       Sized loosely; actual size determined by sections. */
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 4M
    /* RAM region where _start copies .data and .bss is zeroed.
       VMA addresses; the actual base is set by the kernel at runtime,
       and crt0 uses gp-relative addressing so absolute VMAs don't
       matter — what matters is the RELATIVE layout. */
    RAM   (rwx): ORIGIN = 0x00000000, LENGTH = 4M
}

SECTIONS {
    /* .text — code (crt0, main, libc shim).
       Starts at offset 0 in the binary; hdr.s K3 header is the very
       first input file and contributes its 8 bytes here. */
    .text : {
        KEEP(*(.text.start))
        *(.text .text.*)
    } > FLASH

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    } > FLASH

    /* .data — initialised globals. VMA = RAM (gp-relative), LMA = FLASH.
       __global_pointer$ at +0x800 so codegen can reach all of .data +
       half of .bss with gp ± 2KB. */
    .data : ALIGN(4) {
        __data_start = .;
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT > FLASH

    PROVIDE(__global_pointer$ = __data_start + 0x800);

    /* .bss — uninitialised globals. RAM only. */
    .bss : ALIGN(4) {
        __bss_start = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

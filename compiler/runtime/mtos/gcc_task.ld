/*
 * gcc_task.ld — linker script for GCC-compiled guest tasks.
 *
 * Phase 0.5 strategy: text/rodata stays position-independent (-fPIE
 * + linker relax keeps auipc+addi pairs for .rodata references), and
 * .data / .bss are accessed strictly through `__global_pointer$` so
 * the kernel-allocated per-task RAM is reachable regardless of where
 * the binary is actually loaded. The kernel sets gp = ram_base + 0x800
 * before jumping to _start; with __global_pointer$ link-time placed
 * at `__data_start + 0x800`, every small global resolves to
 * `lw/sw rd, (sym - __global_pointer$)(gp)` after gp-relative
 * relaxation, which yields `ram_base + (sym - __data_start)` at
 * runtime — i.e. the right RAM slot regardless of load address.
 *
 * Two non-obvious knobs:
 *
 *   * RAM ORIGIN sits at 0x10000000, not 0. The linker only does
 *     gp-relative relaxation when the existing zero-relative form
 *     can't reach the target; if RAM were at 0 the linker would
 *     prefer `sw rd, off(zero)` for small globals and ignore gp.
 *     Lifting the VMA past the 12-bit signed window forces gp-rel.
 *
 *   * __global_pointer$ is defined with `=` not `PROVIDE`. PROVIDE
 *     only fires when something references the symbol but leaves it
 *     undefined; with no explicit reference (and the relax pass is
 *     the only would-be consumer), the symbol stays unresolved and
 *     the linker silently falls back to PC-relative codegen.
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

MEMORY {
    /* FLASH ORIGIN is high enough that no .text/.rodata symbol's VMA
       can fit in the 12-bit signed window. Otherwise the linker's
       relaxer collapses `auipc rd, 0 + addi rd, rd, imm` into a
       single `li rd, imm` for small targets — which bakes the
       link-time VMA into the binary and breaks our PIC story
       (the task is loaded at a kernel-determined address, not 0). */
    FLASH (rx) : ORIGIN = 0x20000000, LENGTH = 4M
    /* RAM ORIGIN is similarly above the zero-relative window so the
       linker can't fold small-global stores into `sw rd, off(zero)`,
       forcing it to use gp-relative addressing instead. */
    RAM   (rwx): ORIGIN = 0x10000000, LENGTH = 4K
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

    /* .data + .sdata: VMA in RAM (gp-relative reachable), LMA in
       FLASH (bytes live in the binary right after .rodata so _start
       can memcpy them across). */
    .data : ALIGN(4) {
        __data_start = .;
        *(.data .data.*)
        *(.sdata .sdata.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT > FLASH

    __data_lma = LOADADDR(.data);

    /* Explicit = (not PROVIDE) so the linker definitely picks this
       value during gp-relative relaxation. */
    __global_pointer$ = __data_start + 0x800;

    .bss (NOLOAD) : ALIGN(4) {
        __bss_start = .;
        /* 4 bytes of padding keeps subsequent bss symbols off the
           -0x800 boundary in case anything else ever needs gp-rel
           relaxation; the heap-state block itself doesn't use the
           relaxer (crt0 puts its address into `tp` and libc reads
           through tp directly). */
        . += 4;
        __heap_state = .;
        . += 12;                /* base, brk, end — populated by libc */
        *(.bss .bss.*)
        *(.sbss .sbss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    /* crt0 sets `tp = gp - 0x7FC` to point at __heap_state. This
       assertion catches a future layout shuffle that would silently
       desync the hardcoded literal in gcc_crt0.s from the actual
       gp-relative offset. */
    ASSERT(__heap_state - __global_pointer$ == -0x7FC,
        "gcc_crt0.s expects __heap_state at gp - 0x7FC")

    __data_size = __data_end - __data_start;
    __bss_size  = __bss_end  - __bss_start;

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

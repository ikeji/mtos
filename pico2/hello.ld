/* hello.ld — RP2350 Flash XIP linker script */
OUTPUT_ARCH(riscv)
ENTRY(_start)

MEMORY {
    FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 4M
    RAM   (rwx): ORIGIN = 0x20000000, LENGTH = 512K
}

SECTIONS {
    .text : {
        __logical_binary_start = .;
        KEEP(*(.embedded_block))
        __embedded_block_end = .;
        . = ALIGN(4);
        *(.text*)
        . = ALIGN(4);
        *(.rodata*)
    } > FLASH

    .data : {
        . = ALIGN(4);
        *(.data*)
    } > FLASH

    .bss : {
        . = ALIGN(4);
        _sbss = .;
        *(.bss*)
        _ebss = .;
    } > RAM

    /DISCARD/ : { *(.eh_frame) *(.comment) }

    ASSERT(__embedded_block_end - __logical_binary_start <= 4096,
           "IMAGE_DEF must be in first 4KB")
}

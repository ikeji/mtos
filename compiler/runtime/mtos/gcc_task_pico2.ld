/*
 * gcc_task_pico2.ld — linker script for GCC-compiled guest tasks
 * running on Pico 2 (RP2350) with flash XIP for text/rodata.
 *
 * The Pico 2 has 4 MB of XIP-mapped flash at 0x10000000 and only
 * 520 KB of SRAM at 0x20000000. DOOM's text + rodata weigh ~330 KB
 * and would never fit in SRAM alongside its data + bss (~302 KB);
 * splitting the binary across flash and SRAM is the only way it
 * fits at all.
 *
 *   Flash @ FLASH ORIGIN .. +512 KB
 *     .text       (PROGBITS, RX)
 *     .rodata     (PROGBITS, R)
 *     .got        (PROGBITS, R) — stays in flash next to text so the
 *                  PCREL auipc+lw GOT_entry pair lands in the same flash
 *                  region. PCREL only resolves correctly when both ends
 *                  of the pair sit at the same delta from their link-time
 *                  addresses; flash↔flash trivially satisfies that.
 *
 *   SRAM @ 0x20030000 .. 0x2007D000 (~308 KB reserved for one gcc task)
 *     .data       (LMA in flash → VMA in SRAM, copied by crt0)
 *     .bss        (NOLOAD, zeroed by crt0)
 *
 * Text↔data addressing — the painful constraint:
 *   picolibc (PIC build) compiles its `static` vars (e.g. picosbrk's
 *   __malloc_sbrk_brk) with PCREL auipc+addi, NOT through the GOT.
 *   PCREL data access from text only lands on the correct SRAM slot
 *   when (text_runtime - text_link) == (data_runtime - data_link).
 *   data lives at fixed SRAM VMA 0x20030000 at runtime, so data delta
 *   is 0. That forces text delta to also be 0 — i.e. FLASH ORIGIN
 *   must equal the actual chip flash address where this binary's K3
 *   header lands inside kernel.bin. K22 (2026-06-10) hit memset(0x10,
 *   ...) trap because gcc_doom_pico2 landed at chip 0x100f57e0 but
 *   was linked at 0x10100000 — picosbrk's brk var read landed 0xa820
 *   bytes before its real SRAM slot, returned 0, and malloc handed
 *   back ~0x10 (= sbrk_aligned overhead).
 *
 * Why VMA = 0x20030000 for SRAM:
 *   - Kernel .data + .bss live below 0x20030000 (see crt0_pico2_data.s).
 *   - Leaves ~308 KB for the gcc task's data/bss/heap; DOOM's
 *     data + bss alone is ~302 KB so the budget is tight.
 *   - The kernel's stack at 0x20080000-0x20082000 stays untouched.
 *
 * Phase 5 (WAD diet) still needs to land before DOOM actually runs
 * — even with text in flash, the vanilla 6 MiB zone allocator
 * doesn't fit in the SRAM budget. This script just makes the binary
 * shape correct.
 */

OUTPUT_ARCH(riscv)
OUTPUT_FORMAT("elf32-littleriscv")
ENTRY(_start)

/* FLASH ORIGIN must equal gcc_doom_pico2's actual flash position
   inside the kernel.bin — see the long comment above for why.
   To find the current value after a kernel rebuild:
     python3 -c "import struct; d=open('kernel/build/pico2_kernel.uf2','rb').read(); \
       out=b''.join(d[i+32:i+32+struct.unpack_from('<I',d,i+16)[0]] \
       for i in range(0,len(d),512) if d[i:i+4]==b'UF2\\n'); \
       j=out.find(b'MTFS'); i_st=struct.unpack_from('<I',out,j+20)[0]; \
       d_st=struct.unpack_from('<I',out,j+24)[0]; \
       [print('FLASH ORIGIN =','0x%08x'%(0x10000000+j+(d_st+struct.unpack_from('<I',out,j+i_st*512+k*64+40)[0])*512)) \
        for k in range(56) if out[j+i_st*512+k*64:j+i_st*512+k*64+32].split(b'\\0')[0]==b'gcc_doom_pico2']"
   Then update the ORIGIN below and rebuild + reflash. Yes, this is
   a chicken-and-egg loop; the proper fix is a 2-pass build that
   re-links gcc_doom_pico2 after mkfs decides its position. */
MEMORY {
    /* K22 path-A flash-WAD: 8 MB FLASH region to fit the embedded
       DOOM1.WAD (~4.2 MB) plus the existing text/rodata/got. The
       LENGTH only bounds the linker — it doesn't reserve flash;
       the actual occupied bytes are whatever the binary needs. */
    FLASH (rx)  : ORIGIN = 0x100f6720, LENGTH = 8M
    /* K22 path-A B1: __arena 32 KB (smallest that doesn't kernel-
       OOM at boot) and gcc_sram 480 KB. heap ~18 KB after the
       segs[768] / colcache 22 KB / lumpinfo / etc .bss tax. */
    RAM   (rwx) : ORIGIN = 0x20008000, LENGTH = 480K
}

SECTIONS {
    .text : {
        /* K3 header (hdr.s, .section .text.k3) must occupy the
           first 8 bytes of the binary so the kernel's XIP loader
           can read arena/stack sizes off the flash image directly. */
        KEEP(*(.text.k3))
        KEEP(*(.text.start))
        *(.text .text.*)
    } > FLASH

    .rodata : ALIGN(4) {
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    } > FLASH

    /* .got stays in flash alongside text/rodata. The entries are
       pre-filled at link time with absolute SRAM VMAs of .data /
       .bss symbols, and flash is read-only at runtime so we never
       need to write to them. Keeping .got in flash means every
       `auipc + lw GOT_entry` pair is a relative jump within the
       same flash region — that's the property that lets the
       kernel place the binary at any flash address (e.g. inside
       mtfs at whatever offset mkfs picks), not just the linker's
       0x10100000 default. */
    .got : ALIGN(4) {
        *(.got .got.*)
        *(.got.plt .got.plt.*)
    } > FLASH

    /* .data: VMA in SRAM, LMA in flash. gcc_crt0_pico2.s copies the
       bytes across at startup before main runs. The kernel still
       has to put SRAM at the link-time VMA — the GOT entries hold
       absolute pointers into it, so the SRAM destination is the
       one piece of address that has to match. */
    .data : ALIGN(4) {
        __data_start = .;
        *(.sdata .sdata.* .sdata2 .sdata2.*)
        *(.data .data.*)
        . = ALIGN(4);
        __data_end = .;
    } > RAM AT > FLASH

    __data_lma = LOADADDR(.data);
    __data_size = __data_end - __data_start;

    __global_pointer$ = __data_start + 0x800;

    .bss (NOLOAD) : ALIGN(4) {
        __bss_start = .;
        *(.sbss .sbss.*)
        *(.bss .bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end = .;
    } > RAM

    __bss_size  = __bss_end  - __bss_start;

    /* K22 Phase 6: own stack at top of RAM, not the tiny kernel-supplied
       one. TASK_STACK_gcc_doom_pico2 needs to be at TASK_STACK_MIN
       (1 KB) to satisfy the spawn check; gcc_crt0_pico2.s switches sp
       to __stack_top immediately on entry so we get 16 KB instead.
       This lets DOOM's R_RenderPlayerView / R_DrawColumn call chain
       run without overflowing into adjacent heap. */
    /* K22 path-A: stack cut from 16 → 8 KB to give heap +8 KB. DOOM's
       deepest recursion (R_RenderBSPNode → R_Subsector → R_AddLine
       → R_DrawColumn) measured at ~3 KB; 8 KB leaves margin. */
    __stack_size = 8K;
    __stack_top  = ORIGIN(RAM) + LENGTH(RAM);
    __stack_base = __stack_top - __stack_size;

    /* picolibc's _sbrk fallback path references these. We override
       _sbrk in gcc_libc.c, but the link needs them defined. The heap
       has to end below __stack_base so malloc never grows into the
       stack region. */
    PROVIDE(__heap_start = __bss_end);
    PROVIDE(__heap_end   = __stack_base);

    /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame) }
}

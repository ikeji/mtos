# pico2/crt0_pico2.s — Pico 2 (RP2350 RISC-V) startup for TC programs
#
# Runs in compile-pico2.sh; concatenated BEFORE runtime.s and user .s so
# that the IMAGE_DEF picobin block lands at file offset 0 (= Flash
# 0x10000000). _start follows immediately at offset 0x20.
#
# Uses bootstrap/crt0_tc_data.s style runtime interface (__runtime_init,
# do_write, etc.) but:
#   - UART output targets PL011 @ 0x40070000 (not ecall)
#   - gp is set to 0x20000800 (SRAM data base + 0x800) directly
#   - .bss region in SRAM is zero-initialised before any runtime call
#   - NPOOLS (runtime global) is patched to 17 at startup so the .data
#     section can be all zero (no Flash → SRAM data copy is needed)
#
# Pool metadata and __arena live in crt0_pico2_data.s (.rodata for the
# const pool_sizes/counts, .bss for the rest).

    .text
    .globl __embedded_block
__embedded_block:
    # picobin IMAGE_DEF block, packed into 8 little-endian .words so that
    # asm.tc (which has no .byte/.hword support) can emit it.
    #
    # Word 0  PICOBIN_BLOCK_MARKER_START
    .word 0xFFFFDED3
    # Word 1  IMAGE_TYPE item header, packed as:
    #   byte 0 = 0x42 (type = IMAGE_TYPE)
    #   byte 1 = 0x01 (size = 1 word)
    #   bytes 2-3 = 0x1101 (flags = EXE | RISCV | RP2350)
    .word 0x11010142
    # Word 2  ENTRY_POINT item header, packed as:
    #   byte 0 = 0x44 (type = ENTRY_POINT)
    #   byte 1 = 0x03 (size = 3 words)
    #   bytes 2-3 = 0x0000 (pad)
    .word 0x00000344
    # Word 3  entry point (absolute flash address of _start)
    .word 0x10000020
    # Word 4  initial SP (SRAM top)
    .word 0x20082000
    # Word 5  LAST item, packed as:
    #   byte 0 = 0xFF (type = LAST)
    #   bytes 1-2 = 0x0004 (item data size = IMAGE_TYPE(1) + ENTRY_POINT(3))
    #   byte 3 = 0x00 (pad)
    .word 0x000004FF
    # Word 6  loop link to next block (0 = self / single block)
    .word 0x00000000
    # Word 7  PICOBIN_BLOCK_MARKER_END
    .word 0xAB123579

    .globl _start
_start:
    # ===== core 1 park (only core 0 runs main) =====
    li   t0, 0xD0000000           # SIO_BASE
    lw   t0, 0(t0)                # CPUID
    bnez t0, _park

    # ===== SP (SRAM top) =====
    li   sp, 0x20082000

    # ===== XOSC =====
    li   t0, 0x40048000           # XOSC_BASE
    li   t1, 0xAA0                # CTRL: FREQ_RANGE = 1_15MHZ
    sw   t1, 0x00(t0)
    li   t1, 0xC4                 # STARTUP delay
    sw   t1, 0x0C(t0)
    li   t2, 0x4004A000           # XOSC_BASE + SET
    li   t1, 0x00FAB000           # ENABLE
    sw   t1, 0x00(t2)             # CTRL_SET
1:  lw   t1, 0x04(t0)             # XOSC_STATUS
    bge  t1, zero, 1b             # wait until bit31 (STABLE) is set

    # ===== clk_peri → XOSC =====
    li   t0, 0x40010048           # CLK_PERI_CTRL
    sw   zero, 0(t0)
    li   t1, 0x820                # ENABLE (1<<11) | AUXSRC=xosc (4<<5)
    sw   t1, 0(t0)

    # ===== RESETS clear (IO_BANK0=6, PADS_BANK0=9, UART0=26) =====
    li   t0, 0x40023000           # RESETS + CLR
    li   t1, 0x4000240            # (1<<6) | (1<<9) | (1<<26)
    sw   t1, 0(t0)
    li   t0, 0x40020008           # RESETS_RESET_DONE
2:  lw   t2, 0(t0)
    and  t2, t2, t1
    bne  t2, t1, 2b

    # ===== GPIO0/1 funcsel = UART =====
    li   t0, 0x40028004           # IO_BANK0 + GPIO0_CTRL
    li   t1, 2
    sw   t1, 0(t0)
    li   t0, 0x4002800C           # IO_BANK0 + GPIO1_CTRL
    sw   t1, 0(t0)

    # ===== PAD ISO clear (GPIO0/1) + GPIO1 input enable =====
    li   t1, 0x100                # ISO bit
    li   t0, 0x4003B004           # PADS_BANK0 + CLR + GPIO0
    sw   t1, 0(t0)
    li   t0, 0x4003B008           # PADS_BANK0 + CLR + GPIO1
    sw   t1, 0(t0)
    li   t0, 0x4003A008           # PADS_BANK0 + SET + GPIO1
    li   t1, 0x40                 # IE bit
    sw   t1, 0(t0)

    # ===== UART0 init (12 MHz / 115200 bps) =====
    li   t0, 0x40070000           # UART0_BASE
    li   t1, 6
    sw   t1, 0x24(t0)             # IBRD
    li   t1, 33
    sw   t1, 0x28(t0)             # FBRD
    li   t1, 0x70                 # WLEN=11 (8 bits) | FEN
    sw   t1, 0x2C(t0)             # LCR_H
    li   t1, 0x301                # UARTEN | TXE | RXE
    sw   t1, 0x30(t0)             # CR

    # ===== Zero SRAM data+bss region (0x20000000..0x20080000) =====
    # Leaves the top 8 KB of SRAM for stack growth below sp=0x20082000.
    li   t0, 0x20000000
    li   t1, 0x20080000
3:  sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 3b

    # ===== gp = SRAM data base + 0x800 =====
    li   gp, 0x20000800

    # ===== patch runtime global NPOOLS to 17 =====
    # runtime.tc defines `var NPOOLS: i32 = 17`. We zeroed SRAM above,
    # so the SRAM-resident copy is currently 0. Set it manually.
    la   t0, NPOOLS
    li   t1, 17
    sw   t1, 0(t0)

    # ===== __runtime_init(arena, sizes, counts, free, base, end, ready) =====
    la   a0, __arena
    la   a1, __pool_sizes
    la   a2, __pool_counts
    la   a3, __pool_free
    la   a4, __pool_base
    la   a5, __pool_end
    la   a6, __pools_ready
    call __runtime_init__u32__u32__u32__u32__u32__u32__u32

    call main

_park:
    j    _park

    # ===== syscall stubs =====
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    # a0 = fd (ignored), a1 = buf, a2 = len
    li   t0, 0x40070000           # UART0
    mv   t2, a2
4:  beqz t2, 5f
    # wait until TXFF (UARTFR bit 5) is 0
6:  lw   t1, 0x18(t0)             # UARTFR
    andi t1, t1, 0x20
    bnez t1, 6b
    lbu  t1, 0(a1)
    sw   t1, 0x00(t0)             # UARTDR
    addi a1, a1, 1
    addi t2, t2, -1
    j    4b
5:  mv   a0, a2                   # return count
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a0, 0
    ret

    .globl do_exit__i32
do_exit__i32:
    j    _park

    .globl peek8__u32
peek8__u32:
    lbu  a0, 0(a0)
    ret
    .globl peek16__u32
peek16__u32:
    lhu  a0, 0(a0)
    ret
    .globl peek32__u32
peek32__u32:
    lw   a0, 0(a0)
    ret
    .globl poke8__u32__u8
poke8__u32__u8:
    sb   a1, 0(a0)
    ret
    .globl poke16__u32__u16
poke16__u32__u16:
    sh   a1, 0(a0)
    ret
    .globl poke32__u32__u32
poke32__u32__u32:
    sw   a1, 0(a0)
    ret

# kernel/platform_pico2.s — RP2350 (Pico 2) RISC-V platform code
#
# UART: PL011 UART0 @ 0x40070000, 115200 bps via XOSC.
# Used together with kernel/trap_common.s and kernel/crt0_pico2_data.s.

    .text
    .globl __embedded_block
__embedded_block:
    .word 0xFFFFDED3
    .word 0x11010142
    .word 0x00000344
    .word 0x10000020
    .word 0x20082000
    .word 0x000004FF
    .word 0x00000000
    .word 0xAB123579

    .globl _start
_start:
    # Core 1 park
    li   t0, 0xD0000000
    lw   t0, 0(t0)
    bnez t0, _park

    li   sp, 0x20082000

    # XOSC init
    li   t0, 0x40048000
    li   t1, 0xAA0
    sw   t1, 0x00(t0)
    li   t1, 0xC4
    sw   t1, 0x0C(t0)
    li   t2, 0x4004A000
    li   t1, 0x00FAB000
    sw   t1, 0x00(t2)
1:  lw   t1, 0x04(t0)
    bge  t1, zero, 1b

    # clk_peri → XOSC
    li   t0, 0x40010048
    sw   zero, 0(t0)
    li   t1, 0x880
    sw   t1, 0(t0)

    # RESETS clear (IO_BANK0, PADS_BANK0, UART0)
    li   t0, 0x40023000
    li   t1, 0x4000240
    sw   t1, 0(t0)
    li   t0, 0x40020008
2:  lw   t2, 0(t0)
    and  t2, t2, t1
    bne  t2, t1, 2b

    # GPIO0/1 → UART
    li   t0, 0x40028004
    li   t1, 2
    sw   t1, 0(t0)
    li   t0, 0x4002800C
    sw   t1, 0(t0)

    # PAD ISO clear + GPIO1 IE
    li   t1, 0x100
    li   t0, 0x4003B004
    sw   t1, 0(t0)
    li   t0, 0x4003B008
    sw   t1, 0(t0)
    li   t0, 0x4003A008
    li   t1, 0x40
    sw   t1, 0(t0)

    # UART0 init (12MHz / 115200)
    li   t0, 0x40070000
    li   t1, 6
    sw   t1, 0x24(t0)
    li   t1, 33
    sw   t1, 0x28(t0)
    li   t1, 0x70
    sw   t1, 0x2C(t0)
    li   t1, 0x301
    sw   t1, 0x30(t0)

    # Zero SRAM
    li   t0, 0x20000000
    li   t1, 0x20080000
3:  sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 3b

    # gp = SRAM data base + 0x800
    li   gp, 0x20000800

    # Copy .data from Flash to SRAM
    la   t0, __global_pointer$    # PC-relative: Flash gp address
    addi t0, t0, -0x800           # source data_base in Flash
    addi t1, gp, -0x800           # dest data_base in SRAM
    la   t2, __data_end           # gp-relative: dest data_end
    beq  t1, t2, 5f
4:  lw   t3, 0(t0)
    sw   t3, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    bltu t1, t2, 4b
5:

    # runtime init — arena size must match crt0_pico2_data.s's __arena .space
    la   a0, __arena
    li   a1, 491520
    call __runtime_init__u32__i32

    # trap vector
    la   t0, _trap_frame
    csrw 0x340, t0
    la   t0, _trap_entry
    csrw 0x305, t0

    call main
_park:
    j    _park

# ===== Set kernel gp =====
# On Pico 2, gp must be the SRAM address (0x20000800), NOT the PC-relative
# Flash address. Use li with absolute literal.
    .globl _set_kern_gp
_set_kern_gp:
    li   gp, 0x20000800
    ret

# ===== UART write (PL011 TX) =====
    .globl do_uart_write__u32__i32
do_uart_write__u32__i32:
    li   t0, 0x40070000
    mv   t2, a1
1:  beqz t2, 2f
4:  lw   t1, 0x18(t0)         # UARTFR
    andi t1, t1, 0x20         # TXFF
    bnez t1, 4b
    lbu  t1, 0(a0)
    sw   t1, 0x00(t0)         # UARTDR
    addi a0, a0, 1
    addi t2, t2, -1
    j    1b
2:  mv   a0, a1
    ret

# ===== UART read (PL011 RX) =====
    .globl do_uart_read__u32__i32
do_uart_read__u32__i32:
    li   t0, 0x40070000
    beqz a1, 8f
    mv   t2, a1
    mv   t3, a0
6:  lw   t1, 0x18(t0)         # UARTFR
    andi t1, t1, 0x10         # RXFE
    bnez t1, 6b
    lbu  t1, 0(t0)            # UARTDR
    sb   t1, 0(t3)
    addi t3, t3, 1
    addi t2, t2, -1
7:  beqz t2, 8f
    lw   t1, 0x18(t0)
    andi t1, t1, 0x10
    bnez t1, 8f
    lbu  t1, 0(t0)
    sb   t1, 0(t3)
    addi t3, t3, 1
    addi t2, t2, -1
    j    7b
8:  sub  a0, a1, t2
    ret

# Non-blocking UART read. Reads up to `a1` bytes, returns actual count
# read (0 if FIFO empty). Used by uart_rx_dispatch (Phase 2 mux) so
# the kernel can drain frames without blocking on first byte.
    .globl do_uart_try_read__u32__i32
do_uart_try_read__u32__i32:
    li   t0, 0x40070000
    beqz a1, 9f
    mv   t2, a1
    mv   t3, a0
10: beqz t2, 9f
    lw   t1, 0x18(t0)
    andi t1, t1, 0x10         # RXFE
    bnez t1, 9f               # FIFO empty → bail
    lbu  t1, 0(t0)
    sb   t1, 0(t3)
    addi t3, t3, 1
    addi t2, t2, -1
    j    10b
9:  sub  a0, a1, t2
    ret

# ===== Kernel runtime stubs =====
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    mv   a0, a1
    mv   a1, a2
    j    do_uart_write__u32__i32
    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    mv   a0, a1
    mv   a1, a2
    j    do_uart_read__u32__i32
    .globl do_exit__i32
do_exit__i32:
    j    _park

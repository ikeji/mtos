# bootrom.S — 8 KB boot ROM for the hw/ SoC (runs from BSRAM at 0x0).
#
# 1. Print a banner.
# 2. Wait up to BOOT_UART_WAIT mtime ticks (SoC register 0x00100004,
#    ~1 s on the board, tiny in sim) for a byte on the UART. If one
#    arrives, take load frames on the UART:
#      [len u32 LE][data len bytes][sum u32 LE]   sum = bytes mod 2^32
#    → 'K' + jump to 0x8000_0000, or 'E' + wait for another frame.
# 3. Otherwise try the SPI flash: bit-bang SPI (mode 0) on SIO GPIO
#    13=CLK 15=CS 16=MISO 17=MOSI, READ (0x03) from FLASH_IMG_OFF:
#      "MTOS" [len u32 LE][data][sum u32 LE]
#    → copy to 0x8000_0000, verify, print "flash: ok\n", jump. On a bad
#    magic/sum print "flash: none\n" / "flash: bad\n" and fall back to
#    the UART frame loop (waiting forever this time).
# Host side: hw/tools/uart_load.py, hw/tools/flash_kernel.sh.
#
# Registers: s0 = UART base, s1 = dst pointer, s2 = remaining, s3 = sum,
#            s6 = SIO base (0xD0000000).
    .equ FLASH_IMG_OFF, 0x100000
    .equ SIO_IN,      0x04
    .equ SIO_OUT_SET, 0x18
    .equ SIO_OUT_CLR, 0x20
    .equ SIO_OE_SET,  0x38
    .equ F_CLK,  (1 << 13)
    .equ F_CS,   (1 << 15)
    .equ F_MISO, (1 << 16)
    .equ F_MOSI, (1 << 17)

    .section .text
    .globl _start
_start:
    li   sp, 0x1ff0                 # top of the 8 KB ROM/RAM block
    li   s0, 0x10000000
    li   s6, 0xD0000000
    la   a0, banner
    call puts

    # ---- wait for a UART byte or the timeout ----
    li   t2, 0x00100004
    lw   t3, 0(t2)                  # t3 = BOOT_UART_WAIT
    li   t2, 0x0200BFF8
    lw   t4, 0(t2)                  # t4 = mtime lo at start
1:  lbu  t0, 5(s0)
    andi t0, t0, 1
    bnez t0, frame                  # a byte is waiting: UART load
    lw   t5, 0(t2)
    sub  t5, t5, t4
    bltu t5, t3, 1b
    call flash_boot                 # returns only on failure

# ---- UART frame loop ----
frame:
    call get32                      # a0 = len
    mv   s2, a0
    li   s1, 0x80000000
    li   s3, 0
1:  beqz s2, 2f
    call getc
    sb   a0, 0(s1)
    add  s3, s3, a0
    addi s1, s1, 1
    addi s2, s2, -1
    j    1b
2:  call get32                      # a0 = expected sum
    bne  a0, s3, bad
    li   a0, 'K'
    call putc
    j    go_kernel
bad:
    li   a0, 'E'
    call putc
    j    frame

go_kernel:
    fence.i
    li   t0, 0x80000000
    jr   t0

# ---- SPI flash boot ----
flash_boot:
    addi sp, sp, -16
    sw   ra, 12(sp)
    # GPIO setup: CS high, CLK/MOSI low, outputs enabled
    li   t0, F_CS
    sw   t0, SIO_OUT_SET(s6)
    li   t0, F_CLK | F_MOSI
    sw   t0, SIO_OUT_CLR(s6)
    li   t0, F_CLK | F_CS | F_MOSI
    sw   t0, SIO_OE_SET(s6)
    # READ command 0x03 + 24-bit address
    li   t0, F_CS
    sw   t0, SIO_OUT_CLR(s6)        # CS low
    li   a0, 0x03
    call spi_xfer
    li   a0, (FLASH_IMG_OFF >> 16) & 0xff
    call spi_xfer
    li   a0, (FLASH_IMG_OFF >> 8) & 0xff
    call spi_xfer
    li   a0, FLASH_IMG_OFF & 0xff
    call spi_xfer
    # header: magic "MTOS" (LE 0x534F544D), len
    call spi_get32
    li   t0, 0x534F544D
    bne  a0, t0, fl_none
    call spi_get32
    mv   s2, a0
    li   t0, 0x00700000             # sanity: image must fit below the 7 MB mark
    bgeu s2, t0, fl_none
    li   s1, 0x80000000
    li   s3, 0
1:  beqz s2, 2f
    li   a0, 0xff
    call spi_xfer
    sb   a0, 0(s1)
    add  s3, s3, a0
    addi s1, s1, 1
    addi s2, s2, -1
    j    1b
2:  call spi_get32
    li   t0, F_CS
    sw   t0, SIO_OUT_SET(s6)        # CS high
    bne  a0, s3, fl_bad
    la   a0, msg_ok
    call puts
    j    go_kernel
fl_none:
    li   t0, F_CS
    sw   t0, SIO_OUT_SET(s6)
    la   a0, msg_none
    call puts
    j    fl_ret
fl_bad:
    la   a0, msg_bad
    call puts
fl_ret:
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

# spi_xfer: a0 = byte to send (MSB first), returns a0 = byte received.
# SPI mode 0: MOSI set while CLK low, MISO sampled after the rising edge.
spi_xfer:
    li   t1, 8
    li   t6, 0
1:  andi t0, a0, 0x80
    li   t5, F_MOSI
    beqz t0, 2f
    sw   t5, SIO_OUT_SET(s6)
    j    3f
2:  sw   t5, SIO_OUT_CLR(s6)
3:  li   t5, F_CLK
    sw   t5, SIO_OUT_SET(s6)        # rising edge
    nop
    nop
    lw   t0, SIO_IN(s6)             # (2-stage synchroniser in gpio_sio → ≥2 clocks after the edge)
    lw   t0, SIO_IN(s6)
    sw   t5, SIO_OUT_CLR(s6)        # falling edge
    srli t0, t0, 16
    andi t0, t0, 1
    slli t6, t6, 1
    or   t6, t6, t0
    slli a0, a0, 1
    addi t1, t1, -1
    bnez t1, 1b
    mv   a0, t6
    ret

spi_get32:                           # -> a0 = little-endian u32 from the flash stream
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s4, 8(sp)
    sw   s5, 4(sp)
    li   s4, 0
    li   s5, 0
1:  li   a0, 0xff
    call spi_xfer
    sll  a0, a0, s5
    or   s4, s4, a0
    addi s5, s5, 8
    li   t0, 32
    bne  s5, t0, 1b
    mv   a0, s4
    lw   s5, 4(sp)
    lw   s4, 8(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret

# ---- UART helpers (16550 subset: DR +0, LSR +5 bit0 = RX ready) ----
getc:                                # -> a0 = byte (blocking)
1:  lbu  t0, 5(s0)
    andi t0, t0, 1
    beqz t0, 1b
    lbu  a0, 0(s0)
    ret
get32:                               # -> a0 = little-endian u32
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s4, 8(sp)
    sw   s5, 4(sp)
    li   s4, 0
    li   s5, 0
1:  call getc
    sll  a0, a0, s5
    or   s4, s4, a0
    addi s5, s5, 8
    li   t0, 32
    bne  s5, t0, 1b
    mv   a0, s4
    lw   s5, 4(sp)
    lw   s4, 8(sp)
    lw   ra, 12(sp)
    addi sp, sp, 16
    ret
putc:                                # a0 = byte (the DR write stalls until the TX is free)
    sb   a0, 0(s0)
    ret
puts:                                # a0 = NUL-terminated string
    mv   t1, a0
1:  lbu  t2, 0(t1)
    beqz t2, 2f
    sb   t2, 0(s0)
    addi t1, t1, 1
    j    1b
2:  ret

    .section .rodata
banner:   .asciz "tn20k boot: uart [len][data][sum32] or flash @0x100000\n"
msg_ok:   .asciz "flash: ok\n"
msg_none: .asciz "flash: none\n"
msg_bad:  .asciz "flash: bad\n"

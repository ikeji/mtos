# bootrom.S — 8 KB boot ROM for the hw/ SoC (runs from BSRAM at 0x0).
#
# Prints a banner, then loops receiving load frames on the UART:
#   [len u32 LE][data len bytes][sum u32 LE]   sum = sum of data bytes mod 2^32
# The data is stored at 0x8000_0000 (SDRAM). On a good checksum it
# replies 'K' and jumps to 0x8000_0000; on a bad one it replies 'E' and
# waits for another frame. Host side: hw/tools/uart_load.py.
#
# Registers: s0 = UART base, s1 = dst pointer, s2 = remaining, s3 = sum.
    .section .text
    .globl _start
_start:
    li   sp, 0x1ff0                 # top of the 8 KB ROM/RAM block
    li   s0, 0x10000000
    la   a0, banner
    call puts
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
    fence.i
    li   t0, 0x80000000
    jr   t0
bad:
    li   a0, 'E'
    call putc
    j    frame

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
banner:
    .asciz "tn20k boot: send [len][data][sum32]\n"

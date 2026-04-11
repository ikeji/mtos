# hello.s — RP2350 RISC-V bare-metal "Hello, Pico 2!"
#
# Boot ROM が IMAGE_DEF を読んで _start にジャンプする。
# XOSC を起動 → clk_peri を XOSC に切替 → UART0 初期化 → "Hello" 出力 → 無限ループ

    .section .embedded_block, "a"
    .global __embedded_block
__embedded_block:
block_start:
    .word 0xFFFFDED3              # PICOBIN_BLOCK_MARKER_START
    # IMAGE_TYPE item: type=0x42, size=1 word, flags=0x1101 (EXE | RISC-V | RP2350)
    .byte 0x42
    .byte 0x01
    .hword 0x1101
    # ENTRY_POINT item: type=0x44, size=3 words
    .byte 0x44
    .byte 0x03
    .hword 0x0000
    .word _start                  # entry point
    .word 0x20082000              # initial SP (SRAM末尾)
    # LAST item: type=0xFF, size = item部分のワード数 (markers/LAST/link除く)
    # = IMAGE_TYPE(1) + ENTRY_POINT(3) = 4
    .byte 0xFF
    .hword (block_end - block_start - 16) / 4
    .byte 0x00
    .word 0x00000000              # loop link (self)
    .word 0xAB123579              # PICOBIN_BLOCK_MARKER_END
block_end:

    .section .text
    .global _start
_start:
    # コア1は park させる
    li   t0, 0xD0000000           # SIO_BASE
    lw   t0, 0(t0)                # CPUID
    bnez t0, park

    # スタックポインタ初期化
    li   sp, 0x20082000

    # ===== XOSC 有効化 =====
    li   t0, 0x40048000           # XOSC_BASE
    li   t1, 0xAA0                # CTRL: FREQ_RANGE = 1_15MHZ
    sw   t1, 0x00(t0)
    li   t1, 0xC4                 # STARTUP delay
    sw   t1, 0x0C(t0)
    li   t2, 0x4004A000           # XOSC_BASE + SET (atomic)
    li   t1, 0x00FAB000           # ENABLE
    sw   t1, 0x00(t2)             # CTRL_SET
1:  lw   t1, 0x04(t0)             # XOSC_STATUS
    bgez t1, 1b                   # bit31 = STABLE → 負になれば抜ける

    # ===== clk_peri を XOSC に切替 =====
    # まず無効化
    li   t0, 0x40010048           # CLK_PERI_CTRL
    sw   zero, 0(t0)
    # 4 << 5 (AUXSRC=xosc) | (1 << 11) (ENABLE)
    li   t1, (1 << 11) | (4 << 5)
    sw   t1, 0(t0)

    # ===== ペリフェラル リセット解除 (IO_BANK0=6, PADS_BANK0=9, UART0=26) =====
    li   t0, 0x40023000           # RESETS + CLR
    li   t1, (1<<6) | (1<<9) | (1<<26)
    sw   t1, 0(t0)
    # RESET_DONE 待ち
    li   t0, 0x40020008           # RESETS_RESET_DONE
2:  lw   t2, 0(t0)
    and  t2, t2, t1
    bne  t2, t1, 2b

    # ===== GPIO0 (TX): FUNCSEL = 2 (UART) =====
    li   t0, 0x40028004           # IO_BANK0 + GPIO0_CTRL
    li   t1, 2
    sw   t1, 0(t0)
    # GPIO1 (RX): FUNCSEL = 2
    li   t0, 0x4002800C           # IO_BANK0 + GPIO1_CTRL
    sw   t1, 0(t0)

    # ===== PAD ISO クリア (GPIO0, GPIO1) =====
    li   t1, (1 << 8)             # ISO bit
    li   t0, 0x4003B004           # PADS_BANK0 + CLR + GPIO0
    sw   t1, 0(t0)
    li   t0, 0x4003B008           # PADS_BANK0 + CLR + GPIO1
    sw   t1, 0(t0)
    # GPIO1: 入力イネーブル
    li   t0, 0x4003A008           # PADS_BANK0 + SET + GPIO1
    li   t1, (1 << 6)             # IE bit
    sw   t1, 0(t0)

    # ===== UART0 初期化 (12MHz / 115200bps) =====
    # IBRD = 6, FBRD = 33
    li   t0, 0x40070000           # UART0_BASE
    li   t1, 6
    sw   t1, 0x24(t0)             # IBRD
    li   t1, 33
    sw   t1, 0x28(t0)             # FBRD
    # 8N1 + FIFO (WLEN=11, FEN=1)
    li   t1, (3 << 5) | (1 << 4)
    sw   t1, 0x2C(t0)             # LCR_H
    # UARTEN | TXE | RXE
    li   t1, (1 << 9) | (1 << 8) | (1 << 0)
    sw   t1, 0x30(t0)             # CR

    # ===== "Hello, Pico 2!\r\n" 出力 =====
    la   a0, hello_msg
    la   a1, hello_end
    sub  a1, a1, a0
    call uart_write

park:
    j    park

# uart_write(buf=a0, len=a1)
uart_write:
    li   t0, 0x40070000           # UART0
3:  beqz a1, 5f
    # TXFF (bit 5) が立ってる間待つ
4:  lw   t1, 0x18(t0)             # UARTFR
    andi t1, t1, (1 << 5)
    bnez t1, 4b
    lbu  t1, 0(a0)
    sw   t1, 0x00(t0)             # UARTDR
    addi a0, a0, 1
    addi a1, a1, -1
    j    3b
5:  ret

    .section .rodata
hello_msg:
    .ascii "Hello, Pico 2!\r\n"
hello_end:

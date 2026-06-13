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

    # PLL_SYS bring-up: 12 MHz XOSC × FBDIV(125) = 1500 MHz VCO,
    # then POSTDIV1(5) × POSTDIV2(2) = /10 → 150 MHz clk_sys.
    # Sequence mirrors pico-sdk's hardware_pll::pll_init().
    # 1. Take PLL_SYS out of reset (RESETS bit 14).
    li   t0, 0x40023000        # RESETS_CLR alias
    li   t1, 0x4000            # 1<<14 = PLL_SYS
    sw   t1, 0(t0)
    li   t0, 0x40020008        # RESET_DONE
6:  lw   t2, 0(t0)
    and  t2, t2, t1
    bne  t2, t1, 6b
    # 2. Load REFDIV=1 (CS) and FBDIV_INT=125 before powering up VCO.
    li   t0, 0x40050000        # PLL_SYS base
    li   t1, 1
    sw   t1, 0x00(t0)          # CS: REFDIV=1
    li   t1, 125
    sw   t1, 0x08(t0)          # FBDIV_INT
    # 3. Power on PLL + VCO: clear PD (bit 0) and VCOPD (bit 5) of PWR.
    li   t2, 0x40053004        # PLL_SYS PWR_CLR alias
    li   t1, 0x21
    sw   t1, 0(t2)
    # 4. Wait LOCK (CS bit 31). Spin until set.
7:  lw   t1, 0x00(t0)
    bge  t1, zero, 7b          # branch if bit 31 == 0 (not locked yet)
    # 5. Set POSTDIV1=5, POSTDIV2=2 (PRIM register at +0x0C).
    #    Bits [18:16] = POSTDIV1, bits [14:12] = POSTDIV2.
    li   t1, 0x52000           # (5<<16) | (2<<12)
    sw   t1, 0x0C(t0)
    # 6. Power on POSTDIV (clear bit 3 in PWR).
    li   t1, 0x08
    sw   t1, 0(t2)

    # Switch clk_sys → AUX (= PLL_SYS, AUXSRC=0 by default).
    # CLK_SYS_CTRL @ CLOCKS+0x3C, bit 0 = SRC. Glitchless mux:
    # going clk_ref→AUX is safe because both sides are running.
    li   t0, 0x4001003C
    li   t1, 1
    sw   t1, 0(t0)
    li   t0, 0x40010044        # CLK_SYS_SELECTED
8:  lw   t1, 0(t0)
    andi t1, t1, 2             # bit 1 = AUX selected
    beqz t1, 8b

    # clk_peri → XOSC. Leave at 12 MHz so UART baud divider (which we
    # set up next) and SD SPI prescale still work without rework.
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

    # GP30/31 → UART0 (funcsel 11 = UART0 TX/RX on the QFN-80 RP2350B —
    # pico-sdk: GPIO30_CTRL_FUNCSEL_VALUE_UART0_TX = 0x0b, GPIO31..._RX = 0x0b).
    # The 2026-05-21 board moved UART off GP0/1; see docs/pico2_hardware.md.
    # GPn CTRL = IO_BANK0 + 8*n + 4 → GP30 = 0x400280F4, GP31 = 0x400280FC.
    li   t0, 0x400280F4
    li   t1, 11
    sw   t1, 0(t0)
    li   t0, 0x400280FC
    sw   t1, 0(t0)

    # PAD ISO clear on GP30/31, IE on GP31 (RX). PADS_BANK0 reg for GPn
    # is at base + 4 + 4*n → GP30 pad = 0x7C, GP31 pad = 0x80.
    li   t1, 0x100
    li   t0, 0x4003B07C
    sw   t1, 0(t0)
    li   t0, 0x4003B080
    sw   t1, 0(t0)
    li   t0, 0x4003A080
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
    li   a1, 196124
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

# ===== Kernel runtime stubs =====
# do_uart_write / do_uart_read / do_uart_try_read / do_write / do_read
# moved to kernel/platform_pico2.tc (Phase 8). do_exit stays here
# since the kernel exit path never returns and must not touch the TC
# runtime — we just park.
    .globl do_exit__i32
do_exit__i32:
    j    _park

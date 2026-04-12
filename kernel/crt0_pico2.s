# kernel/crt0_pico2.s — kernel crt0 for RP2350 (Pico 2) RISC-V
#
# Platform: PL011 UART0 @ 0x40070000, XOSC 12MHz, 115200 bps.
# Ecall handler for task syscalls. No timer preemption (sequential tasks).

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

    # RESETS (IO_BANK0, PADS_BANK0, UART0)
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

    # gp
    li   gp, 0x20000800

    # runtime init
    la   a0, __arena
    li   a1, 262144
    call __runtime_init__u32__i32

    # trap vector (for ecall handling)
    la   t0, _trap_frame
    csrw 0x340, t0
    la   t0, _trap_entry
    csrw 0x305, t0

    call main

_park:
    j    _park

# ===== Trap entry =====
_trap_entry:
    csrrw sp, 0x340, sp
    sw   ra,   4(sp)
    sw   gp,  12(sp)
    sw   tp,  16(sp)
    sw   t0,  20(sp)
    sw   t1,  24(sp)
    sw   t2,  28(sp)
    sw   s0,  32(sp)
    sw   s1,  36(sp)
    sw   a0,  40(sp)
    sw   a1,  44(sp)
    sw   a2,  48(sp)
    sw   a3,  52(sp)
    sw   a4,  56(sp)
    sw   a5,  60(sp)
    sw   a6,  64(sp)
    sw   a7,  68(sp)
    sw   s2,  72(sp)
    sw   s3,  76(sp)
    sw   s4,  80(sp)
    sw   s5,  84(sp)
    sw   s6,  88(sp)
    sw   s7,  92(sp)
    sw   s8,  96(sp)
    sw   s9, 100(sp)
    sw   s10, 104(sp)
    sw   s11, 108(sp)
    sw   t3, 112(sp)
    sw   t4, 116(sp)
    sw   t5, 120(sp)
    sw   t6, 124(sp)
    csrr t0, 0x340
    sw   t0,   8(sp)
    csrr t0, 0x341
    sw   t0, 128(sp)
    csrw 0x340, sp
    # Dispatch
    csrr t0, 0x342
    li   t1, 11
    beq  t0, t1, _handle_ecall
    # Unknown trap: just restore
    j    _trap_restore

_handle_ecall:
    lw   t0, 68(sp)
    li   t1, 64
    beq  t0, t1, _ecall_write
    li   t1, 93
    beq  t0, t1, _ecall_exit
    # Unknown: advance mepc
    lw   t0, 128(sp)
    addi t0, t0, 4
    sw   t0, 128(sp)
    j    _trap_restore

_ecall_write:
    mv   s0, sp
    la   gp, __global_pointer$
    la   t0, _kern_save
    lw   sp, 4(t0)
    lw   a0, 44(s0)
    lw   a1, 48(s0)
    call do_uart_write__u32__i32
    sw   a0, 40(s0)
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_exit:
    la   t0, _task_exit_trampoline
    sw   t0, 128(sp)
    j    _trap_restore

_trap_restore:
    csrr sp, 0x340
    lw   t0, 128(sp)
    csrw 0x341, t0
    lw   ra,   4(sp)
    lw   gp,  12(sp)
    lw   tp,  16(sp)
    lw   t0,  20(sp)
    lw   t1,  24(sp)
    lw   t2,  28(sp)
    lw   s0,  32(sp)
    lw   s1,  36(sp)
    lw   a0,  40(sp)
    lw   a1,  44(sp)
    lw   a2,  48(sp)
    lw   a3,  52(sp)
    lw   a4,  56(sp)
    lw   a5,  60(sp)
    lw   a6,  64(sp)
    lw   a7,  68(sp)
    lw   s2,  72(sp)
    lw   s3,  76(sp)
    lw   s4,  80(sp)
    lw   s5,  84(sp)
    lw   s6,  88(sp)
    lw   s7,  92(sp)
    lw   s8,  96(sp)
    lw   s9, 100(sp)
    lw   s10, 104(sp)
    lw   s11, 108(sp)
    lw   t3, 112(sp)
    lw   t4, 116(sp)
    lw   t5, 120(sp)
    lw   t6, 124(sp)
    lw   sp,   8(sp)
    mret

# ===== Task exit trampoline =====
_task_exit_trampoline:
    la   gp, __global_pointer$
    la   t0, _kern_save
    lw   ra,  0(t0)
    lw   sp,  4(t0)
    lw   s0,  8(t0)
    lw   s1, 12(t0)
    lw   s2, 16(t0)
    lw   s3, 20(t0)
    lw   s4, 24(t0)
    lw   s5, 28(t0)
    lw   s6, 32(t0)
    lw   s7, 36(t0)
    lw   s8, 40(t0)
    lw   s9, 44(t0)
    lw   s10, 48(t0)
    lw   s11, 52(t0)
    lw   gp, 56(t0)
    ret

# ===== kern_run_task(entry: u32, sp: u32, gp: u32, arena: u32, arena_size: i32) =====
    .globl kern_run_task__u32__u32__u32__u32__i32
kern_run_task__u32__u32__u32__u32__i32:
    la   t0, _kern_save
    sw   ra,  0(t0)
    sw   sp,  4(t0)
    sw   s0,  8(t0)
    sw   s1, 12(t0)
    sw   s2, 16(t0)
    sw   s3, 20(t0)
    sw   s4, 24(t0)
    sw   s5, 28(t0)
    sw   s6, 32(t0)
    sw   s7, 36(t0)
    sw   s8, 40(t0)
    sw   s9, 44(t0)
    sw   s10, 48(t0)
    sw   s11, 52(t0)
    sw   gp, 56(t0)
    mv   t0, a0
    mv   sp, a1
    mv   gp, a2
    mv   a0, a3
    mv   a1, a4
    jr   t0

# ===== UART output =====
    .globl do_uart_write__u32__i32
do_uart_write__u32__i32:
    li   t0, 0x40070000
    mv   t2, a1
1:  beqz t2, 2f
4:  lw   t1, 0x18(t0)
    andi t1, t1, 0x20
    bnez t1, 4b
    lbu  t1, 0(a0)
    sw   t1, 0x00(t0)
    addi a0, a0, 1
    addi t2, t2, -1
    j    1b
2:  mv   a0, a1
    ret

    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    mv   a0, a1
    mv   a1, a2
    j    do_uart_write__u32__i32

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a0, 0
    ret

    .globl do_exit__i32
do_exit__i32:
    j    _park

# ===== Peek/Poke =====
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

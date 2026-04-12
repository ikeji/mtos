# kernel/crt0_virt.s — kernel crt0 for qemu-system-riscv32 -M virt
#
# Platform: 16550 UART @ 0x10000000, SiFive test exit @ 0x100000.
# Supports per-task trap frames and preemptive context switching.

    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    li   sp, 0x88000000
    la   a0, __arena
    li   a1, 4648960
    call __runtime_init__u32__i32
    la   t0, _trap_frame
    csrw 0x340, t0
    la   t0, _trap_entry
    csrw 0x305, t0
    call main
_park:
    li   t0, 0x100000
    li   t1, 0x5555
    sw   t1, 0(t0)
1:  j    1b

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
    # Dispatch by mcause
    csrr t0, 0x342
    li   t1, 11
    beq  t0, t1, _handle_ecall
    # Not ecall: call TC trap_handler(cause, epc)
    mv   s0, sp
    la   gp, __global_pointer$
    la   t2, _kern_save
    lw   sp, 4(t2)
    mv   a0, t0
    csrr a1, 0x341
    call trap_handler__u32__u32
    mv   sp, s0
    j    _trap_restore

# ===== ecall handler =====
_handle_ecall:
    lw   t0, 68(sp)
    li   t1, 64
    beq  t0, t1, _ecall_write
    li   t1, 93
    beq  t0, t1, _ecall_exit
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
    # Call TC sched_task_exit() to get next task frame (0 = all done)
    mv   s0, sp
    la   gp, __global_pointer$
    la   t0, _kern_save
    lw   sp, 4(t0)
    call sched_task_exit
    beqz a0, _all_tasks_done
    # Switch to next task's frame
    la   t0, _switch_frame
    sw   a0, 0(t0)
    mv   sp, s0
    j    _trap_restore
_all_tasks_done:
    mv   sp, s0
    la   t0, _task_exit_trampoline
    sw   t0, 128(sp)
    j    _trap_restore

# ===== Trap restore + context switch =====
_trap_restore:
    # Check _switch_frame: if non-zero, switch to that frame
    la   t0, _switch_frame
    lw   t1, 0(t0)
    beqz t1, _no_switch
    csrw 0x340, t1
    sw   zero, 0(t0)
_no_switch:
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

# ===== Default handlers (overridden by TC) =====
    .globl trap_handler__u32__u32
trap_handler__u32__u32:
    ret
    .globl sched_task_exit
sched_task_exit:
    li   a0, 0
    ret

# ===== set_switch_frame(addr: u32) =====
    .globl set_switch_frame__u32
set_switch_frame__u32:
    la   t0, _switch_frame
    sw   a0, 0(t0)
    ret

# ===== init_task_frame(frame, entry, sp, gp, arena, arena_size) =====
    .globl init_task_frame__u32__u32__u32__u32__u32__i32
init_task_frame__u32__u32__u32__u32__u32__i32:
    # a0=frame, a1=entry, a2=sp, a3=gp, a4=arena, a5=arena_size
    # Zero the frame (132 bytes = 33 words)
    mv   t0, a0
    li   t1, 132
    add  t1, t0, t1
1:  sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 1b
    # Set registers in frame
    sw   a1, 128(a0)          # mepc = entry
    sw   a2,   8(a0)          # sp
    sw   a3,  12(a0)          # gp
    sw   a4,  40(a0)          # a0 = arena addr
    sw   a5,  44(a0)          # a1 = arena size
    ret

# ===== sched_start(frame: u32) =====
# Save kernel context, mret to first task. Returns when all tasks done.
    .globl sched_start__u32
sched_start__u32:
    # a0 = initial task frame address
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
    # Set mscratch to task frame
    csrw 0x340, a0
    # Set MPP=M-mode (bits 12:11) + MPIE (bit 7) for mret
    csrr t0, 0x300
    li   t1, 0x1880           # MPP=11 (0x1800) | MPIE (0x80)
    or   t0, t0, t1
    csrw 0x300, t0
    # Restore from frame via _trap_restore
    j    _trap_restore

# ===== kern_run_task(entry: u32, sp: u32, gp: u32, arena: u32, arena_size: i32) -> i32 =====
    .globl kern_run_task__u32__u32__u32__u32__i32
kern_run_task__u32__u32__u32__u32__i32:
    # a0=entry, a1=sp, a2=gp, a3=arena, a4=arena_size
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
    mv   t0, a0               # entry
    mv   sp, a1
    mv   gp, a2
    mv   a0, a3
    mv   a1, a4
    jr   t0

# ===== UART =====
    .globl do_uart_write__u32__i32
do_uart_write__u32__i32:
    li   t0, 0x10000000
    mv   t2, a1
1:  beqz t2, 2f
    lbu  t1, 0(a0)
    sb   t1, 0(t0)
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

# ===== CSR helpers =====
    .globl csr_read_mstatus
csr_read_mstatus:
    csrr a0, 0x300
    ret
    .globl csr_write_mstatus__u32
csr_write_mstatus__u32:
    csrw 0x300, a0
    ret
    .globl csr_read_mie
csr_read_mie:
    csrr a0, 0x304
    ret
    .globl csr_write_mie__u32
csr_write_mie__u32:
    csrw 0x304, a0
    ret
    .globl csr_read_mcause
csr_read_mcause:
    csrr a0, 0x342
    ret

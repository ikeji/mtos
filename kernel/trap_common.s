# kernel/trap_common.s — platform-independent trap handling and scheduler
#
# Provides: _trap_entry, _trap_restore, _handle_ecall, _task_exit_trampoline,
#           init_task_frame, sched_start, kern_run_task, set_switch_frame,
#           default trap_handler/sched_task_exit, peek/poke, CSR helpers.
#
# Requires from platform.s:
#   _set_kern_gp:       sets gp to the kernel's runtime gp value (1 instr ok)
#   do_uart_write:      a0=buf, a1=len  → write to UART
#   do_uart_read:       a0=buf, a1=len  → read from UART (block first byte)
#   _kern_save, _trap_frame, _switch_frame in BSS

    .text

# ===== Trap entry =====
# Saves all 31 regs + mepc to mscratch (current task's trap frame).
# Then dispatches by mcause.
    .globl _trap_entry
_trap_entry:
    csrrw sp, 0x340, sp       # sp ↔ trap frame
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
    sw   t0,   8(sp)          # original sp
    csrr t0, 0x341
    sw   t0, 128(sp)          # mepc
    csrw 0x340, sp            # mscratch = trap frame
    # Dispatch by mcause
    csrr t0, 0x342
    li   t1, 11
    beq  t0, t1, _handle_ecall
    # Not ecall: call TC trap_handler(cause, epc)
    mv   s0, sp
    call _set_kern_gp
    la   t2, _kern_save
    lw   sp, 4(t2)
    csrr a0, 0x342
    csrr a1, 0x341
    call trap_handler__u32__u32
    mv   sp, s0
    j    _trap_restore

# ===== ecall handler =====
_handle_ecall:
    lw   t0, 68(sp)
    li   t1, 64
    beq  t0, t1, _ecall_write
    li   t1, 63
    beq  t0, t1, _ecall_read
    li   t1, 56
    beq  t0, t1, _ecall_openat
    li   t1, 57
    beq  t0, t1, _ecall_close
    li   t1, 93
    beq  t0, t1, _ecall_exit
    li   t1, 221
    beq  t0, t1, _ecall_exec
    # Unknown: advance mepc and return
    lw   t0, 128(sp)
    addi t0, t0, 4
    sw   t0, 128(sp)
    j    _trap_restore

_ecall_write:
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    lw   a0, 40(s0)         # fd
    lw   a1, 44(s0)         # buf addr
    lw   a2, 48(s0)         # len
    call vfs_write__i32__u32__i32
    sw   a0, 40(s0)
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_read:
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    lw   a0, 40(s0)         # fd
    lw   a1, 44(s0)         # buf addr
    lw   a2, 48(s0)         # len
    call vfs_read__i32__u32__i32
    sw   a0, 40(s0)
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_openat:
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    # a0 = task's dirfd (ignored)
    lw   a0, 44(s0)         # path addr (task's a1)
    lw   a1, 48(s0)         # flags    (task's a2)
    call vfs_open__u32__i32
    sw   a0, 40(s0)
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_close:
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    lw   a0, 40(s0)         # fd
    call vfs_close__i32
    sw   a0, 40(s0)
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

# ===== sys_exec (a7 = 221) =====
# a0 = NUL-terminated path address (task virtual == kernel virtual).
# On success, sys_exec_handler returns the new frame and has already
# called sched_replace_current; we then switch mscratch to it so mret
# lands in the new task's entry. On failure, we write -1 to a0 and
# advance mepc past the ecall like a normal syscall return.
_ecall_exec:
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    lw   a0, 40(s0)         # path addr (task's a0)
    call sys_exec_handler__u32
    beqz a0, _exec_failed
    la   t0, _switch_frame
    sw   a0, 0(t0)
    mv   sp, s0
    j    _trap_restore
_exec_failed:
    li   t0, -1
    sw   t0, 40(s0)         # saved a0 = -1
    lw   t0, 128(s0)
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_exit:
    # Call TC sched_task_exit() to get next task frame (0 = all done)
    mv   s0, sp
    call _set_kern_gp
    la   t0, _kern_save
    lw   sp, 4(t0)
    call sched_task_exit
    beqz a0, _all_tasks_done
    la   t0, _switch_frame
    sw   a0, 0(t0)
    mv   sp, s0
    j    _trap_restore
_all_tasks_done:
    # Disable interrupts: clear MPIE so mret leaves MIE=0
    csrr t0, 0x300
    li   t1, 0x80
    not  t1, t1
    and  t0, t0, t1
    csrw 0x300, t0
    mv   sp, s0
    la   t0, _task_exit_trampoline
    sw   t0, 128(sp)
    j    _trap_restore

# ===== Trap restore + context switch =====
    .globl _trap_restore
_trap_restore:
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
# After mret to here: restore kernel callee-saved from _kern_save and ret.
_task_exit_trampoline:
    call _set_kern_gp
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
    .globl sys_exec_handler__u32
sys_exec_handler__u32:
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
    mv   t0, a0
    li   t1, 132
    add  t1, t0, t1
1:  sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 1b
    sw   a1, 128(a0)          # mepc = entry
    sw   a2,   8(a0)          # sp
    sw   a3,  12(a0)          # gp
    sw   a4,  40(a0)          # a0 = arena addr
    sw   a5,  44(a0)          # a1 = arena size
    ret

# ===== sched_start(frame: u32) =====
    .globl sched_start__u32
sched_start__u32:
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
    csrw 0x340, a0
    csrr t0, 0x300
    li   t1, 0x1880           # MPP=11 + MPIE
    or   t0, t0, t1
    csrw 0x300, t0
    j    _trap_restore

# ===== kern_run_task(entry, sp, gp, arena, arena_size) -> i32 =====
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

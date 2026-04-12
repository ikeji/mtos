# kernel/crt0_virt.s — kernel crt0 for qemu-system-riscv32 -M virt
#
# Platform: 16550 UART @ 0x10000000, SiFive test exit @ 0x100000.
# Trap handler: ecall (syscall) handled in assembly, interrupts in TC.

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
# Saves all regs + mepc to _trap_frame, then dispatches:
#   mcause == 11 (ecall) → assembly ecall handler
#   otherwise            → TC trap_handler(cause, epc)
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

# ===== ecall handler (in assembly) =====
_handle_ecall:
    lw   t0, 68(sp)           # saved a7 = syscall number
    li   t1, 64
    beq  t0, t1, _ecall_write
    li   t1, 93
    beq  t0, t1, _ecall_exit
    # Unknown syscall: advance mepc and return
    lw   t0, 128(sp)
    addi t0, t0, 4
    sw   t0, 128(sp)
    j    _trap_restore

_ecall_write:
    # sys_write(fd, buf, len) → a0=fd, a1=buf, a2=len
    mv   s0, sp               # s0 = trap frame base (callee-saved)
    la   gp, __global_pointer$
    la   t0, _kern_save
    lw   sp, 4(t0)            # kernel stack
    lw   a0, 44(s0)           # saved a1 = buf
    lw   a1, 48(s0)           # saved a2 = len
    call do_uart_write__u32__i32
    sw   a0, 40(s0)           # return value → saved a0
    lw   t0, 128(s0)          # mepc
    addi t0, t0, 4
    sw   t0, 128(s0)
    mv   sp, s0
    j    _trap_restore

_ecall_exit:
    # sys_exit(code) — return to kernel via trampoline
    # Set mepc to _task_exit_trampoline; mret will jump there
    la   t0, _task_exit_trampoline
    sw   t0, 128(sp)          # mepc = trampoline
    j    _trap_restore

# ===== Trap restore + mret =====
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
# mret jumps here after ecall exit. a0 = exit code (from trap frame).
# Restores kernel callee-saved regs from _kern_save and returns to kernel.
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

# ===== Default handlers =====
    .globl trap_handler__u32__u32
trap_handler__u32__u32:
    ret


# ===== kern_run_task(id: i32, sp: u32, gp: u32, arena: u32, arena_size: i32) -> i32 =====
# Saves kernel context, sets up task sp/gp/a0/a1, jumps to task binary by ID.
    .globl kern_run_task__i32__u32__u32__u32__i32
kern_run_task__i32__u32__u32__u32__i32:
    # a0 = task_id, a1 = task_sp, a2 = task_gp, a3 = arena_addr, a4 = arena_size
    # Save kernel callee-saved regs FIRST, then use s-regs for args
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
    # Now safe to use s-regs as temporaries
    mv   s0, a0               # save task_id
    # Set up task registers
    mv   sp, a1               # task stack
    mv   gp, a2               # task gp
    mv   a0, a3               # a0 = arena_addr (for task _start)
    mv   a1, a4               # a1 = arena_size
    # Dispatch by task_id (s0)
    li   t0, 1
    beq  s0, t0, _run_task_1
    # Unknown task: return -1
    la   t0, _kern_save
    lw   ra,  0(t0)
    lw   sp,  4(t0)
    lw   gp, 56(t0)
    li   a0, -1
    ret
_run_task_1:
    la   t0, _task_hello_start
    jr   t0
    # Never reaches here — task exits via ecall → _task_exit_trampoline

# ===== UART output (kernel-internal) =====
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

# Kernel runtime stubs (for kernel's own sys_write via runtime.tc)
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

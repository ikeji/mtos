# tests/virt_crt0.s — minimal crt0 for qemu-system-riscv32 -M virt
#
# Used by tests/test_asm.sh to run TC programs end-to-end on the virt
# machine. UART output goes to 16550 @ 0x10000000 (no THRE wait — qemu
# is always ready). Pairs with compiler/crt0_tc_data.s for __arena.
#
# Trap handling: _trap_entry saves all registers to _trap_frame via
# mscratch, calls TC trap_handler(cause: u32, epc: u32), restores, mret.
# A default trap_handler (just returns) is provided; TC code can override
# it (asm.tc uses last-wins for duplicate labels).

    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    # RAM on `-machine virt -m 128` is 0x80000000..0x88000000.
    # Point sp at the top so stack grows downward through free RAM.
    li   sp, 0x88000000
    la   a0, __arena
    li   a1, 4648960
    call __runtime_init__u32__i32

    # Set up trap infrastructure (interrupts stay disabled until TC enables)
    la   t0, _trap_frame
    csrw 0x340, t0            # mscratch = _trap_frame
    la   t0, _trap_entry
    csrw 0x305, t0            # mtvec = _trap_entry (direct mode)

    call main
    # Shut qemu down via the SiFive test MMIO (virt machine only).
    # Writing 0x5555 to 0x100000 exits qemu with status 0.
_park:
    li   t0, 0x100000
    li   t1, 0x5555
    sw   t1, 0(t0)
1:  j    1b

# ===== Trap entry/exit =====
# mscratch always holds _trap_frame when not in a trap handler.
# Entry: swap sp<->mscratch, save all regs to frame, call TC handler.
# Exit:  restore all regs from frame, swap sp<->mscratch, mret.
#
# Trap frame layout (31 words = 124 bytes, offset by register number * 4):
#   0(x0 unused), 4(ra/x1), 8(sp/x2), 12(gp/x3), 16(tp/x4),
#   20(t0/x5)..44(t2/x7), 48(s0/x8)..52(s1/x9),
#   56(a0/x10)..84(a7/x17), 88(s2/x18)..132(s11/x27),
#   136(t3/x28)..148(t6/x31)
_trap_entry:
    csrrw sp, 0x340, sp       # sp = _trap_frame, mscratch = original sp
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
    # Save original sp (now in mscratch) into frame
    csrr t0, 0x340
    sw   t0,   8(sp)
    # Keep _trap_frame in mscratch for restore and next trap
    csrw 0x340, sp

    # Set up TC calling convention
    mv   sp, t0               # sp = original stack pointer
    la   gp, __global_pointer$
    csrr a0, 0x342            # a0 = mcause
    csrr a1, 0x341            # a1 = mepc
    call trap_handler__u32__u32

    # Restore all registers from trap frame
    csrr sp, 0x340            # sp = _trap_frame (mscratch unchanged)
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
    lw   sp,   8(sp)          # restore original sp (must be last)
    mret

# ===== Default trap handler (overridden by TC if defined) =====
    .globl trap_handler__u32__u32
trap_handler__u32__u32:
    ret

# ===== Syscall stubs =====
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    # a0 = fd (ignored), a1 = buf, a2 = len
    li   t0, 0x10000000         # 16550 UART data register
    mv   t2, a2
1:  beqz t2, 2f
    lbu  t1, 0(a1)
    sb   t1, 0(t0)
    addi a1, a1, 1
    addi t2, t2, -1
    j    1b
2:  mv   a0, a2                 # return count
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a0, 0
    ret

    .globl do_exit__i32
do_exit__i32:
    # do_exit(code) — shut qemu down with status. code != 0 → fail.
    beqz a0, 1f
    # Fail: write 0x3333 | (code << 16) to 0x100000
    slli a0, a0, 16
    li   t1, 0x3333
    or   t1, t1, a0
    j    2f
1:  li   t1, 0x5555
2:  li   t0, 0x100000
    sw   t1, 0(t0)
3:  j    3b

# ===== Peek/Poke builtins =====
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

# ===== CSR helpers for TC =====
# TC cannot execute CSR instructions directly; these stubs expose
# mstatus/mie read/write so TC code can enable/disable interrupts.
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

# ===== Trap frame (BSS) =====
    .bss
    .align 4
_trap_frame:
    .space 128

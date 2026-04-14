#
# task_crt0.s — startup for guest tasks running under the kernel
#
# Calling convention from kernel:
#   sp = task stack top
#   gp = kernel-allocated RAM + 0x800
#   a0 = arena addr, a1 = arena size
#   a2 = argv StringArray pointer (0 if the task has no argv)
#
# _start copies .data from the binary to kernel RAM (gp-relative region),
# then initializes the runtime and calls main(argv: StringArray). Tasks
# that take no argv just ignore a0; len(null) returns 0 so main can
# probe argv.
#
    .text
    .globl _start
_start:
    # Save arena args (a0/a1) and argv (a2) across the data copy
    # and runtime init — these are clobbered by any TC call.
    mv   s0, a0
    mv   s1, a1
    mv   s2, a2

    # Copy .data from binary to kernel-allocated RAM.
    # __global_pointer$ is a text-section label → PC-relative la.
    # In the binary: gp_src = data_base + 0x800
    # Kernel set:    gp     = ram_base  + 0x800
    la   t0, __global_pointer$    # PC-relative: source gp (in binary)
    addi t0, t0, -0x800           # t0 = source data_base
    addi t1, gp, -0x800           # t1 = dest data_base (RAM)
    la   t2, __data_end           # gp-relative: dest data_end
    beq  t1, t2, 2f
1:  lw   t3, 0(t0)
    sw   t3, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    bltu t1, t2, 1b
2:
    # Restore arena args and init runtime
    mv   a0, s0
    mv   a1, s1
    call __runtime_init__u32__i32
    # Call main(argv). Every task defines main with signature
    # `fn main(argv: StringArray) -> i32` so the symbol is always
    # `main__StringArray`; tasks that ignore argv still accept the
    # unused parameter.
    mv   a0, s2
    call main__StringArray
    # sys_exit(return value of main)
    li   a7, 93
    ecall
1:  j    1b

# Syscall stubs (ecall — same ABI as Linux)
    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    li   a7, 64
    ecall
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    li   a7, 63
    ecall
    ret

    .globl do_openat__i32__u32__i32
do_openat__i32__u32__i32:
    li   a7, 56
    ecall
    ret

    .globl do_close__i32
do_close__i32:
    li   a7, 57
    ecall
    ret

    .globl do_exit__i32
do_exit__i32:
    li   a7, 93
    ecall
    ret

    .globl do_exec__u32__u32__u32__u32
do_exec__u32__u32__u32__u32:
    li   a7, 221
    ecall
    ret

    .globl do_spawn__u32__u32__u32__u32
do_spawn__u32__u32__u32__u32:
    li   a7, 220
    ecall
    ret

    .globl do_wait__i32
do_wait__i32:
    li   a7, 260
    ecall
    ret

# peek/poke builtins
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

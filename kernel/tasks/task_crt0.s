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
    # Call main(argv). The task may define either
    #   fn main() -> i32
    #   fn main(argv: StringArray) -> i32
    # which TC mangles to `main` or `main__StringArray` respectively.
    # We always call `main__StringArray` here. When the task only
    # defines plain `main`, asm.tc's last-wins label resolution leaves
    # the stub below (which tail-calls to `main`) intact. When the task
    # defines `main__StringArray`, the task's symbol overrides the stub
    # and this call lands directly in the task's body. a0 carries the
    # argv pointer in both cases — argv-unaware `main` simply ignores
    # it since RISC-V callees don't read unused argument registers.
    mv   a0, s2
    call main__StringArray
    # sys_exit(return value of main)
    li   a7, 93
    ecall
1:  j    1b

# Fallback stubs overridden by the task's own definitions. asm.tc's
# define_label updates the existing label in place when it sees a
# duplicate, and the task's .s files are linked AFTER task_crt0.s,
# so these only matter when the task omits a definition.
#
# `main__StringArray` forwards to `main` with a tail-call: useful for
# tasks that define only `fn main() -> i32`. `main` as a default just
# returns 0, so a task with neither symbol exits cleanly.
    .globl main__StringArray
main__StringArray:
    j    main
    .globl main
main:
    li   a0, 0
    ret

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

    .globl do_spawn_fds__u32__u32__i32__i32
do_spawn_fds__u32__u32__i32__i32:
    li   a7, 219
    ecall
    ret

    .globl do_wait__i32
do_wait__i32:
    li   a7, 260
    ecall
    ret

    .globl do_pipe__u32
do_pipe__u32:
    li   a7, 222
    ecall
    ret

# do_nanosleep(ms: i32) → i32 — sleep for ms milliseconds.
    .globl do_nanosleep__i32
do_nanosleep__i32:
    li   a7, 101
    ecall
    ret

# do_unlink(path_addr: u32) → i32 — remove a file. path_addr points
# at a length-prefixed byte block (String / StringLiteral layout);
# kernel/vfs.tc vfs_unlink reads the count from the header.
    .globl do_unlink__u32
do_unlink__u32:
    li   a7, 87
    ecall
    ret

# do_mux_enable(on: i32) → void — toggle UART frame multiplexing.
# See docs/task/uart_multiplex.md.
    .globl do_mux_enable__i32
do_mux_enable__i32:
    li   a7, 250
    ecall
    ret

# do_readdir(path_addr, buf_addr, buf_size) → bytes_written / -1.
# Writes NUL-terminated directory entry names into buf.
    .globl do_readdir__u32__u32__i32
do_readdir__u32__u32__i32:
    li   a7, 89
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

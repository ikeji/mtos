#
# task_crt0.s — startup for guest tasks running under the kernel
#
# Calling convention from kernel:
#   sp = task stack top (set by kernel)
#   a0, a1 = reserved for future use (arena addr/size)
#
# gp is set by _start via PC-relative la (works because the task binary
# is executed in-place from RAM on virt). For Pico 2 (Flash execution with
# SRAM data), the kernel will need to set gp before jumping here.
#
# Uses ecall for syscalls (write/read/exit), handled by kernel trap handler.
#
    .text
    .globl _start
_start:
    # Kernel sets: sp, gp, a0 (arena addr), a1 (arena size)
    call __runtime_init__u32__i32
    call main
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

    .globl do_exit__i32
do_exit__i32:
    li   a7, 93
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

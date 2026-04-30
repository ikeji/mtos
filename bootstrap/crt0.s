/* crt0.s — startup + syscall stubs for bare-metal RISC-V Linux */
    .text
    .globl _start
_start:
    la   sp, __stack_end
    call main
    /* exit(a0) */
    li   a7, 93
    ecall
1:  j    1b

/* Raw syscall stubs: TinyC calling convention (args in a0-a7) */
/* These have mangled names matching TinyC's typecheck registration */

    .globl do_write__i32__u32__i32
do_write__i32__u32__i32:
    /* a0=fd, a1=buf_addr, a2=len → SYS_write(64) */
    li   a7, 64
    ecall
    ret

    .globl do_read__i32__u32__i32
do_read__i32__u32__i32:
    /* a0=fd, a1=buf_addr, a2=len → SYS_read(63) */
    li   a7, 63
    ecall
    ret

    .globl do_exit__i32
do_exit__i32:
    /* a0=code → SYS_exit(93) */
    li   a7, 93
    ecall
    ret

    /* openat / close — needed by asm_pass1's dead-strip 2nd source
     * pass when invoked with an argv source path. Linux ABI uses
     * NUL-terminated path; TC strings are [u32 count][bytes][NUL]
     * so skipping the count prefix gets a valid C string. */
    .globl do_openat__i32__String__i32
do_openat__i32__String__i32:
    addi a1, a1, 4
    li   a3, 0
    li   a7, 56
    ecall
    ret

    .globl do_close__i32
do_close__i32:
    li   a7, 57
    ecall
    ret

    .bss
    .align 4
    .space 8192
__stack_end:

/* crt0.s — minimal startup for bare-metal / Linux riscv32 */
    .section .text.init
    .globl _start
_start:
    .option push
    .option norelax
    la   gp, __global_pointer$
    .option pop
    la   sp, __stack_end
    call main
    # exit(result)
    li   a7, 93       /* __NR_exit */
    ecall
    /* should not reach here */
1:  j    1b

    .bss
    .align 4
    .space 8192
__stack_end:

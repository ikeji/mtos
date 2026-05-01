/* crt0.s — startup + syscall stubs for bare-metal RISC-V Linux.
 *
 * Process startup state (Linux RISC-V ABI):
 *   sp[0] = argc (32-bit)
 *   sp[4..] = argv[0], argv[1], ..., argv[argc-1] (C-strings)
 *   sp[4*(argc+1)] = NULL terminator
 *   ... envp follows
 *
 * We build a TC StringArray from argv via _build_argv_stringarray
 * (in runtime_syscall.c) so `fn main(argv: StringArray)` works under
 * qemu-riscv32. Programs that only define `fn main()` get the dispatch
 * to `main__StringArray` resolved by asm-pass1's last-wins symbol
 * rules — task_crt0.s has a fallback stub that tail-calls main. The
 * host crt0 is C-runtime-only (no fallback stubs), so we call the
 * mangled name only when the program actually defined it; for plain
 * main, we go to `main` directly. We pick the right one via a small
 * trampoline label scheme below.
 */
    .text
    .globl _start
_start:
    /* Snapshot argc/argv from the kernel-provided stack before
     * relocating sp to our managed __stack_end. */
    lw   a0, 0(sp)        /* argc = sp[0] */
    addi a1, sp, 4        /* argv = &sp[1] */
    la   sp, __stack_end
    /* Build TC StringArray on the heap. Returns ptr in a0. */
    call _build_argv_stringarray
    /* Call main__StringArray with the built argv. The fallback (when
     * the program only defines `fn main()`) is handled by aliasing
     * main__StringArray to main at link time via the .weak directive
     * below. */
    call main__StringArray
    /* exit(a0) */
    li   a7, 93
    ecall
1:  j    1b

    /* Weak alias so plain `fn main()` programs link without
     * defining main__StringArray. The asm-pass1 link order has the
     * program's symbol last; if it defines main__StringArray, that
     * overrides. If it only defines main, the weak fallback below
     * tail-calls main (a0 = StringArray, ignored by argv-unaware
     * main since RISC-V callees just don't read unused args). */
    .weak main__StringArray
main__StringArray:
    j    main

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

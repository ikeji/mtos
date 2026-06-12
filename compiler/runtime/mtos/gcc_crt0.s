#
# gcc_crt0.s — startup for GCC-compiled guest tasks running under the kernel.
#
# Phase 0 minimum: hands control to main(0, NULL) and exits on return.
# Works for any task whose only data lives in .rodata (PC-relative
# reachable from .text) plus stack-local variables — gcc_hello fits.
#
# Phase 0.5 TODO before doomgeneric: real .data copy + .bss zero +
# libc heap init + argv unpack. The hard part isn't the crt0 asm — it's
# that GCC under -fPIE + linker relaxation either folds gp-relative
# global stores into zero-relative absolutes (broken because RAM
# isn't at VMA 0 at runtime) or falls back to PC-relative GOT loads
# (broken because we have no dynamic linker to populate a GOT).
# The likely fix is a load-time relocation pass: link with
# --emit-relocs, append R_RISCV_RELATIVE entries to the .bin, and
# have the kernel apply them when load_fd builds the task frame.
# See docs/task/doom_port.md Phase 0.5 for the design sketch.
#
# Kernel-passed regs on entry (matches task_crt0.s):
#   sp = task stack top
#   gp = ram_base + 0x800
#   a0 = arena addr, a1 = arena size, a2 = argv StringArray ptr (or 0)
#
    .section .text.start, "ax", @progbits
    .globl _start
_start:
    li   a0, 0                  # argc = 0
    li   a1, 0                  # argv = NULL
    call main
    li   a7, 93                 # sys_exit(rc)
    ecall
.Lhang:
    j    .Lhang

#
# gcc_crt0.s — startup for GCC-compiled guest tasks running under the kernel.
#
# Phase 0 minimal version: just jumps into main(argc=0, argv=NULL) after
# the kernel hands us control. No .data copy, no .bss zero, no argv
# unpack — adding those needs explicit gp-relative addressing for the
# libc shim's globals (the linker would otherwise resolve them to
# absolute VMA 0, which is wrong because the kernel allocates RAM at
# a per-task address and only signals it via gp = ram_base + 0x800).
#
# Smoke-test tasks (gcc_hello) don't touch any RW globals — their only
# data is a string literal in .rodata reached via PC-relative loads,
# so this stripped crt0 is enough to prove the kernel ABI + linker +
# objcopy pipeline.
#
# A future revision will:
#   * mark g_argv / g_heap_* as .sdata/.sbss (-msmall-data-limit)
#   * copy .data from binary LMA to gp-relative RAM
#   * zero .bss in RAM
#   * call _libc_init_heap(arena, size)
#   * call _libc_unpack_argv to populate g_argv
#
# Kernel-passed regs on entry (matches task_crt0.s):
#   a0 = arena addr, a1 = arena size, a2 = argv StringArray ptr (or 0)
#
    .text
    .globl _start
_start:
    li   a0, 0                  # argc = 0 (phase 0 smoke ignores argv)
    li   a1, 0                  # argv = NULL
    call main
    li   a7, 93                 # sys_exit
    ecall
.Lhang:
    j    .Lhang

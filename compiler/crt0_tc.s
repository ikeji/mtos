#
# crt0_tc.s — startup code for tc runtime pipeline
# Text section: _start + syscall/peek/poke stubs
# Data/BSS sections are in crt0_tc_data.s (must be linked AFTER all code)
#
    .text
    .globl _start
_start:
    # Linux RISC-V process startup: sp[0] = argc, sp[4..] = argv
    # pointer array (each entry → NUL-terminated string in argv data).
    # Save the pair into callee-saved s0/s1 before any TC call so we
    # still have them post-runtime-init.
    lw   s0, 0(sp)                 # s0 = argc
    addi s1, sp, 4                 # s1 = argv_ptr (pointer to argv[0])
    la   gp, __global_pointer$
    la   a0, __arena
    li   a1, 4648960
    call __runtime_init__u32__i32
    # Build the TC StringArray view of argv on the heap (runtime.tc),
    # then dispatch through main__StringArray. Programs that only
    # define `fn main()` get the fallback below, which tail-calls
    # main and ignores the StringArray in a0 (RISC-V callees don't
    # touch unused arg regs).
    mv   a0, s0
    mv   a1, s1
    call _build_argv__i32__u32
    call main__StringArray
    li   a7, 93
    ecall
1:  j    1b

# Fallback main__StringArray: tail-calls plain `main`. asm_pass1's
# last-wins symbol merge replaces this stub with the program's own
# definition when it exists; otherwise plain-main programs link
# cleanly via the j main hop.
    .globl main__StringArray
main__StringArray:
    j    main

#
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

# do_openat / do_close for Gen2/Gen3 host so asm_pass1 + asm_pass2 +
# asm_pass3 can read sources and emit per-section .bin / .lab / .idx
# files. Linux openat ABI: (dirfd, path*, flags, mode). We pass
# mode=0644 because flags coming from TC code include O_CREAT for
# every new output file (idx/text.bin/rodata.bin/data.bin/reloc/lab/
# out) — without an explicit non-zero mode the kernel sets the new
# inode's permissions from `mode & ~umask`, where mode=0 produces a
# 000 (no-permission) file. The next pass then fails with EACCES on
# read. AT_FDCWD = -100 lets the caller use plain "foo.s" without
# path resolution.
    .globl do_openat__i32__String__i32
do_openat__i32__String__i32:
    # a0=dirfd, a1=path_addr (4-byte length prefix), a2=flags
    # Linux openat takes a NUL-terminated C string; our String layout
    # has [u32 count][bytes...] but the bytes after count are ASCII
    # and we'll add a NUL when staging path strings (see callers).
    addi a1, a1, 4              # skip count prefix → bytes pointer
    li   a3, 0x1a4              # mode = 0644 (rw-r--r--)
    li   a7, 56
    ecall
    ret

    .globl do_close__i32
do_close__i32:
    li   a7, 57
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

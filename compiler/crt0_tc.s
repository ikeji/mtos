#
# crt0_tc.s — startup code for tc runtime pipeline
# Text section: _start + syscall/peek/poke stubs
# Data/BSS sections are in crt0_tc_data.s (must be linked AFTER all code)
#
    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    la   a0, __arena
    li   a1, 4648960
    call __runtime_init__u32__i32
    call main
    #
    li   a7, 93
    ecall
1:  j    1b

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

# do_openat / do_close for Gen2/Gen3 host so asm_pass1 can re-read
# the source file when given a path argument (dead-strip 2nd pass).
# Linux openat ABI: (dirfd, path*, flags, mode). We pass mode=0 since
# the kernel ignores it for read-only opens. AT_FDCWD = -100 lets the
# caller use plain "foo.s" without path resolution.
    .globl do_openat__i32__String__i32
do_openat__i32__String__i32:
    # a0=dirfd, a1=path_addr (4-byte length prefix), a2=flags
    # Linux openat takes a NUL-terminated C string; our String layout
    # has [u32 count][bytes...] but the bytes after count are ASCII
    # and we'll add a NUL when staging path strings (see callers).
    addi a1, a1, 4              # skip count prefix → bytes pointer
    li   a3, 0                  # mode = 0
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

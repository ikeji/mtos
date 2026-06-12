#
# gcc_crt0.s — startup for GCC-compiled guest tasks running under the kernel.
#
# Kernel entry contract (matches task_crt0.s for TC tasks):
#   sp = task stack top
#   gp = ram_base + 0x800   (linker sets __global_pointer$ to match)
#   a0 = arena addr
#   a1 = arena size
#   a2 = argv StringArray ptr (or 0 if no argv)
#
# The linker script lays out text + rodata + data + bss as one
# contiguous LOAD segment with .bss emitted as zero bytes in the
# binary. The kernel just copies the whole binary into RAM at some
# address; -fPIE PC-relative addressing handles the runtime
# relocation since text and data move together.
#
# That eliminates two startup steps the TC crt0 still needs:
#   - .data copy LMA → VMA (not needed: .data is already at its
#     runtime address when the binary lands in RAM)
#   - .bss zero (not needed: the linker baked the zeros into the
#     binary, so the kernel's image copy already zeroed it)
#
# Bootstrap is therefore just:
#   1. tp = arena addr (libc reads heap state through tp; first
#      16 bytes of arena hold base/brk/end).
#   2. _libc_init_heap(arena + 16, arena_size - 16).
#   3. Allocate stack-local argv[ARGV_MAX+1] and unpack the kernel
#      StringArray into it. Stack-local sidesteps the binutils
#      gp-relax address-of quirk: stack alloc is `addi a0, sp, off`,
#      which doesn't need linker relaxation to work after relocation.
#   4. main(argc, argv); sys_exit on return.
#
    .section .text.start, "ax", @progbits
    .globl _start
_start:
    # Save kernel-passed args across the bootstrap calls.
    mv   s0, a0                              # s0 = arena addr
    mv   s1, a1                              # s1 = arena size
    mv   s2, a2                              # s2 = argv StringArray ptr

    # ----- gp setup -----
    # The kernel hands us gp = arena_base + 0x800, which points into
    # the per-task arena (a separate kmalloc block). gcc-compiled code
    # expects gp to point at __global_pointer$ INSIDE the binary
    # image (= __data_start + 0x800), so any gp-relative-relaxed
    # access lands on a real .data / .sdata symbol. Use lla to pick
    # up the runtime address of __global_pointer$ via PC-relative
    # arithmetic — that works at any load address.
.option push
.option norelax
    lla  gp, __global_pointer$
.option pop

    # ----- Hand libc a stable pointer to the heap-state block -----
    # tp = arena addr. The first 16 bytes of the kernel-provided
    # arena hold [base:u32][brk:u32][end:u32][pad:u32]; libc reads
    # and writes through tp directly.
    mv   tp, s0

    # ----- Initialise libc heap from (arena + 16, arena_size - 16) -----
    addi a0, s0, 16
    addi a1, s1, -16
    call _libc_init_heap

    # ----- Allocate stack-local argv[ARGV_MAX+1] and unpack -----
    # (ARGV_MAX+1) * sizeof(char*) = 33 * 4 = 132 bytes, rounded up
    # to 144 for 16-byte stack alignment (RISC-V psABI).
    addi sp, sp, -144
    mv   s4, sp                              # s4 = argv buffer
    mv   a0, s2
    mv   a1, s4
    call _libc_unpack_argv_to                # → argc in a0
    mv   a1, s4

    call main

    addi sp, sp, 144

    # main returned — sys_exit(rc).
    li   a7, 93
    ecall
.Lhang:
    j    .Lhang

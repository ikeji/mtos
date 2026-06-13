#
# gcc_crt0_pico2.s — startup for GCC-compiled guest tasks on Pico 2
# (RP2350) with flash XIP for text + rodata.
#
# Lives at flash 0x10100000+ (per gcc_task_pico2.ld) and runs in place.
# Before main can run, we have to:
#
#   1. Copy .data + .got from their flash LMA (just past .rodata in
#      the binary) to their SRAM VMA. picolibc's GOT entries hold
#      absolute SRAM addresses that only resolve correctly once the
#      table sits at __data_start + .data_size.
#   2. Zero .bss in SRAM. Unlike the qemu virt build, .bss stays
#      NOLOAD on the pico2 layout — the binary doesn't carry zero
#      bytes for it (saves ~240 KB of flash), so the responsibility
#      shifts to crt0.
#   3. Repoint gp at the binary's own __global_pointer$. The kernel
#      hands us gp pointing into the per-task arena, which is wrong
#      for any gp-relative access in our linked code.
#   4. Stash arena address in tp so gcc_libc can read/write the heap
#      state block through tp.
#   5. Run main with (argc, argv) unpacked from the kernel's
#      StringArray.
#
# Kernel entry contract:
#   sp = task stack top
#   gp = ram_base + 0x800     (kernel default; we override with lla)
#   a0 = arena addr
#   a1 = arena size
#   a2 = argv StringArray ptr (or 0)
#
    .section .text.start, "ax", @progbits
    .globl _start
_start:
    # Save kernel-passed args; the data copy / bss zero loops clobber
    # the temp registers but not s*.
    mv   s0, a0                              # s0 = arena addr
    mv   s1, a1                              # s1 = arena size
    mv   s2, a2                              # s2 = argv StringArray ptr

    # ----- gp setup -----
    # SRAM addresses use absolute lui+addi (NOT lla/auipc), because
    # PC-relative addressing from flash text to SRAM data only
    # produces the correct address when text lives at its link-time
    # flash VMA. Once the kernel starts placing the binary at
    # mtfs-determined flash offsets, the runtime PC differs and PCREL
    # math points into garbage. Absolute lui+addi uses the linker
    # symbol's value directly, so it stays correct regardless of where
    # text was loaded.
.option push
.option norelax
    lui  gp, %hi(__global_pointer$)
    addi gp, gp, %lo(__global_pointer$)
.option pop

    # ----- Copy .data from flash LMA → SRAM VMA -----
    # __data_lma IS inside flash with the text, so PC-relative lla
    # naturally tracks wherever text was loaded. __data_start and
    # __data_size are an SRAM address and a pure constant, so they
    # use the absolute (lui+addi or lui+lo) idiom.
    lla  t0, __data_lma                      # t0 = src (flash, PC-rel)
    lui  t1, %hi(__data_start)
    addi t1, t1, %lo(__data_start)           # t1 = dst (SRAM, absolute)
    lui  t3, %hi(__data_size)
    addi t3, t3, %lo(__data_size)
    beqz t3, .Ldata_done
    add  t2, t1, t3                          # t2 = end of copy
.Ldata_copy:
    lw   t4, 0(t0)
    sw   t4, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    bltu t1, t2, .Ldata_copy
.Ldata_done:

    # ----- Zero .bss + .sbss (all in SRAM, absolute addressing) -----
    lui  t0, %hi(__bss_start)
    addi t0, t0, %lo(__bss_start)
    lui  t3, %hi(__bss_size)
    addi t3, t3, %lo(__bss_size)
    beqz t3, .Lbss_done
    add  t1, t0, t3
.Lbss_clear:
    sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, .Lbss_clear
.Lbss_done:

    # ----- Hand libc a stable pointer to the heap-state block -----
    mv   tp, s0
    addi a0, s0, 16
    addi a1, s1, -16
    call _libc_init_heap

    # ----- Allocate stack-local argv[ARGV_MAX+1] and unpack -----
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

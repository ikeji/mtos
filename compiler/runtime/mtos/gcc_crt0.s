#
# gcc_crt0.s — startup for GCC-compiled guest tasks running under the kernel.
#
# Kernel entry contract (matches task_crt0.s for TC tasks):
#   sp = task stack top
#   gp = ram_base + 0x800   (== __global_pointer$ at link time)
#   a0 = arena addr (= ram_base + 0x1000)
#   a1 = arena size
#   a2 = argv StringArray ptr (or 0 if no argv)
#
# Runtime data layout (kernel-allocated, max 4 KB):
#   ram_base + 0x000 .. + 0x1000   .data + .sdata + .bss + .sbss
#                                  (all within ±2 KB of gp)
#   ram_base + 0x1000 ..           task arena (sbrk pool)
#
# Bootstrap:
#   1. Copy .data + .sdata from binary LMA → RAM (gp - 0x800).
#      lla picks up __data_lma PC-relatively, gp gives the runtime
#      destination. __data_size is a linker-emitted constant; we load
#      it via lui+addi instead of an `la` so the relocation produces
#      an immediate value, not an address.
#   2. Zero .bss + .sbss starting where .data ended in RAM, length
#      __bss_size (same trick).
#   3. Hand the kernel arena to the libc shim's bump allocator.
#   4. Allocate (ARGV_MAX + 1) * 4 = 132 bytes on the task stack and
#      translate the kernel StringArray into it via
#      _libc_unpack_argv_to. Stack-local argv sidesteps the address-of
#      relaxation hole (binutils gp-relaxer only folds direct loads
#      and stores into gp-rel form; the auipc+addi pair the compiler
#      emits for `&g_argv` is left as-is even when the target is in
#      range, which would crash a flash-loaded task that takes the
#      address of a global). g_heap_* are only ever touched via
#      load/store so they relax fine.
#   5. main(argc, argv); sys_exit on return.
#
    .section .text.start, "ax", @progbits
    .globl _start
_start:
    # Save kernel-passed args across the bootstrap calls.
    mv   s0, a0                              # s0 = arena addr
    mv   s1, a1                              # s1 = arena size
    mv   s2, a2                              # s2 = argv StringArray ptr

    # ----- Copy .data from binary LMA → RAM VMA -----
    # lla forces auipc+addi (PC-relative) instead of la's PIE-mode
    # GOT-indirect form — __data_lma lives in the loaded binary, no
    # dynamic linker to populate a GOT entry for us.
    lla  t0, __data_lma                      # PC-rel: data in binary
    addi t1, gp, -0x800                      # gp-rel: data start in RAM
    lui  t3, %hi(__data_size)                # link-time constant
    addi t3, t3, %lo(__data_size)
    beqz t3, .Ldata_done
    add  t2, t1, t3                          # t2 = data end in RAM
.Ldata_copy:
    lw   t4, 0(t0)
    sw   t4, 0(t1)
    addi t0, t0, 4
    addi t1, t1, 4
    bltu t1, t2, .Ldata_copy
.Ldata_done:

    # ----- Zero .bss + .sbss -----
    # t1 already points at __data_end after the copy loop; .bss
    # starts immediately after .data in the gcc_task.ld layout, so
    # reuse it as bss_start with no recomputation.
    mv   t0, t1
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
    # tp = &__heap_state. The bss-clear loop above already zeroed
    # those 12 bytes; libc's _sbrk treats `brk == 0` as "uninit",
    # which gets fixed up by _libc_init_heap immediately below.
    # Using tp sidesteps the binutils relaxer entirely: every heap
    # access in libc becomes `lw/sw rd, off(tp)` with no link-time
    # fixup needed.
    #
    # The offset is hardcoded -0x7FC = `__heap_state - __global_pointer$`:
    # the linker script lays __heap_state at __bss_start + 4 and
    # __global_pointer$ at __data_start + 0x800, with __bss_start ==
    # __data_start, so the math is constant. The linker script also
    # asserts this so a future layout shuffle can't silently desync.
    addi tp, gp, -0x7FC

    # ----- Initialise libc heap from the kernel-provided arena -----
    mv   a0, s0
    mv   a1, s1
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

# kernel/platform/tn20k/platform_tn20k.s — Tang Nano 20K (hw/ SoC) platform code
#
# The hw/ SoC mirrors qemu virt's memory map (UART 16550 @ 0x10000000,
# CLINT @ 0x02000000, exit device @ 0x100000), so this is platform_virt.s
# with the RAM size changed: 8 MB of SDRAM at 0x80000000..0x80800000.
# The kernel arena is whatever is left between the end of .bss and the
# 64 KB kernel stack at the top, computed at boot.
# Used together with kernel/src/trap_common.s and crt0_tn20k_data.s.

    .text
    .globl _start
_start:
    la   gp, __global_pointer$
    li   sp, 0x80800000
    # Zero everything above the loaded image (.bss + free RAM) up to the
    # RAM top. qemu hands us zeroed RAM and pico2's crt0 clears its SRAM;
    # the SoC's SDRAM is garbage at power-up and the kernel relies on
    # zero-initialised .bss. ~2M words x ~8 clocks = ~0.6 s at 27 MHz.
    la   t0, _trap_frame          # first .bss label (crt0_tn20k_data.s)
    li   t1, 0x80800000
1:  sw   zero, 0(t0)
    addi t0, t0, 4
    bltu t0, t1, 1b
    la   a0, __arena
    li   a1, 0x807F0000           # arena end = RAM top - 64 KB stack
    sub  a1, a1, a0
    call __runtime_init__u32__i32
    la   t0, _trap_frame
    csrw 0x340, t0
    la   t0, _trap_entry
    csrw 0x305, t0
    call main
    j    _park                    # explicit ref: keeps _park live (docs/problem.md #46)
_park:
    li   t0, 0x100000
    li   t1, 0x5555
    sw   t1, 0(t0)
1:  j    1b

# ===== Set kernel gp (called from trap_common.s) =====
    .globl _set_kern_gp
_set_kern_gp:
    la   gp, __global_pointer$
    ret

# ===== Kernel runtime stubs =====
# UART helpers live in kernel/platform/virt/platform_virt.tc (shared).
    .globl do_exit__i32
do_exit__i32:
    j    _park

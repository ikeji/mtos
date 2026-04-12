# pico2/crt0_pico2_data.s — Pico 2 pool metadata / arena
#
# Concatenated at the END of the asm stream in compile-pico2.sh so that
# these labels end up in their respective sections after asm.tc's
# section-reordering linker pass.
#
# - __pool_sizes / __pool_counts go in .rodata (Flash-resident constants,
#   referenced via PC-relative `la` from text).
# - __pool_free / __pool_base / __pool_end / __pools_ready / __arena go
#   in .bss (SRAM-resident, zero-initialised by crt0_pico2.s, referenced
#   via gp-relative `la`). Their intra-bss offsets stay within ±2KB of gp.
#
# Pool sizes match runtime.tc's NPOOLS=17. __arena is 256 KB which fits
# comfortably in the 512 KB SRAM window crt0_pico2.s zeros on boot.

    .section .rodata
    .align 2
    .globl __pool_sizes
__pool_sizes:
    .word 16
    .word 32
    .word 64
    .word 128
    .word 256
    .word 512
    .word 1024
    .word 2048
    .word 4096
    .word 8192
    .word 16384
    .word 32768
    .word 65536
    .word 131072
    .word 262144
    .word 524288
    .word 1048576

    .globl __pool_counts
__pool_counts:
    # Pico 2 has ~260 KB available for the arena (we zero 0x20000000..
    # 0x20080000 = 512 KB at boot, minus ~208 B of metadata and the
    # 256 KB arena itself). Small buckets get most of the count, large
    # buckets are mostly 0 so they don't consume SRAM.
    .word 256    # 16 B     * 256  = 4096 B
    .word 512    # 32 B     * 512  = 16384 B
    .word 64     # 64 B     * 64   = 4096 B
    .word 32     # 128 B    * 32   = 4096 B
    .word 16     # 256 B    * 16   = 4096 B
    .word 8      # 512 B    * 8    = 4096 B
    .word 4      # 1024 B   * 4    = 4096 B
    .word 2      # 2048 B   * 2    = 4096 B
    .word 1      # 4096 B   * 1    = 4096 B
    .word 0      # 8192 B
    .word 0      # 16384 B
    .word 0      # 32768 B
    .word 0      # 65536 B
    .word 0      # 131072 B
    .word 0      # 262144 B
    .word 0      # 524288 B
    .word 0      # 1048576 B

    .section .bss
    .align 2
    .globl __pool_free
__pool_free:
    .space 68                    # 17 words
    .globl __pool_base
__pool_base:
    .space 68
    .globl __pool_end
__pool_end:
    .space 68
    .globl __pools_ready
__pools_ready:
    .space 4
    .globl __arena
__arena:
    .space 262144                # 256 KB

    # NOTE: no __stack_end here. crt0_pico2.s sets sp with a literal
    # `li sp, 0x20082000` (SRAM top) because stack lives above the
    # zero-init region, far outside the gp-relative ±2KB window that
    # any `la sp, __stack_end` would need.

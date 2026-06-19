/*
 * doom1_wad.S — embed DOOM1.WAD into the gcc_doom_pico2 task binary.
 *
 * The WAD lives in .rodata so it ends up in flash (per gcc_task_pico2.ld)
 * and is XIP-accessible at runtime. W_AddFile_Flash (w_wad.c) uses the
 * _doom1_wad_start address as the wad_file_t->mapped pointer, which
 * makes the existing W_CacheLumpNum() mmap branch return XIP-resident
 * lump pointers with zero copies — eliminating fopen + fread (and the
 * per-column SD-IO syscalls that throttled rendering to < 1 fps).
 *
 * Size: 4196020 bytes (DOOM1.WAD shareware MD5 c4fe9fd920207691a9f493668e0a2083).
 * Locked to a 4-byte alignment so 32-bit reads (LONG()/SHORT()) stay safe.
 */
    .section .rodata.doom1_wad, "a", @progbits
    .balign 4
    .global _doom1_wad_start
_doom1_wad_start:
    .incbin "DOOM1.WAD"
_doom1_wad_end:
    .global _doom1_wad_size
_doom1_wad_size:
    .word _doom1_wad_end - _doom1_wad_start

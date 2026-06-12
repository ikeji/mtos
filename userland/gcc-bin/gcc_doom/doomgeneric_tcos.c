/*
 * doomgeneric_tcos.c — TinyC-OS platform port for doomgeneric.
 *
 * Implements the six DG_* callbacks declared in doomgeneric/doomgeneric.h.
 * Phase 1 only stubs them; the actual work lands in later phases of the
 * K22 plan (docs/task/doom_port.md):
 *
 *   Phase 2 — DG_DrawFrame: scale + RGB565 convert DG_ScreenBuffer
 *             (320x200 ARGB8888 native) and band-blit to /dev/fb.
 *   Phase 3 — DG_GetKey: read /dev/kbd, map to doomkeys.h KEY_* codes.
 *   Phase 4 — Wad I/O switches over to fopen/fread via libc shim that
 *             routes to do_openat("/sd/doom1.wad"), nothing for us to
 *             do here.
 *
 * The stubs return safe defaults so the linker is happy and the game
 * loop won't crash; it just won't see input or produce visible frames.
 */

#include "doomgeneric/doomgeneric.h"

/* Forward-declare our libc-shim syscalls instead of pulling in the
   full POSIX headers — we only have a tiny subset implemented. */
extern long write(int fd, const void *buf, unsigned long n);
extern long read(int fd, void *buf, unsigned long n);
extern long close(int fd);

/* Syscall 153: do_uptime_us — microseconds since kernel boot. The TC
   userland exposes this via libtc; for GCC tasks we hit ecall directly. */
static unsigned long long _uptime_us(void)
{
    register long _a __asm__("a0") = 0;
    register long _n __asm__("a7") = 153;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_n) : "memory");
    return (unsigned long long)(unsigned long)_a;
    /* TODO: kernel returns u32 today; for game time we just need
       monotonic ms which u32 us is plenty (≈70 minutes wrap). */
}

/* Syscall 101: nanosleep. Our kernel takes (sec, nsec) split args
   the same way the Linux ABI does. */
static void _nanosleep_ms(uint32_t ms)
{
    long sec  = (long)(ms / 1000u);
    long nsec = (long)(ms % 1000u) * 1000000L;
    register long _a __asm__("a0") = sec;
    register long _b __asm__("a1") = nsec;
    register long _n __asm__("a7") = 101;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_b), "r"(_n) : "memory");
}

void DG_Init(void)
{
    /* Phase 2 will: do_openat("/dev/fb", O_WRONLY) and stash the fd.
       Phase 3 will: do_openat("/dev/kbd", O_RDONLY | O_NONBLOCK). */
}

void DG_DrawFrame(void)
{
    /* Phase 2: convert DG_ScreenBuffer (DOOMGENERIC_RESX *
       DOOMGENERIC_RESY pixel_t, ARGB8888) → RGB565, band-blit to fb. */
}

int DG_GetKey(int *pressed, unsigned char *key)
{
    /* Phase 3: pop from a kbd → DOOM keycode ring buffer.
       Return 0 when nothing is queued. */
    (void)pressed;
    (void)key;
    return 0;
}

uint32_t DG_GetTicksMs(void)
{
    return (uint32_t)(_uptime_us() / 1000ULL);
}

void DG_SleepMs(uint32_t ms)
{
    _nanosleep_ms(ms);
}

void DG_SetWindowTitle(const char *title)
{
    (void)title;   /* no window manager; nothing to do */
}

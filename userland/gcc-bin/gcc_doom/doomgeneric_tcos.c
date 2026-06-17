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
extern int  open(const char *path, int flags, ...);

/* Syscall 270: sys_uptime_us — microseconds since kernel boot. The TC
   userland exposes this via libtc; for GCC tasks we hit ecall directly. */
static unsigned long long _uptime_us(void)
{
    register long _a __asm__("a0") = 0;
    register long _n __asm__("a7") = 270;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_n) : "memory");
    return (unsigned long long)(unsigned long)_a;
    /* Kernel returns u32 us so the value wraps every ~70 minutes —
       enough for monotonic game time. */
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

/* /dev/fb mode-0 band-blit protocol: 10-byte header (x, y, w, h,
   mode as LE u16) followed by w*h u16 RGB565 pixels. The kernel
   devfs side hands the frame through the platform's display
   driver (kernel/platform/pico2/display_ili9488.tc → SPI on
   PIO2). ILI9488 panel is 480x320 in landscape; DOOM renders 320x200
   so the band lands letterboxed at x=80, y=60.

   CMAP256: DG_ScreenBuffer holds palette indices (uint8_t per pixel),
   not full ARGB. We look up the converted RGB triple from i_video.c's
   `colors[]` global, which I_SetPalette populates from PLAYPAL +
   gammatable. */
#define FB_X_OFFSET   80
#define FB_Y_OFFSET   60
#define FB_BAND_H     8
#define FB_BAND_BYTES (10 + DOOMGENERIC_RESX * FB_BAND_H * 2)

#ifdef CMAP256
/* Field order MUST match i_video.h's `struct color` bitfield layout
   on a little-endian target: { b:8, g:8, r:8, a:8 } stores bytes in
   memory as b, g, r, a. A 4-byte struct mirrors that exact byte
   order. Got this wrong in v85 (a,r,g,b order) and DG_DrawFrame's
   RGB565 conversion swapped red/green/alpha for every pixel — the
   "black square" symptom users saw with a memset(0xFF) buffer was
   actually whatever (b=255, g=255, r=255, a=?) maps to when fed
   through a (g, r, ?) channel-order conversion. */
struct _dg_color { unsigned char b, g, r, a; };
extern struct _dg_color colors[256];   /* defined in i_video.c */
#endif

static int           _fb_fd = -1;
static unsigned char _fb_band[FB_BAND_BYTES];

static void _put_u16le(unsigned char *b, int off, unsigned int v)
{
    b[off]     = (unsigned char)(v & 0xFF);
    b[off + 1] = (unsigned char)((v >> 8) & 0xFF);
}

void DG_Init(void)
{
    /* Phase 2: opens /dev/fb. Failure is non-fatal — DG_DrawFrame
       checks the fd and silently no-ops if it never opened. */
    _fb_fd = open("/dev/fb", 1 /* O_WRONLY */);

    /* Phase 3 will: do_openat("/dev/kbd", O_RDONLY | O_NONBLOCK). */
}

/* Trace counter so we can tell from UART that we're at least
   entering DG_DrawFrame. Printed every 30 calls (~1 sec at 30 fps)
   from PICO2_DG_DRAW_DEBUG to keep noise down. */
#ifdef PICO2_DG_DRAW_DEBUG
extern int printf(const char *, ...);
static unsigned _dg_frame_count = 0;
#endif

void DG_DrawFrame(void)
{
#ifdef PICO2_DG_DRAW_DEBUG
    if ((_dg_frame_count++ % 30) == 0)
        printf("[df %u]", _dg_frame_count);
#endif

    if (_fb_fd < 0 || DG_ScreenBuffer == 0)
        return;

    /* Stage 13 probe: dump the first byte we'll be shipping, so we
       can correlate against the [memset done] trace upstream. */
    {
        static int _dg_dbg_count = 0;
        if (_dg_dbg_count < 3) {
            extern int printf(const char *, ...);
            unsigned char *p = (unsigned char *)DG_ScreenBuffer;
#ifdef CMAP256
            struct _dg_color c0 = colors[0];
            struct _dg_color cff = colors[0xFF];
            printf("[DG_DrawFrame] DG[0]=0x%02x DG[100]=0x%02x col0=(%d,%d,%d) col255=(%d,%d,%d)\n",
                   p[0], p[100],
                   c0.r, c0.g, c0.b, cff.r, cff.g, cff.b);
#else
            printf("[DG_DrawFrame] DG[0]=0x%02x DG[100]=0x%02x\n",
                   p[0], p[100]);
#endif
            _dg_dbg_count++;
        }
    }

    /* Convert DG_ScreenBuffer (320x200 ARGB8888, pixel_t = uint32_t)
       to RGB565 and emit one band-blit per 8 scanlines. The band
       buffer is reused across all 25 bands to keep .bss small. */
    int by;
    for (by = 0; by < DOOMGENERIC_RESY; by += FB_BAND_H) {
        int rows = FB_BAND_H;
        if (by + rows > DOOMGENERIC_RESY)
            rows = DOOMGENERIC_RESY - by;

        _put_u16le(_fb_band, 0, FB_X_OFFSET);
        _put_u16le(_fb_band, 2, FB_Y_OFFSET + by);
        _put_u16le(_fb_band, 4, DOOMGENERIC_RESX);
        _put_u16le(_fb_band, 6, rows);
        _put_u16le(_fb_band, 8, 0);             /* mode 0 = blit */

        unsigned short *out = (unsigned short *)(_fb_band + 10);
        const pixel_t  *src = DG_ScreenBuffer + by * DOOMGENERIC_RESX;
        int            count = rows * DOOMGENERIC_RESX;
        int            i;
        for (i = 0; i < count; i++) {
#ifdef CMAP256
            /* src[i] is a palette index; convert via the colors[]
               table I_SetPalette filled from PLAYPAL. */
            struct _dg_color c = colors[src[i]];
            out[i] = (unsigned short)(((c.r & 0xF8) << 8) |
                                       ((c.g & 0xFC) << 3) |
                                       (c.b >> 3));
#else
            /* ARGB8888 → RGB565 (qemu virt / no-CMAP path) */
            pixel_t c = src[i];
            unsigned int r = (c >> 19) & 0x1F;
            unsigned int g = (c >> 10) & 0x3F;
            unsigned int b = (c >>  3) & 0x1F;
            out[i] = (unsigned short)((r << 11) | (g << 5) | b);
#endif
        }

        write(_fb_fd, _fb_band, 10 + count * 2);
    }
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

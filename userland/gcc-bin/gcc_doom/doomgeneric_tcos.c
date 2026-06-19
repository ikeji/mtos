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

/* Syscall 101: nanosleep — our kernel takes a single `ms` arg in a0
   (not the Linux struct-timespec pair). Matches the TC do_nanosleep
   stub in compiler/runtime/mtos/task_crt0.s. */
static void _nanosleep_ms(uint32_t ms)
{
    register long _a __asm__("a0") = (long)ms;
    register long _n __asm__("a7") = 101;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_n) : "memory");
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
/* LCD landscape is 480×320. DOOM renders at DOOMGENERIC_RESX×RESY;
   center it: x_offset = (480 - RESX) / 2, y_offset = (320 - RESY) / 2.
   K22 path-A dropped from 320×200 (80,60 offsets) to 256×160 to free
   22 KB .bss for the picolibc heap. */
#define FB_X_OFFSET   ((480 - DOOMGENERIC_RESX) / 2)
#define FB_Y_OFFSET   ((320 - DOOMGENERIC_RESY) / 2)
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

/* /dev/kbd backend: rising-edge ASCII bytes since last read (see
   kernel/platform/pico2/keyboard_matrix.tc::kbd_backend_read). The
   kernel only reports presses (no release / no key-hold), so
   DG_GetKey synthesises a held-down window per key by emitting a
   keydown immediately and queuing a keyup K calls later. Tap the
   physical key once, DOOM sees the key held for ~0.3 s — enough
   for ~10 tics of walking / turning. Re-press the same key while
   it is "down" simply extends the release deadline. */
static int _kbd_fd = -1;

/* Active-keys table: each active key carries the count of remaining
   DG_GetKey calls before we emit its synthetic keyup. The kernel only
   reports rising edges, so a single tap holds the key for this many
   DG_GetKey calls — re-pressing the same key while held refreshes
   the timer (mash a key to walk continuously). ~1 s of game time. */
#define _DG_ACTIVE_MAX  8
#define _DG_HOLD_CALLS  35
static unsigned char _active_key[_DG_ACTIVE_MAX];
static int           _active_left[_DG_ACTIVE_MAX];

/* Pending events: ev[0..count) holds (pressed, key) pairs that
   DG_GetKey hands back one at a time. Each kbd byte enqueues a
   single keydown; the matching keyup is scheduled via _active_*. */
#define _DG_KEY_QUEUE 16
static unsigned char _ev_pressed[_DG_KEY_QUEUE];
static unsigned char _ev_key[_DG_KEY_QUEUE];
static int _ev_head = 0;
static int _ev_tail = 0;
static int _ev_count = 0;

static void _ev_push(int pressed, unsigned char key)
{
    if (_ev_count >= _DG_KEY_QUEUE) return;
    _ev_pressed[_ev_tail] = (unsigned char)pressed;
    _ev_key[_ev_tail] = key;
    _ev_tail = (_ev_tail + 1) % _DG_KEY_QUEUE;
    _ev_count++;
}

/* Mark `key` as held. If already active, just refresh the timer. */
static void _hold_press(unsigned char key)
{
    int i;
    for (i = 0; i < _DG_ACTIVE_MAX; i++) {
        if (_active_left[i] > 0 && _active_key[i] == key) {
            _active_left[i] = _DG_HOLD_CALLS;
            return;
        }
    }
    for (i = 0; i < _DG_ACTIVE_MAX; i++) {
        if (_active_left[i] == 0) {
            _active_key[i] = key;
            _active_left[i] = _DG_HOLD_CALLS;
            return;
        }
    }
    /* table full — drop silently; press still fires (queued above). */
}

/* Tick active keys; queue a synthetic keyup for any that timed out. */
static void _hold_tick(void)
{
    int i;
    for (i = 0; i < _DG_ACTIVE_MAX; i++) {
        if (_active_left[i] > 0) {
            _active_left[i]--;
            if (_active_left[i] == 0)
                _ev_push(0, _active_key[i]);
        }
    }
}


void DG_Init(void)
{
    /* /dev/fb is opened write-only; the kernel fb backend never
       reads back. Failure is non-fatal — DG_DrawFrame silently
       no-ops if the fd never opened. */
    _fb_fd  = open("/dev/fb", 1 /* O_WRONLY */);
    _kbd_fd = open("/dev/kbd", 0 /* O_RDONLY */);
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
    /* Print every frame (rendering is so slow that 1 frame ≈ many sec) */
    printf("[df %u]", _dg_frame_count++);
#endif

    if (_fb_fd < 0 || DG_ScreenBuffer == 0)
        return;

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

/* Map an ASCII byte from /dev/kbd to a DOOM keycode (doomkeys.h).
   Returns 0 if the byte has no DOOM equivalent (caller drops it).
   Movement is WASD because the physical keymap probably won't have
   arrow keys; menu navigation also accepts wasd in DOOM. */
static unsigned char _ascii_to_doomkey(unsigned char c)
{
    switch (c) {
        case 'w': case 'W': return 0xad; /* KEY_UPARROW    */
        case 'a': case 'A': return 0xac; /* KEY_LEFTARROW  */
        case 's': case 'S': return 0xaf; /* KEY_DOWNARROW  */
        case 'd': case 'D': return 0xae; /* KEY_RIGHTARROW */
        case ' ':           return 0xa2; /* KEY_USE        */
        case 'f': case 'F': return 0xa3; /* KEY_FIRE       */
        case 0x0d:          return 13;   /* KEY_ENTER      */
        case 0x0a:          return 13;   /* LF → ENTER     */
        case 0x1b:          return 27;   /* KEY_ESCAPE     */
        case 'q': case 'Q': return 0xa0; /* KEY_STRAFE_L   */
        case 'e': case 'E': return 0xa1; /* KEY_STRAFE_R   */
        case 'y': case 'Y': return 'y';  /* menu yes       */
        case 'n': case 'N': return 'n';  /* menu no        */
        case 0x09:          return 9;    /* KEY_TAB        */
        default:            return 0;
    }
}

/* Syscall 271: sys_read_nb — like read(2) but returns -2 instead of
   yielding when no data is available. Critical for the DOOM game loop:
   read(/dev/kbd) on pico2 sleeps until a key event arrives, which
   silently hangs TryRunTics's wait loop because we never make it back
   to I_GetTime to advance. */
static long _read_nb(int fd, void *buf, unsigned long n)
{
    register long _a __asm__("a0") = (long)fd;
    register long _b __asm__("a1") = (long)buf;
    register long _c __asm__("a2") = (long)n;
    register long _s __asm__("a7") = 271;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_b), "r"(_c), "r"(_s) : "memory");
    return _a;
}

int DG_GetKey(int *pressed, unsigned char *key)
{
    /* Drain /dev/kbd into the event queue. The kernel only reports
       rising edges (one ASCII byte per press, nothing on release),
       so every byte enqueues a keydown event AND arms the synthetic
       keyup timer in _active_left so the held-key window expires
       after ~_DG_HOLD_CALLS DG_GetKey invocations. */
    if (_kbd_fd >= 0 && _ev_count + 2 <= _DG_KEY_QUEUE) {
        unsigned char buf[8];
        long n = _read_nb(_kbd_fd, buf, sizeof(buf));
        if (n > 0) {
            int i;
            for (i = 0; i < (int)n && _ev_count + 2 <= _DG_KEY_QUEUE; i++) {
                unsigned char dk = _ascii_to_doomkey(buf[i]);
                if (dk != 0) {
                    _ev_push(1, dk);
                    _hold_press(dk);
                }
            }
        }
    }
    /* Age all held keys by one DG_GetKey call. When one expires, a
       keyup event is queued for it. Only tick once per "drain cycle"
       — DOOM keeps calling DG_GetKey until it returns 0, so guarding
       with _ev_count == 0 limits us to one tick per cycle. */
    if (_ev_count == 0)
        _hold_tick();
    if (_ev_count == 0)
        return 0;
    *pressed = _ev_pressed[_ev_head];
    *key     = _ev_key[_ev_head];
    _ev_head = (_ev_head + 1) % _DG_KEY_QUEUE;
    _ev_count--;
    return 1;
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

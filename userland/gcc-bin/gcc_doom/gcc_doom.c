/*
 * gcc_doom.c — task entry for the TinyC-OS doom port.
 *
 * Hand control straight to doomgeneric_Create(), which calls our
 * DG_Init() (see doomgeneric_tcos.c) and then enters D_DoomMain() —
 * the latter never returns, so the only path back here is a fatal
 * Error_Printf() / I_Quit() from inside the game.
 *
 * Boot command (eventual): /bin/gcc_doom /sd/doom1.wad
 */

#include <stdlib.h>
#include <string.h>

#include "doomgeneric/doomgeneric.h"
#include "doomgeneric/doomtype.h"
#include "doomgeneric/v_patch.h"
#include "doomgeneric/w_wad.h"

void doomgeneric_Create(int argc, char **argv);
extern void V_DrawPatch(int x, int y, patch_t *patch);

/* When run with no `-iwad`, point doomgeneric at the WAD we expect to
   be sitting on the SD card. Saves the user from typing the full path
   at the sh prompt every time. The argv we hand to doomgeneric_Create
   is a fixed-size local array (8 slots is plenty — DOOM tops out
   around four interesting flags in our config). */
int main(int argc, char **argv)
{
    char *new_argv[8];
    int new_argc = 0;

    new_argv[new_argc++] = argc > 0 ? argv[0] : (char *)"gcc_doom";

    int has_iwad = 0;
    for (int i = 1; i < argc && new_argc < 6; i++) {
        new_argv[new_argc++] = argv[i];
        if (argv[i][0] == '-' && argv[i][1] == 'i' && argv[i][2] == 'w'
            && argv[i][3] == 'a' && argv[i][4] == 'd' && argv[i][5] == 0) {
            has_iwad = 1;
        }
    }
    if (!has_iwad && new_argc + 2 <= 8) {
        new_argv[new_argc++] = (char *)"-iwad";
        new_argv[new_argc++] = (char *)"/sd/doom1.wad";
    }
    /* K22 Phase 6 stage 12 probe: tried -warp 1 1 to autostart E1M1 —
       P_SetupLevel allocates ~17 KB blockmap (PU_STATIC) + ~7 KB of
       PU_LEVEL data, then dies on the next 1892-byte alloc because
       the 112 KiB zone is fragmented past the point where a fresh
       map fits. Sticking to the title-screen path (no -warp) until
       either zone grows or more PU_LEVEL allocs move to .bss. */

    doomgeneric_Create(new_argc, new_argv);

    {
        extern long write(int, const void *, unsigned long);
        write(1, "[AFTER_CREATE]\n", 15);
    }

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* K22 Phase 6 stage 12: draw TITLEPIC into DG_ScreenBuffer once.
       First lay down a palette-bar fallback so we can tell from the
       LCD whether the TITLEPIC path actually ran (full image vs.
       horizontal bars vs. all-black). */
    {
        int y, x;
        unsigned char *bb = (unsigned char *)DG_ScreenBuffer;
        for (y = 0; y < 200; y++) {
            unsigned char idx = (unsigned char)((y * 256) / 200);
            for (x = 0; x < 320; x++)
                bb[y * 320 + x] = idx;
        }
    }
    {
        extern long write(int, const void*, unsigned long);
        char dbg[160];
        int dn;
        int lump = W_CheckNumForName("TITLEPIC");
        dn = snprintf(dbg, sizeof(dbg),
                      "[paint] enter lump=%d DG=%p\n",
                      lump, (void *)DG_ScreenBuffer);
        write(1, dbg, (unsigned long)dn);
        if (lump >= 0) {
            int sz = W_LumpLength(lump);
            void *buf = malloc((unsigned long)sz);
            dn = snprintf(dbg, sizeof(dbg),
                          "[paint] sz=%d buf=%p\n", sz, buf);
            write(1, dbg, (unsigned long)dn);
            if (buf != NULL) {
                W_ReadLump((unsigned int)lump, buf);
                short *hdr = (short *)buf;
                dn = snprintf(dbg, sizeof(dbg),
                              "[paint] w=%d h=%d lo=%d to=%d\n",
                              hdr[0], hdr[1], hdr[2], hdr[3]);
                write(1, dbg, (unsigned long)dn);
                V_DrawPatch(0, 0, (patch_t *)buf);
                write(1, "[paint] V_DrawPatch done\n", 25);
                free(buf);
            }
        }
    }

    /* K22 Phase 6 stage 13b: paint a DOOM-themed frame around the
       letterbox once at startup. ILI9488 in landscape is 480×320;
       DOOM is 320×200 centred at (80, 60). That leaves four border
       strips:
            top    : x=0,    y=0,   w=480, h=60
            bottom : x=0,    y=260, w=480, h=60
            left   : x=0,    y=60,  w=80,  h=200
            right  : x=400,  y=60,  w=80,  h=200
       Fill each with one mode=1 blit (single RGB565 colour). Use
       DOOM red (0xF800) so the strips are unmistakable on the LCD.
       If the strips appear, the kernel fb path is alive; the 320×200
       DOOM region staying black would then point at our DG_DrawFrame
       palette / band-blit, not the kernel side. */
    {
        extern long write(int, const void *, unsigned long);
        extern int open(const char *, int, ...);
        int fd = open("/dev/fb", 1);
        if (fd >= 0) {
            /* Switch ILI9488 to landscape (MADCTL = 0x28). The
               kernel boots the panel in portrait 320×480 by default
               (kernel/platform/pico2/display_ili9488.tc line 379);
               the LCD pico2 board is physically mounted landscape so
               every previous test was being painted into the wrong
               orientation, with the band-blits overflowing the
               240-pixel wide rectangle the portrait window allowed.
               mode=3 takes one u16 (low byte is the MADCTL value). */
            {
                unsigned char m3[12];
                m3[0]=0; m3[1]=0;
                m3[2]=0; m3[3]=0;
                m3[4]=0; m3[5]=0;
                m3[6]=0; m3[7]=0;
                m3[8]=3; m3[9]=0;
                m3[10]=0x28; m3[11]=0;
                write(fd, m3, 12);
            }
            /* Each fill: u16 LE x, y, w, h, mode, color */
            #define FILL(_x, _y, _w, _h, _c) do { \
                unsigned char h[12]; \
                h[0]=(_x)&0xFF; h[1]=((_x)>>8)&0xFF; \
                h[2]=(_y)&0xFF; h[3]=((_y)>>8)&0xFF; \
                h[4]=(_w)&0xFF; h[5]=((_w)>>8)&0xFF; \
                h[6]=(_h)&0xFF; h[7]=((_h)>>8)&0xFF; \
                h[8]=1;         h[9]=0; \
                h[10]=(_c)&0xFF; h[11]=((_c)>>8)&0xFF; \
                write(fd, h, 12); \
            } while (0)
            FILL(0,   0,   480, 60,  0xF800);  /* top    red    */
            FILL(0,   260, 480, 60,  0xF800);  /* bottom red    */
            FILL(0,   60,  80,  200, 0xF800);  /* left   red    */
            FILL(400, 60,  80,  200, 0xF800);  /* right  red    */
            /* DOOM area in green via mode=1 — if THIS appears the
               band-blit (mode=0) in DG_DrawFrame is at fault; if it
               stays black, mode=1 itself doesn't reach 320×200. */
            FILL(80,  60,  320, 200, 0x07E0);  /* center green  */
            #undef FILL
            write(1, "[fbprobe border sent]\n", 22);
        } else {
            write(1, "[fbprobe open failed]\n", 22);
        }
    }
    {
        volatile unsigned char *vb = (volatile unsigned char *)DG_ScreenBuffer;
        int i;
        for (i = 0; i < 320 * 200; i++)
            vb[i] = 0xFF;
    }

    while (1) {
        doomgeneric_Tick();
    }
    return 0;
}

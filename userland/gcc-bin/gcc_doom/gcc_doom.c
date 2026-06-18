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
#include "doomgeneric/z_zone.h"

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
    /* K22 Phase 6 stage 15 probe: tried -warp 1 1 with BLOCKMAP
       pinned to .bss (p_setup.c). No Z_Malloc failure, no TRAP, but
       doomgeneric_Create never returned — `[gcc_doom] gamestate=...`
       never prints after a 2-minute wait. P_SetupLevel is probably
       hanging on one of the PU_LEVEL allocs that still goes through
       the zone (~50 KB headroom isn't enough after fragmentation),
       or an infinite loop in the level decode. Leaving the -warp
       trigger off for now; the BLOCKMAP .bss patch in p_setup.c
       still helps zone footprint when autostart eventually does
       land. */
    /* -warp 1 1 (autostart) is tantalisingly close but still hangs
       silently inside the load path after stage 15. Commented out
       so the title-screen build keeps shipping; flip on when the
       hang is debugged. */
    /* if (new_argc + 3 <= 8) {                                  */
    /*     new_argv[new_argc++] = (char *)"-warp";               */
    /*     new_argv[new_argc++] = (char *)"1";                   */
    /*     new_argv[new_argc++] = (char *)"1";                   */
    /* }                                                          */

    doomgeneric_Create(new_argc, new_argv);

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* K22 Phase 6 stage 13: flip the ILI9488 to landscape and paint a
       red letterbox border around the 320×200 DOOM area. The kernel
       boots the panel in its default portrait 320×480 orientation
       (display_ili9488.tc lcd_init line ~379); the physical LCD is
       mounted landscape on the pico2 board so every fb write before
       this point was painted into a portrait window with the
       band-blits overflowing the 240-pixel-wide visible area. The
       four border fills mark the letterbox so the DOOM image inside
       has a clear visual frame. */
    {
        extern long write(int, const void *, unsigned long);
        extern int open(const char *, int, ...);
        int fd = open("/dev/fb", 1);
        if (fd >= 0) {
            /* mode=3 sets MADCTL via the low byte of the payload u16. */
            unsigned char m3[12] = {0,0, 0,0, 0,0, 0,0, 3,0, 0x28,0};
            write(fd, m3, 12);
            /* mode=1: u16 LE x, y, w, h, mode=1, color (RGB565). */
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
            /* Saddle brown (RGB 139,69,19) → RGB565 0x8A22. DOOM-y
               leather/wood feel, easier on the eyes than pure red. */
            FILL(0,   0,   480, 60,  0x8A22);  /* top    */
            FILL(0,   260, 480, 60,  0x8A22);  /* bottom */
            FILL(0,   60,  80,  200, 0x8A22);  /* left   */
            FILL(400, 60,  80,  200, 0x8A22);  /* right  */
            #undef FILL
        }
    }

    /* K22 Phase 6 stage 14: paint TITLEPIC into DG_ScreenBuffer by
       streaming the patch one column at a time. */
#ifdef PICO2_LUMPINFO_SHRUNK
    {
        int lump = W_CheckNumForName("TITLEPIC");
        extern wad_file_t *g_lump_wad;
        extern lumpinfo_t *lumpinfo;
        if (lump >= 0 && g_lump_wad != NULL && lumpinfo != NULL) {
            unsigned int lumppos = (unsigned int)lumpinfo[lump].position;
            unsigned char hdr[8];
            W_Read(g_lump_wad, lumppos, hdr, 8);
            int pw = hdr[0] | (hdr[1] << 8);
            int ph = hdr[2] | (hdr[3] << 8);
            if (pw > 0 && pw <= 320 && ph > 0 && ph <= 200) {
                static unsigned int col_ofs[320];
                W_Read(g_lump_wad, lumppos + 8,
                       col_ofs, (unsigned long)(pw * 4));
                unsigned char *dest = (unsigned char *)DG_ScreenBuffer;
                static unsigned char colbuf[4096];
                int col;
                for (col = 0; col < pw; col++) {
                    unsigned int cofs = lumppos + col_ofs[col];
                    int max_read = ph * 2 + 64;
                    if (max_read > (int)sizeof(colbuf))
                        max_read = sizeof(colbuf);
                    W_Read(g_lump_wad, cofs, colbuf,
                           (unsigned long)max_read);
                    unsigned char *p = colbuf;
                    while (*p != 0xFF) {
                        int top = *p++;
                        int len = *p++;
                        p++;                  /* leading pad */
                        int row;
                        for (row = 0; row < len; row++) {
                            int y = top + row;
                            if (y >= 0 && y < ph)
                                dest[y * 320 + col] = p[row];
                        }
                        p += len;
                        p++;                  /* trailing pad */
                        if (p >= colbuf + sizeof(colbuf)) break;
                    }
                }
            }
        }
    }
#endif /* PICO2_LUMPINFO_SHRUNK */

    while (1) {
        doomgeneric_Tick();
    }
    return 0;
}

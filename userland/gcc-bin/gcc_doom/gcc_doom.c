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
    char *new_argv[10];
    int new_argc = 0;

    new_argv[new_argc++] = argc > 0 ? argv[0] : (char *)"gcc_doom";

    int has_iwad = 0;
    /* K22 path-A B4: drop monsters from the spawn list to keep the
       PU_LEVEL mobj count under the 12 KB zone budget. E1M1 has ~12
       monsters in skill 2 + ~125 items + 1 player; -nomonsters saves
       ~2 KB. We'd need a static mobj pool to scale further. */
    new_argv[new_argc++] = (char *)"-nomonsters";
    for (int i = 1; i < argc && new_argc < 8; i++) {
        new_argv[new_argc++] = argv[i];
        if (argv[i][0] == '-' && argv[i][1] == 'i' && argv[i][2] == 'w'
            && argv[i][3] == 'a' && argv[i][4] == 'd' && argv[i][5] == 0) {
            has_iwad = 1;
        }
    }
    if (!has_iwad && new_argc + 2 <= 10) {
        new_argv[new_argc++] = (char *)"-iwad";
        new_argv[new_argc++] = (char *)"/sd/doom1.wad";
    }
    /* K22 path-A H: drop the -warp E1M1 autostart so D_DoomMain hands
       control to D_StartTitle. The user lands on TITLEPIC + the demo
       attract loop and starts the game from the menu (Enter → Enter
       → ENTER for "New Game" / "Episode 1" / "Hurt me plenty"). */

    doomgeneric_Create(new_argc, new_argv);

    /* K22 path-A D: PICO2_DISABLE_HUD short-circuits ST_Drawer (the
       only call site for ST_doPaletteStuff → I_SetPalette), so the
       palette stays zero-init and every pixel converts to RGB565 = 0.
       Load PLAYPAL ourselves once D_DoomMain has W_Init'd the WAD.
       In a no-HUD build the per-tic palette flicker (red on damage,
       gold on item pickup) is gone, which is fine for path-A. */
    {
        extern void I_SetPalette(unsigned char *palette);
        unsigned char *p = (unsigned char *)W_CacheLumpName("PLAYPAL", 1 /* PU_STATIC */);
        if (p != 0)
            I_SetPalette(p);
    }

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* K22 path-A: flip ILI9488 to landscape. Letterbox borders are
       painted further down — after the full 320×200 TITLEPIC. */
    extern long write(int, const void *, unsigned long);
    extern int open(const char *, int, ...);
    int _fb = open("/dev/fb", 1);
    if (_fb >= 0) {
        /* MADCTL 0xE8 = MY | MX | MV | BGR — landscape with both
           row+col reversed (effectively 180° rotated vs 0x28). The
           pico2 LCD module is mounted upside-down so plain 0x28 puts
           the DOOM viewport on its head. console keeps the kernel
           default (0x48) so the text terminal layout is untouched. */
        unsigned char m3[12] = {0,0, 0,0, 0,0, 0,0, 3,0, 0xE8,0};
        write(_fb, m3, 12);
    }

    /* K22 path-A H: paint TITLEPIC into DG_ScreenBuffer (320×168) so
       D_StartTitle's PageDrawer has a real image to flip to once the
       game loop kicks in. The patch's bottom 32 rows are clipped from
       DG_ScreenBuffer (only 168 rows fit) — those rows get sent
       separately straight to /dev/fb below, then the brown letterbox
       overwrites them once the operator advances past the title. */
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
                            if (y >= 0 && y < DOOMGENERIC_RESY)
                                dest[y * 320 + col] = p[row];
                        }
                        p += len;
                        p++;                  /* trailing pad */
                        if (p >= colbuf + sizeof(colbuf)) break;
                    }
                }
                /* Re-stream the TITLEPIC bottom 32 rows directly to
                   /dev/fb. Use 4 bands of 8 rows; per band, re-decode
                   each column from XIP flash into a stack-local 8×320
                   palette-index scratch, then RGB565-convert into a
                   stack-local band buffer and write. Stack usage:
                   ~5 KB band + ~2.5 KB rows = ~7.5 KB — fits in the
                   16 KB stack. No .bss growth, no heap growth. */
                if (_fb >= 0) {
                    extern struct { unsigned char b, g, r, a; } colors[256];
                    int y_start = 244;   /* = FB_Y_OFFSET (76) + RESY (168) */
                    int by;
                    for (by = 0; by < 32; by += 8) {
                        int rows = 32 - by < 8 ? 32 - by : 8;
                        unsigned char rowbuf[8 * 320];
                        unsigned char band[10 + 8 * 320 * 2];
                        int r2;
                        for (r2 = 0; r2 < rows * 320; r2++) rowbuf[r2] = 0;
                        int yband_lo = DOOMGENERIC_RESY + by;
                        int yband_hi = yband_lo + rows;
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
                                    if (y >= yband_lo && y < yband_hi)
                                        rowbuf[(y - yband_lo) * 320 + col]
                                            = p[row];
                                }
                                p += len;
                                p++;                  /* trailing pad */
                                if (p >= colbuf + sizeof(colbuf)) break;
                            }
                        }
                        band[0] = 80;            band[1] = 0;
                        band[2] = (y_start + by) & 0xFF;
                        band[3] = (y_start + by) >> 8;
                        band[4] = 320 & 0xFF;    band[5] = 320 >> 8;
                        band[6] = rows;          band[7] = 0;
                        band[8] = 0;             band[9] = 0;
                        unsigned short *out = (unsigned short *)(band + 10);
                        int n = rows * 320;
                        int i;
                        for (i = 0; i < n; i++) {
                            unsigned char idx = rowbuf[i];
                            unsigned char R = colors[idx].r;
                            unsigned char G = colors[idx].g;
                            unsigned char B = colors[idx].b;
                            out[i] = (unsigned short)(((R & 0xF8) << 8) |
                                                       ((G & 0xFC) << 3) |
                                                       (B >> 3));
                        }
                        write(_fb, band, 10 + n * 2);
                    }
                }
            }
        }
    }
#endif /* PICO2_LUMPINFO_SHRUNK */

    /* Now paint the letterbox borders. The top/sides cover regions DOOM
       will never touch (above and outside the 320×168 viewport). The
       bottom (y∈[244,320)) intentionally goes BELOW the 32-row TITLEPIC
       extension we just wrote — leaves y∈[244,276) showing the id badge
       until the first DG_DrawFrame from D_PageDrawer overwrites... wait
       no, DG_DrawFrame only writes [76,244). y∈[244,320) stays as last
       written, so the badge survives indefinitely. Paint over it below
       y=276 with brown so a future menu transition doesn't look weird. */
    if (_fb >= 0) {
        #define FILL(_x, _y, _w, _h, _c) do { \
            unsigned char h[12]; \
            h[0]=(_x)&0xFF; h[1]=((_x)>>8)&0xFF; \
            h[2]=(_y)&0xFF; h[3]=((_y)>>8)&0xFF; \
            h[4]=(_w)&0xFF; h[5]=((_w)>>8)&0xFF; \
            h[6]=(_h)&0xFF; h[7]=((_h)>>8)&0xFF; \
            h[8]=1;         h[9]=0; \
            h[10]=(_c)&0xFF; h[11]=((_c)>>8)&0xFF; \
            write(_fb, h, 12); \
        } while (0)
        /* Saddle brown (RGB 139,69,19) → RGB565 0x8A22 */
        FILL(0,   0,   480,  76, 0x8A22);  /* top    */
        FILL(0,   276, 480,  44, 0x8A22);  /* bottom (id badge stays visible) */
        FILL(0,   76,   80, 168, 0x8A22);  /* left   */
        FILL(400, 76,   80, 168, 0x8A22);  /* right  */
        #undef FILL
    }

    while (1) {
        doomgeneric_Tick();
    }
    return 0;
}

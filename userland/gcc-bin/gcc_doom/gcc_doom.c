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
    /* K22 path-A: vertexes/segs/subsectors/sectors/nodes/sides/
       blocklinks/linebuffer/rejectmatrix all pinned to .bss in
       p_setup.c. PU_LEVEL demand drops from ~60 KB to ~mobjs only
       (~21 KB for E1M1's 138 things). DEFAULT_RAM dropped to 28 KB
       (i_system.c) to match the new ~36 KB heap. Try autostart again. */
    if (new_argc + 3 <= 10) {
        new_argv[new_argc++] = (char *)"-warp";
        new_argv[new_argc++] = (char *)"1";
        new_argv[new_argc++] = (char *)"1";
    }

    doomgeneric_Create(new_argc, new_argv);

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* K22 path-A: flip ILI9488 to landscape + paint brown letterbox.
       LCD is 480×320; DOOM at 320×168 (HUD disabled) lands at (80, 76). */
    {
        extern long write(int, const void *, unsigned long);
        extern int open(const char *, int, ...);
        int fd = open("/dev/fb", 1);
        if (fd >= 0) {
            unsigned char m3[12] = {0,0, 0,0, 0,0, 0,0, 3,0, 0x28,0};
            write(fd, m3, 12);
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
            /* Saddle brown (RGB 139,69,19) → RGB565 0x8A22 */
            FILL(0,   0,   480, 76,  0x8A22);  /* top    */
            FILL(0,   244, 480, 76,  0x8A22);  /* bottom */
            FILL(0,   76,  80,  168, 0x8A22);  /* left   */
            FILL(400, 76,  80,  168, 0x8A22);  /* right  */
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
            /* TITLEPIC is 320×200 but DG_ScreenBuffer is now 320×168.
               Clip writes to the visible band so we don't overflow. */
            if (pw > 0 && pw <= 320 && ph > 0 && ph <= 200) {
                static unsigned int col_ofs[320];
                W_Read(g_lump_wad, lumppos + 8,
                       col_ofs, (unsigned long)(pw * 4));
                unsigned char *dest = (unsigned char *)DG_ScreenBuffer;
                static unsigned char colbuf[4096];
                int max_y = DOOMGENERIC_RESY;
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
                            if (y >= 0 && y < max_y)
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

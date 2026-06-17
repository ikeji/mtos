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
    /* K22 Phase 6 stage 12 probe: tried -warp 1 1 to autostart E1M1 —
       P_SetupLevel allocates ~17 KB blockmap (PU_STATIC) + ~7 KB of
       PU_LEVEL data, then dies on the next 1892-byte alloc because
       the 112 KiB zone is fragmented past the point where a fresh
       map fits. Sticking to the title-screen path (no -warp) until
       either zone grows or more PU_LEVEL allocs move to .bss. */

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
            FILL(0,   0,   480, 60,  0xF800);  /* top    */
            FILL(0,   260, 480, 60,  0xF800);  /* bottom */
            FILL(0,   60,  80,  200, 0xF800);  /* left   */
            FILL(400, 60,  80,  200, 0xF800);  /* right  */
            #undef FILL
        }
    }

    /* K22 Phase 6 stage 14: paint TITLEPIC into DG_ScreenBuffer by
       streaming the patch one column at a time. The 68 KiB patch
       lump doesn't fit in either picolibc heap (~30 KiB after Z_Init
       takes the DOOM zone) or the DOOM zone itself (~50 KiB largest
       contiguous chunk after R_Init). Column-stream peak working
       set is ~5.5 KiB (col_ofs[320] 1.3 KiB + colbuf 4 KiB), no
       zone/heap allocation. ~320 SD reads × few hundred bytes each
       takes a couple of seconds over SPI 6 MHz; fine for a one-shot
       title draw. After this, the silent doomgeneric_Tick() loop
       below ships the same DG_ScreenBuffer contents on every frame
       (D_PageDrawer is a no-op under PICO2_TINY_HUD so DOOM never
       overwrites our paint). */
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
                    /* Read enough for one column's posts (vanilla
                       DOOM SW TITLEPIC tops out at ~210 B/col; the
                       4 KiB buffer is overkill but cheap). */
                    unsigned int cofs = lumppos + col_ofs[col];
                    int max_read = ph * 2 + 64;
                    if (max_read > (int)sizeof(colbuf))
                        max_read = sizeof(colbuf);
                    W_Read(g_lump_wad, cofs, colbuf,
                           (unsigned long)max_read);
                    /* Patch post format: topdelta, length, pad,
                       data[length], pad. End when topdelta == 0xFF. */
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

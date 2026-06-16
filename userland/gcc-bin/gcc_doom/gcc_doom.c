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

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* K22 Phase 6 stage 12: draw TITLEPIC into DG_ScreenBuffer once,
       then let the silent tick loop keep blitting it. D_PageDrawer
       is a no-op under PICO2_TINY_HUD (the vanilla path would
       W_CacheLumpName + Z_Malloc ~64 KB) so the buffer never gets
       overwritten by DOOM itself. We read the patch lump into
       picolibc malloc (heap ~150 KB so room for the ~50 KB patch
       is comfortable), V_DrawPatch through I_VideoBuffer (aliased
       onto DG_ScreenBuffer), then free the buffer. */
    {
        int lump = W_CheckNumForName("TITLEPIC");
        if (lump >= 0) {
            int sz = W_LumpLength(lump);
            void *buf = malloc((unsigned long)sz);
            if (buf != NULL) {
                W_ReadLump((unsigned int)lump, buf);
                V_DrawPatch(0, 0, (patch_t *)buf);
                free(buf);
            }
        }
    }

    while (1) {
        doomgeneric_Tick();
    }
    return 0;
}

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

#include "doomgeneric/doomgeneric.h"

void doomgeneric_Create(int argc, char **argv);

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

    doomgeneric_Create(new_argc, new_argv);

    /* K22 Phase 6: doomgeneric_Create's D_DoomLoop runs exactly one
       doomgeneric_Tick before returning — the loop is the platform's
       responsibility. Spin here so the game keeps ticking instead of
       exiting after the first frame. */
    extern void doomgeneric_Tick(void);

    /* Paint a visible "alive" pattern into DG_ScreenBuffer so we can
       confirm DG_DrawFrame is shipping real pixel data to the LCD.
       The title-screen path under PICO2_TINY_HUD makes D_PageDrawer a
       no-op, so DG_ScreenBuffer would otherwise stay at .bss-zero
       (palette index 0 = black). Horizontal palette bars cycle every
       row through every PLAYPAL entry — easy to recognize as "real
       output" on the ILI9488. */
    {
        int y, x;
        unsigned char *buf = (unsigned char *)DG_ScreenBuffer;
        for (y = 0; y < 200; y++) {
            unsigned char idx = (unsigned char)((y * 256) / 200);
            for (x = 0; x < 320; x++)
                buf[y * 320 + x] = idx;
        }
    }

    while (1) {
        doomgeneric_Tick();
    }
    return 0;
}

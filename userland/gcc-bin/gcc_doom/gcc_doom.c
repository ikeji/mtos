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

int main(int argc, char **argv)
{
    doomgeneric_Create(argc, argv);
    return 0;   /* unreachable; D_DoomMain runs forever */
}

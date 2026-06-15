#include <stdio.h>

#include "m_argv.h"

#include "doomgeneric.h"

/* K22 Phase 6: on pico2 with CMAP256, DG_ScreenBuffer is 320*200 =
   64 KB. Allocating it from picolibc malloc after Z_Init takes 108 KB
   leaves no headroom for fopen()'s FILE struct (M_FileExists fails
   silently in D_FindWADByName even though the file is on /sd). Pin
   the screen buffer to .bss so it doesn't compete with the heap. */
#if defined(CMAP256) && defined(PICO2_TINY_HUD)
static pixel_t _pico2_screen_buffer[DOOMGENERIC_RESX * DOOMGENERIC_RESY];
pixel_t* DG_ScreenBuffer = _pico2_screen_buffer;
#else
pixel_t* DG_ScreenBuffer = NULL;
#endif

void M_FindResponseFile(void);
void D_DoomMain (void);


void doomgeneric_Create(int argc, char **argv)
{
	// save arguments
    myargc = argc;
    myargv = argv;

	M_FindResponseFile();

#if !defined(CMAP256) || !defined(PICO2_TINY_HUD)
	/* Non-pico2 path keeps the original heap-allocated buffer. */
	DG_ScreenBuffer = malloc(DOOMGENERIC_RESX * DOOMGENERIC_RESY * sizeof(pixel_t));
#endif

	DG_Init();

	D_DoomMain ();
}


//
// Copyright(C) 1993-1996 Id Software, Inc.
// Copyright(C) 2005-2014 Simon Howard
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// DESCRIPTION:
//	WAD I/O functions.
//


#ifndef __W_WAD__
#define __W_WAD__

#include <stdio.h>

#include "doomtype.h"
#include "d_mode.h"

#include "w_file.h"


//
// TYPES
//

//
// WADFILE I/O related stuff.
//

typedef struct lumpinfo_s lumpinfo_t;

struct lumpinfo_s
{
    char	name[8];
#ifndef PICO2_LUMPINFO_SHRUNK
    wad_file_t *wad_file;
#endif
    int		position;
    int		size;
    void       *cache;

    // Used for hash table lookups

    lumpinfo_t *next;
};


extern lumpinfo_t *lumpinfo;
extern unsigned int numlumps;
#ifdef PICO2_LUMPINFO_SHRUNK
/* K22 Phase 5 stage 3: single-WAD pico2 build drops the per-lump
   wad_file_t* (4 B/lump) and stores the only active WAD as a
   global. With 947 lumps in the trimmed shareware IWAD that's ~3.8
   KB more picolibc heap, which is enough headroom to grow the
   Z_Init zone past R_InitTextures' per-texture allocation wall. */
extern wad_file_t *g_lump_wad;
#define LUMP_WAD(_lump_idx) g_lump_wad
#else
#define LUMP_WAD(_lump_idx) (lumpinfo[_lump_idx].wad_file)
#endif

wad_file_t *W_AddFile (char *filename);

int	W_CheckNumForName (char* name);
int	W_GetNumForName (char* name);

int	W_LumpLength (unsigned int lump);
void    W_ReadLump (unsigned int lump, void *dest);

void*	W_CacheLumpNum (int lump, int tag);
void*	W_CacheLumpName (char* name, int tag);

void    W_GenerateHashTable(void);

extern unsigned int W_LumpNameHash(const char *s);

void    W_ReleaseLumpNum(int lump);
void    W_ReleaseLumpName(char *name);

void W_CheckCorrectIWAD(GameMission_t mission);

#endif

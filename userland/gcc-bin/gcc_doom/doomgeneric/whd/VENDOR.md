# doomgeneric/whd — runtime files for the on-device WHD reader (K22 Phase 5)

This subdirectory holds the **runtime** counterpart of the host-side
`whd_gen` tool. The K22 plan is to flip our gcc_doom_pico2 build over
from raw-WAD reading (current state, dies at R_InitSpriteLumps because
DOOM pins every sprite header in PU_STATIC) to WHD-format reading, the
same compact pre-computed metadata + Huffman-compressed lumps that
rp2040-doom uses to fit Doom on the 264 KB RP2040.

This commit is **stage 0**: only the building-block files are vendored
in. No code paths reference them yet. The next stages will wire them
into our w_wad.c and replace r_data.c with rp2040-doom's r_data_whd.c.

## Upstream provenance

- Repo: https://github.com/kilograham/rp2040-doom
- Commit: `29a453c980918a03e40fc8b69b024e7a3bdb5dc2` (same snapshot as
  the host-side whd-tools vendor at
  `userland/gcc-bin/gcc_doom/whd-tools/`)
- Cloned: 2026-06-14

Byte-identical to upstream so far. Future local modifications will be
tagged with `LOCAL_MOD(K22-PhaseN)` comments and listed here.

## Files

```
whd/
  VENDOR.md           — this file
  whddata.h           — WHD on-disk format spec. Same file as
                         whd-tools/src/whddata.h; we keep two copies
                         because the host build and the device build
                         can drift independently (USE_WHD vs not).
  tiny_huff.{c,h}     — Huffman decoder. The on-device runtime needs
                         this to inflate the compressed lump payloads
                         (sprite columns, flat pixels, music).
  image_decoder.{c,h} — patch/sprite column decoder. Walks WHD's
                         column-segment format and produces a flat
                         pixel run for the renderer.
```

Deliberately NOT vendored yet:

- `r_data_whd.c` (rp2040-doom's drop-in replacement for r_data.c).
  It depends on framedrawable_t infrastructure and `whd_sprite_meta`
  globals that aren't in our tree. Bringing it across needs a coupled
  refactor of r_things.c / r_segs.c / r_bsp.c on the rp2040-doom
  side, all of which is the stage-2 work.
- `musx_decoder.{c,h}` — music decoder. `FEATURE_SOUND` is off in
  our build so the music path is unreachable.
- The rp2040-doom-side modifications to `w_wad.c` and `w_wad.h`.
  These are heavily `#if USE_WHD`-gated; we will mirror them as a
  parallel `w_wad_whd.c` so the WAD-format reader still compiles for
  the qemu virt / hello-world build of gcc_doom.

## Stage map (next steps)

**Stage 0** (this commit): vendor the runtime building blocks.

**Stage 1**: add `-DUSE_WHD=1` build switch for gcc_doom_pico2 only.
Get tiny_huff.c / image_decoder.c compiling under our gcc_libc.c
stack. Pin `PICO_BUILD` / `PICO_ON_DEVICE` correctly so the
`#include "pico.h"` blocks gate out cleanly (or stay out for now if
PICO_BUILD is defined and we don't need the FIFO sync paths).

**Stage 2**: bring in r_data_whd.c. Decide on the integration model:
  - Easy: side-by-side, `#ifdef USE_WHD` gating both r_data.c and
    r_data_whd.c so only one compiles at a time.
  - Hard but cleaner: full rp2040-doom-style refactor where
    framedrawable_t replaces texture_t* throughout r_*.c.
  Stage 2 likely picks the easy path and grows into hard later.

**Stage 3**: replace W_AddFile / W_CacheLumpNum / W_GetNumForName in
w_wad.c with whd-aware variants when USE_WHD. rp2040-doom's
modifications give us a working template (~6 #if blocks across
w_wad.c, the largest one spanning 70 lines around the lump-load
loop).

**Stage 4**: build, flash, expect DOOM to push past R_InitSpriteLumps
(which is currently the wall) into P_SetupLevel.

The host-side `whd_gen` and `wad_trim.py` are already in
`userland/gcc-bin/gcc_doom/whd-tools/`; the `doom1_e1m1.whd`
produced from the `--minimal` trim is what stage 4 reads.

## Licenses

GPLv2 for everything in this tree (same as the doomgeneric vendor —
see the project root for the LICENSE pointer). Same license summary
as the host-side `whd-tools/LICENSE.gpl2`.

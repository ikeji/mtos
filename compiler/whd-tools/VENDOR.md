# whd-tools — host-side WAD→WHD converter (K22 Phase 5)

This directory vendors **`whd_gen`**, the host-side tool from
[kilograham/rp2040-doom](https://github.com/kilograham/rp2040-doom) that
converts a Doom WAD into the compressed WHD format the rp2040-doom
runtime reads. We need it for the K22 DOOM port: `doom1.wad` (~4 MB)
won't fit on the Pico 2 alongside the kernel, but `doom1.whd` (E1M1 only,
~500 KB target) will.

This is **vendor-only at this commit** — the source tree is copied
faithfully but no build glue is in place yet. Wiring up a host build
(`make whd_gen` producing a single binary) is the next step.

## Upstream provenance

- Repo: https://github.com/kilograham/rp2040-doom
- Commit: `29a453c980918a03e40fc8b69b024e7a3bdb5dc2`
  ("rp2350 support and a minor fix")
- Cloned: 2026-06-13

The directory layout below mirrors the upstream `src/` tree exactly so
that `#include "../whddata.h"` style relative paths inside whd_gen.cpp
resolve without rewriting. If you `git diff` against an updated upstream
later, file-by-file diffs should line up.

## Layout (mirrors `rp2040-doom/`)

```
whd-tools/
  LICENSE.gpl2        — GPLv2, applies to all whd_gen + src/ code
  LICENSE.bsd_adpcm   — BSD-3-clause, applies to adpcm-xq subdir
  VENDOR.md           — this file
  src/
    whd_gen/          — main tool (whd_gen.cpp, wad.cpp/h, huff.cpp/h,
                        lodepng.cpp/h, compress_mus.cpp/h, mus2seq.cpp/h,
                        + a handful of headers: huffman.h, huff_sink.h,
                        statsomizer.h, extra_patches.h, config.h)
    doom/doomdata.h   — WAD lump structures (referenced from whd_gen)
    doom/doomdef.h    — pulled in transitively by doomdata.h
    d_mode.h          — game-mode enum, pulled in by doomdef.h
    i_timer.h         — timer API decl, pulled in by doomdef.h
    tiny_huff.{c,h}   — decoder counterpart; shared with on-device code
    musx_decoder.{c,h}
    image_decoder.{c,h}
    whddata.h         — WHD on-disk format spec (the important header)
    doomtype.h        — vanilla doom types
    adpcm-xq/
      adpcm-lib.{c,h} — ADPCM compression for sound effects
```

Files we deliberately did NOT vendor:

- `rp2040-doom/src/whd_gen/CMakeLists.txt` — superseded by our own
  build glue (TBD).
- The rest of `rp2040-doom/src/` (the runtime DOOM port) — we use
  doomgeneric as our runtime base, not rp2040-doom.
- `src/adpcm-xq/adpcm-xq.c` — that's the standalone CLI; whd_gen only
  needs the library functions in adpcm-lib.

## Licenses

- **GPLv2** (`LICENSE.gpl2`): applies to the whd_gen / src/ tree
  including doomdata.h, tiny_huff, musx_decoder, image_decoder,
  whddata.h, and all of whd_gen/. Inherited from id Software's
  original DOOM source + Chocolate Doom + rp2040-doom; we are bound
  by it for distribution. Our own DOOM glue under
  `userland/gcc-bin/gcc_doom/` is also GPLv2 (doomgeneric tree).
- **BSD-3-Clause** (`LICENSE.bsd_adpcm`): applies only to
  `src/adpcm-xq/`. David Bryant's original.

GPLv2 dominates; the combined whd_gen binary must ship under GPLv2.

## What whd_gen does

Given a `doom1.wad` input, whd_gen:

1. Parses the IWAD lump directory (wad.cpp).
2. For each map (E1M1, E1M2, ...), repacks geometry into the more
   compact whd structures defined in `whddata.h` (smaller field widths,
   indexed texture names, compressed BLOCKMAP).
3. Huffman-compresses sprite + flat + patch pixel data
   (huff.cpp + tiny_huff.c).
4. Compresses MUS music streams into MUSX (mus2seq.cpp,
   musx_decoder.c) — we don't need this since FEATURE_SOUND is off.
5. Optionally re-encodes sound effects as ADPCM
   (compress_mus.cpp + adpcm-xq) — also off.
6. Emits a single `doom1.whd` blob with a header pointing at each
   lump's compressed offset.

For our K22 path we only need steps 1-3. The MUS/ADPCM paths can be
disabled at link time once we wire up our own build, since
`doomgeneric` builds with `#undef FEATURE_SOUND`.

## Local modifications

None at this commit. Files are byte-identical to upstream
`29a453c980918a03e40fc8b69b024e7a3bdb5dc2`. If we patch any file later,
mark it with a `// LOCAL_MOD(K22-PhaseN): ...` comment and list it
here.

## Next steps

1. **Add host build glue** — `compiler/whd-tools/Makefile` or
   `build_whd_gen.sh` that produces `build/host/whd_gen` from this
   tree. Will need a `pico.h` shim since tiny_huff.c et al. include it
   for embedded targets.
2. **Strip ADPCM + MUS** to reduce build surface — define
   `IS_WHD_GEN=1` and `#undef FEATURE_SOUND` where it propagates, so
   we don't need to vendor adpcm-xq's full implementation.
3. **Trim doom1.wad to E1M1-only** before feeding to whd_gen — drop
   E1M2-M9 lumps, titlepic, intermission images. Target ~500 KB whd.
4. **Wire `doom1.whd` into our runtime** — replace doomgeneric's
   `fopen("doom1.wad")` with a whd reader that issues
   `do_openat("/sd/doom1.whd")` and caches lumps on demand. The whd
   on-disk format spec is `src/whddata.h`.
5. **Provision SD** — `mr -a /sd/doom1.whd` upload path (already in
   place for K21 self-replicate fixtures).

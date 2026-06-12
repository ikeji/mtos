# doomgeneric (vendored)

Source: https://github.com/ozkl/doomgeneric

Vendored at upstream commit `dcb7a8dbc7a16ce3dda29382ac9aae9d77d21284` ("boolean fix").

## What's included

- All `.h` files from `doomgeneric/` (97 headers)
- All `.c` files from `doomgeneric/` **except** the platform ports
  (`doomgeneric_allegro.c`, `doomgeneric_emscripten.c`,
  `doomgeneric_linuxvt.c`, `doomgeneric_sdl.c`, `doomgeneric_soso.c`,
  `doomgeneric_sosox.c`, `doomgeneric_win.c`, `doomgeneric_xlib.c`)
- Upstream `LICENSE` (GPLv2) as `LICENSE.doomgeneric`

Our port lives one directory up at `../doomgeneric_tcos.c` and implements
the six `DG_*` callbacks declared in `doomgeneric.h`.

## What's left out

- The upstream `Makefile*` variants — we drive the build from
  `userland/Makefile`.
- `doomgeneric.vcxproj` / `doomgeneric.sln` (Visual Studio project files).
- `screenshots/`.

## License

DOOM source is GPLv2. Any binary we ship that links this code inherits
the GPLv2 obligation — keep the license file in the repo and don't
remove the upstream copyright headers.

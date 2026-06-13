#!/usr/bin/env python3
"""Trim a Doom IWAD down to a single episode/map.

K22 Phase 5: shareware doom1.wad ships nine levels (E1M1..E1M9) plus
all the shared assets (textures, sprites, flats, status bar, menus,
palettes, sounds, music). We only need E1M1 on the Pico 2 — both for
flash budget and because that's the scope cap in
docs/task/doom_port.md. Drop the other eight levels' lump groups and
the per-level music we won't play, keep everything else.

WAD file format (Doom 1.9):
    Header (12 bytes)
        4    magic  "IWAD" or "PWAD" (ASCII)
        4    nlumps directory entry count
        4    diroff offset of directory table
    Lump data (variable, packed)
    Directory table (16 bytes per entry, nlumps entries)
        4    offset of lump bytes inside the WAD
        4    size in bytes
        8    name (ASCII, NUL-padded, MUST NOT NUL-terminate if 8 chars)

Level marker lumps (ExMy or MAPxx) are zero-byte entries followed by
exactly ten lumps in fixed order:
    THINGS, LINEDEFS, SIDEDEFS, VERTEXES, SEGS, SSECTORS,
    NODES, SECTORS, REJECT, BLOCKMAP

Usage:
    wad_trim.py <input.wad> <output.wad> [--keep E1M1[,...]] [--no-music]

Default `--keep` is E1M1. With multiple maps, pass `--keep E1M1,E1M2`.
`--no-music` additionally drops the intro / intermission / titlescreen
music lumps; the kept-map music lumps still survive.
"""
from __future__ import annotations
import argparse
import re
import struct
import sys
from pathlib import Path


HEADER_FMT = "<4sII"          # magic, nlumps, diroff
ENTRY_FMT = "<II8s"           # offset, size, name (8 bytes, NUL-padded)
ENTRY_SIZE = struct.calcsize(ENTRY_FMT)

LEVEL_DATA_LUMPS = (
    "THINGS", "LINEDEFS", "SIDEDEFS", "VERTEXES", "SEGS",
    "SSECTORS", "NODES", "SECTORS", "REJECT", "BLOCKMAP",
)
LEVEL_MARKER_RE = re.compile(r"^(?:E[1-4]M[1-9]|MAP\d{2})$")
MUSIC_LEVEL_RE = re.compile(r"^D_(E[1-4]M[1-9]|RUNNI[N]|STALK[S]|COUNTD|BETWEE|DOOM|E2M[1-9])$")


def lump_name(raw: bytes) -> str:
    return raw.rstrip(b"\x00").decode("ascii", errors="replace")


def parse_directory(data: bytes):
    magic, nlumps, diroff = struct.unpack_from(HEADER_FMT, data, 0)
    if magic not in (b"IWAD", b"PWAD"):
        raise SystemExit(f"not a WAD file: magic={magic!r}")
    entries = []
    for i in range(nlumps):
        off, size, name_raw = struct.unpack_from(ENTRY_FMT, data, diroff + i * ENTRY_SIZE)
        entries.append((off, size, lump_name(name_raw), name_raw))
    return magic, entries


def find_level_runs(entries):
    """Return {marker_index: [marker_index, ..., last_data_index]} for each level."""
    runs: dict[int, list[int]] = {}
    i = 0
    n = len(entries)
    while i < n:
        name = entries[i][2]
        if LEVEL_MARKER_RE.match(name) and entries[i][1] == 0:
            indices = [i]
            # Next 10 lumps are the level's data, if they match the expected names.
            for j, expected in enumerate(LEVEL_DATA_LUMPS, start=1):
                if i + j >= n:
                    break
                if entries[i + j][2] == expected:
                    indices.append(i + j)
                else:
                    break
            runs[i] = indices
            i = indices[-1] + 1
        else:
            i += 1
    return runs


def trim(input_path: Path, output_path: Path, keep_maps: set[str], drop_music: bool):
    data = input_path.read_bytes()
    magic, entries = parse_directory(data)

    runs = find_level_runs(entries)
    drop_indices: set[int] = set()
    kept_maps: set[str] = set()
    for marker_idx, lump_indices in runs.items():
        marker_name = entries[marker_idx][2]
        if marker_name in keep_maps:
            kept_maps.add(marker_name)
        else:
            drop_indices.update(lump_indices)

    missing = keep_maps - kept_maps
    if missing:
        raise SystemExit(f"requested maps not found in input WAD: {sorted(missing)}")

    if drop_music:
        # Drop per-level music for dropped maps. Music lump name is D_<map>
        # except for D_INTROA / D_INTROS / D_VICTOR etc., which we keep.
        kept_music_names = {f"D_{m}" for m in kept_maps}
        for idx, (_, _, name, _) in enumerate(entries):
            if MUSIC_LEVEL_RE.match(name) and name not in kept_music_names:
                drop_indices.add(idx)

    # Emit new WAD: header + lump bytes + directory.
    kept_entries = [e for i, e in enumerate(entries) if i not in drop_indices]
    new_dir: list[tuple[int, int, bytes]] = []
    out_lumps = bytearray()
    base_off = 12  # header
    for off, size, _name, name_raw in kept_entries:
        new_off = base_off + len(out_lumps)
        if size > 0:
            out_lumps += data[off : off + size]
        new_dir.append((new_off, size, name_raw))

    diroff = base_off + len(out_lumps)
    header = struct.pack(HEADER_FMT, magic, len(new_dir), diroff)
    dir_bytes = bytearray()
    for off, size, name_raw in new_dir:
        dir_bytes += struct.pack(ENTRY_FMT, off, size, name_raw)

    output_path.write_bytes(header + bytes(out_lumps) + bytes(dir_bytes))

    print(f"input  {input_path}: {len(entries)} lumps, {len(data):,} bytes")
    print(f"kept maps: {sorted(kept_maps)}")
    print(f"dropped {len(drop_indices)} lumps "
          f"({sum(entries[i][1] for i in drop_indices):,} bytes of payload)")
    print(f"output {output_path}: {len(new_dir)} lumps, "
          f"{output_path.stat().st_size:,} bytes")


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("input", type=Path, help="source WAD (e.g. doom1.wad)")
    p.add_argument("output", type=Path, help="trimmed WAD")
    p.add_argument("--keep", default="E1M1",
                   help="comma-separated map list to keep (default E1M1)")
    p.add_argument("--no-music", action="store_true",
                   help="also drop level music lumps for dropped maps")
    args = p.parse_args(argv)
    keep_maps = {m.strip().upper() for m in args.keep.split(",") if m.strip()}
    trim(args.input, args.output, keep_maps, args.no_music)
    return 0


if __name__ == "__main__":
    sys.exit(main())

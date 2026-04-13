#!/usr/bin/env python3
"""mkfs.py — build a MyTinyFS (mtfs) disk image.

Usage: mkfs.py <output> <rootdir>

All files and subdirectories under <rootdir> are written into the image.
Subdirectory inodes are created with the `parent` field pointing at their
enclosing directory's inode number (inode 0 = root).

See docs/filesystem.md for the on-disk layout. Block size is 512.

Layout:
    block 0                  superblock
    block 1 .. data_start-1  inode table (8 inodes per 512 B block)
    block data_start ..      file data (contiguous per file, dir inodes
                             carry start_block = 0)

Inode 0 is the root directory (fixed). Inodes 1.. are assigned in DFS
order: sibling directories/files under one parent are contiguous, and
children appear after their parent.
"""
import os
import struct
import sys

BLOCK_SIZE = 512
INODE_SIZE = 64
INODES_PER_BLOCK = BLOCK_SIZE // INODE_SIZE  # 8
MAGIC = 0x5346544D   # 'M','T','F','S' little-endian
VERSION = 1

FLAG_FILE = 0
FLAG_DIR  = 1


def compute_layout(num_non_root_inodes):
    """Decide how many inodes to reserve.

    Allocate at least one full inode block (8 inodes) so very small
    file sets still have room to grow a little without reformatting.
    """
    needed = num_non_root_inodes + 1  # +1 for root
    blocks = max(1, (needed + INODES_PER_BLOCK - 1) // INODES_PER_BLOCK)
    inode_count = blocks * INODES_PER_BLOCK
    inode_start = 1
    data_start = inode_start + blocks
    return inode_count, inode_start, data_start


def pack_inode(name: bytes, parent: int, size: int, start_block: int, flags: int) -> bytes:
    """Serialize a single 64 B inode."""
    if len(name) >= 32:
        raise ValueError(f"name too long (max 31 bytes): {name!r}")
    name_padded = name + b"\x00" * (32 - len(name))
    return struct.pack("<32sIIII12x", name_padded, parent, size, start_block, flags)


def collect_tree(rootdir):
    """Walk rootdir/ and return a list of entries in inode order.

    Each entry is a tuple (name: bytes, parent_inode: int,
                            data: bytes or None, is_dir: bool).

    Directories are visited recursively after their own inode is
    assigned, so a child's parent inode number is already known by the
    time the child is appended.
    """
    entries = []

    def recurse(current_dir, parent_inode):
        for name in sorted(os.listdir(current_dir)):
            full = os.path.join(current_dir, name)
            name_bytes = name.encode("utf-8")
            if os.path.isdir(full):
                entries.append((name_bytes, parent_inode, None, True))
                my_inode = len(entries)  # 1-based (root = 0)
                recurse(full, my_inode)
            elif os.path.isfile(full):
                with open(full, "rb") as f:
                    data = f.read()
                entries.append((name_bytes, parent_inode, data, False))
            # silently skip symlinks / devices / etc.

    recurse(rootdir, 0)
    return entries


def build_image(rootdir):
    """Assemble the disk image as bytes from a filesystem tree at rootdir."""
    entries = collect_tree(rootdir)
    inode_count, inode_start, data_start = compute_layout(len(entries))

    # Root inode (index 0)
    inodes = [pack_inode(b"/", parent=0, size=0, start_block=0, flags=FLAG_DIR)]

    # Non-root inodes in DFS order (matches collect_tree).
    cur_data_block = 0  # relative to data_start
    file_payloads = []
    num_files = 0
    num_dirs = 0
    for name, parent, data, is_dir in entries:
        if is_dir:
            inodes.append(pack_inode(name,
                                     parent=parent,
                                     size=0,
                                     start_block=0,
                                     flags=FLAG_DIR))
            num_dirs += 1
        else:
            nblocks = (len(data) + BLOCK_SIZE - 1) // BLOCK_SIZE
            inodes.append(pack_inode(name,
                                     parent=parent,
                                     size=len(data),
                                     start_block=cur_data_block,
                                     flags=FLAG_FILE))
            file_payloads.append((cur_data_block, data))
            cur_data_block += nblocks
            num_files += 1

    # Pad the inode table out to inode_count slots
    while len(inodes) < inode_count:
        inodes.append(b"\x00" * INODE_SIZE)

    total_data_blocks = cur_data_block
    total_blocks = data_start + total_data_blocks
    # Ensure at least one data block so block_count > data_start even when
    # the filesystem is empty
    if total_blocks == data_start:
        total_blocks = data_start + 1

    img = bytearray(total_blocks * BLOCK_SIZE)

    # Superblock (block 0)
    struct.pack_into("<IIIIIII", img, 0,
                     MAGIC, VERSION, BLOCK_SIZE, total_blocks,
                     inode_count, inode_start, data_start)

    # Inode table
    for i, ino_bytes in enumerate(inodes):
        off = inode_start * BLOCK_SIZE + i * INODE_SIZE
        img[off:off + INODE_SIZE] = ino_bytes

    # File data (contiguous, starting at data_start)
    for rel_block, data in file_payloads:
        off = (data_start + rel_block) * BLOCK_SIZE
        img[off:off + len(data)] = data

    return bytes(img), {
        "total_blocks": total_blocks,
        "inode_count": inode_count,
        "inode_start": inode_start,
        "data_start": data_start,
        "num_files": num_files,
        "num_dirs": num_dirs,
    }


def main(argv):
    if len(argv) != 3:
        print("Usage: mkfs.py <output> <rootdir>", file=sys.stderr)
        return 1

    outpath = argv[1]
    rootdir = argv[2]
    if not os.path.isdir(rootdir):
        print(f"mkfs: rootdir {rootdir!r} is not a directory", file=sys.stderr)
        return 1

    img, meta = build_image(rootdir)

    with open(outpath, "wb") as fp:
        fp.write(img)

    print(f"mkfs: {outpath} "
          f"blocks={meta['total_blocks']} "
          f"inodes={meta['inode_count']} "
          f"inode_start={meta['inode_start']} "
          f"data_start={meta['data_start']} "
          f"files={meta['num_files']} "
          f"dirs={meta['num_dirs']}",
          file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))

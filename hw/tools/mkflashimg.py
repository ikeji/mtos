#!/usr/bin/env python3
"""mkflashimg.py IN.bin OUT.img — wrap a raw bin in the boot ROM's flash
image format: "MTOS" + len (u32 LE) + data + sum32 (u32 LE of the bytes)."""
import struct, sys
d = open(sys.argv[1], 'rb').read()
open(sys.argv[2], 'wb').write(b'MTOS' + struct.pack('<I', len(d)) + d + struct.pack('<I', sum(d) & 0xffffffff))

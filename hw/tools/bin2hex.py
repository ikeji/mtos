#!/usr/bin/env python3
"""bin2hex.py IN.bin OUT.hex — raw little-endian bin → $readmemh word file.
Also writes OUT.hex.b0 .. OUT.hex.b3 (one byte lane each) for the
synthesizable 4-lane RAM in rtl/soc/soc.v."""
import sys
data = open(sys.argv[1], 'rb').read()
data += b'\0' * (-len(data) % 4)
out = sys.argv[2]
with open(out, 'w') as f:
    for i in range(0, len(data), 4):
        f.write('%08x\n' % int.from_bytes(data[i:i+4], 'little'))
for lane in range(4):
    with open(out + '.b%d' % lane, 'w') as f:
        for i in range(lane, len(data), 4):
            f.write('%02x\n' % data[i])

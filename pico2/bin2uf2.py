#!/usr/bin/env python3
"""bin2uf2.py — raw binary を UF2 に変換 (RP2350 RISC-V 用)

使い方: bin2uf2.py input.bin output.uf2 [base_addr_hex]
デフォルト base_addr = 0x10000000 (Flash XIP base)
"""
import struct
import sys

UF2_MAGIC_START0 = 0x0A324655  # "UF2\n"
UF2_MAGIC_START1 = 0x9E5D5157
UF2_MAGIC_END    = 0x0AB16F30
UF2_FLAG_FAMILY  = 0x00002000
RP2350_RISCV_FAMILY_ID = 0xE48BFF5A
PAYLOAD_SIZE = 256

def main():
    if len(sys.argv) < 3:
        print(__doc__, file=sys.stderr)
        sys.exit(1)
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    base_addr = int(sys.argv[3], 16) if len(sys.argv) > 3 else 0x10000000

    with open(in_path, 'rb') as f:
        data = f.read()

    n_blocks = (len(data) + PAYLOAD_SIZE - 1) // PAYLOAD_SIZE
    out = bytearray()
    for i in range(n_blocks):
        chunk = data[i*PAYLOAD_SIZE:(i+1)*PAYLOAD_SIZE]
        chunk = chunk + b'\x00' * (PAYLOAD_SIZE - len(chunk))
        block = struct.pack('<IIIIIIII',
            UF2_MAGIC_START0, UF2_MAGIC_START1,
            UF2_FLAG_FAMILY,
            base_addr + i * PAYLOAD_SIZE,
            PAYLOAD_SIZE,
            i, n_blocks,
            RP2350_RISCV_FAMILY_ID,
        )
        block += chunk
        block += b'\x00' * (476 - PAYLOAD_SIZE)  # pad to 508
        block += struct.pack('<I', UF2_MAGIC_END)
        assert len(block) == 512
        out += block

    with open(out_path, 'wb') as f:
        f.write(out)
    print(f"Wrote {out_path}: {n_blocks} blocks ({len(data)} bytes input, {len(out)} bytes UF2)")

if __name__ == '__main__':
    main()

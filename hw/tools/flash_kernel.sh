#!/bin/bash
# flash_kernel.sh KERNEL.bin — write a kernel image to the SPI flash at the
# boot ROM's image offset (0x100000, above the bitstream), so the board
# boots it stand-alone. Also use `make -C hw flash-rom` once to put the
# SoC bitstream (top_soc_sdram) in flash.
set -euo pipefail
HW="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="${OSS_CAD:-$HOME/opt/oss-cad-suite}/bin:$PATH"
img="$HW/build/flash_kernel.img"
python3 "$HW/tools/mkflashimg.py" "$1" "$img"
openFPGALoader -b tangnano20k --external-flash --file-type raw -o 0x100000 --verify "$img"

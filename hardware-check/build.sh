#!/bin/bash
# build.sh — build sd_probe.uf2 with pico-sdk
set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
export PICO_SDK_PATH="${PICO_SDK_PATH:-$HOME/tmp/pico-sdk}"
[ -d "$PICO_SDK_PATH" ] || { echo "PICO_SDK_PATH=$PICO_SDK_PATH not found" >&2; exit 1; }

mkdir -p "$SCRIPT_DIR/build"
cd "$SCRIPT_DIR/build"
cmake -DPICO_PLATFORM=rp2350-arm-s -DPICO_BOARD=pico2 .. >/dev/null
make sd_probe -j4
echo
echo "Built: $SCRIPT_DIR/build/sd_probe.uf2"

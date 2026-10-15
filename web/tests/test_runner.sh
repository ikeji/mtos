#!/bin/bash
# test_runner.sh — EmuRunner (Worker core) under Node. SKIPs without the kernel bin.
set -u
WEB="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$WEB/.." && pwd)"
KERNEL_BIN="${KERNEL_BIN:-$ROOT/kernel/build/tn20k_kernel.bin}"
[ -s "$KERNEL_BIN" ] || { echo "test_runner: SKIP ($KERNEL_BIN missing; make -C kernel tn20k)"; exit 0; }
exec node "$WEB/tests/test_runner.mjs" "$KERNEL_BIN"

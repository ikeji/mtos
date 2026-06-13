#!/bin/sh
# build_picolibc_pic.sh — fetch + build picolibc with PIC for the
# gcc_doom / future gcc-task pipeline. Produces:
#
#   $PREFIX/lib/libc.a          (PIC-built, no TLS)
#   $PREFIX/include/...         (headers + the generated picolibc.h)
#   $PREFIX/picolibc.specs      (path-adjusted so --specs= works)
#
# Requires: meson, ninja-build, apt-get (to source the picolibc tarball).
# Override PREFIX / VERSION / WORK if you want non-default locations.
set -e

PREFIX="${PREFIX:-$HOME/opt/picolibc-pic-rv32im}"
VERSION="${VERSION:-1.8.10}"
WORK="${WORK:-/tmp/picolibc-build}"

CROSS_FILE="$(dirname "$0")/../runtime/mtos/picolibc-rv32im-pic.cross"
CROSS_FILE="$(cd "$(dirname "$CROSS_FILE")" && pwd)/$(basename "$CROSS_FILE")"

echo "==> PREFIX=$PREFIX"
echo "==> VERSION=$VERSION"
echo "==> WORK=$WORK"
echo "==> CROSS=$CROSS_FILE"

mkdir -p "$WORK"
cd "$WORK"

# Fetch the upstream tarball via Debian's apt source. apt source dumps
# into $PWD so do this from $WORK.
if [ ! -d "picolibc-$VERSION" ]; then
    echo "==> apt source picolibc-riscv64-unknown-elf"
    apt source --download-only picolibc-riscv64-unknown-elf >/dev/null 2>&1
    tar xf "picolibc_${VERSION}.orig.tar.gz"
fi

# Reconfigure from scratch — meson option flips don't always
# propagate cleanly to existing build dirs.
rm -rf build-rv32im-pic

# -Dthread-local-storage=false drops picolibc's tp-based TLS, which
# would collide with the gcc_crt0.s usage of tp for the per-task heap
# state block.
meson setup build-rv32im-pic \
    --cross-file="$CROSS_FILE" \
    --prefix="$PREFIX" \
    -Dmultilib=false \
    -Dincludedir=include \
    -Dlibdir=lib \
    -Dthread-local-storage=false \
    "picolibc-$VERSION"

ninja -C build-rv32im-pic

# The install step also tries to drop picolibc.specs into the system
# GCC dir, which fails without root and prevents the rest of the
# install. Run it once, swallow the failure, then copy the .specs by
# hand into PREFIX where our Makefile expects it.
ninja -C build-rv32im-pic install 2>/dev/null || true

mkdir -p "$PREFIX/include"
cp build-rv32im-pic/picolibc.h "$PREFIX/include/"
cp build-rv32im-pic/picolibc.specs "$PREFIX/picolibc.specs"

echo "==> done. Verify:"
echo "    riscv64-unknown-elf-gcc --specs=$PREFIX/picolibc.specs ..."

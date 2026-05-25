# kernel/ サブプロジェクト Makefile
#
# 主目的: `make -C kernel test` が kernel 関連 test (test_os) だけ実行
# する (compiler test や userland smoke は走らない)。これによりユーザー
# が kernel/src/*.tc, kernel/platform/*, kernel/tools-src/* を編集した
# とき、compiler 関連テストを再実行せずに済む。
#
# test_os は kernel boot + tmpfs + redirect + spawn/wait 等を qemu virt
# 上で end-to-end 検証する。kernel image 自体は root Makefile の
# build/kernel/disk-demo.img + build/kernel/virt_kernel.bin 経由でビルド。

ROOT := $(realpath $(CURDIR)/..)

.PHONY: all build test clean

# kernel 本体 (virt + pico2) を build
all build:
	$(MAKE) -C $(ROOT) virt-kernel pico2-kernel

# Test target — kernel test だけ実行。root に必要な depending
# (kernel image / disk image) を build させてから test_os を呼ぶ。
# test_os は内部で disk-demo.img / virt_kernel.bin を期待するので、
# root Makefile の dependency tracking 経由で先にビルドさせる。
test:
	$(MAKE) -C $(ROOT) build/kernel/virt_kernel.bin
	$(MAKE) -C $(ROOT) build/kernel/disk-demo.img
	$(MAKE) -C $(ROOT) build/kernel/disk-console.img
	$(MAKE) -C $(ROOT) build/kernel/disk-console-land.img
	@cd $(ROOT) && $(ROOT)/kernel/tests/test_os.sh

clean:
	rm -rf $(ROOT)/build/kernel

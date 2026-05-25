# kernel/ サブプロジェクト Makefile
#
# 主目的: `make -C kernel test` が kernel 関連 test (test_os) だけ実行
# する (compiler test や userland smoke は走らない)。これによりユーザー
# が kernel/src/*.tc, kernel/platform/*, kernel/tools-src/* を編集した
# とき、compiler 関連テストを再実行せずに済む。
#
# build recipe の物理移動は将来のフェーズで実施。現状は root Makefile に
# 委譲する coordinator として動作。

ROOT := $(realpath $(CURDIR)/..)

.PHONY: all build test clean \
    virt pico2 pico2-extra pico2-demo pico2-console pico2-console-land \
    run run-extra run-pico2 run-pico2-extra run-pico2-console run-pico2-console-land \
    flash

# Default: virt + pico2 両方 build
all build: virt pico2

# ===== virt kernel =====
virt:
	$(MAKE) -C $(ROOT) build/kernel/virt_kernel.bin

# qemu virt で対話起動
QEMU_SYSTEM := qemu-system-riscv32
QEMU_DISK   := $(ROOT)/build/kernel/disk.img
QEMU_FAT    := $(ROOT)/build/kernel/fat.img
QEMU_ARGS    = -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
               -machine virt,aclint=on -bios none \
               -drive file=$(QEMU_FAT),format=raw,if=none,id=blk1 \
               -device virtio-blk-device,drive=blk1 \
               -drive file=$(QEMU_DISK),format=raw,if=none,id=blk0 \
               -device virtio-blk-device,drive=blk0 \
               -device loader,file=$(ROOT)/build/kernel/virt_kernel.bin,addr=0x80000000 \
               -device loader,addr=0x80000000,cpu-num=0

run: virt
	$(MAKE) -C $(ROOT) build/kernel/disk.img build/kernel/fat.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

run-extra: QEMU_DISK := $(ROOT)/build/kernel/disk-extra.img
run-extra: virt
	$(MAKE) -C $(ROOT) build/kernel/disk-extra.img build/kernel/fat.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

# ===== pico2 kernel (UF2 + 各 disk variant) =====
pico2:
	$(MAKE) -C $(ROOT) build/kernel/pico2_kernel.uf2

pico2-extra:
	$(MAKE) -C $(ROOT) build/kernel/pico2_kernel_extra.uf2

pico2-demo:
	$(MAKE) -C $(ROOT) build/kernel/pico2_kernel_demo.uf2

pico2-console:
	$(MAKE) -C $(ROOT) build/kernel/pico2_kernel_console.uf2

pico2-console-land:
	$(MAKE) -C $(ROOT) build/kernel/pico2_kernel_console_land.uf2

# pico2 実機 flash + UART (UF2 を build してから run_pico2_interactive.sh)
run-pico2: pico2
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(ROOT)/build/kernel/pico2_kernel.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-extra: pico2-extra
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(ROOT)/build/kernel/pico2_kernel_extra.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-console: pico2-console
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(ROOT)/build/kernel/pico2_kernel_console.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-console-land: pico2-console-land
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(ROOT)/build/kernel/pico2_kernel_console_land.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

# 単発 flash (no build)
flash:
	./scripts/run_pico2.sh $(ROOT)/build/kernel/pico2_kernel.uf2

# ===== test =====
# kernel test — disk image 各種をビルドさせてから test_os を呼ぶ。
test:
	$(MAKE) -C $(ROOT) build/kernel/virt_kernel.bin
	$(MAKE) -C $(ROOT) build/kernel/disk-demo.img
	$(MAKE) -C $(ROOT) build/kernel/disk-console.img
	$(MAKE) -C $(ROOT) build/kernel/disk-console-land.img
	@cd $(ROOT) && $(ROOT)/kernel/tests/test_os.sh

clean:
	rm -rf $(ROOT)/build/kernel

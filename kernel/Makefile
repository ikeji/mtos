# kernel/ サブプロジェクト Makefile
#
# 主目的: `make -C kernel test` が kernel 関連 test (test_os) だけ実行
# する。build recipe も自分が所有 (Phase 4d で root から移動)。
#
# 出力:
#   kernel/build/virt_kernel.bin             qemu virt 用 raw bin
#   kernel/build/pico2_kernel.uf2            pico2 用 UF2 (default)
#   kernel/build/pico2_kernel_{extra,demo,console,console-land}.uf2
#   kernel/build/disk.img / disk-{demo,extra,console,console-land}.img
#   kernel/build/fat.img                     virt 用 second virtio-blk drive

ROOT := $(realpath $(CURDIR)/..)

QEMU_USER := qemu-riscv32

# ----- Compiler artifacts that kernel consumes -----
GEN2_DIR     := $(ROOT)/compiler/build/gen2
GEN2_TOOLS   := $(addprefix $(GEN2_DIR)/,parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2 asm_pass3)
KERN_TOOLS   := $(GEN2_DIR)/mkfs $(GEN2_DIR)/bin2uf2
COMPILE_GEN2 := $(ROOT)/compiler/scripts/compile-gen2.sh

# ----- Userland artifacts that kernel consumes -----
USERLAND_BUILD := $(ROOT)/userland/build
SHARED_S       := $(USERLAND_BUILD)/shared/runtime.s $(USERLAND_BUILD)/shared/libtc.s

# task 一覧 (userland と同じ wildcard 経由で読む)
TASK_MK_FILES := $(wildcard $(ROOT)/userland/bin/*/task.mk) \
                 $(wildcard $(ROOT)/userland/gcc-bin/*/task.mk)
GUEST_TASKS :=
EXTRA_GUEST_TASKS :=
-include $(TASK_MK_FILES)
GUEST_TASKS       := $(filter-out $(DROP_TASKS),$(GUEST_TASKS))
EXTRA_GUEST_TASKS := $(filter-out $(DROP_TASKS),$(EXTRA_GUEST_TASKS))

GUEST_TASK_BINS := $(foreach t,$(GUEST_TASKS),$(USERLAND_BUILD)/tasks/$(t).bin)
EXTRA_TASK_BINS := $(foreach t,$(EXTRA_GUEST_TASKS),$(USERLAND_BUILD)/tasks/$(t).bin)
ALL_TASK_BINS   := $(GUEST_TASK_BINS) $(EXTRA_TASK_BINS)

# ----- Cross-sub delegation: build artifacts in compiler / userland on demand -----
# IMPORTANT: do NOT make these order-only prerequisites (| _userland-tasks).
# Order-only deps only fire when the target file doesn't exist — once a
# .bin lands the sub-make is never invoked again, so .c-level changes
# in userland never propagate into the kernel image. K22 burned hours
# on stale-binary debugging because of exactly that. Use a normal
# (non-order-only) prerequisite so the .PHONY target re-runs on every
# build; the sub-make then does the real dependency tracking inside
# userland.
.PHONY: _compiler-gen2 _compiler-kern-tools _userland-tasks _userland-shared
_compiler-gen2:
	$(MAKE) -C $(ROOT)/compiler gen2
_compiler-kern-tools:
	$(MAKE) -C $(ROOT)/compiler kern-tools
_userland-tasks:
	$(MAKE) -C $(ROOT)/userland tasks
_userland-shared:
	$(MAKE) -C $(ROOT)/userland shared

$(GEN2_TOOLS):     _compiler-gen2
$(KERN_TOOLS):     _compiler-kern-tools
$(ALL_TASK_BINS):  _userland-tasks
$(SHARED_S):       _userland-shared

# ----- Kernel sources -----
KERNEL_TC_SOURCES := $(wildcard $(ROOT)/kernel/src/*.tc) \
                     $(wildcard $(ROOT)/kernel/platform/virt/*.tc) \
                     $(wildcard $(ROOT)/kernel/platform/pico2/*.tc)
KERNEL_S_SOURCES  := $(ROOT)/kernel/platform/virt/platform_virt.s \
                     $(ROOT)/kernel/platform/pico2/platform_pico2.s \
                     $(ROOT)/kernel/src/trap_common.s \
                     $(ROOT)/kernel/platform/virt/crt0_data.s \
                     $(ROOT)/kernel/platform/pico2/crt0_pico2_data.s \
                     $(ROOT)/compiler/runtime/mtos/task_crt0.s \
                     $(ROOT)/compiler/runtime/mtos/task_data.s
KERNEL_COMPILE_DEPS := $(KERNEL_TC_SOURCES) $(KERNEL_S_SOURCES) \
                       $(SHARED_S) $(GEN2_TOOLS) $(COMPILE_GEN2)

# ----- Output dirs -----
BUILD_DIR := $(ROOT)/kernel/build

# ----- Disk image fixture inputs -----
# Files in kernel/fs-spec/etc are dragged in by default.spec via stage-fs.sh
# at disk-image build time; list them as deps so editing /etc/login etc.
# triggers a rebuild instead of silently shipping the previous version.
DISK_STATIC_DEPS := $(ROOT)/integration/inputs/phase7_hello.tc \
                    $(ROOT)/integration/inputs/phase7_min.tc \
                    $(ROOT)/integration/inputs/phase7_hello_world.tc \
                    $(ROOT)/compiler/runtime/mtos/task_crt0.s \
                    $(ROOT)/compiler/runtime/mtos/task_data.s \
                    $(GEN2_DIR)/mkfs \
                    $(wildcard $(ROOT)/kernel/fs-spec/etc/*)

.PHONY: all build test clean \
        virt pico2 pico2-extra pico2-demo pico2-console pico2-console-land \
        disks disk-extra \
        run run-extra run-pico2 run-pico2-extra run-pico2-console run-pico2-console-land \
        flash

# Default: virt + pico2 両方 build
all build: virt pico2

# ===== Output dir =====
$(BUILD_DIR):
	mkdir -p $@

# ===== Disk images (standard 4 variants — kernel/build/disk*.img) =====
$(BUILD_DIR)/disk.img:              DISK_KERN_CONF := $(wildcard $(ROOT)/kernel/kern.conf)
$(BUILD_DIR)/disk-demo.img:         DISK_KERN_CONF := $(ROOT)/kernel/tests/fixtures/kern_demo.conf
$(BUILD_DIR)/disk-console.img:      DISK_KERN_CONF := $(ROOT)/kernel/tests/fixtures/kern_console.conf
$(BUILD_DIR)/disk-console-land.img: DISK_KERN_CONF := $(ROOT)/kernel/tests/fixtures/kern_console_land.conf

# Per-target deps for DISK_KERN_CONF files
$(BUILD_DIR)/disk-demo.img:         $(ROOT)/kernel/tests/fixtures/kern_demo.conf
$(BUILD_DIR)/disk-console.img:      $(ROOT)/kernel/tests/fixtures/kern_console.conf
$(BUILD_DIR)/disk-console-land.img: $(ROOT)/kernel/tests/fixtures/kern_console_land.conf

# /etc/login: only console disks ship the neofetch banner. Plain and
# demo disks omit it because nested-console rendering of neofetch
# would push the test_os landscape test past its budget.
$(BUILD_DIR)/disk-console.img:      DISK_LOGIN := $(ROOT)/kernel/fs-spec/etc/login
$(BUILD_DIR)/disk-console-land.img: DISK_LOGIN := $(ROOT)/kernel/fs-spec/etc/login
$(BUILD_DIR)/disk-console.img:      $(ROOT)/kernel/fs-spec/etc/login
$(BUILD_DIR)/disk-console-land.img: $(ROOT)/kernel/fs-spec/etc/login

# /etc/term.conf: COLS/ROWS for full-screen apps (sl, eventually vi).
# Only console disks ship it; the plain disk leaves it absent so sl on
# the UART terminal falls back to its 80x24 compile-time default.
$(BUILD_DIR)/disk-console.img:      DISK_TERM_CONF := $(ROOT)/kernel/fs-spec/etc/term_portrait.conf
$(BUILD_DIR)/disk-console-land.img: DISK_TERM_CONF := $(ROOT)/kernel/fs-spec/etc/term_landscape.conf
$(BUILD_DIR)/disk-console.img:      $(ROOT)/kernel/fs-spec/etc/term_portrait.conf
$(BUILD_DIR)/disk-console-land.img: $(ROOT)/kernel/fs-spec/etc/term_landscape.conf

# Pre-encode prelude (Step 5 of pre-encode, docs/task/asm_pre_encode.md)
define PRELUDE_PRE_ENCODE
    cd $(ROOT) && qemu-riscv32 compiler/build/gen2/asm_pass1 \
        "$$_r/prelude.s" "$$_r/prelude_tail.s" \
        --idx-out    "$$_r/prelude.idx" \
        --text-bin   "$$_r/prelude.tx" \
        --rodata-bin "$$_r/prelude.ro" \
        --data-bin   "$$_r/prelude.dt" \
        --reloc-out  "$$_r/prelude.rl" \
        2>/dev/null && \
    chmod 644 "$$_r/prelude.idx" "$$_r/prelude.tx" \
              "$$_r/prelude.ro" "$$_r/prelude.dt" \
              "$$_r/prelude.rl"
endef

# fs-spec で kernel/fs-spec/default.spec の静的ファイルを copy。
# 動的部分 (task bins / prelude / kern.conf) のみ Makefile 側で処理。
DEFAULT_SPEC := $(ROOT)/kernel/fs-spec/default.spec

# Common recipe for the 4 standard disks (different DISK_KERN_CONF only)
$(BUILD_DIR)/disk.img $(BUILD_DIR)/disk-demo.img $(BUILD_DIR)/disk-console.img $(BUILD_DIR)/disk-console-land.img: \
    $(GUEST_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) \
    $(GEN2_DIR)/asm_pass1 $(GEN2_DIR)/asm_pass2 $(GEN2_DIR)/asm_pass3 \
    $(DEFAULT_SPEC) $(ROOT)/kernel/scripts/stage-fs.sh \
    $(ROOT)/kernel/tests/fixtures/msh_smoke.sh \
    $(ROOT)/kernel/tests/fixtures/msh_abort.sh \
    $(ROOT)/integration/fixtures/pico2_bench_idx.sh \
    | $(BUILD_DIR)
	@echo "Building disk image: $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" && \
	for t in $(GUEST_TASKS); do \
	    cp $(USERLAND_BUILD)/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	$(ROOT)/kernel/scripts/stage-fs.sh "$$_r" $(DEFAULT_SPEC) && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat $(ROOT)/compiler/runtime/mtos/task_crt0.s; cat $(USERLAND_BUILD)/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp $(ROOT)/compiler/runtime/mtos/task_data.s "$$_r/prelude_tail.s" && \
	$(PRELUDE_PRE_ENCODE) && \
	if [ -n "$(DISK_KERN_CONF)" ] && [ -f "$(DISK_KERN_CONF)" ]; then \
	    mkdir -p "$$_r/etc" && cp "$(DISK_KERN_CONF)" "$$_r/etc/kern.conf"; \
	fi && \
	if [ -n "$(DISK_LOGIN)" ] && [ -f "$(DISK_LOGIN)" ]; then \
	    mkdir -p "$$_r/etc" && cp "$(DISK_LOGIN)" "$$_r/etc/login"; \
	fi && \
	if [ -n "$(DISK_TERM_CONF)" ] && [ -f "$(DISK_TERM_CONF)" ]; then \
	    mkdir -p "$$_r/etc" && cp "$(DISK_TERM_CONF)" "$$_r/etc/term.conf"; \
	fi && \
	mkdir -p "$$_r/etc" && \
	_kbuild=$$(git -C $(ROOT) rev-parse --short=8 HEAD 2>/dev/null || echo unknown) && \
	if ! git -C $(ROOT) diff --quiet HEAD 2>/dev/null; then _kbuild="$$_kbuild+dirty"; fi && \
	_kdate=$$(date -u +%Y-%m-%dT%H:%M:%SZ) && \
	printf 'build=%s\ndate=%s\n' "$$_kbuild" "$$_kdate" > "$$_r/etc/version" && \
	cd $(ROOT) && qemu-riscv32 compiler/build/gen2/mkfs $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

# ----- disk-extra.img: GUEST + EXTRA tasks + 大量の compiler source 同梱 -----
EXTRA_SRC_DEPS := $(addprefix $(ROOT)/compiler/src/,string_buffer.tc source_reader.tc strlib.tc ast_node.tc asm_common.tc parse.tc sigscan.tc tcheck.tc codegen.tc bc2asm.tc asm_pass2.tc asm_pass3.tc runtime.tc) \
    $(ROOT)/userland/lib/libtc/libtc.tc \
    $(ROOT)/kernel/src/kernel_common.tc \
    $(ROOT)/kernel/platform/pico2/block_flash.tc \
    $(ROOT)/kernel/platform/pico2/block_sd.tc \
    $(ROOT)/kernel/src/tmpfs.tc $(ROOT)/kernel/src/fatfs.tc \
    $(ROOT)/kernel/src/mtfs.tc $(ROOT)/kernel/src/procfs.tc \
    $(ROOT)/kernel/src/vfs.tc $(ROOT)/kernel/src/loader.tc \
    $(ROOT)/kernel/src/kernel_pico2.tc \
    $(ROOT)/kernel/platform/pico2/platform_pico2.tc \
    $(ROOT)/kernel/platform/pico2/platform_pico2.s \
    $(ROOT)/kernel/src/trap_common.s \
    $(ROOT)/kernel/platform/pico2/crt0_pico2_data.s

EXTRA_SPEC := $(ROOT)/kernel/fs-spec/extra.spec

# extra disk: GUEST + EXTRA tasks + 全 source 同梱 (device 側 self-replicate
# 用)。静的 file copy は fs-spec/extra.spec が宣言。動的部分 (tasks,
# prelude, kern.conf, per-task header) は recipe 内で処理。
$(BUILD_DIR)/disk-extra.img: $(ALL_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) $(EXTRA_SRC_DEPS) \
    $(GEN2_DIR)/asm_pass1 $(GEN2_DIR)/asm_pass2 $(GEN2_DIR)/asm_pass3 \
    $(EXTRA_SPEC) $(DEFAULT_SPEC) $(ROOT)/kernel/scripts/stage-fs.sh \
    $(ROOT)/userland/scripts/bin2s_incbin.sh \
    $(BUILD_DIR)/disk.img \
    | $(BUILD_DIR)
	@echo "Building disk image (extra): $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" "$$_r/src" && \
	for t in $(GUEST_TASKS) $(EXTRA_GUEST_TASKS); do \
	    cp $(USERLAND_BUILD)/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	$(ROOT)/kernel/scripts/stage-fs.sh "$$_r" $(EXTRA_SPEC) && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat $(ROOT)/compiler/runtime/mtos/task_crt0.s; cat $(USERLAND_BUILD)/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp $(ROOT)/compiler/runtime/mtos/task_data.s "$$_r/prelude_tail.s" && \
	$(PRELUDE_PRE_ENCODE) && \
	if [ -f $(ROOT)/kernel/kern.conf ]; then \
	    mkdir -p "$$_r/etc" && cp $(ROOT)/kernel/kern.conf "$$_r/etc/kern.conf"; \
	fi && \
	for spec in parse:$(TASK_ARENA_parse):$(TASK_STACK_parse) \
	            sigscan:$(TASK_ARENA_sigscan):$(TASK_STACK_sigscan) \
	            tcheck:$(TASK_ARENA_tcheck):$(TASK_STACK_tcheck) \
	            codegen:$(TASK_ARENA_codegen):$(TASK_STACK_codegen) \
	            bc2asm:$(TASK_ARENA_bc2asm):$(TASK_STACK_bc2asm) \
	            asm_pass1:$(TASK_ARENA_asm_pass1):$(TASK_STACK_asm_pass1) \
	            asm_pass2:$(TASK_ARENA_asm_pass2):$(TASK_STACK_asm_pass2) \
	            asm_pass3:$(TASK_ARENA_asm_pass3):$(TASK_STACK_asm_pass3); do \
	    nm=$$(echo $$spec | cut -d: -f1); \
	    ar=$$(echo $$spec | cut -d: -f2); \
	    sk=$$(echo $$spec | cut -d: -f3); \
	    printf '; raw\n    .text\n    .word %d\n    .word %d\n' $$ar $$sk \
	        > "$$_r/src/hdr_$$nm.s"; \
	done && \
	cd $(ROOT) && qemu-riscv32 compiler/build/gen2/mkfs $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

disks:      $(BUILD_DIR)/disk.img $(BUILD_DIR)/disk-demo.img $(BUILD_DIR)/disk-console.img $(BUILD_DIR)/disk-console-land.img
disk-extra: $(BUILD_DIR)/disk-extra.img

# ===== virt kernel =====
virt: $(BUILD_DIR)/virt_kernel.bin

$(BUILD_DIR)/virt_kernel.bin: $(KERNEL_COMPILE_DEPS) | $(BUILD_DIR)
	@echo "Building kernel: virt" >&2
	@cd $(ROOT) && CRT0="kernel/platform/virt/platform_virt.s kernel/src/trap_common.s" \
	    CRT0_DATA=kernel/platform/virt/crt0_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=userland/build/shared \
	    ./compiler/scripts/compile-gen2.sh -o $@ kernel/src/kernel.tc 2>/dev/null

# ===== pico2 kernel (UF2 + 5 disk variants) =====
pico2:              $(BUILD_DIR)/pico2_kernel.uf2
pico2-extra:        $(BUILD_DIR)/pico2_kernel_extra.uf2
pico2-demo:         $(BUILD_DIR)/pico2_kernel_demo.uf2
pico2-console:      $(BUILD_DIR)/pico2_kernel_console.uf2
pico2-console-land: $(BUILD_DIR)/pico2_kernel_console_land.uf2

# Recipe shared by all pico2 UF2 variants. PICO2_DISK は target-specific
# variable で各 variant ごとに切り替え。
define PICO2_KERNEL_RECIPE
	@echo "Building kernel: pico2 (disk=$(PICO2_DISK))" >&2
	@_tmp=$$(mktemp -d) && \
	_labdir=$(ROOT)/build/intermediate/gen2/kernel_pico2 && \
	mkdir -p "$$_labdir" && \
	cp $(PICO2_DISK) "$$_labdir/dx.img" && \
	cd $(ROOT) && userland/scripts/bin2s_incbin.sh $(PICO2_DISK) _mtfs_image dx.img > "$$_tmp/mtfs_image.s" && \
	cd $(ROOT) && CRT0="kernel/platform/pico2/platform_pico2.s kernel/src/trap_common.s" \
	    CRT0_DATA="kernel/platform/pico2/crt0_pico2_data.s $$_tmp/mtfs_image.s" \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=userland/build/shared \
	    ./compiler/scripts/compile-gen2.sh -o "$$_tmp/kernel.bin" kernel/src/kernel_pico2.tc 2>/dev/null && \
	_ksz=$$(wc -c < "$$_tmp/kernel.bin") && \
	_dsz=$$(wc -c < $(PICO2_DISK)) && \
	printf '  kernel.bin: %s bytes, disk: %s bytes\n' "$$_ksz" "$$_dsz" >&2 && \
	cd $(ROOT) && qemu-riscv32 compiler/build/gen2/bin2uf2 "$$_tmp/kernel.bin" $@ && \
	rm -rf "$$_tmp"
endef

$(BUILD_DIR)/pico2_kernel.uf2: PICO2_DISK := $(BUILD_DIR)/disk.img
$(BUILD_DIR)/pico2_kernel.uf2: $(KERNEL_COMPILE_DEPS) $(BUILD_DIR)/disk.img \
    $(ROOT)/userland/scripts/bin2s_incbin.sh $(GEN2_DIR)/bin2uf2 | $(BUILD_DIR)
	$(PICO2_KERNEL_RECIPE)

$(BUILD_DIR)/pico2_kernel_extra.uf2: PICO2_DISK := $(BUILD_DIR)/disk-extra.img
$(BUILD_DIR)/pico2_kernel_extra.uf2: $(KERNEL_COMPILE_DEPS) $(BUILD_DIR)/disk-extra.img \
    $(ROOT)/userland/scripts/bin2s_incbin.sh $(GEN2_DIR)/bin2uf2 | $(BUILD_DIR)
	$(PICO2_KERNEL_RECIPE)

$(BUILD_DIR)/pico2_kernel_demo.uf2: PICO2_DISK := $(BUILD_DIR)/disk-demo.img
$(BUILD_DIR)/pico2_kernel_demo.uf2: $(KERNEL_COMPILE_DEPS) $(BUILD_DIR)/disk-demo.img \
    $(ROOT)/userland/scripts/bin2s_incbin.sh $(GEN2_DIR)/bin2uf2 | $(BUILD_DIR)
	$(PICO2_KERNEL_RECIPE)

$(BUILD_DIR)/pico2_kernel_console.uf2: PICO2_DISK := $(BUILD_DIR)/disk-console.img
$(BUILD_DIR)/pico2_kernel_console.uf2: $(KERNEL_COMPILE_DEPS) $(BUILD_DIR)/disk-console.img \
    $(ROOT)/userland/scripts/bin2s_incbin.sh $(GEN2_DIR)/bin2uf2 | $(BUILD_DIR)
	$(PICO2_KERNEL_RECIPE)

$(BUILD_DIR)/pico2_kernel_console_land.uf2: PICO2_DISK := $(BUILD_DIR)/disk-console-land.img
$(BUILD_DIR)/pico2_kernel_console_land.uf2: $(KERNEL_COMPILE_DEPS) $(BUILD_DIR)/disk-console-land.img \
    $(ROOT)/userland/scripts/bin2s_incbin.sh $(GEN2_DIR)/bin2uf2 | $(BUILD_DIR)
	$(PICO2_KERNEL_RECIPE)

# ===== FAT32 disk image (second virtio-blk drive for virt) =====
MKFS_FAT := $(shell which mkfs.fat 2>/dev/null || echo /sbin/mkfs.fat)

$(BUILD_DIR)/fat.img: | $(BUILD_DIR)
	@echo "Creating FAT32 image: $@" >&2
	@dd if=/dev/zero of=$@ bs=1M count=33 2>/dev/null && \
	$(MKFS_FAT) -F 32 $@ >/dev/null && \
	printf 'hello from SD\n' | mcopy -i $@ - ::HELLO.TXT

# ===== qemu / pico2 run targets =====
QEMU_SYSTEM := qemu-system-riscv32
QEMU_DISK   := $(BUILD_DIR)/disk.img
QEMU_FAT    := $(BUILD_DIR)/fat.img
QEMU_ARGS    = -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
               -machine virt,aclint=on -bios none \
               -drive file=$(QEMU_FAT),format=raw,if=none,id=blk1 \
               -device virtio-blk-device,drive=blk1 \
               -drive file=$(QEMU_DISK),format=raw,if=none,id=blk0 \
               -device virtio-blk-device,drive=blk0 \
               -device loader,file=$(BUILD_DIR)/virt_kernel.bin,addr=0x80000000 \
               -device loader,addr=0x80000000,cpu-num=0

run: virt $(BUILD_DIR)/disk.img $(BUILD_DIR)/fat.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

run-extra: QEMU_DISK := $(BUILD_DIR)/disk-extra.img
run-extra: virt $(BUILD_DIR)/disk-extra.img $(BUILD_DIR)/fat.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

run-pico2: pico2
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(BUILD_DIR)/pico2_kernel.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-extra: pico2-extra
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(BUILD_DIR)/pico2_kernel_extra.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-console: pico2-console
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(BUILD_DIR)/pico2_kernel_console.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

run-pico2-console-land: pico2-console-land
	@echo "[pico2] flash + interactive UART (Ctrl-a x to quit)"
	UF2=$(BUILD_DIR)/pico2_kernel_console_land.uf2 $(ROOT)/kernel/scripts/run_pico2_interactive.sh --no-build

flash:
	$(ROOT)/kernel/scripts/run_pico2.sh $(BUILD_DIR)/pico2_kernel.uf2

# ===== test =====
test: $(BUILD_DIR)/virt_kernel.bin $(BUILD_DIR)/disk-demo.img $(BUILD_DIR)/disk-console.img $(BUILD_DIR)/disk-console-land.img
	@cd $(ROOT) && $(ROOT)/kernel/tests/test_os.sh

clean:
	rm -rf $(BUILD_DIR)

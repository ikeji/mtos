CC = gcc
CFLAGS = -Wall -Wextra -g -I bootstrap

SRCS = bootstrap/lexer.c bootstrap/ast.c bootstrap/parser.c bootstrap/typecheck.c bootstrap/interp.c bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

# Gen1 ツール (C 製、build/gen1/ 固定。repo 直下には置かない)
GEN1_NAMES = parse typecheck interp codegen bcrun bc2asm
GEN1_TOOLS = $(addprefix build/gen1/,$(GEN1_NAMES))

# Gen2 ツール (compile-gen1.sh で compiler/*.tc を RV32 ELF に。
# build/gen2/ 固定にして make test 2 回目以降は再ビルドを避ける)
GEN2_NAMES = parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2
GEN2_TOOLS = $(addprefix build/gen2/,$(GEN2_NAMES))

all: $(GEN1_TOOLS)

build/gen1:
	mkdir -p $@

build/gen1/parse: $(OBJS) bootstrap/parse_main.o | build/gen1
	$(CC) -o $@ $^

build/gen1/typecheck: $(OBJS) bootstrap/typecheck_main.o | build/gen1
	$(CC) -o $@ $^

build/gen1/interp: $(OBJS) bootstrap/interp_main.o | build/gen1
	$(CC) -o $@ $^

build/gen1/codegen: $(OBJS) bootstrap/codegen_main.o | build/gen1
	$(CC) -o $@ $^

build/gen1/bcrun: bootstrap/bcrun.c | build/gen1
	$(CC) $(CFLAGS) -o $@ bootstrap/bcrun.c

build/gen1/bc2asm: bootstrap/bc2asm.c | build/gen1
	$(CC) $(CFLAGS) -o $@ bootstrap/bc2asm.c

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Gen2 ツールを compile-gen1.sh で build。transitive import 追跡は
# recipe 末尾で `tools/tc_deps_to_d.sh` が .d を書き出し、top Makefile
# が `-include` で取り込む (Phase B)。2 回目以降の make test はこの .d
# で「触っていない .tc 経由のツール」を正しくスキップできる。
build/gen2:
	mkdir -p $@

build/gen2/%: compiler/%.tc $(GEN1_TOOLS) tools/collect_imports.sh tools/tc_deps_to_d.sh | build/gen2
	./compile-gen1.sh -o $@ $<
	./tools/tc_deps_to_d.sh $@ $< > $@.d

gen2-tools: $(GEN2_TOOLS)

# .d の内容を取り込む。Phase B で導入。初回ビルドでは存在しないので
# `-include` (エラーにしない) を使う
-include $(addsuffix .d,$(GEN2_TOOLS))

# ===== Gen3 tools (Phase E) =====
#
# Gen3 は Gen2 ツール (Gen1 で build した TC 製ツール) を使って
# compiler/*.tc を再 build したもの。自己ホスト確認 (Gen2==Gen3)
# と、kernel build の本番経路候補に使う。build/gen2/ と同じ流れで
# `.d` による transitive import 追跡を入れる。
GEN3_NAMES = $(GEN2_NAMES)
GEN3_TOOLS = $(addprefix build/gen3/,$(GEN3_NAMES))

build/gen3:
	mkdir -p $@

build/gen3/%: compiler/%.tc $(GEN2_TOOLS) tools/collect_imports.sh tools/tc_deps_to_d.sh | build/gen3
	GEN2_DIR=build/gen2 ./compile-gen2.sh -o $@ $< 2>/dev/null
	./tools/tc_deps_to_d.sh $@ $< > $@.d

gen3-tools: $(GEN3_TOOLS)

-include $(addsuffix .d,$(GEN3_TOOLS))

# ===== kernel build (decomposed) =====
#
# kernel/build.sh を per-task / disk / kernel の 3 段階に分解。
# タスクバイナリは個別 Make ターゲットで incremental build。
# ディスクイメージは 2 種 (標準 / extra)。カーネルバイナリは
# ディスクと独立 (virt)。.NOTPARALLEL: で serial 実行を強制。

KERNEL_TC_SOURCES := $(wildcard kernel/*.tc)
KERNEL_S_SOURCES  := kernel/platform_virt.s kernel/platform_pico2.s \
                     kernel/trap_common.s kernel/crt0_data.s \
                     kernel/crt0_pico2_data.s \
                     kernel/tasks/task_crt0.s kernel/tasks/task_data.s

RUNTIME_DEPS := $(shell tools/collect_imports.sh compiler/runtime.tc 2>/dev/null)
LIBTC_DEPS   := $(shell tools/collect_imports.sh kernel/tasks/libtc/libtc.tc 2>/dev/null)

# task の定義は kernel/tasks/*/task.mk から include。各 task.mk が
# GUEST_TASKS += <name> または EXTRA_GUEST_TASKS += <name> と
# TASK_ARENA_<name> / TASK_STACK_<name> を宣言。
GUEST_TASKS :=
EXTRA_GUEST_TASKS :=
-include $(wildcard kernel/tasks/*/task.mk)
ALL_TASK_NAMES := $(GUEST_TASKS) $(EXTRA_GUEST_TASKS)

TASK_MK_FILES := $(wildcard kernel/tasks/*/task.mk)
QEMU_USER := qemu-riscv32

build/kernel:
	mkdir -p $@

# `)` を Makefile 内で安全に使うためのヘルパー変数
close_paren := )

# task_sizes.sh: per-task arena/stack サイズを bash 関数で提供。
# kernel/build.sh (後方互換) と per-task ビルドレシピが source する。
build/kernel/task_sizes.sh: $(TASK_MK_FILES) Makefile | build/kernel
	@printf '%s\n' \
	    '# auto-generated from kernel/tasks/*/task.mk' \
	    'TASKS="$(GUEST_TASKS)"' \
	    'task_arena_size() { case "$$1" in' \
	    $(foreach t,$(ALL_TASK_NAMES),'  $(t)$(close_paren) echo $(TASK_ARENA_$(t)) ;;') \
	    '  *$(close_paren) echo 32768 ;;' \
	    'esac; }' \
	    'task_stack_size() { case "$$1" in' \
	    $(foreach t,$(ALL_TASK_NAMES),'  $(t)$(close_paren) echo $(TASK_STACK_$(t)) ;;') \
	    '  *$(close_paren) echo 16384 ;;' \
	    'esac; }' > $@

# ----- Shared pre-compiled .s files -----
# runtime.tc と libtc.tc は全タスクが共有するので 1 度だけコンパイルし、
# compile-gen2.sh の CACHED_S_DIR 経由で各タスクビルドに渡す。

build/kernel/shared:
	mkdir -p $@

build/kernel/shared/runtime.s: compiler/runtime.tc $(RUNTIME_DEPS) $(GEN2_TOOLS) | build/kernel/shared
	@echo "Pre-compiling runtime.tc" >&2
	@_ast=$$(mktemp) && _th=$$(mktemp) && \
	build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) build/gen2/tcheck \
	    | $(QEMU_USER) build/gen2/codegen \
	    | $(QEMU_USER) build/gen2/bc2asm > $@ && \
	rm -f "$$_ast" "$$_th"

build/kernel/shared/libtc.s: kernel/tasks/libtc/libtc.tc $(LIBTC_DEPS) $(GEN2_TOOLS) | build/kernel/shared
	@echo "Pre-compiling libtc.tc" >&2
	@_ast=$$(mktemp) && _th=$$(mktemp) && \
	build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) build/gen2/tcheck \
	    | $(QEMU_USER) build/gen2/codegen \
	    | $(QEMU_USER) build/gen2/bc2asm > $@ && \
	rm -f "$$_ast" "$$_th"

SHARED_S := build/kernel/shared/runtime.s build/kernel/shared/libtc.s

# ----- Per-task binaries -----
# 各タスクの .tc + transitive imports + 共有 .s + GEN2 ツールに依存。
# 初回は pattern rule で起動し、.d ファイルで transitive import を追跡。

build/kernel/tasks:
	mkdir -p $@

# Pattern rule に kernel/tasks/%/%.tc を書けない (% は prereq 中 1 回のみ)。
# .tc ファイル依存は .d ファイル (tc_deps_to_d.sh) が提供する。初回は
# .bin が存在しないので無条件にビルドされ、.d が生成される。
build/kernel/tasks/%.bin: $(SHARED_S) $(GEN2_TOOLS) \
    kernel/tasks/task_crt0.s kernel/tasks/task_data.s build/kernel/task_sizes.sh \
    compile-gen2.sh | build/kernel/tasks
	@echo "Building task: $*" >&2
	@_tmp=$$(mktemp -d) && \
	. build/kernel/task_sizes.sh && \
	_arena=$$(task_arena_size $*) && \
	_stack=$$(task_stack_size $*) && \
	printf '    .text\n    .word %s\n    .word %s\n' "$$_arena" "$$_stack" > "$$_tmp/hdr.s" && \
	cat "$$_tmp/hdr.s" kernel/tasks/task_crt0.s > "$$_tmp/crt0.s" && \
	CRT0="$$_tmp/crt0.s" CRT0_DATA=kernel/tasks/task_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    ./compile-gen2.sh -o $@ kernel/tasks/$*/$*.tc 2>/dev/null && \
	rm -rf "$$_tmp"
	@tools/tc_deps_to_d.sh $@ kernel/tasks/$*/$*.tc > $@.d

GUEST_TASK_BINS  := $(foreach t,$(GUEST_TASKS),build/kernel/tasks/$(t).bin)
EXTRA_TASK_BINS  := $(foreach t,$(EXTRA_GUEST_TASKS),build/kernel/tasks/$(t).bin)
ALL_TASK_BINS    := $(GUEST_TASK_BINS) $(EXTRA_TASK_BINS)

-include $(addsuffix .d,$(ALL_TASK_BINS))

# ----- Disk images -----
# 標準イメージ (GUEST_TASKS) と extra イメージ (+ EXTRA_GUEST_TASKS) の 2 種。
# virt カーネルはディスクを実行時に virtio-blk で読むので、カーネル
# バイナリとは独立したターゲット。

DISK_STATIC_DEPS := tests/phase7_hello.tc tests/phase7_min.tc \
    tests/phase7_hello_world.tc kernel/tasks/task_crt0.s \
    kernel/tasks/task_data.s tools/mkfs.py

build/kernel/disk.img: $(GUEST_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) | build/kernel
	@echo "Building disk image: $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" && \
	for t in $(GUEST_TASKS); do \
	    cp build/kernel/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	printf 'hello, mtfs\n' > "$$_r/hello.txt" && \
	{ cp tests/phase7_hello.tc "$$_r/phase7.tc" 2>/dev/null || true; } && \
	{ cp tests/phase7_min.tc "$$_r/phase7_min.tc" 2>/dev/null || true; } && \
	{ cp tests/phase7_hello_world.tc "$$_r/hw.tc" 2>/dev/null || true; } && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat kernel/tasks/task_crt0.s; cat build/kernel/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp kernel/tasks/task_data.s "$$_r/prelude_tail.s" && \
	printf '(imports)\n' > "$$_r/empty_imports.txt" && \
	printf '(imports\n' > "$$_r/imports_open.txt" && \
	printf '(self\n' > "$$_r/self_open.txt" && \
	printf ')\n' > "$$_r/wrap_close.txt" && \
	if [ -f kernel/kern.conf ]; then \
	    mkdir -p "$$_r/etc" && cp kernel/kern.conf "$$_r/etc/kern.conf"; \
	fi && \
	python3 tools/mkfs.py $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

EXTRA_SRC_DEPS := compiler/string_buffer.tc compiler/source_reader.tc \
    compiler/strlib.tc compiler/parse.tc

build/kernel/disk-extra.img: $(ALL_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) $(EXTRA_SRC_DEPS) | build/kernel
	@echo "Building disk image (extra): $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" && \
	for t in $(GUEST_TASKS) $(EXTRA_GUEST_TASKS); do \
	    cp build/kernel/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	printf 'hello, mtfs\n' > "$$_r/hello.txt" && \
	{ cp tests/phase7_hello.tc "$$_r/phase7.tc" 2>/dev/null || true; } && \
	{ cp tests/phase7_min.tc "$$_r/phase7_min.tc" 2>/dev/null || true; } && \
	{ cp tests/phase7_hello_world.tc "$$_r/hw.tc" 2>/dev/null || true; } && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat kernel/tasks/task_crt0.s; cat build/kernel/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp kernel/tasks/task_data.s "$$_r/prelude_tail.s" && \
	printf '(imports)\n' > "$$_r/empty_imports.txt" && \
	printf '(imports\n' > "$$_r/imports_open.txt" && \
	printf '(self\n' > "$$_r/self_open.txt" && \
	printf ')\n' > "$$_r/wrap_close.txt" && \
	if [ -f kernel/kern.conf ]; then \
	    mkdir -p "$$_r/etc" && cp kernel/kern.conf "$$_r/etc/kern.conf"; \
	fi && \
	mkdir -p "$$_r/src" && \
	for s in string_buffer.tc source_reader.tc strlib.tc parse.tc; do \
	    cp compiler/$$s "$$_r/src/$$s" || exit 1; \
	done && \
	python3 tools/mkfs.py $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

# ----- Kernel binary -----
# virt: ディスクイメージとは独立 (実行時に virtio-blk で読む)
# pico2: ディスクイメージを XIP flash に埋め込む

KERNEL_COMPILE_DEPS := $(KERNEL_TC_SOURCES) $(KERNEL_S_SOURCES) \
    $(SHARED_S) $(GEN2_TOOLS) compile-gen2.sh

build/kernel/virt_kernel.bin: $(KERNEL_COMPILE_DEPS) | build/kernel
	@echo "Building kernel: virt" >&2
	@_tmp=$$(mktemp -d) && \
	cat kernel/platform_virt.s kernel/trap_common.s > "$$_tmp/crt0.s" && \
	CRT0="$$_tmp/crt0.s" CRT0_DATA=kernel/crt0_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    ./compile-gen2.sh -o $@ kernel/kernel.tc 2>/dev/null && \
	rm -rf "$$_tmp"

build/kernel/pico2_kernel.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk.img \
    kernel/bin2s.sh tools/bin2uf2.py | build/kernel
	@echo "Building kernel: pico2" >&2
	@_tmp=$$(mktemp -d) && \
	kernel/bin2s.sh build/kernel/disk.img _mtfs_image > "$$_tmp/mtfs_image.s" && \
	cat kernel/platform_pico2.s kernel/trap_common.s > "$$_tmp/crt0.s" && \
	cat kernel/crt0_pico2_data.s "$$_tmp/mtfs_image.s" > "$$_tmp/kern_data.s" && \
	CRT0="$$_tmp/crt0.s" CRT0_DATA="$$_tmp/kern_data.s" \
	    ASM_PROLOGUE="; raw" GEN2_DIR=build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    ./compile-gen2.sh -o "$$_tmp/kernel.bin" kernel/kernel_pico2.tc 2>/dev/null && \
	python3 tools/bin2uf2.py "$$_tmp/kernel.bin" $@ && \
	rm -rf "$$_tmp"

virt-kernel:  build/kernel/virt_kernel.bin
pico2-kernel: build/kernel/pico2_kernel.uf2

# ===== make run — interactive virt boot =====

QEMU_SYSTEM := qemu-system-riscv32
QEMU_DISK   := build/kernel/disk.img
QEMU_ARGS    = -smp 1 -nographic -serial mon:stdio --no-reboot -m 128 \
               -machine virt,aclint=on -bios none \
               -drive file=$(QEMU_DISK),format=raw,if=none,id=blk0 \
               -device virtio-blk-device,drive=blk0 \
               -device loader,file=build/kernel/virt_kernel.bin,addr=0x80000000 \
               -device loader,addr=0x80000000,cpu-num=0

run: build/kernel/virt_kernel.bin build/kernel/disk.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

# run-extra は disk-extra.img (GUEST + EXTRA タスク全部入り) を使う。
# Make が依存を追跡するので強制リビルド不要。
run-extra: QEMU_DISK := build/kernel/disk-extra.img
run-extra: build/kernel/virt_kernel.bin build/kernel/disk-extra.img
	@echo "[qemu] Ctrl-a x to quit, Ctrl-a c for monitor"
	$(QEMU_SYSTEM) $(QEMU_ARGS)

# Pico 2 counterparts. run_pico2_interactive.sh が内部でビルド or
# make pico2-kernel を呼ぶ。--extra は kernel/build.sh 経由 (後方互換)。
.PHONY: run-pico2 run-pico2-extra
run-pico2:
	@echo "[pico2] build + flash + interactive UART (Ctrl-a x to quit)"
	./kernel/run_pico2_interactive.sh

run-pico2-extra:
	@echo "[pico2] build + flash + interactive UART (Ctrl-a x to quit)"
	./kernel/run_pico2_interactive.sh --extra

# ===== test_asm prebuilt binaries (Phase D) =====

build/test/asm:
	mkdir -p $@

TEST_ASM_DEPS := tests/virt_crt0.s $(RUNTIME_DEPS) $(GEN2_TOOLS) compile-gen2.sh

build/test/asm/hello2_virt.bin: tests/hello2.tc $(TEST_ASM_DEPS) | build/test/asm
	CRT0=tests/virt_crt0.s ASM_PROLOGUE='; raw' GEN2_DIR=build/gen2 \
	    ./compile-gen2.sh -o $@ $< 2>/dev/null

build/test/asm/test_timer.bin: tests/test_timer.tc $(TEST_ASM_DEPS) compiler/crt0_tc_data.s | build/test/asm
	CRT0=tests/virt_crt0.s CRT0_DATA=compiler/crt0_tc_data.s ASM_PROLOGUE='; raw' \
	    GEN2_DIR=build/gen2 \
	    ./compile-gen2.sh -o $@ $< 2>/dev/null

build/test/asm/test_echo.bin: tests/test_echo.tc $(TEST_ASM_DEPS) compiler/crt0_tc_data.s | build/test/asm
	CRT0=tests/virt_crt0.s CRT0_DATA=compiler/crt0_tc_data.s ASM_PROLOGUE='; raw' \
	    GEN2_DIR=build/gen2 \
	    ./compile-gen2.sh -o $@ $< 2>/dev/null

TEST_ASM_BINS := build/test/asm/hello2_virt.bin \
                 build/test/asm/test_timer.bin \
                 build/test/asm/test_echo.bin

test-asm-bins: $(TEST_ASM_BINS)

clean:
	rm -f $(OBJS) bootstrap/parse_main.o bootstrap/typecheck_main.o bootstrap/interp_main.o bootstrap/codegen_main.o
	rm -rf build

# ===== test stamp files =====

BUILD_DEPS := $(GEN1_TOOLS) $(GEN2_TOOLS) build/kernel/virt_kernel.bin \
              build/kernel/disk.img $(TEST_ASM_BINS)

TEST_SCRIPTS := $(wildcard tests/*.sh)
TEST_INPUTS  := $(wildcard tests/*.tc) $(wildcard tests/import/*.tc)
TEST_GOLDEN  := $(wildcard tests/golden/*) $(wildcard tests/golden/tc/*)
TEST_SUPPORT := tc_run.sh tc_run_all.sh compile-gen1.sh compile-gen2.sh compile-gen3.sh

ALL_TEST_DEPS := $(BUILD_DEPS) $(TEST_SCRIPTS) $(TEST_INPUTS) $(TEST_GOLDEN) $(TEST_SUPPORT)

build/tests:
	mkdir -p $@

build/tests/test.ok: $(ALL_TEST_DEPS) | build/tests
	./tests/test_all.sh
	@touch $@

build/tests/full-test.ok: $(ALL_TEST_DEPS) | build/tests
	FULL_TEST=1 ./tests/test_all.sh
	@touch $@

test: build/tests/test.ok

full-test: build/tests/full-test.ok

update-golden: all
	./tests/update_golden.sh

update-golden-and-run-test: $(BUILD_DEPS)
	./tests/update_golden.sh
	rm -f build/tests/test.ok
	$(MAKE) test

# 並列ビルド禁止: compile-gen2.sh の CACHED_S_DIR / qemu state が race
# するのを避ける。ログも読みやすくなる。
.NOTPARALLEL:

.PHONY: all clean test full-test update-golden update-golden-and-run-test \
        gen2-tools gen3-tools virt-kernel pico2-kernel test-asm-bins \
        run run-extra run-pico2 run-pico2-extra

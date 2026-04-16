CC = gcc
CFLAGS = -Wall -Wextra -g -I bootstrap

SRCS = bootstrap/lexer.c bootstrap/ast.c bootstrap/parser.c bootstrap/typecheck.c bootstrap/interp.c bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

# Gen1 ツール (C 製、build/gen1/ 固定。repo 直下には置かない)
GEN1_NAMES = parse typecheck interp codegen bcrun bc2asm extract-sigs
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

build/gen1/extract-sigs: bootstrap/extract_sigs.c bootstrap/ast.o | build/gen1
	$(CC) $(CFLAGS) -o $@ bootstrap/extract_sigs.c bootstrap/ast.o

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

# ===== kernel build (Phase C) =====
#
# kernel/build.sh を monolithic に呼ぶが、正しい dependency グラフを
# 張ることで「触っていないときは make がスキップ」する。
#
# 依存:
#   - 全 kernel .tc / .s ソース
#   - 全 task .tc ソース (transitive import は phony に頼り切らず、
#     GNU Make の $(shell ...) で tools/collect_imports.sh から取得)
#   - compiler/runtime.tc とその imports (runtime.s の pre-compile 元)
#   - kernel/tasks/libtc/libtc.tc とその imports
#   - $(GEN2_TOOLS)
#   - kernel/build.sh 自体
#
# virt_kernel.bin と disk.img は同じ recipe で生成されるので grouped
# target (`&:`) でまとめる (GNU Make 4.3+)。pico2 側の disk.img は XIP
# に埋め込まれるので出力ファイルとしては同じ build/kernel/disk.img を
# 共有する。`.NOTPARALLEL:` で serial 実行を強制するので race しない。

KERNEL_TC_SOURCES := $(wildcard kernel/*.tc)
KERNEL_S_SOURCES  := kernel/platform_virt.s kernel/platform_pico2.s \
                     kernel/trap_common.s kernel/crt0_data.s \
                     kernel/crt0_pico2_data.s \
                     kernel/tasks/task_crt0.s kernel/tasks/task_data.s

# compile-gen2.sh 経由のビルドが毎回 compiler/runtime.tc を pre-compile
# するので、transitive import も含めた依存ファイル一覧を Make に渡す。
# $(shell ...) は Makefile パース時に評価されるので tools は既に存在
# している必要がある → git 管理下に置く。
RUNTIME_DEPS := $(shell tools/collect_imports.sh compiler/runtime.tc 2>/dev/null)
LIBTC_DEPS   := $(shell tools/collect_imports.sh kernel/tasks/libtc/libtc.tc 2>/dev/null)

# task の transitive import 一覧。TASKS list は build.sh と揃える。
GUEST_TASKS := hello hello2 catfile sh tmpdemo echo launcher cat
TASK_TC_SOURCES := $(foreach t,$(GUEST_TASKS),\
                     $(shell tools/collect_imports.sh kernel/tasks/$(t)/$(t).tc 2>/dev/null))

KERNEL_BUILD_DEPS := \
    $(KERNEL_TC_SOURCES) \
    $(KERNEL_S_SOURCES) \
    $(RUNTIME_DEPS) \
    $(LIBTC_DEPS) \
    $(TASK_TC_SOURCES) \
    $(GEN2_TOOLS) \
    kernel/build.sh \
    tools/mkfs.py \
    tests/phase7_hello.tc tests/phase7_min.tc tests/phase7_hello_world.tc

build/kernel:
	mkdir -p $@

build/kernel/virt_kernel.bin build/kernel/disk.img &: $(KERNEL_BUILD_DEPS) | build/kernel
	GEN2_DIR=build/gen2 ./kernel/build.sh --target virt \
	    -o build/kernel/virt_kernel.bin \
	    --disk-out build/kernel/disk.img

build/kernel/pico2_kernel.uf2: $(KERNEL_BUILD_DEPS) | build/kernel
	GEN2_DIR=build/gen2 ./kernel/build.sh --target pico2 \
	    -o $@

virt-kernel:  build/kernel/virt_kernel.bin
pico2-kernel: build/kernel/pico2_kernel.uf2

# ===== test_asm prebuilt binaries (Phase D) =====
#
# tests/test_asm.sh compiles 3 small bare-metal .tc programs with
# the virt crt0 to smoke-test the compile-gen2.sh pipeline in a raw
# mode. Without Make caching it re-compiles them (~7 s) every run.
# Move those builds here so make test 2 回目以降は compile をスキップ。

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

TEST_DEPS := all $(GEN2_TOOLS) build/kernel/virt_kernel.bin $(TEST_ASM_BINS)

test: $(TEST_DEPS)
	./tests/test_all.sh

full-test: $(TEST_DEPS)
	FULL_TEST=1 ./tests/test_all.sh

update-golden: all
	./tests/update_golden.sh

update-golden-and-run-test: $(TEST_DEPS)
	./tests/update_golden.sh
	./tests/test_all.sh

# 並列ビルド禁止: compile-gen2.sh の CACHED_S_DIR / qemu state が race
# するのを避ける。ログも読みやすくなる。
.NOTPARALLEL:

.PHONY: all clean test full-test update-golden update-golden-and-run-test \
        gen2-tools gen3-tools virt-kernel pico2-kernel test-asm-bins

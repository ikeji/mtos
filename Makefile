CC = gcc
CFLAGS = -Wall -Wextra -g -I bootstrap

SRCS = bootstrap/lexer.c bootstrap/ast.c bootstrap/parser.c bootstrap/typecheck.c bootstrap/interp.c bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

# Gen1 ツール (C 製、repo 直下に置く。Phase A では build/gen1/ 移動
# はせず、後続 Phase で整理する)
GEN1_TOOLS = parse typecheck interp codegen bcrun bc2asm extract-sigs

# Gen2 ツール (compile-gen1.sh で compiler/*.tc を RV32 ELF に。
# build/gen2/ 固定にして make test 2 回目以降は再ビルドを避ける)
GEN2_NAMES = parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2
GEN2_TOOLS = $(addprefix build/gen2/,$(GEN2_NAMES))

all: $(GEN1_TOOLS)

parse: $(OBJS) bootstrap/parse_main.o
	$(CC) -o $@ $^

typecheck: $(OBJS) bootstrap/typecheck_main.o
	$(CC) -o $@ $^

interp: $(OBJS) bootstrap/interp_main.o
	$(CC) -o $@ $^

codegen: $(OBJS) bootstrap/codegen_main.o
	$(CC) -o $@ $^

bcrun: bootstrap/bcrun.c
	$(CC) $(CFLAGS) -o bcrun bootstrap/bcrun.c

bc2asm: bootstrap/bc2asm.c
	$(CC) $(CFLAGS) -o bc2asm bootstrap/bc2asm.c

extract-sigs: bootstrap/extract_sigs.c bootstrap/ast.o
	$(CC) $(CFLAGS) -o extract-sigs bootstrap/extract_sigs.c bootstrap/ast.o

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

clean:
	rm -f $(OBJS) bootstrap/parse_main.o bootstrap/typecheck_main.o bootstrap/interp_main.o bootstrap/codegen_main.o parse typecheck interp codegen bcrun bc2asm extract-sigs
	rm -rf build

test: all $(GEN2_TOOLS) build/kernel/virt_kernel.bin
	./tests/test_all.sh

full-test: all $(GEN2_TOOLS) build/kernel/virt_kernel.bin
	FULL_TEST=1 ./tests/test_all.sh

update-golden: all
	./tests/update_golden.sh

update-golden-and-run-test: all $(GEN2_TOOLS) build/kernel/virt_kernel.bin
	./tests/update_golden.sh
	./tests/test_all.sh

# 並列ビルド禁止: compile-gen2.sh の CACHED_S_DIR / qemu state が race
# するのを避ける。ログも読みやすくなる。
.NOTPARALLEL:

.PHONY: all clean test full-test update-golden update-golden-and-run-test \
        gen2-tools virt-kernel pico2-kernel

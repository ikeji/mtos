CC = gcc
CFLAGS = -Wall -Wextra -g -I compiler/bootstrap

SRCS = compiler/bootstrap/lexer.c compiler/bootstrap/ast.c compiler/bootstrap/parser.c compiler/bootstrap/typecheck.c compiler/bootstrap/interp.c compiler/bootstrap/codegen.c
OBJS = $(SRCS:.c=.o)

# Gen1 ツール (C 製、compiler/build/gen1/ 固定。repo 直下には置かない)
GEN1_NAMES = parse typecheck interp codegen bcrun bc2asm
GEN1_TOOLS = $(addprefix compiler/build/gen1/,$(GEN1_NAMES))

# Gen2 ツール (compile-gen1.sh で compiler/*.tc を RV32 ELF に。
# compiler/build/gen2/ 固定にして make test 2 回目以降は再ビルドを避ける)
GEN2_NAMES = parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2 asm_pass3
GEN2_TOOLS = $(addprefix compiler/build/gen2/,$(GEN2_NAMES))

all: $(GEN1_TOOLS)

compiler/build/gen1:
	mkdir -p $@

compiler/build/gen1/parse: $(OBJS) compiler/bootstrap/parse_main.o | compiler/build/gen1
	$(CC) -o $@ $^

compiler/build/gen1/typecheck: $(OBJS) compiler/bootstrap/typecheck_main.o | compiler/build/gen1
	$(CC) -o $@ $^

compiler/build/gen1/interp: $(OBJS) compiler/bootstrap/interp_main.o | compiler/build/gen1
	$(CC) -o $@ $^

compiler/build/gen1/codegen: $(OBJS) compiler/bootstrap/codegen_main.o | compiler/build/gen1
	$(CC) -o $@ $^

compiler/build/gen1/bcrun: compiler/bootstrap/bcrun.c | compiler/build/gen1
	$(CC) $(CFLAGS) -o $@ compiler/bootstrap/bcrun.c

compiler/build/gen1/bc2asm: compiler/bootstrap/bc2asm.c | compiler/build/gen1
	$(CC) $(CFLAGS) -o $@ compiler/bootstrap/bc2asm.c

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Gen2 ツールを compile-gen1.sh で build。transitive import 追跡は
# recipe 末尾で `compiler/scripts/tc_deps_to_d.sh` が .d を書き出し、top Makefile
# が `-include` で取り込む (Phase B)。2 回目以降の make test はこの .d
# で「触っていない .tc 経由のツール」を正しくスキップできる。
compiler/build/gen2:
	mkdir -p $@

compiler/build/gen2/%: compiler/src/%.tc $(GEN1_TOOLS) compiler/scripts/collect_imports.sh compiler/scripts/tc_deps_to_d.sh | compiler/build/gen2
	./compiler/scripts/compile-gen1.sh -o $@ $<
	./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

# Phase 8: bin2uf2 host tool ported to TC. Built from kernel/tools-src/bin2uf2.tc
# the same way Gen2 tools are. Produces an RV32 ELF run via
# qemu-riscv32 — replaces the python3 tools/bin2uf2.py invocation in
# the kernel build path.
compiler/build/gen2/bin2uf2: kernel/tools-src/bin2uf2.tc $(GEN1_TOOLS) compiler/scripts/collect_imports.sh compiler/scripts/tc_deps_to_d.sh compiler/bootstrap/crt0.s compiler/bootstrap/runtime_syscall.c | compiler/build/gen2
	./compiler/scripts/compile-gen1.sh -o $@ $<
	./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

# Phase 8: mkfs host tool ported to TC. Reads a directory tree and
# emits a flat MyTinyFS image, byte-exact with tools/mkfs.py
# (including its 4-byte-per-real-inode tail truncation so existing
# md5 fixtures still match). Uses statx (291) for path stat — qemu
# RISC-V user mode doesn't implement fstat (80) or newfstatat (79).
compiler/build/gen2/mkfs: kernel/tools-src/mkfs.tc $(GEN1_TOOLS) compiler/scripts/collect_imports.sh compiler/scripts/tc_deps_to_d.sh compiler/bootstrap/crt0.s compiler/bootstrap/runtime_syscall.c | compiler/build/gen2
	./compiler/scripts/compile-gen1.sh -o $@ $<
	./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

gen2-tools: $(GEN2_TOOLS)

# .d の内容を取り込む。Phase B で導入。初回ビルドでは存在しないので
# `-include` (エラーにしない) を使う
-include $(addsuffix .d,$(GEN2_TOOLS))

# ===== Gen3 tools (Phase E) =====
#
# Gen3 は Gen2 ツール (Gen1 で build した TC 製ツール) を使って
# compiler/*.tc を再 build したもの。自己ホスト確認 (Gen2==Gen3)
# と、kernel build の本番経路候補に使う。compiler/build/gen2/ と同じ流れで
# `.d` による transitive import 追跡を入れる。
GEN3_NAMES = $(GEN2_NAMES)
GEN3_TOOLS = $(addprefix compiler/build/gen3/,$(GEN3_NAMES))

compiler/build/gen3:
	mkdir -p $@

compiler/build/gen3/%: compiler/src/%.tc $(GEN2_TOOLS) compiler/scripts/collect_imports.sh compiler/scripts/tc_deps_to_d.sh | compiler/build/gen3
	GEN2_DIR=compiler/build/gen2 ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null
	./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

gen3-tools: $(GEN3_TOOLS)

-include $(addsuffix .d,$(GEN3_TOOLS))

# ===== kernel build (decomposed) =====
#
# kernel/build.sh を per-task / disk / kernel の 3 段階に分解。
# タスクバイナリは個別 Make ターゲットで incremental build。
# ディスクイメージは 2 種 (標準 / extra)。カーネルバイナリは
# ディスクと独立 (virt)。.NOTPARALLEL: で serial 実行を強制。

KERNEL_TC_SOURCES := $(wildcard kernel/src/*.tc) $(wildcard kernel/platform/virt/*.tc) $(wildcard kernel/platform/pico2/*.tc)
KERNEL_S_SOURCES  := kernel/platform/virt/platform_virt.s kernel/platform/pico2/platform_pico2.s \
                     kernel/src/trap_common.s kernel/platform/virt/crt0_data.s \
                     kernel/platform/pico2/crt0_pico2_data.s \
                     compiler/runtime/mtos/task_crt0.s compiler/runtime/mtos/task_data.s

RUNTIME_DEPS := $(shell compiler/scripts/collect_imports.sh compiler/src/runtime.tc 2>/dev/null)
LIBTC_DEPS   := $(shell compiler/scripts/collect_imports.sh userland/lib/libtc/libtc.tc 2>/dev/null)

# task の定義は userland/bin/*/task.mk から include。各 task.mk が
# GUEST_TASKS += <name> または EXTRA_GUEST_TASKS += <name> と
# TASK_ARENA_<name> / TASK_STACK_<name> を宣言。
GUEST_TASKS :=
EXTRA_GUEST_TASKS :=
-include $(wildcard userland/bin/*/task.mk)
# DROP_TASKS allows shaving disk-extra.img to fit pico2's 4 MiB
# flash when the kernel itself grew (e.g. dumper + bin2uf2). The
# default empty list keeps every task; CI / day-to-day builds are
# untouched. Self-build pipeline kernels pass DROP_TASKS=vi+tcc+...
GUEST_TASKS       := $(filter-out $(DROP_TASKS),$(GUEST_TASKS))
EXTRA_GUEST_TASKS := $(filter-out $(DROP_TASKS),$(EXTRA_GUEST_TASKS))
ALL_TASK_NAMES := $(GUEST_TASKS) $(EXTRA_GUEST_TASKS)

TASK_MK_FILES := $(wildcard userland/bin/*/task.mk)
QEMU_USER := qemu-riscv32

build/kernel:
	mkdir -p $@

# `)` を Makefile 内で安全に使うためのヘルパー変数
close_paren := )

# task_sizes.sh: per-task arena/stack サイズを bash 関数で提供。
# kernel/build.sh (後方互換) と per-task ビルドレシピが source する。
build/kernel/task_sizes.sh: $(TASK_MK_FILES) Makefile | build/kernel
	@printf '%s\n' \
	    '# auto-generated from userland/bin/*/task.mk' \
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

build/kernel/shared/runtime.s: compiler/src/runtime.tc $(RUNTIME_DEPS) $(GEN2_TOOLS) | build/kernel/shared
	@echo "Pre-compiling runtime.tc" >&2
	@_ast=$$(mktemp) && _th=$$(mktemp) && \
	compiler/build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) compiler/build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) compiler/build/gen2/tcheck \
	    | $(QEMU_USER) compiler/build/gen2/codegen \
	    | $(QEMU_USER) compiler/build/gen2/bc2asm > $@ && \
	rm -f "$$_ast" "$$_th"

build/kernel/shared/libtc.s: userland/lib/libtc/libtc.tc $(LIBTC_DEPS) $(GEN2_TOOLS) | build/kernel/shared
	@echo "Pre-compiling libtc.tc" >&2
	@_ast=$$(mktemp) && _th=$$(mktemp) && \
	compiler/build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) compiler/build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) compiler/build/gen2/tcheck \
	    | $(QEMU_USER) compiler/build/gen2/codegen \
	    | $(QEMU_USER) compiler/build/gen2/bc2asm > $@ && \
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
    compiler/runtime/mtos/task_crt0.s compiler/runtime/mtos/task_data.s build/kernel/task_sizes.sh \
    compiler/scripts/compile-gen2.sh | build/kernel/tasks
	@echo "Building task: $*" >&2
	@_tmp=$$(mktemp -d) && \
	. build/kernel/task_sizes.sh && \
	_arena=$$(task_arena_size $*) && \
	_stack=$$(task_stack_size $*) && \
	printf '    .text\n    .word %s\n    .word %s\n' "$$_arena" "$$_stack" > "$$_tmp/hdr.s" && \
	CRT0="$$_tmp/hdr.s compiler/runtime/mtos/task_crt0.s" \
	    CRT0_DATA=compiler/runtime/mtos/task_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    EXTRA_S="$(TASK_EXTRA_S_$*)" \
	    ./compiler/scripts/compile-gen2.sh -o $@ userland/bin/$*/$*.tc 2>/dev/null && \
	rm -rf "$$_tmp"
	@compiler/scripts/tc_deps_to_d.sh $@ userland/bin/$*/$*.tc > $@.d

GUEST_TASK_BINS  := $(foreach t,$(GUEST_TASKS),build/kernel/tasks/$(t).bin)
EXTRA_TASK_BINS  := $(foreach t,$(EXTRA_GUEST_TASKS),build/kernel/tasks/$(t).bin)
ALL_TASK_BINS    := $(GUEST_TASK_BINS) $(EXTRA_TASK_BINS)

-include $(addsuffix .d,$(ALL_TASK_BINS))

# ----- Disk images -----
# 標準イメージ (GUEST_TASKS) と extra イメージ (+ EXTRA_GUEST_TASKS) の 2 種。
# virt カーネルはディスクを実行時に virtio-blk で読むので、カーネル
# バイナリとは独立したターゲット。

DISK_STATIC_DEPS := integration/inputs/phase7_hello.tc integration/inputs/phase7_min.tc \
    integration/inputs/phase7_hello_world.tc compiler/runtime/mtos/task_crt0.s \
    compiler/runtime/mtos/task_data.s compiler/build/gen2/mkfs

# disk.img は kernel/kern.conf があれば /etc/kern.conf としてステージする
# (なければカーネル側のハードコード init にフォールバック)。
# disk-demo.img は tests/fixtures/kern_demo.conf を強制ステージして、
# test_os.sh が kern.conf 駆動の init を検証できるようにする。
build/kernel/disk.img:              DISK_KERN_CONF := $(wildcard kernel/kern.conf)
build/kernel/disk-demo.img:         DISK_KERN_CONF := kernel/tests/fixtures/kern_demo.conf
build/kernel/disk-console.img:      DISK_KERN_CONF := kernel/tests/fixtures/kern_console.conf
build/kernel/disk-console-land.img: DISK_KERN_CONF := kernel/tests/fixtures/kern_console_land.conf

# Japanese font: tmp/font.bmp (np21w PC-98 font, user-supplied, never
# committed) is converted by genjpfont.py into jpfont.dat, then
# bin2s_incbin.sh wraps it as jpfont_inc.s — a .incbin that links the
# font into /bin/console's binary (TASK_EXTRA_S_console). console
# reads the blob in place via peek8. font.bmp is mandatory: without it
# /bin/console cannot be built.
FONT_BMP := $(wildcard tmp/font.bmp)
ifeq ($(FONT_BMP),)
build/kernel/jpfont_inc.s:
	@echo 'Error: tmp/font.bmp is required to build /bin/console.' >&2
	@echo '  Download the np21w PC-98 font from:' >&2
	@echo '  https://simk98.github.io/np21w/download.html' >&2
	@echo '  and place font.bmp at tmp/font.bmp' >&2
	@false
else
build/kernel/jpfont.dat: $(FONT_BMP) kernel/scripts/genjpfont.py | build/kernel
	@python3 kernel/scripts/genjpfont.py $(FONT_BMP) $@
build/kernel/jpfont_inc.s: build/kernel/jpfont.dat kernel/scripts/bin2s_incbin.sh | build/kernel
	@kernel/scripts/bin2s_incbin.sh build/kernel/jpfont.dat jpfont build/kernel/jpfont.dat > $@
endif

TASK_EXTRA_S_console := build/kernel/jpfont_inc.s
build/kernel/tasks/console.bin: build/kernel/jpfont_inc.s

# Pre-encode the prelude (Step 5 of pre-encode, docs/task/asm_pre_encode.md):
# at kernel-build time we pre-encode the concatenation of prelude.s +
# prelude_tail.s (the same bookends the user code is sandwiched between
# at OS-runtime link) so OS-side asm_pass3 can `src raw` memcpy +
# reloc-patch instead of re-tokenising the ~10000-line prelude.
#
# Phase C/D/E of the 3-binary split (2026-05-07): asm_pass1 does the
# idx emit + concat + lab build + bin/reloc emit in a single
# invocation. `_r` is the staging dir set by the disk-image recipe.
define PRELUDE_PRE_ENCODE
    qemu-riscv32 compiler/build/gen2/asm_pass1 \
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

build/kernel/disk.img build/kernel/disk-demo.img build/kernel/disk-console.img build/kernel/disk-console-land.img: $(GUEST_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) compiler/build/gen2/asm_pass1 compiler/build/gen2/asm_pass2 compiler/build/gen2/asm_pass3 | build/kernel
	@echo "Building disk image: $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" && \
	for t in $(GUEST_TASKS); do \
	    cp build/kernel/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	printf 'hello, mtfs\n' > "$$_r/hello.txt" && \
	{ cp integration/inputs/phase7_hello.tc "$$_r/phase7.tc" 2>/dev/null || true; } && \
	{ cp integration/inputs/phase7_min.tc "$$_r/phase7_min.tc" 2>/dev/null || true; } && \
	{ cp integration/inputs/phase7_hello_world.tc "$$_r/hw.tc" 2>/dev/null || true; } && \
	{ cp kernel/tests/fixtures/msh_smoke.sh "$$_r/msh_smoke.sh" 2>/dev/null || true; } && \
	{ cp kernel/tests/fixtures/msh_abort.sh "$$_r/msh_abort.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_bench_idx.sh "$$_r/pico2_bench_idx.sh" 2>/dev/null || true; } && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat compiler/runtime/mtos/task_crt0.s; cat build/kernel/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp compiler/runtime/mtos/task_data.s "$$_r/prelude_tail.s" && \
	$(PRELUDE_PRE_ENCODE) && \
	printf '(imports)\n' > "$$_r/empty_imports.txt" && \
	printf '(imports\n' > "$$_r/imports_open.txt" && \
	printf '(self\n' > "$$_r/self_open.txt" && \
	printf ')\n' > "$$_r/wrap_close.txt" && \
	if [ -n "$(DISK_KERN_CONF)" ] && [ -f "$(DISK_KERN_CONF)" ]; then \
	    mkdir -p "$$_r/etc" && cp "$(DISK_KERN_CONF)" "$$_r/etc/kern.conf"; \
	fi && \
	qemu-riscv32 compiler/build/gen2/mkfs $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

build/kernel/disk.img build/kernel/disk-demo.img build/kernel/disk-console.img build/kernel/disk-console-land.img: kernel/tests/fixtures/msh_smoke.sh kernel/tests/fixtures/msh_abort.sh integration/fixtures/pico2_bench_idx.sh
build/kernel/disk-demo.img:         kernel/tests/fixtures/kern_demo.conf
build/kernel/disk-console.img:      kernel/tests/fixtures/kern_console.conf
build/kernel/disk-console-land.img: kernel/tests/fixtures/kern_console_land.conf

EXTRA_SRC_DEPS := compiler/src/string_buffer.tc compiler/src/source_reader.tc \
    compiler/src/strlib.tc compiler/src/ast_node.tc compiler/src/asm_common.tc \
    compiler/src/parse.tc compiler/src/sigscan.tc compiler/src/tcheck.tc \
    compiler/src/codegen.tc compiler/src/bc2asm.tc compiler/src/asm_pass2.tc \
    compiler/src/asm_pass3.tc compiler/src/runtime.tc \
    userland/lib/libtc/libtc.tc \
    kernel/src/kernel_common.tc kernel/platform/pico2/block_flash.tc kernel/platform/pico2/block_sd.tc \
    kernel/src/tmpfs.tc kernel/src/fatfs.tc kernel/src/mtfs.tc kernel/src/procfs.tc \
    kernel/src/vfs.tc kernel/src/loader.tc kernel/src/kernel_pico2.tc \
    kernel/platform/pico2/platform_pico2.tc \
    kernel/platform/pico2/platform_pico2.s kernel/src/trap_common.s kernel/platform/pico2/crt0_pico2_data.s

build/kernel/disk-extra.img: $(ALL_TASK_BINS) $(SHARED_S) $(DISK_STATIC_DEPS) $(EXTRA_SRC_DEPS) compiler/build/gen2/asm_pass1 compiler/build/gen2/asm_pass2 compiler/build/gen2/asm_pass3 kernel/tests/fixtures/msh_smoke.sh kernel/tests/fixtures/msh_abort.sh integration/fixtures/pico2_bench_idx.sh integration/fixtures/pico2_compile_sb.sh integration/fixtures/pico2_compile_parse.sh integration/fixtures/pico2_compile_sigscan.sh integration/fixtures/pico2_compile_tcheck.sh integration/fixtures/pico2_compile_codegen.sh integration/fixtures/pico2_compile_bc2asm.sh integration/fixtures/pico2_compile_asm_pass1.sh integration/fixtures/pico2_compile_asm_pass2.sh integration/fixtures/pico2_compile_asm_pass3.sh integration/fixtures/pico2_compile_runtime.sh integration/fixtures/pico2_compile_libtc.sh integration/fixtures/pico2_compile_kern.sh integration/fixtures/pico2_compile_platform.sh integration/fixtures/pico2_compile_kern2.sh integration/fixtures/pico2_run_parse.sh integration/fixtures/pico2_md5_test.sh integration/fixtures/pico2_cleanup_sd.sh integration/fixtures/pico2_dir_grow_test.sh integration/fixtures/pico2_dir_grow_test2.sh kernel/scripts/bin2s_incbin.sh build/kernel/disk.img | build/kernel
	@echo "Building disk image (extra): $@" >&2
	@_tmp=$$(mktemp -d) && _r="$$_tmp/root" && \
	mkdir -p "$$_r/bin" && \
	for t in $(GUEST_TASKS) $(EXTRA_GUEST_TASKS); do \
	    cp build/kernel/tasks/$$t.bin "$$_r/bin/$$t" || exit 1; \
	done && \
	printf 'hello, mtfs\n' > "$$_r/hello.txt" && \
	{ cp integration/inputs/phase7_hello.tc "$$_r/phase7.tc" 2>/dev/null || true; } && \
	{ cp integration/inputs/phase7_min.tc "$$_r/phase7_min.tc" 2>/dev/null || true; } && \
	{ cp integration/inputs/phase7_hello_world.tc "$$_r/hw.tc" 2>/dev/null || true; } && \
	{ cp kernel/tests/fixtures/msh_smoke.sh "$$_r/msh_smoke.sh" 2>/dev/null || true; } && \
	{ cp kernel/tests/fixtures/msh_abort.sh "$$_r/msh_abort.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_bench_idx.sh "$$_r/pico2_bench_idx.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_sb.sh "$$_r/pico2_compile_sb.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_parse.sh "$$_r/pico2_compile_parse.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_sigscan.sh "$$_r/pico2_compile_sigscan.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_tcheck.sh "$$_r/pico2_compile_tcheck.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_codegen.sh "$$_r/pico2_compile_codegen.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_bc2asm.sh "$$_r/pico2_compile_bc2asm.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_asm_pass1.sh "$$_r/pico2_compile_asm_pass1.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_asm_pass2.sh "$$_r/pico2_compile_asm_pass2.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_asm_pass3.sh "$$_r/pico2_compile_asm_pass3.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_runtime.sh "$$_r/pico2_compile_runtime.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_libtc.sh "$$_r/pico2_compile_libtc.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_kern.sh "$$_r/pico2_compile_kern.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_platform.sh "$$_r/pico2_compile_platform.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_kern2.sh "$$_r/pico2_compile_kern2.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_run_parse.sh "$$_r/pico2_run_parse.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_run_sb.sh "$$_r/pico2_run_sb.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_md5_test.sh "$$_r/pico2_md5_test.sh" 2>/dev/null || true; } && \
	{ printf '; raw\n'; printf '    .text\n    .word 65536\n    .word 8192\n'; \
	  cat compiler/runtime/mtos/task_crt0.s; cat build/kernel/shared/runtime.s; \
	} > "$$_r/prelude.s" && \
	cp compiler/runtime/mtos/task_data.s "$$_r/prelude_tail.s" && \
	$(PRELUDE_PRE_ENCODE) && \
	printf '(imports)\n' > "$$_r/empty_imports.txt" && \
	printf '(imports\n' > "$$_r/imports_open.txt" && \
	printf '(self\n' > "$$_r/self_open.txt" && \
	printf ')\n' > "$$_r/wrap_close.txt" && \
	if [ -f kernel/kern.conf ]; then \
	    mkdir -p "$$_r/etc" && cp kernel/kern.conf "$$_r/etc/kern.conf"; \
	fi && \
	mkdir -p "$$_r/src" && \
	for s in string_buffer.tc source_reader.tc strlib.tc ast_node.tc asm_common.tc asm_dead_strip.tc parse.tc sigscan.tc tcheck.tc codegen.tc bc2asm.tc asm_pass1.tc asm_pass2.tc asm_pass2_lib.tc asm_pass3.tc asm_pass3_lib.tc runtime.tc; do \
	    cp compiler/src/$$s "$$_r/src/$$s" || exit 1; \
	done && \
	cp userland/lib/libtc/libtc.tc "$$_r/src/libtc.tc" && \
	for s in kernel_common.tc tmpfs.tc fatfs.tc mtfs.tc procfs.tc vfs.tc loader.tc kernel_pico2.tc; do \
	    cp kernel/src/$$s "$$_r/src/$$s" || exit 1; \
	done && \
	for s in platform_pico2.tc block_flash.tc block_sd.tc; do \
	    cp kernel/platform/pico2/$$s "$$_r/src/$$s" || exit 1; \
	done && \
	cp kernel/platform/pico2/platform_pico2.s "$$_r/src/platform_pico2.s" && \
	cp kernel/src/trap_common.s "$$_r/src/trap_common.s" && \
	cp kernel/platform/pico2/crt0_pico2_data.s "$$_r/src/crt0_pico2_data.s" && \
	cp compiler/runtime/mtos/task_crt0.s "$$_r/src/task_crt0.s" && \
	cp compiler/runtime/mtos/task_data.s "$$_r/src/task_data.s" && \
	printf '; raw\n' > "$$_r/src/raw.s" && \
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
	{ cp integration/fixtures/pico2_cleanup_sd.sh "$$_r/pico2_cleanup_sd.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_dir_grow_test.sh "$$_r/pico2_dir_grow_test.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_dir_grow_test2.sh "$$_r/pico2_dir_grow_test2.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_dumper_test.sh "$$_r/pico2_dumper_test.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_self_step1.sh "$$_r/pico2_self_step1.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_self_step2.sh "$$_r/pico2_self_step2.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_self_step3.sh "$$_r/pico2_self_step3.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_self_step4.sh "$$_r/pico2_self_step4.sh" 2>/dev/null || true; } && \
	{ cp integration/fixtures/pico2_compile_compilers.sh "$$_r/pico2_compile_compilers.sh" 2>/dev/null || true; } && \
	qemu-riscv32 compiler/build/gen2/mkfs $@ "$$_r" >&2 && \
	rm -rf "$$_tmp"

# ----- Kernel binary -----
# virt: ディスクイメージとは独立 (実行時に virtio-blk で読む)
# pico2: ディスクイメージを XIP flash に埋め込む

KERNEL_COMPILE_DEPS := $(KERNEL_TC_SOURCES) $(KERNEL_S_SOURCES) \
    $(SHARED_S) $(GEN2_TOOLS) compiler/scripts/compile-gen2.sh

build/kernel/virt_kernel.bin: $(KERNEL_COMPILE_DEPS) | build/kernel
	@echo "Building kernel: virt" >&2
	@CRT0="kernel/platform/virt/platform_virt.s kernel/src/trap_common.s" \
	    CRT0_DATA=kernel/platform/virt/crt0_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    ./compiler/scripts/compile-gen2.sh -o $@ kernel/src/kernel.tc 2>/dev/null

PICO2_DISK = build/kernel/disk.img
# Recipe shared by pico2_kernel.uf2 and pico2_kernel_extra.uf2.
# `dx.img` as the incbin BLOB_PATH matches the on-device dumper's
# wrap.s shape — asm_pass2 then emits a basename-only `src raw dx.img`
# line, and asm_pass3 resolves it relative to the .lab's directory
# (build/intermediate/gen2/kernel_pico2/). We stage a copy of
# $(PICO2_DISK) there as `dx.img` so the resolver finds it.
define PICO2_KERNEL_RECIPE
	@echo "Building kernel: pico2 (disk=$(PICO2_DISK))" >&2
	@_tmp=$$(mktemp -d) && \
	_labdir=build/intermediate/gen2/kernel_pico2 && \
	mkdir -p "$$_labdir" && \
	cp $(PICO2_DISK) "$$_labdir/dx.img" && \
	kernel/scripts/bin2s_incbin.sh $(PICO2_DISK) _mtfs_image dx.img > "$$_tmp/mtfs_image.s" && \
	CRT0="kernel/platform/pico2/platform_pico2.s kernel/src/trap_common.s" \
	    CRT0_DATA="kernel/platform/pico2/crt0_pico2_data.s $$_tmp/mtfs_image.s" \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=build/kernel/shared \
	    ./compiler/scripts/compile-gen2.sh -o "$$_tmp/kernel.bin" kernel/src/kernel_pico2.tc 2>/dev/null && \
	_ksz=$$(wc -c < "$$_tmp/kernel.bin") && \
	_dsz=$$(wc -c < $(PICO2_DISK)) && \
	printf '  kernel.bin: %s bytes, disk: %s bytes\n' "$$_ksz" "$$_dsz" >&2 && \
	qemu-riscv32 compiler/build/gen2/bin2uf2 "$$_tmp/kernel.bin" $@ && \
	rm -rf "$$_tmp"
endef

build/kernel/pico2_kernel.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk.img \
    kernel/scripts/bin2s_incbin.sh compiler/build/gen2/bin2uf2 | build/kernel
	$(PICO2_KERNEL_RECIPE)

build/kernel/pico2_kernel_extra.uf2: PICO2_DISK := build/kernel/disk-extra.img
build/kernel/pico2_kernel_extra.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk-extra.img \
    kernel/scripts/bin2s_incbin.sh compiler/build/gen2/bin2uf2 | build/kernel
	$(PICO2_KERNEL_RECIPE)

# demo UF2: disk-demo.img の /etc/kern.conf で hello + hello2 + sh を
# seed する。`make run-pico2-demo` で kern.conf 駆動 init が実機で
# 動くことを確認できる。
build/kernel/pico2_kernel_demo.uf2: PICO2_DISK := build/kernel/disk-demo.img
build/kernel/pico2_kernel_demo.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk-demo.img \
    kernel/scripts/bin2s_incbin.sh compiler/build/gen2/bin2uf2 | build/kernel
	$(PICO2_KERNEL_RECIPE)

# console UF2: disk-console.img の /etc/kern.conf で /bin/console を
# seed する (portrait, hardware scroll)。Pico 2 LCD コンソールを
# 起動時から立ち上げる経路。`make run-pico2-console` で実機起動。
build/kernel/pico2_kernel_console.uf2: PICO2_DISK := build/kernel/disk-console.img
build/kernel/pico2_kernel_console.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk-console.img \
    kernel/scripts/bin2s_incbin.sh compiler/build/gen2/bin2uf2 | build/kernel
	$(PICO2_KERNEL_RECIPE)

# console-land UF2: 横向き (`/bin/console -l`)、software scroll。
build/kernel/pico2_kernel_console_land.uf2: PICO2_DISK := build/kernel/disk-console-land.img
build/kernel/pico2_kernel_console_land.uf2: $(KERNEL_COMPILE_DEPS) build/kernel/disk-console-land.img \
    kernel/scripts/bin2s_incbin.sh compiler/build/gen2/bin2uf2 | build/kernel
	$(PICO2_KERNEL_RECIPE)

# NOTE: ユーザー向け alias (virt-kernel, pico2-kernel, ...) は kernel/Makefile
# に移動済。`make -C kernel virt` / `make -C kernel pico2` / `make -C kernel
# pico2-{extra,demo,console{,-land}}` を使ってください。実 recipe (`build/kernel/
# *.bin`, `build/kernel/*.uf2`) は引き続きこの root Makefile で定義し、
# サブ Makefile が delegate する形。

# ----- FAT32 disk image (second virtio-blk drive) -----
# mkfs.fat may live in /sbin (not in PATH by default)
MKFS_FAT := $(shell which mkfs.fat 2>/dev/null || echo /sbin/mkfs.fat)

build/kernel/fat.img: | build/kernel
	@echo "Creating FAT32 image: $@" >&2
	@dd if=/dev/zero of=$@ bs=1M count=33 2>/dev/null && \
	$(MKFS_FAT) -F 32 $@ >/dev/null && \
	printf 'hello from SD\n' | mcopy -i $@ - ::HELLO.TXT

# NOTE: ユーザー向け `make run` / `make run-pico2*` は kernel/Makefile に
# 移動済。`make -C kernel run` / `make -C kernel run-pico2{,-extra,-console}` 等
# を使ってください。

# ===== test_asm prebuilt binaries (Phase D) =====

build/test/asm:
	mkdir -p $@

TEST_ASM_DEPS := compiler/tests/virt_crt0.s $(RUNTIME_DEPS) $(GEN2_TOOLS) compiler/scripts/compile-gen2.sh

build/test/asm/hello2_virt.bin: compiler/tests/hello2.tc $(TEST_ASM_DEPS) | build/test/asm
	CRT0=compiler/tests/virt_crt0.s ASM_PROLOGUE='; raw' GEN2_DIR=compiler/build/gen2 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

build/test/asm/test_timer.bin: compiler/tests/test_timer.tc $(TEST_ASM_DEPS) compiler/runtime/linux/crt0_tc_data.s | build/test/asm
	CRT0=compiler/tests/virt_crt0.s CRT0_DATA=compiler/runtime/linux/crt0_tc_data.s ASM_PROLOGUE='; raw' \
	    GEN2_DIR=compiler/build/gen2 UNIFIED_PRELUDE=0 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

build/test/asm/test_echo.bin: compiler/tests/test_echo.tc $(TEST_ASM_DEPS) compiler/runtime/linux/crt0_tc_data.s | build/test/asm
	CRT0=compiler/tests/virt_crt0.s CRT0_DATA=compiler/runtime/linux/crt0_tc_data.s ASM_PROLOGUE='; raw' \
	    GEN2_DIR=compiler/build/gen2 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

TEST_ASM_BINS := build/test/asm/hello2_virt.bin \
                 build/test/asm/test_timer.bin \
                 build/test/asm/test_echo.bin

# NOTE: `make test-asm-bins` は `make -C compiler test-asm-bins` に移動済。
# $(TEST_ASM_BINS) は ALL_TEST_DEPS 経由で test target が引っぱる。

clean:
	rm -f $(OBJS) compiler/bootstrap/parse_main.o compiler/bootstrap/typecheck_main.o compiler/bootstrap/interp_main.o compiler/bootstrap/codegen_main.o
	rm -rf build

# ===== test stamp files =====

BUILD_DEPS := $(GEN1_TOOLS) $(GEN2_TOOLS) build/kernel/virt_kernel.bin \
              build/kernel/disk.img build/kernel/disk-demo.img \
              build/kernel/disk-console.img build/kernel/disk-console-land.img \
              $(TEST_ASM_BINS)

# `make test` はサブプロジェクト Makefile に委譲。集約は sub-Makefile
# の "Results: N passed, M failed" 行で確認できる。stamp file は使わない
# (sub-Makefile が個別にキャッシュ判定する)。
.PHONY: test full-test
test:
	$(MAKE) -C compiler test
	$(MAKE) -C kernel   test
	$(MAKE) -C userland test

# full-test: 上 + integration + FULL_TEST=1 系。
full-test: test integration-test
	FULL_TEST=1 $(MAKE) -C compiler test
	FULL_TEST=1 $(MAKE) -C kernel test

# integration-test: 3 サブプロジェクトの境界をまたぐテスト。
# - test_phase7.sh: phase 7 self-host on qemu virt
# - 他の integration スクリプト (pico2_*, phase3_verify, qemu_mr_scale)
#   は実機 / 特殊 fixture が必要なので手動で実行
.PHONY: integration-test
integration-test:
	@echo "=== integration: test_phase7.sh ===" >&2
	@if [ -z "$$GEN2_DIR" ]; then \
	    GEN2_DIR=$(CURDIR)/compiler/build/gen2 ./integration/test_phase7.sh; \
	else \
	    ./integration/test_phase7.sh; \
	fi

# NOTE: `make update-golden` は `make -C compiler update-golden` に移動済。

# 並列ビルド禁止: compile-gen2.sh の CACHED_S_DIR / qemu state が race
# するのを避ける。ログも読みやすくなる。
.NOTPARALLEL:

.PHONY: all clean test full-test gen2-tools gen3-tools

# compiler/ サブプロジェクト Makefile
#
# 主目的: `make -C compiler test` が compiler 関連 test だけ実行する。
# build recipe も自分が所有 (Phase 4d で root から移動)。
#
# 出力: compiler/build/gen{1,2,3}/{parse,sigscan,...,mkfs,bin2uf2}
#       compiler/build/test_asm/{hello2_virt,test_timer,test_echo}.bin

ROOT := $(realpath $(CURDIR)/..)

CC      := gcc
CFLAGS  := -Wall -Wextra -g -I $(ROOT)/compiler/bootstrap

SRCS := $(ROOT)/compiler/bootstrap/lexer.c \
        $(ROOT)/compiler/bootstrap/ast.c \
        $(ROOT)/compiler/bootstrap/parser.c \
        $(ROOT)/compiler/bootstrap/typecheck.c \
        $(ROOT)/compiler/bootstrap/interp.c \
        $(ROOT)/compiler/bootstrap/codegen.c
OBJS := $(SRCS:.c=.o)

# Gen1 ツール (C 製、x86 native)
GEN1_NAMES := parse typecheck interp codegen bcrun bc2asm
GEN1_DIR   := $(ROOT)/compiler/build/gen1
GEN1_TOOLS := $(addprefix $(GEN1_DIR)/,$(GEN1_NAMES))

# Gen2 ツール (TC 製、RV32 ELF + qemu-riscv32)
GEN2_NAMES := parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2 asm_pass3
GEN2_DIR   := $(ROOT)/compiler/build/gen2
GEN2_TOOLS := $(addprefix $(GEN2_DIR)/,$(GEN2_NAMES))

# Gen3 ツール (Gen2 == Gen3 byte-exact 検証用)
GEN3_NAMES := $(GEN2_NAMES)
GEN3_DIR   := $(ROOT)/compiler/build/gen3
GEN3_TOOLS := $(addprefix $(GEN3_DIR)/,$(GEN3_NAMES))

# kernel build 用の TC ホストツール (mkfs.tc / bin2uf2.tc は
# kernel/tools-src/ にあるが Gen1 で compile するので出力は
# Gen2 dir に置く慣例を維持)
KERN_TOOLS := $(GEN2_DIR)/mkfs $(GEN2_DIR)/bin2uf2

.PHONY: all build test test-warm test-asm-bins update-golden clean \
        gen1 gen2 gen3 kern-tools

# Default: gen2 build
all build: gen2

# ===== Gen1 =====
gen1: $(GEN1_TOOLS)

$(GEN1_DIR):
	mkdir -p $@

$(GEN1_DIR)/parse: $(OBJS) $(ROOT)/compiler/bootstrap/parse_main.o | $(GEN1_DIR)
	$(CC) -o $@ $^

$(GEN1_DIR)/typecheck: $(OBJS) $(ROOT)/compiler/bootstrap/typecheck_main.o | $(GEN1_DIR)
	$(CC) -o $@ $^

$(GEN1_DIR)/interp: $(OBJS) $(ROOT)/compiler/bootstrap/interp_main.o | $(GEN1_DIR)
	$(CC) -o $@ $^

$(GEN1_DIR)/codegen: $(OBJS) $(ROOT)/compiler/bootstrap/codegen_main.o | $(GEN1_DIR)
	$(CC) -o $@ $^

$(GEN1_DIR)/bcrun: $(ROOT)/compiler/bootstrap/bcrun.c | $(GEN1_DIR)
	$(CC) $(CFLAGS) -o $@ $<

$(GEN1_DIR)/bc2asm: $(ROOT)/compiler/bootstrap/bc2asm.c | $(GEN1_DIR)
	$(CC) $(CFLAGS) -o $@ $<

# bootstrap C ソースの .o コンパイル
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# ===== Gen2 (compile-gen1.sh 経由) =====
gen2: $(GEN2_TOOLS)

$(GEN2_DIR):
	mkdir -p $@

# compiler/src/ パターンルール
$(GEN2_DIR)/%: $(ROOT)/compiler/src/%.tc $(GEN1_TOOLS) \
    $(ROOT)/compiler/scripts/collect_imports.sh \
    $(ROOT)/compiler/scripts/tc_deps_to_d.sh | $(GEN2_DIR)
	cd $(ROOT) && ./compiler/scripts/compile-gen1.sh -o $@ $<
	cd $(ROOT) && ./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

# kernel build 用 host ツール (source は kernel/tools-src/ だが
# Gen2 pipeline で compile するので出力 dir は共有)
kern-tools: $(KERN_TOOLS)

$(GEN2_DIR)/bin2uf2: $(ROOT)/kernel/tools-src/bin2uf2.tc $(GEN1_TOOLS) \
    $(ROOT)/compiler/scripts/collect_imports.sh \
    $(ROOT)/compiler/scripts/tc_deps_to_d.sh \
    $(ROOT)/compiler/bootstrap/crt0.s \
    $(ROOT)/compiler/bootstrap/runtime_syscall.c | $(GEN2_DIR)
	cd $(ROOT) && ./compiler/scripts/compile-gen1.sh -o $@ $<
	cd $(ROOT) && ./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

$(GEN2_DIR)/mkfs: $(ROOT)/kernel/tools-src/mkfs.tc $(GEN1_TOOLS) \
    $(ROOT)/compiler/scripts/collect_imports.sh \
    $(ROOT)/compiler/scripts/tc_deps_to_d.sh \
    $(ROOT)/compiler/bootstrap/crt0.s \
    $(ROOT)/compiler/bootstrap/runtime_syscall.c | $(GEN2_DIR)
	cd $(ROOT) && ./compiler/scripts/compile-gen1.sh -o $@ $<
	cd $(ROOT) && ./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

# .d ファイル取り込み (transitive import 追跡)
-include $(addsuffix .d,$(GEN2_TOOLS))
-include $(addsuffix .d,$(KERN_TOOLS))

# ===== Gen3 (Gen2 == Gen3 byte-exact 検証用) =====
gen3: $(GEN3_TOOLS)

$(GEN3_DIR):
	mkdir -p $@

$(GEN3_DIR)/%: $(ROOT)/compiler/src/%.tc $(GEN2_TOOLS) \
    $(ROOT)/compiler/scripts/collect_imports.sh \
    $(ROOT)/compiler/scripts/tc_deps_to_d.sh | $(GEN3_DIR)
	cd $(ROOT) && GEN2_DIR=compiler/build/gen2 ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null
	cd $(ROOT) && ./compiler/scripts/tc_deps_to_d.sh $@ $< > $@.d

-include $(addsuffix .d,$(GEN3_TOOLS))

# ===== test_asm prebuilt binaries =====
TEST_ASM_DIR  := $(ROOT)/compiler/build/test_asm
RUNTIME_DEPS  := $(shell $(ROOT)/compiler/scripts/collect_imports.sh $(ROOT)/compiler/src/runtime.tc 2>/dev/null)
TEST_ASM_DEPS := $(ROOT)/compiler/tests/virt_crt0.s $(RUNTIME_DEPS) $(GEN2_TOOLS) \
    $(ROOT)/compiler/scripts/compile-gen2.sh
TEST_ASM_BINS := $(TEST_ASM_DIR)/hello2_virt.bin \
                 $(TEST_ASM_DIR)/test_timer.bin \
                 $(TEST_ASM_DIR)/test_echo.bin

test-asm-bins: $(TEST_ASM_BINS)

$(TEST_ASM_DIR):
	mkdir -p $@

$(TEST_ASM_DIR)/hello2_virt.bin: $(ROOT)/compiler/tests/hello2.tc $(TEST_ASM_DEPS) | $(TEST_ASM_DIR)
	cd $(ROOT) && CRT0=compiler/tests/virt_crt0.s ASM_PROLOGUE='; raw' \
	    GEN2_DIR=compiler/build/gen2 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

$(TEST_ASM_DIR)/test_timer.bin: $(ROOT)/compiler/tests/test_timer.tc $(TEST_ASM_DEPS) \
    $(ROOT)/compiler/runtime/linux/crt0_tc_data.s | $(TEST_ASM_DIR)
	cd $(ROOT) && CRT0=compiler/tests/virt_crt0.s CRT0_DATA=compiler/runtime/linux/crt0_tc_data.s \
	    ASM_PROLOGUE='; raw' GEN2_DIR=compiler/build/gen2 UNIFIED_PRELUDE=0 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

$(TEST_ASM_DIR)/test_echo.bin: $(ROOT)/compiler/tests/test_echo.tc $(TEST_ASM_DEPS) \
    $(ROOT)/compiler/runtime/linux/crt0_tc_data.s | $(TEST_ASM_DIR)
	cd $(ROOT) && CRT0=compiler/tests/virt_crt0.s CRT0_DATA=compiler/runtime/linux/crt0_tc_data.s \
	    ASM_PROLOGUE='; raw' GEN2_DIR=compiler/build/gen2 \
	    ./compiler/scripts/compile-gen2.sh -o $@ $< 2>/dev/null

# ===== test =====
test: gen2
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_consistency.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_golden_examples.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_gen3.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_asm.sh

test-warm: gen2
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh

update-golden: gen1
	$(ROOT)/compiler/tests/update_golden.sh

clean:
	rm -rf $(ROOT)/compiler/build
	rm -f $(ROOT)/compiler/bootstrap/*.o

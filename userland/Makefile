# userland/ サブプロジェクト Makefile
#
# 主目的: `make -C userland test` が user task の smoke だけ実行する。
# build recipe も自分が所有 (Phase 4d で root から移動)。
#
# 出力:
#   userland/build/tasks/<task>.bin       各タスクの raw bin (K3 header 付)
#   userland/build/shared/{runtime,libtc}.s  全タスクが共有する .s
#   userland/build/task_sizes.sh          task.mk から自動生成された arena/stack
#   userland/build/jpfont.dat / jpfont_inc.s  console 用日本語フォント

ROOT := $(realpath $(CURDIR)/..)

QEMU_USER := qemu-riscv32

# ----- Compiler artifacts that userland consumes -----
GEN1_DIR   := $(ROOT)/compiler/build/gen1
GEN2_DIR   := $(ROOT)/compiler/build/gen2
GEN2_TOOLS := $(addprefix $(GEN2_DIR)/,parse sigscan tcheck codegen bc2asm bcrun asm_pass1 asm_pass2 asm_pass3)
TASK_CRT0  := $(ROOT)/compiler/runtime/mtos/task_crt0.s
TASK_DATA  := $(ROOT)/compiler/runtime/mtos/task_data.s

RUNTIME_DEPS := $(shell $(ROOT)/compiler/scripts/collect_imports.sh $(ROOT)/compiler/src/runtime.tc 2>/dev/null)
LIBTC_DEPS   := $(shell $(ROOT)/compiler/scripts/collect_imports.sh $(ROOT)/userland/lib/libtc/libtc.tc 2>/dev/null)

# Cross-sub delegation: GEN2_TOOLS が無ければ compiler/Makefile に build を依頼
.PHONY: _compiler-gen2
_compiler-gen2:
	$(MAKE) -C $(ROOT)/compiler gen2
$(GEN2_TOOLS): | _compiler-gen2

# ----- Userland output dirs -----
BUILD_DIR  := $(ROOT)/userland/build
TASK_DIR   := $(BUILD_DIR)/tasks
SHARED_DIR := $(BUILD_DIR)/shared
TASK_SIZES := $(BUILD_DIR)/task_sizes.sh

# ----- Task definitions from per-task task.mk -----
# TC tasks live under userland/bin/<name>/, GCC tasks (riscv-elf-gcc
# compiled C) live under userland/gcc-bin/<name>/. Both contribute to
# GUEST_TASKS / TASK_ARENA_<name> / TASK_STACK_<name>; GCC tasks
# additionally append to GCC_TASKS so the dedicated build rule below
# picks them up instead of falling through to the TC pattern rule.
TASK_MK_FILES := $(wildcard $(ROOT)/userland/bin/*/task.mk) \
                 $(wildcard $(ROOT)/userland/gcc-bin/*/task.mk)
GUEST_TASKS :=
EXTRA_GUEST_TASKS :=
GCC_TASKS :=
-include $(TASK_MK_FILES)
# DROP_TASKS で個別タスクを除外可 (pico2 4 MiB flash 用)
GUEST_TASKS       := $(filter-out $(DROP_TASKS),$(GUEST_TASKS))
EXTRA_GUEST_TASKS := $(filter-out $(DROP_TASKS),$(EXTRA_GUEST_TASKS))
ALL_TASK_NAMES := $(GUEST_TASKS) $(EXTRA_GUEST_TASKS)

GUEST_TASK_BINS := $(foreach t,$(GUEST_TASKS),$(TASK_DIR)/$(t).bin)
EXTRA_TASK_BINS := $(foreach t,$(EXTRA_GUEST_TASKS),$(TASK_DIR)/$(t).bin)
ALL_TASK_BINS   := $(GUEST_TASK_BINS) $(EXTRA_TASK_BINS)

SHARED_S := $(SHARED_DIR)/runtime.s $(SHARED_DIR)/libtc.s

# Japanese font fixture for /bin/console (user-supplied tmp/font.bmp)
FONT_BMP := $(wildcard $(ROOT)/tmp/font.bmp)

.PHONY: all build test test-quick test-units clean tasks shared sizes font \
        guest-tasks extra-tasks

# Default: all GUEST + EXTRA tasks
all build tasks: $(ALL_TASK_BINS)

guest-tasks: $(GUEST_TASK_BINS)
extra-tasks: $(EXTRA_TASK_BINS)
shared:      $(SHARED_S)
sizes:       $(TASK_SIZES)
font:        $(BUILD_DIR)/jpfont_inc.s

# ===== Output dirs =====
$(BUILD_DIR) $(TASK_DIR) $(SHARED_DIR):
	mkdir -p $@

# ===== task_sizes.sh (auto-generated) =====
close_paren := )

$(TASK_SIZES): $(TASK_MK_FILES) $(CURDIR)/Makefile | $(BUILD_DIR)
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

# ===== Shared .s (runtime.tc / libtc.tc → .s once per build) =====
$(SHARED_DIR)/runtime.s: $(ROOT)/compiler/src/runtime.tc $(RUNTIME_DEPS) $(GEN2_TOOLS) | $(SHARED_DIR)
	@echo "Pre-compiling runtime.tc" >&2
	@cd $(ROOT) && _ast=$$(mktemp) && _th=$$(mktemp) && \
	compiler/build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) compiler/build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) compiler/build/gen2/tcheck \
	    | $(QEMU_USER) compiler/build/gen2/codegen \
	    | $(QEMU_USER) compiler/build/gen2/bc2asm > $@ && \
	rm -f "$$_ast" "$$_th"

$(SHARED_DIR)/libtc.s: $(ROOT)/userland/lib/libtc/libtc.tc $(LIBTC_DEPS) $(GEN2_TOOLS) | $(SHARED_DIR)
	@echo "Pre-compiling libtc.tc" >&2
	@cd $(ROOT) && _ast=$$(mktemp) && _th=$$(mktemp) && \
	compiler/build/gen1/parse $< > "$$_ast" && \
	$(QEMU_USER) compiler/build/gen2/sigscan < "$$_ast" > "$$_th" && \
	{ printf '(imports)\n(self\n'; cat "$$_th"; printf ')\n'; cat "$$_ast"; } \
	    | $(QEMU_USER) compiler/build/gen2/tcheck \
	    | $(QEMU_USER) compiler/build/gen2/codegen \
	    | $(QEMU_USER) compiler/build/gen2/bc2asm > $@ && \
	rm -f "$$_ast" "$$_th"

# ===== Per-task binary (K3 header + crt0 + task .tc + data) =====
# Pattern: userland/bin/<task>/<task>.tc → userland/build/tasks/<task>.bin
$(TASK_DIR)/%.bin: $(SHARED_S) $(GEN2_TOOLS) $(TASK_CRT0) $(TASK_DATA) $(TASK_SIZES) \
    $(ROOT)/compiler/scripts/compile-gen2.sh | $(TASK_DIR)
	@echo "Building task: $*" >&2
	@_tmp=$$(mktemp -d) && \
	. $(TASK_SIZES) && \
	_arena=$$(task_arena_size $*) && \
	_stack=$$(task_stack_size $*) && \
	printf '    .text\n    .word %s\n    .word %s\n' "$$_arena" "$$_stack" > "$$_tmp/hdr.s" && \
	cd $(ROOT) && \
	CRT0="$$_tmp/hdr.s compiler/runtime/mtos/task_crt0.s" \
	    CRT0_DATA=compiler/runtime/mtos/task_data.s \
	    ASM_PROLOGUE="; raw" GEN2_DIR=compiler/build/gen2 \
	    CACHED_S_DIR=userland/build/shared \
	    EXTRA_S="$(TASK_EXTRA_S_$*)" \
	    ./compiler/scripts/compile-gen2.sh -o $@ userland/bin/$*/$*.tc 2>/dev/null && \
	rm -rf "$$_tmp"
	@cd $(ROOT) && compiler/scripts/tc_deps_to_d.sh $@ userland/bin/$*/$*.tc > $@.d

-include $(addsuffix .d,$(ALL_TASK_BINS))

# ===== GCC-compiled tasks (riscv-elf-gcc) =====
# Linker layout, crt0, and minimal libc shared by every gcc-bin task.
# The build composes:
#   hdr.s  (K3 header, generated per-task from TASK_ARENA / TASK_STACK)
# + gcc_crt0.s
# + gcc_libc.c
# + <task>.c
# → .elf via riscv64-unknown-elf-gcc + ld → .bin via objcopy.
RISCV_GCC  := riscv64-unknown-elf-gcc
RISCV_OBJCOPY := riscv64-unknown-elf-objcopy
GCC_CRT0   := $(ROOT)/compiler/runtime/mtos/gcc_crt0.s
GCC_LIBC   := $(ROOT)/compiler/runtime/mtos/gcc_libc.c
GCC_LD     := $(ROOT)/compiler/runtime/mtos/gcc_task.ld
# -fPIE + --no-relax keeps every string-literal / global access PC-relative
# (auipc + addi) instead of folding to an absolute `li`. The kernel loads
# each task at a per-task RAM/flash address, so any code that bakes in
# the link-time VMA (0x100-ish for .text, 0x128 for the first .rodata)
# would compute wild pointers at runtime — exactly the load-fault trap
# we hit on the first gcc_hello.
GCC_CFLAGS := -march=rv32im -mabi=ilp32 -mcmodel=medlow -Os \
              -fPIE -ffunction-sections -fdata-sections \
              -fno-builtin -nostdlib -nostartfiles \
              -msmall-data-limit=2048 \
              -Wall -Wno-unused-parameter
# --no-relax keeps `auipc + addi` literal-address pairs intact. With
# relaxation enabled the linker folds them into single absolute `li`s,
# which bake the link-time VMA into the binary; our task runs at a
# kernel-assigned runtime address, not at the linker's idea of one,
# so those folds break PC-relative .rodata lookups. (Trade-off: this
# also blocks the gp-relative relaxation that would let small-data
# globals collapse into `lw/sw rd, off(gp)` — once Phase 0.5 adds a
# load-time reloc pass we can revisit.)
GCC_LDFLAGS := -Wl,--no-relax

# Per-task rule generator. Static-pattern-style: emits an explicit
# target for $(TASK_DIR)/<name>.bin that overrides the generic TC
# pattern above (Make picks the most specific match).
define GCC_TASK_RULE
$$(TASK_DIR)/$(1).bin: $$(ROOT)/userland/gcc-bin/$(1)/$(1).c \
    $$(GCC_CRT0) $$(GCC_LIBC) $$(GCC_LD) $$(TASK_SIZES) | $$(TASK_DIR)
	@echo "Building gcc task: $(1)" >&2
	@_tmp=$$$$(mktemp -d) && \
	. $$(TASK_SIZES) && \
	_arena=$$$$(task_arena_size $(1)) && \
	_stack=$$$$(task_stack_size $(1)) && \
	printf '    .section .text.k3, "ax", @progbits\n    .word %s\n    .word %s\n' \
	    "$$$$_arena" "$$$$_stack" > "$$$$_tmp/hdr.s" && \
	$$(RISCV_GCC) $$(GCC_CFLAGS) $$(GCC_LDFLAGS) -T $$(GCC_LD) \
	    "$$$$_tmp/hdr.s" $$(GCC_CRT0) $$(GCC_LIBC) $$< \
	    -o "$$$$_tmp/$(1).elf" && \
	$$(RISCV_OBJCOPY) -O binary "$$$$_tmp/$(1).elf" $$@ && \
	rm -rf "$$$$_tmp"
endef
$(foreach t,$(GCC_TASKS),$(eval $(call GCC_TASK_RULE,$(t))))

# ===== Japanese font for /bin/console =====
# tmp/font.bmp (np21w PC-98 font、user-supplied、never committed) を
# genjpfont.py が jpfont.dat に変換、bin2s_incbin.sh で jpfont_inc.s に
# wrap して console.bin にリンク (TASK_EXTRA_S_console)。
# font.bmp が無ければ console は build できない。

ifeq ($(FONT_BMP),)
$(BUILD_DIR)/jpfont_inc.s:
	@echo 'Error: tmp/font.bmp is required to build /bin/console.' >&2
	@echo '  Download the np21w PC-98 font from:' >&2
	@echo '  https://simk98.github.io/np21w/download.html' >&2
	@echo '  and place font.bmp at tmp/font.bmp' >&2
	@false
else
$(BUILD_DIR)/jpfont.dat: $(FONT_BMP) $(ROOT)/userland/scripts/genjpfont.py | $(BUILD_DIR)
	@python3 $(ROOT)/userland/scripts/genjpfont.py $(FONT_BMP) $@
$(BUILD_DIR)/jpfont_inc.s: $(BUILD_DIR)/jpfont.dat $(ROOT)/userland/scripts/bin2s_incbin.sh | $(BUILD_DIR)
	@cd $(ROOT) && userland/scripts/bin2s_incbin.sh userland/build/jpfont.dat jpfont userland/build/jpfont.dat > $@
endif

TASK_EXTRA_S_console := $(BUILD_DIR)/jpfont_inc.s
$(TASK_DIR)/console.bin: $(BUILD_DIR)/jpfont_inc.s

# ===== test =====
test: all
	@echo "userland smoke: $(words $(ALL_TASK_NAMES)) tasks built OK"

test-quick: $(GUEST_TASK_BINS)
	@echo "userland test-quick: $(words $(GUEST_TASKS)) GUEST_TASKS built OK"

# test-units: build each userland/tests/**/test_*.tc as a Linux RV32 ELF
# (via compile-gen1.sh — pulls in libtc.tc + libtc_test.tc imports) and
# run it under qemu-riscv32. Tests use libtc_test.tc's assert_* helpers
# + return non-zero on failure, so a single test file's failure shows up
# in the summary line. ~1 s per file once Gen1 binaries are built.
TEST_UNIT_FILES := $(shell find $(ROOT)/userland/tests -name 'test_*.tc' 2>/dev/null)

test-units:
	$(MAKE) -C $(ROOT)/compiler gen1
	@total=0; failed=0; \
	tmp=$$(mktemp -d); trap "rm -rf $$tmp" EXIT; \
	for t in $(TEST_UNIT_FILES); do \
	    total=$$((total + 1)); \
	    base=$$(basename "$$t" .tc); \
	    echo "=== $$t ==="; \
	    if ! $(ROOT)/compiler/scripts/compile-gen1.sh -o "$$tmp/$$base" "$$t" 2>&1 | tail -1; then \
	        failed=$$((failed + 1)); continue; \
	    fi; \
	    if ! qemu-riscv32 "$$tmp/$$base"; then \
	        failed=$$((failed + 1)); \
	    fi; \
	done; \
	echo "==== test-units: $$((total - failed))/$$total files passed ===="; \
	test $$failed -eq 0

clean:
	rm -rf $(BUILD_DIR)

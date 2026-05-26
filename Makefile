# ルート Makefile — coordinator only (Phase 4d 完了)
#
# 各サブプロジェクトの build recipe は対応する sub-Makefile が所有:
#   compiler/Makefile  — Gen1/Gen2/Gen3 + mkfs/bin2uf2 + test_asm
#   userland/Makefile  — task binaries + shared.s + jpfont + task_sizes
#   kernel/Makefile    — disk images + virt_kernel + pico2 UF2 + fat
#
# このルート Makefile は test 集約 / clean / integration の薄い
# coordinator のみ。

.NOTPARALLEL:
.PHONY: all test full-test integration-test clean

# Default: Gen1 のみ (旧 `make all` の動作を維持)
all:
	$(MAKE) -C compiler gen1

# `make test` はサブプロジェクト Makefile に委譲。
# 集約は sub-Makefile の "Results: N passed, M failed" 行で確認。
test:
	$(MAKE) -C compiler test
	$(MAKE) -C kernel   test
	$(MAKE) -C userland test

# full-test: 上 + integration + FULL_TEST=1 系。
full-test: test integration-test
	FULL_TEST=1 $(MAKE) -C compiler test
	FULL_TEST=1 $(MAKE) -C kernel test

# integration-test: 3 サブプロジェクトの境界をまたぐテスト。
# - integration/test_phase7.sh: phase 7 self-host on qemu virt
# - 他 (pico2_*, phase3_verify, qemu_mr_scale) は実機 / 特殊 fixture
#   が必要なので手動で実行
integration-test:
	@echo "=== integration: test_phase7.sh ===" >&2
	@if [ -z "$$GEN2_DIR" ]; then \
	    GEN2_DIR=$(CURDIR)/compiler/build/gen2 ./integration/test_phase7.sh; \
	else \
	    ./integration/test_phase7.sh; \
	fi

clean:
	$(MAKE) -C compiler clean
	$(MAKE) -C userland clean
	$(MAKE) -C kernel clean
	rm -rf build

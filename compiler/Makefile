# compiler/ サブプロジェクト Makefile
#
# 主目的: `make -C compiler test` が compiler 関連 test だけ実行する
# (test_os や integration を巻き込まない)。これによりユーザーが
# compiler/src/*.tc を編集したとき、kernel/userland のテストを再実行
# せずに済む。
#
# 内部では root Makefile に委譲して gen1/gen2 tools を ready にした
# あと、compiler テスト用の sh script を直接呼ぶ。Phase 2 では build
# rule の本格分離はせず、test の scoping だけ提供する。

ROOT := $(realpath $(CURDIR)/..)

.PHONY: all build test test-warm clean

# `make -C compiler` 単独で gen1/gen2 を組めるように
all build:
	$(MAKE) -C $(ROOT) gen2-tools

# Test target — root に test_unit / test_pipeline / ... の前提となる
# gen2 tools をビルドさせてから、compiler 固有テストだけを直接呼ぶ。
# test_os と integration は含めない。
test: build
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_consistency.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_golden_examples.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_gen3.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_asm.sh

# 高速版: golden / gen3 / consistency を skip。warm dev loop 用。
test-warm: build
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh

clean:
	rm -rf $(ROOT)/build/gen1 $(ROOT)/build/gen2 $(ROOT)/build/gen3
	rm -f $(ROOT)/compiler/bootstrap/*.o

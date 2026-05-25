# compiler/ サブプロジェクト Makefile
#
# 主目的: `make -C compiler test` が compiler 関連 test だけ実行する
# (test_os や integration を巻き込まない)。これによりユーザーが
# compiler/src/*.tc を編集したとき、kernel/userland のテストを再実行
# せずに済む。
#
# 内部では root Makefile に委譲して gen1/gen2 tools を ready にした
# あと、compiler テスト用の sh script を直接呼ぶ。build recipe の
# 物理移動は将来のフェーズで実施。

ROOT := $(realpath $(CURDIR)/..)

.PHONY: all build test test-warm clean gen1 gen2 gen3 update-golden test-asm-bins

# Default: gen2 を build (compiler のメイン成果物)
all build: gen2

# Gen1: C 製ツール (build/gen1/)
gen1:
	$(MAKE) -C $(ROOT) build/gen1/parse build/gen1/typecheck build/gen1/interp \
	    build/gen1/codegen build/gen1/bcrun build/gen1/bc2asm

# Gen2: TC 製 RV32 ELF (build/gen2/) — Gen1 を使う
gen2:
	$(MAKE) -C $(ROOT) gen2-tools

# Gen3: Gen2 で自己ホスト確認用 (build/gen3/)
gen3:
	$(MAKE) -C $(ROOT) gen3-tools

# Test target — root に gen2 tools を ready にさせてから compiler 固有
# テストだけを直接呼ぶ。test_os と integration は含めない。
test: gen2
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_consistency.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_golden_examples.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_gen3.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_asm.sh

# 高速版: golden / gen3 / consistency を skip。warm dev loop 用。
test-warm: gen2
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_unit.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_pipeline.sh
	@cd $(ROOT) && $(ROOT)/compiler/tests/test_import.sh

# test_asm.sh が事前ビルドする hello2_virt / test_timer / test_echo bin
test-asm-bins:
	$(MAKE) -C $(ROOT) build/test/asm/hello2_virt.bin \
	    build/test/asm/test_timer.bin build/test/asm/test_echo.bin

# golden ファイル再生成
update-golden: gen1
	$(ROOT)/compiler/tests/update_golden.sh

clean:
	rm -rf $(ROOT)/build/gen1 $(ROOT)/build/gen2 $(ROOT)/build/gen3
	rm -f $(ROOT)/compiler/bootstrap/*.o

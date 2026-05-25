# userland/ サブプロジェクト Makefile
#
# 主目的: `make -C userland test` が user task の smoke だけ実行する
# (compiler test や kernel boot は走らない)。これによりユーザーが
# userland/bin/<task>/<task>.tc を編集したとき、compiler/kernel test
# を巻き込まず手早く確認できる。
#
# smoke の中身: 全 GUEST_TASKS バイナリが build できるかを Make の
# dependency tracking 経由で検証 (root Makefile の userland/build/tasks/*.bin
# ルールに委譲)。kernel build は不要なので走らない。

ROOT := $(realpath $(CURDIR)/..)

# 全 GUEST_TASKS + EXTRA_GUEST_TASKS の bin 一覧を集める
TASK_MK_FILES := $(wildcard $(CURDIR)/bin/*/task.mk)
GUEST_TASKS :=
EXTRA_GUEST_TASKS :=
include $(TASK_MK_FILES)
ALL_TASKS := $(GUEST_TASKS) $(EXTRA_GUEST_TASKS)

.PHONY: all build test test-quick clean

# `make -C userland` 単独で全タスクを build (root に 1 回だけ delegate)
.NOTPARALLEL: build all test test-quick
all build:
	$(MAKE) -C $(ROOT) $(addprefix userland/build/tasks/,$(addsuffix .bin,$(ALL_TASKS)))

# Smoke test: 全タスクが build できるなら PASS (warm: ~3 sec)
test: build
	@echo "userland smoke: $(words $(ALL_TASKS)) tasks built OK"

# 高速版: GUEST_TASKS のみ (compiler symlink タスクを除外)
test-quick:
	$(MAKE) -C $(ROOT) $(addprefix userland/build/tasks/,$(addsuffix .bin,$(GUEST_TASKS)))
	@echo "userland test-quick: $(words $(GUEST_TASKS)) GUEST_TASKS built OK"

clean:
	rm -f $(ROOT)/userland/build/tasks/*.bin

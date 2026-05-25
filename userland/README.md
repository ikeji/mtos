# userland/

MTOS で動くユーザータスク (40 個)。

## 構成

- `lib/libtc/libtc.tc` — 共通ユーザライブラリ (puts/eputs/print + syscall stub)
- `bin/<task>/` — 各タスク (40 個)
  - coreutils: sh, msh, ls, cat, echo, wc, head, cp, du, grep, rm, mkdir,
    rmdir, rot13, md5sum
  - apps: vi, neofetch, console, fbtest, count, seq
  - phase 7 / test: hello, hello2, catfile, launcher, tmpdemo
  - UART / SD: mx, mr, muxon, muxoff, sdprobe, kbdump
  - tools: tcc, bin2uf2
  - compiler-on-MTOS (symlinks): parse, sigscan, tcheck, codegen, bc2asm,
    asm_pass{1,2,3} → `../../../compiler/src/<name>.tc`

各 `bin/<task>/` には `task.mk` があり `GUEST_TASKS += <name>` or
`EXTRA_GUEST_TASKS += <name>` と `TASK_ARENA_<name>` / `TASK_STACK_<name>`
を宣言する。

## ビルド

GUEST_TASKS は `make -C kernel virt` / `make -C kernel pico2` の依存として
自動的に組み込まれる。EXTRA_GUEST_TASKS (compiler/cat) は
`make -C kernel pico2-extra` 等で disk-extra.img に組み込まれる。

サブ Makefile 経由でも:

```bash
make -C userland         # 全 40 タスク build (warm <0.1s)
make -C userland test    # smoke test (build OK 確認のみ)
make -C userland test-quick  # GUEST_TASKS のみ (compiler symlink を除外)
```

## crt0

タスク共通 crt0 は `../compiler/runtime/mtos/task_crt0.s` + `task_data.s`。
compiler サブプロジェクトが所有 (compiler-on-MTOS も同じ crt0 を使う)。

詳細は `../docs/sources.md`、設計は `../docs/task/subproject_split.md`。

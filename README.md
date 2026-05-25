# MTOS — TinyC self-hosting RISC-V OS

自作言語 TinyC で書かれた、RISC-V (RV32IMA) 向けのプリエンプティブ
マルチタスク OS。コンパイラ・OS カーネル・ユーザータスクが TinyC で
書かれており、Raspberry Pi Pico 2 (RP2350) と qemu virt の 2
プラットフォームで動作する。

Pico 2 実機で kernel + 全コンパイラを byte-exact に self-replicate
可能 (K18、2026-05-14)。

## ディレクトリ

| | 説明 |
|---|---|
| [`compiler/`](compiler/README.md) | TinyC コンパイラ (Gen1: C → Gen2/3: TC 自己ホスト) |
| [`userland/`](userland/README.md) | MTOS ユーザータスク (sh, ls, vi, console, ... 40 個) |
| [`kernel/`](kernel/README.md) | OS カーネル (virt + pico2 共通) |
| [`integration/`](integration/README.md) | 3 サブプロジェクトをまたぐテスト |
| `tests/` | 共有テストインフラ (test_all.sh, test_common.sh) |
| `docs/` | ドキュメント |

## クイックスタート

```bash
make                    # Gen1 を build
make test               # 148 tests (~50s warm)
make run                # qemu virt で kernel 対話起動
make run-pico2          # Pico 2 実機を flash + UART 対話
```

## テストスコープ限定

編集箇所に応じて scoped 実行する:

```bash
make -C compiler test   # 140 tests (~60s) — compiler/src/*.tc を編集
make -C userland test   # smoke 40 tasks build (~0.07s warm) — userland/bin を編集
make -C kernel test     # test_os 8 tests (~10s) — kernel/* を編集
make full-test          # 上記 + integration テスト
```

## ドキュメント

- `docs/overview.md` — プロジェクト全体概要
- `docs/language.md` — TinyC 言語仕様
- `docs/sources.md` — ソースファイル一覧
- `docs/roadmap.md` — 開発ロードマップ
- `docs/task/subproject_split.md` — 3 サブプロジェクト分割設計
- `CLAUDE.md` — Claude Code / 開発者向けチートシート

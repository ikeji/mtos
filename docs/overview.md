# RISCV OS プロジェクト概要

## 目標

RP2350 (RISC-V モード) と qemu virt 上で動作する小規模 OS と独自
コンパイラを作り、**OS 全体をその OS 上でコンパイルできる自己ホスト
環境**を実現する。

## 対象プラットフォーム

共通 ISA は RV32IMA。2 ターゲット同一コードベース (`kernel/*.tc`)
で動く。platform 固有コードは `kernel/platform_*.s` と
`kernel/kernel.tc` / `kernel/kernel_pico2.tc` に分離。

| ターゲット | 用途 | メモリ |
|---|---|---|
| qemu-system-riscv32 -M virt | 日常の開発・CI | kernel arena 96 MB (十分広い) |
| Raspberry Pi Pico 2 (RP2350B, Hazard3 RISC-V) | 実機 | SRAM 520 KB、内 kernel arena 480 KB、外付 Flash 2 MB (XIP) |

## コンポーネント一覧

### OS (`kernel/`)

| コンポーネント | 概要 |
|---|---|
| カーネル | プリエンプティブ round-robin スケジューラ、M-mode 単一空間 |
| メモリ管理 | `kmalloc` / `kfree` (bump + free-list)、タスクごとに arena + stack を make_task で切り出す |
| プロセス管理 | ラウンドロビン、spawn / exec / wait / pipe 対応 |
| ファイルシステム | VFS + mtfs (read-only、Flash に埋め込み) + tmpfs (RAM) + procfs (virtual) + FAT (SD、bring-up 中) |
| ローダ | ELF は使わず raw binary + 8 byte header (arena_size / stack_size)。XIP 可能なら flash 直実行 |
| シェル (`sh`) | `< > |` リダイレクト / パイプ、tab 補完、history 8 件、絶対パス対応 |
| coreutils | cat, ls, wc, head, cp, du, echo, rm, grep, neofetch, vi, mx/mr (UART mux) 等 |

### コンパイラツールチェーン (`compiler/`)

Gen1 (C、`bootstrap/`) でブートし、Gen2 (TC、`compiler/`) を生成。
Gen2 が自分自身をコンパイルしたものが Gen3 (Gen2 == Gen3 で自己ホスト
達成済)。

| ツール | 入力 → 出力 | 備考 |
|---|---|---|
| `parse` | `.tc` → `.ast` | LL(1) 再帰下降、S 式 |
| `sigscan` | `.ast` → `.th` | 全 top-level (export / 非 export / struct / グローバル) を抽出 (~10 KB peak) |
| `tcheck` | `(imports) (self) (program)` → `.tast` | per-function ストリーミング型検査 (~75〜252 KB peak) |
| `codegen` | `.tast` → `.bc` | per-top-level strtab rollback (~80〜252 KB peak) |
| `bcrun` | `.bc` → stdout | バイトコードインタプリタ (リファレンス実装、常時テスト維持) |
| `bc2asm` | `.bc` → `.s` | per-function emission (~120〜126 KB peak) |
| `asm_pass1` | `.s` → `.lab` | ラベル収集。section 並べ替えリンカ兼 (~250 KB peak) |
| `asm_pass2` | `.lab` + `.s` → ELF / raw bin | 3 pass source rescan + stream emit (~260〜280 KB peak) |

GCC / GNU as / GNU ld は使わない。`asm_pass1/pass2` が「アセンブラ兼
リンカ」としてすべてを担う。

## 自己ホストのロードマップ

```
フェーズ0: 言語仕様確定・環境整備 (QEMU + 実機)                        [完了]
フェーズ1: C 実装の bootstrap (parse / typecheck / codegen / bc2asm)   [完了]
フェーズ2: TC 実装の Gen2 compiler、自己コンパイル (Gen2 == Gen3)       [完了]
フェーズ2.5: TC プログラムを RP2350 実機で実行                          [完了]
フェーズ3〜6: OS (kernel / sched / VFS / userland) を QEMU 上で開発     [完了]
フェーズ7: ネイティブコンパイラを OS 上で動かす                          [M1〜M6 完了]
フェーズ8: OS 全体を独自言語で記述し、OS 上でビルド                      [未着手]
```

現状は **フェーズ 7 M6 + Phase 1/2/3 パイプラインメモリ削減完了** 段階で、
qemu virt 上で `parse → sigscan → tcheck → codegen → bc2asm →
asm_pass1 → asm_pass2` の 7 段を回して `/tmp/hw` に吐いた raw binary を
sh から実行して "Hello, World!" を出せる。pico2 実機でも compile 段の
7 段までは byte-exact で走る (link 段の実機完走は K7 残件)。

詳細は `docs/roadmap.md` / `docs/problem.md` / `docs/task/` 参照。

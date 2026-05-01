# prelude pre-encode（asm_pass2 の prelude 処理を撲滅する案）

## 動機

phase 7 self-host で **asm_pass2 が 53 秒**（全体 57 秒の 93%）。
内訳の大半は prelude.s（~12000 行）を毎回 token + dispatch +
encode する処理。**prelude は kernel build 時点で固定**なので、
事前に raw バイナリへ encode し、OS 側 asm_pass2 はそれを memcpy
するだけにすれば大半の仕事が消える。

**期待値**: asm_pass2 53 s → ~5-10 s、TOTAL 57 s → **~15 s**。

## 現状のデータフロー

```
[kernel build (host)]
─────────────────────────────────────────────────────────────
compiler/runtime.tc   ──[Gen2 compile]──▶ runtime.s     (~234 KB)
compiler/libtc.tc     ──[Gen2 compile]──▶ libtc.s
kernel/tasks/task_crt0.s                                ┐
kernel/tasks/task_data.s                                │
                                                        ▼
                              ┌──────────────────────────────┐
                              │ build/kernel/disk-staging/   │
                              ├──────────────────────────────┤
                              │ prelude.s (= ; raw + crt0    │
                              │            + runtime.s)      │
                              │ prelude_tail.s (= task_data) │
                              │ prelude.idx                  │ ◀─── asm_pass1 --emit-idx prelude.s
                              │ /bin/<task>                  │      └──▶ prelude.idx
                              │ /hw.tc                       │
                              │ /<bench>.sh                  │
                              └──────────────────────────────┘
                                         │
                                         ▼ tools/mkfs.py
                              build/kernel/disk-extra.img (mtfs)


[OS-side compile (pico2 / virt)]
─────────────────────────────────────────────────────────────
/hw.tc ──parse──▶ /sd/1.ast ──sigscan──▶ /sd/1.th
                       │                       │
                       ▼  cat (wrap)           ▼
        empty_imports.txt + self_open.txt + 1.th + wrap_close.txt + 1.ast
                       │
                       ▼ tcheck
                   /sd/2.tast ──codegen──▶ /sd/3.bc ──bc2asm──▶ /sd/4.s
                                                                    │
        /sd/4.s + /prelude_tail.s ─[cat]─▶ /sd/u.s ◀────────────────┘
                                              │
                                              ▼  asm_pass1 --load-idx /prelude.idx
                                                          --idx-source /prelude.s
                                                          /sd/u.s /sd/u.strip
                                              ▼
                                          /sd/lab.s + /sd/u.strip
                                              │
                            (.lab に src /prelude.s / src /sd/u.strip 行を含む)
                                              │
                                              ▼ asm_pass2
                                                  ├── /prelude.s    (XIP, mtfs)
                                                  └── /sd/u.strip   (SD)
                                              ▼
                                          /sd/HW (実行可能 raw ELF)
```

`prelude.idx` は asm_pass1 の **per-file 中間状態**。
`asm_pass2` は `lab.s` の `src` 行に従って `/prelude.s`（mtfs/XIP）と
`/sd/u.strip`（SD）を直接 open し、3 回 walk して text/rodata/data
の bytes を emit。

ここで asm_pass2 が prelude.s を 3 回 walk するのが重い（~50 s）。

## 提案するデータフロー

```
[kernel build (host)] ── prelude を完全に encode してバイナリ化
─────────────────────────────────────────────────────────────
prelude.s ── asm_pass1 + asm_pass2 (host) ──▶ prelude.text.bin    (~50 KB)
                                              prelude.rodata.bin  (~300 B)
                                              prelude.data.bin    (~50 B)
                                              prelude.reloc       (~16 B、1 エントリ)
                                              prelude.idx         (既存)


[OS-side compile]
─────────────────────────────────────────────────────────────
parse → sigscan → cat → tcheck → codegen → bc2asm → cat (user+tail)
                                                            │
                                                            ▼
                                                        /sd/u.s
                                                            │
                                                            ▼ asm_pass1 (変更なし、.idx 経由)
                                                            ▼
                                                      /sd/lab.s + /sd/u.strip
                                                            │
                                          .lab に従い asm_pass2 が以下を組み合わせ：
                                          ┌──── /prelude.text.bin   (memcpy)
                                          ├──── /prelude.rodata.bin (memcpy)
                                          ├──── /prelude.data.bin   (memcpy)
                                          ├──── /prelude.reloc      (patch)
                                          └──── /sd/u.strip          (encode)
                                                            ▼
                                                        /sd/HW
```

## ファイル形式

### `prelude.text.bin` / `prelude.rodata.bin` / `prelude.data.bin`

raw バイト列。section の中身を encode 済みの形で保持。
- `prelude.text.bin`: 命令列 (RV32) を 4 byte 単位で並べたもの
- `prelude.rodata.bin`: `.word`/`.string` ディレクティブの bytes
- `prelude.data.bin`: 同上

`prelude.idx` の `secsize` 行とサイズが一致する。

### `prelude.reloc` (新形式)

各エントリ：`(offset_in_text, target_name, kind)`。

```
; prelude.reloc v1
; kind: 0=jal-pcrel-21bit, 1=auipc-jalr-pcrel-32bit
reloc <offset> <kind> <target_name>
```

prelude を host で encode した時点で `target_name` の最終アドレスは
未定。リンク時 (asm_pass2 OS-side) に target を resolve して当該
オフセットの 4-byte 命令を patch。

実例：`_start` 内の `call main__StringArray` 1 個のみ：
```
reloc 84 1 main__StringArray
```
（offset 84 = `_start` 中の `auipc + jalr` の位置）

### 拡張 `.lab`

asm_pass1 の出力 `.lab` に新しい行種別を追加：
```
src raw <path> <section_id>     ; pre-encoded binary; section 0=text 1=rodata 2=data
src asm <path>                  ; 既存：encode 対象の .s ファイル
reloc <offset> <kind> <name>    ; reloc table（per-prelude）
```

asm_pass2 は `src raw` を memcpy、`src asm` を encode、`reloc` を最後に patch。

## プログラム別 役割と入出力

### kernel build（host 側、1 回だけ）

| program | 入力 | 出力 |
|---|---|---|
| `bc2asm` 等 | runtime.tc 等 | runtime.s（既存） |
| **`asm_pass1 --emit-idx`** | prelude.s | **prelude.idx**（既存） |
| **`asm_pass1 --emit-bin`** *(新)* | prelude.s | **prelude.{text,rodata,data}.bin + prelude.reloc**（新） |
| `mkfs.py` | staging dir | mtfs.img |

`asm_pass1 --emit-bin` モードを新設：
- pass 1a で label 収集
- BFS スキップ（prelude 単体は live 全部）
- compute_sec_bases / fixup でアドレス確定
- 各 section ごとに encode → .bin 出力
- `_start` の `call main__StringArray` を検出 → reloc 行を出力

### OS 側 compile（毎回）

| program | 入力 | 出力 |
|---|---|---|
| parse | /hw.tc | /sd/1.ast |
| sigscan | /sd/1.ast | /sd/1.th |
| cat (wrap) | empty_imports + self_open + 1.th + wrap_close + 1.ast | /sd/1.wr |
| tcheck | /sd/1.wr | /sd/2.tast |
| codegen | /sd/2.tast | /sd/3.bc |
| bc2asm | /sd/3.bc | /sd/4.s |
| cat | /sd/4.s + /prelude_tail.s | /sd/u.s |
| **asm_pass1** | **/prelude.idx + /sd/u.s** | **/sd/lab.s + /sd/u.strip**（変更：lab に src raw 行を埋め込み） |
| **asm_pass2** *(改造)* | **/sd/lab.s + /prelude.{text,rodata,data}.bin + /prelude.reloc + /sd/u.strip** | **/sd/HW** |
| (実行) | /sd/HW | "Hello, World!" |

asm_pass1 の変更：
- `--load-idx` モードで .lab 出力時、`src raw /prelude.text.bin 0` 等の行も emit
- prelude reloc を引き継ぐ（prelude.idx に reloc を含める or 別ファイル参照）

asm_pass2 の変更：
- `.lab` 内 `src raw` 行を見たら該当 section 出力中はそのファイルを memcpy
- `src asm` 行は既存の encode loop
- 全 section emit 後、reloc table を読んで該当 offset を patch

## 段階的実装プラン

| step | 内容 | commit 単位 |
|---|---|---|
| 1 | `.lab` フォーマット拡張（`src raw` / `reloc`）+ docs 更新 | 1 |
| 2 | asm_pass1 に `--emit-bin` モード追加（per-section encode） | 1 |
| 3 | asm_pass2 で `src raw` を memcpy 対応 | 1 |
| 4 | asm_pass2 で reloc patch 対応 | 1 |
| 5 | kernel/build.sh で host 側 prelude pre-encode 実行 + mtfs ステージ | 1 |
| 6 | `pico2_bench_idx.sh` を新パイプラインに切替、ベンチ | 1 |
| 7 | virt phase 7 + pico2 実機検証、必要なら docs/scaling.md 更新 | 1 |

各 step は単独で revert 可能。step 3-4 の間は asm_pass2 が中間状態
（src raw あるけど reloc 無し）になるが、`reloc` 行が空なら fallback
動作（ただの memcpy + encode）で前進可能。

## トレードオフ

**メリット**：
- asm_pass2 の prelude 部 token+dispatch+encode が消える → ~40 s 削減見込み
- 既に確定している計算（kernel build 時点で）を毎回繰り返さない

**デメリット / リスク**：
- **prelude を変更したら kernel rebuild 必須**（だが既にそうなってる）
- **reloc table 形式は 1 個増える**（フォーマット仕様 + tooling）
- **asm_pass2 の section pass loop が複雑化**（src raw / src asm の切り替え）
- **prelude bytes が固定**前提：`call main__StringArray` 以外に user に
  forward する参照が将来増えると reloc 増やす必要あり（影響範囲は
  asm_pass1 の reloc emit + asm_pass2 の patch）

## 関連ドキュメント

- [docs/lab_format.md](../lab_format.md) — `.lab` フォーマット（拡張対象）
- [docs/idx_format.md](../idx_format.md) — `.idx` フォーマット
- [docs/task/asm_pass_split.md](asm_pass_split.md) — 4-pass 整理
- [docs/scaling.md](../scaling.md) — phase 7 のステージ別計測

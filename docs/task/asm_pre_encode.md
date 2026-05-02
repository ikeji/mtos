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
                       └───────────────────────┴──┐
                                                  ▼ tcheck --tgth /sd/1.th
                                                           --tgt /sd/1.ast
                                                           --out /sd/2.tast
                                                  ▼
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

**注**: 2026-05-01 に tcheck が file-args (`--exth` / `--tgth` /
`--tgt` / `--out`) 対応になり cat-wrap step が不要になった
(commit 775a004)。同じ file-args パターンを **asm_pass1 / asm_pass2
にも適用するのが pre-encode の前提**：asm_pass2 が複数の入力ファイル
（prelude.bin × 3 + user.strip）を取れるよう、stdin パイプ前提から
脱却する必要がある。

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
parse → sigscan → tcheck (file-args) → codegen → bc2asm → cat (user+tail)
                                                            │
                                                            ▼
                                                        /sd/u.s
                                                            │
                                                            ▼ asm_pass1 (--load-idx)
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
| **tcheck** | **--tgth /sd/1.th --tgt /sd/1.ast --out /sd/2.tast** *(file-args 対応済 commit 775a004)* | /sd/2.tast |
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

**前提ステップ**（CLI を file-args に統一）：

| step | 内容 | 状態 |
|---|---|---|
| 0a | tcheck `--exth/--tgth/--tgt/--out` | ✅ 完了 (commit 775a004) |
| 0b | asm_pass1 `--lab-out / --strip-out / --user-src` 等の整理 | TODO |
| 0c | asm_pass2 `--lab / --src-raw <path> <sec> / --src-asm <path> / --out` | TODO |

asm_pass1 / asm_pass2 を stdin/stdout 前提から脱却させて**複数入力
ファイルを引数で受け取れる**ようにする。pre-encode 設計では
asm_pass2 が `prelude.{text,rodata,data}.bin` + `/sd/u.strip` の
4 ファイルを section 順に combine するので、stdin パイプは表現
不能。

**本体ステップ**：

| step | 内容 | 状態 |
|---|---|---|
| 1 | `.lab` フォーマット拡張（`src raw` / `reloc`）+ docs 更新 | ✅ commit 2aa3f0a |
| 2 | asm_pass2 に `--emit-bin` モード追加 + reloc detect | ✅ commit 2f6097d |
| 3 | asm_pass2 で `src raw` を memcpy 対応 | ✅ commit 692d8c1 |
| 4 | asm_pass2 で reloc patch 対応 | ✅ commit 749a0f6 |
| 5 | Makefile で host 側 prelude pre-encode 実行 + mtfs ステージ | ✅ commit d7b5e72 |
| 6 | asm_pass1 `--prelude-*` flags + `pico2_bench_idx.sh` 切替 | ✅ commit 40ee22f |
| 7 | virt phase 7 + pico2 実機検証 | 🚧 partial |

**Step 7 の状態 (2026-05-02)**:

- `tests/test_phase7.sh` (legacy stdin pipeline; 結果として
  `--prelude-*` flag を使わない経路): **stage 1 + stage 2
  PASS** (Hello, World! + M7-minimal の OS 上 string_buffer.tc
  コンパイル)。Hello World pipeline 自体は引き続き動作している
- 新パイプライン (`asm_pass1 --prelude-text-bin ... + asm_pass2
  --lab/--out`): asm_pass1 task は v2 .lab を正しく出力するが、
  asm_pass2 が memcpy + reloc-patch した `/tmp/HW` は load して
  実行はされるが何も出力しない。reloc patcher の offset 計算か、
  prelude の dead-strip 抜きで全関数を含めることによる二次効果が
  疑われる (legacy 18 KB 対 pre-encode 44 KB)。tcheck の packed
  16-bit sentinel 修正 (ast_node.tc unpack_hi、commit 6295afc)
  までは asm_pass2 task 自体が `parse_mem_off__?` で build しなかった
- pico2 実機検証は未実施 (Debug Probe + SD card 必要、CI 不可)

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

## CLI まとめ（file-args への移行ロードマップ）

| tool | 現状 | 移行後 |
|---|---|---|
| parse | stdin → stdout | （要検討、まだ stdin） |
| sigscan | stdin → stdout | （要検討、まだ stdin） |
| tcheck | stdin → stdout | ✅ `--exth/--tgth/--tgt/--out` |
| codegen | stdin → stdout | （要検討） |
| bc2asm | stdin → stdout | （要検討） |
| asm_pass1 | argv (`/path/to/src.s [strip.s]`) + `--load-idx`/`--emit-idx` | 既に file-args（pre-encode で `--emit-bin` 追加） |
| asm_pass2 | stdin (`.lab + 3 × source`) → stdout | `--lab + --src-raw × N + --src-asm × N + --out` |

stdin/stdout 中心の Unix-pipe 風 vs 明示的 file-args の選択：
- **Unix-pipe**: 並列性・組合せ性が高い。1 in / 1 out の単純フィルタ向き
- **file-args**: 多入力 / 多出力 / 複雑な組合せ向き。OS 側の SD 経由
  パイプラインでは file-args の方がオーバーヘッド少ない（pipe syscall
  もあるが file 介した方が直接的）

asm_pass2 は **多入力**を扱う必要があるので file-args 必須。tcheck
も実質 3 入力なので file-args が綺麗。parse / sigscan / codegen /
bc2asm は 1 in / 1 out なので stdin 維持で問題ない。

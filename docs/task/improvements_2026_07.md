# プロジェクト改善候補 (2026-07-05 レビュー)

K22 (DOOM TITLEPIC 表示) 到達時点で、`docs/problem.md` /
`docs/scaling.md` / `docs/roadmap.md` / `docs/task/code_improvements.md`
とコードベースを見直して抽出した改善候補。2026-04-22 の
`code_improvements.md` (コードレビュー起点、45 項目) と違い、本稿は
**プロジェクト運営レベル** (信頼性・性能・テスト・ドキュメント) の
横断リストで、個別のコード品質項目は扱わない。

各項目に 優先度 (P1 = 次にやる価値が高い / P2 = 効果はあるが急がない
/ P3 = 機会があれば)、規模 (S = 半日以内 / M = 数日 / L = 週単位) を
付けた。

## サマリ

| # | 項目 | 分類 | 優先度 | 規模 |
|---|---|---|---|---|
| 1 | codegen: グローバル var の StringLiteral 初期化バグ修正 (#36) | バグ | **済 2026-07-05** | S |
| 2 | SD 書き込み高速化 (CMD25 / SPI クロック) | 性能 | **済 2026-07-05** | M |
| 3 | ドキュメントの stale 記述掃除 (パス・解決済エントリ) | docs | **済 2026-07-05** | S |
| 4 | PL011 RX IRQ + nested trap (K11 根本解決) | 信頼性 | P2 | L |
| 5 | peek/poke/get/set intrinsic 化 (#20) → 実は解決済みだった (§2-2) | 性能+安全 | **済 (stale)** | — |
| 6 | tmpfs_unlink 追加 (#30) | 機能 | **済 2026-07-05** | S |
| 7 | userland タスクの単体テスト整備 | テスト | P2 | M |
| 8 | tcheck vartab / fntab の動的化 (#10, Q5) | limitation | **済 2026-07-07** | M |
| 9 | realloc 式 in-place grow (kmalloc 拡張) | 性能 | P2 | M |
| 10 | sh の CWD / 相対パス対応 (#31) | 機能 | P3 | M |
| 11 | tcheck エラーの file:line 化 (#5 段階 2) | DX | P3 | L |
| 12 | ILI9488 16-bit pixel format (0x55) の検証 (#38 残) | 性能 | P3 | S |
| 13 | PIO2 GPIOBASE 問題の再調査 (#37) | 性能 | P3 | M |
| 14 | `make test` 実行時間の headroom 計測を自動化 | テスト | P3 | S |
| 15 | self_replicate NORESET=1 のデフォルト化判断 | 運用 | P3 | S |

---

## 1. バグ・信頼性

### 1-1. codegen: `var X: StringLiteral = "..."` が `.word 0` になる (#36) — P1 / S

既知の明確なコンパイラバグで、回避策 (literal を関数経由で返す) が
`keyboard_matrix.tc` などに散っている。self-host コンパイラの正しさが
プロジェクトの根幹なので、既知バグの中では優先度最高。
`compiler/src/codegen.tc` の cg_var_decl の var_decl + str init 経路を
直し、golden テストを 1 本足す。修正後は `keyboard_matrix.tc` の
`keymap()` ワークアラウンドを戻せる。

参照: `docs/problem.md` #36。

### 1-2. PL011 RX IRQ + nested trap (K11 Phase 2B) — P2 / L

`mr -a` の ACK + checksum プロトコル (K21) で実用上は回避済みだが、
「長時間 ecall 中 (SD write 等) は UART RX FIFO が overflow し得る」
という本質は残っている。今は upload 経路しか守られておらず、将来
対話的なタスク (エディタ、ゲーム) が SD I/O と UART 入力を同時に
使うと再発する。`trap_common.s` に mscratch 退避 + nested trap stack
を入れて RX IRQ 駆動の drain にするのが本筋。

規模が大きい (trap entry の改修 + 全 syscall 経路の再検証) ので、
実害が再発したタイミングで着手が妥当。着手時は
`integration/pico2_k11_reproduce.py` が回帰テストとして使える。

参照: `docs/problem.md` K8+K9 Phase 2B、K11。

### 1-3. tmpfs_unlink (#30) — 済み (2026-07-05)

実装した (`tmpfs_unlink` + `vfs_unlink` の is_tmp_path ブランチ +
test_os.sh fs_virtio に rm × 2 回帰ケース)。`docs/solved.md` #30。

---

## 2. 性能

### 2-1. SD 書き込みの高速化 — 済み (2026-07-05、read/write とも ~1.45×)

**実施結果**: 現ボードは 6 MHz ハード SPI ではなく bit-bang SIO
駆動だった (下の記述は旧ボード前提で一部 stale)。実施した 2 点:
(1) `sd_spi_xfer` の bit ループからラッパー関数呼び出しを排除して
peek32/poke32 直呼び (bc2asm inline) に、(2) CMD24 単発書き込みを
CMD25 バースト化 (連続セクタは CS 保持で追記、vfs の write 系出口の
`fat_block_sync` で確定)。実測 (81 KB cp): read 34→49 KB/s、write
21→32 KB/s (2 回目) / 6.4→9.5 KB/s (初回、FAT scan 支配)。詳細は
`docs/pico2_hardware.md` SD 節。残る伸びしろは per-byte TC 呼び出し
コスト → asm 化 or PIO (#37 GPIOBASE が塞ぐ)。以下は着手前の記述:

self_replicate ~50 min の支配項は全部 SD 書き込み
(asm_pass3 link ~10 min + bin2uf2 ~9 min + dx.img upload ~6 min、
`docs/scaling.md` Q6)。write ~5 KB/s は SPI 6 MHz の理論値
(~750 KB/s) から 2 桁遅く、伸びしろが最も大きい。候補:

1. **CMD25 (multi-block write)**: 現状 `block_sd.tc` はセクタ毎に
   CMD24 + busy wait。連続セクタを CMD25 でまとめれば busy wait が
   ブロック列単位に償却される。fatfs の書き込みは大半が連続
   クラスタなので効きやすい。
2. **SPI クロック引き上げ**: SD は initialization 後 25 MHz まで
   規格内。現行 6 MHz は bit-bang / 配線品質由来の保守値なら、
   まず 12 MHz を試す価値がある。
3. **fatfs の write-behind**: FAT cache (commit 27ec588) は read 側
   中心。dirty sector の遅延書き出しでさらに削れる可能性があるが、
   電源断時の破損リスクと引き換えなので優先度は 1, 2 の後。

計測は `integration/pico2_self_replicate.sh` の step 3/4 の
wall-clock がそのまま使える。self_replicate が 50 min → 20 min 台に
なると開発イテレーションが体感で変わる。

### 2-2. peek/poke/get/set の intrinsic 化 (#20) — 済み (棚卸しで判明、2026-07-05)

着手時の調査で、**既に解決済み**と判明: bc2asm の
`try_inline_builtin` が peek/poke を 1 命令、get/set を数命令に
インライン展開しており (2026-04〜05 実装)、get の境界チェック (#6)
も 2026-05-11 (8501f6d) に入っていた。problem.md の #6 / #20 が
stale なまま残っていただけ。両エントリは `docs/solved.md` へ移動
済み。本項は「ドキュメント台帳の棚卸しが必要」の実例として残す。

### 2-3. realloc 式 in-place grow — P2 / M

`docs/scaling.md` の残削減候補 1 位。name pool 等の x2 grow が
old+new 同時生存の transient peak を作っており、kmalloc に
「large block の in-place 拡張」を足せば asm_pass2/pass3 の peak が
~30 KB 下がる。K19 の two-ended allocator で large heap が連続を
保つようになったので、末尾ブロックの extend は実装しやすくなって
いるはず。task arena の縮小 → 多タスク同時 alive の余裕にも繋がる。

### 2-4. LCD 系: 16-bit pixel format 検証 (#38 残) / PIO2 再調査 (#37) — P3

- 16-bit (0x3A=0x55) は未検証のまま。多くの ILI9488 互換が受ける
  ので、動けば SPI 転送 33% 削減。試すだけなら S 規模。
- PIO2 GPIOBASE (0x168 が書けない) は ACCESSCTRL / OTP / chip
  variant の切り分けが残っている。動けば理論 ~20× だが、bit-bang
  で実用域なので急がない。

---

## 3. 言語・コンパイラの limitation 解消

### 3-1. tcheck vartab / fntab の動的化 — 済み (2026-07-07)

実施。tcheck の nodes 4096 / vartab 1024 / fntab 1024、codegen の
nodes 4096、bc2asm の per-fn instr/label buffer を ×2 動的 grow +
locals_pool 512 に拡大し、**bcrun.tc が Gen2 で self-compile 可能に**
なった (「全ソース self-host」の唯一の例外を解消、problem.md #10 も
クローズ)。task arena は tcheck 320 / codegen 224 / bc2asm 176 KB に
bump。回帰は test_gen3.sh の FULL_TEST ケース。詳細は
`docs/solved.md`「#10 + Q5」、`docs/scaling.md` Q5。

### 3-2. tcheck エラーの `file:line` 化 (#5 段階 2) — P3 / L

AST に `@line` を通す大規模変更。段階 1 (関数名 + near: comment) で
実用上足りているので、コンパイラを大きく触るタイミング (例えば
3-1 の動的配列導入) に相乗りさせるのが現実的。

### 3-3. `"abc" + "def"` がポインタ加算になる件 (#36 の副記述) — P3 / S

コンパイル時 concat が無いこと自体は許容できるが、**型が通って
無意味なコードが出る**のは罠。tcheck で StringLiteral + StringLiteral
を型エラーにするだけなら小規模で、誤用を防げる。

---

## 4. テスト・CI

### 4-1. userland タスクの単体テスト整備 — P2 / M

現状 `make -C userland test` は build smoke のみで、40 タスクの
挙動テストはゼロ。sh / vi / grep 等は過去に実バグ (H11, H13, M10
等) が出ており、リグレッション網が無いのはリスク。全部は不要で、

- ロジックが濃いもの (sh のトークナイズ/リダイレクト、grep の
  マッチ、vi のバッファ操作) に絞る
- qemu virt + msh fixture (`kernel/tests/fixtures/msh_smoke.sh` の
  流儀) で「入力 → UART 出力の golden 比較」形式にする

くらいが費用対効果の均衡点。`make test` 1 分制約があるので、
追加分は `FULL_TEST=1` 側に置く選択肢もある。

### 4-2. `make test` 実行時間の可視化 — P3 / S

CLAUDE.md の「1 分以内維持」ルールは現状 ~50s (warm) で headroom
が 10s しかない。`tests/test_all.sh` が suite 毎の実行時間を出力し、
合計が閾値 (例えば 55s) を超えたら警告する行を足しておくと、
「気づいたら超えていた」を防げる。

### 4-3. 実機テストの定期実行 — P3 / S〜M

`test_pico2*.sh` / self_replicate は手動起動のみ。実機接続が前提
なので CI 化は難しいが、「最後に self_replicate が通った commit」を
docs か tag で記録するだけでも、byte-exact regression (K20 の再発)
の切り分けが速くなる。K20 対策の
`make self-replicate-fixtures-check` は host 側 drift しか見ない
ので、実機側の定期確認は別途必要。

---

## 5. ドキュメント整備 — P1 / S

コード品質と違い一括で安く直せるので、まとめて 1 コミットで:

1. **stale パスの修正**: `docs/scaling.md` に subproject split 前の
   パスが残っている (`kernel/kernel/tests/test_pico2_bench.sh`、
   `tests/pico2_self_replicate.sh`、`tests/bench_pipeline.sh` 等。
   現在は `kernel/tests/` / `integration/` / `compiler/tests/`)。
2. **problem.md の解決済エントリ移動**: #32, #33 (解決済 2026-05)、
   K7 / K12 (解決済) が「後回し」セクションに残っている。
   `docs/solved.md` へ移すか要約 1 行 + リンクに縮める。
3. **roadmap のフェーズ 9 実機検証残の更新**: S3/S4 (ILI9488) は
   K22 / touch 対応で実機動作済のはず。S2 (DS3231) / S5 (キーボード
   マトリクス) の未検証ステータスが現状と合っているか確認して更新。
4. **scaling.md Q1 の推計更新**: 「OS 全体コンパイル 15〜30 分
   (要再測定)」とあるが、self_replicate 実測 (~50 min、Q6) が
   既にあるので、Q1 の古い推計は Q6 への参照に置き換える。

---

## 6. 運用・その他

### 6-1. self_replicate NORESET=1 のデフォルト化 — P3 / S

`docs/scaling.md` Q6 で「1 boot 完走が安定したらデフォルト化を判断」
と保留したまま。K21 以降の実績で安定しているなら、デフォルトを
NORESET にして step 間 reset を opt-in (`RESET_EACH_STEP=1` 等) に
反転する。失敗時の自動 fallback (reset して該当 step を retry) を
足せると更に良い。

### 6-2. K22 続編 (DOOM E1M1) — 独立トラック

roadmap 記載済みなので詳細は省くが、改善観点では「zone 112 KB
不足」は 2-3 (in-place grow) や kernel `__arena` 縮小と地続きの
メモリ予算問題。blockmap の .bss 固定が最小手術。
`docs/problem.md` K22 残件参照。

### 6-3. code_improvements.md の TBD 4 件の再判定 — P3 / S

L3 (block_fat_virtio 重複)、L6 (vfs パスウォーク重複)、L16 (vi
row_col O(n))、L17 (tty_tag if chain) が TBD のまま 2 ヶ月以上
経過。実害が出ていないなら REJECTED に落として台帳を閉じるか、
やる条件 (トリガ) を明記して寝かせる。

---

## 推奨着手順

1. **ドキュメント掃除 (§5)** — 半日で完了、以後の判断材料が正確になる
2. **#36 codegen バグ (§1-1)** — self-host の正しさ直結、S 規模
3. **SD 書き込み高速化 (§2-1)** — 開発イテレーション全体が速くなる
4. **peek/poke intrinsic + get 境界チェック (§2-2)** — 性能と安全の連鎖
5. 以降は DOOM 続編 / K11 根本解決 / vartab 動的化 を興味と実害に応じて

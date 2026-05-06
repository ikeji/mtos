# asm-pass1 の 4 段化と prelude キャッシュ (.idx)

## 動機

phase 7 の self-host pipeline で `asm_pass2` が 100 秒占めるが、
そのほとんど（~95 s）は **prelude.s** (task_crt0 + runtime.s、~70 KB
/ 11 K 行) の source walk + label 収集。prelude は kernel build
時点で固定なので、毎回 OS 上で再走査する必要はない。

更に `asm_pass2` 自体も label 収集 / BFS / アドレス確定 / strip / dump
が 1 関数に詰まっており、責務が混ざって見通しが悪い。整理する
タイミングで per-file 抽出と link を分ける。

## 4 段の責務

| 段 | 責務 | 入力 | 出力 |
|---|---|---|---|
| 1 extract | per-file の section/label/refs 抽出 | `.s` | `.idx` |
| 2 cull | 全 `.idx` を merge → BFS で live set 決定 | `.idx × N` | (in-memory live bitmap) |
| 3 addr | live ラベルに最終アドレス、section base 確定 | (in-memory) + `.idx` | `.lab` |
| 4 encode | アドレス確定済み label table + source bytes で encode | `.lab` + `.s × N` | ELF / raw bin |

`.idx` フォーマットは [docs/idx_format.md](../idx_format.md) を参照。

### Pass 1 (extract)

asm-pass1 を `--emit-idx <out.idx>` モードで起動：

- 既存の pass 1a (`process_source` + `define_label` + `pass1_scan_operand_refs`) を流用
- BFS / fixup / strip は走らせない
- 出力は intra アドレスのまま
- `record_ref` の出力は (owner_idx, target_idx) ではなく (owner_name, target_name) として `ref` 行で吐く（idx は per-file なので merge 後に再採番が必要）

`.idx` は **キャッシュ可能**: prelude.s は kernel build 時に host
側 asm_pass2 で `.idx` 化し、mtfs に staging。OS 上では再生成不要。

### Pass 2-3 (cull + addr)

asm-pass1 の **link モード**（`--load-idx <a.idx>,<b.idx>,...` +
通常引数）：

- 起動時に listed `.idx` を読み込む（`define_label` を name 経由で
  呼び、`g_labels` に登録。intra addr は section 寄与の累積を加味）
- 既存の `--strip-out` 引数で指定された source を pass 1a と同じ
  ように処理（user.s 部分の label/ref 収集）
- 全 .idx + user の section/label/ref が揃ったら `compute_sec_bases`
  → `compute_live` (BFS) → `fixup_labels` で絶対アドレス
- `.lab` を出力（live ラベルのみ、現フォーマットそのまま）

stdin パス（host build pipeline）は今まで通り `.idx` 不使用 + 1 ファイル
入力を維持。

### Pass 4 (encode)

asm-pass2 は変更なし。`.lab` + `.s × N` を読んで encode するだけ。

## 期待効果

prelude.idx を事前生成して OS 上で `asm_pass2 --load-idx /prelude.idx
/sd/sb.s /sd/strip.s > /sd/lab.s` のように起動すると：

- prelude の source walk (~95 s) を skip
- user.s だけ pass 1a で処理 → 数秒
- BFS / fixup / strip は live set が小さくなった分も短縮

string_buffer.tc 自己コンパイル: 100 s → ~10 s 見込み。
全パイプラインで 139 s → ~50 s。

## 実装ステップ

1. **`.idx` フォーマット定義 + writer** (asm_common.tc に
   `asm_dump_idx_state()` を追加。現 `asm_dump_lab_state` の per-file
   メタデータ版)
2. **asm-pass1 の `--emit-idx` モード** (run() を分岐: BFS/fixup を
   skip して `.idx` を吐いて終了)
3. **`.idx` reader** (asm_common.tc に `asm_load_idx(path)` を追加。
   ファイル open → 行 parse → define_label / record_ref を呼ぶ)
4. **asm-pass1 の `--load-idx` モード** (起動直後に listed `.idx` を
   全部 load してから user.s の処理に入る)
5. **kernel/build.sh で prelude.idx 生成** (host asm_pass2 を
   `--emit-idx` で 1 回呼んで `mtfs/prelude.idx` に staging)
6. **bench script で `--load-idx` 使用** (新しい
   `pico2_bench_idx.sh` を staging、test_pico2_bench.sh で測定)
7. **既存 phase7 pipeline にも反映** (test_pico2_phase7_sd.sh /
   test_phase7.sh を `--load-idx` 経由に切り替え)

各ステップで `make test` + virt phase 7 + pico2 bench の
correctness を確認しつつ進める。

## トレードオフ

- **新フォーマット**: `.idx` 1 つ増える。仕様 doc + reader / writer 実装 +
  バージョン管理が要る。`.lab` のフィールドを増やして共用する案も
  検討したが、用途（per-file / final）と addr 種類（intra / 絶対）が
  違うので別形式の方が読みやすい
- **重複コード**: `define_label` を idx ロード経路でも呼ぶので
  既存 pass 1a パスとの整合性に注意。intra addr で渡せば g_pos を
  動かさずに登録できる
- **ref の文字列保持**: idx に owner name を文字列で記録するため
  メモリと I/O が増える。ただし forward-ref 用の deferred queue と
  類似の名前プールで一括管理すれば吸収できる
- **段階的移行**: stdin パス (compile-gen2.sh / kernel build) は
  現状維持。dead-strip も argv モードのまま。新規追加するのは
  `--emit-idx` / `--load-idx` 2 オプション

## 関連

- [docs/idx_format.md](../idx_format.md) — `.idx` フォーマット仕様
- [docs/lab_format.md](../lab_format.md) — `.lab` フォーマット (asm-pass2 入力)
- [docs/task/asm_dead_strip.md](asm_dead_strip.md) — 既存の dead-strip 設計
- [docs/scaling.md](../scaling.md) — phase 7 self-host のステージ別計測

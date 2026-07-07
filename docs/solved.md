# 解決済みの問題

`docs/problem.md` から移動。コミットメッセージで詳細がわかる。

---

## asm_pass2 / asm_pass3 (アセンブラ兼リンカ)

### 7. パイプライン 100 KB 計画: Phase 1+2+3+4+5 完了 (2026-04-16)

**元の「asm.tc 9 MB」問題は Phase 1+2+3+4+5 で実質解決済**。
`compiler/asm.tc` は `asm_common.tc + asm_pass2.tc + asm_pass3.tc`
に分割され、2026-04-15 の Gen2 toolchain migration で旧 asm.tc /
typecheck.tc は削除。asm_pass3 の g_code を .lab のセクションサイズ
合計で動的確保する仕組み (Phase 4) で、旧 4 MB 固定を廃止済。

実測ピーク (compile-gen2.sh で build した Gen3 tools を
qemu-riscv32 で動かして `[kmem peak=N live=M]` を回収):

| タスク    | before  | compiler/*.tc (2026-04-16) | 改善量 |
|---|---:|---:|---:|
| parse         | 14 KB  | 14 KB          | — |
| sigscan (新)  | —      | 9〜11 KB       | — |
| tcheck  (新)  | —      | 74〜244 KB     | — |
| codegen       | 303 KB | 79〜246 KB     | ~2x |
| bc2asm        | 1.4 MB | 118〜124 KB    | ~11x |
| asm-pass1 (新)| —      | **227〜268 KB** | (label pool shrink) |
| asm-pass2 (新)| —      | **260〜280 KB** | (Phase 5 stream-emit) |
| (legacy asm)  | 9.5 MB | — (削除済)     | |

Phase 5 (commit 426f51e, 2026-04-16) で **asm_pass3 から g_code を
廃止**し、source を 3 回再読み込みして target section を 4 KB out_buf
経由で直接 stdout に stream emit する方式に変更。Phase 4 の動的確保
段階では ~440 KB だったのが ~260 KB まで落ちた。asm_pass2 も別途
`MAX_LABELS 16384 → 4096` + `MAX_NAME_POOL 256K → 128K` の shrink
(commit 5098a1e) で ~430 KB → ~250 KB へ。

**結果**: すべての compiler task が Pico 2 kernel arena (480 KB) に
余裕で収まる。

対処履歴:
- Phase 1 (#49〜#54、#62〜#64): typecheck を sigscan + tcheck に分割。
  per-top-level AST streaming + per-fn kmalloc fntab で 717 KB → 75 KB 台
- Phase 2 (#55〜#58): asm を 3 ファイルに分割。`.lab` 中間ファイルで
  pass1 / pass2 を別プロセス化。g_lines 4 MB 廃止
- Phase 3 (#59、#60): codegen と bc2asm を in-place shrink。bc2asm は
  per-function emission で 1.4 MB → 126 KB
- Phase 4: asm_pass3 の g_code を .lab のセクションサイズ合計で動的確保。
  `MAX_CODE = 4194300` 固定を廃止、bss は filesz に含めない。
  4.6 MB → 441 KB (~10x)
- Phase 5: asm_pass3 の g_code 自体を廃止、3-pass source re-scan で
  stream emit。441 KB → 260 KB

計画詳細: `docs/task/pipeline_100kb.md`、.lab 仕様: `docs/lab_format.md`。

### 8. dead-strip 既定 ON + alias label バグ修正 (2026-05-13)

`asm_pass2` の dead-strip (Phase B + C) を `--strip` / `ASM_STRIP=1`
のオプトインから常時 ON へ。`compile-gen2.sh` 経路 (ホスト + デバイス
self_replicate) では dead code を自動で除去し、kernel.bin で
**290 KB → 264 KB** (~9%)、guest task では **53 KB → 24 KB** (~半減)
程度の縮小。`compiler/src/asm_pass2.tc` から `--strip` フラグ、
`asm_common.tc` から `g_ds_strip` / `asm_dead_strip_set_strip` /
`asm_dead_strip_get_strip` を撤去、`asm_dead_strip.tc` から
opt-in 分岐 (`ds_print_compact_analysis`) を削除、`compile-gen2.sh`
から `ASM_STRIP_FLAG` を撤去。

**併せて発覚した alias label バグ** (commit b7d8b4d 同梱):

既定 ON にしてはじめて踏んだ。`compiler/runtime/mtos/task_crt0.s` は
`do_openat__String / do_openat__StringLiteral` のように **同一バイト
オフセットに 2 個の `.globl`** を置く (String / StringLiteral
オーバーロード) パターンを多用している。dead-strip Phase B の BFS は
オーバーロードのうち sh が実際に呼ぶ片方しか live にしない (例:
sh.tc は `do_openat__String` のみ参照)。

ds_compact の Phase 1 ループ:

```tc
while i < n_in_sec {
    ...
    next_addr = asm_label_addr_at(get(workspace, i + 1));
    if asm_dead_strip_is_live(lab_idx) == 0 {
        asm_ds_dr_add(s, dr_start, dr_end);   // ← dead range
    }
    i = i + 1;
}
```

は label を 1 個ずつ処理する。dead な `do_openat__StringLiteral` が
処理されると `next_addr` は **同 addr の次の label** ではなく **次の
distinct addr** (= `do_close`) を指し、結果 `[144, 156)` が dead 範囲
として記録される。`do_openat__String` (live) のバイトがその範囲に
入っていて消えてしまう。

`sh.lab` の症状:

```
lab 144 0 do_openat__i32__String__i32   ← 正
lab 144 0 do_close__i32                 ← 156 → 144 へ衝突
lab 156 0 do_exit__i32                  ← 168 → 156 へずれ
lab 168 0 do_spawn__...                 ← 192 → 168 へずれ
```

sh が `do_spawn` を呼ぶと実体は `do_openat` の `li a7, 56; ecall` に
なるため `spawn` が `openat` を実行、a0 (path 引数の代わりに argv
ポインタ) が不正な fd と解釈されて syscall fail → `sh: spawn failed`。

**修正**: ds_compact の Phase 1 を **addr グループ単位**で処理する。

```tc
while i < n_in_sec {
    var lab_addr = asm_label_addr_at(get(workspace, i));
    var j = i;
    var group_live = 0;
    while j < n_in_sec && asm_label_addr_at(get(workspace, j)) == lab_addr {
        if asm_dead_strip_is_live(get(workspace, j)) != 0 { group_live = 1; }
        j = j + 1;
    }
    // gap を group 全員に同じ値で設定
    if group_live == 0 && next_addr > lab_addr {
        asm_ds_dr_add(s, dr_start, dr_end);
    }
    i = j;
}
```

同一 addr に並ぶ alias 群を 1 グループとみなし、liveness を OR で
合成。「alias の片方でも live なら group 全体を keep」。これで
`do_openat` のバイトは保護され、`do_exec__String + do_exec__StringLiteral`
のように両方 dead な group は従来通り compact される。

回帰確認: `make test` 143 passed / 0 failed。

### 32. dead-strip が最後の dead text ラベルの dead range を誤計算 — 完了 (2026-05-18)

**症状**: text セクションの最後の実ラベルが dead だと、その dead
range が rodata 全体を巻き込んで巨大化し、`new_text = orig_text -
total_dead` が**負値**になる (観測例: 314 KB の `.incbin` フォントを
持つ `/bin/console` で `sec 0 0 -278288`)。.lab のセクションレイアウト
が破綻し、asm_pass3 が壊れたバイナリを吐いてタスクが起動直後にクラッシュ。

**原因**: `__global_pointer$` は section 0 (text) に登録されているが
addr は data 範囲 (`gp_abs = data_base + 2048`) にある。
`ds_compact` Phase 1 が section 0 のラベルを addr 順にソートすると
`__global_pointer$` が全実 text ラベルより後ろに来るため、最後の実
text ラベルの `next_addr` が `gp_abs` になる。そのラベルが dead だと
dead range = `[last_text_addr, gp_abs]` = rodata 全域ぶんになる。
incbin で rodata が巨大なほど被害が大きい。発症は「最後の text
ラベルが dead」のときだけなので、それが live な通常ビルドでは顕在化
しなかった。

**修正**: `ds_sort_section` が `__global_pointer$` を section 0 の
コンパクション walk から除外 (`ds_is_global_pointer`)。gp は root で
常に live、かつ addr は `ds_compact` Phase 3 が専用パスで書き換える
ので workspace から外して安全。

### 33. asm_pass2 の link 入力数が EXTRAS_CAP を超えると末尾を黙って落とす — 完了 (2026-05-20)

**症状**: カーネルに `.tc` モジュールを 1 個足したら virt カーネルが
boot で無出力ハング、pico2 カーネルから埋め込み mtfs image が消えた。
`.lab` を見ると最後の入力 (`crt0_data` / `mtfs_image`) が link から
丸ごと脱落していた。

**原因**: `asm_common.tc::EXTRAS_CAP` は asm_pass2 の link 入力
(prelude + user 以降の `--add` 入力) の上限。これが **16** で、
カーネルの link はちょうど 16 個 (ぎりぎり) だった。モジュールを
1 個追加すると 17 個になり、`asm_add_extra_input` が 17 個目で
`-1` を返す — が呼び出し側 (`asm_pass2_lib.tc::run_link`) がそれを
無視するため、末尾入力 (bss の `.space __arena` を持つ `crt0_data`)
が黙って捨てられていた。bss=0 のカーネルは最初の kmalloc で即死し
無出力。

**修正**:
1. `EXTRAS_CAP` を 16 → 48 に引き上げ (kernel link の現状は ~17、
   余裕を持たせた)。
2. `run_link` が `asm_add_extra_input` の `-1` を検出した時点で
   `"asm_pass2: link inputs exceed EXTRAS_CAP — bump compiler/
   asm_common.tc::EXTRAS_CAP"` を stderr に出力して `-1` を返す
   (silent drop → loud error)。これで cap を超えても link が
   nonzero exit するので、下流の asm_pass3 が full.lab を作れず
   build.sh が "kernel compilation failed" で止まる。
   なお `compile-gen2.sh` は asm_pass2 を `2>/dev/null` で起動する
   ため stderr メッセージ自体は見えないが、exit code は伝播する。

---

## codegen / bc2asm

### 6 + 20. peek/poke/get/set の intrinsic 化 + get 境界チェック — 完了 (実装 2026-04〜05、台帳整理 2026-07-05)

problem.md に「未実装」のまま残っていたが、実際にはとっくに解決
していた 2 エントリ (2026-07-05 の棚卸しで判明):

- **#20 (peek/poke/get/set が関数呼び出しで遅い)**: bc2asm の
  `try_inline_builtin` が peek8/16/32 → `lbu/lhu/lw`、poke8/16/32 →
  `sb/sh/sw` の 1 命令に、typed array の get/set → shift+add+load/
  store 数命令にインライン展開する。peek/poke は builtin mangled-name
  化 (2026-04-06〜08) の頃から、get/set は commit a4de8bf
  (2026-05-01、-19 s / -25%)。len() だけは null チェック semantics
  維持のため call のまま (意図的)。
- **#6 (get の境界チェック未実装)**: commit 8501f6d (2026-05-11) で
  `emit_inline_get/set` の両方に bound check (+2 insns: `lw` count +
  `bltu`、OOB は `__array_oob_get/set` へ jump) が入った。K14 の
  silent overflow footgun 修正の一環。

### 10 + Q5. tcheck vartab/fntab 動的化で bcrun.tc を self-compile 可能に — 完了 (2026-07-07)

「全ソース self-host」の唯一の例外だった bcrun.tc (vm_run が >128
locals + 巨大 fn で tcheck の vartab を溢れさせ `get: N out of
bounds`、`docs/scaling.md` Q5) を解消。あわせて problem.md #10
(fntab 512 上限) も閉じた。

変更 (固定 cap の引き上げ + 動的 grow):
- `tcheck.tc`: nodes `AstNodeArray(2048→4096)`、vartab
  `256→1024`、fntab `512→1024`
- `codegen.tc`: nodes `2048→4096`
- `bc2asm.tc`: per-fn `instrs`(8192)/`label_pcs`(2048) を
  parse_bc 所有に移して **×2 動的 grow** (`grow_i32`)、
  `locals_pool 128→512`。instrs/label_pcs は main で delete して
  いなかった (タスク終了で解放) ので所有権移動は無害
- task arena bump: tcheck 320 KB / codegen 224 KB / bc2asm 176 KB
  (bcrun.tc 入力の実測 peak 287/178/148 KB に margin)

検証: `compile-gen2.sh bcrun.tc` が通り、生成 bcrun が hello.bc /
fib.bc / global_str.bc を Gen1 bcrun と同一出力で実行。回帰は
`test_gen3.sh` の FULL_TEST ケース (Gen2 self-compile + run hello.bc、
~37 s なので 1 分予算を避けて FULL_TEST 側)。`make test` 158 PASS。

これで tcheck の実 worst case は bc2asm.tc (nc=1656) → bcrun.tc
(nc=2387) に更新。vm_run の関数分解は不要だった。

### 40. self_replicate manifest に touch_xpt2046 が未追従 — 完了 (2026-07-06)

const 導入後の byte-exact 確認で `pico2_self_replicate.sh` が失敗
(device k.bin ≠ host)。切り分けは K14 流の中間ファイル md5 総当たり:
REFRESH 後の全モジュール .s / .idx が device↔host で一致し、唯一
kp.idx だけ不一致 → 実体は **touch_xpt2046 (2026-06-21 追加) が
manifest に無い** ことによる compile-gen2 INPUT_NAMES の位置ズレ
(host 側で touch の idx が kp.idx と誤命名、device fixture は touch
を link から欠落)。K20 と同型の再発。

修正 (commit 5222acf): manifest に `tp|touch_xpt2046.tc` を追加して
fixture 4 本を再生成、extra.spec に /src/touch_xpt2046.tc を staging、
再発防止として gen_self_replicate_fixtures.sh に「manifest ==
kernel_pico2.tc の import closure (collect_imports.sh)」の集合一致
ガードを追加 — 従来の --check は fixtures↔manifest の相互一致しか
見ておらず、モジュール追加漏れが盲点だった。今後は
`make self-replicate-fixtures-check` が fail する (負テスト確認済)。

修正後の再実行 (2026-07-06、DROP_TASKS で gcc_doom_pico2/console 等を
外し kernel.bin 3.55 MB に slim 化、CLEAN_SD=1 REFRESH_KERN_MODS=1
NORESET=1): **kernel.bin / kernel.uf2 とも host と byte-exact MATCH**
(md5 `e28a3cce…` / `dd11df01…`)。const 一括変換 (578 宣言) + SD CMD25
+ tmpfs_unlink 込みのツールチェーン/カーネルで self-replicate が
維持されていることを実機確認。step 実測: step1 cat 113 s / step2
asm_pass1×23 + asm_pass2 1085 s / step3 asm_pass3 206 s / step4
bin2uf2 432 s、全体 ~57 min (host freeze + dx.img upload + REFRESH
17 モジュール込み)。

注: disk-extra はデフォルトビルドだと 9.4 MB (gcc_doom_pico2.bin
4.5 MB が主因) で 4 MiB flash に入らない。self_replicate 時は
`DROP_TASKS="gcc_doom gcc_doom_pico2 gcc_hello console sl touchtest
fbtest kbdump vi neofetch grep cp du head wc sdprobe count tmpdemo
launcher hello hello2 catfile seq"` で 3.1 MB に絞る。

### 36b. const 導入で #36 の暗黙エイリアスを置き換え — 完了 (2026-07-05)

#36 の初版修正は「文字列リテラル初期化の `var` グローバルを暗黙に
定数エイリアス化」だったが、**var なのに書き換えられない**のは
言語として筋が悪い、というレビューを受けて明示的な設計に変更:

1. **`const NAME: T = <literal>;` を言語に導入** (トップレベル限定、
   リテラル初期化必須、再代入は tcheck エラー、モジュールプライベート)。
   codegen は int/bool を `push_int`、文字列を `push_str` に
   インライン展開する — ストレージなし。parser (Gen1 lexer/parser +
   parse.tc) / sigscan (.th に type-only で emit) / tcheck (vartab に
   const フラグ) / codegen (const 表 + シャドー判定) / interp の
   全段に実装。5 実行メソッド一致 (`compiler/tests/global_str.tc`)。
2. **グローバル `var` の文字列リテラル初期化はコンパイルエラー**
   (`use const` を案内)。実行時差し替えが要る場合は
   `= 0 as StringLiteral` で null 宣言して代入で初期化する
   (userland/lib/libtc_test.tc の g_test_current が実例)。
3. **既存の「定数ぽい var」を一括 const 化**: リテラル初期化 +
   モジュール内で再代入なし + 手書き .s から参照なし + 宣言が初回
   使用より前、の条件で 578 宣言を機械変換 (compiler/src、kernel、
   userland の 40+ ファイル)。int 定数の load (la+lw) が push_int
   (li) になるので .data も命令数も減る。

制限: 宣言は使用より前に書く (Gen2 codegen はストリーミングのため、
違反はリンク時 undefined label で loud に失敗)。ローカル const は
未サポート。詳細は `docs/language.md`「定数 (const)」。

**副産物: グローバル var の負リテラル初期値が silently 0 になる
既存バグを発見・修正**。`-1` は AST 上 `(unary - (int 1))` で、
codegen の `.global` initval 計算が kind==int しか見ていなかった
ため `var X: i32 = -1;` は昔から **0 初期化**されていた (tcheck.tc
の g_ret_ss / g_type_ss / g_last_cmt_ss、msh の g_script_fd 等が
該当 — `>= 0` ガードが初期状態で誤って真になっていた)。const の
負リテラル対応と同時に var 側の initval も unary-minus-int を
認識するよう Gen1/Gen2 両方を修正 (`compiler/tests/neg_init.tc`
が回帰テスト、5 メソッド一致)。

### 36. `var X: StringLiteral = "..."` で literal が `.word 0` に落ちる — 完了 (2026-07-05、初版修正 → 36b で置換)

**症状**: グローバル変数を文字列リテラルで初期化すると、AST には
`(str "...")` が正しく載っているのに codegen が無視して
`X: .word 0` を吐く。実行時 `get(X, i)` は `peek8(0 + 4 + i)` →
低位カーネルデータの不定値を返す (実例: keyboard_matrix の keymap が
"Raspberry Pi" 等の .rodata 断片を返した)。長らくの回避策は literal
を関数の return 経由で参照するイディオム (commit aa54b0c)。

**設計判断**: PIC raw-bin タスクにはロード時 data relocation が無い
ので、「.data のワードに .rodata strobj のランタイムアドレスを置く」
形はそもそも実現できない。修正は **定数エイリアス化**: 文字列リテラル
初期化のグローバルは `.global`/.data スロットを持たず、

- load は `push_str <slit idx>` (→ asm では `la t0, strobj`) に置換
- 再代入は「codegen: cannot assign to string-literal global X」で
  コンパイルエラー
- ローカル/パラメータが同名でシャドーする場合は従来どおり `load`
  (cg_fn がパラメータも locals 表に足して判定)
- 同一リテラルの複数グローバルは slit dedup で同じ strobj を指す

Gen1 (`compiler/bootstrap/codegen.c`) と Gen2 (`compiler/src/codegen.tc`) の両方に
同一セマンティクスで実装。interp は元々 init 式を評価していたので
無変更で一致。制限: Gen2 codegen はトップレベルをストリーミング処理
するため、**宣言は使用より前に書く必要がある** (宣言前の使用は
`load` のまま → リンク時 undefined label で loud に失敗する)。

テスト: `compiler/tests/global_str.tc` (EXAMPLE_FILES golden +
test_consistency 5 メソッド一致)。kernel 側は keyboard_matrix.tc の
ワークアラウンドを撤去して `var KBD_KEYMAP: StringLiteral = "..."`
直書きに戻した。

**副産物**: この検証中に `compiler/scripts/tc_run_all.sh` が
subproject split 以前の `$ROOT/tc_run.sh` パスを参照したままで、
全メソッドが exit 127 + 空出力 → 「空 == 空」で test_consistency が
**空振り合格**していたことが判明。パス修正 + 「起動失敗 (exit
126/127) は不一致扱い」「exit code も出力と同様に一致比較」の
ハーネス修正を実施。

---

## カーネル / OS

### 30. tmpfs に unlink が無い — 完了 (2026-07-05)

`rm /tmp/x` が常に "cannot remove" になっていた。
`kernel/src/tmpfs.tc` に `tmpfs_unlink(name_addr, n)` を追加
(name/data ブロックを kfree して inode slot をクリア。open 中の fd
が残っている場合は -1 — v1 は orphaned-open をサポートしない)、
`vfs_unlink` に `is_tmp_path` ブランチを追加。mtfs / procfs / devfs
は read-only / synthetic なので -1 のまま。

回帰テスト: `test_os.sh` fs_virtio に `rm /tmp/redir` × 2 を追加 —
1 回目は静かに成功、2 回目だけ "cannot remove" が出ることを
`grep -c == 1` で検証。unlink がメモリを実際に解放するので leak
canary の live カウントも 137 → 135 に下がった。

### 39. SD 読み書きを ~1.45× 高速化: CMD25 バースト + sd_spi_xfer インライン化 — 完了 (2026-07-05)

improvements_2026_07.md §2-1 の実施。self_replicate ~50 min の
支配項が SD 書き込みだったため着手。2 つの変更:

1. **sd_spi_xfer の bit ループからラッパー呼び出しを排除**
   (`kernel/platform/pico2/block_sd.tc`): `sd_sck_high()` 等の 1 行ラッパーは
   TC では call + prologue で 1 pin 操作 ~25 命令。SIO アドレスと
   マスクをローカルに hoist して peek32/poke32 直呼びに (bc2asm が
   1 命令に inline 展開する)。
2. **CMD24 単発書き込みを CMD25 (WRITE_MULTIPLE_BLOCK) バースト化**:
   `fat_block_write` は書き込み後も CS を保持し、次が連続セクタなら
   同一バーストに 0xFC トークンで追記。`fat_block_read` と新設
   `fat_block_sync` がバーストを 0xFD で close する。vfs.tc の
   write 系出口 (write / close / unlink / mkdir / rmdir / open) が
   毎回 `fat_block_sync()` を呼ぶので、**syscall 単位の durability
   は CMD24 時代と同一** (virt backend は no-op sync を export)。
   `kernel/tests/test_pico2_sd.sh` の Phase B (リブート永続性) で
   実機確認済み。

実測 (81 KB `cp /bin/vi /sd/`、実機 150 MHz): read 34.2→49.0 KB/s
(1.43×)、write 2 回目 21.1→31.6 KB/s (1.50×)、write 初回 6.4→9.5
KB/s (FAT free-cluster scan が支配)。数値表は
`docs/pico2_hardware.md` SD 節。

**副産物**: `kernel/scripts/build.sh` の task ループが gcc-bin task
(gcc_hello 等、.tc ソース無し) で silent fail していたのを修正 —
`userland/build/tasks/<task>.bin` のプレビルドを使う。gcc task 追加
(K22) 以降 `test_pico2*.sh` 系の standalone build 経路が壊れていた。

残る伸びしろ: per-byte の sd_spi_xfer 呼び出し自体と eval-stack
codegen のオーバーヘッド。さらに削るなら asm 化か PIO (#37 GPIOBASE
問題が塞ぐ)。

### K22. DOOM Shareware TITLEPIC が pico2 実機の ILI9488 LCD に出る — 完了 (2026-06-18)

doomgeneric ベースの DOOM port (`userland/gcc-bin/gcc_doom/`、
`gcc_doom_pico2.bin` ~374 KB) が pico2 実機で起動し、`/sd/doom1.wad`
を load → `D_DoomMain` 全 init 完走 → `DG_DrawFrame` 経由で band-blit
→ ILI9488 LCD に TITLEPIC (赤い "DOOM" ロゴ + 緑装甲の Doomguy) を
表示するまで到達。

**到達 ladder** (Phase 6 stage 単位):

| stage | 解決した壁 |
|---|---|
| 6 | DG_DrawFrame end-to-end (1 frame to LCD) |
| 8〜10 | R_Init PU_STATIC の 30+ KB を .bss に逃がして zone 確保 |
| 11 | lumphash (4672 B) を .bss、demo / wipe / D_PageDrawer の zone 食いを no-op 化 |
| 12 | `while (1) doomgeneric_Tick()` で safe loop 化 |
| 13 | **MADCTL 0x28 で landscape 化**、`struct _dg_color` のバイト順を `{ b, g, r, a }` に修正 |
| 14 | TITLEPIC (68 KB) を column-by-column ストリーミングで描画、peak ~5.5 KB |

**メモリ予算** (`__gcc_sram` 448 KB を gcc_doom_pico2 が占有):

- `.data + .bss`: ~280 KB
  - DG_ScreenBuffer (.bss、CMAP256 で 64 KB) は I_VideoBuffer と alias
- DOOM zone (`Z_Init` の picolibc `malloc`): 112 KiB
- picolibc heap 残: ~30 KiB (fopen FILE struct + lumpinfo realloc に消費)
- 16 KB stack: `gcc_task_pico2.ld` 末尾に確保、`gcc_crt0_pico2.s` で
  `sp = __stack_top` に切り替え (kernel-supplied 1 KB の bootstrap stack
  は `_start` 冒頭で捨てる)

`__arena` (kernel kmalloc pool) は 64988 B (63 KB) まで縮小。`mr -a`
の new SD upload はこの kernel では OOM するため、WAD upload を先に
別 kernel build (arena 130588) で済ませてから DOOM kernel を flash
する 2-pass フロー。

**最後に判明した二つの実バグ** (stage 13):

1. **LCD orientation**: ILI9488 はデフォルトで portrait 320×480
   (kernel `display_ili9488.tc::lcd_init` の MADCTL=0x48)。実機 LCD は
   landscape mount なので、user task が `/dev/fb` に `mode=3`
   `MADCTL=0x28` を投げて切り替える必要があった。送らないと
   `DG_DrawFrame` が portrait window を上書きして変な position に
   貼り付けてしまう。`console-land` build は kernel 内でこの切り替えを
   やっているが、gcc task は別途自分で送る (`memory/pico2_lcd_madctl.md`
   参照)。

2. **`struct _dg_color` のバイト順**: `i_video.h` の `struct color`
   は `{ b:8; g:8; r:8; a:8 }` ビットフィールド → little-endian で
   メモリ順 `[b][g][r][a]`。`doomgeneric_tcos.c` 初版は
   `{ a, r, g, b }` でフィールド宣言していて、`.r` を読むと
   実際は g バイトを読んでいた。CMAP256 の palette lookup が
   R/G swap で全色 wrong。`{ b, g, r, a }` に直して全 PLAYPAL が
   正しく出るようになった。

**TITLEPIC ストリーミング decoder**:

`gcc_doom.c` の `PICO2_LUMPINFO_SHRUNK` ガード内で、patch lump を
1 column ずつ SD から W_Read。

1. lump 先頭 8 B (`short width, height, leftoffset, topoffset`)
2. `int columnofs[width]` (1280 B、`col_ofs[320]` .bss に置く)
3. 各 col 0..319 について:
   - `lumppos + col_ofs[col]` から最大 4 KB を `colbuf[4096]` に読む
   - post 列をデコード (`topdelta / length / pad / data / pad`,
     `topdelta == 0xFF` で終端)、`DG_ScreenBuffer[y*320 + col]` に
     palette index を書き込む

peak working memory = `col_ofs` 1.3 KB + `colbuf` 4 KB ≈ 5.5 KB。
zone も heap も使わない。SD SPI 6 MHz × 320 reads で数秒かかるが
one-shot title draw なので可。

**過程で見えた debug**:

- **build cache の罠**: `userland/build/tasks/gcc_doom_pico2.bin` の
  `.o` が古いと `.c` 変更が反映されず、何時間も古いバイナリを debug
  していた。`rm -rf userland/build kernel/build` で強制 full rebuild
  しないと最新コードがリンクされないケースに何度か遭遇
- **`malloc(64 KB)` が NULL を返す**: D_FindWADByName 内の fopen が
  NULL を返すのは IWAD missing ではなく picolibc heap 枯渇。
  Z_Init の zone allocation 後、FILE struct 用の ~1 KB すら取れない
  状態だった (`__gcc_sram` 320 → 448 KB 拡張 + `DG_ScreenBuffer` を
  .bss に移して heap headroom 確保)
- **`p[0..15]` dump で col0 のピクセル indices が brown 系**: 期待した
  TITLEPIC のパターンなのに LCD が blue→gray gradient → 上で書いた
  struct byte order のバグだった
- **`memset(0xFF, 320*200)` が TITLEPIC を上書き**: cleanup の途中で
  test 用 memset を残していて、column-stream の結果が全部消えていた

参考: commits `cd848b7` (DG_DrawFrame + D_DoomMain pipeline)、
`212ce25` (first frame to LCD)、`87a544c` (stable tick loop)、
`0d90716` (R_Init PU_STATIC → .bss)、`9cd5f09` (lumphash → .bss)、
`3d97af4` (landscape MADCTL + struct order)、`b5bd104` (column-stream
TITLEPIC)、`1f9119e` (diagnostic traces 削除)。`memory/pico2_lcd_madctl.md`
に MADCTL flip の経緯。

**残課題**:

- Autostart (E1M1) は `P_SetupLevel` が ~24 KB の PU_LEVEL alloc を
  要求 → zone 112 KB 不足。blockmap (17 KB) など PU_LEVEL の大物を
  .bss に固定するか zone をさらに拡張する大手術が必要
- TITLEPIC 描画の左半分が letterbox 色のまま見える件 (`/tmp/lcd_v109.jpg`
  webcam 写真)。webcam の遠近かもしれないし、`DG_DrawFrame` が
  幅 320 全部書ききっていないかも。次セッションで要確認

### K21. boot < 1 秒 + mr -a CRC で byte-exact 維持 — 完了 (2026-05-30)

K20 で self_replicate byte-exact を復活させた後、実機 boot に毎回
~6 秒かかっていた原因が `kernel_pico2.tc::mount_fs` 内の
`dump_mtfs_to_sd` (3.5 MB の disk-extra.img を /sd/dx.img に
コピー) と判明。boot dump を完全削除して boot を **61 ms** (host
wall clock、openocd reset 込みでも 423 ms) に短縮、その上で
byte-exact self-replicate を維持する仕組みを実装。

**boot time 計測** (`kputs_t` を `kern_uptime_us` ベースに修正、
console + sh まで含む実時間):

```
openocd reset → KERN: starting        362 ms (bootrom + flash sector init)
KERN: starting → MTFS: mounted          11 ms
MTFS → mount_fs done                     8 ms
sched_init + start_init_tasks + load    14 ms
timer arm → sched_start                  1 ms
sched_start → console main + sh spawned  27 ms
合計 (KERN: starting → sh spawned)      61 ms
```

**dump 廃止と引き換えの仕掛け**: orchestrator 側で

1. **dx.img を mr -a で upload** (~6 分、disk-extra.img 全部)
2. **wrap.s も同様に upload** (`.incbin SIZE "dx.img"` の小さい
   wrapper、boot dump が emit していた)

**`mr -a` ACK + sum32 checksum + NAK retry** (commit d24ac4d):

frame format:
```
[len:u16 LE][data:len bytes][sum:u32 LE]
sum = (Σ data bytes as u32) mod 2^32
```

mr の動作:
- 起動時に `.` (ACK) を fd 2 に emit
- frame 受信後 sum 検証、一致なら fd 1 に write + `.` ACK、
  不一致なら write せず `!` NAK
- 終端 (len=0) で `.` ACK

mr_upload.py:
- frame 送信後 ACK/NAK を 1 byte read
- NAK 時は同じ frame を re-send (`--max-retries` 5 回まで)
- 最終 progress 行に retry 回数も表示

これで K11 (PL011 RX FIFO overflow during SD writes) を ACK gate で
回避しつつ、UART bit error も checksum で検出/再送可能。実測 3.5 MB
upload を 0 NAK retry で完走 (10.6 KB/s、~6 分)。

**検証** (CLEAN_SD=1 REFRESH_KERN_MODS=1、~50 分):

```
host kernel.bin md5: d7742e39aa324b0b328d64c3463fadfb
device k.bin md5:    d7742e39aa324b0b328d64c3463fadfb  MATCH
host kernel.uf2 md5: bfae44187fd11b95683a8e99dab817fd
device k.uf2 md5:    bfae44187fd11b95683a8e99dab817fd  MATCH
```

**過程で見えた debug**:
- `kputs_t` 初版が `read_mtime() / ticks_per_ms()` で low 32-bit のみ
  読んでいて 32 sec 毎に wrap。`kern_uptime_us() / 1000` 経由に修正
  して hi+lo を正しく扱えるように
- 最初の wrap.s 漏れ: dump 削除直後の run で device full.lab が
  host と md5 違うのを per-module .s 比較で全 module 一致と確認、
  /sd/wrap.s が stale (previous run の dx.img size 残ってる) と
  特定。orchestrator から wrap.s upload を追加して解決
- K11 (mr 16 KB hang) は引き続き未解決。ACK gate で実用上は回避
  できているが PL011 RX IRQ + nested trap 化が本質的 fix

参考: commits fbf75b6 (boot dump 削除 + mr -a)、d24ac4d (sum32
+ NAK retry)、7f22244 (wrap.s upload)、`integration/scripts/
mr_upload.py`、`userland/bin/mr/mr.tc::ack_mode`。

### K20. self_replicate byte-exact 復活: 新 kernel module 対応 — 完了 (2026-05-27)

K18 (2026-05-14) で全 8 コンパイラ + kernel.bin/uf2 の byte-exact
self-replicate を達成した後、`kernel_pico2.tc` の imports が +5
module 増加 (`rtc.tc` fa34500、`rtc_ds3231.tc` 15ddff4、
`display_ili9488.tc` 8b84348、`keyboard_matrix.tc` fb2cfc7、
`devfs.tc`) したが、self_replicate orchestrator + device fixture
が更新されておらず、device は 11/16 module だけ link → host build と
md5 divergent な kernel.bin を生成していた。

K18 直後は実機 self_replicate を回す機会が無く、subproject 分割
リファクタの動作確認で初めて発覚 (b62a2e1 で bin2s_incbin.sh path
を直して device 側を動かせるようになって表面化)。

**修正** (commit cde0c7a): host emit order に device 側を同期。

| 修正対象 | 変更 |
|---|---|
| `kernel/fs-spec/extra.spec` | 5 module の `.tc` を `/src/` に staging |
| `pico2_compile_kern.sh` | rt / di / km の parse→bc2asm 追加 (no imports) |
| `pico2_compile_kern2.sh` | df (imports kc+rt), r3 (imports rt) 追加。vf tcheck に df 追加。kp tcheck を 11 直接 import (kc/pp/bf/bs/ff/mf/vf/ld/r3/di/km) に拡張 |
| `pico2_self_step1.sh` | cat 順を 22 input (4 prelude + 16 user + cd + wrap) に拡張 |
| `pico2_self_step2.sh` | asm_pass1 を 16 user module 分、asm_pass2 `--add` を 22 input に |
| `pico2_self_replicate.sh` | `INPUT_NAMES="kc pp bf bs ff mf tf pf rt df vf ld r3 di km kp"` |

host の compile-gen2.sh emit 順を確認すると:
- `runtime` (cached)
- `in_0..in_15` = kc / pp / bf / bs / ff / mf / tf / pf / **rt** / **df** / vf / ld / **r3** / **di** / **km** / kp

旧 INPUT_NAMES "kc pp bf bs ff mf tf pf vf ld kp pt" は `in_8` 以降で
ズレており、host が `vf` と label していた idx が実際には `rt` (rtc)
の text section だった等、全体的に mislabel されていた。

**検証** (実機 Pico 2、`CLEAN_SD=1 REFRESH_KERN_MODS=1` で ~46 min):

```
host kernel.bin md5: 4a730de411930ad14f7f97727ba00ea3
device k.bin md5:    4a730de411930ad14f7f97727ba00ea3  MATCH
host kernel.uf2 md5: 777c711cfd3fdcf9e3ab471b6f846057
device k.uf2 md5:    777c711cfd3fdcf9e3ab471b6f846057  MATCH
```

CLAUDE.md / docs/roadmap.md の「K13〜K17 self-replicate」状態に復帰。
pico2 が host PC の触媒抜きで kernel + 全コンパイラを再生産できる
self-hosting loop が再び成立。

参考: commit cde0c7a、`integration/fixtures/pico2_self_step{1,2}.sh`、
`integration/fixtures/pico2_compile_kern{,2}.sh`、
`integration/pico2_self_replicate.sh::INPUT_NAMES`、
`kernel/fs-spec/extra.spec` の `/src/` staging。

**Follow-up (2026-05-28): drift 再発防止 + boot トレース** (commits
5065391, dd213b2):

K20 の原因は 6 ファイル (`INPUT_NAMES` + step1/2 + compile_kern{,2}
+ fs-spec) の手動同期 — kernel に import を 1 個追加するたびに 6 ヶ所
更新が必要で、忘れると静かに byte-exact regression を引き起こす。
追加対策:

- `integration/scripts/self_replicate_modules.sh` を single source of
  truth に。short-name → .tc path の 16 行 manifest + 直接 import を
  `grep '^import'` で自動抽出するヘルパー関数。
- `integration/scripts/gen_self_replicate_fixtures.sh` が manifest から
  pico2_self_step{1,2}.sh + pico2_compile_kern{,2}.sh を生成。`--check`
  モードで現行 fixture と diff、drift を検知。
- `make self-replicate-fixtures-check` を `integration-test` の依存に
  加え、`make full-test` 実行時に drift があれば即失敗。
- orchestrator は manifest を source して
  `INPUT_NAMES=$(module_short_names)` で動的派生。

これで kernel に import を追加する手順は: kernel/src/<mod>.tc + manifest
1 行 + `bash integration/scripts/gen_self_replicate_fixtures.sh` の 3
ステップで sync 完了。

加えて transient boot stall 用に kernel_pico2.tc::main + loader.tc に
step プリント追加:

  KERN: sched_init → start_init_tasks → load_task /bin/sh →
        sched_register slot 0 → timer arm → sched_start

`load_task` / `load_fd` の silent failure (vfs_open / vfs_size /
vfs_read 失敗) も `load_task: vfs_open failed: <path>` 等の説明文
出力に変更。次回 `FATFS: mounted` 以降で止まったときに UART log だけで
どの step が deadlock したか即特定可能。

debug print 込みで再 self_replicate して MATCH 維持を確認:

```
host kernel.bin md5: 6033734207eb2ccd552b7c361d9ac8ce
device k.bin md5:    6033734207eb2ccd552b7c361d9ac8ce  MATCH
host kernel.uf2 md5: 5c1351bc3de4db5aed44f807d5dab43f
device k.uf2 md5:    5c1351bc3de4db5aed44f807d5dab43f  MATCH
```

### 35. pico2 console + sh starvation: sched_yield_read で mtimecmp を rearm — 完了 (2026-05-23)

`kern.conf` で `/bin/console` を seed すると LCD に最初の数バイトしか
描画されず、それ以降 sh の出力 (pipe 経由) が console まで届かない。
qemu virt の `test_os` console テストは pass、pico2 実機だけで再現。

**切り分け**:
- LCD bit-bang / SPI 単独: OK (fbtest + render isolation で確認)
- `/bin/hello` (5 回 write して exit) を pipe 経由 spawn_fds: OK
- `/bin/echo` (引数無しで即 exit) を spawn_fds: OK
- `/bin/sh` を spawn_fds: 失敗 — console は post-spawn 後 3〜6 個の
  sys_write しか出せず以降スタベーション

debug counter (`g_dbg_tick` を trap_handler timer 分岐に、`g_dbg_yield`
を sched_yield_read に) で観測すると 15 秒間 timer 12,750 回 +
sched_yield_read 12,600 回 — ほぼ 1:1。1 quantum あたり sh の sys_read
が 1 回しか入っていない (理論上は 760µs / 40µs = 19 回入るはず)。

**根本原因**: M-mode 時間の累積 + pending MTIP の即発火。

1. sh の `sys_read(/dev/kbd)` は kbd_backend_read (~40µs GPIO scan) を
   M-mode で実行。`MIE=0` の間 mtime が進んでも timer 割込みは発火しない。
2. console 側も `eputs` で UART を 1 バイト 87µs busy-wait するから
   sys_write 1 回 ~260µs (3 byte) ぶん M-mode 滞在。
3. sh と console の M-mode 滞在時間の合計が 760µs (= TIMER_INTERVAL)
   を超えると mtime が mtimecmp を追い越し MTIP が pending。
4. sh の -2 yield で `sched_yield_read` が console を選び `mret` した
   瞬間 MIE=1 に戻る → pending MTIP が即発火 → trap_handler timer
   分岐が「console から」のつもりで sh に再 switch → console は 0
   命令しか走らない → 無限ループ。
5. `/bin/hello` は短命 (5 write + delay で exit) のため pending MTIP
   が貯まる前に終わり、console が 1 タスク化して問題顕在化せず。

**修正** (commit 895ec6a): `sched_yield_read` で `g_current != from_slot`
の時だけ `rearm_timer()` を呼ぶ。実際にタスクを切り替えた瞬間
`mtimecmp = mtime + 100000` で上書きされ pending MTIP がクリアされる
ので、選ばれたタスクは新鮮な quantum を確保できる。

「実際に切り替わった時だけ」rearm するのが要点: 同一タスクの -2 retry
で毎回 rearm すると mtimecmp が永遠に push され、sleeping task の
wake_time に mtime が追い付かなくなって `do_nanosleep` が機能しなく
なる。switch 限定なら yield 連打しても mtimecmp は固定で、sleep も
正常に動く。

**検証**: 修正前は post-spawn 3〜6 sys_write で停止 → 修正後は M1..M5 +
render 全段 (rnd → dcp1 cp=N → dcp_ge32 → dcp_lt256 → dh1 → dh2 →
dcp_end → rnd_end) 完走、LCD に "1234" 描画。`make test` 148 件 pass、
pico2 実機の sh-only / console-init 両構成で boot 確認。

問題.md #35 の「仮説 A: stdin_fd 上書き」「仮説 B: struct setter
値コピー」はいずれも誤誘導だった (struct setter は実体 (heap U32Array)
を共有するので値コピー問題は起きない、stdin_fd 上書きは観測されなかった
)。GDB attach で `PC が kbd_settle に landing` していたのは sh が
M-mode で何度も sys_read を retry していた症状そのもの。

参考: `kernel/src/kernel_common.tc::sched_yield_read`、commit 895ec6a。

### K19. bucket carve によるヒープ断片化 → two-ended allocator — 完了 (2026-05-15)

approach A (compile-gen2.sh / kernel build の prelude cat 結合を撤廃し
各 .s を個別 asm_pass1 にする、commit 326b754) を device の
self_replicate fixture (`pico2_self_step2.sh`) にも適用したら、
asm_pass2 の link 段階で kernel arena OOM:

```
OOM: 398152 p=460732 l=70008 free=[389124,57168,s=446292,n=2,m=389124]
```

free 合計 446 KB あるのに連続最大が 389124 で、asm_pass2 タスクの
RAM ブロック (arena 380928 + stack 16384 + frame ≈ 398152) が入らない。

**bisect**: 17 個の asm_pass1 spawn を通して km dump が一定で
`[389124, 57168]` — つまり連続 spawn の churn では断片化していない
(K16 の性質は保たれている)。13-input (cat 版) の成功 run と比較すると
free レイアウトが反転: 成功 run は `[28676, 417660]` (大ブロック上位)、
OOM run は `[389124, 57168]` (大ブロック下位)。splitter (2 つの free
ブロックの間に居座る live 確保) の位置が step2 最初のコマンドで決まって
いた — 13-input は最初が `cat` (小タスク) で splitter 低位、17-input は
最初が `asm_pass1` (RAM ~389 KB) で splitter 高位。

**根本原因**: `compiler/src/runtime.tc` の allocator 設計。bucket 確保
(≤ 2048 byte) は bucket free list が空のとき `large_alloc` で large
heap から個別 carve するが、`kfree` は bucket free list に push する
だけで **large heap には二度と戻らない**。large_free の隣接結合の
対象外。よって一度 carve された bucket entry は large heap 上の永久の
穴になる。

タスク実行中、kernel の FS syscall 処理 (`vfs_open` の path segment
ごとの `U8Array`、`fatfs_open` の scratch、`g_fat_cache_buf`) が
bucket carve する。これが「走行中タスクの大 RAM ブロックが live な
とき」に起きると、large_alloc の first-fit がブロック直上に bucket を
置き、タスク exit でブロックが還っても bucket が高位に取り残されて
free 領域を分断する。K16 の「fragmentation ゼロ」は per-spawn の
往復を綺麗にしたが、「最初に spawn したタスクのサイズで splitter 位置が
決まる」経路は塞いでいなかった。

**修正 D** (commit 8b21b8d): タスク名を task RAM ブロック内に格納。
K16 が argv を ram ブロックに embed したのと同じ方針。`make_task` が
`TASK_NAME_RESERVE` (64 B) を frame 直後に確保、`task_set_name` /
`task_set_name_basename` は slot へ直接コピー (kmalloc 不要)。
`basename_copy` 廃止。spawn 経路の bucket carve を一掃。

**修正 E** (commit d13b7c3): `large_alloc_top` を追加。最高位アドレスの
分割可能なフリーブロックを探し、その**上端**から carve する。`kmalloc`
の bucket 経路を `large_alloc` → `large_alloc_top` に変更。bucket 確保
はヒープ上端に集まり、large_alloc (前方 first-fit) の大確保と物理的に
分離される two-ended allocator。タスクの spawn 順や FS syscall の
タイミングに関係なく large heap 低位は連続を保つ。bucket zone は
steady-state ~12 KB と小さく bounded。

**実機実証** (pico2 `pico2_self_replicate.sh REFRESH_KERN_MODS=1`):
- 修正前: `free=[389124,57168] n=2` → asm_pass2 OOM
- 修正後: `free=[446372] n=1` — 大 free が連続 1 ブロックに復帰
- 17-input self_step2 が step2〜step4 完走、host = device の
  kernel.bin / kernel.uf2 md5 完全一致 (`12e1d4cb...` / `a5967a13...`)、
  `kernel.bin MATCH` / `kernel.uf2 MATCH`
- `pico2_self_step2.sh` を multi-input asm_pass1 版に復帰 (commit
  2018523) — host / device 双方が approach A の split prelude を使う

`make test` 143 passed (runtime.tc は kernel + 全タスク + Gen3
共有だが、メモリ配置が変わるだけで出力バイト不変、gen3 self-host
byte-exact 込みで回帰なし)。

副産物: `kernel/tools-src/mkfs.tc` の OOB バグ修正 (commit 8402f87) — file data
が末尾 truncation 領域に正当に straddle すると `set` OOB していた。
buffer を full `total_blocks * BLOCK_SIZE` で alloc、出力は g_out_size
で truncate して mkfs.py との byte-exact を維持。

### K12. fatfs LFN + サブディレクトリ + mkdir — 完了 (2026-05-14)

`kernel/src/fatfs.tc` を VFAT LFN (Long File Name) + 任意階層 +
ランタイム mkdir 対応に拡張。`/sd/` 配下を 8.3 制約から開放。

**LFN 読み書き** (commit e0693a4):
- attr=0x0F の LFN entry を逆順 reassemble (UCS-2 ASCII 専用、
  最大 255 chars)。SFN の 8.3 checksum を verify
- 書き込みは strict 8.3 でない名前を全て LFN+SFN ペアで emit。
  SFN は `BASE~N` 形式で衝突回避 (N=1..9)
- `dir_delete` も同セクタ内の先行 LFN entry を 0xE5 で掃除
- 既存 SFN-only entry (`HELLO.TXT` など) は to_83 fallback で従来通り
  マッチ

**サブディレクトリ traversal** (commit cbda029):
- `walk_to_dir` で `/`区切り segment を順に dir_find_by_name しながら
  attr&0x10 で directory bit 検証
- `resolve_parent_dir` で path 末尾 `/` を分離 → parent_clus +
  leaf_off/leaf_len
- fatfs_open / fatfs_delete を path-taking 化、内部で
  resolve_parent_dir → dir_find_by_name(parent_clus, leaf)
- fatfs_readdir_path 新設、vfs_readdir で `/sd/sub[/...]` をルーティング

**mkdir** (commit 43f2fbe):
- fatfs_mkdir: fat_alloc_cluster で 1 cluster 確保 → 0 fill →
  `.` (self) + `..` (parent or 0 for root) entry を書き →
  dir_create_entry(attr=0x10, init_clus=new_clus) で親に登録
- vfs_mkdir (/sd/* 専用) + ecall a7=34 (mkdirat 番号、引数は path のみ)
- tasks/mkdir/ user task (`mkdir <dir>...`)
- task_crt0.s の do_mkdir__String / __StringLiteral stub + libtc.tc
  forward decl

**検証** (qemu virt):
- LFN: `/sd/kernel_nodisk.bin` (17 chars), `/sd/MixedCase.TxT` を
  echo > / cat / ls で round trip
- subdir: 既存の `/sd/subdir/FILE.TXT` + LFN dir 名 `/sd/longdir_name`
  を read + 新規 `/sd/subdir/created.txt` を write
- mkdir: 多階層 `mkdir /sd/newdir/nested` → 中で
  `echo > /sd/newdir/nested/deep.txt` まで動く。重複 mkdir はエラー
- mtools `mdir` で host 側から見ても spec 準拠
  (LONGDI~1↔longdirname_with_lfn、NEWDIR~1↔newdir 等)
- `make test` 143 passed (58s)

pico2 self-host bench も本来名に revert (commit 後続) —
`/sd/asm_pass1.lab` / `/sd/asm_pass1.bin` 等、`derive_side_path` も
".idx" 置換から ".idx.rfs" / ".idx.dfs" 追記方式に戻している。

### K16. kernel arena fragmentation 完全消滅 + 1-boot self_replicate — 完了 (2026-05-13)

K15 仕上げ後、pico2 実機で `kernel/tests/test_pico2_bench.sh` を走らせると
Hello World end-to-end で kernel arena が断片化し、asm_pass2 起動時
OOM ([20484,12132,24408,32748,310320] = 5 ブロック、最大 303 KB に
対し 336 KB 要求)。2-boot に分けないと完走しないという問題があった。

bucket peak の per-spawn 推移から **clone_argv が個別 String を
kmalloc**、各 bucket entry を large heap から carve したまま戻らない
ことが正体と判明。修正 3 段階で fragmentation 完全消滅:

1. `clone_argv` を packed + padded (> 2048 byte) に (commit 688e4ef)
   - tcheck (7 argv) で bucket 16 を +7 carve、asm_pass1 (11 argv) で
     bucket 16 +4 / bucket 64 +1 carve していたのが steady state に
2. `make_task` で frame_buf + stack を ram block 内に統合 (commit 49ae455)
   - 132 byte frame_buf が bucket 6 (260 byte) を carve、msh の
     frame_buf が長時間 live で free 領域を 2 つに分断していた
3. argv も task ram 内に embed (commit 0c1b800)
   - kernel-side の独立 argv alloc を撤廃、task per-alloc を 1 個に集約

加えて sh/msh の task arena を実 peak ベースに縮小 (commit afbf12a):

| task | 旧 | 新 | 節約 |
| sh   | 32K + 8K | 16K + 4K | ~20 KB |
| msh  | 32K + 8K | 8K + 4K  | ~28 KB |

合計 ~48 KB の追加余裕。

**実機計測** (commit 001fc41、`NORESET=1` で reset を 6 回省略):

```
Step 1 (cat → /sd/full.s):                 38 sec
Step 2 (asm_pass1 × 13 + asm_pass2):      484 sec  (8 min)
Step 3 (asm_pass3 → /sd/k.bin + md5):     257 sec  (4 min)
Step 4 (bin2uf2 → /sd/k.uf2 + md5):       564 sec  (9 min)
                                         ──────
                                         ~23 min, 1 boot
```

OOM ゼロ、reset ゼロ、`n=1` 固定。「Pico 2 がカーネル + コンパイラ
全部 SRAM 内で 1 boot self-build する」が現実になった。

副次効果として **Hello World end-to-end が 13.78 sec** (1 boot、
K7 era 127 sec から **9.2× speedup**、`docs/scaling.md` Q1)。

### K17. tcheck の fd_t leak 解消、1-boot byte-exact self_replicate 完走 — 完了 (2026-05-13)

K16 完了後 `REFRESH_KERN_MODS=1 NORESET=1` を試したら Step 2 (asm_pass1
/sd/prelude.s) が `cannot open bin/reloc output` で失敗。kernel arena
fragmentation の再発ではなく (km dump で `n=2 max=424 KB` 確認、十分
余裕あり)、**kernel 側 fatfs slot 16 個が枯渇** していた。

トレース (`fatfs_alloc_fd` / `fatfs_close` に kputs を仕込んで実機計測):

```
FATFS alloc slot 00  ← parse / sigscan / tcheck の途中
FATFS alloc slot 01
FATFS close slot 1
FATFS alloc slot 01     ← slot 1 再 alloc
FATFS close slot 0      ← slot 0 close、slot 1 は close されない
(以降 alloc は slot 1 を skip して slot 2, 3, ...)
```

root cause: **`compiler/src/tcheck.tc` Phase 3 の fd_t leak**。tcheck は
3 つの SourceReader を順次 open する設計だが、最後の fd_t (tgt_path
読み込み) のみ明示的 do_close が抜けていた:

- Phase 1 (exth_path): fd_e open → close(g_reader) → do_close(fd_e) ✓
- Phase 2 (tgth_path): fd_s open → close(g_reader) → do_close(fd_s) ✓
- Phase 3 (tgt_path):  fd_t open → close(g_reader) のみ ✗

`source_reader.tc::close()` は struct + buf + StringBuffer を delete
するが underlying fd は閉じない (caller-owns 規約)。よって tcheck 1
回ごとに fatfs slot 1 個 leak。REFRESH で 13+ 回 tcheck 呼ぶうちに
16 個全枯渇。

**修正** (commit 66386cb):
- fd_t を outer scope に declare (初期 -1)
- cleanup ブロックで `if fd_t >= 0 { do_close(fd_t); }`

加えて K17 調査中に整備した道具立て (commit a5752c2):
- `rm -f` flag (`userland/bin/rm/rm.tc`)、missing file で abort しない
- `integration/fixtures/pico2_cleanup_sd.sh` を ~150 entry 分の `rm -f` に
- `integration/pico2_self_replicate.sh` に `CLEAN_SD=1` option

**実機検証** (`CLEAN_SD=1 REFRESH_KERN_MODS=1 NORESET=1`):

```
Step 1 (cat):                       38 sec
Step 2 (asm_pass1 × 13 + asm_pass2): 500 sec  ← reset 無しで完走
Step 3 (asm_pass3 + md5):           256 sec
Step 4 (bin2uf2 + md5):             517 sec
                                  ──────
                                  ~22 min, 1 boot

host kernel.bin md5: fdaa1ec1b9e074acf0c72f7514fe2eac
device k.bin md5:    fdaa1ec1b9e074acf0c72f7514fe2eac  MATCH
host kernel.uf2 md5: 73866365d5fd6f900eb04fad2d9966a5
device k.uf2 md5:    73866365d5fd6f900eb04fad2d9966a5  MATCH
```

「Pico 2 がカーネル + コンパイラを **1 boot で byte-exact 一致** に
自己ビルドする」を実機で達成。K16 (kernel arena fragmentation) +
K17 (fd leak) で 1-boot 経路の構造的バグは出尽くした。

### K18. フルセルフホスト: 全 8 コンパイラを pico2 上で byte-exact 再生成 — 完了 (2026-05-14)

K13〜K17 で kernel.bin/uf2 の self-replicate が成立した後、残された
ピースは「コンパイラ自身 (parse, sigscan, tcheck, codegen, bc2asm,
asm_pass1, asm_pass2, asm_pass3 の 8 タスク binary) を pico2 上で
host build と byte-exact 一致で再生成できるか」。今回 8/8 達成、
Pico 2 が catalyst 抜きで自分の compiler stack 全体を再生産可能に。

| compiler | md5 (host = device) |
|---|---|
| parse     | `e828a362f8f19bddbd06150776815ea9` |
| sigscan   | `6217eaca9745ce17ebb50b14fae1078d` |
| tcheck    | `c62454d8a16fd24807316205a28a503a` |
| codegen   | `e105c2e9cb1c3cdd97bc1326ae3043e2` |
| bc2asm    | `1383af3db4245a1abdccd991d8a05390` |
| asm_pass1 | `0709bdbac80d44e6f678a6e67aea48b2` |
| asm_pass2 | `964e27ccb0bfaf8bcb2b8a51d16321a5` |
| asm_pass3 | `b14f58729f9e9482eb96c3d8ee0ad267` |

3 つの構造的修正が必要だった:

1. **asm_pass1 forward-ref queue を disk stream 化** (commit a987ab3)
   parse.tc self-build で in_3 (parse.s) の asm_pass1 が OOM:
   `OOM: 130948 p=246932 l=222796`。原因は forward-ref を貯める
   `g_def_pool` (U8Array doubling 4 KB→8→16→32→64→128 KB) +
   parallel `g_def_*` arrays。peak ~226 KB が 360 KB task arena に
   入らなくなる。
   record_ref で forward ref に当たったら `def <owner> <name>\n` を
   4 KB buffered streaming で disk に書き、asm_resolve_deferred_refs
   で再度開いて 1 行ずつ lookup → refs 出力。peak 144 KB に削減。

2. **fatfs 8.3 (12-char 上限) 回避**:
   - asm_pass1 が refs/def temp file を `<idx>.idx.rfs` /
     `<idx>.idx.dfs` で開いていたが、`prelude.idx.rfs` (15 chars) は
     fatfs_open の `nlen > 12` 制限で reject されていた。
     derive_side_path を ".idx" 拡張子 **置換** 方式に変更
     (`prelude.idx` → `prelude.rfs`、11 chars)。
   - asm_pass2/3 self-build の `/sd/asm_pass2.lab` (13 chars) も同様。
     fixture を `/sd/a2.lab` / `/sd/a2.bin` (6 chars) に変更。

3. **asm_dead_strip g_ds_edges 初期 cap を 4095 → 16383 に増量**
   asm_pass2 task arena 内で g_ds_edges が 32→64 KB に doubling する
   transient (合計 96 KB live) が live ~315 KB 状態の task arena
   (max contig free 49 KB) で OOM。16383 entries (= 64 KB exact
   bucket) を task 起動時に確保すると live ~10 KB 時点で確保完了、
   後続の doubling 不要。

加えて 2 つの細かい修正:

4. **asm_pass2/3 task arena を 344 KB → 372 KB (380928)**
   K14 (2026-05-11) で「384 KB は kernel arena OOM」と記録されて
   いたが、post-K16/K17 で kernel live が ~70 KB に下がっていて
   380 KB は通る (U8Array(~398 KB) ≤ kernel max contig 408 KB)。
   400 KB 試行は U8Array(~426 KB) が 408 KB に入らず spawn OOM。

5. **Makefile hdr_<name>.s spec を $(TASK_ARENA_<name>) 参照に統一**
   旧版は disk-extra.img staging で arena/stack をハードコード
   (`asm_pass1:294912`) しており task.mk の 368640 とズレていた。
   device 側 hdr_asm_pass1.s に古い 294912 が staging され、host
   build (368640) と divergent な .bin を生成していた。task.mk と
   spec の 2 ヶ所同期を撤廃。

self-build 実行時間 (pico2 実機、device 上で imports compile から
.bin md5 まで):

| compiler | 所要 | 主要 input |
|---|---:|---|
| parse     |  ~5 min | sb, sr, sl, parse, task_data        |
| sigscan   |  ~5 min | sb, sr, sl, an, sigscan, task_data  |
| tcheck    |  9.5 min | sb, sr, sl, an, tcheck, task_data  |
| codegen   |  7.2 min | sb, sr, sl, an, codegen, task_data |
| bc2asm    |  9.4 min | sb, sr, sl, bc2asm, task_data      |
| asm_pass1 |   19 min | sb, sr, sl, ac, asm_pass1, task_data (ac compile 8 min が支配項) |
| asm_pass2 |   21 min | sb, sr, sl, ac, ds, p2l, asm_pass2, task_data |
| asm_pass3 |   21 min | sb, sr, sl, ac, p3l, asm_pass3, task_data |

これで Pico 2 が host PC の触媒抜きで kernel + 全コンパイラを再生産
できる完全な self-hosting loop が成立。`docs/roadmap.md` 「ブート
ストラップ戦略」ステップ 4 (OS 全体を独自言語で記述してネイティブ
コンパイラでビルド) の中核要件 (compiler stack を pico2 内で
maintain) が達成された。

### K15. self_replicate byte-exact 再帰仕上げ + asm_pass3 46ms silent-exit 解消 — 完了 (2026-05-13)

K14 (2026-05-11) で device self_replicate の md5 match を一度確認した
あと、dead-strip / B-type reloc / pool 最適化セッション
(2026-05-12) で同経路が壊れた。再走させると asm_pass3 task が
**46 ms で exit=0** を返し `/sd/k.bin` を更新せず、前回の stale
md5 が「偶然一致」して見える、というやっかいな状態:

```
[0.340] >> asm_pass3 --lab /sd/full.lab --out /sd/k.bin
[0.389] << exit=0 dt=0.046    ← km_dump_peak の [kmem peak=...] が
[0.413] >> md5sum /sd/k.bin    出ない
8929f2b12694514f9f5490533fd51595  /sd/k.bin   ← 前回の stale
```

**根本原因** (2 つ重なっていた):

1. **tcheck forward-reference bug** (`compiler/src/asm_pass3_lib.tc`):
   `parse_reloc_into_pending` (line ~534) が `g_lab_cur` を読むが、
   宣言は line ~712 にあった。tcheck の型推論は `g_lab_cur` を `?`
   (型不明) と判定し
   `Type error: no overload for 'skip_ws' matching (U8Array, ?, i32)`
   で **exit=1 + 部分的 .tast 出力** で終わる。

2. **`compile-gen2.sh` の silent pipeline failure**:
   `tcheck < wrap | codegen | bc2asm > out.s` の左側 (tcheck) が
   非ゼロ終了しても `set -e` は trip しない。truncated .tast が
   codegen → bc2asm を素通りし、`run_pass3` 以降の関数が一切
   compile されていない asm_pass3 task `.s` (6 functions しか
   無い、~110 KB vs 正常時 ~145 KB) が生成される。

device で task が起動すると `main(argv)` から `run_pass3(...)` を
呼ぶが、未定義シンボルは crt0 fallback (= `li a0, 0; ret`) で
解決される。a0=0 のまま `sys_exit(0)` → 46 ms silent-exit。
`[kmem peak=...]` が出ないのは `km_dump_peak` 自体が unreachable
だから。

**修正** (commit 2325004):

1. `compiler/src/asm_pass3_lib.tc`: `var g_lab_int: i32 = 0;` /
   `var g_lab_cur: i32 = 0;` を `parse_reloc_into_pending` より
   前のグローバル領域に移動。tcheck が forward 参照を含む型推論
   を諦めないですむ位置に置く。
2. `compile-gen2.sh`: `set -o pipefail` を追加。tcheck / codegen /
   bc2asm の中間失敗を全部前面に晒す。これがあれば最初から
   "exit=1 が無視される" 経路を踏まずに済んだ。

**併せて入った周辺改善** (本セッション全 commit):

- `f2f8785` `NUM_LAB_PER_DIGIT` 2047 → 4095。704b811 の縮小が
  その後の dead-strip + B-type reloc 追加で 2200 個必要に
  なり破綻していた (asm_pass2 self-build OOB)。
- `8374d91` `bootstrap/runtime_syscall.c` の C-runtime プール
  bucket 4 (256 B) を 64 → 512 スロットに拡張。asm_pass1 が
  bc2asm.s で 256-byte slot を 122 個要求する。
- `15e8124` dead-strip Phase A を `--strip` 必須化 + プール
  buckets 3-7 を generous bump。Phase A は本来 dead-code 圧縮
  時にしか要らない解析を常時走らせていて 200〜400 KB peak
  を浪費していた。
- `ce96320` `src raw` / `.idx incbin` 行を **basename only**
  で emit、asm_pass3 が `.lab` の存在 directory 相対で resolve。
  host (`/home/.../prelude.tx`) と device (`/sd/p.tx`) の絶対
  パス差異を `.lab` バイト列から排除。
- `086ea91` Makefile + orchestrator + `compile-gen2.sh` で
  host/device の中間ファイル名を揃える。`PRELUDE_NAME=p` /
  `INPUT_NAMES="kc pp bf bs ff mf tf pf vf ld kp pt"` を
  orchestrator が `compile-gen2.sh` に渡す。`bin2s_incbin.sh`
  には `dx.img` を BLOB_PATH として渡し、`<lab dir>/dx.img`
  に disk-extra.img を symlink-equivalent (cp) で staging。

**最終 byte-exact 検証** (2026-05-13 00:52 終了):

```
host kernel.bin md5: 51c9fd9d7873ececf0bed2787055bf24
device k.bin md5:    51c9fd9d7873ececf0bed2787055bf24
host kernel.uf2 md5: ca8ac3c75a63b589fcf479df643a94a1
device k.uf2 md5:    ca8ac3c75a63b589fcf479df643a94a1
kernel.bin MATCH
kernel.uf2 MATCH — pico2 self-replicated its own UF2.
END WALL=1807s (30m07s)
```

asm_pass3 step 3 は今度は **104 sec** + `[kmem peak=259400
live=234680]` を吐いて正常完走 (前回 46 ms から 2300× 長い)。

**検出経緯** ("3 時間" 神話の調査からスタート):

CLAUDE.md に残っていた古い記述 (echo hello world ~11 sec、
self_replicate ~3 h) を確認するため device で
`integration/pico2_self_replicate.sh` を回したところ ~35 min で完走
したが md5 mismatch。「stale k.bin が偶然一致」して見える挙動
を発見し、asm_pass3 task binary を逆アセしたところ
`run_pass3` が定義されていないことが判明。compile-gen2.sh
の pipeline が tcheck error を握り潰していた、というのが
最終的な根本原因。

調査の副産物として、本セッションの 7 commits (f2f8785 →
2325004) で per-stage memory peak も大幅縮小 (`docs/scaling.md`
Q1 の表参照)。

### K14. device self_replicate byte-exact — 完了 (2026-05-11)

実機 pico2 で `REFRESH_KERN_MODS=1 integration/pico2_self_replicate.sh` が
per-file pre-encode + `asm_pass2` 経路で完走し、生成された
`/sd/k.bin` と `/sd/k.uf2` の md5 が host build
(`compile-gen2.sh kernel/src/kernel_pico2.tc`) と byte-exact 一致。
walked-source モードはこの時点で退役 (commit dddbf8b)。

- host k.bin md5: `8929f2b12694514f9f5490533fd51595`
- device k.bin md5: `8929f2b12694514f9f5490533fd51595` ✅
- virt k.bin md5: `8929f2b12694514f9f5490533fd51595` (qemu-system + 同 OS image での再現も一致)
- host k.uf2 md5: `b4eee17af1f3ba6d0e9c13b36e6b4797`
- device k.uf2 md5: `b4eee17af1f3ba6d0e9c13b36e6b4797` ✅

**解決した bug の総まとめ**:

1. **OOM (asm_pass2 / asm_pass3 task arena が大きすぎ)**:
   - asm_pass3_lib.tc memory 最適化 (commit 119fac1) で peak 382→328 KB
     - `g_reloc_names` (3000 個の U8Array(name) 保持) → `g_reloc_lab_idx`
       (parse 時に label index 解決) 化で 120 KB 削減
     - `asm_ensure_labels_finalized()` を ref parse 前に呼ぶ (O(1) find_label)
     - `pre_secs` の delete 漏れ修正 (156 KB leak)
     - `RELOCS_CAP_INIT` 256 → 4096 で doubling growth 回避
   - asm_pass3 `raw_memcpy_section` の `U8Array(pad_n)` を 4 KB chunk-write
     loop に置換 (commit d2543e5) — 3.5 MB blob 前の zero pad alloc を回避
   - task arena 384→336 KB (commit 0a57e15) で kernel make_task が
     pico2 508 KB kernel arena に fit

2. **byte-exact 不一致 (parse.tc の silent overflow)** (commit 4fe14d7):
   - `parse.tc::pars_struct` の `fields: FieldInfoArray(16u32)` が
     `struct Task` (19 fields) で 17th 以降 overflow
   - Gen1 (bootstrap C runtime) は set/get の bound check で abort →
     host parse output が 1024 byte で truncate
   - Gen2 (compiler/src/runtime.tc) は `bc2asm.tc::emit_inline_set` が
     bound check を skip して inline → silent corrupt
   - 結果: virt+device は corrupt AST から「自己整合的だが host と違う」
     k.bin を生成
   - 修正: FieldInfoArray を 32 slots に bump (現状の max Task の 19 が
     収まる)

3. **その他 (virt 再現で見つけた付随 bug)**:
   - fatfs / mtfs / vfs の FD table 上限が device での REFRESH には十分だが
     virt が全 step を 1 boot で走らせると不足 (commit f2d6ce0):
     FATFS_MAX_FDS 8→16, MTFS_MAX_FDS 8→16, VFS_MAX_FDS 16→32
   - loader.tc の sys_spawn_handler 失敗パスに debug_dump_path 追加で
     spawn 失敗時の path がデバッグ可能に

**検出経緯**: 当初 device 側で OOM 393220 で step 2 が必ず落ちる症状。
原因は OOM ではなく kernel make_task の U8Array(arena_size) 失敗 (task
arena 自体が大きすぎた)。task arena を 336 KB に絞ったところ end-to-end
完走したが host kernel build と byte-exact 不一致。virt で device と同じ
OS image を走らせて 13 input idx を host 側と md5 比較したところ 4 個
(ff/mf/ld/pt) が違い、bisect で `parse < kernel_common.tc` の出力が
host=1024 byte で truncate していることが判明。原因は parse.tc の
16-slot FieldInfoArray と struct Task の 19 fields。

**Follow-up 解消 (commit 8501f6d)**: `bc2asm.tc::emit_inline_set/get`
が runtime bound check を skip するという罠は同じバグを再現させる
可能性があったので、両 inline path に 2-insn (lw + bltu) の bound
check + OOB 時に `__array_oob_{set,get}__i32__i32` への jump を
追加した。Gen1 (`bootstrap/runtime_syscall.c`) と Gen2/3
(`compiler/src/runtime.tc`) の両 runtime に対応する OOB handler を追加。

詳細は `docs/scaling.md` の self_replicate byte-exact 検証節と、
commits 119fac1 / 0a57e15 / d2543e5 / f2d6ce0 / 4fe14d7 / 8501f6d
を参照。

### K13. Pico 2 が自分の UF2 を byte-exact に self-replicate — 完了 (2026-05-06; 2026-05-09 platform fixture 追加)

**2026-05-09 追補**: K13 完成後に compile pipeline が `kernel/platform/pico2/platform_pico2.tc` を
新設して `do_uart_*` / `do_write` / `do_read` を asm から TC に移行
したため、self_replicate の REFRESH 経路で `/sd/pp.s` (TC-compiled
platform) が生成されないと on-device link で
`undefined label do_write__i32__u32__i32` が出る状態になっていた。
`integration/fixtures/pico2_compile_platform.sh` を新設し orchestrator に
step 0d として組み込んだ (commit 37b791b)。実機検証: kernel.bin md5
`1ec465d27a1137c66d9554b07e840295` / kernel.uf2 md5
`fb7645d1d735a5c0cfce9f740f3c8cb3` が host build と完全一致、
total ~29 min (REFRESH 込み)。

また step 2 を per-file pre-encode + `asm_pass2` に移行
(`integration/fixtures/pico2_self_step2.sh`)。host compile-gen2.sh と同じ
`asm_pass1 per .s + asm_pass2` の shape で .lab を生成する。
host での同パイプライン再現で byte-exact 確認、device 側の byte-exact
動作は K14 完了時 (2026-05-11) に確認、walked-source モードは退役した
(commit dddbf8b)。

更に asm_pass1 に `--incbin-skip` フラグを追加 (commit 6f57f45 / 2b48cd0):
section 先頭の `.incbin SIZE "path"` を idx の `incbin <sec> <intra>
<size> <path>` レコードに defer し、asm_pass2 が `.lab` に
`src raw <path> <sec> <abs>` 行を直接 emit する。asm_pass3 が
original blob (e.g. `/sd/dx.img`) を memcpy するので、3.5 MB の
asm_pass1 read+emit ループが消える。

  - host kernel build (compile-gen2.sh): 288 sec → 42 sec (6.9x)
  - asm_pass1 on pt.s (qemu host): 1020 ms → 39 ms (26x)

Makefile の `pico2_kernel*.uf2` 系ターゲットを `bin2s.sh` (.byte 形式
26 MB ASCII) → `bin2s_incbin.sh` (.incbin 形式 1.5 KB wrap) に切替、
compile-gen2.sh が prelude_tail.s に `--incbin-skip` を自動注入する。



Pico 2 実機がフラッシュ済の UF2 を起点に、自分が動かすファームウェアを
最初から最後まで自前で生成し、host gen2 build と byte-for-byte 完全一致
させる閉ループを達成 (~50 min)。

```
host   kernel.bin md5: 026d825ca32e4d40a67b182505c36d48
device /sd/k.bin md5:  026d825ca32e4d40a67b182505c36d48
host   kernel.uf2 md5: 4a639e26b7fbd057654ec5ac63fbf09a
device /sd/k.uf2 md5:  4a639e26b7fbd057654ec5ac63fbf09a
```

`integration/pico2_self_replicate.sh` orchestrator が openocd reset で
ステップ間を区切りつつ:

1. boot dumper (`kernel_pico2.tc::dump_mtfs_to_sd`) が起動時に
   embedded mtfs を `/sd/dx.img` に dump し、対応する `/sd/wrap.s`
   を emit。Size + 先頭 64 byte content match で skip 判定 (3 s)。
2. `pico2_compile_runtime/libtc/kern/kern2.sh` で /sd 上の .s 群を
   現ソースから regenerate (~14 min)。
3. cat 16 files → /sd/full.s (302 s)
4. asm_pass2 が `--lab-out /sd/full.lab /sd/full.s` で `src` 行を
   `.lab` に bake (232 s)
5. asm_pass3 が `--lab /sd/full.lab --out /sd/k.bin` で /sd/full.s を
   3 回直接読んでリンク (800 s)
6. bin2uf2 task が /sd/k.bin → /sd/k.uf2 を変換 (758 s)

決め手の実装:

- **`bin2uf2` task** (`userland/bin/bin2uf2/bin2uf2.tc`):
  `tools/bin2uf2.py` の TC port、qemu virt で 6 KB fixture を
  byte-exact verify 済 (commit b9067cd)
- **`.incbin SIZE "path"` directive** (`compiler/src/asm_common.tc`):
  bin2s.sh の `.byte` 列挙の代わりに binary file を直接埋め込み、
  巨大な mtfs blob を XIP flash に低コストで載せる (commit 5958574)
- **bin2s_incbin.sh / bin2s.sh の `_mtfs_image_size_value` helper**:
  TC dumper が peek32 を介さずに blob size を取れる
- **boot-time mtfs dumper**: kernel が起動時に `_mtfs_image_*` を
  `/sd/dx.img` + `/sd/wrap.s` として複製。size+content 64 B 比較
  で再 dump 判定 (commit fb9c7fb)
- **fatfs `dir_create` chain growth** (commit 773b746):
  FAT root cluster 128 entries 上限を撤廃、自己再生中に増える
  ファイルが入る
- **asm_pass2 --lab-out + 位置引数で `src` 行を `.lab` に
  emit** (commit 0c9a9a4): cat /sd/full.lab + 3×/sd/full.s →
  /sd/p2_in.s の中間ファイル (13 MB / 305 s) を撤廃。
  実機 v8 検証: kernel.bin md5 `7805e7348...` / kernel.uf2 md5
  `d4be5e9e...` が host と完全一致 (~50 min total、v6 比 ~5 min 短縮)
- **REFRESH skip** (v9 検証): /sd 上の .s 群が直近の build と
  同じソースから生成済みなら `REFRESH_KERN_MODS=0` (default) で
  step 0a-d を skip でき、~14 分短縮 (~50 min → ~36 min)。byte-exact
  は維持。ソースを触ったときだけ `REFRESH_KERN_MODS=1` で再生成。
- **fatfs FAT セクタ書き込みキャッシュ** (commit 27ec588): 連続する
  クラスタ割り当てで fat_get_entry / fat_set_entry が同じ FAT セクタを
  毎回 read-modify-write していた (FAT1 + FAT2 で 4 SD ops/cluster) 部分を
  per-sector write-back cache に置き換え。fatfs_close / fatfs_delete
  で flush。実機 v10 検証: ~50 min → ~26 min (REFRESH 込みで 1.9× 速)。
  step 1 cat (302→78 s, 3.9×)、step 2 asm_pass2 (311→97 s, 3.2×)、
  step 0c kern_leaves (323→105 s, 3.0×) が特に速くなる。byte-exact
  維持 (md5 `5dc55910...` host == device)。
- **dumper 1 KB content probe** (commit 60050f7): mtfs 先頭 64 B
  だけだと superblock layout が同じ別ビルドで誤判定するので 1 KB
  (= superblock + 16 inode entries) に拡大、disk-extra.img の
  ファイル増減を確実に検出する
- **DROP_TASKS Makefile knob**: vi/tcc/sdprobe/neofetch/
  count/tmpdemo/launcher を外して disk-extra.img を 3.5 MB に
  抑え、kernel + dumper + bin2uf2 が 4 MiB flash に収まる

副次的に閉じた issue: K11 の pico2 mr upload hang は「kernel が
disk image を /sd に dump する」内部経路に置き換わったため、
host から大容量を UART で送らずに済むようになった (K11 自体は
未解決のまま、回避経路が確立)。

### K7. pico2 で phase 7 コンパイラを完走 — 完了 (2026-04-29)

実機 Pico 2 上で OS 自身の compile pipeline が完全に走り、生成
バイナリを実行できるようになった:

```
parse → sigscan → cat → tcheck → codegen → bc2asm → cat
       → asm_pass2 → cat → asm_pass3 → /sd/HW
=> Hello, World!
合計 127 秒
```

決め手は 3 点の組み合わせ:

1. **SD カード SPI ストレージ** (commit 37c99c7)
   `kernel/platform/pico2/block_sd.tc` + MBR 対応 `kernel/src/fatfs.tc`。`/sd/<path>`
   経由で SD に読み書きできるようになり、中間ファイル
   (1.ast / 2.tast / 3.bc / 4.s / full.s / lab.s / p2.in / HW) を
   全部 SD に流せるようになった。これで 480 KB SRAM tmpfs 縛りが
   外れ、phase 7 の I/O 量が無制限に。

2. **PLL_SYS bring-up で CPU を 150 MHz 化** (commit cf22718)
   それまで `kernel/platform/pico2/platform_pico2.s` は PLL 未使用で clk_sys ≈ 12 MHz。
   asm_pass2 単独で 310 秒もかかっていた (CPU バウンド)。XOSC 12 MHz
   × FBDIV(125) → POSTDIV(5,2) で clk_sys 150 MHz に切替えた結果、
   同じ asm_pass2 が 27 秒に短縮 (11.5×)。clk_peri は XOSC 直 12 MHz
   のまま据え置いて UART/SPI baud は無変更。

3. **プロンプト同期 UART ドライブ** (commit 5dfa631)
   PL011 RX FIFO は 32 byte。sh が `sys_wait` 中は drain されない
   ので fixed-sleep のテストでは長行が捨てられた。
   `integration/pico2_pipeline_drive.py` が `sh$ ` プロンプトを見て次行を
   送る方式に切替えて回避。

旁ら必要だった副次修正:
- `bootstrap/runtime_syscall.c` の 16-byte pool を 256 → 32768
  に拡大 (commit b8049d2)。`make pico2-kernel-extra` が asm_pass2
  自身を Gen2 で compile する際の bucket 0 OOM 解消。

副次の運用 limitation (phase 8 で再検討):
- UART RX FIFO に IRQ + ring buffer は未対応 (K8+K9 と統合)
- task arena 絶対サイズの限界 (asm_pass3 で 320 KB) は維持
- 達成直後に観測された「part 3 OOM 中継」は後続テストで再現せず、
  別テストの状態残りだった疑い (要再現確認のまま closed)

### K3. タスクサイズ宣言 — 案C 完了 (2026-04-15)

タスクバイナリの先頭 8 バイトに `.word arena_size; .word stack_size`
の header を埋め込む仕組みで完了。

- `kernel/scripts/build.sh` が per-task で header.s を emit し task_crt0.s の
  前にリンク。`task_arena_size()` / `task_stack_size()` の 2 つの
  bash 関数に per-task 値が載っている (hello 8 KB ... asm_pass3 512
  KB)。
- `kernel/src/loader.tc::load_fd` が img 先頭 8 バイトから peek32 で
  arena / stack を取り、`make_task(img + 8, arena, stack)` を呼ぶ。
- kernel.tc / kernel_pico2.tc / sys_exec_handler / sys_spawn_handler
  から固定 16 MB / 16 KB を撲滅。`load_task` の引数も
  `load_task(path)` だけに簡潔化された。
- 中間バイナリ (/tmp/hw) 用の header は `/prelude.s` に 32 KB / 8 KB
  が baked in されている。

残件: OS 側で大きいタスクを compile するときに `/prelude.s` の
header 値も調整する仕組みがない (固定 32 KB)。

---

## その他 (以前から解決済み)

- **phase 7 M6 達成 (2026-04-14)**: OS 上で Hello World を自己コンパイル
  + 自己実行。sh の `<` / `>` リダイレクトと絶対パス実行、tmpfs による
  中間ファイル経由のパイプライン、runtime.tc の per-task ピークメモリ
  計測、`task_crt0.s` の `fn main()` / `fn main(argv)` 両対応フォールバック
  スタブ、`kernel/scripts/build.sh` の `/prelude.s` 事前連結など。tests/
  test_phase7.sh に 2 ステージのテストあり (`make test` 非同梱)

- **パイプライン 100 KB 計画 Phase 1 + 2 + 3 完了 (2026-04-15)**: 計画
  `docs/task/pipeline_100kb.md`、commit log は #49〜#64。元の 717 KB /
  303 KB / 1.4 MB / 9.5 MB の各ステージを劇的に縮小:
  - Phase 1: `compiler/src/sigscan.tc` + `compiler/src/tcheck.tc` を新設。
    拡張 .th (`(imports)(self)(program)` wrapper) で typecheck を
    per-function streaming 化。tcheck は per-fn strtab rollback +
    per-fn kmalloc fntab で 717 KB → **75〜251 KB** (~9x)
  - Phase 2: `compiler/src/asm_common.tc` + `compiler/src/asm_pass2.tc` +
    `compiler/src/asm_pass3.tc` を新設。`.lab` 中間ファイル (`docs/
    lab_format.md`) で 2 プロセス分離、g_lines 4 MB を廃止。
    asm-pass1 **~430 KB** (~22x)、asm-pass2 **~4.6 MB** (g_code 残
    件は問題 #7 に移動)
  - Phase 3: codegen は strtab perm/ephemeral 2 cursor 化で
    303 KB → **80〜252 KB**。bc2asm は per-function emission で
    1.4 MB → **120〜126 KB** (~11x)
  - Cleanup (#61 partial): `compiler/extract_sigs.tc` 削除 (unused)、
    `typecheck.tc` / `asm.tc` に deprecation header
  - integration/test_phase7.sh: sigscan + tcheck + asm_pass2 + asm_pass3 の
    full split pipeline で OS 上 Hello World 完走

- **Gen2 toolchain migration 完了 (2026-04-15)**: Phase 1+2+3 の後半
  cleanup。compile-gen2.sh / compile-gen3.sh / kernel/scripts/build.sh /
  tests/test_common.sh / compiler/tests/test_gen3.sh / tc_run.sh を新パイプ
  ライン (sigscan + tcheck + asm_pass2 + asm_pass3) に切り替え、
  `compiler/typecheck.tc` / `compiler/asm.tc` (+ kernel/tasks/
  typecheck/, kernel/tasks/asm/, tc_asm.sh, tests/test_split.sh)
  を完全削除

- **bc2asm の `__tc_strobj<N>` ラベルが複数 .tc 間で衝突していた (#21)**:
  ラベルを `__<first_fn_mangled_name>_strobj<N>` にして .tc ごとに一意化

- `u32 >> n` が arithmetic shift だった → `shr_u` opcode 追加 (9ff97b5)
- `u32 < u32` (`<=`, `>`, `>=`) が signed 比較になっていた → `lt_u` /
  `le_u` / `gt_u` / `ge_u` opcode 追加 + codegen で LHS 型を見て分岐
- `u32 / u32` / `u32 % u32` が signed 除算になっていた → `div_u` /
  `mod_u` opcode 追加
- 16 進リテラル `0xFFFFFFFF` 等で top bit 以上が壊れる → parse.tc の
  hex/binary 累積を `<<` + `|` に変更
- struct 定義の trailing comma が通らなかった → 修正 (b04855c)
- 関数宣言 / 関数呼び出しの trailing comma → 修正 (b04855c)
- struct array が asm リンカで未定義シンボル → parser で synthetic fn
  を生成して修正 (b04855c)

### 8. asm セクション 16B アライン制限 (wontfix, 2026-04-17 moved)

実害は qemu virt の block_virtio.tc 1 箇所のみ (12 KB waste)。
pico2 は関係なし。修正不要と判断。

### K4. UART EOF 検出不可 (limitation → mux で解決, 2026-04-17 moved)

`do_uart_read` が busy-loop で EOF を区別できなかったが、
UART mux (mx/mr) の length-prefix フレーミングで len=0 が EOF マーカー
として機能するため、mux ON 環境では解決。mux OFF では sh の "quit"
コマンドで代替。

### K5. cat 5 ファイル後の spawn 失敗 (bug → 解決, 2026-04-17)

調査の結果、`sys_spawn_handler` で `sched_spawn` が失敗した際に
redirect fd / frame / ram / stack / img / argv がリークするバグを発見し
修正 (`free_last_alloc()` 追加)。元の再現条件 (旧パイプライン構成) は
現在の virt 環境で 5-file cat + redirect を 4 回繰り返しても再現せず、
prelude 導入前の構成固有だったと判断。

### K6. デバッグトレース常時 ON (ergonomics → 整理済, 2026-04-17)

TIMER_INTERVAL を 1s → 1ms に復元。kdbg_switch / kdbg_exit を mux ON
時のみに。kdbg_write (vfs redirect trace) を削除。km_dump_peak の
task_crt0.s 常時 call を削除。kdbg_trap と OOM メッセージは残留。

### K10. pico2 multi-file cat hang (bug → 再現せず, 2026-04-17)

pico2 で cat 3+ ファイルが hang する問題。2026-04-17 に pico2 実機で
cat 3 files / cat 4 files (redirect 付き) を確認したところ正常動作。
K5 の sys_spawn_handler リソースリーク修正や構成変更で解消されたと判断。

### 17. make test 60 秒制約 (ergonomics → 解決, 2026-04-17 moved)

Make ベース incremental build 導入後、warm 33s / cold 78s まで短縮。
60 秒制約を十分に満たしている。

### 3. 整数リテラルの型推論 (ergonomics → 解決, 2026-04-18)

関数呼び出し時にサフィックスなし整数リテラル (`256`) をパラメータの
整数型 (`u32`, `u8` 等) に合わせて自動推論するよう tcheck.tc と
bootstrap/typecheck.c に 2段階オーバーロード解決を実装。

Phase 1: exact match (従来通り)。Phase 2: exact match 失敗時に
サフィックスなし整数リテラル引数を相手型に coerce して再解決。
変数経由 (`var n: i32 = 256; f(n)`) は従来通りエラー。

`U8Array(256u32)` → `U8Array(256)` のように配列コンストラクタや
poke/peek 等の直接リテラル引数から u32 サフィックスを ~180 箇所除去。
変数の `as u32` キャストやバイナリ演算内のサフィックスは対象外
(関数呼び出し引数位置のリテラルのみ)。

### UART stdin ブロック (bug → 解決, 2026-04-18)

sh の `sys_read(0, buf, 1)` が ecall ハンドラ内の `do_uart_read` で
M-mode スピンウェイトし、hello/hello2 等の他タスクが実行されなかった。
`do_uart_try_read` (非ブロッキング) + -2 sentinel + `sched_yield_read`
で yield and retry に変更。-2 sentinel により UART empty と file EOF
(リダイレクト時の tmpfs/pipe EOF) を区別。

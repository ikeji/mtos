# コード改善候補一覧

2026-04-22 時点で compiler/ / kernel/ / kernel/tasks/ の全 .tc ファイルを
レビューして抽出した改善候補。45 項目のうち 26 件を修正済み、4 件を
保留、残りは無効化または却下。

**Status 凡例:**
- **FIXED (commit)**: 実装済み
- **TBD**: 後回し
- **REJECTED**: 現実的に影響なし、あるいは要件と合わず却下
- **INVALID**: レビュー時に誤りが判明し削除

---

## High: バグ・正確性の問題

### H1. numlab_back/fwd が miss 時に 0 を返す (asm_common.tc)

**Status:** FIXED (a5246cc)

`numlab_back` / `numlab_fwd` でバックワード/フォワード数字ラベルが
見つからない場合に 0 (= テキスト先頭の正当なアドレス) を返していた。
miss 時に `numlab_miss` 経由で `asm_err_end` で exit するように変更。

### H2. bcrun: 未定義変数の LOAD/STORE がサイレントに 0 を返す (bcrun.tc)

**Status:** FIXED (13b454a)

OP_LOAD miss 時に 0 push、OP_STORE miss 時に値を捨てる挙動だった。
`bc_fatal_name` で stderr にエラー出して `sys_exit(1)`。

### H3. bcrun: ゼロ除算ガードなし (bcrun.tc)

**Status:** FIXED (13b454a)

RISC-V rv32im は DIV/REM ゼロ除算を trap せず -1 / dividend を返す
(元記述の「crash する」は誤り)。OP_DIV/OP_MOD/OP_DIV_U/OP_MOD_U の
divisor チェックを追加、`bc_fatal_lit("divide by zero")`。

### H4. asm_install_label_from_lab に境界チェックなし (asm_common.tc)

**Status:** FIXED (a5246cc) — Medium 降格

`define_label` の MAX_LABELS / MAX_NAME_POOL チェックを
`asm_install_label_from_lab` / `asm_install_numlab_from_lab` にも
追加。pass 1 で既にチェック済みなので実害は低いが defense-in-depth。

### H5. sigscan: consume_subtree_silent が \xNN エスケープを処理しない

**Status:** INVALID — 削除

AST 形式は `\n` `\t` `\r` `\\` `\"` の 5 種のみ、`\xNN` は存在しない。
元レビュー時の形式誤認。

### H6. tcheck: 22+ parameter で OOB (tcheck.tc)

**Status:** FIXED (a5246cc) — Low 降格 + 記述訂正

元記述「OOB write」は誤り。np は FN_MAX_PARAMS で capped、
ft_alloc も capped 値で確保するので OOB しない。実バグは
**22+ param の関数がサイレント truncation** (signature 破壊)。
修正: loop 終了後に `pc1 >= 0` ならエラーで abort。

### H7. virt kernel: rearm_timer の mtime_hi 無視 (kernel.tc)

**Status:** FIXED (ff80d4e)

`poke32(MTIMECMP_HI, 0)` 常時書きで、mtime_hi が 1 以上になると
(~7 分稼働) 割り込みが即時連発 → 全タスク starvation。pico2 と同じ
パターンに揃える: `MTIMECMP_HI = 0xFFFFFFFF` で guard、mtime_lo/hi
読んで carry 処理、MTIME_HI (0x0200BFFC) 追加。

### H8. task_input_read が M-mode でビジースピン (kernel_common.tc)

**Status:** FIXED (58a4a4b)

mux モードで stdin ring buffer 空時に trap handler 内で
`uart_rx_dispatch()` をスピンし、mie マスクで他タスク starvation。
while を 1 回 dispatch + buf 空なら -2 yield に変更、加えて timer
handler 内でも `g_mux_enabled != 0` のとき uart_rx_dispatch 呼び出し。

### H9. procfs: synth_tasks の OOB 読み出し (procfs.tc)

**Status:** FIXED (1b857ba)

`append_byte` が `pos >= cap` でも pos+1 を返していたため、
synth_tasks 末尾の poke32(buf, pos) が U8Array 実サイズを超える
長さを書き、procfs_read が OOB read。`pos >= cap` で進めないように
変更。一度だけ `kputs("procfs: output buffer truncated")` で警告。

### H10. procfs: append_dec が val==0 で U8Array(12) をリーク

**Status:** INVALID — 記述誤り (note 化)

`d` は `x == 0` の条件分岐より後に宣言されており、早期 return 時
には allocate されていない。現状リークなし。順序変更時の注意点と
してだけ認識。

### H11. sh: do_pipe 失敗時にパイプ fd がリーク (sh.tc)

**Status:** FIXED (17eadc9)

`do_close` 宣言はあるが呼ばれず、N 本目の `do_pipe` 失敗で既作成
fd がリーク。成功パスでも parent が pipe fd を閉じないので EOF
delivery 不可。wait 前に `pi` (作成数) 本の read/write fd を
`do_close` で閉じるように変更 — 失敗・成功両対応。

### H12. sh/ls: do_readdir バッファの off-by-4

**Status:** INVALID — 誤り (note 化)

`U8Array(N)` は header 4 + data N の構成、data 領域は N バイト確保
されるので `buf+4` から 4096 書いても OK。元記述の誤り。

### H13. sh: open_redir_path で ffd > 0 を使っている (sh.tc)

**Status:** FIXED (17eadc9) — 記述差し替え

元記述の「fd 0 が返った場合」は誤り (VFS fd は 3 以上)。実バグは
`ffd < 0` の silent 無視 (open 失敗が無視されてコマンドが通常
実行される)。失敗時に `sh: <path>: open failed` を stderr に出し
spawn スキップ + pipeline fail に変更。

### H14. grep: str_nul("grep: ") の結果がリーク (grep.tc)

**Status:** FIXED (2be6343)

L1 で libtc に `eputs` 追加 + grep / cat の stderr 出力を eputs
呼び出しに書き換え、`str_nul` の戻り値を保持しない経路が消えて
リーク解消。

---

## Medium: 堅牢性・エッジケース

### M1. 32-bit mtime ロールオーバーで sleep が壊れる (kernel_common.tc)

**Status:** FIXED (ff80d4e)

`read_mtime()` は u32、wake_time も u32 で保存、`now >= wake_time`
比較がラップ越えで壊れる。wraparound-safe な
`(now - wake_time) as i32 >= 0` の signed-diff 形式に変更。
2^31 tick 未満の sleep 時間なら常に正しく動く。trap_handler の
wake check + sys_nanosleep の re-exec check 両方。

### M2. sched_wait が全タスク sleeping 時に 0 を返す (kernel_common.tc)

**Status:** FIXED (58a4a4b)

caller は WAITING 状態になり、sys_wait が 0 success 扱いで復帰する
挙動だった。sched_wait 内で idle-poll loop を追加: READY を探し、
見つからなければ mtime で SLEEPING を wake しながら再スキャン。
誰も sleeping でない (= 回復不能) なら 0 を返して caller の bug を
可視化。

### M3. sys_nanosleep(0) でデッドロック (kernel_common.tc)

**Status:** FIXED (ff80d4e)

`wake_time == 0` が「未設定」sentinel と衝突し、`now + ticks == 0`
の時に初回ブランチが無限ループ。計算結果が 0 になったら 1 にずらす
1 行追加で解決。

### M4. fatfs: FAT2 更新時に FAT1 の上位 4 bit を使う (fatfs.tc)

**Status:** FIXED (2494a1f)

`fat_set_entry` で FAT2 更新時、top 4 bits を FAT1 から取得していた。
FAT2 の sector 読み込み後に再抽出する `old2` を追加。

### M5. fatfs: partial write の read-modify-write でエラーチェックなし

**Status:** FIXED (2494a1f)

`fatfs_write` の partial-sector read-modify-write で
`fat_block_read` の戻り値チェックなし。`!= 512` で `-1` return に変更。

### M6. mtfs/fatfs: secbuf がプリエンプション間で共有 (mtfs.tc, fatfs.tc)

**Status:** FIXED (10ecf4d)

`g_mtfs_sector` / `g_fat_secbuf` が共有されており、preempt された
mtfs_read / fat_* 間でバッファ上書き race。hot path
(`mtfs_read`, `fat_get_entry`, `fat_set_entry`) を per-call
`U8Array(512)` alloc/delete に変更。mount 時 (preempt 前) は
共有バッファのまま — fatfs 側は `g_fat_secbuf` 自体を削除し
mount でも local scratch 使用。

### M7. tmpfs_write の need 計算がオーバーフローする (tmpfs.tc)

**Status:** FIXED (2494a1f)

`need = tf_pos + n` の i32 加算がラップして grow スキップ → OOB
write の可能性。冒頭で `if n < 0 || n > 16777216 { return -1 }`
チェック追加。

### M8. sched_register(idx, f) が境界チェックなし (kernel_common.tc)

**Status:** FIXED (2494a1f)

`idx < 0 || idx >= g_num_tasks` チェックを `sched_register` 冒頭に
追加。加えて `main()` 側で `n_cfg > n_slots` の警告 + clamp。

### M9. vfs_read で fd 1/2 が UART 読み出しに飛ぶ (vfs.tc)

**Status:** FIXED (2494a1f)

`if fd >= 0 && fd < 3 { return do_uart_read(...) }` が fd 1/2 も
拾っていた。`if fd == 1 || fd == 2 { return -1 }` に変更。

### M10. vi: ファイル 16 KB 超でサイレント truncation (vi.tc)

**Status:** FIXED (1b857ba)

`load_file` で `n == BUF_CAP` の場合に `sys_read(fd, probe, 1)` で
1 byte 追加試行、戻り > 0 なら `[read, truncated: file exceeds 16KB]`
メッセージ。

### M11. cp: sys_write の戻り値未チェック (cp.tc)

**Status:** FIXED (2494a1f)

`sys_write` の戻り値をチェックして不一致なら stderr + `exit 1`。

### M12 + M13. asm: line buffer 4092 統一 + overflow error

**Status:** FIXED (95fa19a)

`g_line_buf` は 4092 byte、caller の `U8Array(4096)` + buf_cap 4096
で不整合。caller を 4092 / 4092 に統一し、`llen >= buf_cap` で
`asm_err_end("line too long (max N bytes)")` で abort。
`asm_err_begin` / `asm_err_end` を export (asm_pass1 から使うため)。

### M14. codegen: read_node のエスケープで next が二重実行の可能性

**Status:** INVALID — 削除

`\n` トレース時: 「`\` 消費 → peek esc → 分岐内で ch 変換 → 分岐外で
set → next で esc 消費」で 2 バイト正しく消費している。二重実行なし。
元記述の誤り。codegen / tcheck / sigscan 3 箇所すべて同じ正しい
ロジック。

---

## Low: パフォーマンス・コード品質

### L1. libtc に共通ユーティリティを集約 (libtc.tc)

**Status:** FIXED (2be6343 + b12af22)

以下を libtc.tc に追加:
- `to_cstr(s: String) -> U8Array` (新規)
- `to_cstr(s: StringLiteral) -> U8Array` (旧 `str_nul` 改名)
- `print(v: i32) -> void` (旧 print_u32 / print_int の統合 + 改名)
- `eputs(s: StringLiteral) -> void` (新規、stderr)
- `putchar(c: u8) -> void` (新規、1 byte write)

重複削除: catfile / cp / rm の `str_to_nul` / `string_to_nul` /
`str_nul` → `to_cstr`。wc / du / neofetch / count / vi の
`print_u32` / `print_int` / `emit_int` + `putc` → `print` / `putchar`。

### L2. sh/msh の共通コード (sh.tc, msh.tc)

**Status:** FIXED (部分) (2be6343)

`eq_lit` のみ libtc に `eq` として移動。他 (count_tokens / copy_range
/ parse_redir / free_argv / build_path) は shell 固有なので
各々に残す。msh / sh の `eputs` は libtc 版に置換。

### L3. block_fat_virtio.tc が block_virtio.tc の完全コピー

**Status:** TBD

virt の 1st / 2nd virtio-blk デバイス用に symbol 分離された 2 ファイル
(~260 行の 95% 重複)。per-device struct 化が理想だが TC の generics
弱く refactor コストが高い。現状維持。

### L4. kernel.tc / kernel_pico2.tc の main() 重複

**Status:** FIXED (00895aa)

kern.conf パース + init タスク登録ループを `loader.tc::start_init_tasks()`
に抽出。両 main() は `if start_init_tasks() == 0 { ...default seeds... }`
に集約。

### L5. vfs.tc: path prefix チェック 3 関数

**Status:** FIXED (1b857ba)

`is_tmp_path` / `is_sd_path` / `is_proc_path` の 3 関数を
`path_has_prefix(addr, plen, prefix)` に統合。3 関数は 1 行の
wrapper に。

### L6. vfs.tc: resolve_mtfs_inode と vfs_open のパスウォーク重複

**Status:** TBD

空 segment の扱いが微妙に違う (vfs_open は -1、resolve は root 返す)。
共通 helper 抽出は可能だが挙動差を吸収する必要あり。後回し。

### L7. asm_common: find_label が O(N) 線形探索

**Status:** FIXED (853987e)

pass 2 で `.lab` ロード完了後に `asm_finalize_labels()` を呼び、
16384 スロットのオープンアドレッシング hash table を構築。
find_label は g_lab_hash_ok で分岐して hash lookup (O(1))、
なければ従来の線形 scan。pass 1 は元のまま linear。

### L8. string_buffer: emit_int が毎回 U8Array(12) を確保

**Status:** FIXED (77c3402)

module-level の `g_emit_int_tmp` を lazy-init し再利用。alloc/free
per-call を排除。

### L9. kputchar が毎回 U8Array(1) を確保 (kernel.tc)

**Status:** REJECTED

boot debug (dump_sector0) でのみ使用、17 回/起動。hot path でない。

### L10. parse_rx_frames が毎回 memmove (kernel_common.tc)

**Status:** REJECTED

UART 速度 14 KB/s で memmove の影響軽微。ring buffer 化の必要なし。

### L11. block_flash: byte-by-byte セクタコピー

**Status:** REJECTED

pico2 の loader は `mtfs_xip_addr` で flash 直参照し、block_read は
mount 時の数セクタのみ。hot path でない。

### L12. ob_st_escaped が codegen/tcheck で重複

**Status:** FIXED (77c3402)

`string_buffer.tc::emit_escaped` に抽出、codegen.tc / tcheck.tc の
定義を削除して callsite 置換。

### L13. read_node のエスケープシーケンスデコードが 3 箇所重複

**Status:** FIXED (89db759)

`source_reader.tc::read_string_char(sr) -> i32` を追加。`\X` まるごと
消費して decoded byte を返し、-1 で `"` or EOF。codegen / tcheck /
sigscan の 3 箇所すべて同じ 5-6 行の while ループに統一。

### L14. bcrun: 6.5 MB の固定事前確保

**Status:** REJECTED — 記述訂正

実測 ~3.5 MB (元記述の 6.5 MB は誤り)。bcrun はホスト側ツール、
OS に乗らない → 固定 alloc で問題なし。

### L15. mtfs_mount で FD テーブルの二重初期化

**Status:** FIXED (77c3402)

`clear_fd_table()` 呼び出しを削除。構築ループ (`MtfsFD(-1, 0)`) だけ
残す (struct array の各スロットを明示構築する必要がある)。

### L16. vi: row_col が O(offset) で毎回先頭から走査

**Status:** TBD

keypress ごとに最大 16 KB scan、pico2 150 MHz で実用上問題なし。
incremental cache は将来の課題。

### L17. tty_tag_for_slot が 16 分岐の if chain

**Status:** TBD

UART mux 時の frame 送信ごとに呼ばれるが frequency 低く実害なし。
static table 化は将来の課題。

---

## 参考: 意図的/許容済みの項目

- `parse.tc` の `classify_ident` 長さ別ディスパッチ:
  パフォーマンス意図、keyword 追加時の注意で十分
- `hello.tc` / `hello2.tc` の重複: smoke test 目的、統合不要
- `catfile` の 64 byte read 上限: テストハーネス専用
- `tmpfs` に unlink がない (ファイルが溜まる): 既知制限
- `bcrun.tc` の `fn_table` stride-10 flat array: レガシーだが動作

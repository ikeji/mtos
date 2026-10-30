# `/proc/self/env/` — procfs 経由の環境変数 (設計、2026-10-30)

## 動機

vi / sl は起動時に `/etc/term.conf` (COLS / ROWS) を読んで画面サイズを
決めている (commit 3ef0029)。しかしこのファイルはディスクイメージ全体で
1 つなので、console 系ディスク (`kern_console_vram.conf` 等は
`init=/bin/console -l -v` と `init=/bin/sh` の両方を持つ) では **UART 側
の sh から起動した vi も LCD 用の 56x15 で描画される**。逆に term.conf
の無いディスクでは LCD 側が 80x24 のまま。

task は自分の stdin が `/dev/kbd` か UART かを知る手段を持たず、親から
子へ情報を渡す経路は argv しかない。「親が子に伝える、継承される、生存中
に書き換えられる」情報 = Unix の環境変数 (`LINES` / `COLUMNS` / `TERM`)
が欲しい。

## 結論: spawn ABI は変えず、`/proc/self/env/<KEY>` を読み書き可能な
procfs ファイルとして実装する

検討した 2 案:

| 案 | 内容 | 却下 / 採用理由 |
|---|---|---|
| A. envp を ABI で渡す | spawn / spawn_fds / exec に env StringArray を追加 (a4)、task_crt0.s が a3 で受けて libtc のグローバルへ | trap_common.s / task_crt0.s / libtc / kernel spawn 3 本 / sh の export builtin と層をまたいで揃える箇所が多い。「0 なら親を継承」を実現するには結局 kernel が親の領域を読む |
| **B. `/proc/self/env/<KEY>`** (採用) | kernel が task ごとに env 表を持ち、procfs で読み書きさせる。spawn 時に親の表を子へコピー | ABI 不変。`echo 15 > /proc/self/env/ROWS` / `cat /proc/self/env/ROWS` / `ls /proc/self/env` が追加コードなしに sh から使える (`echo ... > /dev/rtc` が通る今の流儀)。継承は kernel の spawn 1 箇所で済み、spawn する側 (sh / msh / console / launcher) は何も意識しない |

argv は「呼び出しの一部」(関数の引数と同じで、spawn 時に渡され生存中は
不変、`main()` 入口で必要) なので入口は spawn のまま。対称性は
「argv も /proc で渡す」ではなく「**argv も /proc で読める**」方向で取り、
`/proc/self/cmdline` (読み取り専用) を同時に足す。Linux の
`/proc/self/{cmdline,environ}` と同じ形。副産物として `ps` にコマンド
ラインを出せる。

## 名前空間

```
/proc/
  tasks meminfo cpuinfo uptime diskinfo soc kernel   (既存)
  self/                 呼び出し task 自身 (open / readdir 時の g_current)
    cmdline             argv を空白区切りで 1 行 + LF (読み取り専用)
    env/                環境変数ディレクトリ
      <KEY>             値 + LF。O_CREAT|O_WRONLY で書くと設定
  <slot>/               (Phase 4、任意) 他 task の cmdline / env を読み取り専用で
```

- `KEY` は `[A-Za-z0-9_]+`、最大 31 バイト。値は NUL / LF を含まない
  最大 127 バイト。
- **読み**: `cat /proc/self/env/ROWS` → `15\n`。無いキーは open が -1
  (ENOENT 相当)。LF を付けるのは `echo X > f; cat f` と対称にして sh
  プロンプトが崩れないため。vi / sl の 10 進パーサは非数字で止まるので
  LF は無害。
- **書き**: `echo 15 > /proc/self/env/ROWS`。書かれたバイト列から末尾の
  LF を 1 つ落として値にする。空文字列も有効な値。
- **削除**: `do_unlink("/proc/self/env/ROWS")` → 呼び出し task 自身の
  unset (`vfs_unlink` に procfs 分岐、Phase 2 で実装済)。**sh から
  `rm /proc/self/env/ROWS` と打っても sh の変数は消えない**: rm は別
  task で、自分が継承したコピーから消すだけ (`>` の open が sh の文脈で
  行われるのとは違い、unlink は rm の syscall)。sh の変数を消すのは
  Phase 3 の `unsetenv` builtin (libtc `env_unset` → do_unlink)。

### `self` の解決タイミング — 重要

`self` は **open / readdir した瞬間の `sched_current_idx()`** で解決し、
ProcFD に slot 番号を記録する。これにより:

- `echo 15 > /proc/self/env/ROWS` — sh は `echo` を spawn し、`>` の
  open は `sys_spawn_handler` → `open_redir` → `vfs_open` で **sh の
  文脈** (syscall 中、g_current = sh) で行われる。ProcFD は sh の slot
  を覚えるので、echo が書いた値は **sh の env** に入る。fd は子 (echo)
  所有で exit 時に close されるが、commit 先は記録済の sh の slot。
- `cat /proc/self/env/ROWS` — cat 自身の env を読む。cat は sh の子で
  env を継承しているので sh が設定した値が見える。
- `ls /proc/self/env` も同様に ls の継承 env を列挙する。

つまり sh に builtin が無くても、環境変数の設定・参照・列挙が既存
コマンドだけで成立する。ただし `>` 経由の設定はこの「open 時解決」に
依存していて直感に反する (echo の env に入ると誤解しやすい) ので、
sh には `setenv` / `getenv` / `env` builtin を UI として足す (後述)。
機構は /proc、builtin はその薄い皮、という分担。

## kernel 側

新規 .tc モジュールは**追加しない** (self-replicate manifest
`integration/scripts/self_replicate_modules.sh` の K20 型 drift を避ける)。
変更は `kernel_common.tc` / `procfs.tc` / `vfs.tc` / `loader.tc` /
`trap_common.s` に収める。

### Task への追加 (kernel_common.tc)

```tc
struct Task {
    ...
    env:  u32,   // kmalloc'd env 表 (0 = 空)。slot_free_allocs で kfree
    argv: u32,   // packed argv (ram block 内、make_task_argv_addr の値)。
                 // /proc/self/cmdline 用。0 = argv 無し
}
```

- `argv` を別に持つ理由: `set_frame_argv` は trap frame の saved a2
  (frame+48) に書くが、frame は trap ごとに保存し直されるので task が
  走り出した後の frame+48 は生きた a2 であって argv ではない。
  `slot_capture_last` で `g_last_argv_addr` を `argv` に写す (name と
  同じ経路)。ram block 内なので解放は ram と一緒。
- `env` の表: 1 本の kmalloc (`ENV_CAP = 256` バイト) に
  `[used: u32][KEY=VALUE\0 KEY=VALUE\0 ...]` を詰める。線形探索で十分
  (数本しか入らない)。満杯なら write が -1 を返し `kputs("procfs: env
  full\n")` で loud に (fd table 満杯の流儀)。
- **lazily 確保**: 最初の write、または親に非空の env があるときの
  spawn コピーでだけ kmalloc する。UART の sh (kern.conf init) は 0 の
  まま。
- `slot_free_allocs(idx)` で `env` を kfree して 0 に。

API (export):

```tc
fn task_env_get(slot, key_addr, klen, out_addr, cap) -> i32   // 値長 / -1
fn task_env_set(slot, key_addr, klen, val_addr, vlen) -> i32  // 0 / -1
fn task_env_unset(slot, key_addr, klen) -> i32
fn task_env_count(slot) -> i32 / task_env_key(slot, i, out, cap) -> i32  // readdir 用
fn task_env_inherit(child, parent) -> void   // 親が非空なら丸ごとコピー
fn task_get_argv(slot) -> u32
```

### spawn / exec (loader.tc, kernel_common.tc)

- `sys_spawn_handler` / `sys_spawn_fds_handler`: `sched_spawn` が slot
  を返した直後に `task_env_inherit(slot, sched_current_idx())`。
- `sys_exec_handler`: `sched_replace_current` が旧 alloc を
  `slot_free_allocs` で解放するので env も消える。exec 前に `env`
  ポインタを退避して `env(t, 0)` にし、新 frame 装着後に戻す (Unix の
  exec は env を保つ)。
- kern.conf init (`sched_register`) は env 0。

### procfs (procfs.tc)

現在の procfs は「open でスナップショットを kmalloc、read で消費、close
で kfree」の読み取り専用モデル。これに 2 つ足す。

1. **階層化**: `procfs_open(path_addr, plen, flags)` と
   `procfs_readdir(path_addr, plen, buf, size)` が path を解釈する。
   `vfs_open_owned` は procfs に flags を渡すようにし、`vfs_readdir` は
   `/proc` 完全一致だけでなく `/proc/self` / `/proc/self/env` (Phase 4
   で `/proc/<n>`) を procfs に回す。`ls /proc` には `self` も出す。
2. **書き込み**: `ProcFD` に `mode` (0 = read snapshot / 1 = env write)、
   `slot`、`key` (U8Array、≤ 31 B) を足す。
   - `/proc/self/env/<KEY>` を O_WRONLY / O_RDWR / O_CREAT / O_TRUNC の
     いずれかで open → mode=1、`buf` は書き込みバッファ (128 B)。
   - `procfs_write(fd, buf, n)`: バッファに追記 (溢れたら -1)。
   - `procfs_close(fd)`: mode=1 なら末尾 LF を 1 つ落として
     `task_env_set(slot, key, buf)` に commit。close 時 commit なので
     `printf` 的に複数 write されても 1 値になる。
   - 読みの open は `task_env_get` の結果 + LF をスナップショットに
     する (既存モデルのまま)。
   - vfs の write vtable (`g_fs_write[FS_PROCFS]`) は現在 0 (未対応 →
     -1)。`trap_common.s` の `fs_ops_init` に `procfs_write` の
     mangled 名を 1 行足す (mangled 名はここ 1 箇所に集約する流儀)。
3. **`/proc/self/cmdline`**: `task_get_argv(slot)` の packed argv
   (`[count][ptr_i...][len_i bytes_i]...`) を空白区切りで結合 + LF。
   argv 0 なら task name のみ (kern.conf init)。

`PROCFS_MAX_FDS = 4` は据え置き (vi / sl の起動時読みは即 close)。

## userland 側

- **libtc**: 文字列の読み書きだけを提供し、型は知らない。
  ```tc
  export fn env_get(key: StringLiteral, buf: U8Array, cap: i32) -> i32;
      // open /proc/self/env/<key> → read → close。値のバイト数 (LF 抜き)、
      // 無ければ -1
  export fn env_set(key: StringLiteral, buf: U8Array, n: i32) -> i32;
      // O_CREAT|O_WRONLY|O_TRUNC で open → write → close。0 / -1
  export fn env_unset(key: StringLiteral) -> i32;
      // do_unlink("/proc/self/env/<key>")
  export fn parse_dec(buf: U8Array, off: i32, n: i32) -> i32;
      // 非数字で止まる 10 進パーサ。vi / sl / ps が私物で持っている
      // parse_dec_buf / tok→i32 をここに寄せる (副産物の集約)
  ```
  数値化は呼び手 (vi / sl) がプロセス内で `parse_dec` する。key の
  `/proc/self/env/` prefix 連結は env_get / env_set の内部で行う
  (U8Array に String layout で組んで do_openat へ渡す、vi の g_path と
  同じ手口)。vi と sl が持つ term.conf パーサ (`load_term_conf` /
  `buf_starts_with` / `parse_dec_buf`) は削除。
- **console**: sh を `do_spawn_fds` する**前**に自分の env に
  `COLS` / `ROWS` (と `TERM=lcd`) を書く。子は spawn 時に継承する。
  値は今の `term_landscape.conf` (56 / 15) と `term_portrait.conf`
  (40 / 30) と同じにする。
  - 要確認: landscape の console は `TCONT_COLS = 58` / `TCONT_ROWS =
    17` を内部で持つが、term.conf は 56 / 15 で経験的に合わせた値
    (web/tests/test_console.sh が「status 行が LCD 15 行目」を検証)。
    実装時に console のどの変数が子に見せる端末領域なのかを確かめ、
    その値を export する (差があるなら理由をコメントに残す)。
- **vi**: `env_get("ROWS", ...)` が成功したら `parse_dec` して
  `g_screen_rows` / `g_text_rows` に、`COLS` が成功したら `cols - 1` を
  `g_print_cols` に (eager wrap の -1 は据え置き)。未設定なら 80x24 の
  既定のまま。ROWS < 2 / COLS < 3 の無視も据え置き。
- **sl**: 優先順位は argv (`sl COLS ROWS`) > env > 80x24。
- **ps** (Phase 4、任意): `/proc/<slot>/cmdline` を読んで NAME の代わり
  に cmdline を出す。
- **sh** (Phase 3): 現在の builtin は `exec_command` 先頭の `quit`
  だけ (専用の仕組みは無く `eq(cmd, n, "quit")` で見ている)。同じ場所に
  3 つ足す。どれも libtc の env_get / env_set の薄い皮:
  - `setenv KEY VALUE` — `env_set`。VALUE 省略は空文字列
  - `unsetenv KEY` — `env_unset` (rm では sh の変数は消えない、上述)
  - `getenv KEY` — `env_get` して値 + LF を出力。無ければ exit≠0 相当の
    メッセージ
  - `env` — `/proc/self/env` を readdir して `KEY=VALUE` を 1 行ずつ
  `$VAR` 展開は Phase 4 (任意)。同じ env_get に乗るだけ。

## 廃止するもの

- `/etc/term.conf`: `kernel/fs-spec/etc/term_{landscape,portrait}.conf`
  と `kernel/Makefile` の `DISK_TERM_CONF` 配線 (6 ディスク × 2 行 +
  `PRELUDE_PRE_ENCODE` の cp)。console が自分の幾何を知っているので
  ファイルで共有する必要がない。
- vi / sl の term.conf パーサ。

## テスト

- **kernel (`kernel/tests/test_os.sh`、virt)** に msh スクリプトで追加:
  ```
  echo 15 > /proc/self/env/ROWS      # sh の env に入る (self = open 時の sh)
  cat /proc/self/env/ROWS            # → 15 (cat が継承)
  setenv COLS 56                     # builtin 経由
  getenv COLS                        # → 56
  env                                # → COLS=56 / ROWS=15
  ls /proc/self/env                  # → COLS ROWS
  catfile /proc/self/cmdline         # → catfile /proc/self/cmdline
  cat /proc/self/env/NOPE            # → open 失敗 (エラー表示、exit≠0)
  ```
  `find /tmp /proc -type f` の既存チェックが `/proc/self/...` を拾う
  ので期待値を見直す。spawn/wait leak canary (`KERN: live=...`) で
  env の kmalloc が exit で解放されることも同時に見る。
- **web (`web/tests/test_console.sh`)**: 既存の「LCD の vi は status 行
  が 15 行目」に加え、**UART 側** (node_run の `--stdin` で xterm 相当の
  入力を流す) で `cat /proc/self/env/ROWS` が失敗し、vi の status 行が
  24 行目に来る (UART ログの `ESC[24;1H` か、CRLF 23 本の後に
  `-- NORMAL`) ことを確認する。
- **実機**: pico2 の `make -C kernel run-pico2-console-land` で vi の
  行数が変わらないこと。self-replicate は kernel ソース変更のみなので
  byte-exact に影響しない (新モジュール無し)。
- `make test` 1 分上限: test_os への追加は msh 1 行ずつ (~数十 ms) で
  収まる。

## フェーズ

1. **kernel**: Task.env / Task.argv、task_env_* API、spawn 継承、exec
   保持、procfs の階層 open / readdir、env read、`cmdline`。
   ここまでで `cat /proc/self/cmdline` と `ls /proc/self` が動く。
2. **kernel 書き込み**: ProcFD の write モード、`procfs_write` +
   vtable、close commit。`echo 15 > /proc/self/env/ROWS` が通る。
   test_os に上記チェックを追加。
3. **userland**: libtc `env_get` / `env_set` / `parse_dec`、console の
   export、vi / sl の切替 (+ ps の parse_dec 集約)、sh の `setenv` /
   `getenv` / `env` builtin、term.conf 廃止、web テスト (UART 側 24 行)
   追加。docs/filesystem.md の procfs 節 (「読み取り専用」の記述) と
   docs/sources.md を更新。
4. **任意**: `/proc/<slot>/{cmdline,env}`、ps の cmdline 列、sh の
   `$VAR` 展開。

## 判断の記録

- **LF を値に付ける / 落とす**: Linux の `/proc/self/environ` は NUL
  区切りだが、MTOS には NUL を可視化する道具が無く、`cat` で読める
  ことを優先した。
- **close 時 commit**: write ごとに上書きすると `printf` 的な分割 write
  で値が欠ける。sh の `>` は子所有 fd を exit 時に close するので commit
  が確実に走る。
- **env 表は 1 kmalloc / 256 B 固定**: K16 (kernel arena fragmentation)
  の経験から、可変長の多数 kmalloc は避ける。満杯は loud に失敗させる。
- **libtc は文字列、数値化は呼び手**: env の値は文字列 (`TERM=lcd` の
  ように数値でないものもある)。libtc に int 版を置くと型ごとに API が
  増えるので、`env_get` / `env_set` + 汎用 `parse_dec` に留める。
- **sh builtin は機構ではなく UI**: `/proc/self/env/` だけで機能は
  完結させ、`setenv` / `getenv` / `env` は libtc を呼ぶだけの皮にする。
  テストは /proc 直叩きと builtin の両方を通す。
- **`self` 以外を書けるようにしない**: 他 task の env を書く用途が無く、
  読み取り専用に限れば `g_current` 以外の slot の同期を考えなくてよい。

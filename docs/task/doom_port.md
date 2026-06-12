# DOOM on TinyC-OS — K22 milestone plan

## Goal

shareware DOOM の **E1M1 "Hangar"** を、我々の TinyC-OS の guest task
として `/bin/gcc_doom /sd/doom1.wad` で起動して、Pico 2 + ILI9488
で遊べる状態に持っていく。

参考実装: kilograham/rp2040-doom (RP2040 ARM、264KB SRAM 用に WAD を
whd 形式に pre-compress した路線)。我々はそのテクを部分的に借りつつ、
ソースは doomgeneric ベースを GCC で RV32 にコンパイルする。

### Scope (絞り込み済み)

- shareware doom1.wad のうち **E1M1 のみ** 動けば OK (E1M2..E1M9 は
  scope 外、起動はしなくてよい)
- 音 (PWM / I2S) は無し
- save game は SD に書ければベター、無くてもよい
- ネットワークプレイ、cheat code は scope 外

### Out of scope

- フル DOOM (E1M1-M9 全部) — メモリで詰むので E1M1 で打ち止め
- DOOM II / Ultimate DOOM — shareware で固定
- 60fps — SPI 帯域上限で 15-20fps 想定、それで OK

## Constraints

### Memory budget

- RP2350 SRAM: 520 KB
- kernel arena が 504 KB のうち、kernel 自身 (console + sh + neofetch
  などの並走 task 含む) で **~120 KB** 使用
- DOOM task 1 個に出せる arena は **~380 KB**
- DOOM zone memory は vanilla で 3 MB 想定なので、whd 圧縮 + 必要 lump
  だけ on-demand 展開する rp2040-doom 路線が前提

### SPI 帯域

- ILI9488 は PIO2 SPI 18.75 MHz = 約 2.34 MB/s
- 320×200 RGB565 = 128 KB / frame
- 128 KB × 15 fps = 1.92 MB/s で帯域内、syscall overhead 込みで
  **12-15 fps** 想定

### CPU

- Hazard3 RISC-V @ 150 MHz, RV32IM (Zicsr, Zifencei あり、float なし)
- DOOM は fixed-point math なので float 不要
- rp2040-doom の ARM Cortex-M0+ asm hotpath (`R_DrawColumn` 系) は
  C 等価に落として RISC-V でコンパイル、性能は ARM 版より落ちる

## Phases

### Phase 0: GCC task 実行基盤 (3-5 日) ← K22 まずここ

GCC で compile した RV32 raw bin を我々の K3 task として spawn できる
道筋を作る。これ自体が再利用資産。

成果物 `compiler/runtime/mtos/`:

- **`gcc_crt0.s`** — GCC task 用 crt0
  - K3 header はファイル先頭に置かず、`task_crt0.s` と同じく Makefile
    側で `hdr.s` を prepend する形にする
  - `_start`: kernel から受け取った `gp = ram_base + 0x800` を信用、
    .data を binary から RAM へコピー、`__libc_init_array` を呼んだ後
    argv StringArray を unpack して `main(int argc, char **argv)` を
    呼ぶ
  - argv 変換: kernel が渡す `[len:u32][String*][String*]...` を
    null-terminated C 文字列の `char *argv[]` 配列に詰め直して a1 に
    渡す
  - 戻り値で `sys_exit(rc)`

- **`gcc_libc.c`** — newlib retarget 用 syscall stubs
  - `_open / _read / _write / _close / _lseek / _fstat / _isatty`
  - `_exit`, `_kill`, `_getpid` (kill/getpid は no-op で OK)
  - `_sbrk` — 我々の task arena から bump 割り当て
  - 他: gettimeofday は `do_uptime_us()`、それ以外は ENOSYS

- **`gcc_task.ld`** — linker script
  - `.text → .rodata → .data → .bss`、`__global_pointer$ = __data_start + 0x800`
  - text base は 0、relocation は PC-rel + gp-rel のみで absolute なし
  - `__bss_start`/`__bss_end`/`__data_start`/`__data_end` symbol 公開
  - 既存 `task_crt0.s` の data 配置と互換 (kernel が gp の値を計算する
    ロジックは TC task と共通)

- **Makefile rule** — `userland/gcc-bin/<name>/<name>.c` (専用ディレクトリ
  を切る) → `userland/build/tasks/<name>.bin`
  - `riscv32-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -Os -ffunction-sections -fdata-sections`
  - `ld -T gcc_task.ld --gc-sections crt0.o libc.a <task>.o -o <task>.elf`
  - `objcopy -O binary <task>.elf <task>.bin`
  - 最後に K3 header (arena, stack を `.word` で 8 byte) を prepend
  - 既存 `task.mk` 仕組み (`GUEST_TASKS += <name>`, `TASK_ARENA_<name>`)
    との互換は保つ — Makefile 側で gcc-bin/ ディレクトリも GUEST_TASKS
    として認識する分岐を追加

- **Smoke test** — `userland/gcc-bin/gcc_hello/gcc_hello.c`
  - `#include <stdio.h>` で `printf("hello from gcc\n")`
  - `make -C userland test-quick` でビルドできて、qemu virt 上で
    `sh$ gcc_hello` で hello が出れば Phase 0 PASS

### Phase 0.5: load-time relocation で globals を解錠 (3-5 日)

Phase 0 commit `e371610` で「globals を持たない」GCC task は動いたが、
.data / .bss を持つ task (= doomgeneric 含む実用 task 全部) はまだ
動かない。理由は GCC が生成する globals アクセスのアドレッシングと、
我々の task ABI の RAM レイアウトが整合しないこと:

- **-fPIE + linker --no-relax**: .rodata は auipc + addi で PC-rel
  に解決され ✓ (これが Phase 0 で string literal が動く理由)、しかし
  .data / .bss も同じ仕組みで PC-rel になり、起動時に
  「runtime_text_base + VMA_offset」を計算してしまう。我々の RAM は
  flash に隣接しているわけではなく、kernel が別途 ram_base に
  allocate するため、ストアが flash 領域に向かってトラップ。
- **-fPIE + relax 有効**: linker が PC-rel pair を絶対 `li` や
  `sw rd, off(zero)` に畳む。今度は .rodata 参照も絶対化されて
  link-time VMA を baked-in した bin が出来上がり、結局 task が
  別アドレスに load された瞬間にデタラメな pointer を読みに行く。
- **-msmall-data-limit + gp-relative relax**: `__global_pointer$`
  を PROVIDE しても linker が pickup せず、small globals は
  zero-base 相対 (`sw rd, off(zero)`) に落ちる。

正攻法は **load-time relocation**:

1. `--emit-relocs` で ELF を吐き、`R_RISCV_RELATIVE` 等の relocation
   表を保持したまま objcopy で raw bin にする (relocs を末尾の
   独立セクションに dump)
2. K3 header を `arena | stack | reloc_off | reloc_count` の 16 byte
   に拡張し、bin 末尾の reloc 表へのオフセットを格納
3. kernel/loader.tc::load_fd で K3 header を読んだ後、reloc 表を
   走査して `*addr += task_load_base` でアドレスを fix-up
4. これで -fno-pic / -fPIC 関係なく、絶対参照を含むコードが任意の
   runtime address で動く
5. gcc_crt0 は .data copy + .bss zero + heap init + argv unpack を
   フル実装してよくなる

成果物:

- `kernel/src/loader.tc` の K3 header parsing 拡張と reloc 適用ループ
- `compiler/runtime/mtos/gcc_crt0.s` をフル版に戻す
- `compiler/runtime/mtos/gcc_libc.c` の `_libc_init_heap` /
  `_libc_unpack_argv` 経路の smoke test (printf, malloc 含む)
- `userland/gcc-bin/gcc_globals_smoke/` で globals + heap を実際に
  使う smoke task を追加 (`make test` 組み込み)

Phase 1 着手前にここを通すことで、doomgeneric の 50K LOC を素直に
GCC に通す道が拓ける。

### Phase 1: doomgeneric vendor + ホスト層 (1-2 日)

- `userland/gcc-bin/gcc_doom/doomgeneric/` に doomgeneric を vendor in
  (submodule か git subtree か copy)
- `doomgeneric_tcos.c` を新規作成、`DG_*` を埋める:
  - `DG_Init` — `/dev/fb` と `/dev/kbd` を open
  - `DG_DrawFrame` — Phase 2 で実装
  - `DG_GetKey` — Phase 3 で実装
  - `DG_GetTicksMs` — `do_uptime_us() / 1000`
  - `DG_SleepMs` — `do_nanosleep(ms)`
  - `DG_SetWindowTitle` — no-op

### Phase 2: video driver (3-5 日)

- `DG_DrawFrame` で 320×200 ARGB8888 buffer (doomgeneric の native
  format) を 320×200 RGB565 に変換
- 帯 (320 × 8 RGB565 = 5120 byte) ごとに 1 syscall:
  ```
  sys_write(fb, mode0_header(x=80, y=60, w=320, h=8, mode=0), 5130);
  ```
  x=80, y=60 で 480×320 panel の中央寄せ letterbox
- 25 帯 / frame で 1 frame 完了
- 帯域試算: 5130 × 25 × 15 fps = 1.92 MB/s ≤ 2.34 MB/s OK
- 黒帯部分は初回起動時に mode=1 で塗り潰し、以降は触らない

### Phase 3: input (2-3 日)

- `/dev/kbd` を opening して non-blocking poll
- doomgeneric の key code への変換テーブル:
  | 物理 | DOOM |
  |---|---|
  | W / 上 | KEY_UPARROW |
  | S / 下 | KEY_DOWNARROW |
  | A | KEY_STRAFE_L |
  | D | KEY_STRAFE_R |
  | ←→ | KEY_LEFTARROW / KEY_RIGHTARROW |
  | Space | KEY_FIRE |
  | E / Enter | KEY_USE |
  | Shift | KEY_RSHIFT (走る) |
  | ESC | KEY_ESCAPE |
  | 1-7 | weapon select |
- qemu virt では `/dev/kbd` が UART RX stub なので、`make -C kernel run`
  でホスト PC キーボードからそのままテスト可

### Phase 4: WAD on SD (3-5 日)

- doomgeneric の `Wad I/O` は `fopen/fread/fseek` ベース
- libc shim の `_open/_read/_lseek` を経由して `do_openat("/sd/doom1.wad")`
  → fatfs 経由で読む
- 起動コマンド: `/bin/gcc_doom /sd/doom1.wad` (or `/sd/doom.whd` if Phase 5
  で whd 化)
- shareware doom1.wad (~4 MB) を SD root に置く運用、git には commit
  しない (`.gitignore` 既出)

### Phase 5: メモリ調整 — E1M1 削り込み (1-2 週間、ここが山場)

doomgeneric の zone memory は 380 KB に絶対収まらない。やること:

- **whd への WAD 変換**: rp2040-doom の `whx_extract` を host で動かして
  shareware doom1.wad → doom1.whd (~1.5 MB に圧縮) を生成
- **doomgeneric の WAD layer を whd 対応化**: lump 読み出しを whd の
  on-demand decompression に差し替え
- **E1M1 以外のレベルデータを切る**: WAD の lump dictionary を編集
  して E1M1 と必要 sprite だけ残す。doom1_e1m1.whd を別途生成
- **rp2040-doom の RAM allocator を借りる**: zone memory 全部 RAM に
  載せるのは諦め、cluster 単位で SD から streaming + cache
- **scope 縮退ライン**: もしこれでも詰むなら DEMO1 自動デモループだけ
  動かす (interactive プレイ無し)

### Phase 6: 仕上げ (1-2 週間)

- FPS 計測、ボトルネック特定 (`R_DrawColumn` vs SPI 転送 vs syscall)
- save game を `/sd/doom.sav` に
- 起動 fixture: `kernel/tests/fixtures/kern_doom.conf` で
  `init=/bin/gcc_doom /sd/doom1.whd`
- `pico2-doom` UF2 variant を `kernel/Makefile` に追加 (`DROP_TASKS` で
  console/sh を残す or 専用 disk variant)
- `docs/task/doom_port.md` 更新 + `docs/solved.md` に K22 として記録

## 想定工数

- Phase 0-4 (順調): **3-4 週間**
- Phase 5 (山場): **+2-3 週間**
- 想定 total: **4-7 週間**

## Risk register

| Risk | Likelihood | Mitigation |
|---|---|---|
| zone memory が 380KB に絶対入らない | 高 | Phase 5 で whd + E1M1-only WAD、ダメなら DEMO1 のみ |
| SPI 帯域不足で fps 1 桁台 | 中 | mode-0 帯転送を band sleep で前後分けて double buffer、もしくは画面下部 (HUD) を毎フレ更新せず dirty rect 化 |
| GCC libc shim の sbrk が arena を食い尽くす | 中 | task.mk で TASK_ARENA を限界まで上げる (現 32-256 KB ぐらいの想定) |
| RV32 でも fixed-point math が遅すぎて E1M1 で 5fps 切る | 中 | Phase 6 で hot path 個別最適化、最悪は 256×160 など解像度落とす |
| K3 header 仕様変更で gcc_crt0 と既存 task_crt0 が乖離 | 低 | crt0 共通テストを test_os.sh に追加 |

## 次の一手

Phase 0-1 を進める前に、まず Phase 0 の最小 PoC を作る:

1. `compiler/runtime/mtos/gcc_crt0.s` 雛形を書く
2. `compiler/runtime/mtos/gcc_libc.c` の minimal stub を書く
3. `compiler/runtime/mtos/gcc_task.ld` を書く
4. `userland/gcc-bin/gcc_hello/gcc_hello.c` を書く
5. `userland/Makefile` に gcc-bin/ ディレクトリの build rule を生やす
6. qemu virt で `sh$ gcc_hello` が "hello from gcc" を出す

ここまで通ったら Phase 1 (doomgeneric vendor in) へ。

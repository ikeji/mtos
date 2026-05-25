# integration/

3 サブプロジェクト (compiler + userland + kernel) をまたぐテスト。
`make test` には含めず、`make full-test` か手動で実行する。

## スクリプト

| ファイル | 説明 | 実行環境 |
|---|---|---|
| `test_phase7.sh` | コンパイラ全段を userland として実機 OS 上で実行 | qemu virt |
| `pico2_self_replicate.sh` | pico2 上で kernel + 全コンパイラを実機再生成し host gen2 と md5 一致を検証 | 実機 (Debug Probe + openocd) |
| `pico2_verify.sh` | pico2 実機で compile 7 段の byte-exact 検証 | 実機 |
| `pico2_test_compile_parse.sh` | parse.bin 単体実機検証 | 実機 |
| `phase3_verify.py` | virt 上で 9 段全部走らせて byte-exact 検証 | qemu virt |
| `qemu_mr_scale.py` | K11 (mr UART hang) 再現 | qemu virt |
| `pico2_drive.py` / `pico2_hw_driver.py` / `pico2_k11_reproduce.py` / `pico2_pipeline_drive.py` / `pico2_tty.py` / `pico2_upload.py` | pico2 UART driver / utility | 実機 |
| `uart_demux.py` | UART mux frame parser | (utility) |

## inputs/

| ファイル | 説明 |
|---|---|
| `phase7_hello.tc` | parse 入力: `fn main() -> i32 { return 42; }` |
| `phase7_min.tc` | parse 段階的縮小用の最小入力 |
| `phase7_hello_world.tc` | Hello World ソース (M6 のゴール) |

## fixtures/

`pico2_self_step{1,2,3,4}.sh`、`pico2_compile_*.sh` (asm_pass1/2/3, bc2asm,
codegen, compilers, kern{,2}, libtc, parse, platform, runtime, sb, sigscan,
tcheck)、`pico2_dumper_test.sh`、`pico2_dir_grow_test{,2}.sh`、
`pico2_md5_test.sh`、`pico2_ls_sd.sh`、`pico2_run_{parse,sb}.sh`、
`pico2_cleanup_sd.sh`、`pico2_bench_idx.sh`、`calib.sh` 等。

## 実行例

```bash
# integration の自動可能部分 (qemu virt のみ)
make full-test
# または個別:
GEN2_DIR=$(pwd)/compiler/build/gen2 ./integration/test_phase7.sh
python3 integration/phase3_verify.py
python3 integration/qemu_mr_scale.py

# 実機が必要なもの (Debug Probe + openocd-rpi が前提)
GEN2_DIR=$(pwd)/compiler/build/gen2 ./integration/pico2_self_replicate.sh
```

詳細設計は `../docs/task/subproject_split.md`。

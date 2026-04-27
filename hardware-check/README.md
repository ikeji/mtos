# hardware-check — 既知良の参照実装

我々の TC self-hosted コンパイラ / kernel / 自作 SPI ドライバが
バグっている可能性を切り分けるため、**pico-sdk (ARM Cortex-M33)**
で書いた最小限のリファレンス実装を置く。

ハードウェアテスト目的なので CPU 種別 (ARM vs RISC-V) は問題ではない:
SPI ペリフェラル / GPIO / UART は同じシリコン。pico-sdk の公式 API で
動かなければ、それは 100% ハード側の問題。

## ビルド

```bash
PICO_SDK_PATH=$HOME/tmp/pico-sdk ./hardware-check/build.sh
# → hardware-check/build/sd_probe.uf2
```

要件: `arm-none-eabi-gcc`, `cmake`, `make`, pico-sdk 2.x。

## flash & 実行

```bash
# Pico 2 が既に RISC-V kernel を実行中なら、まず ARM 用 IMAGE_DEF
# を含むこの bin を flash する (RISC-V config で halt → program → reset)。
~/opt/openocd-rpi/bin/openocd \
    -s ~/opt/openocd-rpi/share/openocd/scripts \
    -f interface/cmsis-dap.cfg -f target/rp2350-riscv.cfg \
    -c "adapter speed 5000" -c "init" -c "reset halt" \
    -c "program hardware-check/build/sd_probe.bin 0x10000000 verify" \
    -c "exit"

# その後、USB を抜き差しして CPU を ARM モードでブート (新しい
# IMAGE_DEF が ARM-S を要求するのでそうなる)。
# 以降、reset するなら ARM target config で:
~/opt/openocd-rpi/bin/openocd \
    -s ~/opt/openocd-rpi/share/openocd/scripts \
    -f interface/cmsis-dap.cfg -f target/rp2350.cfg \
    -c "adapter speed 5000" -c "init" -c "reset run" -c "exit"

# UART キャプチャ
stty -F /dev/ttyACM0 115200 cs8 -cstopb -parenb raw -echo -crtscts
cat /dev/ttyACM0
```

ARM 動作後に RISC-V kernel に戻すには `make run-pico2` を実行
(再 flash + USB 抜き差し)。

## 出力例 (健康な SDHC カード)

```
=== sd_probe (pico-sdk reference) ===
clk_sys = 150000000 Hz
clk_peri = 150000000 Hz
SPI0 actual = 398936 Hz
CMD0[0] R1 = 0x01
CMD8 R1 = 0x01 echo = 00 00 01 AA
OK: v2 SDHC card, ready for ACMD41
ACMD41 init loop:
  iter 0: CMD55 R1=0x01  ACMD41 R1=0x01
  iter 1: CMD55 R1=0x01  ACMD41 R1=0x01
  ...
OK: card initialized after N iterations
```

## 配線

`docs/pico2_hardware.md` の SD カード節と同じ:
- GP4 (Pin 6) → MISO
- GP5 (Pin 7) → CS
- GP6 (Pin 9) → SCK
- GP7 (Pin 10) → MOSI
- 3V3 (Pin 36) → モジュール 3V3
- GND → GND

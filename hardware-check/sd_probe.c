// sd_probe.c — pico-sdk reference + extensive bit-bang diagnostics.
//
// Goal: figure out why the SD card on the Catalex-style module never
// returns a valid response, even though the same card is recognized
// by a PC. We try the official SPI peripheral path AND a hand-rolled
// bit-bang in all four SPI modes, while checking line states with
// internal pulls disabled / PUE / PDE.

#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/spi.h"
#include "hardware/gpio.h"
#include "hardware/clocks.h"
#include "hardware/structs/sio.h"
#include "hardware/structs/pads_bank0.h"

#define PIN_MISO 4
#define PIN_CS   5
#define PIN_SCK  6
#define PIN_MOSI 7

static void delay_us_busy(int us) {
    busy_wait_us_32(us);
}

static int gpio_in(int pin) { return (sio_hw->gpio_in >> pin) & 1; }

static void show_pad_state(const char *label) {
    printf("%s: GP4=%d GP5=%d GP6=%d GP7=%d\n", label,
           gpio_in(4), gpio_in(5), gpio_in(6), gpio_in(7));
}

static void all_in_no_pull(void) {
    for (int p = 4; p <= 7; p++) {
        gpio_set_function(p, GPIO_FUNC_SIO);
        gpio_set_dir(p, GPIO_IN);
        gpio_disable_pulls(p);
    }
    delay_us_busy(50);
}
static void all_in_pue(void) {
    for (int p = 4; p <= 7; p++) {
        gpio_set_function(p, GPIO_FUNC_SIO);
        gpio_set_dir(p, GPIO_IN);
        gpio_pull_up(p);
    }
    delay_us_busy(200);
}
static void all_in_pde(void) {
    for (int p = 4; p <= 7; p++) {
        gpio_set_function(p, GPIO_FUNC_SIO);
        gpio_set_dir(p, GPIO_IN);
        gpio_pull_down(p);
    }
    delay_us_busy(200);
}

// ---- Bit-bang SPI ----
static int g_cpol = 0;
static int g_cpha = 0;
static int g_half_us = 5;  // half clock period

static void bb_setup(int cpol, int cpha, int half_us) {
    g_cpol = cpol;
    g_cpha = cpha;
    g_half_us = half_us;
    for (int p = 4; p <= 7; p++) {
        gpio_set_function(p, GPIO_FUNC_SIO);
        gpio_disable_pulls(p);
    }
    gpio_set_dir(PIN_MISO, GPIO_IN);
    gpio_pull_up(PIN_MISO);          // help MISO read clean 1 when card HiZ

    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_set_dir(PIN_SCK, GPIO_OUT);
    gpio_set_dir(PIN_MOSI, GPIO_OUT);

    gpio_put(PIN_CS, 1);
    gpio_put(PIN_SCK, cpol);
    gpio_put(PIN_MOSI, 1);
}

// Mode 0/3: sample on first edge after activation (cpol XOR cpha == cpol)
// Mode 1/2: sample on second edge.
// To keep things simple use SD-typical mode 0 first, then iterate.
static uint8_t bb_xfer(uint8_t out) {
    uint8_t in = 0;
    for (int b = 7; b >= 0; b--) {
        // setup MOSI on inactive edge
        gpio_put(PIN_MOSI, (out >> b) & 1);
        delay_us_busy(g_half_us);
        // active edge (sample)
        gpio_put(PIN_SCK, !g_cpol);
        // for cpha=0 sample now (data setup before this edge)
        if (g_cpha == 0) {
            int bit = gpio_in(PIN_MISO);
            in = (in << 1) | bit;
            delay_us_busy(g_half_us);
        } else {
            delay_us_busy(g_half_us);
        }
        // inactive edge
        gpio_put(PIN_SCK, g_cpol);
        if (g_cpha == 1) {
            int bit = gpio_in(PIN_MISO);
            in = (in << 1) | bit;
            delay_us_busy(g_half_us);
        }
    }
    return in;
}

static uint8_t bb_send_cmd(uint8_t cmd, uint32_t arg, uint8_t crc) {
    gpio_put(PIN_CS, 0);
    bb_xfer(0xFF);
    bb_xfer(0x40 | cmd);
    bb_xfer((arg >> 24) & 0xFF);
    bb_xfer((arg >> 16) & 0xFF);
    bb_xfer((arg >>  8) & 0xFF);
    bb_xfer( arg        & 0xFF);
    bb_xfer(crc);
    uint8_t r1 = 0xFF;
    for (int i = 0; i < 16; i++) {
        r1 = bb_xfer(0xFF);
        if ((r1 & 0x80) == 0) break;
    }
    return r1;
}

static void bb_finish(void) {
    gpio_put(PIN_CS, 1);
    bb_xfer(0xFF);
}

static int try_cmd0_mode(int cpol, int cpha) {
    printf("\n-- Bit-bang SPI mode %d%d --\n", cpol, cpha);
    bb_setup(cpol, cpha, 10);
    // 200 init clocks with CS=H, MOSI=H
    gpio_put(PIN_CS, 1);
    for (int i = 0; i < 200; i++) bb_xfer(0xFF);
    int got = -1;
    for (int attempt = 0; attempt < 5; attempt++) {
        uint8_t r1 = bb_send_cmd(0, 0, 0x95);
        bb_finish();
        printf("  attempt %d: R1 = 0x%02X\n", attempt, r1);
        if (r1 == 0x01) { got = 0x01; break; }
        if (r1 != 0xFF && r1 != 0x00) { got = r1; }
        delay_us_busy(2000);
    }
    return got;
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("\n=== sd_probe v2 (pico-sdk + bit-bang diagnostics) ===\n");
    printf("clk_sys=%u clk_peri=%u\n", clock_get_hz(clk_sys), clock_get_hz(clk_peri));

    // ---- Static line probe ----
    all_in_no_pull();
    show_pad_state("no-pull ");
    all_in_pue();
    show_pad_state("PUE     ");
    all_in_pde();
    show_pad_state("PDE     ");

    // Drive each output, read it back via GPIO_IN
    all_in_no_pull();
    for (int p = 5; p <= 7; p++) {
        gpio_set_dir(p, GPIO_OUT);
        gpio_put(p, 0);
        delay_us_busy(50);
        int lo = gpio_in(p);
        gpio_put(p, 1);
        delay_us_busy(50);
        int hi = gpio_in(p);
        gpio_set_dir(p, GPIO_IN);
        printf("drive GP%d: lo->%d hi->%d\n", p, lo, hi);
    }

    // ---- Crosstalk: drive MOSI low, watch MISO ----
    // If MOSI and MISO share a wire (breadboard short), MISO will
    // follow MOSI. Otherwise MISO stays at its idle level.
    all_in_no_pull();
    gpio_set_dir(PIN_MOSI, GPIO_OUT);
    gpio_put(PIN_MOSI, 0);
    delay_us_busy(200);
    int miso_when_mosi_lo = gpio_in(PIN_MISO);
    gpio_put(PIN_MOSI, 1);
    delay_us_busy(200);
    int miso_when_mosi_hi = gpio_in(PIN_MISO);
    gpio_set_dir(PIN_MOSI, GPIO_IN);
    printf("crosstalk MOSI->MISO: lo=%d hi=%d (independent if both same)\n",
           miso_when_mosi_lo, miso_when_mosi_hi);

    // Same test: drive SCK, watch MISO
    gpio_set_dir(PIN_SCK, GPIO_OUT);
    gpio_put(PIN_SCK, 0);
    delay_us_busy(200);
    int miso_sck_lo = gpio_in(PIN_MISO);
    gpio_put(PIN_SCK, 1);
    delay_us_busy(200);
    int miso_sck_hi = gpio_in(PIN_MISO);
    gpio_set_dir(PIN_SCK, GPIO_IN);
    printf("crosstalk SCK->MISO: lo=%d hi=%d\n", miso_sck_lo, miso_sck_hi);

    // Same: drive CS, watch MISO. With CS low SD card may release
    // its pull-up on DAT3 — the change of MISO with CS movement
    // tells us if the card is alive.
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS, 1);
    delay_us_busy(2000);
    int miso_cs_hi = gpio_in(PIN_MISO);
    gpio_put(PIN_CS, 0);
    delay_us_busy(2000);
    int miso_cs_lo = gpio_in(PIN_MISO);
    gpio_put(PIN_CS, 1);
    gpio_set_dir(PIN_CS, GPIO_IN);
    printf("CS hi->MISO=%d, CS lo->MISO=%d (no-pull, watching card)\n",
           miso_cs_hi, miso_cs_lo);

    // ---- SPI peripheral path with internal MISO pull-up ----
    printf("\n-- SPI peripheral, mode 0, 400 kHz, MISO PUE on --\n");
    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS, 1);
    spi_init(spi0, 400 * 1000);
    spi_set_format(spi0, 8, SPI_CPOL_0, SPI_CPHA_0, SPI_MSB_FIRST);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK,  GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);
    gpio_pull_up(PIN_MISO);

    // 200 init clocks
    uint8_t hi[10]; for (int i=0; i<10; i++) hi[i] = 0xFF;
    gpio_put(PIN_CS, 1);
    for (int i = 0; i < 20; i++) spi_write_blocking(spi0, hi, sizeof(hi));

    for (int attempt = 0; attempt < 5; attempt++) {
        gpio_put(PIN_CS, 0);
        uint8_t cmd[] = {0xFF, 0x40, 0, 0, 0, 0, 0x95};
        spi_write_blocking(spi0, cmd, sizeof(cmd));
        uint8_t r1 = 0xFF;
        uint8_t buf[16];
        for (int i = 0; i < 16; i++) buf[i] = 0xFF;
        spi_write_read_blocking(spi0, buf, buf, 16);
        printf("  HW mode0 attempt %d  bytes:", attempt);
        for (int i = 0; i < 16; i++) printf(" %02X", buf[i]);
        for (int i = 0; i < 16; i++) {
            if ((buf[i] & 0x80) == 0) { r1 = buf[i]; break; }
        }
        printf("  R1=0x%02X\n", r1);
        gpio_put(PIN_CS, 1);
        spi_write_blocking(spi0, hi, 1);
        if (r1 == 0x01) break;
        sleep_ms(2);
    }

    // ---- Aggressive recovery sequence ----
    // Some cards lock up if SPI mode isn't entered correctly. Try:
    //   1. Hold CS low for 1s while clocking (forces SD-mode card to
    //      see CS as DAT3 = 0, helps SPI-mode entry detection).
    //   2. Send 10000 init clocks with CS high.
    //   3. Then CMD0.
    printf("\n-- Aggressive recovery --\n");
    bb_setup(0, 0, 5);  // 100 kHz-ish bit-bang
    gpio_put(PIN_CS, 0);
    for (int i = 0; i < 100; i++) bb_xfer(0xFF);  // 800 clocks at CS=L
    gpio_put(PIN_CS, 1);
    delay_us_busy(1000);
    for (int i = 0; i < 1250; i++) bb_xfer(0xFF); // 10000 init clocks at CS=H
    uint8_t r1 = 0xFF;
    for (int attempt = 0; attempt < 8; attempt++) {
        uint8_t got = bb_send_cmd(0, 0, 0x95);
        bb_finish();
        printf("  recovery attempt %d: R1=0x%02X\n", attempt, got);
        if (got == 0x01) { r1 = got; break; }
        delay_us_busy(5000);
    }

    // ---- Bit-bang in all four modes ----
    int best = -1;
    if (r1 == 0x01) best = 0;
    else {
        for (int cpol = 0; cpol <= 1; cpol++) {
            for (int cpha = 0; cpha <= 1; cpha++) {
                int r = try_cmd0_mode(cpol, cpha);
                if (r == 0x01) { best = (cpol<<1)|cpha; break; }
            }
            if (best >= 0) break;
        }
    }

    if (best >= 0) {
        printf("\nSUCCESS: card responded 0x01 in mode %d\n", best);
    } else {
        printf("\nNo CMD0 mode worked. Suspect: PCB trace break inside\n");
        printf("module or SD socket contact failure (card itself works on PC).\n");
    }

    while (1) tight_loop_contents();
}

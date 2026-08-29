// soc.v — rv32_core + bus decode + RAM + UART + CLINT + exit device.
//
// Memory map mirrors qemu virt so the MTOS kernel's virt platform code
// (kernel/src/kernel.tc CLINT, platform_virt.tc UART) runs unchanged:
//   0x0010_0000  exit/LED   (SiFive test: 0x5555 = pass, 0x3333|code<<16 = fail)
//   0x0010_0004  BOOT_UART_WAIT (read-only; boot ROM's UART-vs-flash timeout)
//   0x0200_0000  CLINT      (+0x4000 mtimecmp lo/hi, +0xBFF8 mtime lo/hi)
//   0x1000_0000  UART       (+0 DR, +5 LSR: bit0 RX ready, bit5/6 TX empty)
//   0xD000_0000  GPIO       (RP2350 SIO register layout, 48 pins; gpio_sio.v)
//   0x1002_0000  flash SPI + DMA (boot flash: +0 DATA +4 STATUS +8 CTRL, +10.. DMA; flash_dma.v)
//   0x1003_0000  SPI master 1 (microSD, same registers)
//   0x8000_0000  RAM        (SDRAM 8 MB when USE_SDRAM, else BSRAM RAM_WORDS*4)
//   0x0000_0000  boot ROM   (BSRAM ROM_WORDS*4, init from ROM_INIT; RESET_PC=0
//                            boots from it, RESET_PC=0x8000_0000 bypasses it)
//
// A UART DR write stalls the bus until the transmitter is free, so
// software may write without polling (qemu behaviour).
module soc #(
    parameter integer RAM_WORDS = 2*1024*1024,   // 8 MB (BSRAM mode only)
    parameter integer CLK_HZ    = 27_000_000,
    parameter integer BAUD      = 115_200,
    parameter         RAM_INIT  = "",            // $readmemh base name (BSRAM mode)
    parameter integer USE_SDRAM = 0,
    parameter integer USE_CACHE = 1,             // sdram_cache in front of the SDRAM
    parameter integer SDRAM_ZERO_WORDS = 2*1024*1024, // words zero-filled by the SDRAM controller after init (sim: shrink)
    parameter integer ROM_WORDS = 2048,          // 8 KB boot ROM
    parameter         ROM_INIT  = "",
    parameter [31:0]  RESET_PC  = 32'h8000_0000,
    parameter [31:0]  BOOT_UART_WAIT = 32'd27_000_000   // boot ROM: mtime ticks to wait for a UART frame before trying the SPI flash
) (
    input  wire        clk,
    input  wire        rst,
    input  wire        uart_rx,
    output wire        uart_tx,
    // SDRAM pins (unused when USE_SDRAM = 0)
    output wire        sdram_clk, sdram_cke, sdram_cs_n, sdram_ras_n, sdram_cas_n, sdram_we_n,
    output wire [10:0] sdram_addr,
    output wire [1:0]  sdram_ba,
    output wire [3:0]  sdram_dqm,
    inout  wire [31:0] sdram_dq,
    // GPIO (SIO-compatible, 48 pins; the board top wires a subset to pads)
    output wire [47:0] gpio_out,
    output wire [47:0] gpio_oe,
    input  wire [47:0] gpio_in,
    // SPI master 0 (config flash) / 1 (microSD)
    output wire        spi_sck, spi_cs_n, spi_mosi,
    input  wire        spi_miso,
    output wire        sd_sck, sd_cs_n, sd_mosi,
    input  wire        sd_miso,
    output reg  [31:0] exit_code,     // last write to the exit device
    output reg         exit_valid,    // pulses on that write
    output wire [31:0] dbg_pc,
    output wire [31:0] dbg_instr,
    output wire [2:0]  dbg_state,
    output wire [31:0] dbg_addr,
    output wire [7:0]  dbg_txcnt,
    output wire        dbg_txbusy
);
    wire        mem_valid;
    reg         mem_ready;
    wire [31:0] mem_addr, mem_wdata;
    wire [3:0]  mem_wstrb;
    reg  [31:0] mem_rdata;
    reg  [63:0] mtime;
    reg  [63:0] mtimecmp;
    wire        timer_irq = (mtime >= mtimecmp);

    rv32_core #(.RESET_PC(RESET_PC)) cpu (
        .clk(clk), .rst(rst),
        .mem_valid(mem_valid), .mem_ready(mem_ready), .mem_addr(mem_addr),
        .mem_wdata(mem_wdata), .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata),
        .timer_irq(timer_irq), .mtime(mtime), .dbg_pc(dbg_pc), .dbg_instr(dbg_instr), .dbg_state(dbg_state));
    assign dbg_addr = mem_addr;

    // ---- address decode ----
    wire sel_ram   = (mem_addr[31:28] == 4'h8);
    wire sel_rom   = (mem_addr[31:16] == 16'h0000);
    wire sel_gpio  = (mem_addr[31:16] == 16'hD000);
    wire sel_spi   = (mem_addr[31:16] == 16'h1002);
    wire sel_spi1  = (mem_addr[31:16] == 16'h1003);
    wire sel_uart  = (mem_addr[31:16] == 16'h1000);
    wire sel_clint = (mem_addr[31:16] == 16'h0200);
    wire sel_exit  = (mem_addr[31:16] == 16'h0010);
    wire is_write  = (mem_wstrb != 4'b0);

    // ---- boot ROM (BSRAM, writable so the loader can use it as RAM too) ----
    localparam integer ROM_AW = $clog2(ROM_WORDS);
    wire [31:0] rom_q;
    ram32 #(.WORDS(ROM_WORDS), .INIT(ROM_INIT)) rom (
        .clk(clk), .addr(mem_addr[ROM_AW+1:2]), .wdata(mem_wdata),
        .we(mem_wstrb & {4{mem_valid && sel_rom}}), .rdata(rom_q));

    // flash DMA → SDRAM port (declared here: used inside the RAM generate below)
    wire        dma_valid, dma_ready, dma_active, dma_done; wire [31:0] dma_addr, dma_wdata;
    wire        cache_flushing;

    // ---- main RAM: SDRAM or BSRAM (synchronous, 1-cycle; see ram32.v) ----
    wire [31:0] ram_q;
    wire        sd_ready, sd_init_done;
    wire        sd_valid;   // held while the access is in flight (refresh may delay acceptance)
    generate if (USE_SDRAM) begin : g_sdram
        // 8 KB direct-mapped write-through cache in front of the SDRAM (USE_CACHE=0 bypasses it)
        wire c_valid, c_ready; wire [20:0] c_addr; wire [31:0] c_wdata, c_rdata; wire [3:0] c_wstrb;
        if (USE_CACHE) begin : g_cache
            sdram_cache #(.LINES(2048)) cache (
                .clk(clk), .rst(rst), .inval(dma_done), .flushing(cache_flushing),
                .valid(sd_valid), .ready(sd_ready),
                .addr(mem_addr[22:2]), .wdata(mem_wdata), .wstrb(mem_wstrb), .rdata(ram_q),
                .m_valid(c_valid), .m_ready(c_ready), .m_addr(c_addr), .m_wdata(c_wdata), .m_wstrb(c_wstrb), .m_rdata(c_rdata));
        end else begin : g_nocache
            assign c_valid = sd_valid; assign sd_ready = c_ready; assign c_addr = mem_addr[22:2];
            assign c_wdata = mem_wdata; assign c_wstrb = mem_wstrb; assign ram_q = c_rdata;
            assign cache_flushing = 1'b0;
        end
        // arbiter: the DMA owns the SDRAM port while active (the CPU runs from the boot ROM then)
        wire        a_valid = dma_active ? dma_valid : c_valid;
        wire [20:0] a_addr  = dma_active ? dma_addr[22:2] : c_addr;
        wire [31:0] a_wdata = dma_active ? dma_wdata : c_wdata;
        wire [3:0]  a_wstrb = dma_active ? 4'hF : c_wstrb;
        wire        a_ready;
        assign c_ready   = a_ready & ~dma_active;
        assign dma_ready = a_ready &  dma_active;
        sdram_ctrl #(.CLK_HZ(CLK_HZ), .ZERO_WORDS(SDRAM_ZERO_WORDS)) sd (
            .clk(clk), .rst(rst), .valid(a_valid), .ready(a_ready),
            .addr(a_addr), .wdata(a_wdata), .wstrb(a_wstrb), .rdata(c_rdata), .init_done(sd_init_done),
            .sdram_clk(sdram_clk), .sdram_cke(sdram_cke), .sdram_cs_n(sdram_cs_n), .sdram_ras_n(sdram_ras_n),
            .sdram_cas_n(sdram_cas_n), .sdram_we_n(sdram_we_n), .sdram_addr(sdram_addr), .sdram_ba(sdram_ba),
            .sdram_dqm(sdram_dqm), .sdram_dq(sdram_dq));
    end else begin : g_bsram
        localparam integer AW = $clog2(RAM_WORDS);
        ram32 #(.WORDS(RAM_WORDS), .INIT(RAM_INIT)) ram (
            .clk(clk), .addr(mem_addr[AW+1:2]), .wdata(mem_wdata),
            .we(mem_wstrb & {4{mem_valid && sel_ram}}), .rdata(ram_q));
        assign sd_ready = 1'b0; assign sd_init_done = 1'b1; assign dma_ready = 1'b0; assign cache_flushing = 1'b0;
        assign sdram_clk = 1'b0; assign sdram_cke = 1'b0; assign sdram_cs_n = 1'b1; assign sdram_ras_n = 1'b1;
        assign sdram_cas_n = 1'b1; assign sdram_we_n = 1'b1; assign sdram_addr = 11'b0; assign sdram_ba = 2'b0; assign sdram_dqm = 4'hF;
    end endgenerate

    // ---- UART ----
    wire [7:0] rx_data; wire rx_valid;
    uart_rx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) urx (.clk(clk), .rst(rst), .rx(uart_rx), .data(rx_data), .valid(rx_valid));
    reg  [7:0] tx_data; reg tx_valid; wire tx_busy;
    uart_tx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) utx (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(uart_tx));
    // 64-byte RX FIFO (the kernel drains it from the 1 ms timer tick)
    reg [7:0] rxf [0:63];
    reg [5:0] rx_wp, rx_rp;
    wire rx_empty = (rx_wp == rx_rp);
    always @(posedge clk) begin
        if (rst) rx_wp <= 0;
        else if (rx_valid) begin rxf[rx_wp] <= rx_data; rx_wp <= rx_wp + 1'b1; end
    end
    wire [7:0] uart_lsr = {1'b0, ~tx_busy, ~tx_busy, 4'b0, ~rx_empty};
    reg [7:0] txcnt; always @(posedge clk) if (rst) txcnt <= 0; else if (tx_valid) txcnt <= txcnt + 1'b1;
    assign dbg_txcnt = txcnt; assign dbg_txbusy = tx_busy;   // for top_socdbg

    // ---- bus response ----
    reg pending;       // a BSRAM transaction completes this cycle
    reg sd_wait;       // an SDRAM transaction is in flight
    assign sd_valid = sd_wait;

    // ---- GPIO ----
    wire [31:0] gpio_rdata;
    wire        gpio_strobe = mem_valid && sel_gpio && !mem_ready && !pending && !sd_wait;
    gpio_sio gpio (.clk(clk), .rst(rst), .sel(gpio_strobe), .we(is_write), .addr(mem_addr[7:0]),
                   .wdata(mem_wdata), .rdata(gpio_rdata), .gpio_out(gpio_out), .gpio_oe(gpio_oe), .gpio_in(gpio_in));

    // ---- flash SPI + DMA (writes straight into the SDRAM, bypassing the cache;
    //      the cache is invalidated when a DMA completes) ----
    wire [31:0] spi_rdata;
    wire        spi_strobe = mem_valid && sel_spi && !mem_ready && !pending && !sd_wait;
    flash_dma spi (.clk(clk), .rst(rst), .sel(spi_strobe), .we(is_write), .addr(mem_addr[5:0]),
                   .wdata(mem_wdata), .rdata(spi_rdata),
                   .m_valid(dma_valid), .m_ready(dma_ready), .m_addr(dma_addr), .m_wdata(dma_wdata),
                   .dma_active(dma_active), .done(dma_done), .ext_busy(cache_flushing),
                   .sck(spi_sck), .cs_n(spi_cs_n), .mosi(spi_mosi), .miso(spi_miso));
    wire [31:0] spi1_rdata;
    wire        spi1_strobe = mem_valid && sel_spi1 && !mem_ready && !pending && !sd_wait;
    spi_master spi1 (.clk(clk), .rst(rst), .sel(spi1_strobe), .we(is_write), .addr(mem_addr[3:0]),
                     .wdata(mem_wdata), .rdata(spi1_rdata), .sck(sd_sck), .cs_n(sd_cs_n), .mosi(sd_mosi), .miso(sd_miso));



    always @(posedge clk) begin
        if (rst) begin
            mem_ready <= 1'b0; pending <= 1'b0; sd_wait <= 1'b0; mem_rdata <= 0;
            mtime <= 0; mtimecmp <= 64'hFFFF_FFFF_FFFF_FFFF;
            tx_valid <= 1'b0; tx_data <= 0; rx_rp <= 0;
            exit_code <= 0; exit_valid <= 1'b0;
        end else begin
            mtime <= mtime + 64'd1;
            tx_valid <= 1'b0;
            exit_valid <= 1'b0;
            mem_ready <= 1'b0;
            if (sd_wait) begin
                // SDRAM access in flight: complete on its ready pulse
                if (sd_ready) begin sd_wait <= 1'b0; mem_rdata <= ram_q; mem_ready <= 1'b1; end
            end else if (mem_valid && !mem_ready && !pending) begin
                // BSRAM: data is available next cycle (ram_q / rom_q). Others: immediate.
                if (sel_ram && USE_SDRAM) begin
                    if (sd_init_done) sd_wait <= 1'b1;
                end else if (sel_ram || sel_rom) begin
                    pending <= 1'b1;
                end else if (sel_uart) begin
                    if (is_write) begin
                        if (mem_addr[2:0] == 3'd0) begin
                            if (!tx_busy && !tx_valid) begin
                                tx_data <= mem_wdata[7:0]; tx_valid <= 1'b1; mem_ready <= 1'b1;
                            end
                            // else: stall until the transmitter is free
                        end else mem_ready <= 1'b1;
                    end else begin
                        // The core selects the byte lane from mem_addr[1:0],
                        // so replicate the register across all four lanes.
                        case (mem_addr[2:0])
                            3'd0: begin
                                mem_rdata <= {4{rx_empty ? 8'd0 : rxf[rx_rp]}};
                                if (!rx_empty) rx_rp <= rx_rp + 1'b1;
                            end
                            3'd5: mem_rdata <= {4{uart_lsr}};
                            default: mem_rdata <= 32'd0;
                        endcase
                        mem_ready <= 1'b1;
                    end
                end else if (sel_clint) begin
                    case (mem_addr[15:0])
                        16'h4000: begin if (is_write) mtimecmp[31:0]  <= mem_wdata; mem_rdata <= mtimecmp[31:0];  end
                        16'h4004: begin if (is_write) mtimecmp[63:32] <= mem_wdata; mem_rdata <= mtimecmp[63:32]; end
                        16'hBFF8: begin if (is_write) mtime[31:0]     <= mem_wdata; mem_rdata <= mtime[31:0];     end
                        16'hBFFC: begin if (is_write) mtime[63:32]    <= mem_wdata; mem_rdata <= mtime[63:32];    end
                        default:  mem_rdata <= 32'd0;
                    endcase
                    mem_ready <= 1'b1;
                end else if (sel_gpio) begin
                    mem_rdata <= gpio_rdata;    // write side-effect happens in gpio_sio on this strobe
                    mem_ready <= 1'b1;
                end else if (sel_spi) begin
                    mem_rdata <= spi_rdata;
                    mem_ready <= 1'b1;
                end else if (sel_spi1) begin
                    mem_rdata <= spi1_rdata;
                    mem_ready <= 1'b1;
                end else if (sel_exit) begin
                    if (is_write && mem_addr[3:0] == 4'd0) begin exit_code <= mem_wdata; exit_valid <= 1'b1; end
                    mem_rdata <= (mem_addr[3:0] == 4'd4) ? BOOT_UART_WAIT : 32'd0;
                    mem_ready <= 1'b1;
                end else begin
                    // unmapped: read as zero, writes ignored
                    mem_rdata <= 32'd0;
                    mem_ready <= 1'b1;
                end
            end else if (pending) begin
                pending <= 1'b0;
                mem_rdata <= sel_rom ? rom_q : ram_q;
                mem_ready <= 1'b1;
            end
        end
    end

endmodule

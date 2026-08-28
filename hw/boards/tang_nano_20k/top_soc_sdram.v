// top_soc_sdram.v — the SoC with SDRAM main memory and the UART boot
// ROM (build/bootrom.hex). Reset with S1. LED0 = SDRAM init done,
// LED1 = exit device wrote 0x5555.
module top_soc_sdram (
    input  wire       clk, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx,
    output wire        O_sdram_clk, O_sdram_cke, O_sdram_cs_n, O_sdram_cas_n, O_sdram_ras_n, O_sdram_wen_n,
    output wire [10:0] O_sdram_addr, output wire [1:0] O_sdram_ba, output wire [3:0] O_sdram_dqm,
    inout  wire [31:0] IO_sdram_dq);
    reg [8:0] por = 0; wire rst = ~por[8] | key[0];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;
    wire [31:0] exit_code; wire exit_valid;
    soc #(.USE_SDRAM(1), .CLK_HZ(27_000_000), .BAUD(115_200), .RESET_PC(32'h0), .ROM_WORDS(2048), .ROM_INIT("build/bootrom.hex")) u_soc (
        .clk(clk), .rst(rst), .uart_rx(uart_rx), .uart_tx(uart_tx),
        .sdram_clk(O_sdram_clk), .sdram_cke(O_sdram_cke), .sdram_cs_n(O_sdram_cs_n), .sdram_ras_n(O_sdram_ras_n), .sdram_cas_n(O_sdram_cas_n), .sdram_we_n(O_sdram_wen_n),
        .sdram_addr(O_sdram_addr), .sdram_ba(O_sdram_ba), .sdram_dqm(O_sdram_dqm), .sdram_dq(IO_sdram_dq),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(), .dbg_instr(), .dbg_state(), .dbg_addr(), .dbg_txcnt(), .dbg_txbusy());
    reg ok = 0; always @(posedge clk) if (rst) ok <= 0; else if (exit_valid && exit_code == 32'h5555) ok <= 1;
    assign led = ~{4'b0, ok, u_soc.sd_init_done};
endmodule

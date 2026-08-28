// tb_boot.v — boot-ROM path: SoC resets into the ROM (+rom=hex), the
// testbench streams a load frame for +bin=<file> over uart_rx, and the
// loaded program's UART output / exit code decide PASS.
`timescale 1ns/1ps
module tb_boot;
    reg clk = 0; always #18.5 clk = ~clk;
    reg rst = 1; reg rx = 1;
    wire uart_tx; wire [31:0] exit_code; wire exit_valid; wire [31:0] pc;
    wire sclk, cke, cs_n, ras_n, cas_n, we_n; wire [10:0] sa; wire [1:0] ba; wire [3:0] dqm; wire [31:0] dq;
    localparam BAUD = 2_700_000;   // 10 clocks/bit in sim
    soc #(.USE_SDRAM(1), .CLK_HZ(27_000_000), .BAUD(BAUD), .RESET_PC(32'h0), .ROM_WORDS(2048)) dut (
        .clk(clk), .rst(rst), .uart_rx(rx), .uart_tx(uart_tx),
        .sdram_clk(sclk), .sdram_cke(cke), .sdram_cs_n(cs_n), .sdram_ras_n(ras_n), .sdram_cas_n(cas_n), .sdram_we_n(we_n),
        .sdram_addr(sa), .sdram_ba(ba), .sdram_dqm(dqm), .sdram_dq(dq),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc), .dbg_instr(), .dbg_state(), .dbg_addr(), .dbg_txcnt(), .dbg_txbusy());
    sdram_model mdl (.clk(sclk), .cke(cke), .cs_n(cs_n), .ras_n(ras_n), .cas_n(cas_n), .we_n(we_n), .addr(sa), .ba(ba), .dqm(dqm), .dq(dq));
    wire [7:0] ch; wire chv;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(BAUD)) mon (.clk(clk), .rst(rst), .rx(uart_tx), .data(ch), .valid(chv));
    always @(posedge clk) if (chv) $write("%c", ch);
    reg [1023:0] romfile, binfile; integer timeout_cycles, cyc = 0, fd, n, i, len; reg [7:0] bt; reg [31:0] sum;
    reg [7:0] img [0:1024*1024-1];
    localparam BIT_NS = 1_000_000_000 / BAUD;
    task send(input [7:0] b); integer k; begin
        rx = 0; #(BIT_NS); for (k = 0; k < 8; k = k + 1) begin rx = b[k]; #(BIT_NS); end rx = 1; #(BIT_NS);
    end endtask
    always @(posedge clk) begin
        cyc = cyc + 1;
        if (exit_valid) begin
            $display("\n[tb] exit code 0x%08x after %0d cycles", exit_code, cyc);
            if (exit_code == 32'h5555) $display("[tb] PASS"); else $display("[tb] FAIL");
            $finish;
        end
        if (cyc == timeout_cycles) begin $display("\n[tb] TIMEOUT pc=%08x", pc); $display("[tb] FAIL"); $finish; end
    end
    initial begin
        if (!$value$plusargs("rom=%s", romfile)) begin $display("need +rom="); $finish; end
        if (!$value$plusargs("bin=%s", binfile)) begin $display("need +bin="); $finish; end
        if (!$value$plusargs("timeout=%d", timeout_cycles)) timeout_cycles = 20_000_000;
        $readmemh({romfile, ".b0"}, dut.rom.ram0); $readmemh({romfile, ".b1"}, dut.rom.ram1);
        $readmemh({romfile, ".b2"}, dut.rom.ram2); $readmemh({romfile, ".b3"}, dut.rom.ram3);
        fd = $fopen(binfile, "rb"); len = 0;
        while (!$feof(fd)) begin n = $fread(bt, fd); if (n > 0) begin img[len] = bt; len = len + 1; end end
        $fclose(fd);
        $display("[tb] loading %0d bytes via boot ROM", len);
        repeat (4) @(posedge clk); rst = 0;
        // wait for the ROM's SDRAM init + banner (~200 us init at 27 MHz = 5400 clocks)
        #400000;
        sum = 0;
        send(len[7:0]); send(len[15:8]); send(len[23:16]); send(len[31:24]);
        for (i = 0; i < len; i = i + 1) begin send(img[i]); sum = sum + img[i]; end
        send(sum[7:0]); send(sum[15:8]); send(sum[23:16]); send(sum[31:24]);
    end
endmodule

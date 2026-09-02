// tb_soc.v — run a raw bin (+hex=<file from tools/bin2hex.py>) on the SoC.
// UART output goes to stdout; the exit device ends the sim with the
// SiFive-test convention (0x5555 pass, else fail). +timeout=<cycles>.
`timescale 1ns/1ps
module tb_soc;
    reg clk = 0; always #18.5 clk = ~clk;     // 27 MHz
    reg rst = 1;
    wire uart_tx; wire [31:0] exit_code; wire exit_valid; wire [31:0] pc;
    reg [1023:0] hexfile; integer timeout_cycles;
    // Fast UART in sim (BAUD = CLK/10 → 10 clocks/bit) so long prints are cheap.
    soc #(.RAM_WORDS(2*1024*1024), .CLK_HZ(27_000_000), .BAUD(2_700_000)) dut (
        .clk(clk), .rst(rst), .uart_rx(1'b1), .uart_tx(uart_tx),
        .sdram_clk(), .sdram_cke(), .sdram_cs_n(), .sdram_ras_n(), .sdram_cas_n(), .sdram_we_n(), .sdram_addr(), .sdram_ba(), .sdram_dqm(), .sdram_dq(), .gpio_out(), .gpio_oe(), .gpio_in(48'b0), .spi_sck(), .spi_cs_n(), .spi_mosi(), .spi_miso(1'b1), .sd_sck(), .sd_cs_n(), .sd_mosi(), .sd_miso(1'b1), .lcd_sck(), .lcd_mosi(),
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc), .dbg_instr(), .dbg_state(), .dbg_addr(), .dbg_txcnt(), .dbg_txbusy());
    wire [7:0] ch; wire chv;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(2_700_000)) mon (.clk(clk), .rst(rst), .rx(uart_tx), .data(ch), .valid(chv));
    always @(posedge clk) if (chv) $write("%c", ch);
    // Trap trace: the first 16 traps are always printed (cheap, and the
    // usual reason a program hangs).
    integer ntrap = 0, k;
    reg [31:0] hist [0:255]; integer hp = 0;
    reg exec_d = 0; integer trace_n = 0, traced = 0;
    initial if (!$value$plusargs("trace=%d", trace_n)) trace_n = 0;
    always @(posedge clk) begin
        exec_d <= (dut.cpu.state == 3'd1);
        if (dut.cpu.state == 3'd1 && !exec_d) begin
            hist[hp] = dut.cpu.pc; hp = (hp + 1) % 256;
            if (traced < trace_n) begin traced = traced + 1; $display("[tb] pc=%08x instr=%08x", dut.cpu.pc, dut.cpu.instr); end
        end
    end
    always @(posedge clk) if (dut.cpu.state == 3'd4 && ntrap < 16) begin
        ntrap = ntrap + 1;
        $display("[tb] trap cause=%08x epc=%08x tval=%08x", dut.cpu.trap_cause, dut.cpu.trap_epc, dut.cpu.trap_tval);
        if (ntrap == 1 && !dut.cpu.trap_cause[31]) begin   // exceptions only, not interrupts
            $write("[tb] last pcs:");
            for (k = 0; k < 256; k = k + 1) $write(" %08x", hist[(hp + k) % 256]);
            $write("\n");
        end
    end
    integer cyc = 0;
    always @(posedge clk) begin
        cyc = cyc + 1;
        if (exit_valid) begin
            $display("\n[tb] exit code 0x%08x after %0d cycles", exit_code, cyc);
            if (exit_code == 32'h5555) $display("[tb] PASS"); else $display("[tb] FAIL");
            $finish;
        end
        if (cyc == timeout_cycles) begin
            $display("\n[tb] TIMEOUT pc=%08x", pc); $display("[tb] FAIL"); $finish;
        end
    end
    initial begin
        if (!$value$plusargs("hex=%s", hexfile)) begin $display("need +hex="); $finish; end
        if (!$value$plusargs("timeout=%d", timeout_cycles)) timeout_cycles = 2_000_000;
        $readmemh({hexfile, ".b0"}, dut.g_bsram.ram.ram0);
        $readmemh({hexfile, ".b1"}, dut.g_bsram.ram.ram1);
        $readmemh({hexfile, ".b2"}, dut.g_bsram.ram.ram2);
        $readmemh({hexfile, ".b3"}, dut.g_bsram.ram.ram3);
        repeat (4) @(posedge clk); rst = 0;
    end
endmodule

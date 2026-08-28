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
        .exit_code(exit_code), .exit_valid(exit_valid), .dbg_pc(pc));
    wire [7:0] ch; wire chv;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(2_700_000)) mon (.clk(clk), .rst(rst), .rx(uart_tx), .data(ch), .valid(chv));
    always @(posedge clk) if (chv) $write("%c", ch);
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
        $readmemh({hexfile, ".b0"}, dut.ram.ram0);
        $readmemh({hexfile, ".b1"}, dut.ram.ram1);
        $readmemh({hexfile, ".b2"}, dut.ram.ram2);
        $readmemh({hexfile, ".b3"}, dut.ram.ram3);
        repeat (4) @(posedge clk); rst = 0;
    end
endmodule

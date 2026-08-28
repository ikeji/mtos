// tb_top_blink.v — feed two bytes into top_blink's uart_rx at 115200 and
// check they come back on uart_tx (echo path incl. FIFO).
`timescale 1ns/1ps
module tb_top_blink;
    reg clk = 0; always #18.5 clk = ~clk;   // 27 MHz
    reg rx = 1; wire tx; wire [5:0] led;
    top_blink dut(.clk(clk), .key(2'b00), .led(led), .uart_rx(rx), .uart_tx(tx));
    reg mrst = 1;
    wire [7:0] rd; wire rv;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(115_200)) mon(.clk(clk), .rst(mrst), .rx(tx), .data(rd), .valid(rv));
    reg [7:0] got [0:3]; integer n = 0;
    always @(posedge clk) if (rv) begin got[n] = rd; n = n + 1; end
    task send(input [7:0] b); integer i; begin
        rx = 0; #8680; for (i=0;i<8;i=i+1) begin rx = b[i]; #8680; end rx = 1; #8680;
    end endtask
    initial begin
        #1000 mrst = 0;
        #20000; send(8'h70); send(8'h69); #300000;
        if (n == 2 && got[0] == 8'h70 && got[1] == 8'h69) $display("PASS top_blink echo");
        else $display("FAIL n=%0d got0=%02x got1=%02x", n, got[0], got[1]);
        $finish;
    end
endmodule

`timescale 1ns/1ps
module tb_top_soc_syn;
    reg clk = 0; always #18.5 clk = ~clk;
    wire [5:0] led; wire tx;
    top_soc dut(.clk(clk), .key(2'b00), .led(led), .uart_rx(1'b1), .uart_tx(tx));
    wire [7:0] ch; wire chv; reg mrst = 1;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(115_200)) mon(.clk(clk), .rst(mrst), .rx(tx), .data(ch), .valid(chv));
    always @(posedge clk) if (chv) $display("[syn] uart %c (%02x)", ch, ch);
    initial begin #100 mrst = 0; #6000000; $display("[syn] led=%b", led); $finish; end
endmodule

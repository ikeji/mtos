// tb_uart.v — loop uart_tx into uart_rx and check 256 bytes round-trip.
`timescale 1ns/1ps
module tb_uart;
    reg clk = 0; always #5 clk = ~clk;   // 100 MHz sim clock, DIV = 100000000/1000000 = 100
    reg rst = 1;
    reg [7:0] d = 0; reg v = 0; wire busy, line;
    wire [7:0] rd; wire rv;
    uart_tx #(.CLK_HZ(100_000_000), .BAUD(1_000_000)) tx (.clk(clk), .rst(rst), .data(d), .valid(v), .busy(busy), .tx(line));
    uart_rx #(.CLK_HZ(100_000_000), .BAUD(1_000_000)) rx (.clk(clk), .rst(rst), .rx(line), .data(rd), .valid(rv));
    integer sent = 0, got = 0, errors = 0;
    always @(posedge clk) if (rv) begin
        if (rd !== got[7:0]) begin errors = errors + 1; $display("MISMATCH got=%02x want=%02x", rd, got[7:0]); end
        got = got + 1;
    end
    initial begin
        repeat (4) @(posedge clk); rst = 0;
        while (sent < 256) begin
            @(posedge clk);
            if (!busy && !v) begin d <= sent[7:0]; v <= 1; sent = sent + 1; end
            else v <= 0;
        end
        @(posedge clk); v <= 0;
        repeat (3000) @(posedge clk);
        if (got == 256 && errors == 0) $display("PASS uart loopback 256 bytes");
        else $display("FAIL got=%0d errors=%0d", got, errors);
        $finish;
    end
endmodule

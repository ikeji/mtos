// top_ramtest.v — BSRAM bring-up: dump the first 16 words of the
// RAM's init image (build/prog.hex) as hex over the UART, forever.
module top_ramtest (
    input  wire       clk, input wire [1:0] key, output wire [5:0] led,
    input  wire       uart_rx, output wire uart_tx);
    reg [8:0] por = 0; wire rst = ~por[8];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;
    reg [3:0] widx = 0; wire [31:0] rd;
    ram32 #(.WORDS(8192), .INIT("build/prog.hex")) ram (
        .clk(clk), .addr({9'b0, widx}), .wdata(32'b0), .we(4'b0), .rdata(rd));
    reg [7:0] tx_data; reg tx_valid = 0; wire tx_busy;
    uart_tx #(.CLK_HZ(27_000_000), .BAUD(115_200)) utx (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(uart_tx));
    // state: for each word, emit 8 hex digits + '\n'; wait ~20 ms between words
    reg [3:0] nib = 0; reg [31:0] word; reg [1:0] st = 0; reg [20:0] wait_cnt = 0;
    function [7:0] hexc(input [3:0] v); hexc = (v < 10) ? (8'h30 + v) : (8'h57 + v); endfunction
    always @(posedge clk) begin
        tx_valid <= 1'b0;
        if (rst) begin st <= 0; widx <= 0; nib <= 0; wait_cnt <= 0; end
        else case (st)
            0: begin wait_cnt <= wait_cnt + 1'b1; if (&wait_cnt) begin st <= 1; end end   // settle + gap
            1: begin word <= rd; nib <= 0; st <= 2; end                                       // rd reflects widx
            2: if (!tx_busy && !tx_valid) begin
                   if (nib == 8) begin tx_data <= 8'h0a; tx_valid <= 1'b1; st <= 3; end
                   else begin tx_data <= hexc(word[31:28]); word <= word << 4; nib <= nib + 1'b1; tx_valid <= 1'b1; end
               end
            3: begin widx <= widx + 1'b1; st <= 0; end
        endcase
    end
    assign led = ~{5'b0, widx[3]};
endmodule

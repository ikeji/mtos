// uart_hexout.v — print a 32-bit word as 8 hex digits + a trailing
// character (e.g. ' ' or '\n') over uart_tx. `go` starts it; `busy` high
// until done.
module uart_hexout #(parameter CLK_HZ = 27_000_000, parameter BAUD = 115_200) (
    input  wire        clk, input wire rst,
    input  wire        go, input wire [31:0] value, input wire [7:0] tail,
    output reg         busy, output wire tx);
    reg [7:0] tx_data; reg tx_valid; wire tx_busy;
    uart_tx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) u (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(tx));
    function [7:0] hexc(input [3:0] v); hexc = (v < 10) ? (8'h30 + v) : (8'h57 + v); endfunction
    reg [31:0] sh; reg [3:0] nib; reg [7:0] tl;
    always @(posedge clk) begin
        tx_valid <= 0;
        if (rst) begin busy <= 0; nib <= 0; end
        else if (!busy) begin
            if (go) begin busy <= 1; sh <= value; nib <= 0; tl <= tail; end
        end else if (!tx_busy && !tx_valid) begin
            if (nib == 8) begin tx_data <= tl; tx_valid <= 1; busy <= 0; end
            else begin tx_data <= hexc(sh[31:28]); sh <= sh << 4; nib <= nib + 1'b1; tx_valid <= 1; end
        end
    end
endmodule

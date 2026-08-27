// uart_tx.v — 8N1 transmitter. CLK_HZ / BAUD gives the bit period.
module uart_tx #(
    parameter CLK_HZ = 27_000_000,
    parameter BAUD   = 115_200
) (
    input  wire       clk,
    input  wire       rst,
    input  wire [7:0] data,
    input  wire       valid,   // pulse (or hold) while busy == 0 to send
    output reg        busy,
    output reg        tx
);
    localparam integer DIV = CLK_HZ / BAUD;
    reg [15:0] cnt;
    reg [3:0]  bit_idx;   // 0 = start, 1..8 = data, 9 = stop
    reg [9:0]  shift;

    always @(posedge clk) begin
        if (rst) begin
            busy <= 1'b0; tx <= 1'b1; cnt <= 0; bit_idx <= 0; shift <= 10'h3ff;
        end else if (!busy) begin
            tx <= 1'b1;
            if (valid) begin
                shift   <= {1'b1, data, 1'b0};  // stop, data(lsb first), start
                busy    <= 1'b1;
                cnt     <= 0;
                bit_idx <= 0;
                tx      <= 1'b0;
            end
        end else begin
            if (cnt == DIV - 1) begin
                cnt <= 0;
                if (bit_idx == 9) begin
                    busy <= 1'b0;
                    tx   <= 1'b1;
                end else begin
                    bit_idx <= bit_idx + 1'b1;
                    tx      <= shift[bit_idx + 1];
                end
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule

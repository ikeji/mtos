// uart_rx.v — 8N1 receiver, samples mid-bit. `valid` pulses one clk per byte.
module uart_rx #(
    parameter CLK_HZ = 27_000_000,
    parameter BAUD   = 115_200
) (
    input  wire       clk,
    input  wire       rst,
    input  wire       rx,
    output reg  [7:0] data,
    output reg        valid
);
    localparam integer DIV = CLK_HZ / BAUD;
    reg [1:0]  sync;
    reg        busy;
    reg [15:0] cnt;
    reg [3:0]  bit_idx;
    reg [7:0]  shift;

    always @(posedge clk) begin
        if (rst) begin
            sync <= 2'b11; busy <= 0; cnt <= 0; bit_idx <= 0; valid <= 0; data <= 0; shift <= 0;
        end else begin
            sync  <= {sync[0], rx};
            valid <= 1'b0;
            if (!busy) begin
                if (sync[1] == 1'b0) begin   // start bit edge
                    busy    <= 1'b1;
                    cnt     <= DIV / 2;      // sample at mid-bit
                    bit_idx <= 0;
                end
            end else if (cnt == DIV - 1) begin
                cnt <= 0;
                if (bit_idx == 0) begin
                    if (sync[1] != 1'b0) busy <= 1'b0;   // false start
                    else bit_idx <= 1;
                end else if (bit_idx <= 8) begin
                    shift   <= {sync[1], shift[7:1]};
                    bit_idx <= bit_idx + 1'b1;
                end else begin               // stop bit
                    busy <= 1'b0;
                    if (sync[1] == 1'b1) begin
                        data  <= shift;
                        valid <= 1'b1;
                    end
                end
            end else begin
                cnt <= cnt + 1'b1;
            end
        end
    end
endmodule

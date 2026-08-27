// top_blink.v — Phase 0 smoke test for Tang Nano 20K.
//   * LED0 blinks at ~1 Hz, LED1..5 show a running light.
//   * UART (BL616 bridge, 115200 8N1) echoes every byte back, and
//     pressing S1 sends "tn20k\r\n".
module top_blink (
    input  wire       clk,      // 27 MHz
    input  wire [1:0] key,      // S1 / S2, active low
    output wire [5:0] led,      // active low
    input  wire       uart_rx,
    output wire       uart_tx
);
    // Power-on reset: hold for 2^8 cycles.
    reg [8:0] por = 0;
    wire rst = ~por[8];
    always @(posedge clk) if (!por[8]) por <= por + 1'b1;

    reg [26:0] div = 0;
    always @(posedge clk) div <= div + 1'b1;
    // ~1 Hz on led[0], running light on led[5:1] at ~4 Hz.
    reg [4:0] run = 5'b00001;
    reg       tick_d = 0;
    wire      tick = div[24];
    always @(posedge clk) begin
        tick_d <= tick;
        if (tick & ~tick_d) run <= {run[3:0], run[4]};
    end
    assign led = ~{run, div[26]};

    wire [7:0] rx_data; wire rx_valid;
    uart_rx #(.CLK_HZ(27_000_000), .BAUD(115_200)) urx (
        .clk(clk), .rst(rst), .rx(uart_rx), .data(rx_data), .valid(rx_valid));

    reg  [7:0] tx_data; reg tx_valid = 0; wire tx_busy;
    uart_tx #(.CLK_HZ(27_000_000), .BAUD(115_200)) utx (
        .clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(uart_tx));

    // Echo path + S1 banner. Simple 16-byte FIFO so a burst of RX
    // bytes (or the banner) is not dropped while the TX shifter is busy.
    reg [7:0] fifo [0:15];
    reg [3:0] wp = 0, rp = 0;
    wire empty = (wp == rp);

    localparam BANNER_LEN = 7;
    reg [7:0] banner [0:BANNER_LEN-1];
    initial begin
        banner[0]="t"; banner[1]="n"; banner[2]="2"; banner[3]="0";
        banner[4]="k"; banner[5]="\r"; banner[6]="\n";
    end
    reg [2:0]  bidx = 0;
    reg        bsend = 0;
    reg [19:0] key_db = 0;   // debounce: S1 must be held ~40 ms
    reg        key_fired = 0;

    always @(posedge clk) begin
        if (rst) begin
            wp <= 0; rp <= 0; tx_valid <= 0; bsend <= 0; bidx <= 0; key_db <= 0; key_fired <= 0;
        end else begin
            tx_valid <= 1'b0;
            if (rx_valid) begin fifo[wp] <= rx_data; wp <= wp + 1'b1; end

            if (key[0] == 1'b0) begin
                if (key_db != 20'hFFFFF) key_db <= key_db + 1'b1;
                else if (!key_fired) begin key_fired <= 1'b1; bsend <= 1'b1; bidx <= 0; end
            end else begin key_db <= 0; key_fired <= 1'b0; end

            if (bsend && !rx_valid) begin
                fifo[wp] <= banner[bidx]; wp <= wp + 1'b1;
                if (bidx == BANNER_LEN - 1) bsend <= 1'b0; else bidx <= bidx + 1'b1;
            end

            if (!empty && !tx_busy && !tx_valid) begin
                tx_data  <= fifo[rp];
                tx_valid <= 1'b1;
                rp       <= rp + 1'b1;
            end
        end
    end
endmodule

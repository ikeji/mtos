// spi_master.v — tiny SPI master (mode 0, MSB first, SCK = clk/2).
//   +0 DATA   write: start an 8-bit transfer with this byte; read: last received byte
//   +4 STATUS bit0 = busy
//   +8 CTRL   bit0 = CS asserted (1 → cs_n low)
// Used by the boot ROM to stream the kernel out of the SPI flash.
module spi_master (
    input  wire        clk,
    input  wire        rst,
    input  wire        sel,
    input  wire        we,
    input  wire [3:0]  addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    output reg         sck,
    output reg         cs_n,
    output reg         mosi,
    input  wire        miso
);
    reg        busy;
    reg [7:0]  shift, rx;
    reg [3:0]  bit_cnt;     // bits remaining
    reg        phase;       // 0: SCK low (data set up), 1: SCK high (sample)
    always @(*) begin
        case (addr[3:2])
            2'd0: rdata = {24'b0, rx};
            2'd1: rdata = {31'b0, busy};
            2'd2: rdata = {31'b0, ~cs_n};
            default: rdata = 32'd0;
        endcase
    end
    always @(posedge clk) begin
        if (rst) begin
            busy <= 0; sck <= 0; cs_n <= 1; mosi <= 0; shift <= 0; rx <= 0; bit_cnt <= 0; phase <= 0;
        end else begin
            if (sel && we && addr[3:2] == 2'd2) cs_n <= ~wdata[0];
            if (!busy) begin
                if (sel && we && addr[3:2] == 2'd0) begin
                    busy <= 1; shift <= wdata[7:0]; bit_cnt <= 8; phase <= 0; mosi <= wdata[7]; sck <= 0;
                end
            end else if (!phase) begin
                sck <= 1; phase <= 1;                       // rising edge: slave samples MOSI, we sample MISO next
            end else begin
                rx <= {rx[6:0], miso};                      // sample on the high phase
                sck <= 0; phase <= 0;
                shift <= {shift[6:0], 1'b0};
                mosi <= shift[6];
                bit_cnt <= bit_cnt - 1'b1;
                if (bit_cnt == 1) busy <= 0;
            end
        end
    end
endmodule

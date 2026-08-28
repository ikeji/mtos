// gpio_sio.v — 48-bit GPIO block with the RP2350 SIO register layout, so
// the pico2 GPIO bit-bang drivers (keyboard_matrix.tc, display_ili9488.tc)
// run on the SoC with only pin-number constants changed. Base 0xD000_0000.
//   0x04 GPIO_IN        0x08 GPIO_HI_IN        (HI = GPIO 32..47 in bits 15:0)
//   0x10 GPIO_OUT       0x14 GPIO_HI_OUT
//   0x18 GPIO_OUT_SET   0x1C GPIO_HI_OUT_SET
//   0x20 GPIO_OUT_CLR   0x24 GPIO_HI_OUT_CLR
//   0x28 GPIO_OUT_XOR   0x2C GPIO_HI_OUT_XOR
//   0x30 GPIO_OE        0x34 GPIO_HI_OE
//   0x38 GPIO_OE_SET    0x3C GPIO_HI_OE_SET
//   0x40 GPIO_OE_CLR    0x44 GPIO_HI_OE_CLR
// IO_BANK0 / PADS / PIO registers of the RP2350 are simply unmapped in
// the SoC (writes ignored, reads 0); pull-ups are static IO attributes.
module gpio_sio (
    input  wire        clk,
    input  wire        rst,
    input  wire        sel,        // this cycle's bus access targets us
    input  wire        we,
    input  wire [7:0]  addr,       // byte offset within the block
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    output reg  [47:0] gpio_out,
    output reg  [47:0] gpio_oe,
    input  wire [47:0] gpio_in
);
    reg [47:0] in_sync0, in_sync1;
    always @(posedge clk) begin in_sync0 <= gpio_in; in_sync1 <= in_sync0; end
    always @(*) begin
        case (addr[7:2])
            6'h01: rdata = in_sync1[31:0];
            6'h02: rdata = {16'b0, in_sync1[47:32]};
            6'h04: rdata = gpio_out[31:0];
            6'h05: rdata = {16'b0, gpio_out[47:32]};
            6'h0C: rdata = gpio_oe[31:0];
            6'h0D: rdata = {16'b0, gpio_oe[47:32]};
            default: rdata = 32'd0;
        endcase
    end
    always @(posedge clk) begin
        if (rst) begin gpio_out <= 48'd0; gpio_oe <= 48'd0; end
        else if (sel && we) begin
            case (addr[7:2])
                6'h04: gpio_out[31:0]  <= wdata;
                6'h05: gpio_out[47:32] <= wdata[15:0];
                6'h06: gpio_out[31:0]  <= gpio_out[31:0] | wdata;
                6'h07: gpio_out[47:32] <= gpio_out[47:32] | wdata[15:0];
                6'h08: gpio_out[31:0]  <= gpio_out[31:0] & ~wdata;
                6'h09: gpio_out[47:32] <= gpio_out[47:32] & ~wdata[15:0];
                6'h0A: gpio_out[31:0]  <= gpio_out[31:0] ^ wdata;
                6'h0B: gpio_out[47:32] <= gpio_out[47:32] ^ wdata[15:0];
                6'h0C: gpio_oe[31:0]   <= wdata;
                6'h0D: gpio_oe[47:32]  <= wdata[15:0];
                6'h0E: gpio_oe[31:0]   <= gpio_oe[31:0] | wdata;
                6'h0F: gpio_oe[47:32]  <= gpio_oe[47:32] | wdata[15:0];
                6'h10: gpio_oe[31:0]   <= gpio_oe[31:0] & ~wdata;
                6'h11: gpio_oe[47:32]  <= gpio_oe[47:32] & ~wdata[15:0];
                default: ;
            endcase
        end
    end
endmodule

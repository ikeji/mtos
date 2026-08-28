// spiflash_model.v — minimal SPI NOR flash: READ (0x03) with 24-bit
// address, mode 0, MSB first, continuous sequential read while CS is low.
`timescale 1ns/1ps
module spiflash_model #(parameter integer SIZE = 4*1024*1024) (
    input wire clk, input wire cs_n, input wire mosi, output reg miso);
    reg [7:0] mem [0:SIZE-1];
    reg [31:0] shin; integer nbits; reg [23:0] addr; reg [7:0] outb; integer obit;
    reg reading;
    always @(negedge cs_n) begin shin = 0; nbits = 0; reading = 0; obit = 7; miso = 1'bz; end
    always @(posedge clk) if (!cs_n) begin
        if (!reading) begin
            shin = {shin[30:0], mosi}; nbits = nbits + 1;
            if (nbits == 32) begin
                if (shin[31:24] != 8'h03) $display("[flash] unsupported cmd %02x", shin[31:24]);
                addr = shin[23:0]; reading = 1; outb = mem[addr]; obit = 7;
            end
        end
    end
    always @(negedge clk) if (!cs_n && reading) begin
        miso <= outb[obit];
        if (obit == 0) begin obit <= 7; addr <= addr + 1; outb <= mem[addr + 1]; end
        else obit <= obit - 1;
    end
    always @(posedge cs_n) miso <= 1'bz;
endmodule

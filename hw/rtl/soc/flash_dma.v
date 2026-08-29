// flash_dma.v — SPI flash controller: register-driven byte transfers
// (same +0/+4/+8 layout as spi_master.v) plus a DMA engine that streams
// a READ (0x03) into memory as 32-bit words and sums the bytes.
//   +0x00 DATA    byte transfer (write starts, read = received byte)
//   +0x04 STATUS  bit0 = byte transfer busy
//   +0x08 CTRL    bit0 = CS asserted, bits 15:8 = clock divider
//   +0x10 DMA_SRC flash byte offset (24 bit)
//   +0x14 DMA_DST memory byte address (word aligned)
//   +0x18 DMA_LEN bytes (rounded up to a whole word for the last write)
//   +0x1C DMA_CTRL write 1 = start; read bit0 = busy (until mem_done_in)
//   +0x20 DMA_SUM sum of the first DMA_LEN bytes mod 2^32
// DMA runs SCK at clk/2 and owns the SPI pins while active. Memory
// writes use the valid/ready port (m_*); `done` pulses when the last
// write was accepted so the SoC can invalidate its cache; `busy` stays
// set while `ext_busy` (cache flush) is high.
module flash_dma (
    input  wire        clk,
    input  wire        rst,
    input  wire        sel,
    input  wire        we,
    input  wire [5:0]  addr,
    input  wire [31:0] wdata,
    output reg  [31:0] rdata,
    // memory write port
    output reg         m_valid,
    input  wire        m_ready,
    output reg  [31:0] m_addr,
    output reg  [31:0] m_wdata,
    output wire        dma_active,
    output reg         done,
    input  wire        ext_busy,
    // SPI pins
    output reg         sck,
    output reg         cs_n,
    output reg         mosi,
    input  wire        miso
);
    // ---- byte-mode engine (as spi_master.v) ----
    reg        bbusy; reg [7:0] shift, rx; reg [3:0] bit_cnt; reg phase; reg [7:0] div, dcnt; reg cs_reg;
    // ---- DMA ----
    reg [23:0] src; reg [31:0] dst, len, sum; reg dbusy;
    localparam D_IDLE = 3'd0, D_CMD = 3'd1, D_DATA = 3'd2, D_WRITE = 3'd3, D_FIN = 3'd4;
    reg [2:0]  dstate;
    reg [31:0] dshift;      // command/address shifter (32 bits: 0x03 + addr)
    reg [5:0]  dbits;       // bits remaining in the current shift
    reg        dphase;
    reg [31:0] word; reg [1:0] wbytes; reg [7:0] cur; reg [2:0] cbits;
    reg [31:0] remaining;
    assign dma_active = (dstate != D_IDLE);

    always @(*) begin
        case (addr[5:2])
            4'h0: rdata = {24'b0, rx};
            4'h1: rdata = {31'b0, bbusy};
            4'h2: rdata = {16'b0, div, 7'b0, cs_reg};
            4'h4: rdata = {8'b0, src};
            4'h5: rdata = dst;
            4'h6: rdata = len;
            4'h7: rdata = {31'b0, dbusy | ext_busy};
            4'h8: rdata = sum;
            default: rdata = 32'd0;
        endcase
    end

    always @(posedge clk) begin
        if (rst) begin
            bbusy <= 0; shift <= 0; rx <= 0; bit_cnt <= 0; phase <= 0; div <= 0; dcnt <= 0; cs_reg <= 0;
            src <= 0; dst <= 0; len <= 0; sum <= 0; dbusy <= 0; dstate <= D_IDLE; dshift <= 0; dbits <= 0; dphase <= 0;
            word <= 0; wbytes <= 0; cur <= 0; cbits <= 0; remaining <= 0;
            m_valid <= 0; m_addr <= 0; m_wdata <= 0; done <= 0; sck <= 0; cs_n <= 1; mosi <= 0;
        end else begin
            done <= 1'b0;
            // register writes
            if (sel && we) begin
                case (addr[5:2])
                    4'h2: begin cs_reg <= wdata[0]; div <= wdata[15:8]; end
                    4'h4: src <= wdata[23:0];
                    4'h5: dst <= wdata;
                    4'h6: len <= wdata;
                    default: ;
                endcase
            end
            if (dstate == D_IDLE) begin
                // ---- byte mode ----
                cs_n <= ~cs_reg;
                if (!bbusy) begin
                    if (sel && we && addr[5:2] == 4'h0) begin
                        bbusy <= 1; shift <= wdata[7:0]; bit_cnt <= 8; phase <= 0; mosi <= wdata[7]; sck <= 0; dcnt <= 0;
                    end else if (sel && we && addr[5:2] == 4'h7 && wdata[0]) begin
                        // ---- start DMA: CS low, send 0x03 + 24-bit address ----
                        dbusy <= 1; dstate <= D_CMD; dshift <= {8'h03, src}; dbits <= 32; dphase <= 0;
                        sum <= 0; remaining <= len; wbytes <= 0; cbits <= 0; cs_n <= 0; sck <= 0; mosi <= 1'b0;
                        m_addr <= dst;
                    end
                end else if (dcnt != div) begin
                    dcnt <= dcnt + 1'b1;
                end else if (!phase) begin
                    dcnt <= 0; sck <= 1; phase <= 1;
                end else begin
                    dcnt <= 0; rx <= {rx[6:0], miso}; sck <= 0; phase <= 0;
                    shift <= {shift[6:0], 1'b0}; mosi <= shift[6]; bit_cnt <= bit_cnt - 1'b1;
                    if (bit_cnt == 1) bbusy <= 0;
                end
            end else begin
                // ---- DMA engine: SCK = clk/2, mode 0 ----
                case (dstate)
                D_CMD: begin
                    if (!dphase) begin mosi <= dshift[31]; sck <= 0; dphase <= 1; end   // set up
                    else begin
                        sck <= 1; dphase <= 0; dshift <= {dshift[30:0], 1'b0}; dbits <= dbits - 1'b1;
                        if (dbits == 1) begin dstate <= D_DATA; cbits <= 0; end
                    end
                end
                D_DATA: begin
                    // Each bit: low phase (slave drives), high phase (we sample).
                    if (!dphase) begin sck <= 0; dphase <= 1; end
                    else begin
                        sck <= 1; dphase <= 0; cur <= {cur[6:0], miso};
                        if (cbits == 7) begin
                            cbits <= 0;
                            // byte complete: pack little-endian into word
                            if (remaining != 0) begin sum <= sum + {24'b0, cur[6:0], miso}; remaining <= remaining - 1'b1; end
                            case (wbytes)
                                2'd0: word[7:0]   <= {cur[6:0], miso};
                                2'd1: word[15:8]  <= {cur[6:0], miso};
                                2'd2: word[23:16] <= {cur[6:0], miso};
                                2'd3: word[31:24] <= {cur[6:0], miso};
                            endcase
                            wbytes <= wbytes + 1'b1;
                            if (wbytes == 2'd3) dstate <= D_WRITE;
                        end else cbits <= cbits + 1'b1;
                    end
                end
                D_WRITE: begin
                    sck <= 0;
                    if (!m_valid) begin m_valid <= 1; m_wdata <= word; end
                    else if (m_ready) begin
                        m_valid <= 0; m_addr <= m_addr + 32'd4;
                        if (remaining == 0) begin dstate <= D_FIN; cs_n <= 1; done <= 1; end
                        else dstate <= D_DATA;
                    end
                end
                D_FIN: begin dbusy <= 0; dstate <= D_IDLE; end
                default: dstate <= D_IDLE;
                endcase
            end
        end
    end
endmodule

// soc.v — rv32_core + bus decode + RAM + UART + CLINT + exit device.
//
// Memory map mirrors qemu virt so the MTOS kernel's virt platform code
// (kernel/src/kernel.tc CLINT, platform_virt.tc UART) runs unchanged:
//   0x0010_0000  exit/LED   (SiFive test: 0x5555 = pass, 0x3333|code<<16 = fail)
//   0x0200_0000  CLINT      (+0x4000 mtimecmp lo/hi, +0xBFF8 mtime lo/hi)
//   0x1000_0000  UART       (+0 DR, +5 LSR: bit0 RX ready, bit5/6 TX empty)
//   0x8000_0000  RAM        (RAM_WORDS * 4 bytes; sim = 8 MB, board = BSRAM)
//
// A UART DR write stalls the bus until the transmitter is free, so
// software may write without polling (qemu behaviour).
module soc #(
    parameter integer RAM_WORDS = 2*1024*1024,   // 8 MB
    parameter integer CLK_HZ    = 27_000_000,
    parameter integer BAUD      = 115_200,
    parameter         RAM_INIT  = ""             // $readmemh file (sim)
) (
    input  wire        clk,
    input  wire        rst,
    input  wire        uart_rx,
    output wire        uart_tx,
    output reg  [31:0] exit_code,     // last write to the exit device
    output reg         exit_valid,    // pulses on that write
    output wire [31:0] dbg_pc,
    output wire [31:0] dbg_instr,
    output wire [2:0]  dbg_state,
    output wire [31:0] dbg_addr,
    output wire [7:0]  dbg_txcnt,
    output wire        dbg_txbusy
);
    wire        mem_valid;
    reg         mem_ready;
    wire [31:0] mem_addr, mem_wdata;
    wire [3:0]  mem_wstrb;
    reg  [31:0] mem_rdata;
    reg  [63:0] mtime;
    reg  [63:0] mtimecmp;
    wire        timer_irq = (mtime >= mtimecmp);

    rv32_core #(.RESET_PC(32'h8000_0000)) cpu (
        .clk(clk), .rst(rst),
        .mem_valid(mem_valid), .mem_ready(mem_ready), .mem_addr(mem_addr),
        .mem_wdata(mem_wdata), .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata),
        .timer_irq(timer_irq), .mtime(mtime), .dbg_pc(dbg_pc), .dbg_instr(dbg_instr), .dbg_state(dbg_state));
    assign dbg_addr = mem_addr;

    // ---- address decode ----
    wire sel_ram   = (mem_addr[31:28] == 4'h8);
    wire sel_uart  = (mem_addr[31:16] == 16'h1000);
    wire sel_clint = (mem_addr[31:16] == 16'h0200);
    wire sel_exit  = (mem_addr[31:16] == 16'h0010);
    wire is_write  = (mem_wstrb != 4'b0);

    // ---- RAM (synchronous, 1-cycle; see ram32.v) ----
    localparam integer AW = $clog2(RAM_WORDS);
    wire [31:0] ram_q;
    ram32 #(.WORDS(RAM_WORDS), .INIT(RAM_INIT)) ram (
        .clk(clk), .addr(mem_addr[AW+1:2]), .wdata(mem_wdata),
        .we(mem_wstrb & {4{mem_valid && sel_ram}}), .rdata(ram_q));

    // ---- UART ----
    wire [7:0] rx_data; wire rx_valid;
    uart_rx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) urx (.clk(clk), .rst(rst), .rx(uart_rx), .data(rx_data), .valid(rx_valid));
    reg  [7:0] tx_data; reg tx_valid; wire tx_busy;
    uart_tx #(.CLK_HZ(CLK_HZ), .BAUD(BAUD)) utx (.clk(clk), .rst(rst), .data(tx_data), .valid(tx_valid), .busy(tx_busy), .tx(uart_tx));
    // 16-byte RX FIFO
    reg [7:0] rxf [0:15];
    reg [3:0] rx_wp, rx_rp;
    wire rx_empty = (rx_wp == rx_rp);
    always @(posedge clk) begin
        if (rst) rx_wp <= 0;
        else if (rx_valid) begin rxf[rx_wp] <= rx_data; rx_wp <= rx_wp + 1'b1; end
    end
    wire [7:0] uart_lsr = {1'b0, ~tx_busy, ~tx_busy, 4'b0, ~rx_empty};
    reg [7:0] txcnt; always @(posedge clk) if (rst) txcnt <= 0; else if (tx_valid) txcnt <= txcnt + 1'b1;
    assign dbg_txcnt = txcnt; assign dbg_txbusy = tx_busy;   // for top_socdbg

    // ---- bus response ----
    reg pending;       // a transaction has been accepted and is completing this cycle
    always @(posedge clk) begin
        if (rst) begin
            mem_ready <= 1'b0; pending <= 1'b0; mem_rdata <= 0;
            mtime <= 0; mtimecmp <= 64'hFFFF_FFFF_FFFF_FFFF;
            tx_valid <= 1'b0; tx_data <= 0; rx_rp <= 0;
            exit_code <= 0; exit_valid <= 1'b0;
        end else begin
            mtime <= mtime + 64'd1;
            tx_valid <= 1'b0;
            exit_valid <= 1'b0;
            mem_ready <= 1'b0;
            if (mem_valid && !mem_ready && !pending) begin
                // RAM: data is available next cycle (ram_q). Others: immediate.
                if (sel_ram) begin
                    pending <= 1'b1;
                end else if (sel_uart) begin
                    if (is_write) begin
                        if (mem_addr[2:0] == 3'd0) begin
                            if (!tx_busy && !tx_valid) begin
                                tx_data <= mem_wdata[7:0]; tx_valid <= 1'b1; mem_ready <= 1'b1;
                            end
                            // else: stall until the transmitter is free
                        end else mem_ready <= 1'b1;
                    end else begin
                        // The core selects the byte lane from mem_addr[1:0],
                        // so replicate the register across all four lanes.
                        case (mem_addr[2:0])
                            3'd0: begin
                                mem_rdata <= {4{rx_empty ? 8'd0 : rxf[rx_rp]}};
                                if (!rx_empty) rx_rp <= rx_rp + 1'b1;
                            end
                            3'd5: mem_rdata <= {4{uart_lsr}};
                            default: mem_rdata <= 32'd0;
                        endcase
                        mem_ready <= 1'b1;
                    end
                end else if (sel_clint) begin
                    case (mem_addr[15:0])
                        16'h4000: begin if (is_write) mtimecmp[31:0]  <= mem_wdata; mem_rdata <= mtimecmp[31:0];  end
                        16'h4004: begin if (is_write) mtimecmp[63:32] <= mem_wdata; mem_rdata <= mtimecmp[63:32]; end
                        16'hBFF8: begin if (is_write) mtime[31:0]     <= mem_wdata; mem_rdata <= mtime[31:0];     end
                        16'hBFFC: begin if (is_write) mtime[63:32]    <= mem_wdata; mem_rdata <= mtime[63:32];    end
                        default:  mem_rdata <= 32'd0;
                    endcase
                    mem_ready <= 1'b1;
                end else if (sel_exit) begin
                    if (is_write) begin exit_code <= mem_wdata; exit_valid <= 1'b1; end
                    mem_rdata <= 32'd0;
                    mem_ready <= 1'b1;
                end else begin
                    // unmapped: read as zero, writes ignored
                    mem_rdata <= 32'd0;
                    mem_ready <= 1'b1;
                end
            end else if (pending) begin
                pending <= 1'b0;
                mem_rdata <= ram_q;
                mem_ready <= 1'b1;
            end
        end
    end

endmodule

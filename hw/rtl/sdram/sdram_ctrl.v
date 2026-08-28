// sdram_ctrl.v — minimal SDR SDRAM controller for the GW2AR-18's
// in-package 64 Mbit SDRAM (2M x 32: 4 banks x 2048 rows x 256 cols).
//
// One access at a time: ACTIVE → (tRCD) → READ/WRITE with auto-
// precharge → data (CL=2) → (tRP). No page mode, no pipelining —
// throughput is ~1 word per 7-8 clocks, which is plenty for a
// multi-cycle core at 27 MHz. AUTO REFRESH is issued from the idle
// state every REFRESH_CLKS clocks. The SDRAM clock is the controller
// clock (same phase); at 27 MHz every timing margin is generous.
//
// Bus: valid/ready handshake like the CPU port. `ready` pulses for one
// clock when the access completes (read data valid on that clock).
module sdram_ctrl #(
    parameter integer CLK_HZ = 27_000_000
) (
    input  wire        clk,
    input  wire        rst,
    // user port (word addressed)
    input  wire        valid,
    output reg         ready,
    input  wire [20:0] addr,      // {bank[1:0], row[10:0], col[7:0]}
    input  wire [31:0] wdata,
    input  wire [3:0]  wstrb,     // 0 = read
    output reg  [31:0] rdata,
    output reg         init_done,
    // SDRAM pins
    output wire        sdram_clk,
    output wire        sdram_cke,
    output wire        sdram_cs_n,
    output wire        sdram_ras_n,
    output wire        sdram_cas_n,
    output wire        sdram_we_n,
    output reg  [10:0] sdram_addr,
    output reg  [1:0]  sdram_ba,
    output reg  [3:0]  sdram_dqm,
    inout  wire [31:0] sdram_dq
);
    // Timing in clocks (conservative for 27..~70 MHz with a CL=2 part).
    localparam integer T_INIT_CLKS  = CLK_HZ / 5000;      // 200 us power-up wait
    localparam integer REFRESH_CLKS = CLK_HZ / 128000;    // ~7.8 us (2x margin over 15.6 us)
    localparam integer T_RP  = 2;
    localparam integer T_RFC = 4;
    localparam integer T_MRD = 2;
    localparam integer T_RCD = 2;
    localparam integer CL    = 2;

    // Commands: {cs_n, ras_n, cas_n, we_n}
    localparam [3:0] CMD_NOP   = 4'b0111;
    localparam [3:0] CMD_ACT   = 4'b0011;
    localparam [3:0] CMD_READ  = 4'b0101;
    localparam [3:0] CMD_WRITE = 4'b0100;
    localparam [3:0] CMD_PRE   = 4'b0010;
    localparam [3:0] CMD_REF   = 4'b0001;
    localparam [3:0] CMD_MRS   = 4'b0000;

    reg [3:0] cmd;
    assign {sdram_cs_n, sdram_ras_n, sdram_cas_n, sdram_we_n} = cmd;
    assign sdram_clk = clk;
    assign sdram_cke = 1'b1;

    reg        dq_oe;
    reg [31:0] dq_out;
    assign sdram_dq = dq_oe ? dq_out : 32'bz;

    localparam S_INIT_WAIT = 4'd0;
    localparam S_INIT_PRE  = 4'd1;
    localparam S_INIT_REF  = 4'd2;
    localparam S_INIT_MRS  = 4'd3;
    localparam S_IDLE      = 4'd4;
    localparam S_ACT       = 4'd5;
    localparam S_RW        = 4'd6;
    localparam S_WAIT      = 4'd7;
    localparam S_REF       = 4'd8;
    localparam S_PRE       = 4'd9;

    reg [3:0]  state;
    reg [15:0] cnt;          // generic wait counter
    reg [3:0]  init_refs;
    reg [9:0]  ref_timer;
    reg        ref_due;
    reg        is_write;
    reg [20:0] a_lat; reg [31:0] wd_lat; reg [3:0] ws_lat;
    reg [31:0] dq_in_r;

    always @(posedge clk) dq_in_r <= sdram_dq;   // registered input

    always @(posedge clk) begin
        if (rst) begin
            state <= S_INIT_WAIT; cnt <= 0; init_refs <= 0; ref_timer <= 0; ref_due <= 0;
            cmd <= CMD_NOP; sdram_addr <= 0; sdram_ba <= 0; sdram_dqm <= 4'hF;
            dq_oe <= 0; dq_out <= 0; ready <= 0; rdata <= 0; init_done <= 0; is_write <= 0;
            a_lat <= 0; wd_lat <= 0; ws_lat <= 0;
        end else begin
            cmd   <= CMD_NOP;
            ready <= 1'b0;
            dq_oe <= 1'b0;
            // refresh bookkeeping
            if (ref_timer == REFRESH_CLKS - 1) begin ref_timer <= 0; ref_due <= 1'b1; end
            else ref_timer <= ref_timer + 1'b1;

            case (state)
            S_INIT_WAIT: begin
                if (cnt == T_INIT_CLKS) begin cnt <= 0; state <= S_INIT_PRE; end
                else cnt <= cnt + 1'b1;
            end
            S_INIT_PRE: begin
                cmd <= CMD_PRE; sdram_addr <= 11'b100_0000_0000;   // A10 = all banks
                cnt <= 0; state <= S_INIT_REF; init_refs <= 0;
            end
            S_INIT_REF: begin
                if (cnt == T_RP + T_RFC) begin
                    cnt <= 0;
                    if (init_refs == 8) state <= S_INIT_MRS;
                    else begin cmd <= CMD_REF; init_refs <= init_refs + 1'b1; end
                end else cnt <= cnt + 1'b1;
            end
            S_INIT_MRS: begin
                // mode: burst length 1, sequential, CAS latency 2, standard write
                cmd <= CMD_MRS; sdram_ba <= 2'b00; sdram_addr <= 11'b000_0010_0000;
                cnt <= 0; state <= S_WAIT; init_done <= 1'b1;
            end
            S_IDLE: begin
                sdram_dqm <= 4'hF;
                if (ref_due) begin
                    ref_due <= 1'b0; cmd <= CMD_REF; cnt <= 0; state <= S_REF;
                end else if (valid && !ready) begin
                    a_lat <= addr; wd_lat <= wdata; ws_lat <= wstrb; is_write <= (wstrb != 4'b0);
                    cmd <= CMD_ACT; sdram_ba <= addr[20:19]; sdram_addr <= addr[18:8];
                    cnt <= 0; state <= S_ACT;
                end
            end
            S_ACT: begin
                if (cnt == T_RCD - 1) begin
                    cnt <= 0; state <= S_RW;
                    sdram_ba <= a_lat[20:19];
                    sdram_addr <= {1'b0, 1'b1, 1'b0, a_lat[7:0]};   // A10 = auto precharge
                    if (is_write) begin
                        cmd <= CMD_WRITE; sdram_dqm <= ~ws_lat; dq_oe <= 1'b1; dq_out <= wd_lat;
                    end else begin
                        cmd <= CMD_READ; sdram_dqm <= 4'h0;
                    end
                end else cnt <= cnt + 1'b1;
            end
            S_RW: begin
                // write: data was driven with the command; wait tWR + tRP.
                // read: data appears CL clocks after the command; dq_in_r
                // registers it one clock later.
                // Explicit per-bank PRECHARGE afterwards (belt and braces on
                // top of the A10 auto-precharge; see docs — the first
                // bring-up showed rows never changing).
                if (is_write) begin
                    if (cnt == 2) begin cnt <= 0; state <= S_PRE; cmd <= CMD_PRE; sdram_ba <= a_lat[20:19]; sdram_addr <= 11'b0; end
                    else cnt <= cnt + 1'b1;
                end else begin
                    if (cnt == CL + 2) begin rdata <= dq_in_r; cnt <= 0; state <= S_PRE; cmd <= CMD_PRE; sdram_ba <= a_lat[20:19]; sdram_addr <= 11'b0; end
                    else cnt <= cnt + 1'b1;
                end
                if (cnt == 0) dq_oe <= is_write;   // hold DQ one extra clock for the write
            end
            S_REF: begin
                if (cnt == T_RFC) state <= S_IDLE; else cnt <= cnt + 1'b1;
            end
            S_PRE: begin
                if (cnt == T_RP - 1) begin ready <= 1'b1; state <= S_IDLE; end else cnt <= cnt + 1'b1;
            end
            S_WAIT: begin
                if (cnt == T_MRD) state <= S_IDLE; else cnt <= cnt + 1'b1;
            end
            default: state <= S_IDLE;
            endcase
        end
    end
endmodule

// rv32_core.v — RV32IM + Zicsr (M-mode only) multi-cycle core.
//
// Non-pipelined FSM: FETCH → EXEC → (MEM | MULDIV) → FETCH. One
// memory port (PicoRV32-style valid/ready handshake, byte strobes).
// Written for the MTOS kernel's needs (docs/task/tang_nano_20k.md §3):
//   * RV32I + M + csrrw/csrrs/csrrc(+i), ecall, ebreak, mret, fence (nop)
//   * CSRs: mstatus mie mip mtvec mscratch mepc mcause mtval misa
//     mhartid mvendorid marchid mimpid, cycle/instret/time (+h)
//   * Exceptions: misaligned fetch/load/store, illegal instruction,
//     ecall-from-M, ebreak. Interrupt: machine timer only.
//   * mtvec direct mode only (low 2 bits ignored).
module rv32_core #(
    parameter [31:0] RESET_PC = 32'h8000_0000
) (
    input  wire        clk,
    input  wire        rst,
    // memory port
    output reg         mem_valid,
    input  wire        mem_ready,
    output reg  [31:0] mem_addr,
    output reg  [31:0] mem_wdata,
    output reg  [3:0]  mem_wstrb,     // 0 = read
    input  wire [31:0] mem_rdata,
    // interrupts
    input  wire        timer_irq,
    input  wire [63:0] mtime,         // for the `time` CSR
    output wire [31:0] dbg_pc,
    output wire [31:0] dbg_instr,
    output wire [2:0]  dbg_state
);
    // ---------------------------------------------------------------
    // State
    // ---------------------------------------------------------------
    localparam S_FETCH  = 3'd0;
    localparam S_EXEC   = 3'd1;
    localparam S_MEM    = 3'd2;
    localparam S_MULDIV = 3'd3;
    localparam S_TRAP   = 3'd4;

    reg [2:0]  state;
    reg [31:0] pc;
    assign dbg_pc = pc;
    reg [31:0] instr;
    assign dbg_instr = instr;
    assign dbg_state = state;
    reg [31:0] regs [0:31];

    // ---------------------------------------------------------------
    // Instruction cache (direct-mapped, 1024 lines = 4 KB). Makes S_FETCH
    // a ~1-2 cycle hit instead of a 3-cycle SDRAM-cache handshake, and
    // keeps instruction traffic off the shared data path. Coherent
    // WITHOUT fence.i: every CPU store invalidates the matching line, so
    // code written to RAM (the task loader, phase-7 /tmp/hw) is refetched
    // fresh. Flushed at reset. See docs/task/tang_nano_20k.md Phase 7.
    // ---------------------------------------------------------------
    localparam integer IC_LINES = 1024;
    reg [31:0] ic_data [0:IC_LINES-1];
    reg [19:0] ic_tag  [0:IC_LINES-1];
    reg        ic_val  [0:IC_LINES-1];
    reg [31:0] ic_data_q; reg [19:0] ic_tag_q; reg ic_val_q; reg [31:0] ic_raddr_q;
    reg        ic_flushing; reg [9:0] ic_flush_idx;
    wire [9:0] ic_ridx = pc[11:2];
    wire       ic_hit  = ic_val_q && (ic_tag_q == pc[31:12]) && (ic_raddr_q == pc) && !ic_flushing;
    // write side: reset-flush > store-invalidate > fill.
    wire       ic_fill = (state == S_FETCH) && mem_valid && mem_ready;   // fetch-miss capture cycle
    wire       ic_store_inv = (state == S_MEM) && (mem_wstrb != 4'b0) && mem_ready;
    wire [9:0] ic_widx = ic_flushing ? ic_flush_idx : (ic_store_inv ? mem_addr[11:2] : pc[11:2]);
    wire       ic_wr_v = ic_flushing || ic_store_inv || ic_fill;
    wire       ic_wval = ic_fill && !ic_store_inv && !ic_flushing;   // 1 = fill, 0 = flush/inval

    always @(posedge clk) begin
        if (ic_wr_v) ic_val[ic_widx] <= ic_wval;
        ic_val_q <= ic_val[ic_ridx];
    end
    always @(posedge clk) begin
        if (ic_fill && !ic_store_inv && !ic_flushing) ic_tag[pc[11:2]] <= pc[31:12];
        ic_tag_q <= ic_tag[ic_ridx];
    end
    always @(posedge clk) begin
        if (ic_fill && !ic_store_inv && !ic_flushing) ic_data[pc[11:2]] <= mem_rdata;
        ic_data_q <= ic_data[ic_ridx];
    end
    always @(posedge clk) begin
        ic_raddr_q <= pc;
        if (rst) begin ic_flushing <= 1'b1; ic_flush_idx <= 10'd0; end
        else if (ic_flushing) begin
            ic_flush_idx <= ic_flush_idx + 10'd1;
            if (ic_flush_idx == 10'd1023) ic_flushing <= 1'b0;
        end
    end

    // CSRs
    reg        mstatus_mie, mstatus_mpie;
    reg        mie_mtie;
    reg [31:0] mtvec, mscratch, mepc, mcause, mtval;
    reg [63:0] cycle_cnt, instret_cnt;

    // trap bookkeeping
    reg [31:0] trap_cause, trap_tval, trap_epc;

    // ---------------------------------------------------------------
    // Decode (combinational, from `instr`)
    // ---------------------------------------------------------------
    wire [6:0] opcode = instr[6:0];
    wire [4:0] rd     = instr[11:7];
    wire [2:0] funct3 = instr[14:12];
    wire [4:0] rs1    = instr[19:15];
    wire [4:0] rs2    = instr[24:20];
    wire [6:0] funct7 = instr[31:25];
    wire [11:0] csr_addr = instr[31:20];

    wire [31:0] imm_i = {{20{instr[31]}}, instr[31:20]};
    wire [31:0] imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    wire [31:0] imm_b = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
    wire [31:0] imm_u = {instr[31:12], 12'b0};
    wire [31:0] imm_j = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

    localparam OP_LUI    = 7'b0110111;
    localparam OP_AUIPC  = 7'b0010111;
    localparam OP_JAL    = 7'b1101111;
    localparam OP_JALR   = 7'b1100111;
    localparam OP_BRANCH = 7'b1100011;
    localparam OP_LOAD   = 7'b0000011;
    localparam OP_STORE  = 7'b0100011;
    localparam OP_IMM    = 7'b0010011;
    localparam OP_OP     = 7'b0110011;
    localparam OP_FENCE  = 7'b0001111;
    localparam OP_SYSTEM = 7'b1110011;

    wire [31:0] rs1_val = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
    wire [31:0] rs2_val = (rs2 == 5'd0) ? 32'd0 : regs[rs2];

    wire is_muldiv = (opcode == OP_OP) && (funct7 == 7'b0000001);

    // ALU
    wire [31:0] alu_b = (opcode == OP_IMM) ? imm_i : rs2_val;
    wire        alu_sub = (opcode == OP_OP) && funct7[5];
    wire        alu_sra = funct7[5];          // valid for funct3 == 101 in both OP and OP_IMM
    // Arithmetic shift computed on its own: inside the ?: below the
    // $signed() would be lost (unsigned context) and >>> turn logical.
    wire signed [31:0] rs1_signed = rs1_val;
    wire [31:0] sra_out = rs1_signed >>> alu_b[4:0];
    reg  [31:0] alu_out;
    always @(*) begin
        case (funct3)
            3'b000: alu_out = alu_sub ? (rs1_val - alu_b) : (rs1_val + alu_b);
            3'b001: alu_out = rs1_val << alu_b[4:0];
            3'b010: alu_out = {31'b0, $signed(rs1_val) < $signed(alu_b)};
            3'b011: alu_out = {31'b0, rs1_val < alu_b};
            3'b100: alu_out = rs1_val ^ alu_b;
            3'b101: alu_out = alu_sra ? sra_out : (rs1_val >> alu_b[4:0]);
            3'b110: alu_out = rs1_val | alu_b;
            default: alu_out = rs1_val & alu_b;
        endcase
    end

    // Branch condition
    reg br_take;
    always @(*) begin
        case (funct3)
            3'b000: br_take = (rs1_val == rs2_val);
            3'b001: br_take = (rs1_val != rs2_val);
            3'b100: br_take = ($signed(rs1_val) < $signed(rs2_val));
            3'b101: br_take = !($signed(rs1_val) < $signed(rs2_val));
            3'b110: br_take = (rs1_val < rs2_val);
            3'b111: br_take = !(rs1_val < rs2_val);
            default: br_take = 1'b0;
        endcase
    end

    wire [31:0] pc_plus4  = pc + 32'd4;
    wire [31:0] mem_ea    = rs1_val + ((opcode == OP_STORE) ? imm_s : imm_i);
    wire [31:0] jalr_tgt  = (rs1_val + imm_i) & 32'hFFFF_FFFE;

    // Illegal-instruction detection for the parts we implement.
    reg illegal;
    always @(*) begin
        illegal = 1'b0;
        case (opcode)
            OP_LUI, OP_AUIPC, OP_JAL: illegal = 1'b0;
            OP_JALR:   illegal = (funct3 != 3'b000);
            OP_BRANCH: illegal = (funct3 == 3'b010) || (funct3 == 3'b011);
            OP_LOAD:   illegal = (funct3 == 3'b011) || (funct3 == 3'b110) || (funct3 == 3'b111);
            OP_STORE:  illegal = (funct3 > 3'b010);
            OP_IMM: begin
                if (funct3 == 3'b001) illegal = (funct7 != 7'b0);
                else if (funct3 == 3'b101) illegal = (funct7 != 7'b0) && (funct7 != 7'b0100000);
            end
            OP_OP: begin
                if (funct7 == 7'b0000001) illegal = 1'b0;                      // M
                else if (funct7 == 7'b0100000) illegal = !(funct3 == 3'b000 || funct3 == 3'b101);
                else illegal = (funct7 != 7'b0);
            end
            OP_FENCE:  illegal = 1'b0;   // fence / fence.i → nop
            OP_SYSTEM: illegal = 1'b0;   // refined in the CSR/priv path below
            default:   illegal = 1'b1;
        endcase
    end

    // ---------------------------------------------------------------
    // CSR read mux
    // ---------------------------------------------------------------
    reg  [31:0] csr_rdata;
    reg         csr_known;
    always @(*) begin
        csr_known = 1'b1;
        case (csr_addr)
            12'h300: csr_rdata = {19'b0, 2'b11, 3'b0, mstatus_mpie, 3'b0, mstatus_mie, 3'b0}; // MPP=11
            12'h301: csr_rdata = 32'h4000_1100;   // misa: RV32IM
            12'h304: csr_rdata = {24'b0, mie_mtie, 7'b0};
            12'h305: csr_rdata = mtvec;
            12'h340: csr_rdata = mscratch;
            12'h341: csr_rdata = mepc;
            12'h342: csr_rdata = mcause;
            12'h343: csr_rdata = mtval;
            12'h344: csr_rdata = {24'b0, timer_irq, 7'b0};
            12'hF11, 12'hF12, 12'hF13, 12'hF14: csr_rdata = 32'd0; // vendor/arch/imp/hartid
            12'hC00, 12'hB00: csr_rdata = cycle_cnt[31:0];
            12'hC80, 12'hB80: csr_rdata = cycle_cnt[63:32];
            12'hC01: csr_rdata = mtime[31:0];
            12'hC81: csr_rdata = mtime[63:32];
            12'hC02, 12'hB02: csr_rdata = instret_cnt[31:0];
            12'hC82, 12'hB82: csr_rdata = instret_cnt[63:32];
            default: begin csr_rdata = 32'd0; csr_known = 1'b0; end
        endcase
    end
    wire [31:0] csr_src   = funct3[2] ? {27'b0, rs1} : rs1_val;
    reg  [31:0] csr_wdata;
    always @(*) begin
        case (funct3[1:0])
            2'b01:   csr_wdata = csr_src;
            2'b10:   csr_wdata = csr_rdata | csr_src;
            default: csr_wdata = csr_rdata & ~csr_src;
        endcase
    end
    // csrrs/csrrc with rs1 = x0 (or uimm = 0) must not write.
    wire csr_do_write = (funct3[1:0] == 2'b01) || (rs1 != 5'd0);

    // ---------------------------------------------------------------
    // Multiply / divide unit (sequential, 32 iterations)
    // ---------------------------------------------------------------
    reg  [5:0]  md_cnt;
    reg         md_prep;     // 1 = first S_MULDIV cycle: turn raw operands into absolutes
    reg         md_busy;
    reg  [63:0] md_acc;      // product accumulator / {remainder, quotient}
    reg  [31:0] md_a, md_b;  // |operands|
    reg         md_neg_out, md_neg_rem;
    wire        md_is_div   = funct3[2];
    wire        md_signed_a = (funct3 == 3'b000) || (funct3 == 3'b001) || (funct3 == 3'b010) ||
                              (funct3 == 3'b100) || (funct3 == 3'b110);
    wire        md_signed_b = (funct3 == 3'b000) || (funct3 == 3'b001) ||
                              (funct3 == 3'b100) || (funct3 == 3'b110);
    wire        a_neg = md_signed_a & rs1_val[31];
    wire        b_neg = md_signed_b & rs2_val[31];
    // The absolute values are computed in a dedicated first S_MULDIV
    // cycle (md_prep) from the latched raw operands — doing it
    // combinationally from the register file was the critical path.
    reg  [31:0] md_ra, md_rb;
    reg         md_a_neg, md_b_neg;

    // Restoring division step on {rem, quo} = md_acc, divisor md_b.
    wire [32:0] div_sub = {md_acc[62:31]} - {1'b0, md_b};   // (rem << 1 | next bit) - divisor
    reg  [31:0] md_result;
    always @(*) begin
        case (funct3)
            3'b000: md_result = md_neg_out ? (~md_acc[31:0] + 32'd1) : md_acc[31:0];               // mul
            3'b001, 3'b010, 3'b011: begin                                                          // mulh*
                if (md_neg_out) md_result = (~md_acc + 64'd1) >> 32;
                else            md_result = md_acc[63:32];
            end
            3'b100, 3'b101: md_result = md_neg_out ? (~md_acc[31:0] + 32'd1) : md_acc[31:0];       // div
            default:        md_result = md_neg_rem ? (~md_acc[63:32] + 32'd1) : md_acc[63:32];    // rem
        endcase
    end

    // ---------------------------------------------------------------
    // Load data formatting
    // ---------------------------------------------------------------
    reg [31:0] load_val;
    always @(*) begin
        case (funct3)
            3'b000: case (mem_addr[1:0])
                2'b00: load_val = {{24{mem_rdata[7]}},  mem_rdata[7:0]};
                2'b01: load_val = {{24{mem_rdata[15]}}, mem_rdata[15:8]};
                2'b10: load_val = {{24{mem_rdata[23]}}, mem_rdata[23:16]};
                default: load_val = {{24{mem_rdata[31]}}, mem_rdata[31:24]};
            endcase
            3'b001: load_val = mem_addr[1] ? {{16{mem_rdata[31]}}, mem_rdata[31:16]} : {{16{mem_rdata[15]}}, mem_rdata[15:0]};
            3'b100: case (mem_addr[1:0])
                2'b00: load_val = {24'b0, mem_rdata[7:0]};
                2'b01: load_val = {24'b0, mem_rdata[15:8]};
                2'b10: load_val = {24'b0, mem_rdata[23:16]};
                default: load_val = {24'b0, mem_rdata[31:24]};
            endcase
            3'b101: load_val = mem_addr[1] ? {16'b0, mem_rdata[31:16]} : {16'b0, mem_rdata[15:0]};
            default: load_val = mem_rdata;
        endcase
    end

    wire misaligned_ea = ((funct3[1:0] == 2'b01) && mem_ea[0]) ||
                         ((funct3[1:0] == 2'b10) && (mem_ea[1:0] != 2'b00));

    // ---------------------------------------------------------------
    // Interrupt pending
    // ---------------------------------------------------------------
    wire irq_pending = mstatus_mie & mie_mtie & timer_irq;

    // ---------------------------------------------------------------
    // Main FSM
    // ---------------------------------------------------------------
    integer i;
    task write_rd(input [4:0] r, input [31:0] v);
        begin if (r != 5'd0) regs[r] <= v; end
    endtask

    always @(posedge clk) begin
        if (rst) begin
            state <= S_FETCH; pc <= RESET_PC; instr <= 32'h13; // nop
            mem_valid <= 1'b0; mem_addr <= 0; mem_wdata <= 0; mem_wstrb <= 0;
            mstatus_mie <= 1'b0; mstatus_mpie <= 1'b0; mie_mtie <= 1'b0;
            mtvec <= 0; mscratch <= 0; mepc <= 0; mcause <= 0; mtval <= 0;
            cycle_cnt <= 0; instret_cnt <= 0;
            md_cnt <= 0; md_prep <= 0; md_busy <= 1'b0; md_acc <= 0; md_a <= 0; md_b <= 0; md_neg_out <= 0; md_neg_rem <= 0; md_ra <= 0; md_rb <= 0; md_a_neg <= 0; md_b_neg <= 0;
            trap_cause <= 0; trap_tval <= 0; trap_epc <= 0;
            for (i = 0; i < 32; i = i + 1) regs[i] <= 32'd0;
        end else begin
            cycle_cnt <= cycle_cnt + 64'd1;
            case (state)
            // ---------------------------------------------------------
            S_FETCH: begin
                if (!mem_valid) begin
                    if (irq_pending) begin
                        trap_cause <= 32'h8000_0007; trap_tval <= 32'd0; trap_epc <= pc;
                        state <= S_TRAP;
                    end else if (pc[1:0] != 2'b00) begin
                        trap_cause <= 32'd0; trap_tval <= pc; trap_epc <= pc;
                        state <= S_TRAP;
                    end else if (ic_raddr_q != pc || ic_flushing) begin
                        // I$ read not yet aligned to pc (just entered / flushing):
                        // wait one cycle for the registered read to catch up.
                    end else if (ic_hit) begin
                        instr <= ic_data_q;
                        state <= S_EXEC;
                    end else begin
                        // I$ miss: fetch from memory via the shared port.
                        mem_valid <= 1'b1; mem_addr <= pc; mem_wstrb <= 4'b0;
                    end
                end else if (mem_ready) begin
                    // ic_fill (wire) is high this cycle → the I$ arrays capture
                    // mem_rdata / pc into the line synchronously.
                    mem_valid <= 1'b0;
                    instr <= mem_rdata;
                    state <= S_EXEC;
                end
            end
            // ---------------------------------------------------------
            S_EXEC: begin
                instret_cnt <= instret_cnt + 64'd1;
                if (illegal) begin
                    trap_cause <= 32'd2; trap_tval <= instr; trap_epc <= pc; state <= S_TRAP;
                end else case (opcode)
                    OP_LUI:   begin write_rd(rd, imm_u);            pc <= pc_plus4; state <= S_FETCH; end
                    OP_AUIPC: begin write_rd(rd, pc + imm_u);       pc <= pc_plus4; state <= S_FETCH; end
                    OP_JAL:   begin write_rd(rd, pc_plus4);         pc <= pc + imm_j; state <= S_FETCH; end
                    OP_JALR:  begin write_rd(rd, pc_plus4);         pc <= jalr_tgt;   state <= S_FETCH; end
                    OP_BRANCH: begin pc <= br_take ? (pc + imm_b) : pc_plus4; state <= S_FETCH; end
                    OP_LOAD: begin
                        if (misaligned_ea) begin
                            trap_cause <= 32'd4; trap_tval <= mem_ea; trap_epc <= pc; state <= S_TRAP;
                        end else begin
                            mem_valid <= 1'b1; mem_addr <= mem_ea; mem_wstrb <= 4'b0; state <= S_MEM;
                        end
                    end
                    OP_STORE: begin
                        if (misaligned_ea) begin
                            trap_cause <= 32'd6; trap_tval <= mem_ea; trap_epc <= pc; state <= S_TRAP;
                        end else begin
                            mem_valid <= 1'b1; mem_addr <= mem_ea; state <= S_MEM;
                            case (funct3)
                                3'b000: begin
                                    mem_wdata <= {4{rs2_val[7:0]}};
                                    mem_wstrb <= 4'b0001 << mem_ea[1:0];
                                end
                                3'b001: begin
                                    mem_wdata <= {2{rs2_val[15:0]}};
                                    mem_wstrb <= mem_ea[1] ? 4'b1100 : 4'b0011;
                                end
                                default: begin
                                    mem_wdata <= rs2_val;
                                    mem_wstrb <= 4'b1111;
                                end
                            endcase
                        end
                    end
                    OP_IMM: begin write_rd(rd, alu_out); pc <= pc_plus4; state <= S_FETCH; end
                    OP_OP: begin
                        if (is_muldiv) begin
                            md_ra <= rs1_val; md_rb <= rs2_val;
                            md_a_neg <= a_neg; md_b_neg <= b_neg;
                            md_prep <= 1'b1;
                            md_cnt <= 6'd0;
                            // Sign of the result. Division by zero is special-cased
                            // below (quotient all-ones, remainder = dividend).
                            md_neg_out <= md_is_div ? (a_neg ^ b_neg) && (rs2_val != 32'd0)
                                                    : (a_neg ^ b_neg);
                            md_neg_rem <= a_neg;
                            state <= S_MULDIV;
                        end else begin
                            write_rd(rd, alu_out); pc <= pc_plus4; state <= S_FETCH;
                        end
                    end
                    OP_FENCE: begin pc <= pc_plus4; state <= S_FETCH; end
                    OP_SYSTEM: begin
                        if (funct3 == 3'b000) begin
                            case (instr[31:20])
                                12'h000: begin trap_cause <= 32'd11; trap_tval <= 0; trap_epc <= pc; state <= S_TRAP; end // ecall
                                12'h001: begin trap_cause <= 32'd3;  trap_tval <= 0; trap_epc <= pc; state <= S_TRAP; end // ebreak
                                12'h302: begin                                                                    // mret
                                    pc <= mepc; mstatus_mie <= mstatus_mpie; mstatus_mpie <= 1'b1; state <= S_FETCH;
                                end
                                12'h105: begin pc <= pc_plus4; state <= S_FETCH; end                              // wfi → nop
                                default: begin trap_cause <= 32'd2; trap_tval <= instr; trap_epc <= pc; state <= S_TRAP; end
                            endcase
                        end else if (funct3 == 3'b100 || !csr_known) begin
                            trap_cause <= 32'd2; trap_tval <= instr; trap_epc <= pc; state <= S_TRAP;
                        end else begin
                            write_rd(rd, csr_rdata);
                            if (csr_do_write) begin
                                case (csr_addr)
                                    12'h300: begin mstatus_mie <= csr_wdata[3]; mstatus_mpie <= csr_wdata[7]; end
                                    12'h304: mie_mtie <= csr_wdata[7];
                                    12'h305: mtvec <= {csr_wdata[31:2], 2'b00};
                                    12'h340: mscratch <= csr_wdata;
                                    12'h341: mepc <= {csr_wdata[31:1], 1'b0};
                                    12'h342: mcause <= csr_wdata;
                                    12'h343: mtval <= csr_wdata;
                                    default: ;   // read-only / counters: ignore
                                endcase
                            end
                            pc <= pc_plus4; state <= S_FETCH;
                        end
                    end
                    default: begin trap_cause <= 32'd2; trap_tval <= instr; trap_epc <= pc; state <= S_TRAP; end
                endcase
            end
            // ---------------------------------------------------------
            S_MEM: begin
                if (mem_ready) begin
                    mem_valid <= 1'b0; mem_wstrb <= 4'b0;
                    if (opcode == OP_LOAD) write_rd(rd, load_val);
                    pc <= pc_plus4; state <= S_FETCH;
                end
            end
            // ---------------------------------------------------------
            S_MULDIV: begin
                if (md_prep) begin
                    md_prep <= 1'b0;
                    md_a <= md_a_neg ? (~md_ra + 32'd1) : md_ra;
                    md_b <= md_b_neg ? (~md_rb + 32'd1) : md_rb;
                    md_acc <= md_is_div ? {32'd0, (md_a_neg ? (~md_ra + 32'd1) : md_ra)} : 64'd0;
                end else if (md_cnt == 6'd32) begin
                    if (md_is_div && md_b == 32'd0) begin
                        // div/divu by zero → all ones; rem/remu → dividend
                        write_rd(rd, funct3[1] ? rs1_val : 32'hFFFF_FFFF);
                    end else begin
                        write_rd(rd, md_result);
                    end
                    pc <= pc_plus4; state <= S_FETCH;
                end else begin
                    md_cnt <= md_cnt + 6'd1;
                    if (md_is_div) begin
                        // shift {rem, quo} left by one; subtract if it fits
                        if (div_sub[32] == 1'b0)
                            md_acc <= {div_sub[31:0], md_acc[30:0], 1'b1};
                        else
                            md_acc <= {md_acc[62:0], 1'b0};
                    end else begin
                        // shift-add: examine md_b bit 0, add md_a << cnt
                        if (md_b[0]) md_acc <= md_acc + ({32'd0, md_a} << md_cnt);
                        md_b <= md_b >> 1;
                    end
                end
            end
            // ---------------------------------------------------------
            S_TRAP: begin
                mepc   <= trap_epc;
                mcause <= trap_cause;
                mtval  <= trap_tval;
                mstatus_mpie <= mstatus_mie;
                mstatus_mie  <= 1'b0;
                pc <= mtvec;
                state <= S_FETCH;
            end
            default: state <= S_FETCH;
            endcase
        end
    end
endmodule

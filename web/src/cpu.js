// cpu.js — RV32IM + Zicsr interpreter, M-mode only.
//
// Mirrors the subset the hw/ core implements and the kernel needs
// (docs/task/tang_nano_20k.md §3): the 6 CSRs mstatus / mie / mtvec /
// mscratch / mepc / mcause, ecall / mret, and a timer interrupt from the
// CLINT in soc.js. No A / C / F; fence and wfi are nops.
//
// Unknown instructions and fetches outside RAM stop the emulator with a
// CpuError (debug aid) instead of raising an illegal-instruction trap.
// Misaligned loads/stores trap (cause 4 / 6) like the hw core.

export const RAM_BASE = 0x80000000;

export const CAUSE_INSN_MISALIGNED = 0;
export const CAUSE_ILLEGAL = 2;
export const CAUSE_BREAKPOINT = 3;
export const CAUSE_LOAD_MISALIGNED = 4;
export const CAUSE_STORE_MISALIGNED = 6;
export const CAUSE_ECALL_M = 11;
export const CAUSE_MTIMER = 0x80000007;

const MSTATUS_MIE = 0x8;
const MSTATUS_MPIE = 0x80;
const MSTATUS_MPP = 0x1800;
const MIE_MTIE = 0x80;

export class CpuError extends Error {
  constructor(msg, cpu) {
    super(msg + " @ pc=" + hex(cpu.pc));
    this.cpu = cpu;
  }
}

export function hex(v) {
  return "0x" + (v >>> 0).toString(16).padStart(8, "0");
}

// High 32 bits of the unsigned 64-bit product a * b (16-bit limbs, no BigInt).
function mulhu(a, b) {
  a >>>= 0;
  b >>>= 0;
  const al = a & 0xffff, ah = a >>> 16, bl = b & 0xffff, bh = b >>> 16;
  const ll = al * bl, lh = al * bh, hl = ah * bl, hh = ah * bh;
  const mid = (ll >>> 16) + (lh & 0xffff) + (hl & 0xffff);
  return (hh + (lh >>> 16) + (hl >>> 16) + (mid >>> 16)) >>> 0;
}

export class Cpu {
  constructor(soc) {
    this.soc = soc;
    this.x = new Int32Array(32);
    this.pc = RAM_BASE | 0;
    this.mstatus = MSTATUS_MPP; // MPP reads as 3 (M-mode)
    this.mie = 0;
    this.mtvec = 0;
    this.mscratch = 0;
    this.mepc = 0;
    this.mcause = 0;
    this.mtval = 0;
    this.insns = 0;
    this.halted = false;
  }

  reset(pc = RAM_BASE) {
    this.x.fill(0);
    this.pc = pc | 0;
    this.mstatus = MSTATUS_MPP;
    this.mie = 0;
    this.mtvec = 0;
    this.mscratch = 0;
    this.mepc = 0;
    this.mcause = 0;
    this.mtval = 0;
    this.insns = 0;
    this.halted = false;
  }

  trap(cause, tval) {
    this.mepc = this.pc;
    this.mcause = cause | 0;
    this.mtval = tval | 0;
    let s = this.mstatus;
    s = (s & ~MSTATUS_MPIE) | ((s & MSTATUS_MIE) ? MSTATUS_MPIE : 0);
    s &= ~MSTATUS_MIE;
    s |= MSTATUS_MPP;
    this.mstatus = s;
    this.pc = (this.mtvec & ~3) | 0;
  }

  mret() {
    let s = this.mstatus;
    s = (s & ~MSTATUS_MIE) | ((s & MSTATUS_MPIE) ? MSTATUS_MIE : 0);
    s |= MSTATUS_MPIE | MSTATUS_MPP;
    this.mstatus = s;
    this.pc = this.mepc | 0;
  }

  csrRead(csr) {
    switch (csr) {
      case 0x300: return this.mstatus;
      case 0x304: return this.mie;
      case 0x305: return this.mtvec;
      case 0x340: return this.mscratch;
      case 0x341: return this.mepc;
      case 0x342: return this.mcause;
      case 0x343: return this.mtval;
      case 0x344: return this.soc.timerPending() ? MIE_MTIE : 0; // mip
      case 0x301: return 0x40001100; // misa: RV32IM
      case 0xf14: return 0; // mhartid
      case 0xc00: case 0xc02: case 0xb00: case 0xb02: return this.insns | 0; // cycle / instret (lo)
      case 0xc80: case 0xc82: case 0xb80: case 0xb82: return (this.insns / 4294967296) | 0;
      default: return 0;
    }
  }

  csrWrite(csr, v) {
    switch (csr) {
      case 0x300: this.mstatus = (v & (MSTATUS_MIE | MSTATUS_MPIE)) | MSTATUS_MPP; break;
      case 0x304: this.mie = v & MIE_MTIE; break;
      case 0x305: this.mtvec = v | 0; break;
      case 0x340: this.mscratch = v | 0; break;
      case 0x341: this.mepc = (v & ~1) | 0; break;
      case 0x342: this.mcause = v | 0; break;
      case 0x343: this.mtval = v | 0; break;
      default: break; // read-only / unimplemented: ignore
    }
  }

  // Execute up to n instructions. Returns the number actually executed.
  // Stops early when the SoC halts (exit device).
  run(n) {
    const soc = this.soc;
    const x = this.x;
    const ram32 = soc.ram32;
    const ram16 = soc.ram16;
    const ram8 = soc.ram8;
    const ramSize = soc.ramSize;
    let pc = this.pc | 0;
    let done = 0;

    for (; done < n; done++) {
      if (soc.halted) break;

      // ---- timer interrupt ----
      if ((this.mstatus & MSTATUS_MIE) && (this.mie & MIE_MTIE) && soc.mtime >= soc.mtimecmp) {
        this.pc = pc;
        this.trap(CAUSE_MTIMER, 0);
        pc = this.pc;
      }

      // ---- fetch ----
      const off = (pc - RAM_BASE) >>> 0;
      if (off >= ramSize) {
        this.pc = pc;
        throw new CpuError("fetch outside RAM", this);
      }
      if (pc & 3) {
        this.pc = pc;
        this.trap(CAUSE_INSN_MISALIGNED, pc);
        pc = this.pc;
        continue;
      }
      const insn = ram32[off >> 2];
      const opcode = insn & 0x7f;
      const rd = (insn >>> 7) & 0x1f;
      const rs1 = (insn >>> 15) & 0x1f;
      const rs2 = (insn >>> 20) & 0x1f;
      const funct3 = (insn >>> 12) & 7;
      let nextPc = (pc + 4) | 0;

      switch (opcode) {
        case 0x37: // lui
          if (rd) x[rd] = insn & 0xfffff000;
          break;
        case 0x17: // auipc
          if (rd) x[rd] = (pc + (insn & 0xfffff000)) | 0;
          break;
        case 0x6f: { // jal
          const imm = ((insn >> 31) << 20) | (((insn >>> 12) & 0xff) << 12) |
                      (((insn >>> 20) & 1) << 11) | (((insn >>> 21) & 0x3ff) << 1);
          if (rd) x[rd] = nextPc;
          nextPc = (pc + imm) | 0;
          break;
        }
        case 0x67: { // jalr
          const target = ((x[rs1] + (insn >> 20)) & ~1) | 0;
          if (rd) x[rd] = nextPc;
          nextPc = target;
          break;
        }
        case 0x63: { // branches
          const a = x[rs1], b = x[rs2];
          let take;
          switch (funct3) {
            case 0: take = a === b; break;
            case 1: take = a !== b; break;
            case 4: take = a < b; break;
            case 5: take = a >= b; break;
            case 6: take = (a >>> 0) < (b >>> 0); break;
            case 7: take = (a >>> 0) >= (b >>> 0); break;
            default: this.pc = pc; throw new CpuError("bad branch funct3", this);
          }
          if (take) {
            const imm = ((insn >> 31) << 12) | (((insn >>> 7) & 1) << 11) |
                        (((insn >>> 25) & 0x3f) << 5) | (((insn >>> 8) & 0xf) << 1);
            nextPc = (pc + imm) | 0;
          }
          break;
        }
        case 0x03: { // loads
          const addr = (x[rs1] + (insn >> 20)) | 0;
          const o = (addr - RAM_BASE) >>> 0;
          let v;
          switch (funct3) {
            case 0: // lb
              v = o < ramSize ? ram8[o] : soc.mmioRead(addr >>> 0, 1);
              v = (v << 24) >> 24;
              break;
            case 1: // lh
              if (addr & 1) { this.pc = pc; this.trap(CAUSE_LOAD_MISALIGNED, addr); pc = this.pc; continue; }
              v = o < ramSize ? ram16[o >> 1] : soc.mmioRead(addr >>> 0, 2);
              v = (v << 16) >> 16;
              break;
            case 2: // lw
              if (addr & 3) { this.pc = pc; this.trap(CAUSE_LOAD_MISALIGNED, addr); pc = this.pc; continue; }
              v = o < ramSize ? ram32[o >> 2] : soc.mmioRead(addr >>> 0, 4);
              break;
            case 4: // lbu
              v = o < ramSize ? ram8[o] : (soc.mmioRead(addr >>> 0, 1) & 0xff);
              break;
            case 5: // lhu
              if (addr & 1) { this.pc = pc; this.trap(CAUSE_LOAD_MISALIGNED, addr); pc = this.pc; continue; }
              v = o < ramSize ? ram16[o >> 1] : (soc.mmioRead(addr >>> 0, 2) & 0xffff);
              break;
            default: this.pc = pc; throw new CpuError("bad load funct3", this);
          }
          if (rd) x[rd] = v;
          break;
        }
        case 0x23: { // stores
          const imm = ((insn >> 25) << 5) | ((insn >>> 7) & 0x1f);
          const addr = (x[rs1] + imm) | 0;
          const o = (addr - RAM_BASE) >>> 0;
          const v = x[rs2];
          switch (funct3) {
            case 0:
              if (o < ramSize) ram8[o] = v; else soc.mmioWrite(addr >>> 0, 1, v & 0xff);
              break;
            case 1:
              if (addr & 1) { this.pc = pc; this.trap(CAUSE_STORE_MISALIGNED, addr); pc = this.pc; continue; }
              if (o < ramSize) ram16[o >> 1] = v; else soc.mmioWrite(addr >>> 0, 2, v & 0xffff);
              break;
            case 2:
              if (addr & 3) { this.pc = pc; this.trap(CAUSE_STORE_MISALIGNED, addr); pc = this.pc; continue; }
              if (o < ramSize) ram32[o >> 2] = v; else soc.mmioWrite(addr >>> 0, 4, v >>> 0);
              break;
            default: this.pc = pc; throw new CpuError("bad store funct3", this);
          }
          break;
        }
        case 0x13: { // op-imm
          const a = x[rs1];
          const imm = insn >> 20;
          let v;
          switch (funct3) {
            case 0: v = (a + imm) | 0; break;
            case 1: v = a << (imm & 31); break;
            case 2: v = a < imm ? 1 : 0; break;
            case 3: v = (a >>> 0) < (imm >>> 0) ? 1 : 0; break;
            case 4: v = a ^ imm; break;
            case 5: v = (insn & 0x40000000) ? (a >> (imm & 31)) : (a >>> (imm & 31)); break;
            case 6: v = a | imm; break;
            case 7: v = a & imm; break;
          }
          if (rd) x[rd] = v;
          break;
        }
        case 0x33: { // op
          const a = x[rs1], b = x[rs2];
          const funct7 = insn >>> 25;
          let v;
          if (funct7 === 1) { // M extension
            switch (funct3) {
              case 0: v = Math.imul(a, b); break;
              case 1: v = (mulhu(a, b) - (a < 0 ? (b >>> 0) : 0) - (b < 0 ? (a >>> 0) : 0)) | 0; break; // mulh
              case 2: v = (mulhu(a, b) - (a < 0 ? (b >>> 0) : 0)) | 0; break; // mulhsu
              case 3: v = mulhu(a, b) | 0; break;
              case 4: v = b === 0 ? -1 : (a === -2147483648 && b === -1) ? a : (a / b) | 0; break; // div
              case 5: v = b === 0 ? -1 : Math.floor((a >>> 0) / (b >>> 0)) | 0; break; // divu
              case 6: v = b === 0 ? a : (a === -2147483648 && b === -1) ? 0 : (a % b) | 0; break; // rem
              case 7: v = b === 0 ? a : ((a >>> 0) % (b >>> 0)) | 0; break; // remu
            }
          } else if (funct7 === 0 || funct7 === 0x20) {
            const alt = funct7 === 0x20;
            switch (funct3) {
              case 0: v = alt ? (a - b) | 0 : (a + b) | 0; break;
              case 1: v = a << (b & 31); break;
              case 2: v = a < b ? 1 : 0; break;
              case 3: v = (a >>> 0) < (b >>> 0) ? 1 : 0; break;
              case 4: v = a ^ b; break;
              case 5: v = alt ? (a >> (b & 31)) : (a >>> (b & 31)); break;
              case 6: v = a | b; break;
              case 7: v = a & b; break;
            }
          } else {
            this.pc = pc; throw new CpuError("bad op funct7 " + funct7, this);
          }
          if (rd) x[rd] = v;
          break;
        }
        case 0x0f: // fence / fence.i: nop
          break;
        case 0x73: { // system
          const csr = insn >>> 20;
          if (funct3 === 0) {
            switch (csr) {
              case 0x000: // ecall
                this.pc = pc; this.trap(CAUSE_ECALL_M, 0); pc = this.pc; soc.mtime++; continue;
              case 0x001: // ebreak
                this.pc = pc; this.trap(CAUSE_BREAKPOINT, pc); pc = this.pc; soc.mtime++; continue;
              case 0x302: // mret
                this.mret(); nextPc = this.pc; break;
              case 0x105: // wfi: nop
                break;
              default:
                this.pc = pc; throw new CpuError("bad system insn " + hex(insn), this);
            }
          } else {
            const old = this.csrRead(csr);
            const src = (funct3 & 4) ? rs1 : x[rs1];
            switch (funct3 & 3) {
              case 1: this.csrWrite(csr, src); break; // csrrw
              case 2: if (rs1 !== 0) this.csrWrite(csr, old | src); break; // csrrs
              case 3: if (rs1 !== 0) this.csrWrite(csr, old & ~src); break; // csrrc
              default: this.pc = pc; throw new CpuError("bad csr funct3", this);
            }
            if (rd) x[rd] = old;
          }
          break;
        }
        default:
          this.pc = pc;
          throw new CpuError("unknown opcode " + hex(insn), this);
      }
      pc = nextPc;
      soc.mtime++;
    }
    this.pc = pc;
    this.insns += done;
    return done;
  }

  dump() {
    const names = ["zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2", "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
                   "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"];
    const lines = ["pc=" + hex(this.pc) + " insns=" + this.insns + " mstatus=" + hex(this.mstatus) +
                   " mie=" + hex(this.mie) + " mtvec=" + hex(this.mtvec) + " mepc=" + hex(this.mepc) +
                   " mcause=" + hex(this.mcause)];
    for (let i = 0; i < 32; i += 4) {
      lines.push([0, 1, 2, 3].map(j => names[i + j].padStart(4) + "=" + hex(this.x[i + j])).join("  "));
    }
    return lines.join("\n");
  }
}

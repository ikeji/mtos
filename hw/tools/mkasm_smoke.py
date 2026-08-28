#!/usr/bin/env python3
"""Hand-encoded RV32I smoke program: prints "Hi\n" on the UART, writes
0x5555 to the exit device (sim: PASS + finish; board: LEDs), then keeps
printing "Hi\n" every ~0.5 s so a late UART listener still sees it.
Emits raw bin to argv[1]."""
import struct, sys
def r(op, rd, f3, rs1, rs2, f7): return op | rd<<7 | f3<<12 | rs1<<15 | rs2<<20 | f7<<25
def i(op, rd, f3, rs1, imm): return op | rd<<7 | f3<<12 | rs1<<15 | (imm & 0xfff)<<20
def s(op, f3, rs1, rs2, imm): return op | (imm&0x1f)<<7 | f3<<12 | rs1<<15 | rs2<<20 | ((imm>>5)&0x7f)<<25
def u(op, rd, imm20): return op | rd<<7 | (imm20 & 0xfffff)<<12
def j(op, rd, off):
    return op | rd<<7 | ((off>>12)&0xff)<<12 | ((off>>11)&1)<<20 | ((off>>1)&0x3ff)<<21 | ((off>>20)&1)<<31
def b(f3, rs1, rs2, off):
    return 0x63 | ((off>>11)&1)<<7 | ((off>>1)&0xf)<<8 | f3<<12 | rs1<<15 | rs2<<20 | ((off>>5)&0x3f)<<25 | ((off>>12)&1)<<31
T0, T1, T2 = 5, 6, 7
prog = [
    u(0x37, T0, 0x10000),          # lui t0, 0x10000  → 0x10000000
    i(0x13, T1, 0, 0, ord('H')),   # addi t1, x0, 'H'
    s(0x23, 0, T0, T1, 0),         # sb t1, 0(t0)
    i(0x13, T1, 0, 0, ord('i')),
    s(0x23, 0, T0, T1, 0),
    i(0x13, T1, 0, 0, 10),
    s(0x23, 0, T0, T1, 0),
    u(0x37, T0, 0x100),            # lui t0, 0x100 → 0x00100000
    u(0x37, T1, 0x5),              # lui t1, 5
    i(0x13, T1, 0, T1, 0x555),     # addi t1, t1, 0x555 → 0x5555
    s(0x23, 2, T0, T1, 0),         # sw t1, 0(t0)
    # loop: print "Hi\n" then busy-wait ~0.5 s (27 MHz, ~4 cycles/iter)
    u(0x37, T0, 0x10000),          # 12: lui t0, 0x10000
    i(0x13, T1, 0, 0, ord('H')),   # 13
    s(0x23, 0, T0, T1, 0),         # 14
    i(0x13, T1, 0, 0, ord('i')),   # 15
    s(0x23, 0, T0, T1, 0),         # 16
    i(0x13, T1, 0, 0, 10),         # 17
    s(0x23, 0, T0, T1, 0),         # 18
    u(0x37, T2, 0x300),            # 19: lui t2, 0x300 → 3145728
    i(0x13, T2, 0, T2, -1),        # 20: addi t2, t2, -1
    b(1, T2, 0, -4),               # 21: bnez t2, -4
    j(0x6f, 0, -9*4),              # 22: j 13 (skip the lui)
]
open(sys.argv[1], 'wb').write(b''.join(struct.pack('<I', w) for w in prog))

// riscv_test.h — minimal riscv-tests environment for the hw/ SoC.
// PASS → write 0x5555 to the exit device; FAIL → 0x3333 | testnum << 16.
#ifndef _ENV_TN20K_TEST_H
#define _ENV_TN20K_TEST_H

#define RVTEST_RV32U
#define RVTEST_RV32M
#define RVTEST_RV32S

#define TESTNUM gp

#define RVTEST_CODE_BEGIN            \
        .section .text.init;         \
        .globl _start;               \
_start:                              \
        la t0, trap_vector;          \
        csrw mtvec, t0;              \
        li TESTNUM, 0;               \
        j reset_vector;              \
trap_vector:                         \
        /* any trap = fail with mcause in the code */ \
        csrr t5, mcause;             \
        slli t5, t5, 16;             \
        li t6, 0x3333;               \
        or t5, t5, t6;               \
        li t6, 0x100000;             \
        sw t5, 0(t6);                \
1:      j 1b;                        \
reset_vector:

#define RVTEST_CODE_END

#define RVTEST_PASS                  \
        li t5, 0x5555;               \
        li t6, 0x100000;             \
        sw t5, 0(t6);                \
1:      j 1b;

#define RVTEST_FAIL                  \
        slli TESTNUM, TESTNUM, 16;   \
        ori TESTNUM, TESTNUM, 0x333; \
        li t6, 0x100000;             \
        sw TESTNUM, 0(t6);           \
1:      j 1b;

#define RVTEST_DATA_BEGIN .align 4; .global begin_signature; begin_signature:
#define RVTEST_DATA_END .align 4; .global end_signature; end_signature:

#endif

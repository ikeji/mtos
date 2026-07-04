    .text
    .align 2

    .globl put_sl__StringLiteral
    .type  put_sl__StringLiteral, @function
put_sl__StringLiteral:
    # prologue: frame_size=48, params=1, locals=3, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_put_sl__StringLiteral_pc8:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_put_sl__StringLiteral_pc24
0:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    j    .L_put_sl__StringLiteral_pc8
  .L_put_sl__StringLiteral_pc24:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of put_sl__StringLiteral

    .globl put2__i32
    .type  put2__i32, @function
put2__i32:
    # prologue: frame_size=48, params=1, locals=1, eval_depth=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    div  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    andi t0, t0, 0xff
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    rem  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    andi t0, t0, 0xff
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U8Array__i32__u8
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of put2__i32

    .globl main
    .type  main, @function
main:
    # prologue: frame_size=16, params=0, locals=0, eval_depth=2
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    la   t0, __put_sl__StringLiteral_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call put_sl__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t0, __put_sl__StringLiteral_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call put_sl__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t0, __put_sl__StringLiteral_strobj1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call put_sl__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t0, __put_sl__StringLiteral_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, G_ADD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call put2__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
    # end of main

    .data
    .globl G_ADD
G_ADD:
    .word 10

    .section .rodata
    .align 4
__put_sl__StringLiteral_strobj0:
    .word 15
    .string "hi, global str!"
    .align 4
__put_sl__StringLiteral_strobj1:
    .word 4
    .string "tail"


    .text
    .align 2

    .globl StringBuffer__U8Array__i32__i32
    .type  StringBuffer__U8Array__i32__i32, @function
StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=48, params=3, locals=1, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
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
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
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
    # end of StringBuffer__U8Array__i32__i32

    .globl buf__StringBuffer
    .type  buf__StringBuffer, @function
buf__StringBuffer:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of buf__StringBuffer

    .globl pos__StringBuffer
    .type  pos__StringBuffer, @function
pos__StringBuffer:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
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
    # end of pos__StringBuffer

    .globl fd__StringBuffer
    .type  fd__StringBuffer, @function
fd__StringBuffer:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
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
    # end of fd__StringBuffer

    .globl buf__StringBuffer__U8Array
    .type  buf__StringBuffer__U8Array, @function
buf__StringBuffer__U8Array:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
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
    # end of buf__StringBuffer__U8Array

    .globl pos__StringBuffer__i32
    .type  pos__StringBuffer__i32, @function
pos__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
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
    # end of pos__StringBuffer__i32

    .globl fd__StringBuffer__i32
    .type  fd__StringBuffer__i32, @function
fd__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
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
    # end of fd__StringBuffer__i32

    .globl delete__StringBuffer
    .type  delete__StringBuffer, @function
delete__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U32Array
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
    # end of delete__StringBuffer

    .globl StringBufferArray__u32
    .type  StringBufferArray__u32, @function
StringBufferArray__u32:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of StringBufferArray__u32

    .globl len__StringBufferArray
    .type  len__StringBufferArray, @function
len__StringBufferArray:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__U32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of len__StringBufferArray

    .globl get__StringBufferArray__i32
    .type  get__StringBufferArray__i32, @function
get__StringBufferArray__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of get__StringBufferArray__i32

    .globl set__StringBufferArray__i32__StringBuffer
    .type  set__StringBufferArray__i32__StringBuffer, @function
set__StringBufferArray__i32__StringBuffer:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__U32Array__i32__u32
    addi sp, sp, 12
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
    # end of set__StringBufferArray__i32__StringBuffer

    .globl delete__StringBufferArray
    .type  delete__StringBufferArray, @function
delete__StringBufferArray:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U32Array
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
    # end of delete__StringBufferArray

    .globl StringBuffer_new
    .type  StringBuffer_new, @function
StringBuffer_new:
    # prologue: frame_size=32, params=0, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    li   t0, 124
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call StringBuffer__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of StringBuffer_new

    .globl StringBuffer_new__i32
    .type  StringBuffer_new__i32, @function
StringBuffer_new__i32:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call StringBuffer__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of StringBuffer_new__i32

    .globl destroy__StringBuffer
    .type  destroy__StringBuffer, @function
destroy__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__StringBuffer
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
    # end of destroy__StringBuffer

    .globl grow__StringBuffer
    .type  grow__StringBuffer, @function
grow__StringBuffer:
    # prologue: frame_size=48, params=1, locals=5, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_grow__StringBuffer_pc16:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_grow__StringBuffer_pc32
0:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -32(s0)
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
    sw   t0, -32(s0)
    j    .L_grow__StringBuffer_pc16
  .L_grow__StringBuffer_pc32:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call buf__StringBuffer__U8Array
    addi sp, sp, 8
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
    # end of grow__StringBuffer

    .globl emit_char__StringBuffer__u8
    .type  emit_char__StringBuffer__u8, @function
emit_char__StringBuffer__u8:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call len__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_char__StringBuffer__u8_pc28
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fd__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_char__StringBuffer__u8_pc25
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call fd__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_char__StringBuffer__u8_pc28
  .L_emit_char__StringBuffer__u8_pc25:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call grow__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_emit_char__StringBuffer__u8_pc28:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
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
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
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
    # end of emit_char__StringBuffer__u8

    .globl emit_nl__StringBuffer
    .type  emit_nl__StringBuffer, @function
emit_nl__StringBuffer:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
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
    # end of emit_nl__StringBuffer

    .globl emit_string__StringBuffer__StringLiteral
    .type  emit_string__StringBuffer__StringLiteral, @function
emit_string__StringBuffer__StringLiteral:
    # prologue: frame_size=48, params=2, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_emit_string__StringBuffer__StringLiteral_pc5:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_emit_string__StringBuffer__StringLiteral_pc20
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
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
    sw   t0, -20(s0)
    j    .L_emit_string__StringBuffer__StringLiteral_pc5
  .L_emit_string__StringBuffer__StringLiteral_pc20:
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
    # end of emit_string__StringBuffer__StringLiteral

    .globl emit_string__StringBuffer__String
    .type  emit_string__StringBuffer__String, @function
emit_string__StringBuffer__String:
    # prologue: frame_size=48, params=2, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__String
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_emit_string__StringBuffer__String_pc5:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_emit_string__StringBuffer__String_pc20
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__String__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
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
    sw   t0, -20(s0)
    j    .L_emit_string__StringBuffer__String_pc5
  .L_emit_string__StringBuffer__String_pc20:
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
    # end of emit_string__StringBuffer__String

    .globl emit_int__StringBuffer__i32
    .type  emit_int__StringBuffer__i32, @function
emit_int__StringBuffer__i32:
    # prologue: frame_size=64, params=2, locals=5, eval_depth=5
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2147483647
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_int__StringBuffer__i32_pc55
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 50
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 55
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 51
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 54
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 52
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_emit_int__StringBuffer__i32_pc55:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_emit_int__StringBuffer__i32_pc67
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
  .L_emit_int__StringBuffer__i32_pc67:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_int__StringBuffer__i32_pc76
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_emit_int__StringBuffer__i32_pc76:
    la   t1, g_emit_int_tmp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_int__StringBuffer__i32_pc84
0:
    li   t0, 12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_emit_int_tmp
    sw   t0, 0(t1)
  .L_emit_int__StringBuffer__i32_pc84:
    la   t1, g_emit_int_tmp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_emit_int__StringBuffer__i32_pc90:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_int__StringBuffer__i32_pc113
0:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
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
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    lw   t0, -32(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    j    .L_emit_int__StringBuffer__i32_pc90
  .L_emit_int__StringBuffer__i32_pc113:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_emit_int__StringBuffer__i32_pc117:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_int__StringBuffer__i32_pc132
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    j    .L_emit_int__StringBuffer__i32_pc117
  .L_emit_int__StringBuffer__i32_pc132:
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
    # end of emit_int__StringBuffer__i32

    .globl emit_escaped__StringBuffer__U8Array__i32__i32
    .type  emit_escaped__StringBuffer__U8Array__i32__i32, @function
emit_escaped__StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc2:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc66
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc21
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc21:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc30
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc30:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc39
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc39:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc48
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc48:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc57
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc57:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc61:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc2
  .L_emit_escaped__StringBuffer__U8Array__i32__i32_pc66:
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
    # end of emit_escaped__StringBuffer__U8Array__i32__i32

    .globl emit_n__StringBuffer__U8Array__i32__i32
    .type  emit_n__StringBuffer__U8Array__i32__i32, @function
emit_n__StringBuffer__U8Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=1, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_emit_n__StringBuffer__U8Array__i32__i32_pc2:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_emit_n__StringBuffer__U8Array__i32__i32_pc19
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_emit_n__StringBuffer__U8Array__i32__i32_pc2
  .L_emit_n__StringBuffer__U8Array__i32__i32_pc19:
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
    # end of emit_n__StringBuffer__U8Array__i32__i32

    .globl emit_indent__StringBuffer__i32
    .type  emit_indent__StringBuffer__i32, @function
emit_indent__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=2, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_emit_indent__StringBuffer__i32_pc6:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_emit_indent__StringBuffer__i32_pc19
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
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
    j    .L_emit_indent__StringBuffer__i32_pc6
  .L_emit_indent__StringBuffer__i32_pc19:
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
    # end of emit_indent__StringBuffer__i32

    .globl append__StringBuffer__StringBuffer
    .type  append__StringBuffer__StringBuffer, @function
append__StringBuffer__StringBuffer:
    # prologue: frame_size=48, params=2, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
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
  .L_append__StringBuffer__StringBuffer_pc5:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_append__StringBuffer__StringBuffer_pc21
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
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
    j    .L_append__StringBuffer__StringBuffer_pc5
  .L_append__StringBuffer__StringBuffer_pc21:
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
    # end of append__StringBuffer__StringBuffer

    .globl length__StringBuffer
    .type  length__StringBuffer, @function
length__StringBuffer:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of length__StringBuffer

    .globl char_at__StringBuffer__i32
    .type  char_at__StringBuffer__i32, @function
char_at__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of char_at__StringBuffer__i32

    .globl reset__StringBuffer
    .type  reset__StringBuffer, @function
reset__StringBuffer:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pos__StringBuffer__i32
    addi sp, sp, 8
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
    # end of reset__StringBuffer

    .globl write__StringBuffer__i32
    .type  write__StringBuffer__i32, @function
write__StringBuffer__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call buf__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call pos__StringBuffer
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
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
    # end of write__StringBuffer__i32

    .globl is_digit__u8
    .type  is_digit__u8, @function
is_digit__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_digit__u8_pc10
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_digit__u8_pc10
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_digit__u8_pc11
  .L_is_digit__u8_pc10:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_digit__u8_pc11:
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
    # end of is_digit__u8

    .globl is_alpha__u8
    .type  is_alpha__u8, @function
is_alpha__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=5
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_alpha__u8_pc10
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 122
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_alpha__u8_pc10
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_alpha__u8_pc11
  .L_is_alpha__u8_pc10:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_alpha__u8_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alpha__u8_pc26
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_alpha__u8_pc22
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 90
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_is_alpha__u8_pc22
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_alpha__u8_pc23
  .L_is_alpha__u8_pc22:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_alpha__u8_pc23:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alpha__u8_pc26
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_alpha__u8_pc27
  .L_is_alpha__u8_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_alpha__u8_pc27:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alpha__u8_pc34
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alpha__u8_pc34
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_alpha__u8_pc35
  .L_is_alpha__u8_pc34:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_alpha__u8_pc35:
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
    # end of is_alpha__u8

    .globl is_alnum__u8
    .type  is_alnum__u8, @function
is_alnum__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_alpha__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alnum__u8_pc8
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call is_digit__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_alnum__u8_pc8
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_alnum__u8_pc9
  .L_is_alnum__u8_pc8:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_alnum__u8_pc9:
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
    # end of is_alnum__u8

    .globl is_wspace__u8
    .type  is_wspace__u8, @function
is_wspace__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc10
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc10
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_wspace__u8_pc11
  .L_is_wspace__u8_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_wspace__u8_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc18
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc18
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_wspace__u8_pc19
  .L_is_wspace__u8_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_wspace__u8_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc26
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_wspace__u8_pc26
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_wspace__u8_pc27
  .L_is_wspace__u8_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_wspace__u8_pc27:
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
    # end of is_wspace__u8

    .globl buf_set_str__U8Array__i32__StringLiteral
    .type  buf_set_str__U8Array__i32__StringLiteral, @function
buf_set_str__U8Array__i32__StringLiteral:
    # prologue: frame_size=48, params=3, locals=2, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_buf_set_str__U8Array__i32__StringLiteral_pc5:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    j    .L_buf_set_str__U8Array__i32__StringLiteral_pc23
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_buf_set_str__U8Array__i32__StringLiteral_pc5
  .L_buf_set_str__U8Array__i32__StringLiteral_pc23:
    lw   t0, -28(s0)
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
    # end of buf_set_str__U8Array__i32__StringLiteral

    .globl streq__U8Array__i32__i32__StringLiteral
    .type  streq__U8Array__i32__i32__StringLiteral, @function
streq__U8Array__i32__i32__StringLiteral:
    # prologue: frame_size=48, params=4, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_streq__U8Array__i32__i32__StringLiteral_pc9
0:
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
  .L_streq__U8Array__i32__i32__StringLiteral_pc9:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_streq__U8Array__i32__i32__StringLiteral_pc11:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    j    .L_streq__U8Array__i32__i32__StringLiteral_pc32
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_streq__U8Array__i32__i32__StringLiteral_pc27
0:
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
  .L_streq__U8Array__i32__i32__StringLiteral_pc27:
    lw   t0, -32(s0)
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
    sw   t0, -32(s0)
    j    .L_streq__U8Array__i32__i32__StringLiteral_pc11
  .L_streq__U8Array__i32__i32__StringLiteral_pc32:
    li   t0, 1
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
    # end of streq__U8Array__i32__i32__StringLiteral

    .globl cmp__U8Array__i32__StringLiteral
    .type  cmp__U8Array__i32__StringLiteral, @function
cmp__U8Array__i32__StringLiteral:
    # prologue: frame_size=48, params=3, locals=2, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call len__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_cmp__U8Array__i32__StringLiteral_pc5:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_cmp__U8Array__i32__StringLiteral_pc26
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__StringLiteral__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_cmp__U8Array__i32__StringLiteral_pc21
0:
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
  .L_cmp__U8Array__i32__StringLiteral_pc21:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_cmp__U8Array__i32__StringLiteral_pc5
  .L_cmp__U8Array__i32__StringLiteral_pc26:
    li   t0, 1
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
    # end of cmp__U8Array__i32__StringLiteral

    .globl print_error__StringLiteral
    .type  print_error__StringLiteral, @function
print_error__StringLiteral:
    # prologue: frame_size=32, params=1, locals=1, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    call StringBuffer_new
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_string__StringBuffer__StringLiteral
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call emit_char__StringBuffer__u8
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call write__StringBuffer__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call destroy__StringBuffer
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
    # end of print_error__StringLiteral

    .globl udivmod32__i32__i32
    .type  udivmod32__i32__i32, @function
udivmod32__i32__i32:
    # prologue: frame_size=64, params=2, locals=7, eval_depth=2
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_udivmod32__i32__i32_pc10:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_udivmod32__i32__i32_pc57
0:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_udivmod32__i32__i32_pc32
0:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    or   t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_udivmod32__i32__i32_pc32:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_udivmod32__i32__i32_pc52
0:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    or   t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
  .L_udivmod32__i32__i32_pc52:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    j    .L_udivmod32__i32__i32_pc10
  .L_udivmod32__i32__i32_pc57:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_udiv_q
    sw   t0, 0(t1)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_udiv_r
    sw   t0, 0(t1)
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
    # end of udivmod32__i32__i32

    .globl bc_fatal_lit__StringLiteral
    .type  bc_fatal_lit__StringLiteral, @function
bc_fatal_lit__StringLiteral:
    # prologue: frame_size=48, params=1, locals=4, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
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
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 99
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 58
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
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
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_bc_fatal_lit__StringLiteral_pc53:
    lw   t0, -28(s0)
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
    j    .L_bc_fatal_lit__StringLiteral_pc73
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
    lw   t0, -28(s0)
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
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_bc_fatal_lit__StringLiteral_pc53
  .L_bc_fatal_lit__StringLiteral_pc73:
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call sys_exit__i32
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
    # end of bc_fatal_lit__StringLiteral

    .globl bc_fatal_name__StringLiteral__U8Array__i32__i32
    .type  bc_fatal_name__StringLiteral__U8Array__i32__i32, @function
bc_fatal_name__StringLiteral__U8Array__i32__i32:
    # prologue: frame_size=64, params=4, locals=4, eval_depth=5
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
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
    sw   t0, -28(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 99
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 58
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc55:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    j    .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc75
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -40(s0)
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
    sw   t0, -40(s0)
    j    .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc55
  .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc75:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 39
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc96:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
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
    j    .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc118
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -40(s0)
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
    sw   t0, -40(s0)
    j    .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc96
  .L_bc_fatal_name__StringLiteral__U8Array__i32__i32_pc118:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 39
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
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
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call sys_exit__i32
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
    # end of bc_fatal_name__StringLiteral__U8Array__i32__i32

    .globl stab_eq__U8Array__i32__i32__i32__i32
    .type  stab_eq__U8Array__i32__i32__i32__i32, @function
stab_eq__U8Array__i32__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=1, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   zero, -32(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc6
0:
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
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc6:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc8:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc31
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc26
0:
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
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc26:
    lw   t0, -32(s0)
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
    sw   t0, -32(s0)
    j    .L_stab_eq__U8Array__i32__i32__i32__i32_pc8
  .L_stab_eq__U8Array__i32__i32__i32__i32_pc31:
    li   t0, 1
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
    # end of stab_eq__U8Array__i32__i32__i32__i32

    .globl in_cur__U8Array
    .type  in_cur__U8Array, @function
in_cur__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_in_cur__U8Array_pc6
0:
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
  .L_in_cur__U8Array_pc6:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of in_cur__U8Array

    .globl is_ws__u8
    .type  is_ws__u8, @function
is_ws__u8:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc10
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc10
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc11
  .L_is_ws__u8_pc10:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc11:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc18
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc18
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc19
  .L_is_ws__u8_pc18:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc19:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc26
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_is_ws__u8_pc26
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_is_ws__u8_pc27
  .L_is_ws__u8_pc26:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_is_ws__u8_pc27:
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
    # end of is_ws__u8

    .globl skip_spaces__U8Array
    .type  skip_spaces__U8Array, @function
skip_spaces__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=4
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
  .L_skip_spaces__U8Array_pc0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_skip_spaces__U8Array_pc20
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_skip_spaces__U8Array_pc16
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_skip_spaces__U8Array_pc16
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_spaces__U8Array_pc17
  .L_skip_spaces__U8Array_pc16:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_spaces__U8Array_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_spaces__U8Array_pc20
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_spaces__U8Array_pc21
  .L_skip_spaces__U8Array_pc20:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_spaces__U8Array_pc21:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_spaces__U8Array_pc27
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_skip_spaces__U8Array_pc0
  .L_skip_spaces__U8Array_pc27:
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
    # end of skip_spaces__U8Array

    .globl skip_line__U8Array
    .type  skip_line__U8Array, @function
skip_line__U8Array:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
  .L_skip_line__U8Array_pc0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_skip_line__U8Array_pc11
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc11
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_skip_line__U8Array_pc12
  .L_skip_line__U8Array_pc11:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_skip_line__U8Array_pc12:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_skip_line__U8Array_pc18
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_skip_line__U8Array_pc0
  .L_skip_line__U8Array_pc18:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_skip_line__U8Array_pc26
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_skip_line__U8Array_pc26:
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
    # end of skip_line__U8Array

    .globl next_tok__U8Array__U8Array
    .type  next_tok__U8Array__U8Array, @function
next_tok__U8Array__U8Array:
    # prologue: frame_size=48, params=2, locals=1, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
  .L_next_tok__U8Array__U8Array_pc5:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_next_tok__U8Array__U8Array_pc16
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_next_tok__U8Array__U8Array_pc16
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_next_tok__U8Array__U8Array_pc17
  .L_next_tok__U8Array__U8Array_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_next_tok__U8Array__U8Array_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_next_tok__U8Array__U8Array_pc33
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_next_tok__U8Array__U8Array_pc5
  .L_next_tok__U8Array__U8Array_pc33:
    lw   t0, -20(s0)
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
    # end of next_tok__U8Array__U8Array

    .globl tok_len__i32
    .type  tok_len__i32, @function
tok_len__i32:
    # prologue: frame_size=32, params=1, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
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
    # end of tok_len__i32

    .globl discard_tok__i32
    .type  discard_tok__i32, @function
discard_tok__i32:
    # prologue: frame_size=16, params=1, locals=0, eval_depth=1
    addi sp, sp, -16
    sw   ra, 12(sp)
    sw   s0, 8(sp)
    addi s0, sp, 16
    sw   a0, -12(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    sw   t0, 0(t1)
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
    # end of discard_tok__i32

    .globl int_from_stab__U8Array__i32__i32
    .type  int_from_stab__U8Array__i32__i32, @function
int_from_stab__U8Array__i32__i32:
    # prologue: frame_size=64, params=3, locals=4, eval_depth=5
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc16
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 45
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc16
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_int_from_stab__U8Array__i32__i32_pc17
  .L_int_from_stab__U8Array__i32__i32_pc16:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_int_from_stab__U8Array__i32__i32_pc17:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc22
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_int_from_stab__U8Array__i32__i32_pc22:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_int_from_stab__U8Array__i32__i32_pc24:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_int_from_stab__U8Array__i32__i32_pc60
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc44
0:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc44
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_int_from_stab__U8Array__i32__i32_pc45
  .L_int_from_stab__U8Array__i32__i32_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_int_from_stab__U8Array__i32__i32_pc45:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc55
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
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
    sw   t0, -32(s0)
  .L_int_from_stab__U8Array__i32__i32_pc55:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_int_from_stab__U8Array__i32__i32_pc24
  .L_int_from_stab__U8Array__i32__i32_pc60:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_int_from_stab__U8Array__i32__i32_pc68
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
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
  .L_int_from_stab__U8Array__i32__i32_pc68:
    lw   t0, -32(s0)
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
    # end of int_from_stab__U8Array__i32__i32

    .globl read_strlit__U8Array__U8Array
    .type  read_strlit__U8Array__U8Array, @function
read_strlit__U8Array__U8Array:
    # prologue: frame_size=112, params=2, locals=10, eval_depth=12
    addi sp, sp, -112
    sw   ra, 108(sp)
    sw   s0, 104(sp)
    addi s0, sp, 112
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_read_strlit__U8Array__U8Array_pc13
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc13
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc14
  .L_read_strlit__U8Array__U8Array_pc13:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc14:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc19
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_read_strlit__U8Array__U8Array_pc19:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
  .L_read_strlit__U8Array__U8Array_pc21:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc31
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_read_strlit__U8Array__U8Array_pc31
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc32
  .L_read_strlit__U8Array__U8Array_pc31:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc32:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc245
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc50
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_read_strlit__U8Array__U8Array_pc50:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc60
0:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 92
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc60
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc61
  .L_read_strlit__U8Array__U8Array_pc60:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc61:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc231
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc77
0:
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc77:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc83
0:
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc83:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc89
0:
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc89:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 120
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc220
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc121
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc121
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc122
  .L_read_strlit__U8Array__U8Array_pc121:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc122:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc128
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_read_strlit__U8Array__U8Array_pc128:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc138
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc138
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc139
  .L_read_strlit__U8Array__U8Array_pc138:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc139:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc145
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 55
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_read_strlit__U8Array__U8Array_pc145:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc155
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc155
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc156
  .L_read_strlit__U8Array__U8Array_pc155:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc156:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc162
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 87
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
  .L_read_strlit__U8Array__U8Array_pc162:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc172
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc172
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc173
  .L_read_strlit__U8Array__U8Array_pc172:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc173:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc179
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_read_strlit__U8Array__U8Array_pc179:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc189
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 70
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc189
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc190
  .L_read_strlit__U8Array__U8Array_pc189:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc190:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc196
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 55
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_read_strlit__U8Array__U8Array_pc196:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc206
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc206
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_read_strlit__U8Array__U8Array_pc207
  .L_read_strlit__U8Array__U8Array_pc206:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_read_strlit__U8Array__U8Array_pc207:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc213
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 87
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_read_strlit__U8Array__U8Array_pc213:
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
  .L_read_strlit__U8Array__U8Array_pc220:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
  .L_read_strlit__U8Array__U8Array_pc231:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_read_strlit__U8Array__U8Array_pc244
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
  .L_read_strlit__U8Array__U8Array_pc244:
    j    .L_read_strlit__U8Array__U8Array_pc21
  .L_read_strlit__U8Array__U8Array_pc245:
    lw   t0, -20(s0)
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
    # end of read_strlit__U8Array__U8Array

    .globl classify_op__U8Array__i32__i32
    .type  classify_op__U8Array__i32__i32, @function
classify_op__U8Array__i32__i32:
    # prologue: frame_size=48, params=3, locals=0, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc8
0:
    la   t1, OP_OR
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc8:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc16
0:
    la   t1, OP_EQ
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc16:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc24
0:
    la   t1, OP_NE
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc24:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc32
0:
    la   t1, OP_LT
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc32:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc40
0:
    la   t1, OP_LE
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc40:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc48
0:
    la   t1, OP_GT
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc48:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc56
0:
    la   t1, OP_GE
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc56:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc64
0:
    la   t1, OP_ADD
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc64:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc72
0:
    la   t1, OP_SUB
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc72:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc80
0:
    la   t1, OP_MUL
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc80:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc88
0:
    la   t1, OP_DIV
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc88:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj11
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc96
0:
    la   t1, OP_MOD
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc96:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj12
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc104
0:
    la   t1, OP_AND
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc104:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc112
0:
    la   t1, OP_XOR
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc112:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj14
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc120
0:
    la   t1, OP_SHL
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc120:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj15
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc128
0:
    la   t1, OP_SHR
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc128:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj16
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc136
0:
    la   t1, OP_POP
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc136:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj17
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc144
0:
    la   t1, OP_NEG
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc144:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj18
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc152
0:
    la   t1, OP_LNOT
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc152:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj19
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc160
0:
    la   t1, OP_CAST
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc160:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj20
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc168
0:
    la   t1, OP_LOAD
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc168:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj21
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc176
0:
    la   t1, OP_JUMP
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc176:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj22
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc184
0:
    la   t1, OP_CALL
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc184:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj23
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc192
0:
    la   t1, OP_LT_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc192:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj24
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc200
0:
    la   t1, OP_LE_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc200:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj25
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc208
0:
    la   t1, OP_GT_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc208:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj26
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc216
0:
    la   t1, OP_GE_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc216:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj27
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc224
0:
    la   t1, OP_STORE
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc224:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj28
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc232
0:
    la   t1, OP_SHR_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc232:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj29
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc240
0:
    la   t1, OP_DIV_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc240:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj30
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc248
0:
    la   t1, OP_MOD_U
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc248:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc256
0:
    la   t1, OP_RETURN
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc256:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj32
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc264
0:
    la   t1, OP_JUMP_IF
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc264:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj33
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc272
0:
    la   t1, OP_PUSH_INT
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc272:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj34
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc280
0:
    la   t1, OP_PUSH_STR
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc280:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj35
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc288
0:
    la   t1, OP_JUMP_IFNOT
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc288:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t0, __StringBuffer__U8Array__i32__i32_strobj36
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call streq__U8Array__i32__i32__StringLiteral
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_classify_op__U8Array__i32__i32_pc296
0:
    la   t1, OP_RETURN_VOID
    lw   t0, 0(t1)
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
  .L_classify_op__U8Array__i32__i32_pc296:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
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
    # end of classify_op__U8Array__i32__i32

    .globl fn_name_ss__I32Array__i32
    .type  fn_name_ss__I32Array__i32, @function
fn_name_ss__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_name_ss__I32Array__i32

    .globl fn_name_sl__I32Array__i32
    .type  fn_name_sl__I32Array__i32, @function
fn_name_sl__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_name_sl__I32Array__i32

    .globl fn_param_base__I32Array__i32
    .type  fn_param_base__I32Array__i32, @function
fn_param_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_param_base__I32Array__i32

    .globl fn_nparam__I32Array__i32
    .type  fn_nparam__I32Array__i32, @function
fn_nparam__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_nparam__I32Array__i32

    .globl fn_local_base__I32Array__i32
    .type  fn_local_base__I32Array__i32, @function
fn_local_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_local_base__I32Array__i32

    .globl fn_nlocal__I32Array__i32
    .type  fn_nlocal__I32Array__i32, @function
fn_nlocal__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_nlocal__I32Array__i32

    .globl fn_instr_base__I32Array__i32
    .type  fn_instr_base__I32Array__i32, @function
fn_instr_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_instr_base__I32Array__i32

    .globl fn_ninstr__I32Array__i32
    .type  fn_ninstr__I32Array__i32, @function
fn_ninstr__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of fn_ninstr__I32Array__i32

    .globl fn_set__I32Array__i32__i32__i32
    .type  fn_set__I32Array__i32__i32__i32, @function
fn_set__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
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
    # end of fn_set__I32Array__i32__i32__i32

    .globl pl_name_ss__I32Array__i32
    .type  pl_name_ss__I32Array__i32, @function
pl_name_ss__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of pl_name_ss__I32Array__i32

    .globl pl_name_sl__I32Array__i32
    .type  pl_name_sl__I32Array__i32, @function
pl_name_sl__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of pl_name_sl__I32Array__i32

    .globl pl_set__I32Array__i32__i32__i32
    .type  pl_set__I32Array__i32__i32__i32, @function
pl_set__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
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
    # end of pl_set__I32Array__i32__i32__i32

    .globl ins_op__I32Array__i32__i32
    .type  ins_op__I32Array__i32__i32, @function
ins_op__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of ins_op__I32Array__i32__i32

    .globl ins_ival__I32Array__i32__i32
    .type  ins_ival__I32Array__i32__i32, @function
ins_ival__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of ins_ival__I32Array__i32__i32

    .globl ins_ss__I32Array__i32__i32
    .type  ins_ss__I32Array__i32__i32, @function
ins_ss__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of ins_ss__I32Array__i32__i32

    .globl ins_sl__I32Array__i32__i32
    .type  ins_sl__I32Array__i32__i32, @function
ins_sl__I32Array__i32__i32:
    # prologue: frame_size=32, params=3, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of ins_sl__I32Array__i32__i32

    .globl ins_set__I32Array__i32__i32__i32__i32
    .type  ins_set__I32Array__i32__i32__i32__i32, @function
ins_set__I32Array__i32__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
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
    # end of ins_set__I32Array__i32__i32__i32__i32

    .globl hm_kind__I32Array__i32
    .type  hm_kind__I32Array__i32, @function
hm_kind__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of hm_kind__I32Array__i32

    .globl hm_base__I32Array__i32
    .type  hm_base__I32Array__i32, @function
hm_base__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of hm_base__I32Array__i32

    .globl hm_size__I32Array__i32
    .type  hm_size__I32Array__i32, @function
hm_size__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of hm_size__I32Array__i32

    .globl heap_new_u8__I32Array__i32
    .type  heap_new_u8__I32Array__i32, @function
heap_new_u8__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    la   t1, g_heap_bytes_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
    lw   t0, -20(s0)
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
    # end of heap_new_u8__I32Array__i32

    .globl heap_new_i32__I32Array__i32
    .type  heap_new_i32__I32Array__i32, @function
heap_new_i32__I32Array__i32:
    # prologue: frame_size=32, params=2, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   zero, -20(s0)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    la   t1, g_heap_i32s_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_heap_i32s_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
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
    la   t1, g_heap_i32s_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
    lw   t0, -20(s0)
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
    # end of heap_new_i32__I32Array__i32

    .globl heap_new_str__I32Array__U8Array__U8Array__i32__i32
    .type  heap_new_str__I32Array__U8Array__U8Array__i32__i32, @function
heap_new_str__I32Array__U8Array__U8Array__i32__i32:
    # prologue: frame_size=64, params=5, locals=2, eval_depth=5
    addi sp, sp, -64
    sw   ra, 60(sp)
    sw   s0, 56(sp)
    addi s0, sp, 64
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
  .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc31:
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    j    .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc51
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -36(s0)
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
    sw   t0, -36(s0)
    j    .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc31
  .L_heap_new_str__I32Array__U8Array__U8Array__i32__i32_pc51:
    la   t1, g_heap_bytes_top
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
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
    la   t1, g_heap_bytes_top
    sw   t0, 0(t1)
    la   t1, g_heap_obj_count
    lw   t0, 0(t1)
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
    la   t1, g_heap_obj_count
    sw   t0, 0(t1)
    lw   t0, -32(s0)
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
    # end of heap_new_str__I32Array__U8Array__U8Array__i32__i32

    .globl heap_getu8__I32Array__U8Array__i32__i32
    .type  heap_getu8__I32Array__U8Array__i32__i32, @function
heap_getu8__I32Array__U8Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
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
    # end of heap_getu8__I32Array__U8Array__i32__i32

    .globl heap_setu8__I32Array__U8Array__i32__i32__i32
    .type  heap_setu8__I32Array__U8Array__i32__i32__i32, @function
heap_setu8__I32Array__U8Array__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    # end of heap_setu8__I32Array__U8Array__i32__i32__i32

    .globl heap_geti32__I32Array__I32Array__i32__i32
    .type  heap_geti32__I32Array__I32Array__i32__i32, @function
heap_geti32__I32Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
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
    # end of heap_geti32__I32Array__I32Array__i32__i32

    .globl heap_seti32__I32Array__I32Array__i32__i32__i32
    .type  heap_seti32__I32Array__I32Array__i32__i32__i32, @function
heap_seti32__I32Array__I32Array__i32__i32__i32:
    # prologue: frame_size=48, params=5, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
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
    # end of heap_seti32__I32Array__I32Array__i32__i32__i32

    .globl parse_lnum__U8Array__i32__i32
    .type  parse_lnum__U8Array__i32__i32, @function
parse_lnum__U8Array__i32__i32:
    # prologue: frame_size=48, params=3, locals=3, eval_depth=4
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
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
    sw   t0, -28(s0)
  .L_parse_lnum__U8Array__i32__i32_pc6:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
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
    j    .L_parse_lnum__U8Array__i32__i32_pc40
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc24
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 57
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc24
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_lnum__U8Array__i32__i32_pc25
  .L_parse_lnum__U8Array__i32__i32_pc24:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_lnum__U8Array__i32__i32_pc25:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_lnum__U8Array__i32__i32_pc35
0:
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 48
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
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
  .L_parse_lnum__U8Array__i32__i32_pc35:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_parse_lnum__U8Array__i32__i32_pc6
  .L_parse_lnum__U8Array__i32__i32_pc40:
    lw   t0, -24(s0)
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
    # end of parse_lnum__U8Array__i32__i32

    .globl parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array
    .type  parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array, @function
parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array:
    # prologue: frame_size=384, params=10, locals=39, eval_depth=44
    addi sp, sp, -384
    sw   ra, 380(sp)
    sw   s0, 376(sp)
    addi s0, sp, 384
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    lw   t0, 0(s0)
    sw   t0, -44(s0)
    lw   t0, 4(s0)
    sw   t0, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    sw   zero, -64(s0)
    sw   zero, -68(s0)
    sw   zero, -72(s0)
    sw   zero, -76(s0)
    sw   zero, -80(s0)
    sw   zero, -84(s0)
    sw   zero, -88(s0)
    sw   zero, -92(s0)
    sw   zero, -96(s0)
    sw   zero, -100(s0)
    sw   zero, -104(s0)
    sw   zero, -108(s0)
    sw   zero, -112(s0)
    sw   zero, -116(s0)
    sw   zero, -120(s0)
    sw   zero, -124(s0)
    sw   zero, -128(s0)
    sw   zero, -132(s0)
    sw   zero, -136(s0)
    sw   zero, -140(s0)
    sw   zero, -144(s0)
    sw   zero, -148(s0)
    sw   zero, -152(s0)
    sw   zero, -156(s0)
    sw   zero, -160(s0)
    sw   zero, -164(s0)
    sw   zero, -168(s0)
    sw   zero, -172(s0)
    sw   zero, -176(s0)
    sw   zero, -180(s0)
    sw   zero, -184(s0)
    sw   zero, -188(s0)
    sw   zero, -192(s0)
    sw   zero, -196(s0)
    sw   zero, -200(s0)
    sw   zero, -204(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc5:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc16
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc15:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc16:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1202
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc26
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc26:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc44
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc43:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc44:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc49
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc49:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc60
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc59:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc60:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc68
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc67:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc68:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc72
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc72:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc83
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc82:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc83:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc91
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc90:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc91:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc99
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc98:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc99:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc123
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc123:
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc133
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc133:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143
0:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc144
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc143:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc144:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc203
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call read_strlit__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -92(s0)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -84(s0)
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
    la   t1, g_nstrings
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc200
0:
    lw   t0, -84(s0)
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
    la   t1, g_nstrings
    sw   t0, 0(t1)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc200:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc203:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213
0:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc214
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc213:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc214:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc297
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nglobals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nglobals
    lw   t0, 0(t1)
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
    la   t1, g_nglobals
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc297:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307
0:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc308
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc307:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc308:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc425
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc321:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc333
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc332:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc333:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc362
0:
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc321
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc362:
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    la   t1, g_nfuncs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 8
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_ninstrs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nfuncs
    lw   t0, 0(t1)
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
    la   t1, g_nfuncs
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc425:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435
0:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc436
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc435:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc436:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc499
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nparams
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nparams
    lw   t0, 0(t1)
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
    la   t1, g_nparams
    sw   t0, 0(t1)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc496
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc496:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc499:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509
0:
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc510
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc509:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc510:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc573
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nlocals
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call pl_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_nlocals
    lw   t0, 0(t1)
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
    la   t1, g_nlocals
    sw   t0, 0(t1)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc570
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc570:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc573:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc585
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc585:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc596
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc595:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc596:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc605
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc605:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc616
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc615:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc616:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc688
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -140(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -144(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc634:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_op__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -148(s0)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653
0:
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc654
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc653:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc654:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661
0:
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc662
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc661:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc662:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc677
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ival__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -152(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc677:
    lw   t0, -144(s0)
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
    sw   t0, -144(s0)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc634
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc682:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc688:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc699
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc698:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc699:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 102
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc707
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc706:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc707:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc715
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc714:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc715:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc723
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc722:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc723:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc731
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc730:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc731:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc738:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc749
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc748:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc749:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc757
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc756:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc757:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc765
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc764:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc765:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc773
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc772:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc773:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc841
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc776:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc788
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc787:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc788:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc797
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc796:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc797:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc803
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc776
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc803:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 58
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc815
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc814:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc815:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call parse_lnum__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_ninstrs
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc838:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc841:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 13
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc852
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc851:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc852:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 59
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc860
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc859:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc860:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 46
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc868
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc867:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc868:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875
0:
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc876
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc875:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc876:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -164(s0)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -168(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call classify_op__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -172(s0)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902
0:
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc903
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc902:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc903:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1198
0:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -176(s0)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -180(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc964
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc964:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_STR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc988
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call int_from_stab__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call discard_tok__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc988:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LOAD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998
0:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_STORE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc999
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc998:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc999:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1021
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1021:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CALL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1106
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1036:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 10
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1048
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1047:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1048:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1081
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    lw   t0, -196(s0)
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
    sw   t0, -196(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1036
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1081:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1106:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CAST
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1131
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call next_tok__U8Array__U8Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call tok_len__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1131:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141
0:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1142
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1141:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1142:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149
0:
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1150
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1149:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1150:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1186
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_spaces__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1156:
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
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
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call in_cur__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call is_ws__u8
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1168
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1167:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1168:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1174
0:
    la   t1, g_in_pos
    lw   t0, 0(t1)
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
    la   t1, g_in_pos
    sw   t0, 0(t1)
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1156
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1174:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call parse_lnum__U8Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -204(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call ins_set__I32Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1186:
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 9
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
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
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call fn_set__I32Array__i32__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_ninstrs
    lw   t0, 0(t1)
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
    la   t1, g_ninstrs
    sw   t0, 0(t1)
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1198:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call skip_line__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1201:
    j    .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc5
  .L_parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array_pc1202:
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
    # end of parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array

    .globl var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    .type  var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32, @function
var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32:
    # prologue: frame_size=80, params=7, locals=5, eval_depth=5
    addi sp, sp, -80
    sw   ra, 76(sp)
    sw   s0, 72(sp)
    addi s0, sp, 80
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_param_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_local_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc18:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
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
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc44
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pl_name_ss__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pl_name_sl__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc39
0:
    lw   t0, -56(s0)
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
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc39:
    lw   t0, -56(s0)
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
    sw   t0, -56(s0)
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc18
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc44:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc46:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
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
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc74
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pl_name_ss__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call pl_name_sl__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc69
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
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
    mv   a0, t0
    mv   t0, s0
    lw   ra, -4(t0)
    lw   s0, -8(t0)
    addi sp, t0, 0
    ret
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc69:
    lw   t0, -56(s0)
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
    sw   t0, -56(s0)
    j    .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc46
  .L_var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32_pc74:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
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
    # end of var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32

    .globl global_find__U8Array__I32Array__i32__i32
    .type  global_find__U8Array__I32Array__i32__i32, @function
global_find__U8Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=1, eval_depth=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_global_find__U8Array__I32Array__i32__i32_pc2:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nglobals
    lw   t0, 0(t1)
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
    j    .L_global_find__U8Array__I32Array__i32__i32_pc32
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_global_find__U8Array__I32Array__i32__i32_pc27
0:
    lw   t0, -28(s0)
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
  .L_global_find__U8Array__I32Array__i32__i32_pc27:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_global_find__U8Array__I32Array__i32__i32_pc2
  .L_global_find__U8Array__I32Array__i32__i32_pc32:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
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
    # end of global_find__U8Array__I32Array__i32__i32

    .globl func_find__U8Array__I32Array__i32__i32
    .type  func_find__U8Array__I32Array__i32__i32, @function
func_find__U8Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=1, eval_depth=5
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   zero, -28(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
  .L_func_find__U8Array__I32Array__i32__i32_pc2:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nfuncs
    lw   t0, 0(t1)
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
    j    .L_func_find__U8Array__I32Array__i32__i32_pc24
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_name_ss__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_name_sl__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call stab_eq__U8Array__i32__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_func_find__U8Array__I32Array__i32__i32_pc19
0:
    lw   t0, -28(s0)
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
  .L_func_find__U8Array__I32Array__i32__i32_pc19:
    lw   t0, -28(s0)
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
    sw   t0, -28(s0)
    j    .L_func_find__U8Array__I32Array__i32__i32_pc2
  .L_func_find__U8Array__I32Array__i32__i32_pc24:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
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
    # end of func_find__U8Array__I32Array__i32__i32

    .globl stk_push__I32Array__I32Array__i32__i32
    .type  stk_push__I32Array__I32Array__i32__i32, @function
stk_push__I32Array__I32Array__i32__i32:
    # prologue: frame_size=48, params=4, locals=0, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    lw   t0, 0(t1)
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
    la   t1, g_sp
    sw   t0, 0(t1)
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
    # end of stk_push__I32Array__I32Array__i32__i32

    .globl stk_pop__I32Array__I32Array
    .type  stk_pop__I32Array__I32Array, @function
stk_pop__I32Array__I32Array:
    # prologue: frame_size=32, params=2, locals=0, eval_depth=2
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_tag
    sw   t0, 0(t1)
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
    # end of stk_pop__I32Array__I32Array

    .globl cs_push__I32Array__i32__i32__i32__i32__i32
    .type  cs_push__I32Array__i32__i32__i32__i32__i32, @function
cs_push__I32Array__i32__i32__i32__i32__i32:
    # prologue: frame_size=48, params=6, locals=1, eval_depth=3
    addi sp, sp, -48
    sw   ra, 44(sp)
    sw   s0, 40(sp)
    addi s0, sp, 48
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   zero, -36(s0)
    la   t1, g_csp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
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
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_csp
    lw   t0, 0(t1)
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
    la   t1, g_csp
    sw   t0, 0(t1)
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
    # end of cs_push__I32Array__i32__i32__i32__i32__i32

    .globl cs_pop__I32Array
    .type  cs_pop__I32Array, @function
cs_pop__I32Array:
    # prologue: frame_size=32, params=1, locals=1, eval_depth=3
    addi sp, sp, -32
    sw   ra, 28(sp)
    sw   s0, 24(sp)
    addi s0, sp, 32
    sw   a0, -12(s0)
    sw   zero, -16(s0)
    la   t1, g_csp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_csp
    sw   t0, 0(t1)
    la   t1, g_csp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -16(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    sw   t0, 0(t1)
    lw   t0, -12(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_pc
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_fbase
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_vp
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_sp
    sw   t0, 0(t1)
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
    # end of cs_pop__I32Array

    .globl vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array
    .type  vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array, @function
vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array:
    # prologue: frame_size=656, params=21, locals=85, eval_depth=56
    addi sp, sp, -656
    sw   ra, 652(sp)
    sw   s0, 648(sp)
    addi s0, sp, 656
    sw   a0, -12(s0)
    sw   a1, -16(s0)
    sw   a2, -20(s0)
    sw   a3, -24(s0)
    sw   a4, -28(s0)
    sw   a5, -32(s0)
    sw   a6, -36(s0)
    sw   a7, -40(s0)
    lw   t0, 0(s0)
    sw   t0, -44(s0)
    lw   t0, 4(s0)
    sw   t0, -48(s0)
    lw   t0, 8(s0)
    sw   t0, -52(s0)
    lw   t0, 12(s0)
    sw   t0, -56(s0)
    lw   t0, 16(s0)
    sw   t0, -60(s0)
    lw   t0, 20(s0)
    sw   t0, -64(s0)
    lw   t0, 24(s0)
    sw   t0, -68(s0)
    lw   t0, 28(s0)
    sw   t0, -72(s0)
    lw   t0, 32(s0)
    sw   t0, -76(s0)
    lw   t0, 36(s0)
    sw   t0, -80(s0)
    lw   t0, 40(s0)
    sw   t0, -84(s0)
    lw   t0, 44(s0)
    sw   t0, -88(s0)
    lw   t0, 48(s0)
    sw   t0, -92(s0)
    sw   zero, -96(s0)
    sw   zero, -100(s0)
    sw   zero, -104(s0)
    sw   zero, -108(s0)
    sw   zero, -112(s0)
    sw   zero, -116(s0)
    sw   zero, -120(s0)
    sw   zero, -124(s0)
    sw   zero, -128(s0)
    sw   zero, -132(s0)
    sw   zero, -136(s0)
    sw   zero, -140(s0)
    sw   zero, -144(s0)
    sw   zero, -148(s0)
    sw   zero, -152(s0)
    sw   zero, -156(s0)
    sw   zero, -160(s0)
    sw   zero, -164(s0)
    sw   zero, -168(s0)
    sw   zero, -172(s0)
    sw   zero, -176(s0)
    sw   zero, -180(s0)
    sw   zero, -184(s0)
    sw   zero, -188(s0)
    sw   zero, -192(s0)
    sw   zero, -196(s0)
    sw   zero, -200(s0)
    sw   zero, -204(s0)
    sw   zero, -208(s0)
    sw   zero, -212(s0)
    sw   zero, -216(s0)
    sw   zero, -220(s0)
    sw   zero, -224(s0)
    sw   zero, -228(s0)
    sw   zero, -232(s0)
    sw   zero, -236(s0)
    sw   zero, -240(s0)
    sw   zero, -244(s0)
    sw   zero, -248(s0)
    sw   zero, -252(s0)
    sw   zero, -256(s0)
    sw   zero, -260(s0)
    sw   zero, -264(s0)
    sw   zero, -268(s0)
    sw   zero, -272(s0)
    sw   zero, -276(s0)
    sw   zero, -280(s0)
    sw   zero, -284(s0)
    sw   zero, -288(s0)
    sw   zero, -292(s0)
    sw   zero, -296(s0)
    sw   zero, -300(s0)
    sw   zero, -304(s0)
    sw   zero, -308(s0)
    sw   zero, -312(s0)
    sw   zero, -316(s0)
    sw   zero, -320(s0)
    sw   zero, -324(s0)
    sw   zero, -328(s0)
    sw   zero, -332(s0)
    sw   zero, -336(s0)
    sw   zero, -340(s0)
    sw   zero, -344(s0)
    sw   zero, -348(s0)
    sw   zero, -352(s0)
    sw   zero, -356(s0)
    sw   zero, -360(s0)
    sw   zero, -364(s0)
    sw   zero, -368(s0)
    sw   zero, -372(s0)
    sw   zero, -376(s0)
    sw   zero, -380(s0)
    sw   zero, -384(s0)
    sw   zero, -388(s0)
    sw   zero, -392(s0)
    sw   zero, -396(s0)
    sw   zero, -400(s0)
    sw   zero, -404(s0)
    sw   zero, -408(s0)
    sw   zero, -412(s0)
    sw   zero, -416(s0)
    sw   zero, -420(s0)
    sw   zero, -424(s0)
    sw   zero, -428(s0)
    sw   zero, -432(s0)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 109
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_stab_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
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
    la   t1, g_stab_pos
    lw   t0, 0(t1)
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
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call func_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_stab_pos
    sw   t0, 0(t1)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc52
0:
    li   t0, 1
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc52:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc54:
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_nglobals
    lw   t0, 0(t1)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc83
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -104(s0)
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
    sw   t0, -104(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc54
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc83:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc97:
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc118
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -116(s0)
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
    sw   t0, -116(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc97
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc118:
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
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
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    neg  t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 20(sp)
    lw   a1, 16(sp)
    lw   a2, 12(sp)
    lw   a3, 8(sp)
    lw   a4, 4(sp)
    lw   a5, 0(sp)
    call cs_push__I32Array__i32__i32__i32__i32__i32
    addi sp, sp, 24
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc140:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2290
0:
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc150
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc150:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2289
0:
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_instr_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_ninstr__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -128(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc185
0:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc185:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195
0:
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -128(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc196
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc195:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc196:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2289
0:
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_op__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -132(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ival__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -136(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_ss__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -140(s0)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call ins_sl__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -144(s0)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
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
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc231
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc231:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_PUSH_STR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc262
0:
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -148(s0)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -152(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -148(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -152(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_new_str__I32Array__U8Array__U8Array__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc262:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LOAD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    call var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 28
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc293
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc293:
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call global_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc325
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc325:
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335
0:
    la   t0, __StringBuffer__U8Array__i32__i32_strobj37
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call bc_fatal_name__StringLiteral__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc335:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_STORE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -164(s0)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -168(s0)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 24(sp)
    lw   a1, 20(sp)
    lw   a2, 16(sp)
    lw   a3, 12(sp)
    lw   a4, 8(sp)
    lw   a5, 4(sp)
    lw   a6, 0(sp)
    call var_find_local__U8Array__I32Array__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 28
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -156(s0)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc374
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc374:
    lw   t0, -156(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call global_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -160(s0)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406
0:
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -164(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
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
    lw   t0, -168(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc406:
    lw   t0, -160(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416
0:
    la   t0, __StringBuffer__U8Array__i32__i32_strobj38
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call bc_fatal_name__StringLiteral__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc416:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CALL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1638
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -172(s0)
    lw   t0, -172(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -176(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc426:
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc449
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -176(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -176(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc426
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc449:
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -180(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -208(s0)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc473
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -184(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc473:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc483
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -188(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc483:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc493
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -192(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc493:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc503
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -196(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc503:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc513
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -200(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc513:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc523
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 5
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -204(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc523:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc533
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 6
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -208(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc533:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc549
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc549
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc550
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc549:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc550:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc557
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 121
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc557
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc558
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc557:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc558:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc565
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc565
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc566
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc565:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc566:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc573
0:
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc573
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc574
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc573:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc574:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc788
0:
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 119
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc637
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -224(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -232(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc605
0:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -232(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc605:
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -244(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc611:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -232(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc629
0:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc611
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc629:
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -232(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_write__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc637:
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc777
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -224(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc667
0:
    lw   t0, -240(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc667:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc679
0:
    lw   t0, -256(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc679
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc680
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc679:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc680:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc725
0:
    la   t1, g_prog_stdin_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -260(s0)
    lw   t0, -260(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc723
0:
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -260(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc695
0:
    lw   t0, -260(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -252(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc695:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc697:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc717
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc697
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc717:
    la   t1, g_prog_stdin_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
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
    la   t1, g_prog_stdin_pos
    sw   t0, 0(t1)
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc723:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc725:
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc735
0:
    lw   t0, -256(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc735
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc736
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc735:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc736:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc777
0:
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -244(s0)
    lw   t0, -224(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -252(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_read__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc770
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc752:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc770
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc752
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc770:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -256(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc777:
    lw   t0, -200(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc786
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call sys_exit__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc786:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc788:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc798
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc798
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc799
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc798:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc799:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc806
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 114
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc806
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc807
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc806:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc807:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc814
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc814
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc815
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc814:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc815:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc905
0:
    lw   t0, -208(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc825
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 0(sp)
    call print_i32__i32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc825:
    lw   t0, -208(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc835
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call print_u32__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc835:
    lw   t0, -208(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc846
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call print_bool__bool
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc846:
    lw   t0, -208(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc903
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -236(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -240(s0)
    lw   t0, -240(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -244(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc870:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc888
0:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -236(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc870
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc888:
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -240(s0)
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
    lw   t0, -244(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc903:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc905:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc915
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc915
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc916
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc915:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc916:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc923
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 90
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sltu t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc923
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc924
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc923:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc924:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc931
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 7
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc931
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc932
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc931:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc932:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc959
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -268(s0)
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 73
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc947
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -268(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_i32__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc947:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 73
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc957
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -268(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc957:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc959:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc985
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc981
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc977
0:
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc977
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc978
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc977:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc978:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc981
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc982
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc981:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc982:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc985
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc986
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc985:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc986:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc993
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 103
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc993
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc994
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc993:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc994:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1001
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1001
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1002
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1001:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1002:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1009
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1009
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1010
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1009:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1010:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1045
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -272(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1031
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call heap_geti32__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1031:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1043
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call heap_getu8__I32Array__U8Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1043:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1045:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1071
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1067
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1063
0:
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1063
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1064
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1063:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1064:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1067
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1068
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1067:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1068:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1071
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1072
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1071:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1072:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1079
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 115
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1079
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1080
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1079:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1080:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1087
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1087
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1088
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1087:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1088:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1095
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 116
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1095
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1096
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1095:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1096:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1137
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -272(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 2
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -276(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1122
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -276(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_seti32__I32Array__I32Array__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1122:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_kind__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    la   t1, HK_I32
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1135
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -272(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -276(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 16(sp)
    lw   a1, 12(sp)
    lw   a2, 8(sp)
    lw   a3, 4(sp)
    lw   a4, 0(sp)
    call heap_setu8__I32Array__U8Array__i32__i32__i32
    addi sp, sp, 20
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1135:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1137:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1163
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1159
0:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 3
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1155
0:
    lw   t0, -196(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 95
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1155
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1156
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1155:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1156:
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1159
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1160
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1159:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1160:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1163
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1164
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1163:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1164:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1171
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1171
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1172
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1171:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1172:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1179
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1179
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1180
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1179:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1180:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1187
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 110
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1187
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1188
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1187:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1188:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1197
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1197:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1207
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 100
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1207
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1208
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1207:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1208:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1215
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1215
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1216
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1215:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1216:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1223
0:
    lw   t0, -192(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 108
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1223
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1224
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1223:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1224:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1227
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1227:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1237
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 97
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1237
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1238
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1237:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1238:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1245
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1245
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1246
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1245:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1246:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1391
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -228(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -280(s0)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -284(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -288(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -228(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -292(s0)
    lw   t0, -284(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1317
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -296(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -300(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1283:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1303
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -288(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1283
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1303:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
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
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1317:
    lw   t0, -284(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1389
0:
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -304(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -280(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -308(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -308(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call heap_new_u8__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -296(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -300(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1341:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1361
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -288(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1341
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1361:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -248(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1363:
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -308(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1385
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -300(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -292(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -304(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -248(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -248(s0)
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
    sw   t0, -248(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1363
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1385:
    lw   t0, -296(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    la   t1, TAG_REF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -216(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1389:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1391:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1401
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1401
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1402
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1401:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1402:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1409
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 113
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1409
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1410
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1409:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1410:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1484
0:
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -312(s0)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -316(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -312(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -320(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -312(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -324(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -316(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_base__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -316(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call hm_size__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -332(s0)
    lw   t0, -324(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -332(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1441
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1441:
    lw   t0, -324(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -332(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1482
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -336(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -340(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1449:
    lw   t0, -340(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -324(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1459
0:
    lw   t0, -336(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1459
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1460
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1459:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1460:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1480
0:
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -320(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -340(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -340(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1475
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -336(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1475:
    lw   t0, -340(s0)
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
    sw   t0, -340(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1449
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1480:
    lw   t0, -336(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1482:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1484:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1494
0:
    lw   t0, -184(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 112
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1494
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1495
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1494:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1495:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1510
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 101
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1506
0:
    lw   t0, -188(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 111
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1506
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1507
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1506:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1507:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1510
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1511
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1510:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1511:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1516
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -212(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -220(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1516:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1526
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -212(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -216(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1526:
    lw   t0, -220(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1638
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call func_find__U8Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -344(s0)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1546
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1546:
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1638
0:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_cur_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_frame_base
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -180(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 20(sp)
    lw   a1, 16(sp)
    lw   a2, 12(sp)
    lw   a3, 8(sp)
    lw   a4, 4(sp)
    lw   a5, 0(sp)
    call cs_push__I32Array__i32__i32__i32__i32__i32
    addi sp, sp, 24
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -348(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nparam__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -352(s0)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call fn_nlocal__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -356(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -360(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1570:
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1597
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -360(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__I32Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -360(s0)
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
    sw   t0, -360(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1570
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1597:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -364(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1599:
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -356(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1626
0:
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -364(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call set__I32Array__i32__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -364(s0)
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
    sw   t0, -364(s0)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1599
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1626:
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -352(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -356(s0)
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
    la   t1, g_vp
    sw   t0, 0(t1)
    lw   t0, -348(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    lw   t0, -344(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1638:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_RETURN
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1669
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -368(s0)
    la   t1, g_pop_tag
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -372(s0)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -368(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -372(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1669:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_RETURN_VOID
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1692
0:
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call cs_pop__I32Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cs_func
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_func
    sw   t0, 0(t1)
    la   t1, g_cs_pc
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
    la   t1, g_cs_fbase
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_frame_base
    sw   t0, 0(t1)
    la   t1, g_cs_vp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_vp
    sw   t0, 0(t1)
    la   t1, g_cs_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_sp
    sw   t0, 0(t1)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1692:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_POP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1700
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1700:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_ADD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1710
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1710
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1711
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1710:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1711:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1835
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_ADD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1734
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1734:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SUB
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1742
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1742:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MUL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1750
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    mul  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1750:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_DIV
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1760
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MOD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1760
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1761
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1760:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1761:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1768
0:
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1768
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1769
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1768:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1769:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1773
0:
    la   t0, __StringBuffer__U8Array__i32__i32_strobj39
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call bc_fatal_lit__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1773:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_DIV
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1781
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    div  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1781:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MOD
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1789
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    rem  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1789:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_AND
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1797
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1797:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_OR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1805
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    or   t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1805:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_XOR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1813
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1813:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHL
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1821
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1821:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1829
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sra  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1829:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1835:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_DIV_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1845
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MOD_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    beqz t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1845
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1846
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1845:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1846:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1884
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -380(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -384(s0)
    lw   t0, -380(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1866
0:
    la   t0, __StringBuffer__U8Array__i32__i32_strobj40
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call bc_fatal_lit__StringLiteral
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1866:
    lw   t0, -384(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -380(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call udivmod32__i32__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_udiv_q
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -388(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_MOD_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1878
0:
    la   t1, g_udiv_r
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -388(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1878:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -388(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1884:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_SHR_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1913
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -392(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -396(s0)
    lw   t0, -396(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -392(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    srl  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -400(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -400(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1913:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1923
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1923
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1924
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1923:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1924:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2005
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -328(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_EQ
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1949
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1949
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1949:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_NE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1959
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1959
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1959:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1969
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1969
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1969:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1979
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1979
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1979:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1989
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1989
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1989:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1999
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -328(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1999
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc1999:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2005:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2015
0:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2015
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2016
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2015:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2016:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2089
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -404(s0)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -408(s0)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 31
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sll  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -412(s0)
    lw   t0, -408(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -412(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -416(s0)
    lw   t0, -404(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -412(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    xor  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -420(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -424(s0)
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LT_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2053
0:
    lw   t0, -416(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -420(s0)
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
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2053
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -424(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2053:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LE_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2063
0:
    lw   t0, -416(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -420(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2063
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -424(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2063:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GT_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2073
0:
    lw   t0, -416(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -420(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2073
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -424(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2073:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_GE_U
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2083
0:
    lw   t0, -416(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -420(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2083
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -424(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2083:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -424(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2089:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_NEG
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2105
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2105:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_LNOT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2127
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2121
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -264(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2121:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -264(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2127:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_CAST
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2255
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -428(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -432(s0)
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2149
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -428(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2149:
    lw   t0, -144(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2159
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -140(s0)
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
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -432(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2159:
    lw   t0, -428(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2169
0:
    lw   t0, -432(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2169
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2170
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2169:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2170:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2175
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2175:
    lw   t0, -428(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 117
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2185
0:
    lw   t0, -432(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2185
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2186
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2185:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2186:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2191
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65535
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2191:
    lw   t0, -428(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2201
0:
    lw   t0, -432(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 56
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2201
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2202
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2201:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2202:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2215
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 255
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 128
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2215
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 256
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2215:
    lw   t0, -428(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 105
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2225
0:
    lw   t0, -432(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 49
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2225
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2226
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2225:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2226:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2239
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65535
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    and  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 32768
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t0, t1
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2239
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2239:
    lw   t0, -428(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 98
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2249
0:
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2249
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -376(s0)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2249:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -376(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, TAG_INT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 12(sp)
    lw   a1, 8(sp)
    lw   a2, 4(sp)
    lw   a3, 0(sp)
    call stk_push__I32Array__I32Array__i32__i32
    addi sp, sp, 16
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2255:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2261
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2261:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IF
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2275
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    snez t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2275
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2275:
    lw   t0, -132(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, OP_JUMP_IFNOT
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2289
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2289
0:
    lw   t0, -136(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_cur_pc
    sw   t0, 0(t1)
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2289:
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc140
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2290:
    la   t1, g_sp
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2300
0:
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call stk_pop__I32Array__I32Array
    addi sp, sp, 8
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_pop_ival
    lw   t0, 0(t1)
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
  .L_vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array_pc2300:
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
    # end of vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array

    .globl main
    .type  main, @function
main:
    # prologue: frame_size=224, params=0, locals=30, eval_depth=22
    addi sp, sp, -224
    sw   ra, 220(sp)
    sw   s0, 216(sp)
    addi s0, sp, 224
    sw   zero, -12(s0)
    sw   zero, -16(s0)
    sw   zero, -20(s0)
    sw   zero, -24(s0)
    sw   zero, -28(s0)
    sw   zero, -32(s0)
    sw   zero, -36(s0)
    sw   zero, -40(s0)
    sw   zero, -44(s0)
    sw   zero, -48(s0)
    sw   zero, -52(s0)
    sw   zero, -56(s0)
    sw   zero, -60(s0)
    sw   zero, -64(s0)
    sw   zero, -68(s0)
    sw   zero, -72(s0)
    sw   zero, -76(s0)
    sw   zero, -80(s0)
    sw   zero, -84(s0)
    sw   zero, -88(s0)
    sw   zero, -92(s0)
    sw   zero, -96(s0)
    sw   zero, -100(s0)
    sw   zero, -104(s0)
    sw   zero, -108(s0)
    sw   zero, -112(s0)
    sw   zero, -116(s0)
    sw   zero, -120(s0)
    sw   zero, -124(s0)
    sw   zero, -128(s0)
    li   t0, 524288
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -12(s0)
    li   t0, 262144
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
    li   t0, 2048
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -20(s0)
    li   t0, 1024
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -24(s0)
    li   t0, 256
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -28(s0)
    li   t0, 2560
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -32(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -36(s0)
    li   t0, 4096
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -40(s0)
    li   t0, 262144
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -44(s0)
    li   t0, 16384
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -48(s0)
    li   t0, 2048
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -52(s0)
    li   t0, 524288
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -56(s0)
    li   t0, 131072
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -60(s0)
    li   t0, 8192
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -64(s0)
    li   t0, 8192
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -68(s0)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -72(s0)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -76(s0)
    li   t0, 512
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -80(s0)
    li   t0, 512
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -84(s0)
    li   t0, 2560
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -88(s0)
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -92(s0)
    li   t0, 64
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call I32Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -96(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_len
    sw   t0, 0(t1)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -100(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_main_pc73:
    lw   t0, -104(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    seqz t0, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc83
0:
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 524000
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
    j    .L_main_pc83
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    j    .L_main_pc84
  .L_main_pc83:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
  .L_main_pc84:
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc125
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 65536
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 8(sp)
    lw   a1, 4(sp)
    lw   a2, 0(sp)
    call sys_read__i32__U8Array__i32
    addi sp, sp, 12
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -108(s0)
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc96
0:
    li   t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -104(s0)
  .L_main_pc96:
    lw   t0, -108(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc124
0:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -112(s0)
  .L_main_pc102:
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
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
    j    .L_main_pc120
0:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -112(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -112(s0)
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
    sw   t0, -112(s0)
    j    .L_main_pc102
  .L_main_pc120:
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -108(s0)
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
    la   t1, g_in_len
    sw   t0, 0(t1)
  .L_main_pc124:
    j    .L_main_pc73
  .L_main_pc125:
    lw   t0, -100(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call delete__U8Array
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    slt  t0, t1, t0
    xori t0, t0, 1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    bnez t0, 0f
    j    .L_main_pc134
0:
    li   t0, 1
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
  .L_main_pc134:
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -48(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -8
    lw   t0, 12(sp)
    sw   t0, 0(sp)
    lw   t0, 8(sp)
    sw   t0, 4(sp)
    lw   a0, 44(sp)
    lw   a1, 40(sp)
    lw   a2, 36(sp)
    lw   a3, 32(sp)
    lw   a4, 28(sp)
    lw   a5, 24(sp)
    lw   a6, 20(sp)
    lw   a7, 16(sp)
    call parse_bc__U8Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array
    addi sp, sp, 48
    addi sp, sp, -4
    sw   a0, 0(sp)
    addi sp, sp, 4
    la   t1, g_in_len
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    sub  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -116(s0)
    lw   t0, -116(s0)
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
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 0(sp)
    call U8Array__u32
    addi sp, sp, 4
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -120(s0)
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -124(s0)
  .L_main_pc158:
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -116(s0)
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
    j    .L_main_pc176
0:
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -12(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    la   t1, g_in_pos
    lw   t0, 0(t1)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -124(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t1, 0(sp)
    lw   t0, 4(sp)
    addi sp, sp, 8
    add  t0, t0, t1
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 0(sp)
    call get__U8Array__i32
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
    lw   t0, -124(s0)
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
    sw   t0, -124(s0)
    j    .L_main_pc158
  .L_main_pc176:
    li   t0, 0
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_prog_stdin_pos
    sw   t0, 0(t1)
    lw   t0, -116(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    la   t1, g_prog_stdin_len
    sw   t0, 0(t1)
    lw   t0, -16(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -20(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -24(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -28(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -32(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -36(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -40(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -44(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -52(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -56(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -60(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -64(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -68(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -72(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -76(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -80(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -84(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -88(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -92(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -96(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    lw   t0, -120(s0)
    addi sp, sp, -4
    sw   t0, 0(sp)
    addi sp, sp, -52
    lw   t0, 100(sp)
    sw   t0, 0(sp)
    lw   t0, 96(sp)
    sw   t0, 4(sp)
    lw   t0, 92(sp)
    sw   t0, 8(sp)
    lw   t0, 88(sp)
    sw   t0, 12(sp)
    lw   t0, 84(sp)
    sw   t0, 16(sp)
    lw   t0, 80(sp)
    sw   t0, 20(sp)
    lw   t0, 76(sp)
    sw   t0, 24(sp)
    lw   t0, 72(sp)
    sw   t0, 28(sp)
    lw   t0, 68(sp)
    sw   t0, 32(sp)
    lw   t0, 64(sp)
    sw   t0, 36(sp)
    lw   t0, 60(sp)
    sw   t0, 40(sp)
    lw   t0, 56(sp)
    sw   t0, 44(sp)
    lw   t0, 52(sp)
    sw   t0, 48(sp)
    lw   a0, 132(sp)
    lw   a1, 128(sp)
    lw   a2, 124(sp)
    lw   a3, 120(sp)
    lw   a4, 116(sp)
    lw   a5, 112(sp)
    lw   a6, 108(sp)
    lw   a7, 104(sp)
    call vm_run__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__I32Array__U8Array
    addi sp, sp, 136
    addi sp, sp, -4
    sw   a0, 0(sp)
    lw   t0, 0(sp)
    addi sp, sp, 4
    sw   t0, -128(s0)
    lw   t0, -128(s0)
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
    .globl g_emit_int_tmp
g_emit_int_tmp:
    .word 0
    .globl OP_PUSH_INT
OP_PUSH_INT:
    .word 1
    .globl OP_PUSH_STR
OP_PUSH_STR:
    .word 2
    .globl OP_LOAD
OP_LOAD:
    .word 3
    .globl OP_STORE
OP_STORE:
    .word 4
    .globl OP_CALL
OP_CALL:
    .word 5
    .globl OP_RETURN
OP_RETURN:
    .word 6
    .globl OP_RETURN_VOID
OP_RETURN_VOID:
    .word 7
    .globl OP_POP
OP_POP:
    .word 8
    .globl OP_ADD
OP_ADD:
    .word 9
    .globl OP_SUB
OP_SUB:
    .word 10
    .globl OP_MUL
OP_MUL:
    .word 11
    .globl OP_DIV
OP_DIV:
    .word 12
    .globl OP_MOD
OP_MOD:
    .word 13
    .globl OP_AND
OP_AND:
    .word 14
    .globl OP_OR
OP_OR:
    .word 15
    .globl OP_XOR
OP_XOR:
    .word 16
    .globl OP_SHL
OP_SHL:
    .word 17
    .globl OP_SHR
OP_SHR:
    .word 18
    .globl OP_EQ
OP_EQ:
    .word 19
    .globl OP_NE
OP_NE:
    .word 20
    .globl OP_LT
OP_LT:
    .word 21
    .globl OP_LE
OP_LE:
    .word 22
    .globl OP_GT
OP_GT:
    .word 23
    .globl OP_GE
OP_GE:
    .word 24
    .globl OP_NEG
OP_NEG:
    .word 25
    .globl OP_LNOT
OP_LNOT:
    .word 26
    .globl OP_CAST
OP_CAST:
    .word 27
    .globl OP_JUMP
OP_JUMP:
    .word 28
    .globl OP_JUMP_IF
OP_JUMP_IF:
    .word 29
    .globl OP_JUMP_IFNOT
OP_JUMP_IFNOT:
    .word 30
    .globl OP_SHR_U
OP_SHR_U:
    .word 31
    .globl OP_LT_U
OP_LT_U:
    .word 32
    .globl OP_LE_U
OP_LE_U:
    .word 33
    .globl OP_GT_U
OP_GT_U:
    .word 34
    .globl OP_GE_U
OP_GE_U:
    .word 35
    .globl OP_DIV_U
OP_DIV_U:
    .word 36
    .globl OP_MOD_U
OP_MOD_U:
    .word 37
    .globl HK_U8
HK_U8:
    .word 1
    .globl HK_I32
HK_I32:
    .word 2
    .globl HK_STR
HK_STR:
    .word 3
    .globl TAG_INT
TAG_INT:
    .word 0
    .globl TAG_REF
TAG_REF:
    .word 1
    .globl g_cur_func
g_cur_func:
    .word 0
    .globl g_cur_pc
g_cur_pc:
    .word 0
    .globl g_sp
g_sp:
    .word 0
    .globl g_csp
g_csp:
    .word 0
    .globl g_frame_base
g_frame_base:
    .word 0
    .globl g_vp
g_vp:
    .word 0
    .globl g_pop_ival
g_pop_ival:
    .word 0
    .globl g_pop_tag
g_pop_tag:
    .word 0
    .globl g_udiv_q
g_udiv_q:
    .word 0
    .globl g_udiv_r
g_udiv_r:
    .word 0
    .globl g_cs_func
g_cs_func:
    .word 0
    .globl g_cs_pc
g_cs_pc:
    .word 0
    .globl g_cs_fbase
g_cs_fbase:
    .word 0
    .globl g_cs_vp
g_cs_vp:
    .word 0
    .globl g_cs_sp
g_cs_sp:
    .word 0
    .globl g_prog_stdin_pos
g_prog_stdin_pos:
    .word 0
    .globl g_prog_stdin_len
g_prog_stdin_len:
    .word 0
    .globl g_nfuncs
g_nfuncs:
    .word 0
    .globl g_nparams
g_nparams:
    .word 0
    .globl g_nlocals
g_nlocals:
    .word 0
    .globl g_ninstrs
g_ninstrs:
    .word 0
    .globl g_nglobals
g_nglobals:
    .word 0
    .globl g_nstrings
g_nstrings:
    .word 0
    .globl g_stab_pos
g_stab_pos:
    .word 0
    .globl g_in_pos
g_in_pos:
    .word 0
    .globl g_in_len
g_in_len:
    .word 0
    .globl g_heap_bytes_top
g_heap_bytes_top:
    .word 0
    .globl g_heap_i32s_top
g_heap_i32s_top:
    .word 0
    .globl g_heap_obj_count
g_heap_obj_count:
    .word 0

    .section .rodata
    .align 4
__StringBuffer__U8Array__i32__i32_strobj0:
    .word 2
    .string "or"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj1:
    .word 2
    .string "eq"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj2:
    .word 2
    .string "ne"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj3:
    .word 2
    .string "lt"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj4:
    .word 2
    .string "le"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj5:
    .word 2
    .string "gt"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj6:
    .word 2
    .string "ge"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj7:
    .word 3
    .string "add"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj8:
    .word 3
    .string "sub"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj9:
    .word 3
    .string "mul"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj10:
    .word 3
    .string "div"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj11:
    .word 3
    .string "mod"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj12:
    .word 3
    .string "and"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj13:
    .word 3
    .string "xor"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj14:
    .word 3
    .string "shl"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj15:
    .word 3
    .string "shr"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj16:
    .word 3
    .string "pop"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj17:
    .word 3
    .string "neg"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj18:
    .word 4
    .string "lnot"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj19:
    .word 4
    .string "cast"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj20:
    .word 4
    .string "load"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj21:
    .word 4
    .string "jump"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj22:
    .word 4
    .string "call"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj23:
    .word 4
    .string "lt_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj24:
    .word 4
    .string "le_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj25:
    .word 4
    .string "gt_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj26:
    .word 4
    .string "ge_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj27:
    .word 5
    .string "store"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj28:
    .word 5
    .string "shr_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj29:
    .word 5
    .string "div_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj30:
    .word 5
    .string "mod_u"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj31:
    .word 6
    .string "return"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj32:
    .word 7
    .string "jump_if"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj33:
    .word 8
    .string "push_int"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj34:
    .word 8
    .string "push_str"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj35:
    .word 10
    .string "jump_ifnot"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj36:
    .word 11
    .string "return_void"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj37:
    .word 26
    .string "undefined variable on load"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj38:
    .word 27
    .string "undefined variable on store"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj39:
    .word 14
    .string "divide by zero"
    .align 4
__StringBuffer__U8Array__i32__i32_strobj40:
    .word 25
    .string "divide by zero (unsigned)"


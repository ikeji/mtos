/*
 * runtime_syscall.c — bare-metal runtime using Linux ecall directly.
 * No libc dependency; works with riscv64-unknown-elf -march=rv32im.
 */
#include <stdint.h>

/* ===== Linux RISC-V syscall interface ===== */

static long __syscall1(long n, long a0) {
    register long s __asm__("a7") = n;
    register long r0 __asm__("a0") = a0;
    __asm__ volatile ("ecall" : "+r"(r0) : "r"(s) : "memory");
    return r0;
}

static long __syscall3(long n, long a0, long a1, long a2) {
    register long s  __asm__("a7") = n;
    register long r0 __asm__("a0") = a0;
    register long r1 __asm__("a1") = a1;
    register long r2 __asm__("a2") = a2;
    __asm__ volatile ("ecall" : "+r"(r0) : "r"(s),"r"(r1),"r"(r2) : "memory");
    return r0;
}

#define SYS_write  64
#define SYS_exit   93

static void do_write(int fd, const char *buf, int len) {
    __syscall3(SYS_write, fd, (long)buf, len);
}

/* ===== Integer to string helpers ===== */

static int i32_to_str(int32_t v, char *buf) {
    char tmp[12]; int neg = 0, i = 0, j = 0;
    if (v < 0) { neg = 1; v = -v; }
    if (v == 0) { tmp[i++] = '0'; }
    while (v > 0) { tmp[i++] = '0' + (v % 10); v /= 10; }
    if (neg) tmp[i++] = '-';
    for (int k = i - 1; k >= 0; k--) buf[j++] = tmp[k];
    buf[j++] = '\n'; buf[j] = '\0';
    return j;
}

static int u32_to_str(uint32_t v, char *buf) {
    char tmp[12]; int i = 0, j = 0;
    if (v == 0) { tmp[i++] = '0'; }
    while (v > 0) { tmp[i++] = '0' + (v % 10); v /= 10; }
    for (int k = i - 1; k >= 0; k--) buf[j++] = tmp[k];
    buf[j++] = '\n'; buf[j] = '\0';
    return j;
}

/* ===== HeapObj (minimal — arrays and strings) ===== */

#define OBJ_ARRAY  0
#define OBJ_STRING 1

/* Simple bump allocator (no free) */
static char heap_mem[65536];
static int  heap_pos = 0;

static void *bump_alloc(int size) {
    size = (size + 3) & ~3;  /* align to 4 */
    if (heap_pos + size > (int)sizeof(heap_mem)) {
        do_write(2, "runtime: out of heap\n", 21);
        __syscall1(SYS_exit, 1);
    }
    void *p = &heap_mem[heap_pos];
    heap_pos += size;
    return p;
}

typedef struct {
    int      kind;
    int      size;
    int      len;
    int      is_literal;
    int32_t *fields;
    uint8_t *bytes;
} HeapObj;

static HeapObj *new_obj(int kind) {
    HeapObj *o = bump_alloc(sizeof(HeapObj));
    o->kind = kind; o->size = 0; o->len = 0;
    o->is_literal = 0; o->fields = 0; o->bytes = 0;
    return o;
}

/* ===== Print helpers ===== */

void __tc_print_i32(int32_t v) {
    char buf[16]; int len = i32_to_str(v, buf);
    do_write(1, buf, len);
}

void __tc_print_u32(uint32_t v) {
    char buf[16]; int len = u32_to_str(v, buf);
    do_write(1, buf, len);
}

void __tc_print_bool(int32_t v) {
    if (v) do_write(1, "true\n",  5);
    else   do_write(1, "false\n", 6);
}

void __tc_print_str(HeapObj *s) {
    if (s && s->kind == OBJ_STRING && s->bytes)
        do_write(1, (char*)s->bytes, s->len);
    do_write(1, "\n", 1);
}

/* ===== String construction ===== */

HeapObj *__tc_make_string(const char *data, int len) {
    HeapObj *o = new_obj(OBJ_STRING);
    o->len = len; o->bytes = (uint8_t*)data; o->is_literal = 1;
    return o;
}

/* ===== Array operations ===== */

static HeapObj *new_array(int sz) {
    HeapObj *o = new_obj(OBJ_ARRAY);
    o->size = sz;
    o->fields = bump_alloc(sz > 0 ? sz * sizeof(int32_t) : 4);
    for (int i = 0; i < sz; i++) o->fields[i] = 0;
    return o;
}

HeapObj *__tc_newU8Array (int32_t sz) { return new_array(sz); }
HeapObj *__tc_newU16Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_newU32Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_newI8Array (int32_t sz) { return new_array(sz); }
HeapObj *__tc_newI16Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_newI32Array(int32_t sz) { return new_array(sz); }

int32_t __tc_len(HeapObj *o) {
    if (!o) return 0;
    return o->kind == OBJ_ARRAY ? o->size : o->len;
}

int32_t __tc_get(HeapObj *o, int32_t idx) {
    if (!o || idx < 0 || idx >= o->size) {
        do_write(2, "get: out of bounds\n", 19);
        __syscall1(SYS_exit, 1);
    }
    return o->fields[idx];
}

void __tc_set(HeapObj *o, int32_t idx, int32_t val) {
    if (!o || idx < 0 || idx >= o->size) {
        do_write(2, "set: out of bounds\n", 19);
        __syscall1(SYS_exit, 1);
    }
    o->fields[idx] = val;
}

void __tc_delete(HeapObj *o) { (void)o; /* bump allocator — no-op */ }

/* ===== String operations ===== */

int32_t __tc_getChar(HeapObj *s, int32_t idx) {
    if (!s || s->kind != OBJ_STRING || idx < 0 || idx >= s->len) return 0;
    return s->bytes[idx];
}

HeapObj *__tc_append_char(HeapObj *s, int32_t c) {
    int sl = s ? s->len : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + 1;
    ns->bytes = bump_alloc(ns->len + 1);
    for (int i = 0; i < sl; i++) ns->bytes[i] = s->bytes[i];
    ns->bytes[sl] = (uint8_t)c;
    ns->bytes[ns->len] = 0;
    return ns;
}

HeapObj *__tc_append_str(HeapObj *s, HeapObj *t) {
    int sl = s ? s->len : 0, tl = t ? t->len : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + tl;
    ns->bytes = bump_alloc(ns->len + 1);
    for (int i = 0; i < sl; i++) ns->bytes[i] = s->bytes[i];
    for (int i = 0; i < tl; i++) ns->bytes[sl+i] = t->bytes[i];
    ns->bytes[ns->len] = 0;
    return ns;
}

int32_t __tc_equals(HeapObj *s, HeapObj *t) {
    if (!s || !t) return s == t;
    if (s->len != t->len) return 0;
    for (int i = 0; i < s->len; i++)
        if (s->bytes[i] != t->bytes[i]) return 0;
    return 1;
}

/* ===== peek / poke ===== */

uint32_t __tc_peek8 (uint32_t a) { return *(uint8_t  *)a; }
uint32_t __tc_peek16(uint32_t a) { return *(uint16_t *)a; }
uint32_t __tc_peek32(uint32_t a) { return *(uint32_t *)a; }
void __tc_poke8 (uint32_t a, uint32_t v) { *(uint8_t  *)a = v; }
void __tc_poke16(uint32_t a, uint32_t v) { *(uint16_t *)a = v; }
void __tc_poke32(uint32_t a, uint32_t v) { *(uint32_t *)a = v; }

/* ===== sys calls ===== */

int32_t __tc_sys_write(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    /* write bytes directly from fields array */
    char tmp[256];
    int chunk = n < 256 ? n : 256;
    for (int i = 0; i < chunk; i++) tmp[i] = (char)buf->fields[i];
    return (int32_t)__syscall3(SYS_write, fd, (long)tmp, chunk);
}

int32_t __tc_sys_read(int32_t fd, HeapObj *buf, int32_t len) {
    (void)fd; (void)buf; (void)len; return -1; /* not implemented */
}

void __tc_sys_exit(int32_t code) { __syscall1(SYS_exit, code); }

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

#define SYS_read   63
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

/* Power-of-2 pool allocator with 19 size classes.
 * Each bucket holds a fixed set of pre-linked slots; alloc/free are O(1)
 * within a bucket, O(NPOOLS=19) for locating the bucket on free.
 * See docs/task/pool_allocator.md for sizing rationale. */
#define NPOOLS 19
static const int pool_size[NPOOLS] = {
    16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192,
    16384, 32768, 65536, 131072, 262144, 524288,
    1048576, 2097152, 4194304
};
static const int pool_count[NPOOLS] = {
    128, 32768, 64, 64, 32, 32, 16, 16, 16, 16,
    32, 8, 8, 4, 48, 4, 4, 4, 2
};
static char heap_mem[50331648]; /* 48MB arena */
static char *pool_free[NPOOLS];
static char *pool_base[NPOOLS];
static char *pool_end[NPOOLS];
static int   pools_ready = 0;

static void pool_init(void) {
    char *p = heap_mem;
    char *limit = heap_mem + sizeof(heap_mem);
    for (int i = 0; i < NPOOLS; i++) {
        int sz = pool_size[i];
        int n  = pool_count[i];
        pool_base[i] = p;
        pool_free[i] = p;
        for (int j = 0; j < n - 1; j++) {
            *(char **)p = p + sz;
            p += sz;
        }
        *(char **)p = 0;
        p += sz;
        pool_end[i] = p;
    }
    if (p > limit) {
        do_write(2, "runtime: arena too small\n", 25);
        __syscall1(SYS_exit, 1);
    }
    pools_ready = 1;
}

static int bucket_of(int size) {
    int i = 0, v = pool_size[0];
    while (v < size && i < NPOOLS - 1) { i++; v = pool_size[i]; }
    return i;
}

static void *pool_alloc(int size) {
    if (!pools_ready) pool_init();
    if (size <= 0) size = 1;
    int i = bucket_of(size);
    if (!pool_free[i]) {
        do_write(2, "runtime: pool OOM bucket=", 25);
        char tmp[16]; int n = i32_to_str(i, tmp);
        do_write(2, tmp, n);
        do_write(2, "size=", 5);
        n = i32_to_str(pool_size[i], tmp);
        do_write(2, tmp, n);
        __syscall1(SYS_exit, 1);
    }
    char *slot = pool_free[i];
    pool_free[i] = *(char **)slot;
    int sz = pool_size[i];
    for (int k = 0; k < sz; k++) slot[k] = 0;
    return slot;
}

static void pool_free_blk(void *ptr) {
    if (!ptr) return;
    char *p = (char *)ptr;
    for (int i = 0; i < NPOOLS; i++) {
        if (p >= pool_base[i] && p < pool_end[i]) {
            *(char **)p = pool_free[i];
            pool_free[i] = p;
            return;
        }
    }
    do_write(2, "runtime: bad free\n", 18);
    __syscall1(SYS_exit, 1);
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
    HeapObj *o = pool_alloc(sizeof(HeapObj));
    o->kind = kind;
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
    o->fields = pool_alloc(sz > 0 ? sz * (int)sizeof(int32_t) : 4);
    return o;
}

HeapObj *__tc_U8Array (int32_t sz) { return new_array(sz); }
HeapObj *__tc_U16Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_U32Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_I8Array (int32_t sz) { return new_array(sz); }
HeapObj *__tc_I16Array(int32_t sz) { return new_array(sz); }
HeapObj *__tc_I32Array  (int32_t sz) { return new_array(sz); }
HeapObj *__tc_StringArray(int32_t sz) { return new_array(sz); }
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
    if (!o) { do_write(2, "get: null\n", 10); __syscall1(SYS_exit, 1); }
    if (o->kind == OBJ_STRING) {
        if (idx < 0 || idx >= o->len) return 0;
        return o->bytes[idx];
    }
    if (idx < 0 || idx >= o->size) {
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

void __tc_delete(HeapObj *o) {
    if (!o) return;
    if (!o->is_literal) {
        if (o->kind == OBJ_ARRAY) pool_free_blk(o->fields);
        else if (o->bytes)        pool_free_blk(o->bytes);
    }
    pool_free_blk(o);
}

/* Mark/reset are no-ops now that the pool allocator supports free(). */
int32_t __tc_heap_mark(void) { return 0; }
void __tc_heap_reset(int32_t mark) { (void)mark; }

/* ===== String operations ===== */

HeapObj *__tc_append_char(HeapObj *s, int32_t c) {
    int sl = s ? s->len : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + 1;
    ns->bytes = pool_alloc(ns->len + 1);
    for (int i = 0; i < sl; i++) ns->bytes[i] = s->bytes[i];
    ns->bytes[sl] = (uint8_t)c;
    ns->bytes[ns->len] = 0;
    return ns;
}

HeapObj *__tc_append_str(HeapObj *s, HeapObj *t) {
    int sl = s ? s->len : 0, tl = t ? t->len : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + tl;
    ns->bytes = pool_alloc(ns->len + 1);
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
    char tmp[256];
    int total = 0;
    while (total < n) {
        int chunk = (n - total) < 256 ? (n - total) : 256;
        for (int i = 0; i < chunk; i++) tmp[i] = (char)buf->fields[total + i];
        long r = __syscall3(SYS_write, fd, (long)tmp, chunk);
        if (r <= 0) break;
        total += (int)r;
    }
    return total;
}

int32_t __tc_sys_read(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    char tmp[256];
    int total = 0;
    while (total < n) {
        int chunk = (n - total) < 256 ? (n - total) : 256;
        long r = __syscall3(SYS_read, fd, (long)tmp, chunk);
        if (r <= 0) break;
        for (int i = 0; i < (int)r; i++)
            buf->fields[total + i] = (uint8_t)tmp[i];
        total += (int)r;
    }
    return total;
}

void __tc_sys_exit(int32_t code) { __syscall1(SYS_exit, code); }

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
    256, 32768, 256, 128, 64, 256, 64, 64, 32, 16,
    32, 8, 8, 4, 8, 4, 4, 4, 2
};
static char heap_mem[50331648]; /* 48MB arena */
static char *pool_free[NPOOLS];
static char *pool_base[NPOOLS];
static char *pool_end[NPOOLS];
static int   pools_ready = 0;

/* Stats: per-bucket live count and peak */
static int pool_live[NPOOLS];
static int pool_peak[NPOOLS];
static int pool_total[NPOOLS];

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
    pool_live[i]++;
    pool_total[i]++;
    if (pool_live[i] > pool_peak[i]) pool_peak[i] = pool_live[i];
    return slot;
}

static void pool_free_blk(void *ptr) {
    if (!ptr) return;
    char *p = (char *)ptr;
    for (int i = 0; i < NPOOLS; i++) {
        if (p >= pool_base[i] && p < pool_end[i]) {
            *(char **)p = pool_free[i];
            pool_free[i] = p;
            pool_live[i]--;
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
    void    *data;     /* int32_t* for arrays, uint8_t* for strings */
} HeapObj;

static HeapObj *new_obj(int kind) {
    HeapObj *o = pool_alloc(sizeof(HeapObj));
    o->kind = kind;
    return o;
}

/* ===== Print helpers ===== */

void print_i32__i32(int32_t v) {
    char buf[16]; int len = i32_to_str(v, buf);
    do_write(1, buf, len);
}

void print_u32__u32(uint32_t v) {
    char buf[16]; int len = u32_to_str(v, buf);
    do_write(1, buf, len);
}

void print_bool__bool(int32_t v) {
    if (v) do_write(1, "true\n",  5);
    else   do_write(1, "false\n", 6);
}

void print_str__String(HeapObj *s) {
    if (s && s->kind == OBJ_STRING && s->data)
        do_write(1, (char*)s->data, s->len);
    do_write(1, "\n", 1);
}

/* ===== Array operations ===== */

static HeapObj *new_array(int sz) {
    HeapObj *o = new_obj(OBJ_ARRAY);
    o->size = sz;
    o->data = pool_alloc(sz > 0 ? sz * (int)sizeof(int32_t) : 4);
    return o;
}

/* Array constructors — mangled as TypeName__i32 */
#define ARRAY_CTOR(T) HeapObj * T##__i32(int32_t sz) { return new_array(sz); }
ARRAY_CTOR(U8Array)
ARRAY_CTOR(U16Array)
ARRAY_CTOR(U32Array)
ARRAY_CTOR(I8Array)
ARRAY_CTOR(I16Array)
ARRAY_CTOR(I32Array)
ARRAY_CTOR(StringArray)

/* len — all array/string types share the same implementation */
static int32_t len_impl(HeapObj *o) {
    if (!o) return 0;
    return o->kind == OBJ_ARRAY ? o->size : o->len;
}
#define LEN_ALIAS(T) int32_t len__##T(HeapObj *o) { return len_impl(o); }
LEN_ALIAS(U8Array)   LEN_ALIAS(U16Array)  LEN_ALIAS(U32Array)
LEN_ALIAS(I8Array)   LEN_ALIAS(I16Array)  LEN_ALIAS(I32Array)
LEN_ALIAS(StringArray) LEN_ALIAS(String)

/* get — all array/string types share the same implementation */
static int32_t get_impl(HeapObj *o, int32_t idx) {
    if (!o) { do_write(2, "get: null\n", 10); __syscall1(SYS_exit, 1); }
    if (o->kind == OBJ_STRING) {
        if (idx < 0 || idx >= o->len) return 0;
        return ((uint8_t*)o->data)[idx];
    }
    if (idx < 0 || idx >= o->size) {
        do_write(2, "get: out of bounds\n", 19);
        __syscall1(SYS_exit, 1);
    }
    return ((int32_t*)o->data)[idx];
}
#define GET_ALIAS(T) int32_t get__##T##__i32(HeapObj *o, int32_t i) { return get_impl(o, i); }
GET_ALIAS(U8Array)   GET_ALIAS(U16Array)  GET_ALIAS(U32Array)
GET_ALIAS(I8Array)   GET_ALIAS(I16Array)  GET_ALIAS(I32Array)
GET_ALIAS(StringArray) GET_ALIAS(String)

/* set — all array types share the same implementation */
static void set_impl(HeapObj *o, int32_t idx, int32_t val) {
    if (!o || idx < 0 || idx >= o->size) {
        do_write(2, "set: out of bounds\n", 19);
        __syscall1(SYS_exit, 1);
    }
    ((int32_t*)o->data)[idx] = val;
}
void set__U8Array__i32__u8    (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__U16Array__i32__u16  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__U32Array__i32__u32  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I8Array__i32__i8    (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I16Array__i32__i16  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__I32Array__i32__i32  (HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }
void set__StringArray__i32__String(HeapObj *o, int32_t i, int32_t v) { set_impl(o,i,v); }

/* delete — all types share the same implementation */
static void delete_impl(HeapObj *o) {
    if (!o) return;
    if (o->is_literal) return;
    if (o->data) pool_free_blk(o->data);
    pool_free_blk(o);
}
#define DELETE_ALIAS(T) void delete__##T(HeapObj *o) { delete_impl(o); }
DELETE_ALIAS(U8Array)   DELETE_ALIAS(U16Array)  DELETE_ALIAS(U32Array)
DELETE_ALIAS(I8Array)   DELETE_ALIAS(I16Array)  DELETE_ALIAS(I32Array)
DELETE_ALIAS(StringArray) DELETE_ALIAS(String)

/* Mark/reset are no-ops now that the pool allocator supports free(). */
int32_t heap_mark(void) { return 0; }
void heap_reset__i32(int32_t mark) { (void)mark; }

/* ===== String operations ===== */

HeapObj *append__String__u8(HeapObj *s, int32_t c) {
    int sl = s ? s->len : 0;
    uint8_t *sb = s ? (uint8_t*)s->data : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + 1;
    uint8_t *nb = pool_alloc(ns->len + 1);
    for (int i = 0; i < sl; i++) nb[i] = sb[i];
    nb[sl] = (uint8_t)c;
    nb[ns->len] = 0;
    ns->data = nb;
    return ns;
}

HeapObj *append__String__String(HeapObj *s, HeapObj *t) {
    int sl = s ? s->len : 0, tl = t ? t->len : 0;
    uint8_t *sb = s ? (uint8_t*)s->data : 0;
    uint8_t *tb = t ? (uint8_t*)t->data : 0;
    HeapObj *ns = new_obj(OBJ_STRING);
    ns->len = sl + tl;
    uint8_t *nb = pool_alloc(ns->len + 1);
    for (int i = 0; i < sl; i++) nb[i] = sb[i];
    for (int i = 0; i < tl; i++) nb[sl+i] = tb[i];
    nb[ns->len] = 0;
    ns->data = nb;
    return ns;
}

int32_t equals__String__String(HeapObj *s, HeapObj *t) {
    if (!s || !t) return s == t;
    if (s->len != t->len) return 0;
    uint8_t *sb = (uint8_t*)s->data, *tb = (uint8_t*)t->data;
    for (int i = 0; i < s->len; i++)
        if (sb[i] != tb[i]) return 0;
    return 1;
}

/* ===== peek / poke ===== */

uint32_t peek8__u32 (uint32_t a) { return *(uint8_t  *)a; }
uint32_t peek16__u32(uint32_t a) { return *(uint16_t *)a; }
uint32_t peek32__u32(uint32_t a) { return *(uint32_t *)a; }
void poke8__u32__u32 (uint32_t a, uint32_t v) { *(uint8_t  *)a = v; }
void poke16__u32__u32(uint32_t a, uint32_t v) { *(uint16_t *)a = v; }
void poke32__u32__u32(uint32_t a, uint32_t v) { *(uint32_t *)a = v; }

/* ===== sys calls ===== */

static int32_t sys_write_impl(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    char tmp[256];
    int total = 0;
    while (total < n) {
        int chunk = (n - total) < 256 ? (n - total) : 256;
        int32_t *fp = (int32_t*)buf->data;
        for (int i = 0; i < chunk; i++) tmp[i] = (char)fp[total + i];
        long r = __syscall3(SYS_write, fd, (long)tmp, chunk);
        if (r <= 0) break;
        total += (int)r;
    }
    return total;
}
int32_t sys_write__i32__U8Array__i32(int32_t fd, HeapObj *b, int32_t l) { return sys_write_impl(fd,b,l); }

static int32_t sys_read_impl(int32_t fd, HeapObj *buf, int32_t len) {
    if (!buf || buf->kind != OBJ_ARRAY) return -1;
    int n = len < buf->size ? len : buf->size;
    char tmp[256];
    int total = 0;
    while (total < n) {
        int chunk = (n - total) < 256 ? (n - total) : 256;
        long r = __syscall3(SYS_read, fd, (long)tmp, chunk);
        if (r <= 0) break;
        for (int i = 0; i < (int)r; i++)
            ((int32_t*)buf->data)[total + i] = (uint8_t)tmp[i];
        total += (int)r;
    }
    return total;
}
int32_t sys_read__i32__U8Array__i32(int32_t fd, HeapObj *b, int32_t l) { return sys_read_impl(fd,b,l); }

static void pool_dump_stats(void) {
    char tmp[16]; int n;
    do_write(2, "\npool stats (bucket: peak/total/provisioned):\n", 46);
    for (int i = 0; i < NPOOLS; i++) {
        if (pool_total[i] == 0 && pool_peak[i] == 0) continue;
        n = i32_to_str(pool_size[i], tmp); tmp[n-1] = ' '; /* strip \n */
        do_write(2, "  ", 2); do_write(2, tmp, n);
        do_write(2, ": ", 2);
        n = i32_to_str(pool_peak[i], tmp); tmp[n-1] = '/';
        do_write(2, tmp, n);
        n = i32_to_str(pool_total[i], tmp); tmp[n-1] = '/';
        do_write(2, tmp, n);
        n = i32_to_str(pool_count[i], tmp);
        do_write(2, tmp, n);
    }
}

void sys_exit__i32(int32_t code) {
    pool_dump_stats();
    __syscall1(SYS_exit, code);
}

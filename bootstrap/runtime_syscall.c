/*
 * runtime_syscall.c — bare-metal runtime using Linux ecall directly.
 * No libc dependency; works with riscv64-unknown-elf -march=rv32im.
 *
 * HeapObj layout: a single allocation with count prefix.
 *   ptr → [ count (4 bytes) | data (variable) ]
 *   OBJ_COUNT(p) = *(int*)p
 *   OBJ_DATA(p)  = (char*)p + 4
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

/* ===== HeapObj: count-prefixed allocation ===== */
/* Layout: [ int count | data bytes... ]
 * Pointer passed around points to the start (count field).
 * OBJ_COUNT(p) reads the count, OBJ_DATA(p) points to the data area. */

typedef int32_t* HeapObj;

#define OBJ_COUNT(p) (*(int32_t*)(p))
#define OBJ_DATA(p)  ((void*)((char*)(p) + 4))

/* Power-of-2 pool allocator with 19 size classes.
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

/* Allocate a count-prefixed object: 4 bytes count + data_bytes */
static HeapObj new_array(int count, int data_bytes) {
    int total = 4 + (data_bytes > 0 ? data_bytes : 0);
    HeapObj o = pool_alloc(total);
    OBJ_COUNT(o) = count;
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

void print_str__String(HeapObj s) {
    if (s) do_write(1, (char*)OBJ_DATA(s), OBJ_COUNT(s));
    do_write(1, "\n", 1);
}

void print_str__StringLiteral(HeapObj s) {
    print_str__String(s);
}

/* ===== Array operations ===== */

/* Typed array constructor: count-prefixed, 4 + count*elem_bytes */
static HeapObj new_typed_array(int sz, int elem_bytes) {
    return new_array(sz, sz > 0 ? sz * elem_bytes : 4);
}

HeapObj U8Array__u32 (uint32_t sz) { return new_typed_array((int32_t)sz, 1); }
HeapObj U16Array__u32(uint32_t sz) { return new_typed_array((int32_t)sz, 2); }
HeapObj U32Array__u32(uint32_t sz) { return new_typed_array((int32_t)sz, 4); }
HeapObj I8Array__u32 (uint32_t sz) { return new_typed_array((int32_t)sz, 1); }
HeapObj I16Array__u32(uint32_t sz) { return new_typed_array((int32_t)sz, 2); }
HeapObj I32Array__u32(uint32_t sz) { return new_typed_array((int32_t)sz, 4); }
HeapObj StringArray__u32(uint32_t sz) { return new_typed_array((int32_t)sz, 4); }

/* len */
static int32_t len_impl(HeapObj o) {
    if (!o) return 0;
    return OBJ_COUNT(o);
}
#define LEN_ALIAS(T) int32_t len__##T(HeapObj o) { return len_impl(o); }
LEN_ALIAS(U8Array)   LEN_ALIAS(U16Array)  LEN_ALIAS(U32Array)
LEN_ALIAS(I8Array)   LEN_ALIAS(I16Array)  LEN_ALIAS(I32Array)
LEN_ALIAS(StringArray) LEN_ALIAS(String) LEN_ALIAS(StringLiteral)

/* get — typed per element size */
static void get_null_check(HeapObj o) {
    if (!o) { do_write(2, "get: null\n", 10); __syscall1(SYS_exit, 1); }
}
/* Emit "get: <idx> out of bounds (len=<n>)\n" then exit. Hand-rolled
   instead of snprintf so we don't depend on libc stdio. */
static void get_bounds_check(HeapObj o, int32_t idx) {
    if (idx < 0 || idx >= OBJ_COUNT(o)) {
        char tmp[16]; int n;
        do_write(2, "get: ", 5);
        n = i32_to_str(idx, tmp); tmp[n-1] = ' '; do_write(2, tmp, n);
        do_write(2, "out of bounds (len=", 19);
        n = i32_to_str(OBJ_COUNT(o), tmp); tmp[n-1] = ')'; do_write(2, tmp, n);
        do_write(2, "\n", 1);
        __syscall1(SYS_exit, 1);
    }
}

int32_t get__U8Array__i32 (HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((uint8_t *)OBJ_DATA(o))[i]; }
int32_t get__U16Array__i32(HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((uint16_t*)OBJ_DATA(o))[i]; }
int32_t get__U32Array__i32(HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((uint32_t*)OBJ_DATA(o))[i]; }
int32_t get__I8Array__i32 (HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((int8_t  *)OBJ_DATA(o))[i]; }
int32_t get__I16Array__i32(HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((int16_t *)OBJ_DATA(o))[i]; }
int32_t get__I32Array__i32(HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((int32_t *)OBJ_DATA(o))[i]; }
int32_t get__StringArray__i32(HeapObj o, int32_t i) { get_null_check(o); get_bounds_check(o,i); return ((int32_t *)OBJ_DATA(o))[i]; }
int32_t get__String__i32(HeapObj o, int32_t i) {
    get_null_check(o);
    if (i < 0 || i >= OBJ_COUNT(o)) return 0;
    return ((uint8_t*)OBJ_DATA(o))[i];
}
int32_t get__StringLiteral__i32(HeapObj o, int32_t i) {
    return get__String__i32(o, i);
}

/* set — typed per element size */
static void set_bounds_check(HeapObj o, int32_t idx) {
    if (!o) {
        do_write(2, "set: null\n", 10); __syscall1(SYS_exit, 1);
    }
    if (idx < 0 || idx >= OBJ_COUNT(o)) {
        char tmp[16]; int n;
        do_write(2, "set: ", 5);
        n = i32_to_str(idx, tmp); tmp[n-1] = ' '; do_write(2, tmp, n);
        do_write(2, "out of bounds (len=", 19);
        n = i32_to_str(OBJ_COUNT(o), tmp); tmp[n-1] = ')'; do_write(2, tmp, n);
        do_write(2, "\n", 1);
        __syscall1(SYS_exit, 1);
    }
}

void set__U8Array__i32__u8    (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((uint8_t *)OBJ_DATA(o))[i] = (uint8_t)v; }
void set__U16Array__i32__u16  (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((uint16_t*)OBJ_DATA(o))[i] = (uint16_t)v; }
void set__U32Array__i32__u32  (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((uint32_t*)OBJ_DATA(o))[i] = (uint32_t)v; }
void set__I8Array__i32__i8    (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((int8_t  *)OBJ_DATA(o))[i] = (int8_t)v; }
void set__I16Array__i32__i16  (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((int16_t *)OBJ_DATA(o))[i] = (int16_t)v; }
void set__I32Array__i32__i32  (HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((int32_t *)OBJ_DATA(o))[i] = v; }
void set__StringArray__i32__String(HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((int32_t *)OBJ_DATA(o))[i] = v; }
void set__StringArray__i32__StringLiteral(HeapObj o, int32_t i, int32_t v) { set_bounds_check(o,i); ((int32_t *)OBJ_DATA(o))[i] = v; }

/* delete — single free (count + data in one allocation) */
static void delete_impl(HeapObj o) {
    if (!o) return;
    pool_free_blk(o);
}
#define DELETE_ALIAS(T) void delete__##T(HeapObj o) { delete_impl(o); }
DELETE_ALIAS(U8Array)   DELETE_ALIAS(U16Array)  DELETE_ALIAS(U32Array)
DELETE_ALIAS(I8Array)   DELETE_ALIAS(I16Array)  DELETE_ALIAS(I32Array)
DELETE_ALIAS(StringArray) DELETE_ALIAS(String)
void delete__StringLiteral(HeapObj o) { (void)o; /* no-op: .rodata */ }


/* ===== String operations ===== */

HeapObj append__String__u8(HeapObj s, int32_t c) {
    int sl = s ? OBJ_COUNT(s) : 0;
    HeapObj ns = new_array(sl + 1, sl + 2);
    uint8_t *nd = (uint8_t*)OBJ_DATA(ns);
    if (s) { uint8_t *sd = (uint8_t*)OBJ_DATA(s); for (int i = 0; i < sl; i++) nd[i] = sd[i]; }
    nd[sl] = (uint8_t)c;
    nd[sl + 1] = 0;
    return ns;
}

HeapObj append__String__String(HeapObj s, HeapObj t) {
    int sl = s ? OBJ_COUNT(s) : 0, tl = t ? OBJ_COUNT(t) : 0;
    HeapObj ns = new_array(sl + tl, sl + tl + 1);
    uint8_t *nd = (uint8_t*)OBJ_DATA(ns);
    if (s) { uint8_t *sd = (uint8_t*)OBJ_DATA(s); for (int i = 0; i < sl; i++) nd[i] = sd[i]; }
    if (t) { uint8_t *td = (uint8_t*)OBJ_DATA(t); for (int i = 0; i < tl; i++) nd[sl+i] = td[i]; }
    nd[sl + tl] = 0;
    return ns;
}

/* StringLiteral append overloads */
HeapObj append__StringLiteral__u8(HeapObj s, int32_t c) { return append__String__u8(s, c); }
HeapObj append__StringLiteral__StringLiteral(HeapObj s, HeapObj t) { return append__String__String(s, t); }
HeapObj append__StringLiteral__String(HeapObj s, HeapObj t) { return append__String__String(s, t); }
HeapObj append__String__StringLiteral(HeapObj s, HeapObj t) { return append__String__String(s, t); }

int32_t equals__String__String(HeapObj s, HeapObj t) {
    if (!s || !t) return s == t;
    if (OBJ_COUNT(s) != OBJ_COUNT(t)) return 0;
    uint8_t *sb = (uint8_t*)OBJ_DATA(s), *tb = (uint8_t*)OBJ_DATA(t);
    for (int i = 0; i < OBJ_COUNT(s); i++)
        if (sb[i] != tb[i]) return 0;
    return 1;
}

/* StringLiteral equals overloads */
int32_t equals__StringLiteral__StringLiteral(HeapObj s, HeapObj t) { return equals__String__String(s, t); }
int32_t equals__StringLiteral__String(HeapObj s, HeapObj t) { return equals__String__String(s, t); }
int32_t equals__String__StringLiteral(HeapObj s, HeapObj t) { return equals__String__String(s, t); }

/* ===== peek / poke ===== */

uint32_t peek8__u32 (uint32_t a) { return *(uint8_t  *)a; }
uint32_t peek16__u32(uint32_t a) { return *(uint16_t *)a; }
uint32_t peek32__u32(uint32_t a) { return *(uint32_t *)a; }
void poke8__u32__u32 (uint32_t a, uint32_t v) { *(uint8_t  *)a = v; }
void poke16__u32__u32(uint32_t a, uint32_t v) { *(uint16_t *)a = v; }
void poke32__u32__u32(uint32_t a, uint32_t v) { *(uint32_t *)a = v; }

/* ===== sys calls ===== */

int32_t sys_write__i32__U8Array__i32(int32_t fd, HeapObj buf, int32_t len) {
    if (!buf) return -1;
    int n = len < OBJ_COUNT(buf) ? len : OBJ_COUNT(buf);
    uint8_t *p = (uint8_t*)OBJ_DATA(buf);
    int total = 0;
    while (total < n) {
        long r = __syscall3(SYS_write, fd, (long)(p + total), n - total);
        if (r <= 0) break;
        total += (int)r;
    }
    return total;
}

int32_t sys_read__i32__U8Array__i32(int32_t fd, HeapObj buf, int32_t len) {
    if (!buf) return -1;
    int n = len < OBJ_COUNT(buf) ? len : OBJ_COUNT(buf);
    uint8_t *p = (uint8_t*)OBJ_DATA(buf);
    int total = 0;
    while (total < n) {
        long r = __syscall3(SYS_read, fd, (long)(p + total), n - total);
        if (r <= 0) break;
        total += (int)r;
    }
    return total;
}

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
    /* Silent by default so compile-gen*.sh can surface real errors
       without the 14-line pool stats noise drowning them. See
       problem.md #14. pool_dump_stats() is still defined above
       for future opt-in use (ENV var / debug flag). */
    (void)pool_dump_stats;  /* silence unused-function warning */
    __syscall1(SYS_exit, code);
}

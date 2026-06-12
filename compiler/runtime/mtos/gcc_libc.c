/*
 * gcc_libc.c — minimal libc shim for GCC-compiled tasks.
 *
 * Implements what `_start` (gcc_crt0.s) and small programs need to do
 * useful work:
 *
 *   _libc_init_heap   — set up sbrk bump allocator from the kernel arena
 *   _libc_unpack_argv — convert kernel's StringArray to C argv/argc
 *   _sbrk             — heap grow; called by malloc / printf scratch
 *   write/read/open/close/lseek — POSIX-ish wrappers around our syscalls
 *
 * No printf yet — phase 0 smoke test writes a literal string directly via
 * write(1, ...). Wire newlib in once the basics are confirmed.
 */

#include <stddef.h>
#include <stdint.h>

/* Syscall stubs. ABI: a7 = syscall number, a0..a5 = args, a0 = return. */
static inline long _syscall3(long n, long a, long b, long c) {
    register long _a __asm__("a0") = a;
    register long _b __asm__("a1") = b;
    register long _c __asm__("a2") = c;
    register long _n __asm__("a7") = n;
    __asm__ volatile("ecall"
                     : "+r"(_a)
                     : "r"(_b), "r"(_c), "r"(_n)
                     : "memory");
    return _a;
}
static inline long _syscall1(long n, long a) {
    register long _a __asm__("a0") = a;
    register long _n __asm__("a7") = n;
    __asm__ volatile("ecall" : "+r"(_a) : "r"(_n) : "memory");
    return _a;
}

/* ---------- POSIX-ish syscalls ---------- */

long write(int fd, const void *buf, unsigned long n) {
    return _syscall3(64, fd, (long)buf, n);
}

long read(int fd, void *buf, unsigned long n) {
    return _syscall3(63, fd, (long)buf, n);
}

long close(int fd) { return _syscall1(57, fd); }

void _exit(int rc) {
    _syscall1(93, rc);
    for (;;) {}
}

/* openat-style: takes a String (length-prefixed) for path. C callers
   that want POSIX open() need to wrap their C string into a String;
   that wrapper lives outside this phase 0 stub. */
long do_openat(int dirfd, const void *path_str, int flags) {
    return _syscall3(56, dirfd, (long)path_str, flags);
}

/* ---------- sbrk bump allocator ---------- */

static char *g_heap_base = 0;
static char *g_heap_brk  = 0;
static char *g_heap_end  = 0;

void _libc_init_heap(void *arena_addr, long arena_size) {
    g_heap_base = (char *)arena_addr;
    g_heap_brk  = g_heap_base;
    g_heap_end  = g_heap_base + arena_size;
}

void *_sbrk(long n) {
    if (g_heap_brk == 0) return (void *)-1;
    char *prev = g_heap_brk;
    char *next = prev + n;
    if (next < g_heap_base || next > g_heap_end) return (void *)-1;
    g_heap_brk = next;
    return prev;
}

/* ---------- argv unpacking ---------- */

/* Cap on argv we hand to main; bigger requests fall off the end and
   the binary still gets argv[ARGV_MAX-1] = NULL terminator. */
#define ARGV_MAX 32
char *g_argv[ARGV_MAX + 1];   /* +1 for trailing NULL */

/* Each kernel-side String / StringLiteral is laid out as:
     [count:u32][bytes...][\0]    — bytes is `count` long
   Translate to a C-pointer to the first byte of `bytes`. The NUL byte
   after `bytes` is guaranteed by the kernel's argv packer (kernel/
   loader.tc::pack_argv_at), so the resulting pointer is a valid
   C-string for any consumer that strlen()s it. */
static char *_string_to_cstr(unsigned long s_ptr) {
    if (s_ptr == 0) return 0;
    return (char *)(s_ptr + 4);
}

/* Read the count field of a StringArray. Layout:
     [count:u32][p0:u32][p1:u32]...
   Returns argc; populates g_argv. */
int _libc_unpack_argv(unsigned long sa_ptr) {
    int argc = 0;
    if (sa_ptr == 0) {
        g_argv[0] = 0;
        return 0;
    }
    unsigned long *base = (unsigned long *)sa_ptr;
    unsigned int  count = (unsigned int)base[0];
    if (count > ARGV_MAX) count = ARGV_MAX;
    for (unsigned int i = 0; i < count; i++) {
        g_argv[i] = _string_to_cstr(base[1 + i]);
        argc++;
    }
    g_argv[argc] = 0;
    return argc;
}

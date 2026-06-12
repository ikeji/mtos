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

/* The three heap pointers (base / brk / end) live in a 12-byte
   block in .bss whose address sits in tp by the time main runs —
   gcc_crt0.s does `addi tp, gp, %lo(__heap_state_gp_off)` once,
   and the kernel's trap_common.s preserves tp across context
   switches the same way it does s0..s11. Going through tp instead
   of a C-level global sidesteps a binutils gp-relax quirk where one
   of several consecutive `auipc + lw/sw` pairs silently fails to
   collapse to `lw/sw rd, off(gp)`; the surviving auipc bakes in the
   link-time VMA and the task crashes when the kernel loads it at a
   different RAM address. */
typedef struct { char *base; char *brk; char *end; } heap_state_t;

static inline heap_state_t *_heap_state(void) {
    heap_state_t *p;
    __asm__("mv %0, tp" : "=r"(p));
    return p;
}

void _libc_init_heap(void *arena_addr, long arena_size) {
    heap_state_t *h = _heap_state();
    h->base = (char *)arena_addr;
    h->brk  = (char *)arena_addr;
    h->end  = (char *)arena_addr + arena_size;
}

void *_sbrk(long n) {
    heap_state_t *h = _heap_state();
    if (h->brk == 0) return (void *)-1;
    char *prev = h->brk;
    char *next = prev + n;
    if (next < h->base || next > h->end) return (void *)-1;
    h->brk = next;
    return prev;
}

/* ---------- argv unpacking ---------- */

/* Cap on argv we hand to main; bigger requests fall off the end.
   The buffer lives on the task's stack (allocated by gcc_crt0),
   not as a libc global — keeps the gp-relative addressing surface
   small (just the heap pointers) and lets each spawn get a fresh
   argv area without a wipe step. */
#define ARGV_MAX 32

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

/* Translate the kernel's StringArray into a C-style argv[] in the
   caller-provided buffer. Returns argc. argv must hold at least
   ARGV_MAX + 1 char* slots so we can NUL-terminate. */
int _libc_unpack_argv_to(unsigned long sa_ptr, char **argv) {
    if (sa_ptr == 0) {
        argv[0] = 0;
        return 0;
    }
    unsigned long *base = (unsigned long *)sa_ptr;
    unsigned int  count = (unsigned int)base[0];
    if (count > ARGV_MAX) count = ARGV_MAX;
    for (unsigned int i = 0; i < count; i++) {
        argv[i] = _string_to_cstr(base[1 + i]);
    }
    argv[count] = 0;
    return (int)count;
}

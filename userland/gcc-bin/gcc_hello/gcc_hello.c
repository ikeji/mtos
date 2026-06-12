/*
 * gcc_hello.c — Phase 0 smoke test for the GCC task pipeline.
 *
 * Writes one line via the kernel's sys_write (a7 = 64) and exits.
 * No newlib, no printf — just confirms that:
 *   1. crt0 hands control to main correctly
 *   2. .data / .bss layout matches what the kernel expects
 *   3. ecall ABI works the same as for TC tasks
 *
 * Run as: sh$ gcc_hello
 * Expect: "hello from gcc task\n" on stdout, then return to prompt.
 */

extern long write(int fd, const void *buf, unsigned long n);
extern void _exit(int rc);

int main(int argc, char **argv) {
    (void)argc;
    (void)argv;
    static const char msg[] = "hello from gcc task\n";
    write(1, msg, sizeof(msg) - 1);
    return 0;
}

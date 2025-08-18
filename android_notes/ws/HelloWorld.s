    .text
    .global _start
_start:
    // write(1, msg, len)
    mov     x8, #64              // SYS_write on AArch64 Linux/Android
    mov     x0, #1               // fd = stdout
    adr     x1, msg              // buf
    mov     x2, #6               // len
    svc     #0

    // exit(0)
    mov     x8, #93              // SYS_exit
    mov     x0, #0
    svc     #0

    .data
msg:
    .ascii  "Hello\n"

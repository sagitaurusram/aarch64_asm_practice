.section .data
msg: .ascii "Hello ARM64!\n"
len = . - msg
.section .text
.global _start
_start:
    mov x0, #1          // stdout
    ldr x1, =msg
    mov x2, #13         // message length
    mov x8, #64         // syscall: write
    svc #0
    mov x8, #93         // syscall: exit
    mov x0, #0
    svc #0

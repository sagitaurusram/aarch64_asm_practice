/*
pseudo code
lower case to upper case
lower_msg = "super man is a Man 0123!"
for(length_of_message)
    if within ascii range
        ignore
    else
        add+capital_offset
*/
.section .data
msg: .ascii "super man is a Man.\n"
msg_len = . - msg
.section .text
.global _start
// print function
// X0 = fd (stdout=1), X1 = address, X2 = length
_print:
    mov x8, #64         // syscall: write
    svc #0
    ret
_exit:
    mov x8, #93             // syscall: exit
    mov x0, #0
    svc #0
_start:
    mov x0, #msg_len
    ldr x1, =msg
    sub x1, x1, #1
    add x0, x0, #1
_loop:
    ADD x1, x1, #1
    SUB x0, x0, #1
    cmp x0, 0
    B.EQ _print_and_exit
    LDRB w5, [x1]            //load ascii byte
    cmp w5, #'z'
    B.GT _loop             // already UPPER CASE so skip
    cmp w5, #'a'           // dont case <a
    B.LT _loop
    SUB w5, w5, #('a' - 'A') // convert to UPPER CASE
    STRB w5, [x1]             // store it back to same location
    CMP x0, #0
    B.NE _loop        
_print_and_exit:
    mov x0, #1              // fd = stdout
    ldr x1, =msg      // address of message
    mov x2, #msg_len      // length of message
    bl _print
    B _exit
    

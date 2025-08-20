// ARM AArch64 General Purpose Registers:
// X0-X30 : General purpose 64-bit registers
// W0-W30 : Lower 32 bits of X0-X30
// X0-X7  : Argument/return value registers
// X8     : Indirect result location register
// X9-X15 : Temporary registers (caller-saved)
// X16-X17: Intra-procedure-call scratch registers
// X18    : Platform register (reserved on some platforms)
// X19-X28: Callee-saved registers
// X29    : Frame pointer (FP)
// X30    : Link register (LR)
// X31    : Stack pointer (SP) or zero register (ZR) depending on context
// SP     : Stack pointer
// ZR     : Zero register (reads as zero, writes are ignored)

// Floating Point/SIMD Registers:
// V0-V31 : 128-bit SIMD/floating point registers
// S0-S31 : Lower 32 bits of V0-V31
// D0-D31 : Lower 64 bits of V0-V31
// Q0-Q31 : 128-bit vector registers (alias for V0-V31)

CASE1_MSG: .ascii "case_1 executed\n"
CASE1_LEN = . - CASE1_MSG
CASE2_MSG: .ascii "case_2 executed\n"
CASE2_LEN = . - CASE2_MSG

// print function
// X0 = fd (stdout=1), X1 = address, X2 = length
_print:
    mov x8, #64         // syscall: write
    svc #0
    ret

// select case
.equ NUMBER, 1
.equ CASE_1, 1
.equ CASE_2, 2
.global _start
_start:
    MOV X1, NUMBER
    CMP X1, CASE_1
    B.EQ _case1
    CMP X1, CASE_2
    B.EQ _case2
    B _exit

_case1:
    mov x0, #1              // fd = stdout
    ldr x1, =CASE1_MSG      // address of message
    mov x2, #CASE1_LEN      // length of message
    bl _print
    B _exit

_case2:
    mov x0, #1              // fd = stdout
    ldr x1, =CASE2_MSG      // address of message
    mov x2, #CASE2_LEN      // length of message
    bl _print
    B _exit

_exit:
    mov x8, #93             // syscall: exit
    mov x0, #0
    svc #0


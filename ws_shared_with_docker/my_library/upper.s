//
// Assembler program to convert a string to
// all upper case.
//
// X1 - address of output string
// X0 - address of input string
// X4 - original output string for length calc.
// W5 - current character being processed
//
// toupper: copy input string at X0 to output at X1, converting a–z to A–Z.
// Returns: X0 = number of bytes written (including the trailing 0).


.global toupper

toupper:
    MOV     X4, X1            // save start of output for length calc

// Loop until we store a 0 byte
loop:
    LDRB    W5, [X0], #1      // load *X0++ into W5
    CMP     W5, #'z'          // if (W5 > 'z') -> cont
    B.GT    cont
    CMP     W5, #'a'          // else if (W5 < 'a') -> cont
    B.LT    cont
    SUB     W5, W5, #('a' - 'A') // convert lower->upper

cont:
    STRB    W5, [X1], #1      // *X1++ = W5
    CMP     W5, #0            // stop at NUL
    B.NE    loop

    SUB     X0, X1, X4        // length = end_out - start_out
    RET                        // return

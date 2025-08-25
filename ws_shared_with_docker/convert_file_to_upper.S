/*
pseudo code for converting contents of a file to all UPPER case_1
ex: say in_file is a ptr to input file; out_file for output
    in_file containts 1000 bytes
    METHOD_1:
        read each byte from input file and write to output file
        analysis:
            for linux file write the API is 
                X0 file ptr
                X1 buffer
                X2 len
                X8 WRITE_COMMAND
                svc
        given the api; its inefficient to call linux service for each byte
    METHOD_2:
        read all bytes one shot to a buffer; pass buffer to linux serv call
        analysis:
            if the file is 1GB you need 2 memories of such capacity to hold
            1GB input buffer and 1GB output buffer
    METHOD_3:
        trade off between number of linux calls versus memory Usage
        It would be nice to even profile this and plot a 2-d graph

    we proceed with METHOD_3 and use a buffer size of 256 bytes

    CHOSEN_METHOD:
        infile_desc = open_file("file_path")
        buffer_255  = read(infile_desc, i*0_to_i*255_bytes)
        buffer_255  = convert_lower_to_upper(buffer_255)
        outfile_desc= open_file("out_file_path")
                      write(outfile_desc, buffer_255)
        close_file
*/
//
// Assembler program to convert a string to
// all upper case by calling a function.
//
// X0-X2, X8 - used by macros to call linux
// X11 - input file descriptor
// X9 - output file descriptor
// X10 - number of characters read
//
#include <asm/unistd.h>
#include "fileio.S"
.equ BUFFERLEN, 250
.global _start

_start:
    openFile inFile, O_RDONLY
    ADDS    X11, XZR, X0
    B.PL    nxtfil
    MOV     X1, #1
    LDR     X2, =inpErrsz
    LDR     W2, [X2]
    writeFile X1, inpErr, X2
    B       exit

nxtfil:
    openFile outFile, O_CREAT|O_WRONLY
    ADDS    X9, XZR, X0
    B.PL    loop
    MOV     X1, #1
    LDR     X2, =outErrsz
    LDR     W2, [X2]
    writeFile X1, outErr, X2
    B       exit

loop:
    readFile X11, buffer, BUFFERLEN
    MOV     X10, X0
    MOV     X1, #0
    LDR     X0, =buffer
    STRB    W1, [X0, X10]
    LDR     X1, =outBuf
    BL      toupper
    writeFile X9, outBuf, X10
    CMP     X10, #BUFFERLEN
    B.EQ    loop
    flushClose X11
    flushClose X9

exit:
    MOV     X0, #0
    MOV     X8, #__NR_exit
    SVC     0

.data
inFile:     .asciz "lowercase_text.txt"
outFile:    .asciz "upper.txt"
buffer:     .fill  BUFFERLEN + 1, 1, 0
outBuf:     .fill  BUFFERLEN + 1, 1, 0
inpErr:     .asciz "Failed to open input file.\n"
inpErrsz:   .word  .-inpErr
outErr:     .asciz "Failed to open output file.\n"
outErrsz:   .word  .-outErr

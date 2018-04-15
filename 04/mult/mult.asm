// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

@R2
M=0 // product starts at 0

@R0
D=M
@STEP
D;JGT // start multiplaction loop iff R0>0

@END
0;JMP

(STEP)
	@R2 // load R2 for the working value
	D=M // store R2 as the memory value

	@R1 // load R1 for the working value
	D=D+M // add R1 to R2
	
	@R2 // load R2 for the working value
	M=D // overwrite R2 with its new value

	@R0 // load up R0 (to be used as a counter)
	D=M-1 // decrement R0
	M=D

	@STEP // run the loop again iff R0>1
	D;JGT

(END) // infinite loop to end program
	@END
	0,JMP
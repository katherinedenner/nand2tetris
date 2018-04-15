// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// check the keyboard value
(LOOP) // loop to check whether a key is pressed (whether KBD > 0)
	@KBD
	D=M

	@ON
	D;JGT // jump to the loop for pressed key if KBD > 0

	@OFF 
	0;JMP // else jump to the loop for no pressed key

// screen is on -> black-out
(ON)
	@R0		// R0 stores the color
	M=-1	// set the color to black

	@FILL
	0;JMP

// screen is off -> white-out
(OFF)
	@R0		// R0 stores the color
	M=0		// set the color to white

	@FILL
	0;JMP

// black-out or white-out the screen, one pixel per iteration
(FILL)
	// set the counter to track the number of remaining pixels
	@8191
	D=A
	@R1
	M=D    // store the counter in R1

	// iteravely color each pixel
	(PIXEL)
		// select pixel
		@R1
		D=M // call up place in counter
		@pos
		M=D // counter -> position
		@SCREEN
		D=A
		@pos
		M=M+D

		// color pixel
		@R0
		D=M // call up current color
		@pos
		A=M
		M=D

		// decrement the counter
		@R1
		D=M-1
		M=D

		// check whether to loop again
		@PIXEL
		D;JGE // continue process iff counter R1 >=0

@LOOP
0;JMP
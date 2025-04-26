BINARY TO NUMBER (4 BITS; ASCII)
Brainfuck program that reads in 4 bits of input and outputs ASCII number
Also attempt at a readable structure for use with brainfuck
https://sange.fi/esoteric/brainfuck/impl/interp/i.html
TODO: convert values over 9 into ASCII representation

Created 26 April 2025
- Jimmy Ho

Format
	(current ptr indx) (command)
	(0_3) Input bits
	(4_9) Leave empty (in case input typo; more than 4 bits but less than 10)
	(10_13) Store binary exponent ie 2 ^ X where X corresponds to binary position
	(14) Output
Note: 
	BRAINFUCK INPUTS ARE TAKEN AS CHAR (DECIMAL VALS)
	ASCII decimal to number
	48 (0) | 53 (5)
	49 (1) | 54 (6)
	50 (2) | 55 (7)
	51 (3) | 56 (8)
	52 (4) | 57 (9)	
	Binary (4 bits) to number
	0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100 1101 1110 1111
	(0)  (1)  (2)  (3)  (4)  (5)  (6)  (7)  (8)  (9)  (10) (11) (12) (13) (14) (15)

// main code
//Reading input; expecting 0 or 1 char inputs
0 ,------------------------------------------------ //convert char to int val
1 >,------------------------------------------------ //convert char to int val
2 >,------------------------------------------------ //convert char to int val
3 >,------------------------------------------------ //convert char to int val
//Binary exponents
10 >>>>>>>     //0
11 >++         //2^1 = 2
12 >++++       //2^2 = 4
13 >++++++++   //2^3 = 8 
//Generate output
14 >
	//iterate input binary positions; read left to right
	if 0 <<<<<<<<<<<<<< [
		14 >>>>>>>>>>>>>>
		for 13 <[ //left most exponential
			14 >+
			13 <- //decrement FOR
			]
			14 >
			0 <<<<<<<<<<<<<<- //decrement IF
		] 
	14 >>>>>>>>>>>>>>

	if 1 <<<<<<<<<<<<< [
		14 >>>>>>>>>>>>>
		for 12 <<[
			14 >>+
			12 <<- //decrement FOR
			]
			14 >>
			1 <<<<<<<<<<<<<- //decrement IF
		] 
	14 >>>>>>>>>>>>>  
	
	if 2 <<<<<<<<<<<< [
		14 >>>>>>>>>>>>
		for 11 <<<[
			14 >>>+
			11 <<<- //decrement FOR
			] 
			14 >>>
			2 <<<<<<<<<<<<- //decrement IF
		] 
	14 >>>>>>>>>>>>  
	
	if 3 <<<<<<<<<<< [ //right most exponential
		14 >>>>>>>>>>>+ //add 1 to output
		3 <<<<<<<<<<<- //decrement IF
		]
	14 >>>>>>>>>>> 
 	
//Read output
14 ++++++++++++++++++++++++++++++++++++++++++++++++.
	
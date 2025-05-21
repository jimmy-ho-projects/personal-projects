BINARY TO NUMBER (4 BITS; ASCII)
Brainfuck program that reads in 4 bits of input and outputs ASCII number
Also attempt at a readable structure for use with brainfuck
https://sange.fi/esoteric/brainfuck/impl/interp/i.html
TODO: convert values over 9 into ASCII representation
NOTE: ptr can store range neg127 to pos127 oh no

Created 25_26 April 2025
Finished 27 April 2025 (original 4 bit vers)
TODO complete 8 bit expansion
_ Jimmy Ho

Format
	(current ptr indx) (command)
	(32767) store int sum (index loop around)
	__________________________________________
	(0_7) Input bits
	(8_9) Leave empty (in case input typo; more than 4 bits but less than 10)
	(10_17) Store binary exponent ie 2 ^ X where X corresponds to binary position
	(15) 0 empty stop point
    	(16) store 10 (for limiting incrementing 10 times)
	(17_26) 10 bits for counting
	(27) ENABLE thing for techniclity
	(28) store TENS value multiplier
    	(29) ONES
	(30_33) ADDENDUM: Store binary exponent ie 2 ^ X where X corresponds to binary position

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

// MAIN CODE
//Reading input; expecting 0 or 1 char inputs
0 ,------------------------------------------------ //convert char to int val
1 >,------------------------------------------------ //convert char to int val
2 >,------------------------------------------------ //convert char to int val
3 >,------------------------------------------------ //convert char to int val
//ADDENDUM: 8 bit expansion
4 >,------------------------------------------------
5 >,------------------------------------------------
6 >,------------------------------------------------
7 >,------------------------------------------------

//Binary exponents
10 >>>         //0
11 >++         //2^1 = 2
12 >++++       //2^2 = 4
13 >++++++++   //2^3 = 8
// ADDENDUM: 8 bit expansion
14 >++++++++++++++++ //2^4 = 16
15 >++++++++++++++++++++++++++++++++ //2^5 = 32
16 >++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //2^6 = 64
17 >++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //2^7 = 128
0 <<<<<<<<<<<<<<<<< //reset position

//Binary to Int; store at 32767
32767 <
	//iterate input binary positions; read left to right
	if 0 > [
		32767 < //positioning ptr
		for 17 >>>>>>>>>>>>>>>>>>[ //left most exponential
			32767 <<<<<<<<<<<<<<<<<<+
			17 >>>>>>>>>>>>>>>>>>- //decrement FOR
			]
			32767 <<<<<<<<<<<<<<<<<< //reposition
			0 >- //decrement IF
		] 
	32767 < //reposition

	if 1 >> [
		32767 << //positioning ptr
		for 16 >>>>>>>>>>>>>>>>>[ //left most exponential
			32767 <<<<<<<<<<<<<<<<<+
			16 >>>>>>>>>>>>>>>>>- //decrement FOR
			]
			32767 <<<<<<<<<<<<<<<<< //reposition
			1 >>- //decrement IF
		] 
	32767 << //reposition
	
	if 2 >>> [
		32767 <<<
		for 15 >>>>>>>>>>>>>>>>[
			32767 <<<<<<<<<<<<<<<<+
			15 >>>>>>>>>>>>>>>>- //decrement FOR
			] 
			32767 <<<<<<<<<<<<<<<<
			2 >>>- //decrement IF
		] 
	32767 <<< //reposition 
	
	if 3 >>>> [
		32767 <<<<
		for 14 >>>>>>>>>>>>>>>[
			32767 <<<<<<<<<<<<<<<+
			14 >>>>>>>>>>>>>>>- //decrement FOR
			] 
			32767 <<<<<<<<<<<<<<<
			3 >>>>- //decrement IF
		] 
	32767 <<<< //reposition 

	if 4 >>>>> [
		32767 <<<<<
		for 13 >>>>>>>>>>>>>>[
			32767 <<<<<<<<<<<<<<+
			13 >>>>>>>>>>>>>>- //decrement FOR
			] 
			32767 <<<<<<<<<<<<<<
			4 >>>>>- //decrement IF
		] 
	32767 <<<<< //reposition 

	if 5 >>>>>> [
		32767 <<<<<<
		for 12 >>>>>>>>>>>>>[
			32767 <<<<<<<<<<<<<+
			12 >>>>>>>>>>>>>- //decrement FOR
			] 
			32767 <<<<<<<<<<<<<
			5 >>>>>>- //decrement IF
		] 
	32767 <<<<<< //reposition 

	if 6 >>>>>>> [
		32767 <<<<<<<
		for 11 >>>>>>>>>>>>[
			32767 <<<<<<<<<<<<+
			11 >>>>>>>>>>>>- //decrement FOR
			] 
			32767 <<<<<<<<<<<<
			6 >>>>>>>- //decrement IF
		] 
	32767 <<<<<<< //reposition 

	//10 is 0, directly add ONES to int sum counter
	for 7 >>>>>>>> [
		32767 <<<<<<<<+
		7 >>>>>>>>- //decrement FOR
		] 
	32767 <<<<<<<< # //website debugging char DEBUG POINT (original 4 bit end pt)

======================================================================================================works
	
//Looping for total sum; increment 10 bit (15_24); each +1 left to right; restart from left when end
15 >           //0 empty stop point for ptr travel
16 >++++++++++ //init 16 with 10
27 >>>>>>>>>>>+ //init 27 w 1

for 14 <<<<<<<<<<<<<-[ //dirty fix: off by one error
	14 -
	//fill 10 bits with ones
	if 16 >>[
		16 - //decrement 
		17 > //start here 
		17_26 [>]+ //if current ptr not empty; fill adjacent cell
		15 [<]     //travel back to stop point EXCEPT if 16 empty it stops at 16
	]
     //IF 16 EMPTY; STOPS at 16 so PTR ONE OFF
	IF 27 WHEN ABOVE ELSE PTR 26 >>>>>>>>>>>[ //DEBUG POINT
		28 >+ //increment TENS counter
		26 <<-
		25 <-
		24 <-
		23 <-
		22 <-
		21 <-
		20 <-
		19 <-
		18 <-
		17 <-
		16 <++++++++++
		26 >>>>>>>>>> 
	]
	14 <<<<<<<<<<<< //DEBUG POINT
] 

# //DEBUG POINT

//loop ends when 14 int sum is 0; remainders will still be stored in 10 bits but not wiped in IF 26
//add up all 10 bits values for ONES place value

if 17 >>>[- 29>>>>>>>>>>>>+<<<<<<<<<<<<]
if 18 >[- 29>>>>>>>>>>>+<<<<<<<<<<<]
if 19 >[- 29>>>>>>>>>>+<<<<<<<<<<]
if 20 >[- 29>>>>>>>>>+<<<<<<<<<]
if 21 >[- 29>>>>>>>>+<<<<<<<<]
if 22 >[- 29>>>>>>>+<<<<<<<]
if 23 >[- 29>>>>>>+<<<<<<]
if 24 >[- 29>>>>>+<<<<<]
if 25 >[- 29>>>>+<<<<]
//implied 26 is empty

//Print Results (adding 48 to align with ASCII code)
28 >>>++++++++++++++++++++++++++++++++++++++++++++++++. //PRINT TENS PLACE
29 >++++++++++++++++++++++++++++++++++++++++++++++++. //PRINT ONES PLACE
	
	(0_3) Input bits
	(32767_32764) input bits ADDENDUM; expand for 8 bits; ptr location loop back
	(4_9) Leave empty (in case input typo; more than 4 bits but less than 10)
	(10_13) Store binary exponent ie 2 ^ X where X corresponds to binary position
	(14) store int sum
	(15) 0 empty stop point
    (16) store 10 (for limiting incrementing 10 times)
	(17_26) 10 bits for counting
	(27) ENABLE thing for techniclity
	(28) store TENS value multiplier
    (29) ONES
	(30-33) ADDENDUM: Store binary exponent ie 2 ^ X where X corresponds to binary position

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
//ADDENDUM: 8 bit expansion
32767 <<<<,------------------------------------------------
32766 <,------------------------------------------------
32765 <,------------------------------------------------
32764 <,------------------------------------------------
0>>>>

//Binary exponents
10 >>>>>>>     //0
11 >++         //2^1 = 2
12 >++++       //2^2 = 4
13 >++++++++   //2^3 = 8
// ADDENDUM: 8 bit expansion
30>>>>>>>>>>>>>>>>>++++++++++++++++ //2^4 = 16
31>++++++++++++++++++++++++++++++++ //2^5 = 32
32>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //2^6 = 64
33>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //2^7 = 128
13<<<<<<<<<<<<<<<<<<<< //return

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
	14 >>>>>>>>>>> # //website debugging char DEBUG POINT (original 4 bit end pt)

	if 32767 <<<<<<<<<<<<<<< [ //going to 8 bit expansion addendum location
			14 >>>>>>>>>>>>>>>+ //add 1 to output
			32767 <<<<<<<<<<<<<<<- //decrement IF
			]
		14 >>>>>>>>>>>>>>>

	if 32766 <<<<<<<<<<<<<<<< [ //going to 8 bit expansion addendum location
			14 >>>>>>>>>>>>>>>>+ //add 1 to output
			32766 <<<<<<<<<<<<<<<<- //decrement IF
			]
		14 >>>>>>>>>>>>>>>>
	
	if 32765 <<<<<<<<<<<<<<<<< [ //going to 8 bit expansion addendum location
			14 >>>>>>>>>>>>>>>>>+ //add 1 to output
			32765 <<<<<<<<<<<<<<<<<- //decrement IF
			]
		14 >>>>>>>>>>>>>>>>>

	if 32764 <<<<<<<<<<<<<<<<<< [ //going to 8 bit expansion addendum location
			14 >>>>>>>>>>>>>>>>>>+ //add 1 to output
			32764 <<<<<<<<<<<<<<<<<<- //decrement IF
			]
		14 >>>>>>>>>>>>>>>>>> # //DEBUG POINT (8 bit)
 
======================================================================================================works
	
//Looping for total sum; increment 10 bit (15_24); each +1 left to right; restart from left when end
15 >           //0 empty stop point for ptr travel
16 >++++++++++ //init 16 with 10
27 >>>>>>>>>>>+ //init 27 w 1

for 14 <<<<<<<<<<<<<-[ //dirty fix: off by one error
	14 -
	//fill 10 bits with ones
	if 16 >>[
		16 - //decrement 
		17 > //start here 
		17_26 [>]+ //if current ptr not empty; fill adjacent cell
		15 [<]     //travel back to stop point EXCEPT if 16 empty it stops at 16
	]
     //IF 16 EMPTY; STOPS at 16 so PTR ONE OFF
	IF 27 WHEN ABOVE ELSE PTR 26 >>>>>>>>>>>[ //DEBUG POINT
		28 >+ //increment TENS counter
		26 <<-
		25 <-
		24 <-
		23 <-
		22 <-
		21 <-
		20 <-
		19 <-
		18 <-
		17 <-
		16 <++++++++++
		26 >>>>>>>>>> 
	]
	14 <<<<<<<<<<<< //DEBUG POINT
] 

# //DEBUG POINT

//loop ends when 14 int sum is 0; remainders will still be stored in 10 bits but not wiped in IF 26
//add up all 10 bits values for ONES place value

if 17 >>>[- 29>>>>>>>>>>>>+<<<<<<<<<<<<]
if 18 >[- 29>>>>>>>>>>>+<<<<<<<<<<<]
if 19 >[- 29>>>>>>>>>>+<<<<<<<<<<]
if 20 >[- 29>>>>>>>>>+<<<<<<<<<]
if 21 >[- 29>>>>>>>>+<<<<<<<<]
if 22 >[- 29>>>>>>>+<<<<<<<]
if 23 >[- 29>>>>>>+<<<<<<]
if 24 >[- 29>>>>>+<<<<<]
if 25 >[- 29>>>>+<<<<]
//implied 26 is empty

//Print Results (adding 48 to align with ASCII code)
28 >>>++++++++++++++++++++++++++++++++++++++++++++++++. //PRINT TENS PLACE
29 >++++++++++++++++++++++++++++++++++++++++++++++++. //PRINT ONES PLACE
	
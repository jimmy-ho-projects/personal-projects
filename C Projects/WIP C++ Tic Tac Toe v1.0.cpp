@echo off 
/*
TIC TAC TOE v1.0
Tic tac toe implementation in C++! Runs in 
terminal. Original was a BATCH file that
no one can run so that's useless...
Players always goes first
Created 4/?/25
-Jimmy Ho
*/

#include <iostream>

int main(){ 
	int numMoves = 0;
	//Variable for player input
	int A = 1; int B = 2; int C = 3;
	int D = 4; int E = 5; int F = 6;
	int G = 7; int H = 8; int I = 9;
	//array to map CPU choice # to letter
	char list[9]={'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'};

	bool loopVar = true;

	// ===MAIN LOOP===
	while(loopVar){
		// ==== Print Board ====
		printf("Turn: %i\n", numMoves);
		printf("[ %i ][ %i ][ %i ]\n", A, B, C);
		std::cout << "===============" <<'\n';
		printf("[ %i ][ %i ][ %i ]\n", D, E, F);
		std::cout << "===============" <<'\n';
		printf("[ %i ][ %i ][ %i ]\n", G, H, I);
		std::cout<<'\n';

		// ==== Turns Made ====
		//PLAYER_INPUT
		choice /c 123456789 /m "Player Turn ( X )  "
		std::cout<<"Player Turn ( X ): "
		int pChoice = 0; //default 0
		std::cin>>pChoice; //invald inputs are 0


		//TODO: MAKE SEPARATE TIC TAC TOE BOARD to store MOVES MADE
			 if (pChoice == 1 && A == 1){} (
				if %A%== 1 (set A=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			  if pChoice == 2 (
				if %B%== 2 (set B=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 3 (
				if %C%== 3 (set C=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 4 (
				if %D%== 4 (set D=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 5 (
				if %E%== 5 (set E=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 6 (
				if %F%== 6 (set F=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 7 (
				if %G%== 7 (set G=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 8 (
				if %H%== 8 (set H=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
			 if pChoice == 9 (
				if %I%== 9 (set I=X) else (
					cls
					echo * Invalid move, buster! *
					goto :MAINLOOP
					)
				)
		goto :return_point_1

		goto :CPU_TURN
		:return_point_2

		if numMoves >= 2 (
			goto :CHECK_WIN_COND)
		:return_point_3

		numMoves = numMoves + 1
	}
}

REM ********** FUNCTIONS **********


:CPU_TURN
	REM https://ss64.com/nt/syntax-random.html
	set /a max = 10
	set /a min = 0
	REM [min, max), # round down, allow 1 and 9 to be chosen
	REM initial RANDOM bc first value almost constantly same
	set /a random_num = %RANDOM%
	set /a random_num = (%RANDOM%*(max-min+1)/32768)+min
	REM if TRUE, imply value not set; FALSE if space already chosen
	if %random_num% == %A% (set A=O
		goto :return_point_2)
	if %random_num% == %B% (set B=O
		goto :return_point_2)
	if %random_num% == %C% (set C=O
		goto :return_point_2)
	if %random_num% == %D% (set D=O
		goto :return_point_2)
	if %random_num% == %E% (set E=O
		goto :return_point_2)
	if %random_num% == %F% (set F=O
		goto :return_point_2)
	if %random_num% == %G% (set G=O
		goto :return_point_2)
	if %random_num% == %H% (set H=O
		goto :return_point_2)
	if %random_num% == %I% (set I=O
		goto :return_point_2)
	goto :CPU_TURN

:CHECK_WIN_COND
	set checkr=X
	if %B% == %checkr% (
		if %A% == %checkr% (
			if %C% == %checkr% (goto :X_WIN)
		)
	)
	if %D% == %checkr% (
		if %A% == %checkr% (
			if %G% == %checkr% (goto :X_WIN)
		)
	)
	if %F% == %checkr% (
		if %C% == %checkr% (
			if %I% == %checkr% (goto :X_WIN)
		)
	)
	if %H% == %checkr% (
		if %G% == %checkr% (
			if %I% == %checkr% (goto :X_WIN)
		)
	)
	if %E% == %checkr% (
		if %D% == %checkr% (if %F% == %checkr% (goto :X_WIN))
		if %B% == %checkr% (if %H% == %checkr% (goto :X_WIN))
		if %A% == %checkr% (if %I% == %checkr% (goto :X_WIN))
		if %G% == %checkr% (if %C% == %checkr% (goto :X_WIN))
	)
	set checkr=O
	if %B% == %checkr% (
		if %A% == %checkr% (
			if %C% == %checkr% (goto :O_WIN)
		)
	)
	if %D% == %checkr% (
		if %A% == %checkr% (
			if %G% == %checkr% (goto :O_WIN)
		)
	)
	if %F% == %checkr% (
		if %C% == %checkr% (
			if %I% == %checkr% (goto :O_WIN)
		)
	)
	if %H% == %checkr% (
		if %G% == %checkr% (
			if %I% == %checkr% (goto :O_WIN)
		)
	)
	if %E% == %checkr% (
		if %D% == %checkr% (if %F% == %checkr% (goto :O_WIN))
		if %B% == %checkr% (if %H% == %checkr% (goto :O_WIN))
		if %A% == %checkr% (if %I% == %checkr% (goto :O_WIN))
		if %G% == %checkr% (if %C% == %checkr% (goto :O_WIN))
	)
	goto :return_point_3
	
:X_WIN
	cls
	echo Turn: %numMoves%
	echo [ %A% ][ %B% ][ %C% ]
	echo ===============
	echo [ %D% ][ %E% ][ %F% ]
	echo ===============
	echo [ %G% ][ %H% ][ %I% ]
	echo ==================
	echo PLAYER (X) WINS!!!
	echo ==================
	echo:
	echo Thanks for Playing!
	pause
	goto :EOF

:O_WIN
	cls
	echo Turn: %numMoves%
	echo [ %A% ][ %B% ][ %C% ]
	echo ===============
	echo [ %D% ][ %E% ][ %F% ]
	echo ===============
	echo [ %G% ][ %H% ][ %I% ]
	echo ==================
	echo CPU (O) WINS!!!
	echo ==================
	echo:
	echo Thanks for Playing!
	pause
	goto :EOF
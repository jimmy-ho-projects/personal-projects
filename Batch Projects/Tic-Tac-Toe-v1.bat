@echo off 

REM TIC TAC TOE v1.0
REM Tic tac toe implementation in BATCH! Runs in 
REM terminal. Quite proud of it so far :3 
REM Players always goes first
REM Created 4/1/25
REM -Jimmy Ho

set /a numMoves = 0
REM Variable for player input
set /a A = 1
set /a B = 2
set /a C = 3
set /a D = 4
set /a E = 5
set /a F = 6
set /a G = 7
set /a H = 8
set /a I = 9
REM array to map CPU choice # to letter
set list[0]=A
set list[1]=B
set list[2]=C
set list[3]=D
set list[4]=E
set list[5]=F
set list[6]=G
set list[7]=H
set list[8]=I


:MAINLOOP
REM ==== Print Board ====
echo Turn: %numMoves%
echo [ %A% ][ %B% ][ %C% ]
echo ===============
echo [ %D% ][ %E% ][ %F% ]
echo ===============
echo [ %G% ][ %H% ][ %I% ]
echo:
REM ==== Turns Made ====
goto :PLAYER_INPUT
:return_point_1
goto :CPU_TURN
:return_point_2
if %numMoves% GEQ 2 (
	goto :CHECK_WIN_COND)
:return_point_3
set /a numMoves = %numMoves% + 1
cls
goto :MAINLOOP


REM ********** FUNCTIONS **********
:PLAYER_INPUT
	choice /c 123456789 /m "Player Turn ( X )  "
 		if %errorlevel%== 1 (
			if %A%== 1 (set A=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		 if %errorlevel%== 2 (
			if %B%== 2 (set B=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 3 (
			if %C%== 3 (set C=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 4 (
			if %D%== 4 (set D=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 5 (
			if %E%== 5 (set E=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 6 (
			if %F%== 6 (set F=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 7 (
			if %G%== 7 (set G=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 8 (
			if %H%== 8 (set H=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
 		if %errorlevel%== 9 (
			if %I%== 9 (set I=X) else (
				cls
				echo * Invalid move, buster! *
				goto :MAINLOOP
				)
			)
	goto :return_point_1

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
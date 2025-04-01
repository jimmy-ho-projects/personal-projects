@echo off
color 1f
title ARVDEL
REM have to use "^" before a special character to allow the program to print it without using it as an operation
REM !DONT FORGET TO PUT "IF NOT DEFINED" (SEE :title) FOR USER INPUTS OTHERWISE PRESSING ENTER WILL JUST PROCEED TO NEXT LABEL/CRASH/SCREW YOU UP!
REM use CHOICE command for choices: choice /c (list of single-keyinputs, nospaces) /n (optional, NOT display choice keys at end of input string) /cs (make choice keys case-sensitive) /t (timeout) /d (default choice if timer runs out) /m "text" (msg string describe choices)
	REM CHOICE will actually set the error level to some number, offset by 1 (starts from 1 and goes down)
	REM so a choice list of abcd, %errorlevel%= 1 corresponds with choice a
REM use amperstand "&" for multiple commands in simultaneous execution (in order)

:title
cls
echo  ^> ~ WELCOME TO ARVDEL! ~ ^<
echo ============================
echo   ^|^|^|^|^|   p) Play!   ^|^|^|^|^|
echo   ^|^|^|^|^|   e) Exit    ^|^|^|^|^|
echo ============================
echo   ~ ~` ~ ~ ~` ~ ~` ~ ~ ~` ~ ~` ~ 
echo    ~`  ~ ` ~  ~  ~ ` ~ ~`  ~ `~ ` ~ 
echo      ~   ~` `  ~  ` ~   ~    ~  `   ~ ` 
echo:
choice /c pe /n /m ">"
	if %errorlevel%== 1 goto race
	if %errorlevel%== 2 exit
	
:race
cls
echo      ^>RACE^<
echo Choose your race:
echo *****************
	echo A) Dwarf
	echo B) Elf
	echo C) Retard
echo:
	echo D) Return to Title
echo:
choice /c abcd /n /m ">"
	if %errorlevel%== 1 goto Dwarf
	if %errorlevel%== 2 goto Elf
	if %errorlevel%== 3 goto Retard
	if %errorlevel%== 4 goto title

:Dwarf
cls
echo ^>THE DWARF^<
echo A sturdy, stout fighter! Their burly muscles
echo strike fear into the nearest foe, but their
echo short stature keeps them from the highest
echo shelf! There is little they fear except
echo great heights!
echo ============================================
echo Health: 10
echo Strength: 5
echo:
echo Do you wish to be a dwarf?
echo ***************************
choice
	if %errorlevel%== 1 set race=Dwarf& set health=10& set strength=10& goto racerepeat
	if %errorlevel%== 2 goto race

:Elf
cls
echo ^>ELF^<
echo A swift, cunning acrobat! The nimblest of the
echo three, able to scale cliffs and climbs trees!
echo Yeah, the elves sure love their trees but you're
echo not gonna see any of them...
echo (Currently very weak, plan to implement DODGE stat)
echo ===================================================
echo Health: 10
echo Strength: 3
echo:
echo Do you wish to be an elf?
echo **************************
choice
	if %errorlevel%== 1 set race=Elf& set health=10& set strength=3& call PLAYERSTATS & goto racerepeat
	if %errorlevel%== 2 goto race

:Retard
cls
color 1c
echo ^>L' RETARD^<
echo ...
echo ==========================
echo Health: ...
echo Strength: ...
echo:
echo ...?
echo *****************
choice
	if %errorlevel%== 1 set race=RETARD& set health=69& set strength=420& goto racerepeat
	if %errorlevel%== 2 color 1f & goto race

:racerepeat
cls
echo:
echo You have chosen to be the %race%!
echo Health: %health%
echo Str: %strength%
echo:
echo Are you sure?
echo *************
choice
	if %errorlevel%== 1 goto gamestart
	if %errorlevel%== 2 goto race
pause
goto :character

:gamestart
cls
echo -------------
call PLAYERSTATS
	echo Race
echo -------------
pause
exit 

:PLAYERSTATS
set race= %race%
set /a health= %health%
set /a strength%= %strength%
gotoeof
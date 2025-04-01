@echo off
color a
title RPG

::Note if set var=(value), dont need space after equal sign
::Idea-using CTRL+F to find subroutines quickly ex: CTRL+F ":main"
::will need to include (commented) list of all subroutines near top of list
	::idea-have specific routine just to "draw the screen" (name/stats)
	::instead of copy/pasting same sequence of ECHO commands every routine

:character
cls
echo Select your character
echo '''''''''''''''''''''
choice /c RT /M "R-Rouge T-Tank"
	if %ERRORLEVEL%== 1 goto rouge
	if %ERRORLEVEL%== 2 goto tank

:rouge
echo.
echo ------
echo Rouge
echo ------
echo.
echo HP: 5
echo Str: 3
echo.
choice /m "Do you wish to be a rouge?"
	if %ERRORLEVEL%== 2 goto character
	if %ERRORLEVEL%== 1 set charclass=Rouge
		set charhp=5
		set charstr=3
		goto :name
			::if %var%== value (command)
			::next set of commands BAT proceeds to
			::bc BAT linear, must declare ALL choices BEFORE
			::using this method ie errorlevels must be declared
			::BEFORE any commands not on the same line otherwise
			::BAT does not ackowledge it (kinda)
	

:tank
echo.
echo ------
echo Tank
echo ------
echo.
echo HP: 10
echo Str: 6
echo.
choice /m "Do you wish to be a Tank?"
	if %ERRORLEVEL%== 2 goto character
	if %ERRORLEVEL%== 1 set charclass=Tank
		set charhp=10
		set charstr=6
		goto name
	

:name
cls
echo %charclass% [HP:%charhp% STR:%charstr%]
echo.
set /p charname= "Mighty %charclass%, what is your name? > "
echo.
choice /M "Will your name be %charname%?"
	if %ERRORLEVEL%== 1 goto main
	if %ERRORLEVEL%== 2 goto name

:main
cls
echo %charname%, the %charclass% [HP:%charhp% STR:%charstr%]
call stats.bat
pause
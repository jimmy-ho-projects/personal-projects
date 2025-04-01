@echo off
color a
title RPG WIP

:name
set /p name= "Enter name: " 
echo.
echo Will your name be %name%?
echo.
choice
	if %ERRORLEVEL%== 1 goto nameconfirm
	if %ERRORLEVEL%== 2 goto namedeny

:nameconfirm
cls
echo Your name is %name%
pause

:namedeny
cls
goto name
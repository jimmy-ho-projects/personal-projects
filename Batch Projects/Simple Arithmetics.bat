@echo off
color a
title Arithmetic Excercise w/ Variables
REM batch programming cannot utilize decimal numbers/non-integers

:title
cls
echo  ========================
echo     SIMPLE ARITHMETICS
echo //*=*=*=*=*=*=*=*=*=*=*=\\
echo:
echo   * INTEGER CALC ONLY *
echo:
choice /c abc /n /m "[A]Calculate [B]Demo [C]Exit >"
	if %errorlevel%== 1 goto Calc
	if %errorlevel%== 2 goto demo
	if %errorlevel%== 3 exit

:demo
echo:
echo ================
echo ''''"[DEMO]"''''
set /a var1= 5
set /a var2= 2
	set /a jor= %var1% + %var2%
	set /a xim= %var1% - %var2%
	set /a yeet= %var1% * %var2%
	set /a vel= %var1% / %var2%
echo ===============
echo:
echo 5 + 2 = %jor%
echo:
echo 5 - 2 = %xim%
echo:
echo 5 * 2 = %yeet%
echo:
echo 5 / 2 = %vel%
echo:
echo ===============
echo ***************
pause
goto title

:Calc
cls
echo ===========
echo CALCULATOR
echo ===========
echo:
echo A) Addition
echo B) Subtraction
echo C) Multiplication
echo D) Division
echo:
echo E) Exit
choice /c abcde /n /m ">"
	if %errorlevel%== 1 goto add
	if %errorlevel%== 2 goto sub
	if %errorlevel%== 3 goto mult
	if %errorlevel%== 4 goto div
	if %errorlevel%== 5 exit

:add
cls
echo Addition
set /p num1= "First #: "
set /a num1 = num1
echo [First value saved as %num1%]
set /p num2= "Second #: "
set /a num2 = num2
echo [Second value saved as %num2%]
set /a num3 = num1 + num2
echo  %num1% + %num2% = %num3%
pause
goto Calc

:sub
cls
echo Subtraction
set /p num1= "First #: "
set /a num1 = num1
echo [First value saved as %num1%]
set /p num2= "Second #: "
set /a num2 = num2
echo [Second value saved as %num2%]
set /a num3 = num1 - num2
echo  %num1% - %num2% = %num3%
pause
goto Calc

:mult
cls
echo Multiplication
set /p num1= "First #: "
set /a num1 = num1
echo [First value saved as %num1%]
set /p num2= "Second #: "
set /a num2 = num2
echo [Second value saved as %num2%]
set /a num3 = num1 * num2
echo  %num1% * %num2% = %num3%
pause
goto Calc

:div
cls
echo Division
set /p num1= "First #: "
set /a num1 = num1
echo [First value saved as %num1%]
set /p num2= "Second #: "
set /a num2 = num2
echo [Second value saved as %num2%]
REM have division display remainder after whole div NOTE: USE COMPARE BATCH OP
set /a num3 = num1 / num2
if %num1% LSS %num2% set /a remainder = num2 - (num1 * num3)

if %num1% GTR %num2% set /a remainder = num1 - (num2 * num3)

if %num1% EQU %num2%set /a remainder = 0

echo  %num1% / %num2% = %num3% remainder %remainder%
pause
goto Calc


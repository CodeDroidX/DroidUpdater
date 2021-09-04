@Echo on
cd %~dp0

set ver=1.0.0
set name=DroidUpdate

title %name% - %ver%
set args=%*
if "%args%"=="" goto arg
if "%~dp0"=="%temp%\DroidUpdate\" goto :s


xcopy %~dp0 %temp%\DroidUpdate /H /Y /C /R /S /I
start %temp%\DroidUpdate\Update.cmd %*
exit



:s
cls
color E
echo Starting Update %~1
set reponame=%~1
set repopath=%~2
set arch=%~3
rmdir /s /q %repopath%\UpdateTemp
md %repopath%\UpdateTemp
gh repo clone %reponame% %repopath%\UpdateTemp
if "%arch%"=="enable-arch" goto enarch
:back1
xcopy %repopath%\UpdateTemp %repopath% /H /Y /C /R /S /I
if exist "%repopath%\UpdateScript.bat" start %repopath%\UpdateScript.bat
rmdir /s /q %repopath%\UpdateTemp
echo.
echo Work completed
timeout /t 15 >> nul
exit
:enarch
7z e %repopath%\UpdateTemp\%~4 -o"%repopath%\UpdateExtractTemp"
rmdir /s /q %repopath%\UpdateTemp
xcopy %repopath%\UpdateExtractTemp %repopath%\UpdateTemp /H /Y /C /R /S /I
rmdir /s /q %repopath%\UpdateExtractTemp
goto back1

:arg
color C
@Echo off
cls
echo DroidUpdate must be used by application(
echo Goodbye!
timeout /t 15 >> nul
exit
@echo off

setlocal enabledelayedexpansion

set "BASEDIR=%cd%"
set "IDENT=%~n0"

for /f "tokens=1 delims=_" %%# in ("%IDENT%") do set SERVERTYPE=%%~n#
for /f "tokens=2 delims=_" %%# in ("%IDENT%") do set IDENT=%%~n#

set "RUSTDIR=rustserver_%SERVERTYPE%"

if not exist "%BASEDIR%\%RUSTDIR%\RustDedicated.exe" (
    echo RustDedicated.exe does not exist: %BASEDIR%\%RUSTDIR%\RustDedicated.exe
    echo Probably need to run update_%RUSTDIR%.bat
    pause
    exit
)

if not exist "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg" (
    mkdir "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg" || (
	echo Error creating directory %BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg
	pause
	exit
    )
)

if not exist "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg\users.cfg" (
    if exist "%BASEDIR%\defaultcfg\users.cfg" (
	echo Installing default users.cfg...
	copy "%BASEDIR%\defaultcfg\users.cfg" "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg\users.cfg" || (
	    echo Error installing default users.cfg
	    pause
	    exit
        )
    )
)

if not exist "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg\server.cfg" (
    if exist "%BASEDIR%\defaultcfg\server.cfg" (
	echo Installing default server.cfg...
	copy "%BASEDIR%\defaultcfg\server.cfg" "%BASEDIR%\%RUSTDIR%\server\%IDENT%\cfg\server.cfg" || (
	    echo Error installing default server.cfg
	    pause
	    exit
        )
    )
)

cd "%BASEDIR%\%RUSTDIR%"
RustDedicated.exe -batchmode ^
    +server.hostname "%IDENT%" ^
    +server.description "%IDENT%" ^
    +server.identity "%IDENT%" ^
    +oxide.directory "server/{server.identity}/oxide"

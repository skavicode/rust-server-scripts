@echo off

rem This script 

setlocal

set "BASEDIR=%cd%"

if exist "%BASEDIR%\modded.server.backup" (
	echo %BASEDIR%\modded.server.backup already exists
	pause
	exit
)

if exist "%BASEDIR%\rustserver_modded\server" (
	xcopy /I /E "%BASEDIR%\rustserver_modded\server" "%BASEDIR%\modded.server.backup" || (
		echo Error backing up modded servers
		pause
		exit
	)
)

rmdir /S /Q "%BASEDIR%\rustserver_modded" || (
	echo Error deleting %BASEDIR%\rustserver_modded
	pause
	exit
)

xcopy /I /E "%BASEDIR%\rustserver_vanilla" "%BASEDIR%\rustserver_modded" || (
	echo Error copying vanilla to modded
	pause
	exit
)

rmdir /S /Q "%BASEDIR%\rustserver_modded\server"

if exist "%BASEDIR%\modded.server.backup" (
	xcopy /I /E "%BASEDIR%\modded.server.backup" "%BASEDIR%\rustserver_modded\server" || (
		echo Error restoring %BASEDIR%\rustserver_modded\server
		pause
		exit
	)
	rmdir /S /Q "%BASEDIR%\modded.server.backup"
)

echo Downloading latest Oxide/Umod zip...
curl -L -o "%BASEDIR%\Oxide.Rust.zip" https://github.com/OxideMod/Oxide.Rust/releases/latest/download/Oxide.Rust.zip || (
    echo Error downloading latest Oxide/Umod zip
    pause
    exit
)

echo Extracting Oxide/Umod zip...
powershell Expand-Archive "%BASEDIR%\Oxide.Rust.zip" -Force -DestinationPath "%BASEDIR%\rustserver_modded" || (
    echo Error extracting Oxide/Umod zip
    pause
    exit
)

echo SUCCESS! Rust server updated.
pause
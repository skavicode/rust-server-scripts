@echo off

rem This script 

setlocal

set "BASEDIR=%cd%"

if exist "%BASEDIR%\steamcmd\steamcmd.exe" goto :gotSteamCmdExe
echo steamcmd.exe not found, checking for steamcmd.zip...

if exist "%BASEDIR%\steamcmd.zip" goto :gotSteamCmdZip
echo Downloading steamcmd.zip...
curl -L -o "%BASEDIR%\steamcmd.zip" https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip || (
   echo Error downloading steamcmd.zip
   pause
   exit
)

:gotSteamCmdZip
echo steamcmd.zip exists, extracting...
powershell Expand-Archive "%BASEDIR%\steamcmd.zip" -DestinationPath "%BASEDIR%\steamcmd" || (
    echo Error extracting steamcmd.zip
    pause
    exit
)

:gotSteamCmdExe
echo steamcmd.exe exists, updating Rust Server application...
"%BASEDIR%\steamcmd\steamcmd.exe" +login anonymous +force_install_dir "%BASEDIR%\rustserver_vanilla" +app_update 258550 +quit || (
    echo Error updating Rust Server
    pause
    exit
)


echo SUCCESS! Rust server updated.
pause
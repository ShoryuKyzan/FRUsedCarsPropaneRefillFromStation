@echo off
setlocal
set "source=FRUsedCarsPropaneRefillFromStation"
set "zipfile=FRUsedCarsPropaneRefillFromStation.zip"

REM Remove the existing zip file if it exists
if exist "%zipfile%" del "%zipfile%"

REM Create the zip file
powershell -command "Compress-Archive -Path '%source%\*' -DestinationPath '%zipfile%' -Force"
endlocal

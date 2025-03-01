REM copies local mod to user profile\Workshop folder for upload

REM cleanup first
rmdir /s /q "%USERPROFILE%\Zomboid\Workshop\FRUsedCarsPropaneRefillFromStation"

REM copy in
xcopy /f /y /q "FRUsedCarsPropaneRefillFromStation\poster.png" "%USERPROFILE%\Zomboid\Workshop\FRUsedCarsPropaneRefillFromStation\preview.png*"
xcopy /y /q "workshop.txt" "%USERPROFILE%\Zomboid\Workshop\FRUsedCarsPropaneRefillFromStation\"
xcopy /s /e /y /q "FRUsedCarsPropaneRefillFromStation" "%USERPROFILE%\Zomboid\Workshop\FRUsedCarsPropaneRefillFromStation\Contents\mods\FRUsedCarsPropaneRefillFromStation\"
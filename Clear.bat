sc stop vgk

@echo OFF
cls

title KIDDYxSTORE
mode con: cols=90 lines=30
Color 0F
cls
:lunch
        attrib %windir%\system32 -h | findstr /I "system32" >nul
        IF %errorlevel% neq 1 (
                echo.
                echo Ce script doit tre lanc en Administrateur.
                echo.
                pause
        )


											

color F
echo please launch FiveM and follow the next Instructions :)
timeout /T 5

taskkill /f /im FiveM.exe
echo fiveM is closed, please wait a moment.

sc stop XboxNetApiSvc
sc stop XboxGipSvc
sc stop XblGameSave
sc stop XblAuthManager

echo 				     			Xbox Unlink !
timeout /T 5

echo lancer FiveM
pause

echo veuillez appuyer sur entre si vous souhaitez relancer vos services Xbox
pause

sc start XboxNetApiSvc
sc start XboxGipSvc
sc start XblGameSave
sc start XblAuthManager

echo Services Xbox opprationnel vous pouvez quitter !
timeout /T 10
@echo off
goto :xboxclean
:xboxclean
cls
powershell -Command "& {Get-AppxPackage -AllUsers xbox | Remove-AppxPackage}"
sc stop XblAuthManager
sc stop XblGameSave
sc stop XboxNetApiSvc
sc stop XboxGipSvc
sc delete XblAuthManager
sc delete XblGameSave
sc delete XboxNetApiSvc
sc delete XboxGipSvc
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\xbgm" /f
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTask" /disable
schtasks /Change /TN "Microsoft\XblGameSave\XblGameSaveTaskLogon" /disableL
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
cls
set hostspath=%windir%\System32\drivers\etc\hosts
echo 127.0.0.1 xboxlive.com >> %hostspath%
echo 127.0.0.1 user.auth.xboxlive.com >> %hostspath%
echo 127.0.0.1 presence-heartbeat.xboxlive.com >> %hostspath%
rd %userprofile%\AppData\Local\DigitalEntitlements /q /s
exit
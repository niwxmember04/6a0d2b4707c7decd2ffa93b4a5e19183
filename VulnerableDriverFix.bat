
@echo off

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
reg add HKLM\SYSTEM\CurrentControlSet\Control\CI\Config /v VulnerableDriverBlocklistEnable /t REG_DWORD /d 0x000000

echo Done! Please Restart

pause
) ELSE (
    ECHO Please run as admin
    pause
)
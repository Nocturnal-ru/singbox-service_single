@echo off
REM change-mode.bat
REM This script switches between TUN and PROXY modes in singbox-service.xml
REM It outputs messages in English.

set "FILE=.\sing-box\singbox-service.xml"

REM Check if current mode is TUN
for /f "usebackq tokens=*" %%i in (`type "%FILE%" ^| findstr /i "config-tun.json"`) do (
    echo Currently in TUN mode.
    echo Switching to PROXY mode...
    powershell -Command "(Get-Content '%FILE%') -replace 'config-tun.json','config-proxy.json' | Set-Content '%FILE%'"
    echo Switched to PROXY mode.
    call restart-service.bat
    pause
    goto :EOF
)

REM Check if current mode is PROXY
for /f "usebackq tokens=*" %%i in (`type "%FILE%" ^| findstr /i "config-proxy.json"`) do (
    echo Currently in PROXY mode.
    echo Switching to TUN mode...
    powershell -Command "(Get-Content '%FILE%') -replace 'config-proxy.json','config-tun.json' | Set-Content '%FILE%'"
    echo Switched to TUN mode.
    call restart-service.bat
    pause
    goto :EOF
)

REM If neither is found
echo Could not find config-tun.json or config-proxy.json in %FILE%.
pause
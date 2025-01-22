@echo off
REM change-mode.bat
REM This script switches between TUN and PROXY modes in singbox-service.xml
REM It outputs messages in English.

set "FILE=.\sing-box\singbox-service.xml"

REM Check if current mode is TUN
for /f "usebackq tokens=*" %%i in (`type "%FILE%" ^| findstr /i "config-tun.json"`) do (
    echo Currently in TUN mode.
    pause
    goto :EOF
)

REM Check if current mode is PROXY
for /f "usebackq tokens=*" %%i in (`type "%FILE%" ^| findstr /i "config-proxy.json"`) do (
    echo Currently in PROXY mode.
    pause
    goto :EOF
)

REM If neither is found
echo Could not find config-tun.json or config-proxy.json in %FILE%.
pause
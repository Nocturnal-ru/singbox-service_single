@echo off
cd /d "%~dp0/sing-box"
echo Stopping SingBox service...
singbox-service.exe stop
pause
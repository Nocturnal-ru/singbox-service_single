@echo off
cd /d "%~dp0/sing-box"
echo Restarting SingBox service...
singbox-service.exe restart
pause
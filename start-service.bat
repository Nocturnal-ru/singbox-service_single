@echo off
cd /d "%~dp0/sing-box"
echo Starting SingBox service...
singbox-service.exe start
pause
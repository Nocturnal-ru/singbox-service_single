@echo off
cd /d "%~dp0/sing-box"
echo Checking service status...
singbox-service.exe status
pause
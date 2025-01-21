@echo off
cd /d "%~dp0/sing-box"
echo Removing SingBox service...
singbox-service.exe stop
timeout /t 1 /nobreak
singbox-service.exe uninstall
pause
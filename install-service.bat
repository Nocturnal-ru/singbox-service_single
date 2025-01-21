@echo off
cd /d "%~dp0/sing-box"
echo Installing SingBox service...
singbox-service.exe install
timeout /t 1 /nobreak
echo Starting SingBox service...
singbox-service.exe start
pause
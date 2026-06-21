@echo off
title AC's Multitool 1.1.2
color 0B
chcp 65001 >nul

:menu
cls
echo ==========================================
echo          AC'S MULTITOOL 1.1.2
echo ==========================================
echo.
echo 1. System Information
echo 2. Network Config
echo 3. Simple Port Scanner
echo 4. Nmap Style Scan
echo 5. Quick HTTP Request
echo 6. IP Grabify Logger
echo 7. Exit
echo ==========================================
set /p choice=Select (1-7): 

if "%choice%"=="1" goto sysinfo
if "%choice%"=="2" goto netconfig
if "%choice%"=="3" goto portscan
if "%choice%"=="4" goto nmapscan
if "%choice%"=="5" goto httpreq
if "%choice%"=="6" goto grabify
if "%choice%"=="7" goto exit

echo Invalid!
pause
goto menu

:sysinfo
cls
echo ===== SYSTEM INFORMATION =====
systeminfo | more
pause
goto menu

:netconfig
cls
echo ===== NETWORK CONFIG =====
ipconfig /all | more
pause
goto menu

:portscan
cls
set /p target=Target IP: 
if "%target%"=="" goto menu
echo Scanning ports 1-100 on %target%...
for /L %%p in (1,1,100) do (
    <nul (set /p "=%%p ") >nul
    powershell -noprofile -command "(New-Object System.Net.Sockets.TcpClient).Connect('%target%',%%p)" 2>nul && echo [OPEN %%p]
)
pause
goto menu

:nmapscan
cls
set /p target=Target: 
if "%target%"=="" goto menu
where nmap >nul 2>&1 || echo Nmap not installed.
if %errorlevel%==0 nmap -T4 -F %target%
pause
goto menu

:httpreq
cls
set /p url=Enter URL: 
if "%url%"=="" goto menu
powershell -noprofile -command "Invoke-WebRequest -Uri '%url%' -UseBasicParsing | Select-Object StatusCode,Content" 
pause
goto menu

:grabify
cls
echo ===== IP GRABIFY LOGGER =====
set /p link=Enter your Grabify link: 
if "%link%"=="" goto menu
echo.
echo Share this link:
echo %link%
echo.
echo Waiting for clicks... Check Grabify dashboard.
pause
goto menu

:exit
echo.
echo Goodbye, Master AC~
timeout /t 2 >nul
exit
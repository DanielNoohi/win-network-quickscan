@echo off
setlocal EnableDelayedExpansion

REM 1. Check if nmap is installed
where nmap >nul 2>&1
if %errorlevel% neq 0 (
    echo [*] Nmap is not installed. Downloading and installing...
    REM Download nmap installer
    powershell -Command "Invoke-WebRequest -Uri 'https://nmap.org/dist/nmap-7.95-setup.exe' -OutFile '%temp%\nmap-setup.exe'"
    REM Silent install
    "%temp%\nmap-setup.exe" /SILENT /NORESTART
    timeout /t 10
    REM Update PATH for current session
    set "PATH=%ProgramFiles(x86)%\Nmap;%ProgramFiles%\Nmap;%PATH%"
    echo [*] Nmap installed.
) else (
    echo [*] Nmap is already installed.
)

REM 2. Quick scan for online devices in local network
set "NETWORK_RANGE=192.168.1.0/24"
echo [*] Scanning network %NETWORK_RANGE% for online hosts...
nmap -sn %NETWORK_RANGE% -oG live_hosts.txt

REM 3. Parse live hosts and check OS detection for Windows
echo [*] Identifying Windows hosts...
set "WINDOWS_HOSTS="
for /f "tokens=2 delims= " %%i in ('findstr /R /C:"Status: Up" live_hosts.txt') do (
    REM OS detection (slow for many hosts)
    echo [*] Checking OS for %%i...
    nmap -O %%i | findstr /I "windows" >nul 2>&1
    if !errorlevel! == 0 (
        echo [*] Windows host found: %%i
        set "WINDOWS_HOSTS=!WINDOWS_HOSTS! %%i"
    )
)

REM 4. For each Windows host, scan open ports and print
if "%WINDOWS_HOSTS%"=="" (
    echo [*] No Windows hosts detected.
) else (
    for %%h in (%WINDOWS_HOSTS%) do (
        echo [*] Scanning open ports for Windows host: %%h
        nmap -Pn -p- %%h
    )
)

echo [*] Script finished.
pause

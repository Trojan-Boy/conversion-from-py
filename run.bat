@echo off
setlocal enabledelayedexpansion

:: Configuration
set "REPO_URL=https://raw.githubusercontent.com/Trojan-Boy/conversion-from-py/main"
set "SCRIPT_NAME=telegram-1.py"
set "REQUIREMENTS=requirements.txt"
set "DOWNLOAD_DIR=%USERPROFILE%\Documents\telegram bot"

:: Colors for output
echo ================================================
echo   Telegram Auto-Sender Bot - Launcher
echo ================================================
echo.

:: Create download directory if it doesn't exist
if not exist "%DOWNLOAD_DIR%" (
    echo [*] Creating directory: %DOWNLOAD_DIR%
    mkdir "%DOWNLOAD_DIR%"
)

:: Change to download directory
cd /d "%DOWNLOAD_DIR%"
echo [*] Working directory: %DOWNLOAD_DIR%
echo.

:: Download latest version of the Python script
echo [*] Downloading latest version from GitHub...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%REPO_URL%/%SCRIPT_NAME%' -OutFile '%SCRIPT_NAME%'}"

if errorlevel 1 (
    echo [ERROR] Failed to download %SCRIPT_NAME%
    echo [ERROR] Please check:
    echo   1. Your internet connection
    echo   2. The repository URL is correct
    echo   3. The file exists in your GitHub repo
    pause
    exit /b 1
)
echo [+] Successfully downloaded %SCRIPT_NAME%
echo.

:: Download requirements.txt
echo [*] Downloading requirements.txt...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%REPO_URL%/%REQUIREMENTS%' -OutFile '%REQUIREMENTS%'}"

if errorlevel 1 (
    echo [WARNING] Could not download requirements.txt
) else (
    echo [+] Successfully downloaded requirements.txt
)
echo.

:: Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH
    echo Please install Python from https://www.python.org/downloads/
    pause
    exit /b 1
)
echo [+] Python detected
echo.

:: Install/Update requirements
if exist "%REQUIREMENTS%" (
    echo [*] Installing/Updating Python dependencies...
    python -m pip install --upgrade pip >nul 2>&1
    python -m pip install -r "%REQUIREMENTS%" --upgrade
    echo [+] Dependencies installed
    echo.
)

:: Run the Python script
echo ================================================
echo [*] Starting Telegram Bot...
echo ================================================
echo.
python "%SCRIPT_NAME%"

:: Check exit status
if errorlevel 1 (
    echo.
    echo [ERROR] Script ended with errors
    pause
    exit /b 1
)

echo.
echo ================================================
echo [*] Script completed successfully
echo ================================================
pause

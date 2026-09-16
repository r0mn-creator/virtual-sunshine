@echo off
rem Run this once, as Administrator, after updating an existing Apollo/
rem Sunshine install by extracting the portable ZIP over it (rather than
rem using the installer). A fresh install's config folder gets its
rem permissions set up by the installer itself (icacls /reset, run
rem elevated); a plain file drop-in skips that step, and the certificate/
rem log files that get overwritten can end up with permissions the app
rem can no longer read or write - Sunshine then fails to start with an
rem "Access is denied" error the moment it tries to load its TLS cert.
rem Safe to run any time, including on an install that's already working.

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This needs to run as Administrator.
    echo Right-click this file and choose "Run as administrator", then try again.
    pause
    exit /b 1
)

echo Fixing permissions on "%~dp0config"...
icacls "%~dp0config" /grant Users:(OI)(CI)M /T

echo.
echo Done. You can close this window and start sunshine.exe normally.
pause

@echo off
powershell.exe -ExecutionPolicy Bypass -File "%~dp0fileUploadScript.ps1"
exit /b %ERRORLEVEL%
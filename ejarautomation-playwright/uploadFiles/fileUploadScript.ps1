# File Upload Automation Script for Windows File Dialog
# This script automates file selection in Windows file upload dialogs

param(
    [string]$FilePath = "D:\\ejarconnected\\ejarautomation-selenium\\uploadFiles\\logo_high.png"
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Wait for file dialog to appear
Start-Sleep -Seconds 2

# Get the file dialog window
$fileDialog = Get-Process | Where-Object { $_.MainWindowTitle -like "*Open*" -or $_.MainWindowTitle -like "*Upload*" -or $_.MainWindowTitle -like "*Choose*" } | Select-Object -First 1

if ($fileDialog -ne $null) {
    # Bring the file dialog to foreground
    [System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
    Start-Sleep -Milliseconds 500
    
    # Type the file path and press Enter
    [System.Windows.Forms.SendKeys]::SendWait($FilePath)
    Start-Sleep -Milliseconds 500
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
    
    Write-Host "File uploaded successfully: $FilePath"
} else {
    Write-Host "No file dialog found"
    exit 1
}

exit 0
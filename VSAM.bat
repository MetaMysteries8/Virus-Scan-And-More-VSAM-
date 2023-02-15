@echo off

:menu
cls
echo Please choose an option:
echo 1. Scan files for corruption and malicious content
echo 2. Repair files using System File Checker (SFC)
echo 3. Scan and repair files using DISM
echo 4. Scan and repair the Windows registry
echo 5. Scan and repair the Master Boot Record (MBR)
echo 6. Scan and repair the boot configuration data (BCD)
echo 7. Boot into Safe Mode
echo 8. Reboot into Recovery Mode
echo 9. Exit

set /p option="Enter your choice: "

if %option%==1 (
    echo Scanning files for corruption and malicious content...
    REM Check for corrupted files using sfc (System File Checker)
    sfc /scannow
    REM Check for malware using Windows Defender
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3
    REM Check for dangerous files using Windows Defender
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
    REM Check for adware and potentially unwanted programs (PUPs) using PowerShell
    powershell -Command "Get-AppxPackage -AllUsers | where-object {$_.Name -like '*adware*'}"
    REM Check for rootkits using Windows Defender Offline
    "%ProgramFiles%\Windows Defender\mpam-fe.exe" /mPolicies /RunAsSystem /Scan -BootSectorScan
    REM Check for backdoors using Windows Defender
    "%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
    echo File scan complete.
    pause
    goto menu
)

if %option%==2 (
    echo Repairing files using SFC...
    sfc /scannow
    pause
    goto menu
)

if %option%==3 (
    echo Repairing files using DISM...
    DISM /Online /Cleanup-Image /RestoreHealth
    pause
    goto menu
)

if %option%==4 (
    echo Scanning and repairing the Windows registry...
    REG /C /ScanNow
    pause
    goto menu
)

if %option%==5 (
    echo Scanning and repairing the Master Boot Record (MBR)...
    bootrec /FixMbr
    pause
    goto menu
)

if %option%==6 (
    echo Scanning and repairing the boot configuration data (BCD)...
    bootrec /RebuildBcd
    pause
    goto menu
)

if %option%==7 (
    echo Booting into Safe Mode...
    bcdedit /set {default} safeboot minimal
    shutdown /r /f /t 00
)

if %option%==8 (
    echo Rebooting into Recovery Mode...
    shutdown /r /o /t 00
)

if %option%==9 (
    echo Exiting script...
    exit
)

echo Invalid choice. Please try again.
pause
goto menu

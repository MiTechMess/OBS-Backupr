@echo off 
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
echo off

title OBS Backupr
set script-title=OBS Backupr
set backup-dir=%userprofile%\Desktop

:begin
cls
echo ====================================================================================
echo %script-title%
echo - Easy OBS Backup / Restore
echo ====================================================================================
echo,
echo 1) Backup OBS (Settings, Scenes, Sources, Plugins)
echo 2) Restore OBS 
echo 3) More information ... 
echo 4) Exit 
echo,
echo ------------------------------------------------------------------------------------
set /p op=What do you want to do? 
if "%op%"=="1" goto backup
if "%op%"=="2" goto restore
if "%op%"=="3" goto information
if "%op%"=="4" goto exit


:backup
mkdir "%backup-dir%"

cls
echo ====================================================================================
echo %script-title%
echo - Backing Up OBS ... 
echo ====================================================================================
echo,

cd %appdata% && tar -a -cf "%backup-dir%\obs-studio.zip" "obs-studio"

cls
echo ====================================================================================
echo %script-title%
echo - Backup Finished!
echo ====================================================================================
timeout /t 5 
goto begin

:restore
cls
echo ====================================================================================
echo %script-title%
echo ! WARNING ! This will close OBS, Save before you continue.
echo ====================================================================================
echo,
set /p op=Are you sure you want to continue? (y/n) :  
if "%op%"=="y" goto restore-yes
if "%op%"=="n" goto exit

:restore-yes
cls
echo ====================================================================================
echo %script-title%
echo Closing OBS ... 
echo, 
echo ! NOTE ! If OBS is already closed, you will get an error. You can ignore it.
echo ====================================================================================
echo,
taskkill/f /t /im obs64.exe
echo,
timeout /t 5 

cls
echo ====================================================================================
echo %script-title%
echo ! Restoring OBS from backup ...
echo ====================================================================================
echo,

cd %appdata% && tar -m -xf "%backup-dir%\obs-studio.zip" "obs-studio"

cls
echo ====================================================================================
echo %script-title%
echo - Restore Finished!
echo ====================================================================================
timeout /t 5 
goto begin


:information
cls
echo ====================================================================================
echo %script-title% - More Information
echo ====================================================================================
echo,
echo This script was made by Mitechmess.com
echo, 
echo ------------------------------------------------------------------------------------
echo,
set /p op=To go back type X and press enter 
if "%op%"=="x" goto begin
if "%op%"=="X" goto begin

:exit
exit
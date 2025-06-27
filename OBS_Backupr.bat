:: OBS Backupr
:: Version: 1.1
:: Author: MiTechMess
:: Description: A script to backup and restore your OBS settings, scenes, sources and plugins.

:: Run this script as administrator

@echo off 
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
echo off

:config
title OBS Backupr
set verion=1.0
set author=MiTechMess
set description=A script to backup and restore your OBS settings, scenes, sources and plugins.
set script-title=OBS Backupr
set backup-dir=%userprofile%\Desktop
set appdata=%appdata%


:main_menu
cls
echo ====================================================================================
echo %script-title%
echo Version: %version%
echo Description: %description%
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
echo Version: %version%
echo Description: %description%
echo ====================================================================================
echo,
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
goto main_menu

:restore
cls
echo ====================================================================================
echo %script-title%
echo Version: %version%
echo ====================================================================================
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
echo Version: %version%
echo ====================================================================================
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
echo Version: %version%
echo ! Restoring OBS from backup ...
echo ====================================================================================
echo,

cd %appdata% && tar -m -xf "%backup-dir%\obs-studio.zip" "obs-studio"

cls
echo ====================================================================================
echo %script-title%
echo Version: %version%
echo - Restore Finished!
echo ====================================================================================
timeout /t 5 
goto main_menu


:information
cls
echo ====================================================================================
echo %script-title% - MORE INFORMATION
echo Version: %version%
echo Description: %description%
echo ====================================================================================
echo,
echo This script was made by Mitechmess.com
echo, 
echo ------------------------------------------------------------------------------------
echo,
set /p op=To go back type X and press enter 
if "%op%"=="x" goto main_menu
if "%op%"=="X" goto main_menu

:exit
exit
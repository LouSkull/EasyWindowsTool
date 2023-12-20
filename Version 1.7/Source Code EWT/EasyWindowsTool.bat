@echo off
title EWT FreeV2 - https://vk.com/easytool
start Am.vbs

mode 200,60

net session >nul 2>&1
if %errorLevel% neq 0 (

:spam
    echo Этот скрипт должен быть запущен с правами администратора!
    goto spam
    pause
    exit /b 1
)


:menu
echo.
echo                                                     ███████╗██╗    ██╗████████╗              ███████╗██████╗ ███████╗███████╗    ██╗   ██╗██████╗ 
echo                                                     ██╔════╝██║    ██║╚══██╔══╝              ██╔════╝██╔══██╗██╔════╝██╔════╝    ██║   ██║╚════██╗
echo                                                     █████╗  ██║ █╗ ██║   ██║       █████╗    █████╗  ██████╔╝█████╗  █████╗      ██║   ██║ █████╔╝
echo                                                     ██╔══╝  ██║███╗██║   ██║       ╚════╝    ██╔══╝  ██╔══██╗██╔══╝  ██╔══╝      ╚██╗ ██╔╝██╔═══╝ 
echo                                                     ███████╗╚███╔███╔╝   ██║                 ██║     ██║  ██║███████╗███████╗     ╚████╔╝ ███████╗
echo                                                     ╚══════╝ ╚══╝╚══╝    ╚═╝                 ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝      ╚═══╝  ╚══════╝
echo.
echo.
echo                                                               ==========================================================================
echo                                                                                             Главное меню                                    
echo                                                               ==========================================================================
echo.
echo                                                               1. Управление диспетчером задач      !           8. Мой IP
echo                                                               2. Информация о системе              !           9. Сброс реестра 
echo                                                               3. Удаление временных файлов         !           10. Выключить компьютер
echo                                                               4. Управление Windows Defender       !           11. Сброс Userinit
echo                                                               5. Авто запуск                       !           12. Настройки
echo                                                               6. Мониторинг ресурсов               !           13. Выход
echo                                                               7. Обновление системы                !           14. Сканирование на вирусы
echo.
echo.
echo.
echo.

echo.
echo.
set /p choice=[*] Введите номер функции: 

if "%choice%" == "14" (
    cls
    @echo off
setlocal

echo Запуск сканирования антивирусом...

start /wait "" "C:\Program Files\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2

if %errorlevel% equ 0 (
    echo Сканирование завершено без обнаружения угроз.
) else (
    echo Обнаружены угрозы во время сканирования.
)

endlocal
    pause
    cls
    goto menu
)

if "%choice%" == "1" (  

    cls
    
    @echo off
:TaskMgr
    echo
    echo                                                   ==========================================================================
    echo                                                                             Управление диспетчером задач                                    
    echo                                                   ==========================================================================
    echo.
    echo                                                          1. Отключить диспетчер задач  ! 2. Включить диспетчер задач
    echo                                                                             3. Вернуться в меню
    echo.
    echo.
    echo.
    
set /p choiceTaskMgr=[*] Введите номер функции: 

if "%choiceTaskMgr%" == "1" (
    cls
    echo Диспетчер задач выключен
    REG add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f
    pause
    cls
    goto TaskMgr

)

if "%choiceTaskMgr%" == "2" (
    cls
    echo Диспетчер задач включен
    REG add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 0 /f
    pause
    cls
    goto TaskMgr
    
)

if "%choiceTaskMgr%" == "3" (
    echo.
    cls
    goto menu    
)

    pause
    cls
    goto menu
)


 if "%choice%"=="2" (
    cls

    @echo off

    echo ------------------------
    echo Информация о компьютере:
    echo ------------------------
    systeminfo | findstr /C:"Host Name" /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model"
    echo ------------------------------
    echo Информация о процессоре:
    echo ------------------------
    wmic cpu get Name, MaxClockSpeed, NumberOfCores
    echo ------------------------------------------
    echo Информация о памяти:
    echo --------------------
    wmic memorychip get Capacity, Speed
    echo ------------------------------
    echo Информация о жестком диске:
    echo ---------------------------
    wmic diskdrive get Model, Size
    echo ------------------------------
    pause
    cls
    goto menu
)

if "%choice%"=="3" (
    cls

    @echo off
    echo Очистка временных файлов...

echo Очистка временных файлов Windows...
del /q /s /f %temp%\*.*
del /q /s /f C:\Windows\Temp\*

echo Очистка кеша браузера "Google Chrome"
rd /s /q "C:\Users\%username%\AppData\Local\Google\Chrome\User Data\Default\Cache"

echo Очистка файлов журналов...
del /q /s /f C:\Windows\Logs\*

echo Очистка временных файлов Центра обновления Windows...
del /q /s /f C:\Windows\SoftwareDistribution\Download\*.*

echo Очистка временных файлов установщика Windows...
del /q /s /f %windir%\Installer\*.*

echo Cleanup complete.
    pause
    cls
    goto menu
)

if "%choice%" == "4" (
    cls

    @echo off
:WindowsDefender
    echo.
    echo                                                   ==========================================================================
    echo                                                                            Управление Windows Defender                                    
    echo                                                   ==========================================================================
    echo.
    echo                                                        1. Включить защитник виндовс   ! 2. Отключить защитник виндовс
    echo                                                                               3. Назад к меню
    echo.
    echo.
    set /p choiceWindowsDefender=[*] Введите номер функции: 

if "%choiceWindowsDefender%" == "1" (
    echo Защитник Windows отключен!
    powershell -Command "Start-Process -Wait -Verb RunAs PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command Set-MpPreference -DisableRealtimeMonitoring $false'"
    pause
    cls
    goto WindowsDefender
)

if "%choiceWindowsDefender%" == "2" (
    powershell -Command "Start-Process -Wait -Verb RunAs PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command Set-MpPreference -DisableRealtimeMonitoring $true'"
    echo Защитник Windows включен!
    pause
    cls
    goto WindowsDefender
)

if "%choiceWindowsDefender%" == "3" (
    cls
    goto menu
)

pause
cls
goto menu
)

if "%choice%"=="5" (
    cls

    @echo off
echo Следующие программы запускаются при запуске операционной системы:
echo.

wmic startup list full | findstr /I "Caption Command"
    pause
    cls
    goto menu
)

if "%choice%"=="6" (

    @echo off
:monitor
cls
echo Мониторинг ресурсов
echo -------------------
echo.


echo 3агрузка процессора:
wmic cpu get loadpercentage


echo Использование памяти:
wmic os get freephysicalmemory, totalvisiblememorysize /value


    pause
    cls
    goto menu
)

if "%choice%"=="7" (
    cls
    @echo off
setlocal

echo Попытка установки обновлений...

wusa.exe "C:\path\to\update.msu" /quiet /norestart

if %errorlevel% equ 0 (
    echo Обновления успешно установлены.
) else (
    echo Произошла ошибка при установке обновлений.
)

endlocal

    pause
    cls
    goto menu
)
if "%choice%"=="8" (
    cls

    @echo off
    ipconfig | findstr /i "IPv6 Address"
    echo.
    ipconfig | findstr /i "IPv4 Address"
    pause
    cls
    goto menu
)

if "%choice%"=="9" (
:ReestreVV
cls

echo.
echo.

echo.

set /p registryBackupPath=[*] Введите путь к файлу резервной копии реестра: 

if not exist "%registryBackupPath%" (
    echo Указанный файл резервной копии реестра не существует.
    pause
    goto ReestreVV
)

echo Восстановление реестра...
reg restore HKLM\System\ControlSet001\BackupRestore %registryBackupPath%
reg restore HKLM\System\ControlSet002\BackupRestore %registryBackupPath%
reg restore HKLM\System\CurrentControlSet\BackupRestore %registryBackupPath%

echo.
pause
goto menu
)

if "%choice%" == "10" (
    cls

    echo.
    echo                                                   ==========================================================================
    echo                                                                             Управление Питанием                                    
    echo                                                   ==========================================================================
    echo.
    echo                                                            1. Перезагрузить компьютер   ! 2. Выключить компьютер
    echo                                                            3. Выйти                     ! 4. Вернуться в меню
    echo.
    echo.
    echo.
    set /p ShutDuwnPcc=[*] Введите номер функции: 

if "%ShutDuwnPcc%" == "1" (
shutdown /r /f /t 0
echo.
exit /b
)

if "%ShutDuwnPcc%" == "2" (
shutdown /s /f /t 0
echo.
exit /b
)

if "%ShutDuwnPcc%" == "3" (
shutdown /l
echo.
exit /b
)

if "%ShutDuwnPcc%" == "4" (
cls
goto menu
exit /b
)

    pause
    cls
    goto menu
)

if "%choice%"=="13" (
    echo Выход.
    exit /b
)

if "%choice%"=="12" (
    cls
    @echo off
    echo.
    echo                                                               ==========================================================================
    echo                                                                                              Настройки                                        
    echo                                                               ==========================================================================
    echo.
    echo                                                                                 1. Установить цвет ! 2. Обновлять
    echo                                                                                         3. Вернуться в меню
    set /p Settings=[*] Введите номер функции: 
    echo.
    echo.

if "%Settings%" == "1" (
    cls
    :ColorMenu
    echo.
    echo                                                               ==========================================================================
    echo                                                                                           Настройки цвета                                
    echo                                                               ==========================================================================
    echo.
    echo                                                                                  1. По умолчанию  ! 2. Красный
    echo                                                                                  3. Зеленый       ! 4. Голубой
    echo                                                                                  5. Серый         ! 6. Назад к меню

    set /p ColorChoice=[*] Введите номер функции: 

    if "%ColorChoice%" == "1" (
        color F
        cls
        goto ColorMenu
    )

    if "%ColorChoice%" == "2" (
        color 4
        cls
        goto ColorMenu
    )

    if "%ColorChoice%" == "3" (
        color 2
        cls
        goto ColorMenu
    )

    if "%ColorChoice%" == "4" (
        color 3
        cls
        goto ColorMenu
    )

    if "%ColorChoice%" == "5" (
        color 8
        cls
        goto ColorMenu
    )

    if "%ColorChoice%" == "6" (
        cls
        goto menu
    )

    pause
    cls
    goto menu
)

if "%Settings%" == "3" (    
cls
goto menu
)

if "%Settings%" == "2" (
start "" "https://vk.com/easytool"
cls
goto menu
)

    pause
    cls
    goto menu
)

if "%choice%" == "11" (
cls
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /t REG_SZ /d "C:\Windows\system32\userinit.exe,"
cls
goto menu
)



echo Неверный ответ. Пожалуйста, выберите еще раз.
pause
     cls
     goto menu
end
    end
        end

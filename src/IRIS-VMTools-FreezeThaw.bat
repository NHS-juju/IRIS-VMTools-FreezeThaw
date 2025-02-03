@echo off
rem VMTools should pass in either freeze or thaw.
if "%1" == "freeze" goto doFreeze
if "%1" == "thaw" goto doThaw
echo.
echo Nothing Matched. Exiting...
EXIT /b

:doFreeze
rem Call external freeze. OS Authentication negates need for login credentials.
c:\InterSystems\HealthShare\bin\irisdb -s"C:\InterSystems\HealthShare\Mgr" -U%%SYS ##Class(Backup.General).ExternalFreeze()
echo.
echo.
rem Check errorlevel from highest to lowest here.
if errorlevel 5 goto FreezeOK
if errorlevel 3 goto FreezeFAIL

rem If here, errorlevel did not match an expected output.
rem Assume Failure.
echo errorlevel returned unexpected value
goto FreezeFAIL

:FreezeOK
echo SYSTEM IS FROZEN
rem Error levels from freeze do not match standard convention, so we return 0 when successful.
EXIT /b 0

:FreezeFAIL
echo SYSTEM FREEZE FAILED
EXIT /b 1

:doThaw
c:\InterSystems\HealthShare\bin\irisdb -s"C:\InterSystems\HealthShare\Mgr" -U%%SYS ##Class(Backup.General).ExternalThaw()
echo.
echo SYSTEM IS THAWED
echo.
c:\InterSystems\HealthShare\bin\irisdb -s"C:\InterSystems\HealthShare\Mgr" -U%%SYS ##Class(Backup.General).ExternalSetHistory()
echo.
echo BACKUP RECORDED
EXIT /b 0

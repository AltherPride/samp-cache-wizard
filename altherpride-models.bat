@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo Before continuing this operation, ensure your internet connection is stable.

choice /C YN /N /M "Are you sure you want to continue? (Y/N):"

if errorlevel 2 (
	echo The operation was cancelled by user, bye :^)
	timeout /t 3 /nobreak >nul
	exit /b
) else if errorlevel 1 (
	cls
	timeout /t 3 /nobreak >nul
)

title AltherPride SA-MP Cache Wizard

:checkpoint1

for /f "tokens=2 delims=[]" %%a in ('ping -n 1 samp.altherpride.my.id ^| find "["') do set "ATR_IP=%%a"

for /f "tokens=2 delims=:" %%a in ('mode con ^| find "Columns"') do set "cols=%%a"
set /a cols=%cols%

set /a pad=(cols - 50) / 2
set "spaces="
for /l %%i in (1,1,%pad%) do set "spaces=!spaces! "

echo(
echo !spaces!╔════════════════════════════════════════════════╗
echo !spaces!║         AltherPride SA-MP Cache Wizard         ║
echo !spaces!║                  by melovart                   ║
echo !spaces!╚════════════════════════════════════════════════╝

echo(
echo(
timeout /t 1 /nobreak >nul
echo Initializing the AltherPride Wizard
timeout /t 3 /nobreak >nul

set SAMP_IP=%ATR_IP%.7777
set ATR_DIR=%USERPROFILE%\Documents\GTA San Andreas User Files\SAMP\cache\%SAMP_IP%
set TEMP_DIR=%TEMP%\altherpride_temp
set ZIP_FILE=%TEMP%\altherpride_models.zip

if exist "%ATR_DIR%" (
	echo └── AltherPride SA-MP Cache Models already exist in "%ATR_DIR%"
	echo(
	choice /C YN /N /M "Are you sure you want to continue? Current models will deleted (Y/N):"

	if errorlevel 2 (
		if exist "%TEMP_DIR%" (
			rd /s /q "%TEMP_DIR%"
		)

		if exist "%ZIP_FILE%" (
			del "%ZIP_FILE%"
		)

		echo You good to choice that way, bye :^)
		timeout /t 3 /nobreak >nul
		exit /b
	) else if errorlevel 1 (
		rd /s /q "%ATR_DIR%"
		mkdir "%ATR_DIR%"

		cls
		timeout /t 3 /nobreak >nul
	)
) else (
	mkdir "%ATR_DIR%"
	echo ├── Created AltherPride SA-MP Cache folder in "%ATR_DIR%"
	timeout /t 1 /nobreak >nul
)

if not exist "%TEMP_DIR%" (
	mkdir "%TEMP_DIR%"
	echo ├── Created Temporary Folder in "%TEMP_DIR%"
	timeout /t 1 /nobreak >nul
) else (
	echo ├── Temporary Folder already exist in "%TEMP_DIR%" skipping
	timeout /t 1 /nobreak >nul
)

echo └── Initializing Done

timeout /t 3 /nobreak >nul

echo(
echo Preparing AltherPride Cache Models
timeout /t 3 /nobreak >nul

:checkpoint2

if exist "%ZIP_FILE%" (
	echo ├── Cache Models already exists in "%ZIP_FILE%" skipping
	timeout /t 1 /nobreak >nul
) else (
	powershell -Command "Invoke-WebRequest -Uri 'https://altherpride.my.id/download?file=models.zip' -OutFile '%ZIP_FILE%' -Headers @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' }"

	if errorlevel 1 (
		echo └── Download failed

		echo(
		choice /C YN /N /M "Do you want to re-download the Cache Models? (Y/N):"

		if errorlevel 2 (
			if exist "%TEMP_DIR%" (
				rd /s /q "%TEMP_DIR%"
			)

			if exist "%ZIP_FILE%" (
				del "%ZIP_FILE%"
			)

			echo The operation was cancelled by user, bye :^)
			timeout /t 3 /nobreak >nul
			exit /b
		) else if errorlevel 1 (
			if exist "%ZIP_FILE%" (
				del "%ZIP_FILE%"
			)

			goto checkpoint2
		)
	) else (
		echo ├── Cache Models successfully downloaded to "%ZIP_FILE%"
		timeout /t 1 /nobreak >nul
	)
)

if exist "%ZIP_FILE%" (
	powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%' -Force"

	echo ├── Successfully Extracting the Cache Models to "%TEMP_DIR%"
	timeout /t 1 /nobreak >nul
) else (
	echo └── We're cannot find the Cache Models place
	echo(

	choice /C YN /N /M "Do you want to re-run this Wizard? (Y/N):"

	if errorlevel 2 (
		echo The operation was cancelled by user, bye :^)
		timeout /t 3 /nobreak >nul
		exit /b
	) else if errorlevel 1 (
		if exist "%TEMP_DIR%" (
			rd /s /q "%TEMP_DIR%"
		)

		if exist "%ZIP_FILE%" (
			del "%ZIP_FILE%"
		)

		cls
		goto checkpoint1
	)
)

xcopy "%TEMP_DIR%\*" "%ATR_DIR%" /E /H /Y >nul

echo ├── Successfully Copying the Cache Models to "%ATR_DIR%"
timeout /t 1 /nobreak >nul

echo └── Preparing Cache Models Done

timeout /t 3 /nobreak >nul

echo(
echo Cleaning Up

if exist "%TEMP_DIR%" (
	rd /s /q "%TEMP_DIR%"

	echo ├── Successfully Cleaning Temporary folder in "%TEMP_DIR%"
	timeout /t 3 /nobreak >nul
)

if exist "%ZIP_FILE%" (
	del "%ZIP_FILE%"

	echo ├── Successfully Cleaning Temporary file "%ZIP_FILE%"
	timeout /t 2 /nobreak >nul
)

echo └── Cleaning Up Done

timeout /t 3 /nobreak >nul

echo(
echo(
echo Thankyou and Goodbye from melovart :^)
echo(

pause
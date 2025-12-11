@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
	echo Before continuing this operation, ensure your internet connection is stable.
	choice /C YN /N /M "Are you sure you want to continue? (Y/N):"

	if errorlevel 2 (
		echo The operation was cancelled.
		timeout /t 3 /nobreak >nul
		exit /b
	) else (
		set "bar="
		set "spaces=                    "
		for /l %%i in (1,1,20) do (
			set "bar=!bar!#"
			set "pad=!spaces:~%%i!"
			cls
			echo Initializing AltherPride Wizard: [!bar!!pad!]
			ping localhost -n 1 >nul
		)
		cls

		start "" cmd /k "%~f0" spawned
		exit /b
	)
)

title AltherPride Cache Wizard

set TEMP_DIR=%TEMP%\alther_temp
set OLD_FOLDER=139.59.241.180.7777
set CHECKED_DIR=%USERPROFILE%\Documents\GTA San Andreas User Files\SAMP\cache\%OLD_FOLDER%
set ZIP_FILE=%TEMP%\alther_models.zip
set TARGET_DIR=%USERPROFILE%\Documents\GTA San Andreas User Files\SAMP\cache

echo [INIT] Setting up a temporary folder...
timeout /t 5 /nobreak >nul
if exist "%TEMP_DIR%" rd /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"
echo [INFO] Temporary folder created successfully.
echo.
timeout /t 3 /nobreak >nul

echo [DOWNLOAD] Downloading cache files...
powershell -Command "Invoke-WebRequest -Uri 'https://altherpride.my.id/download?file=models.zip' -OutFile '%ZIP_FILE%' -Headers @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' }"

if not exist "%ZIP_FILE%" (
	echo [ERROR] Download failed. Check your internet connection or the URL.
	pause
	exit /b 1
)

echo [INFO] All cache files have been downloaded.
echo.
timeout /t 3 /nobreak >nul

echo [SCAN] Scanning directory: '%TARGET_DIR%'
if not exist "%TARGET_DIR%" (
	mkdir "%TARGET_DIR%" 2>nul
)
timeout /t 5 /nobreak >nul

if exist "%CHECKED_DIR%" (
	choice /C YN /N /M "[INPUT] Old cache folder '%OLD_FOLDER%' found. Do you want to remove it? (Y/N):"

	if errorlevel 2 (
		timeout /t 2 /nobreak >nul
	) else (
		echo [REMOVE] Removing the '%OLD_FOLDER%' folder...
		timeout /t 5 /nobreak >nul
		rd /s /q "%CHECKED_DIR%"
		echo [INFO] Folder '%OLD_FOLDER%' was successfully removed.
		echo.
		timeout /t 3 /nobreak >nul
	)
)

echo [EXTRACT] Extracting new cache files...
powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%TEMP_DIR%' -Force"

echo [INFO] All cache files extracted successfully.
echo.
timeout /t 3 /nobreak >nul

echo [COPY] Copying new files to directory: '%TARGET_DIR%'
timeout /t 5 /nobreak >nul

if not exist "%TEMP_DIR%" (
	echo [ERROR] Extracted files not found. Aborting.
	exit /b 1
)

xcopy "%TEMP_DIR%\*" "%TARGET_DIR%" /E /H /Y >nul

echo [INFO] All new files copied to directory: '%TARGET_DIR%'
echo.
timeout /t 3 /nobreak >nul

echo [CLEANUP] Cleaning temporary files...
timeout /t 5 /nobreak >nul
del "%ZIP_FILE%"
rd /s /q "%TEMP_DIR%"

echo [INFO] Temporary folder removed.
timeout /t 3 /nobreak >nul

echo [INFO] Residual files cleared.
echo.
timeout /t 5 /nobreak >nul

echo [DONE] The model cache has been updated successfully.
pause
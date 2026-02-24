@echo off
echo ========================================
echo     LoyalBazaar Flutter App Runner
echo ========================================
echo.

REM Check if Flutter is in PATH
where flutter >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Flutter not found in PATH!
    echo.
    echo Please install Flutter first:
    echo 1. Download from: https://flutter.dev/docs/get-started/install/windows
    echo 2. Extract to: C:\flutter
    echo 3. Add C:\flutter\bin to system PATH
    echo.
    echo Then run this file again.
    pause
    exit /b 1
)

echo Flutter found! Starting LoyalBazaar app...
echo.

REM Navigate to project directory
cd /d "d:\Smart Kirana"
if %ERRORLEVEL% NEQ 0 (
    echo Error: Cannot find project directory!
    pause
    exit /b 1
)

echo Current directory: %CD%
echo.

REM Check if main file exists
if not exist "lib\main_responsive.dart" (
    echo Error: Main file not found!
    echo Expected: lib\main_responsive.dart
    pause
    exit /b 1
)

echo Installing dependencies...
flutter pub get
if %ERRORLEVEL% NEQ 0 (
    echo Error installing dependencies!
    pause
    exit /b 1
)

echo.
echo Dependencies installed successfully!
echo.

echo Checking Flutter doctor...
flutter doctor
echo.

echo Starting LoyalBazaar app...
echo.
echo Choose your option:
echo 1. Run on connected device
echo 2. Run in Chrome (Web)
echo 3. Run in Android Emulator
echo.
set /p choice="Enter your choice (1-3): "

if "%choice%"=="1" (
    echo Running on connected device...
    flutter run --target=lib/main_responsive.dart
) else if "%choice%"=="2" (
    echo Running in Chrome...
    flutter run -d chrome --target=lib/main_responsive.dart
) else if "%choice%"=="3" (
    echo Running on Android Emulator...
    flutter emulators
    echo.
    set /p emulator="Enter emulator name: "
    flutter emulators --launch %emulator%
    flutter run --target=lib/main_responsive.dart
) else (
    echo Invalid choice! Running on default device...
    flutter run --target=lib/main_responsive.dart
)

echo.
echo LoyalBazaar app execution completed!
pause

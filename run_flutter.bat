@echo off
echo Searching for Flutter...
echo.

REM Try common Flutter installation paths
if exist "C:\Users\amanr\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" (
    echo Found Flutter in Downloads
    call "C:\Users\amanr\Downloads\flutter_windows_3.41.1-stable\flutter\bin\flutter.bat" %*
    goto :end
)

if exist "C:\flutter\bin\flutter.bat" (
    echo Found Flutter in C:\flutter
    call "C:\flutter\bin\flutter.bat" %*
    goto :end
)

if exist "C:\dev\flutter\bin\flutter.bat" (
    echo Found Flutter in C:\dev\flutter
    call "C:\dev\flutter\bin\flutter.bat" %*
    goto :end
)

echo Flutter not found in common locations.
echo Please install Flutter from: https://flutter.dev/docs/get-started/install/windows
echo.
pause

:end
echo Flutter command completed.

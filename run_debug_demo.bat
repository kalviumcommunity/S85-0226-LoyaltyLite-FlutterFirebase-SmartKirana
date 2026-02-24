@echo off
echo ========================================
echo 🔧 Flutter Debug Tools Demo
echo ========================================
echo.

echo 📋 Starting Flutter Debug Tools Demonstration...
echo.

echo 🚀 Running Debug Demo App...
echo 📱 This will demonstrate:
echo    • Hot Reload capabilities
echo    • Debug Console logging
echo    • Flutter DevTools integration
echo.

flutter run -d chrome --target=lib/main_debug_demo.dart

echo.
echo 🎯 Demo Instructions:
echo.
echo 1. 🔥 HOT RELOAD:
echo    - Modify code in lib/debug_demo_screen.dart
echo    - Save file (Ctrl+S) to see instant updates
echo    - Press 'r' in terminal for manual hot reload
echo.
echo 2. 💻 DEBUG CONSOLE:
echo    - Click buttons to see real-time logs
echo    - Check VS Code Debug Console or terminal
echo    - Watch for debugPrint() statements
echo.
echo 3. 🛠️ FLUTTER DEVTOOLS:
echo    - Run: flutter pub global run devtools
echo    - Open Widget Inspector to explore UI
echo    - Check Performance tab for frame analysis
echo    - Monitor Memory tab for usage patterns
echo.
echo 📚 For detailed instructions, see README_DEBUG_DEMO.md
echo.

pause

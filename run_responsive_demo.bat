@echo off
echo ========================================
echo 📱 Responsive Layout Design Demo
echo ========================================
echo.

echo 🎯 Features Demonstrated:
echo    • Container widget with padding, margin, and styling
echo    • Row widget for horizontal layouts
echo    • Column widget for vertical layouts
echo    • MediaQuery for responsive design
echo    • Expanded widgets for flexible layouts
echo    • Responsive design for phone vs tablet
echo    • Landscape vs portrait orientation
echo    • Working buttons with feedback
echo.

echo 📱 Testing Instructions:
echo    • Try rotating your device (Ctrl+Shift+R in Chrome)
echo    • Resize browser window to see responsive behavior
echo    • Test on different screen sizes
echo    • Click all buttons to verify they work
echo.

echo 🚀 Starting Responsive Layout Demo...
echo.

flutter run -d chrome --target=lib/main_responsive_demo.dart

echo.
echo 🎉 Demo Complete!
echo.
echo 📸 Take screenshots of:
echo    • Phone layout (small screen)
echo    • Tablet layout (large screen)
echo    • Landscape orientation
echo    • Portrait orientation
echo.
echo 🔧 All buttons should show SnackBar feedback
echo.

pause

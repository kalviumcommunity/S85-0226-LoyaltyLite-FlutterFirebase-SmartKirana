@echo off
echo ========================================
echo 📱 Responsive Design Demo - MediaQuery & LayoutBuilder
echo ========================================
echo.

echo 🎯 Responsive Features Demonstrated:
echo    • MediaQuery for screen dimensions
echo    • LayoutBuilder for conditional layouts
echo    • Mobile layout (< 600px width)
echo    • Tablet layout (600px - 1200px width)
echo    • Desktop layout (> 1200px width)
echo    • Orientation-aware designs
echo    • Responsive typography and spacing
echo    • Adaptive component sizing
echo.

echo 📱 Screen Layouts:
echo    • Dashboard: Multi-panel responsive layout
echo    • Products: Grid with sidebar filters
echo    • Forms: Multi-column form layouts
echo    • All screens adapt to screen size
echo.

echo 🚀 Starting Responsive Design Demo...
echo.

flutter run -d chrome --target=lib/main_responsive_design_demo.dart

echo.
echo 🎉 Demo Complete!
echo.
echo 📸 Test Responsiveness:
echo    • Resize browser window to see layout changes
echo    • Test on mobile (width < 600px)
echo    • Test on tablet (600px - 1200px)
echo    • Test on desktop (> 1200px)
echo    • Rotate device to test orientation
echo    • Check text scaling and spacing
echo.

pause

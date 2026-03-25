import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _dynamicColorKey = 'dynamic_color';
  
  ThemeMode _themeMode = ThemeMode.system;
  Color _dynamicColor = const Color(0xFF6750A4); // Default purple
  
  ThemeMode get themeMode => _themeMode;
  Color get dynamicColor => _dynamicColor;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  ThemeProvider() {
    _loadThemeFromPreferences();
  }

  // Load saved theme preferences
  Future<void> _loadThemeFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeIndex = prefs.getInt(_themeKey) ?? 2; // Default to system
      final savedColorValue = prefs.getString(_dynamicColorKey);
      
      _themeMode = ThemeMode.values[savedThemeIndex];
      if (savedColorValue != null) {
        _dynamicColor = Color(int.parse(savedColorValue));
      }
      
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading theme preferences: $e');
    }
  }

  // Save theme preferences
  Future<void> _saveThemeToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, _themeMode.index);
      await prefs.setString(_dynamicColorKey, _dynamicColor.value.toString());
    } catch (e) {
      debugPrint('Error saving theme preferences: $e');
    }
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
    }
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Set to system theme
  void setSystemTheme() {
    _themeMode = ThemeMode.system;
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Update dynamic color
  void updateDynamicColor(Color color) {
    _dynamicColor = color;
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Reset to default theme
  void resetToDefault() {
    _themeMode = ThemeMode.system;
    _dynamicColor = const Color(0xFF6750A4);
    _saveThemeToPreferences();
    notifyListeners();
  }

  // Get theme mode name for display
  String get themeModeName {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
    return 'System';
  }

  // Get available theme options
  List<ThemeMode> get availableThemes => ThemeMode.values;

  // Predefined color options
  static const List<Color> colorOptions = [
    Color(0xFF6750A4), // Deep Purple
    Color(0xFF2196F3), // Blue
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFFE91E63), // Red
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Light Blue
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
  ];

  // Get color name for display
  static String getColorName(Color color) {
    final index = colorOptions.indexOf(color);
    if (index != -1) {
      const names = [
        'Deep Purple', 'Blue', 'Green', 'Orange', 
        'Red', 'Purple', 'Light Blue', 'Brown', 'Blue Grey'
      ];
      return names[index];
    }
    return 'Custom';
  }
}

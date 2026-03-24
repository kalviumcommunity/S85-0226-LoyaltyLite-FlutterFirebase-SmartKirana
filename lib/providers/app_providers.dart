import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Counter State Provider
class CounterProvider extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
  
  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
  
  void reset() {
    _count = 0;
    notifyListeners();
  }
}

// Favorites State Provider
class FavoritesProvider extends ChangeNotifier {
  final List<String> _items = [];
  
  List<String> get items => List.unmodifiable(_items);
  
  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }
  
  void removeItem(String item) {
    _items.remove(item);
    notifyListeners();
  }
  
  void clearFavorites() {
    _items.clear();
    notifyListeners();
  }
  
  bool isFavorite(String item) {
    return _items.contains(item);
  }
}

// User State Provider
class UserProvider extends ChangeNotifier {
  String _name = '';
  String _email = '';
  bool _isLoggedIn = false;
  
  String get name => _name;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;
  
  void setUser(String name, String email) {
    _name = name;
    _email = email;
    _isLoggedIn = true;
    notifyListeners();
  }
  
  void logout() {
    _name = '';
    _email = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}

// Theme State Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  
  ThemeMode get themeMode => _themeMode;
  
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    notifyListeners();
  }
  
  void setTheme(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

// Settings State Provider
class SettingsProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  double _fontSize = 14.0;
  
  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkMode => _darkMode;
  double get fontSize => _fontSize;
  
  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }
  
  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
  
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }
}

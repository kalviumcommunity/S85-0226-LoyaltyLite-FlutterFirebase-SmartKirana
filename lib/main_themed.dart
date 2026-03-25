import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'providers/theme_provider.dart';
import 'themes/app_theme.dart';
import 'screens/themed_demo_screen.dart';
import 'screens/theme_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const ThemedApp(),
    ),
  );
}

class ThemedApp extends StatelessWidget {
  const ThemedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Smart Kirana - Themed UI',
          debugShowCheckedModeBanner: false,
          theme: _buildDynamicTheme(themeProvider, Brightness.light),
          darkTheme: _buildDynamicTheme(themeProvider, Brightness.dark),
          themeMode: themeProvider.themeMode,
          home: const ThemedDemoScreen(),
        );
      },
    );
  }

  // Build theme with dynamic color
  ThemeData _buildDynamicTheme(ThemeProvider themeProvider, Brightness brightness) {
    final baseTheme = brightness == Brightness.dark 
        ? AppTheme.darkTheme 
        : AppTheme.lightTheme;
    
    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeProvider.dynamicColor,
        brightness: brightness,
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: brightness == Brightness.dark 
            ? Colors.grey.shade900 
            : themeProvider.dynamicColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeProvider.dynamicColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}

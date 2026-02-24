import 'package:flutter/material.dart';
import 'debug_demo_screen.dart';

void main() {
  runApp(const DebugDemoApp());
}

class DebugDemoApp extends StatelessWidget {
  const DebugDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This will help with DevTools Widget Inspector
    debugPrint('Building DebugDemoApp');
    
    return MaterialApp(
      title: '🔧 Flutter Debug Tools Demo',
      debugShowCheckedModeBanner: true, // Keep this for debug mode
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const DebugDemoScreen(),
    );
  }
}

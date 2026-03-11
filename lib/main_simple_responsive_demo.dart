import 'package:flutter/material.dart';
import 'screens/simple_responsive_home.dart';

void main() {
  runApp(const SimpleResponsiveDemoApp());
}

class SimpleResponsiveDemoApp extends StatelessWidget {
  const SimpleResponsiveDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '📱 Responsive Design Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SimpleResponsiveHome(),
    );
  }
}

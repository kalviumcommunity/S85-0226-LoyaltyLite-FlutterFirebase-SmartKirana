import 'package:flutter/material.dart';
import 'screens/responsive_fixed_home.dart';

void main() {
  runApp(const ResponsiveFixedDemoApp());
}

class ResponsiveFixedDemoApp extends StatelessWidget {
  const ResponsiveFixedDemoApp({Key? key}) : super(key: key);

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
      home: const ResponsiveFixedHome(),
    );
  }
}

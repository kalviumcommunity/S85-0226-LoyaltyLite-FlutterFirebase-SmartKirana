import 'package:flutter/material.dart';
import 'responsive_layout.dart';

void main() {
  runApp(const ResponsiveDemoApp());
}

class ResponsiveDemoApp extends StatelessWidget {
  const ResponsiveDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '📱 Responsive Layout Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const ResponsiveLayout(),
    );
  }
}

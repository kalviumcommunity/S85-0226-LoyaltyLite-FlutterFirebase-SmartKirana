import 'package:flutter/material.dart';
import 'screens/scrollable_views.dart';

void main() {
  runApp(const ScrollableDemoApp());
}


class ScrollableDemoApp extends StatelessWidget {
  const ScrollableDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      title: '📱 Scrollable Views Demo',
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
      home: const ScrollableViews(),
    );
  }
}

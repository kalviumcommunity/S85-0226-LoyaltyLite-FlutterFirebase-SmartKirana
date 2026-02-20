import 'package:flutter/material.dart';
import 'screens/widget_tree_demo.dart';

void main() {
  runApp(const WidgetTreeApp());
}

class WidgetTreeApp extends StatelessWidget {
  const WidgetTreeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Root of the widget tree - MaterialApp
    return MaterialApp(
      title: 'Widget Tree & Reactive UI Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const WidgetTreeDemo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

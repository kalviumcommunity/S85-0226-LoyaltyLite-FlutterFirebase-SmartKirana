import 'package:flutter/material.dart';
import 'lib/screens/state_management_demo.dart';

void main() {
  runApp(const StateManagementApp());
}

class StateManagementApp extends StatelessWidget {
  const StateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StateManagementDemo(),
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/firebase_demo_simple.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FirebaseSimpleDemoApp());
}

class FirebaseSimpleDemoApp extends StatelessWidget {
  const FirebaseSimpleDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🔥 Firebase Integration Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const FirebaseSimpleDemo(),
    );
  }
}

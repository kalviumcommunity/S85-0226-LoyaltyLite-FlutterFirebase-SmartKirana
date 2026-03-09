import 'package:flutter/material.dart';
import 'screens/widget_demo_home.dart';
import 'screens/widget_demo_products.dart';
import 'screens/widget_demo_services.dart';

void main() {
  runApp(const CustomWidgetsDemoApp());
}

class CustomWidgetsDemoApp extends StatelessWidget {
  const CustomWidgetsDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🧩 Custom Widgets Demo',
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
      initialRoute: '/',
      routes: {
        '/': (context) => const WidgetDemoHome(),
        '/products': (context) => const WidgetDemoProducts(),
        '/services': (context) => const WidgetDemoServices(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Page not found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The page you are looking for does not exist.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              icon: const Icon(Icons.home),
              label: const Text('Go Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

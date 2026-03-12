import 'package:flutter/material.dart';

void main() {
  runApp(const BasicResponsiveDemoApp());
}

class BasicResponsiveDemoApp extends StatelessWidget {
  const BasicResponsiveDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Responsive Demo',
      debugShowCheckedModeBanner: false,
      home: const BasicResponsiveHome(),
    );
  }
}

class BasicResponsiveHome extends StatelessWidget {
  const BasicResponsiveHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Responsive - Width: ${screenWidth.toStringAsFixed(0)}px'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: screenWidth < 600 ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: screenWidth < 600 ? Colors.red : Colors.green),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                screenWidth < 600 ? Icons.phone_android : Icons.desktop_mac,
                size: 80,
                color: screenWidth < 600 ? Colors.red : Colors.green,
              ),
              const SizedBox(height: 20),
              Text(
                screenWidth < 600 ? 'Mobile Layout' : 'Desktop Layout',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: screenWidth < 600 ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Screen width: ${screenWidth.toStringAsFixed(0)}px',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${screenWidth < 600 ? 'Mobile' : 'Desktop'} button pressed!'),
                      backgroundColor: screenWidth < 600 ? Colors.red : Colors.green,
                    ),
                  );
                },
                child: Text('${screenWidth < 600 ? 'Mobile' : 'Desktop'} Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const WorkingResponsiveDemoApp());
}

class WorkingResponsiveDemoApp extends StatelessWidget {
  const WorkingResponsiveDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      debugShowCheckedModeBanner: false,
      home: const WorkingResponsiveHome(),
    );
  }
}

class WorkingResponsiveHome extends StatelessWidget {
  const WorkingResponsiveHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Demo - Width: ${screenWidth.toStringAsFixed(0)}px'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          print('LayoutBuilder maxWidth: ${constraints.maxWidth}');
          
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout();
          } else {
            return _buildDesktopLayout();
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      color: Colors.red.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_android, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text(
              'Mobile Layout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Screen width < 600px',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Mobile button pressed');
              },
              child: Text('Mobile Button'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      color: Colors.green.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.desktop_mac, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Desktop Layout',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Screen width >= 600px',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Desktop button pressed');
              },
              child: Text('Desktop Button'),
            ),
          ],
        ),
      ),
    );
  }
}

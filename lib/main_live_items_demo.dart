import 'package:flutter/material.dart';

import 'screens/live_items_viewer_screen.dart';

void main() {
  runApp(const LiveItemsDemoApp());
}

class LiveItemsDemoApp extends StatelessWidget {
  const LiveItemsDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Items Viewer Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LiveItemsViewerScreen(),
    );
  }
}

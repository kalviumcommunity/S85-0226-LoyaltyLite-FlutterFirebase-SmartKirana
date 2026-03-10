import 'package:flutter/material.dart';

class ResponsiveDemoHome extends StatelessWidget {
  const ResponsiveDemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final columns = width < 600 ? 1 : (width < 1000 ? 2 : 3);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Demo Home')),
      body: GridView.count(
        crossAxisCount: columns,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: List.generate(6, (index) {
          return Card(
            child: Center(
              child: Text('Section ${index + 1}'),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ResponsiveSimpleHome extends StatelessWidget {
  const ResponsiveSimpleHome({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 700;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Simple Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isWide
            ? Row(
                children: const [
                  Expanded(child: _Panel(title: 'Overview')),
                  SizedBox(width: 12),
                  Expanded(child: _Panel(title: 'Actions')),
                ],
              )
            : const Column(
                children: [
                  Expanded(child: _Panel(title: 'Overview')),
                  SizedBox(height: 12),
                  Expanded(child: _Panel(title: 'Actions')),
                ],
              ),
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const LoyalBazaarApp());
}

class LoyalBazaarApp extends StatelessWidget {
  const LoyalBazaarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoyalBazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SimpleDashboard(),
    );
  }
}

class SimpleDashboard extends StatelessWidget {
  const SimpleDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoyalBazaar Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _InfoCard(title: 'Total Customers', value: '1,234', icon: Icons.people),
          SizedBox(height: 12),
          _InfoCard(title: "Today's Revenue", value: 'Rs 12,450', icon: Icons.currency_rupee),
          SizedBox(height: 12),
          _InfoCard(title: 'Active Rewards', value: '8', icon: Icons.card_giftcard),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value, required this.icon});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }
}

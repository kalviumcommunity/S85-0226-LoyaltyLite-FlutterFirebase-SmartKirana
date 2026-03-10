import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'asset_demo_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key, required this.user});

  final User user;
  final AuthService _authService = AuthService();

  Future<void> _logout(BuildContext context) async {
    await _authService.logout();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartKirana Dashboard'),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Welcome'),
              subtitle: Text(user.email ?? 'Shop Owner'),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text('Total Customers'),
              trailing: Text('1,234'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.currency_rupee, color: Colors.green),
              title: Text("Today's Revenue"),
              trailing: Text('12,450'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.card_giftcard, color: Colors.orange),
              title: Text('Active Rewards'),
              trailing: Text('8'),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AssetDemoScreen()),
              );
            },
            icon: const Icon(Icons.image),
            label: const Text('Open Assets Demo'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMobile ? 'Mobile Layout' : (isTablet ? 'Tablet Layout' : 'Desktop Layout'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: const [
                  _DashboardCard(title: 'Revenue', value: 'Rs 45,678', icon: Icons.currency_rupee),
                  _DashboardCard(title: 'Customers', value: '1,234', icon: Icons.people),
                  _DashboardCard(title: 'Orders', value: '346', icon: Icons.shopping_cart),
                  _DashboardCard(title: 'Growth', value: '+23%', icon: Icons.trending_up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.title, required this.value, required this.icon});

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            const Spacer(),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(title),
          ],
        ),
      ),
    );
  }
}

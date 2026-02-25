import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 Responsive Layout Design'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: isLandscape ? 80 : 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Icon(
                      Icons.devices,
                      size: isTablet ? 32 : 24,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'Responsive Layout Demo',
                        style: TextStyle(
                          fontSize: isTablet ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'Screen: ${screenWidth.toStringAsFixed(0)} x ${screenHeight.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: isTablet ? 12 : 10,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Main Content Area
            Expanded(
              child: isTablet || isLandscape
                  ? _buildTabletLayout(isTablet)
                  : _buildPhoneLayout(),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom Action Bar
            Container(
              width: double.infinity,
              height: isLandscape ? 60 : 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(Icons.home, 'Home', () {
                    _showSnackBar(context, 'Home button pressed! 🏠');
                  }),
                  _buildActionButton(Icons.search, 'Search', () {
                    _showSnackBar(context, 'Search button pressed! 🔍');
                  }),
                  _buildActionButton(Icons.favorite, 'Like', () {
                    _showSnackBar(context, 'Like button pressed! ❤️');
                  }),
                  _buildActionButton(Icons.share, 'Share', () {
                    _showSnackBar(context, 'Share button pressed! 📤');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Phone Layout (Vertical)
  Widget _buildPhoneLayout() {
    return Column(
      children: [
        // Stats Cards Row
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatCard('Sales', '₹45.6K', Icons.currency_rupee, Colors.green),
            ),
          ],
        ),
        
        const SizedBox(height: 8),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard('Orders', '892', Icons.shopping_cart, Colors.purple),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatCard('Rating', '4.8', Icons.star, Colors.orange),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Feature Cards
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  '🎨 Beautiful Design',
                  'Responsive layouts that adapt to any screen size',
                  Icons.palette,
                  Colors.pink,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _buildFeatureCard(
                  '⚡ High Performance',
                  'Optimized widgets for smooth user experience',
                  Icons.speed,
                  Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Tablet Layout (Horizontal)
  Widget _buildTabletLayout(bool isTablet) {
    return Row(
      children: [
        // Left Panel - Stats
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📊 Statistics',
                  style: TextStyle(
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildTabletStatItem('Total Users', '1,234', Icons.people, Colors.blue),
                _buildTabletStatItem('Revenue', '₹45.6K', Icons.currency_rupee, Colors.green),
                _buildTabletStatItem('Orders', '892', Icons.shopping_cart, Colors.purple),
                _buildTabletStatItem('Rating', '4.8/5.0', Icons.star, Colors.orange),
                const Spacer(),
                _buildTabletStatItem('Growth', '+23%', Icons.trending_up, Colors.red),
              ],
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        // Right Panel - Features
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Expanded(
                child: _buildFeatureCard(
                  '🎨 Beautiful Design',
                  'Responsive layouts that adapt to any screen size with smooth animations and transitions',
                  Icons.palette,
                  Colors.pink,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _buildFeatureCard(
                  '⚡ High Performance',
                  'Optimized widgets for smooth user experience across all devices',
                  Icons.speed,
                  Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _buildFeatureCard(
                  '🔒 Secure & Reliable',
                  'Enterprise-grade security with 99.9% uptime guarantee',
                  Icons.security,
                  Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletStatItem(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey.shade400,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.orange,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

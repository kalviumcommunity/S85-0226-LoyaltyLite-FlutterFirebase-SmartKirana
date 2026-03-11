import 'package:flutter/material.dart';

class ResponsiveFixedHome extends StatelessWidget {
  const ResponsiveFixedHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📱 Responsive Design Demo',
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 22,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          print('Constraints width: ${constraints.maxWidth}');
          print('Screen width: $screenWidth');
          
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(context, screenWidth, screenHeight);
          } else if (constraints.maxWidth < 1200) {
            return _buildTabletLayout(context, screenWidth, screenHeight);
          } else {
            return _buildDesktopLayout(context, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth, double screenHeight) {
    print('Building mobile layout');
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '📱 Mobile Layout',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenHeight * 0.02),
          
          // Stats Cards
          _buildStatsGrid(screenWidth, 2),
          SizedBox(height: screenHeight * 0.02),
          
          // Feature Cards
          _buildFeatureCards(screenWidth, 1),
          SizedBox(height: screenHeight * 0.02),
          
          // Action Buttons
          _buildActionButtons(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    print('Building tablet layout');
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.green.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '📱 Tablet Layout',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenHeight * 0.02),
          
          // Two Column Layout
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        '📊 Statistics',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildStatsGrid(screenWidth, 2),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        '📋 Activity',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildActivityList(screenWidth),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenHeight * 0.02),
          _buildActionButtons(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth, double screenHeight) {
    print('Building desktop layout');
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '🖥️ Desktop Layout',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenHeight * 0.02),
          
          // Three Column Layout
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '📊 Statistics',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildStatsGrid(screenWidth, 2),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '📈 Analytics',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildChartAreas(screenWidth),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '⚙️ Settings',
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildSettingsList(screenWidth),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenHeight * 0.02),
          _buildActionButtons(context, screenWidth),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(double screenWidth, int crossAxisCount) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: screenWidth * 0.03,
      mainAxisSpacing: screenWidth * 0.03,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Users', '1,234', Icons.people, Colors.blue, screenWidth),
        _buildStatCard('Revenue', '₹45.6K', Icons.currency_rupee, Colors.green, screenWidth),
        _buildStatCard('Orders', '892', Icons.shopping_cart, Colors.orange, screenWidth),
        _buildStatCard('Growth', '+23%', Icons.trending_up, Colors.purple, screenWidth),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: screenWidth < 600 ? 24 : 32),
          SizedBox(height: screenWidth * 0.02),
          Text(
            value,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 16 : 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: screenWidth * 0.01),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 12 : 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCards(double screenWidth, int crossAxisCount) {
    final List<Map<String, dynamic>> features = [
      {'title': 'Responsive Design', 'icon': Icons.devices, 'color': Colors.blue},
      {'title': 'MediaQuery Usage', 'icon': Icons.straighten, 'color': Colors.green},
      {'title': 'Layout Builder', 'icon': Icons.view_quilt, 'color': Colors.orange},
      {'title': 'Cross Platform', 'icon': Icons.devices_other, 'color': Colors.purple},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: screenWidth * 0.03,
      mainAxisSpacing: screenWidth * 0.03,
      childAspectRatio: 1.2,
      children: features.map((feature) {
        return _buildFeatureCard(
          feature['title'] as String,
          feature['icon'] as IconData,
          feature['color'] as Color,
          screenWidth,
        );
      }).toList(),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon, Color color, double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: screenWidth < 600 ? 32 : 48),
          SizedBox(height: screenWidth * 0.02),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList(double screenWidth) {
    final List<String> activities = [
      'New user registered',
      'Order completed',
      'Payment received',
      'Report generated',
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Icon(Icons.notifications, color: Colors.blue, size: screenWidth < 600 ? 16 : 20),
          ),
          title: Text(
            activities[index],
            style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16),
          ),
        );
      },
    );
  }

  Widget _buildChartAreas(double screenWidth) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_chart, color: Colors.green, size: screenWidth < 600 ? 32 : 48),
                  SizedBox(height: screenWidth * 0.02),
                  Text('Revenue Chart', style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.02),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pie_chart, color: Colors.orange, size: screenWidth < 600 ? 32 : 48),
                  SizedBox(height: screenWidth * 0.02),
                  Text('Sales Distribution', style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsList(double screenWidth) {
    final List<String> settings = [
      'Display Settings',
      'Notification Preferences',
      'Account Settings',
      'Privacy & Security',
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: settings.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.settings, color: Colors.grey, size: screenWidth < 600 ? 16 : 20),
          title: Text(
            settings[index],
            style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Primary action pressed! 🔥'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.all(screenWidth * 0.03),
            ),
            child: Text(
              'Primary Action',
              style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16),
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Secondary action pressed! ⚡'),
                  backgroundColor: Colors.grey,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey,
              side: BorderSide(color: Colors.grey),
              padding: EdgeInsets.all(screenWidth * 0.03),
            ),
            child: Text(
              'Secondary Action',
              style: TextStyle(fontSize: screenWidth < 600 ? 14 : 16),
            ),
          ),
        ),
      ],
    );
  }
}

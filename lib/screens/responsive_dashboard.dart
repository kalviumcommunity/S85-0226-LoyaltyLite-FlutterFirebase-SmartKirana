import 'package:flutter/material.dart';

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📱 Responsive Dashboard',
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 22,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              orientation == Orientation.landscape ? Icons.portrait_up : Icons.landscape,
              size: screenWidth < 600 ? 20 : 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Orientation: ${orientation.toString().split('.').last} 🔄'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile Layout
            return _buildMobileLayout(context, screenWidth, screenHeight);
          } else if (constraints.maxWidth < 1200) {
            // Tablet Layout
            return _buildTabletLayout(context, screenWidth, screenHeight);
          } else {
            // Desktop Layout
            return _buildDesktopLayout(context, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth, double screenHeight) {
    final isMobile = screenWidth < 600;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Stats
          _buildHeaderStats(screenWidth, true),
          SizedBox(height: screenHeight * 0.02),
          
          // Quick Actions
          _buildQuickActions(screenWidth, true),
          SizedBox(height: screenHeight * 0.02),
          
          // Charts Section
          _buildChartsSection(screenWidth, screenHeight, true),
          SizedBox(height: screenHeight * 0.02),
          
          // Recent Activity
          _buildRecentActivity(screenWidth, true),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Column(
        children: [
          // Header with Stats
          _buildHeaderStats(screenWidth, false),
          SizedBox(height: screenHeight * 0.02),
          
          // Main Content Area
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Charts Section (Left)
                Expanded(
                  flex: 3,
                  child: _buildChartsSection(screenWidth, screenHeight, false),
                ),
                SizedBox(width: screenWidth * 0.02),
                
                // Recent Activity (Right)
                Expanded(
                  flex: 2,
                  child: _buildRecentActivity(screenWidth, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02),
      child: Column(
        children: [
          // Header with Stats and Actions
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildHeaderStats(screenWidth, false),
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: _buildQuickActions(screenWidth, false),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          
          // Main Content Area
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Charts Section (Left)
                Expanded(
                  flex: 2,
                  child: _buildChartsSection(screenWidth, screenHeight, false),
                ),
                SizedBox(width: screenWidth * 0.02),
                
                // Recent Activity (Middle)
                Expanded(
                  flex: 1,
                  child: _buildRecentActivity(screenWidth, false),
                ),
                SizedBox(width: screenWidth * 0.02),
                
                // Additional Info (Right)
                Expanded(
                  flex: 1,
                  child: _buildAdditionalInfo(screenWidth, screenHeight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStats(double screenWidth, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 Dashboard Overview',
            style: TextStyle(
              fontSize: screenWidth < 600 ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          if (isMobile) ...[
            _buildStatRow('Total Revenue', '₹45,678', Icons.currency_rupee, screenWidth),
            _buildStatRow('Active Users', '1,234', Icons.people, screenWidth),
            _buildStatRow('Growth Rate', '+23%', Icons.trending_up, screenWidth),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Revenue', '₹45,678', Icons.currency_rupee, screenWidth),
                _buildStatItem('Active Users', '1,234', Icons.people, screenWidth),
                _buildStatItem('Growth Rate', '+23%', Icons.trending_up, screenWidth),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8), size: screenWidth < 600 ? 20 : 24),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 18 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 12 : 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, double screenWidth) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: screenWidth < 600 ? 24 : 32),
        SizedBox(height: screenWidth * 0.01),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 12 : 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(double screenWidth, bool isMobile) {
    if (isMobile) {
      // Mobile: Horizontal scroll
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚡ Quick Actions',
            style: TextStyle(
              fontSize: screenWidth < 600 ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          SizedBox(
            height: screenWidth * 0.25,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildActionCard('Add User', Icons.person_add, Colors.green, screenWidth),
                _buildActionCard('New Order', Icons.shopping_cart, Colors.orange, screenWidth),
                _buildActionCard('Generate Report', Icons.assessment, Colors.purple, screenWidth),
                _buildActionCard('Settings', Icons.settings, Colors.grey, screenWidth),
              ],
            ),
          ),
        ],
      );
    } else {
      // Tablet/Desktop: Grid layout
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚡ Quick Actions',
            style: TextStyle(
              fontSize: screenWidth < 600 ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            crossAxisSpacing: screenWidth * 0.02,
            mainAxisSpacing: screenWidth * 0.02,
            childAspectRatio: 1.2,
            children: [
              _buildActionCard('Add User', Icons.person_add, Colors.green, screenWidth),
              _buildActionCard('New Order', Icons.shopping_cart, Colors.orange, screenWidth),
              _buildActionCard('Generate Report', Icons.assessment, Colors.purple, screenWidth),
              _buildActionCard('Settings', Icons.settings, Colors.grey, screenWidth),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildActionCard(String title, IconData icon, Color color, double screenWidth) {
    return Container(
      width: screenWidth < 600 ? screenWidth * 0.35 : null,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {
          // Handle action
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: screenWidth < 600 ? 24 : 32),
              SizedBox(height: screenWidth * 0.02),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartsSection(double screenWidth, double screenHeight, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          
          // Chart Areas
          if (isMobile) ...[
            _buildChartArea('Revenue Trend', Colors.green, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildChartArea('User Growth', Colors.blue, screenWidth, screenHeight),
          ] else ...[
            Expanded(
              child: _buildChartArea('Revenue Trend', Colors.green, screenWidth, screenHeight),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: _buildChartArea('User Growth', Colors.blue, screenWidth, screenHeight),
            ),
          ],
          ],
        ],
      ],
    ),
    );
  }

  Widget _buildChartArea(String title, Color color, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      height: isMobile ? screenHeight * 0.15 : double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth < 600 ? 14 : 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Icon(
                Icons.insert_chart,
                color: color.withOpacity(0.5),
                size: screenWidth < 600 ? 32 : 48,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity(double screenWidth, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 Recent Activity',
            style: TextStyle(
              fontSize: screenWidth < 600 ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          
          // Activity List
          Expanded(
            child: ListView(
              children: [
                _buildActivityItem('New user registered', 'John Doe', Icons.person_add, Colors.green, screenWidth),
                _buildActivityItem('Order completed', 'Order #1234', Icons.check_circle, Colors.blue, screenWidth),
                _buildActivityItem('Payment received', '₹1,234', Icons.currency_rupee, Colors.orange, screenWidth),
                _buildActivityItem('Report generated', 'Monthly Report', Icons.assessment, Colors.purple, screenWidth),
                _buildActivityItem('System update', 'Version 2.0.1', Icons.system_update, Colors.grey, screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String subtitle, IconData icon, Color color, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        children: [
          Container(
            width: screenWidth < 600 ? 40 : 48,
            height: screenWidth < 600 ? 40 : 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: screenWidth < 600 ? 20 : 24),
          ),
          SizedBox(width: screenWidth * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 12 : 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ℹ️ System Info',
            style: TextStyle(
              fontSize: screenWidth < 600 ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          
          // System Info Items
          _buildInfoItem('App Version', '2.0.1', screenWidth),
          _buildInfoItem('Last Backup', '2 hours ago', screenWidth),
          _buildInfoItem('Storage Used', '45.2 GB', screenWidth),
          _buildInfoItem('Uptime', '99.9%', screenWidth),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 14 : 16,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: screenWidth < 600 ? 14 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

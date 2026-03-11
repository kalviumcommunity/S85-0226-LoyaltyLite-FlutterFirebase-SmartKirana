import 'package:flutter/material.dart';

class SimpleResponsiveHome extends StatelessWidget {
  const SimpleResponsiveHome({Key? key}) : super(key: key);

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
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(context, screenWidth, screenHeight);
          } else {
            return _buildDesktopLayout(context, screenWidth, screenHeight);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Stats Cards
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
              _buildStatCard('Revenue', '₹45.6K', Icons.currency_rupee, Colors.green),
              _buildStatCard('Orders', '892', Icons.shopping_cart, Colors.orange),
              _buildStatCard('Growth', '+23%', Icons.trending_up, Colors.purple),
            ],
          ),
          
          SizedBox(height: 20),
          
          // Action Buttons
          Row(
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
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text('Primary Action'),
                ),
              ),
              SizedBox(width: 16),
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
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text('Secondary Action'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Header Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
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
                  '🖥️ Desktop Layout',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                          children: [
                            _buildStatCard('Users', '1,234', Icons.people, Colors.blue),
                            _buildStatCard('Revenue', '₹45.6K', Icons.currency_rupee, Colors.green),
                            _buildStatCard('Orders', '892', Icons.shopping_cart, Colors.orange),
                            _buildStatCard('Growth', '+23%', Icons.trending_up, Colors.purple),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        '📋 Activity',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.1),
                                child: Icon(Icons.notifications, color: Colors.blue),
                              ),
                              title: Text('New user registered'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green.withOpacity(0.1),
                                child: Icon(Icons.check_circle, color: Colors.green),
                              ),
                              title: Text('Order completed'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.orange.withOpacity(0.1),
                                child: Icon(Icons.currency_rupee, color: Colors.orange),
                              ),
                              title: Text('Payment received'),
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.purple.withOpacity(0.1),
                                child: Icon(Icons.assessment, color: Colors.purple),
                              ),
                              title: Text('Report generated'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Action Buttons
          Row(
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
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text('Primary Action'),
                ),
              ),
              SizedBox(width: 16),
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
                    padding: EdgeInsets.all(16),
                  ),
                  child: Text('Secondary Action'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

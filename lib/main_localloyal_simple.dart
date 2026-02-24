import 'package:flutter/material.dart';
import 'services/whatsapp_service_fixed.dart';
import 'services/role_service_fixed.dart';

void main() {
  runApp(const LocalLoyalApp());
}

class LocalLoyalApp extends StatelessWidget {
  const LocalLoyalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '💳 LocalLoyal - Modern Loyalty System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const LocalLoyalDashboard(),
    );
  }
}

class LocalLoyalDashboard extends StatefulWidget {
  const LocalLoyalDashboard({Key? key}) : super(key: key);

  @override
  State<LocalLoyalDashboard> createState() => _LocalLoyalDashboardState();
}

class _LocalLoyalDashboardState extends State<LocalLoyalDashboard> {
  int _currentIndex = 0;
  UserRole? _currentUserRole;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const CustomersScreen(),
    const RewardsScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserRole();
  }

  Future<void> _initializeUserRole() async {
    final role = await RoleService.getCurrentRole();
    setState(() {
      _currentUserRole = role ?? UserRole.shopOwner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '💳 LocalLoyal',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _sendWhatsAppNotification,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _sendWhatsAppNotification() async {
    final success = await WhatsAppService.sendWelcomeMessage(
      customerPhone: '+919876543210',
      shopName: 'LocalLoyal Store',
      customerName: 'Ramesh Kumar',
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? 'WhatsApp notification sent! 📱' : 'Failed to send notification'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  void _logout() async {
    await RoleService.clearRoleData();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged out successfully'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back! 👋',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your shop is performing great today!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Quick Stats
          const Text(
            '📊 Quick Stats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Total Customers', '1,234', Icons.people, Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Today\'s Revenue', '₹12,450', Icons.currency_rupee, Colors.green),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Active Rewards', '8', Icons.card_giftcard, Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Repeat Rate', '78%', Icons.trending_up, Colors.orange),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          const Text(
            '⚡ Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildActionButton('Add Customer', Icons.person_add, () {
                  _showAddCustomerDialog(context);
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton('Create Reward', Icons.card_giftcard, () {
                  _showCreateRewardDialog(context);
                }),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildActionButton('Send WhatsApp', Icons.message, () {
                  _sendBulkWhatsApp(context);
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionButton('View Analytics', Icons.analytics, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening analytics... 📊'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Recent Activity
          const Text(
            '📋 Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildActivityCard('Ramesh Kumar earned 25 points', '2 minutes ago', Icons.add_circle, Colors.green),
          _buildActivityCard('Priya redeemed free tea reward', '15 minutes ago', Icons.card_giftcard, Colors.purple),
          _buildActivityCard('New customer Amit registered', '1 hour ago', Icons.person_add, Colors.blue),
          _buildActivityCard('₹500 purchase completed', '2 hours ago', Icons.shopping_cart, Colors.orange),
        ],
      ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildActionButton(String title, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: Colors.orange),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, String time, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  time,
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

  void _showAddCustomerDialog(BuildContext context) {
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await WhatsAppService.sendWelcomeMessage(
                customerPhone: phoneController.text,
                shopName: 'LocalLoyal Store',
                customerName: nameController.text,
              );
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'Customer added and WhatsApp sent! 🎉' : 'Customer added!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Add Customer'),
          ),
        ],
      ),
    );
  }

  void _showCreateRewardDialog(BuildContext context) {
    final nameController = TextEditingController();
    final pointsController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Reward'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Reward Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pointsController,
              decoration: const InputDecoration(
                labelText: 'Points Required',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reward created successfully! 🎁'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Create Reward'),
          ),
        ],
      ),
    );
  }

  void _sendBulkWhatsApp(BuildContext context) async {
    final customers = ['+919876543210', '+919876543211', '+919876543212'];
    final message = '🎉 Special offer for our loyal customers! Visit us today for exclusive rewards!';
    
    final result = await WhatsAppService.sendBulkMessages(
      phoneNumbers: customers,
      message: message,
    );
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bulk WhatsApp sent: ${result['success']} successful, ${result['failure']} failed'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.orange),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Customer List
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final customers = [
                    {'name': 'Ramesh Kumar', 'phone': '+91 9876543210', 'points': '450', 'visits': '23'},
                    {'name': 'Priya Sharma', 'phone': '+91 9876543211', 'points': '320', 'visits': '18'},
                    {'name': 'Amit Patel', 'phone': '+91 9876543212', 'points': '680', 'visits': '31'},
                    {'name': 'Sunita Devi', 'phone': '+91 9876543213', 'points': '210', 'visits': '12'},
                    {'name': 'Rahul Verma', 'phone': '+91 9876543214', 'points': '890', 'visits': '45'},
                  ];
                  
                  final customer = customers[index];
                  return _buildCustomerCard(customer);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCustomerDialog();
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, String> customer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange.withOpacity(0.1),
                child: const Icon(Icons.person, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      customer['phone']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  _handleCustomerAction(value, customer);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'send_whatsapp',
                    child: Row(
                      children: [
                        Icon(Icons.message, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Send WhatsApp'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'add_points',
                    child: Row(
                      children: [
                        Icon(Icons.add_circle, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Add Points'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'view_history',
                    child: Row(
                      children: [
                        Icon(Icons.history, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('View History'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMiniStat('Points', customer['points']!, Colors.orange),
              _buildMiniStat('Visits', customer['visits']!, Colors.blue),
              _buildMiniStat('Status', 'Active', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _showAddCustomerDialog() {
    final phoneController = TextEditingController();
    final nameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Customer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final success = await WhatsAppService.sendWelcomeMessage(
                customerPhone: phoneController.text,
                shopName: 'LocalLoyal Store',
                customerName: nameController.text,
              );
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'Customer added and WhatsApp sent! 🎉' : 'Customer added!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Add Customer'),
          ),
        ],
      ),
    );
  }

  void _handleCustomerAction(String action, Map<String, String> customer) {
    switch (action) {
      case 'send_whatsapp':
        WhatsAppService.sendPointsEarnedNotification(
          customerPhone: customer['phone']!,
          customerName: customer['name']!,
          pointsEarned: 25,
          totalPoints: int.parse(customer['points']!) + 25,
          shopName: 'LocalLoyal Store',
          purchaseAmount: 250,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('WhatsApp notification sent! 📱'),
            backgroundColor: Colors.green,
          ),
        );
        break;
      case 'add_points':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Points added successfully! ⭐'),
            backgroundColor: Colors.orange,
          ),
        );
        break;
      case 'view_history':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening customer history... 📊'),
            backgroundColor: Colors.blue,
          ),
        );
        break;
    }
  }
}

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Points Balance
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Points',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      '450',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Rewards List
          const Text(
            '🎁 Available Rewards',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                final rewards = [
                  {'name': 'Free Tea', 'points': '50', 'description': 'Get a free cup of tea'},
                  {'name': '10% Off', 'points': '100', 'description': 'Get 10% discount'},
                  {'name': 'Free Snack', 'points': '150', 'description': 'Choose any snack'},
                  {'name': '₹50 Cashback', 'points': '200', 'description': 'Get ₹50 cashback'},
                  {'name': 'Free Coffee', 'points': '80', 'description': 'Premium coffee'},
                  {'name': '20% Off', 'points': '250', 'description': 'On selected items'},
                ];
                
                final reward = rewards[index];
                return _buildRewardCard(reward);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(Map<String, String> reward) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.card_giftcard,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reward['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        reward['description']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${reward['points']} pts',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        await WhatsAppService.sendRewardUnlockedNotification(
                          customerPhone: '+919876543210',
                          customerName: 'Ramesh Kumar',
                          rewardName: reward['name']!,
                          rewardDescription: reward['description']!,
                          shopName: 'LocalLoyal Store',
                        );
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Reward redeemed successfully! 🎉'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Redeem'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Revenue Overview
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Revenue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  '₹87,450',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '+12.5% from last month',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Key Metrics
          const Text(
            '📊 Key Metrics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('Customers', '1,234', '+45', Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard('Transactions', '3,456', '+234', Colors.green),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(
                child: _buildMetricCard('Avg. Order', '₹25.30', '+₹2.10', Colors.purple),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildMetricCard('Repeat Rate', '78%', '+5%', Colors.orange),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Top Products
          const Text(
            '🏆 Top Selling Items',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final products = [
                  {'name': 'Tea', 'sales': '234', 'revenue': '₹2,340'},
                  {'name': 'Snacks', 'sales': '189', 'revenue': '₹3,780'},
                  {'name': 'Beverages', 'sales': '156', 'revenue': '₹2,340'},
                  {'name': 'Groceries', 'sales': '98', 'revenue': '₹4,900'},
                  {'name': 'Stationery', 'sales': '67', 'revenue': '₹1,340'},
                ];
                
                final product = products[index];
                return _buildProductItem(product, index + 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String change, Color color) {
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
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildProductItem(Map<String, String> product, int rank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${product['sales']} sales',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            product['revenue']!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Shop Info
          Container(
            padding: const EdgeInsets.all(20),
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
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.orange.withOpacity(0.1),
                  child: const Icon(
                    Icons.storefront,
                    size: 40,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'LocalLoyal Store',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  '+91 9876543210',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  'Delhi, India',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Settings Options
          const Text(
            '⚙️ Settings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSettingItem('WhatsApp Notifications', Icons.message, true, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('WhatsApp notifications enabled! 📱'),
                backgroundColor: Colors.green,
              ),
            );
          }),
          
          _buildSettingItem('Role-Based Access', Icons.admin_panel_settings, true, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Shop Owner role active! 👨‍💼'),
                backgroundColor: Colors.blue,
              ),
            );
          }),
          
          _buildSettingItem('Mobile-First UI', Icons.phone_android, true, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mobile-First UI enabled! 📱'),
                backgroundColor: Colors.purple,
              ),
            );
          }),
          
          _buildSettingItem('Analytics', Icons.analytics, false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Analytics feature coming soon! 📊'),
                backgroundColor: Colors.orange,
              ),
            );
          }),
          
          _buildSettingItem('Multi-Store Support', Icons.store, false, () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Multi-store support coming soon! 🏪'),
                backgroundColor: Colors.orange,
              ),
            );
          }),
          
          const SizedBox(height: 24),
          
          // Deployment Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: const Column(
              children: [
                Text(
                  '🚀 Deployment Ready',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Vercel + Render deployment configured',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '.env.example file created',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, IconData icon, bool enabled, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: enabled ? Colors.orange : Colors.grey),
        title: Text(title),
        trailing: Switch(
          value: enabled,
          onChanged: (value) {
            onTap();
          },
          activeColor: Colors.orange,
        ),
        onTap: onTap,
      ),
    );
  }
}

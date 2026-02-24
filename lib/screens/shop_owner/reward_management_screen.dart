import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RewardManagementScreen extends StatefulWidget {
  const RewardManagementScreen({Key? key}) : super(key: key);

  @override
  State<RewardManagementScreen> createState() => _RewardManagementScreenState();
}

class _RewardManagementScreenState extends State<RewardManagementScreen> {
  List<Map<String, dynamic>> _rewards = [
    {
      'id': '1',
      'name': 'Free Tea',
      'description': 'Get a free cup of tea on your next visit',
      'points': 50,
      'type': 'Free Item',
      'image': 'tea.png',
      'active': true,
    },
    {
      'id': '2',
      'name': '10% Off',
      'description': 'Get 10% discount on total bill',
      'points': 100,
      'type': 'Discount',
      'image': 'discount.png',
      'active': true,
    },
    {
      'id': '3',
      'name': 'Free Snack',
      'description': 'Choose any snack worth ₹50',
      'points': 150,
      'type': 'Free Item',
      'image': 'snack.png',
      'active': true,
    },
    {
      'id': '4',
      'name': '₹50 Cashback',
      'description': 'Get ₹50 cashback credited to your account',
      'points': 200,
      'type': 'Cashback',
      'image': 'cashback.png',
      'active': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reward Management',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddRewardDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard('Active Rewards', '3', Colors.green),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Total Redemptions', '127', Colors.blue),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Avg. Points', '125', Colors.orange),
                ),
              ],
            ),
          ),
          
          // Rewards list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _rewards.length,
              itemBuilder: (context, index) {
                final reward = _rewards[index];
                return _buildRewardCard(reward);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRewardDialog,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> reward) {
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
          // Header with image
          Container(
            height: 120,
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
            child: Center(
              child: Icon(
                _getRewardIcon(reward['type']),
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        reward['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: reward['active'] ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        reward['active'] ? 'Active' : 'Inactive',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  reward['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${reward['points']} points',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          reward['type'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () => _showRewardOptions(reward),
                        ),
                      ],
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

  IconData _getRewardIcon(String type) {
    switch (type) {
      case 'Free Item':
        return Icons.card_giftcard;
      case 'Discount':
        return Icons.percent;
      case 'Cashback':
        return Icons.currency_rupee;
      default:
        return Icons.card_giftcard;
    }
  }

  void _showAddRewardDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final pointsController = TextEditingController();
    String selectedType = 'Free Item';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Create New Reward',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Reward Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pointsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Points Required',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                labelText: 'Reward Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'Free Item', child: Text('Free Item')),
                DropdownMenuItem(value: 'Discount', child: Text('Discount')),
                DropdownMenuItem(value: 'Cashback', child: Text('Cashback')),
              ],
              onChanged: (value) {
                selectedType = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add reward logic here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reward created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Create Reward'),
          ),
        ],
      ),
    );
  }

  void _showRewardOptions(Map<String, dynamic> reward) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(reward['active'] ? Icons.pause : Icons.play_arrow),
              title: Text(reward['active'] ? 'Deactivate' : 'Activate'),
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  reward['active'] = !reward['active'];
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Reward'),
              onTap: () {
                Navigator.of(context).pop();
                // Edit reward logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('View Analytics'),
              onTap: () {
                Navigator.of(context).pop();
                // View analytics logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Reward', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                // Delete reward logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

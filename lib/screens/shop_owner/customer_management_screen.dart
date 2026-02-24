import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({Key? key}) : super(key: key);

  @override
  State<CustomerManagementScreen> createState() => _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  final _searchController = TextEditingController();
  List<Map<String, String>> _customers = [
    {'name': 'Ramesh Kumar', 'phone': '+91 9876543210', 'points': '450', 'visits': '23'},
    {'name': 'Priya Sharma', 'phone': '+91 9876543211', 'points': '320', 'visits': '18'},
    {'name': 'Amit Patel', 'phone': '+91 9876543212', 'points': '680', 'visits': '31'},
    {'name': 'Sunita Devi', 'phone': '+91 9876543213', 'points': '210', 'visits': '12'},
    {'name': 'Rahul Verma', 'phone': '+91 9876543214', 'points': '890', 'visits': '45'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Management',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddCustomerDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
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
              onChanged: (value) {
                setState(() {
                  // Filter customers based on search
                });
              },
            ),
          ),
          
          // Customer list
          Expanded(
            child: ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final customer = _customers[index];
                return _buildCustomerCard(customer);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCustomerDialog,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, String> customer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      customer['phone']!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showCustomerOptions(customer);
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Points', customer['points']!, Colors.orange),
              _buildStatItem('Visits', customer['visits']!, Colors.blue),
              _buildStatItem('Status', 'Active', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  void _showAddCustomerDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add New Customer',
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
                labelText: 'Customer Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefix: const Text('+91 '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email (Optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
              // Add customer logic here
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Customer added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Add Customer'),
          ),
        ],
      ),
    );
  }

  void _showCustomerOptions(Map<String, String> customer) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Call Customer'),
              onTap: () {
                Navigator.of(context).pop();
                // Call customer logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Send Message'),
              onTap: () {
                Navigator.of(context).pop();
                // Send message logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('View History'),
              onTap: () {
                Navigator.of(context).pop();
                // View history logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Add Points'),
              onTap: () {
                Navigator.of(context).pop();
                // Add points logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Customer'),
              onTap: () {
                Navigator.of(context).pop();
                // Edit customer logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

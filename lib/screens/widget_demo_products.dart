import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/product_card.dart';
import '../widgets/info_card.dart';

class WidgetDemoProducts extends StatefulWidget {
  const WidgetDemoProducts({Key? key}) : super(key: key);

  @override
  State<WidgetDemoProducts> createState() => _WidgetDemoProductsState();
}

class _WidgetDemoProductsState extends State<WidgetDemoProducts> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Flutter Course',
      'price': '₹2,999',
      'category': 'Education',
      'rating': 4.5,
      'isFavorite': false,
      'color': Colors.blue,
    },
    {
      'name': 'UI Kit Pro',
      'price': '₹1,499',
      'category': 'Design',
      'rating': 4.8,
      'isFavorite': true,
      'color': Colors.purple,
    },
    {
      'name': 'Code Editor',
      'price': '₹999',
      'category': 'Tools',
      'rating': 4.2,
      'isFavorite': false,
      'color': Colors.green,
    },
    {
      'name': 'Design System',
      'price': '₹3,999',
      'category': 'Resources',
      'rating': 4.9,
      'isFavorite': true,
      'color': Colors.orange,
    },
    {
      'name': 'Mobile Template',
      'price': '₹799',
      'category': 'Templates',
      'rating': 4.0,
      'isFavorite': false,
      'color': Colors.red,
    },
    {
      'name': 'Icon Pack',
      'price': '₹499',
      'category': 'Assets',
      'rating': 4.7,
      'isFavorite': false,
      'color': Colors.teal,
    },
  ];

  void _toggleFavorite(int index) {
    setState(() {
      _products[index]['isFavorite'] = !_products[index]['isFavorite'];
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _products[index]['isFavorite']
              ? '${_products[index]['name']} added to favorites! ❤️'
              : '${_products[index]['name']} removed from favorites',
        ),
        backgroundColor: _products[index]['color'],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _addToCart(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_products[index]['name']} added to cart! 🛒'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showProductDetails(int index) {
    final product = _products[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${product['category']}'),
            Text('Price: ${product['price']}'),
            Text('Rating: ${product['rating']} ⭐'),
            const SizedBox(height: 16),
            Row(
              children: [
                CustomButton(
                  label: 'Add to Cart',
                  onPressed: () {
                    Navigator.pop(context);
                    _addToCart(index);
                  },
                  icon: Icons.add_shopping_cart,
                ),
                const SizedBox(width: 12),
                CustomOutlineButton(
                  label: 'Favorite',
                  onPressed: () {
                    Navigator.pop(context);
                    _toggleFavorite(index);
                  },
                  icon: product['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                  color: product['color'],
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ Product Cards'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Card
            InfoCard(
              title: 'Product Cards Demo',
              subtitle: 'Reusable product card widgets with consistent design',
              icon: Icons.shopping_bag,
              color: Colors.blue,
              actions: [
                Icon(Icons.star, color: Colors.blue, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${_products.length}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Stats Row
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: 'Total Products',
                    subtitle: '${_products.length} items',
                    icon: Icons.inventory,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InfoCard(
                    title: 'Favorites',
                    subtitle: '${_products.where((p) => p['isFavorite']).length} items',
                    icon: Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Products Grid
            Text(
              '🛒 Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ProductCard(
                  name: product['name'],
                  price: product['price'],
                  category: product['category'],
                  rating: product['rating'],
                  isFavorite: product['isFavorite'],
                  accentColor: product['color'],
                  onTap: () => _showProductDetails(index),
                  onFavoriteTap: () => _toggleFavorite(index),
                  onAddToCartTap: () => _addToCart(index),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Bottom Actions
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Clear Favorites',
                    onPressed: () {
                      setState(() {
                        for (var product in _products) {
                          product['isFavorite'] = false;
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All favorites cleared! 🧹'),
                          backgroundColor: Colors.orange,
                        ),
                      );
                    },
                    icon: Icons.clear_all,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: 'Back to Home',
                    onPressed: () => Navigator.pop(context),
                    icon: Icons.home,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

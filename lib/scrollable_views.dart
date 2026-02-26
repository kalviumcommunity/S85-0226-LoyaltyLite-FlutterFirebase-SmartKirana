import 'package:flutter/material.dart';

class ScrollableViews extends StatefulWidget {
  const ScrollableViews({Key? key}) : super(key: key);

  @override
  State<ScrollableViews> createState() => _ScrollableViewsState();
}

class _ScrollableViewsState extends State<ScrollableViews> {
  List<String> categories = ['Electronics', 'Clothing', 'Food', 'Books', 'Toys', 'Sports'];
  List<Product> products = [
    Product('Laptop', '₹45,999', 'Electronics', Icons.laptop),
    Product('T-Shirt', '₹599', 'Clothing', Icons.checkroom),
    Product('Pizza', '₹299', 'Food', Icons.local_pizza),
    Product('Novel', '₹299', 'Books', Icons.book),
    Product('Teddy Bear', '₹499', 'Toys', Icons.toys),
    Product('Football', '₹899', 'Sports', Icons.sports_soccer),
    Product('Phone', '₹15,999', 'Electronics', Icons.smartphone),
    Product('Jeans', '₹1,299', 'Clothing', Icons.style),
    Product('Burger', '₹199', 'Food', Icons.fastfood),
    Product('Textbook', '₹599', 'Books', Icons.menu_book),
    Product('Car', '₹2,999', 'Toys', Icons.directions_car),
    Product('Cricket Bat', '₹1,599', 'Sports', Icons.sports_cricket),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📱 Scrollable Views Demo'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🛍️ Shopping Catalog',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Browse products with ListView and GridView',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildStatChip('12 Products', Icons.inventory),
                      const SizedBox(width: 8),
                      _buildStatChip('6 Categories', Icons.category),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Horizontal ListView Section
            _buildSectionHeader('📋 Categories (Horizontal ListView)', Icons.view_list),
            const SizedBox(height: 12),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryCard(categories[index], index);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Vertical ListView Section
            _buildSectionHeader('📝 Product List (Vertical ListView)', Icons.list),
            const SizedBox(height: 12),
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductListItem(products[index]);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // GridView Section
            _buildSectionHeader('🎯 Product Grid (GridView)', Icons.grid_view),
            const SizedBox(height: 12),
            Container(
              height: 400,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductGridItem(products[index]);
                },
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showSnackBar(context, 'Add to cart feature coming soon! 🛒');
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showSnackBar(context, 'Wishlist feature coming soon! ❤️');
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text('Wishlist'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                    ),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category, int index) {
    final colors = [Colors.blue, Colors.green, Colors.purple, Colors.pink, Colors.teal, Colors.indigo];
    final color = colors[index % colors.length];
    
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {
          _showSnackBar(context, 'Selected category: $category 📂');
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                _getCategoryIcon(category),
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              category,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${products.where((p) => p.category == category).length} items',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListItem(Product product) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange.withOpacity(0.1),
        child: Icon(
          product.icon,
          color: Colors.orange,
        ),
      ),
      title: Text(
        product.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(product.category),
      trailing: Text(
        product.price,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green,
          fontSize: 16,
        ),
      ),
      onTap: () {
        _showProductDialog(context, product);
      },
    );
  }

  Widget _buildProductGridItem(Product product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showProductDialog(context, product);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.withOpacity(0.1), Colors.deepOrange.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Icon(
                  product.icon,
                  size: 48,
                  color: Colors.orange,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Electronics':
        return Icons.devices;
      case 'Clothing':
        return Icons.checkroom;
      case 'Food':
        return Icons.restaurant;
      case 'Books':
        return Icons.book;
      case 'Toys':
        return Icons.toys;
      case 'Sports':
        return Icons.sports;
      default:
        return Icons.category;
    }
  }

  void _showProductDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(product.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(product.icon, size: 48, color: Colors.orange),
            const SizedBox(height: 16),
            Text('Category: ${product.category}'),
            Text('Price: ${product.price}'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showSnackBar(context, 'Added ${product.name} to cart! 🛒');
                  },
                  child: const Text('Add to Cart'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showSnackBar(context, 'Added ${product.name} to wishlist! ❤️');
                  },
                  child: const Text('Wishlist'),
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

class Product {
  final String name;
  final String price;
  final String category;
  final IconData icon;

  Product(this.name, this.price, this.category, this.icon);
}

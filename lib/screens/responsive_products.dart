import 'package:flutter/material.dart';

class ResponsiveProducts extends StatelessWidget {
  const ResponsiveProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '🛍️ Responsive Products',
          style: TextStyle(
            fontSize: screenWidth < 600 ? 18 : 22,
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: screenWidth < 600 ? 20 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: screenWidth < 600 ? 20 : 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search feature coming soon! 🔍'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              size: screenWidth < 600 ? 20 : 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Filter feature coming soon! 🎯'),
                  backgroundColor: Colors.green,
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
    return Column(
      children: [
        // Filter Bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: screenWidth * 0.12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(screenWidth * 0.03),
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Container(
                width: screenWidth * 0.12,
                height: screenWidth * 0.12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.filter_list, color: Colors.white, size: screenWidth * 0.06),
              ),
            ],
          ],
        ),
        
        SizedBox(height: screenHeight * 0.02),
        
        // Products Grid
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.04,
                mainAxisSpacing: screenWidth * 0.04,
                childAspectRatio: 0.8,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => _buildProductCard(index, screenWidth, true),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Sidebar Filters
        Container(
          width: screenWidth * 0.25,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(right: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🎯 Filters',
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildFilterOption('All Products', true, screenWidth),
              _buildFilterOption('Electronics', false, screenWidth),
              _buildFilterOption('Clothing', false, screenWidth),
              _buildFilterOption('Books', false, screenWidth),
              _buildFilterOption('Sports', false, screenWidth),
            ],
          ),
        ),
        
        // Products Grid
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenWidth * 0.03,
                childAspectRatio: 0.9,
              ),
              itemCount: 15,
              itemBuilder: (context, index) => _buildProductCard(index, screenWidth, false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth, double screenHeight) {
    return Row(
      children: [
        // Sidebar Filters
        Container(
          width: screenWidth * 0.2,
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            border: Border(right: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🎯 Filters',
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildFilterOption('All Products', true, screenWidth),
              _buildFilterOption('Electronics', false, screenWidth),
              _buildFilterOption('Clothing', false, screenWidth),
              _buildFilterOption('Books', false, screenWidth),
              _buildFilterOption('Sports', false, screenWidth),
              SizedBox(height: screenHeight * 0.03),
              _buildFilterOption('Price Range', false, screenWidth),
              _buildFilterOption('Brand', false, screenWidth),
              _buildFilterOption('Rating', false, screenWidth),
            ],
          ),
        ),
        
        // Main Content Area
        Expanded(
          child: Column(
            children: [
              // Search and Sort Bar
              Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: screenWidth * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(screenWidth * 0.025),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sort by',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth < 600 ? 14 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Products Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: screenWidth * 0.02,
                      mainAxisSpacing: screenWidth * 0.02,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) => _buildProductCard(index, screenWidth, false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterOption(String title, bool isSelected, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.025),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 14 : 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.green : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(int index, double screenWidth, bool isMobile) {
    final products = [
      {'name': 'Laptop Pro', 'price': '₹45,999', 'category': 'Electronics', 'color': Colors.blue},
      {'name': 'T-Shirt Premium', 'price': '₹1,299', 'category': 'Clothing', 'color': Colors.orange},
      {'name': 'Smartphone X', 'price': '₹35,999', 'category': 'Electronics', 'color': Colors.green},
      {'name': 'Running Shoes', 'price': '₹3,999', 'category': 'Sports', 'color': Colors.red},
      {'name': 'Flutter Course', 'price': '₹2,999', 'category': 'Education', 'color': Colors.purple},
      {'name': 'Headphones Pro', 'price': '₹5,999', 'category': 'Electronics', 'color': Colors.teal},
      {'name': 'Winter Jacket', 'price': '₹2,499', 'category': 'Clothing', 'color': Colors.indigo},
      {'name': 'Basketball', 'price': '₹899', 'category': 'Sports', 'color': Colors.amber},
      {'name': 'Design System', 'price': '₹1,999', 'category': 'Design', 'color': Colors.pink},
      {'name': 'Camera Pro', 'price': '₹25,999', 'category': 'Electronics', 'color': Colors.cyan},
    ];
    
    final product = products[index % products.length];
    final cardHeight = isMobile ? screenWidth * 0.45 : screenWidth * 0.25;
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Handle product tap
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                product['color'].withOpacity(0.1),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Area
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [
                        product['color'].withOpacity(0.2),
                        product['color'].withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Icon(
                    Icons.shopping_bag,
                    color: product['color'],
                    size: isMobile ? screenWidth * 0.08 : screenWidth * 0.06,
                  ),
                ),
              ),
              
              // Product Info Area
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'],
                            style: TextStyle(
                              fontSize: isMobile ? screenWidth * 0.035 : screenWidth * 0.025,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            product['category'],
                            style: TextStyle(
                              fontSize: isMobile ? screenWidth * 0.03 : screenWidth * 0.02,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['price'],
                            style: TextStyle(
                              fontSize: isMobile ? screenWidth * 0.04 : screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                              color: product['color'],
                            ),
                          ),
                          Container(
                            width: isMobile ? screenWidth * 0.08 : screenWidth * 0.05,
                            height: isMobile ? screenWidth * 0.08 : screenWidth * 0.05,
                            decoration: BoxDecoration(
                              color: product['color'],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: isMobile ? screenWidth * 0.04 : screenWidth * 0.03,
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
      ),
    );
  }
}

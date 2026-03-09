import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final String? imageUrl;
  final double rating;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToCartTap;
  final bool isFavorite;
  final Color? accentColor;

  const ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.rating = 0.0,
    this.onTap,
    this.onFavoriteTap,
    this.onAddToCartTap,
    this.isFavorite = false,
    this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? Colors.orange;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.05),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0.1),
                        color.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: imageUrl != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                                child: Image.network(
                                  imageUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.image_not_supported,
                                      size: 48,
                                      color: color.withOpacity(0.5),
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.shopping_bag,
                                size: 48,
                                color: color.withOpacity(0.5),
                              ),
                      ),
                      // Favorite Button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                              size: 16,
                            ),
                            onPressed: onFavoriteTap,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      // Category Badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Product Info Section
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                price,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                ),
                              ),
                              const Spacer(),
                              // Rating Stars
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 12,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: onAddToCartTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_shopping_cart, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
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

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final List<String>? features;

  const ServiceCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.color = Colors.orange,
    this.onTap,
    this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (features != null && features!.isNotEmpty) ...[
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features!.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: color,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_ios,
                    color: color,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/info_card.dart';
import '../widgets/like_button.dart';
import '../widgets/product_card.dart';

class WidgetDemoHome extends StatelessWidget {
  const WidgetDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧩 Custom Widgets Demo'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reusable Custom Widgets',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Demonstrating modular UI components',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CustomButton(
                        label: 'View Products',
                        onPressed: () {
                          Navigator.pushNamed(context, '/products');
                        },
                        icon: Icons.shopping_bag,
                      ),
                      const SizedBox(width: 12),
                      CustomOutlineButton(
                        label: 'View Services',
                        onPressed: () {
                          Navigator.pushNamed(context, '/services');
                        },
                        icon: Icons.miscellaneous_services,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Info Cards Section
            Text(
              '📋 Info Cards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            InfoCard(
              title: 'Custom Buttons',
              subtitle: 'Reusable button components with different styles',
              icon: Icons.touch_app,
              color: Colors.blue,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Info card tapped! 📱'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 12),
            
            InfoCard(
              title: 'Stateful Widgets',
              subtitle: 'Interactive components with internal state management',
              icon: Icons.autorenew,
              color: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Stateful widget tapped! 🔄'),
                    backgroundColor: Colors.purple,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 12),
            
            InfoCard(
              title: 'Product Cards',
              subtitle: 'Beautiful product display cards with actions',
              icon: Icons.shopping_cart,
              color: Colors.green,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product card tapped! 🛍️'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Like Buttons Section
            Text(
              '❤️ Interactive Components',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Like this demo: '),
                      LikeButton(
                        initialLikes: 42,
                        onLikeChanged: (isLiked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isLiked ? 'Thanks for liking! ❤️' : 'Unliked 😔'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('Rate this demo: '),
                      LikeButton(
                        initialLikes: 128,
                        showCount: false,
                        size: 32,
                        activeColor: Colors.orange,
                        onLikeChanged: (isLiked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isLiked ? 'Rated! ⭐' : 'Rating removed'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Service Cards Section
            Text(
              '🛠️ Service Cards',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'Widget Development',
              description: 'Create reusable Flutter widgets',
              icon: Icons.code,
              color: Colors.teal,
              features: [
                'Stateless widgets',
                'Stateful widgets',
                'Custom styling',
                'Event handling',
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Service card tapped! 🛠️'),
                    backgroundColor: Colors.teal,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            ServiceCard(
              title: 'UI/UX Design',
              description: 'Beautiful and intuitive interfaces',
              icon: Icons.palette,
              color: Colors.pink,
              features: [
                'Material Design',
                'Responsive layouts',
                'Custom animations',
                'User experience',
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Design service tapped! 🎨'),
                    backgroundColor: Colors.pink,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Explore Products',
                    onPressed: () {
                      Navigator.pushNamed(context, '/products');
                    },
                    icon: Icons.explore,
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    label: 'View Services',
                    onPressed: () {
                      Navigator.pushNamed(context, '/services');
                    },
                    icon: Icons.miscellaneous_services,
                    color: Colors.purple,
                    isFullWidth: true,
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

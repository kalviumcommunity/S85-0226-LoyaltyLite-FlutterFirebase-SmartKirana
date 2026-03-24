import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_providers.dart';
import 'provider_counter_screen.dart';
import 'provider_favorites_screen.dart';
import 'provider_settings_screen.dart';

class ProviderDemoScreen extends StatelessWidget {
  const ProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider State Management Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: themeProvider.toggleTheme,
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.dark 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Status Card
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Status',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userProvider.isLoggedIn 
                              ? 'Logged in as: ${userProvider.name}'
                              : 'Not logged in',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (!userProvider.isLoggedIn) ...[
                              ElevatedButton(
                                onPressed: () {
                                  userProvider.setUser('Demo User', 'demo@smartkirana.com');
                                },
                                child: const Text('Login'),
                              ),
                            ] else ...[
                              ElevatedButton(
                                onPressed: userProvider.logout,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Logout'),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Counter Status Card
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Global Counter',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Count: ${counterProvider.count}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Favorites Status Card
            Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favorites',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total items: ${favoritesProvider.items.length}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Navigation Buttons
            const Text(
              'Explore Provider Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
                _buildNavigationCard(
                  context,
                  'Counter Demo',
                  Icons.calculate,
                  Colors.blue,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProviderCounterScreen(),
                    ),
                  ),
                ),
                _buildNavigationCard(
                  context,
                  'Favorites',
                  Icons.favorite,
                  Colors.red,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProviderFavoritesScreen(),
                    ),
                  ),
                ),
                _buildNavigationCard(
                  context,
                  'Settings',
                  Icons.settings,
                  Colors.green,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProviderSettingsScreen(),
                    ),
                  ),
                ),
                _buildNavigationCard(
                  context,
                  'Multi-Screen Demo',
                  Icons.screen_share,
                  Colors.orange,
                  () => _showMultiScreenDemo(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiScreenDemo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Multi-Screen State Sharing'),
        content: const Text(
          'This demonstrates how Provider allows state to be shared across multiple screens. '
          'Try adding favorites in the Favorites screen and see the count update here!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_providers.dart';

class ProviderFavoritesScreen extends StatefulWidget {
  const ProviderFavoritesScreen({super.key});

  @override
  State<ProviderFavoritesScreen> createState() => _ProviderFavoritesScreenState();
}

class _ProviderFavoritesScreenState extends State<ProviderFavoritesScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Favorites Demo'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              return IconButton(
                onPressed: favoritesProvider.clearFavorites,
                icon: const Icon(Icons.clear_all),
                tooltip: 'Clear All',
              );
            },
          ),
        ],
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          return Column(
            children: [
              // Add Item Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Add to Favorites',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.favorite_border),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (_controller.text.trim().isNotEmpty) {
                                favoritesProvider.addItem(_controller.text.trim());
                                _controller.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to favorites!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Favorites List
              Expanded(
                child: favoritesProvider.items.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No favorites yet\nAdd some items above!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: favoritesProvider.items.length,
                        itemBuilder: (context, index) {
                          final item = favoritesProvider.items[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: ListTile(
                              leading: const Icon(Icons.favorite, color: Colors.red),
                              title: Text(item),
                              trailing: IconButton(
                                onPressed: () {
                                  favoritesProvider.removeItem(item);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Removed "$item" from favorites'),
                                      backgroundColor: Colors.orange,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.remove_circle),
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

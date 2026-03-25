import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';
import 'theme_settings_screen.dart';

class ThemedDemoScreen extends StatelessWidget {
  const ThemedDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Themed UI Demo'),
        backgroundColor: AppTheme.getPrimaryColor(context),
        foregroundColor: Colors.white,
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return PopupMenuButton<ThemeMode>(
                icon: const Icon(Icons.palette),
                tooltip: 'Theme Options',
                onSelected: (ThemeMode mode) {
                  themeProvider.setThemeMode(mode);
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: ThemeMode.light,
                    child: Row(
                      children: [
                        Icon(
                          Icons.light_mode,
                          color: themeProvider.isLightMode 
                              ? AppTheme.primaryColor 
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text('Light Mode'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.dark,
                    child: Row(
                      children: [
                        Icon(
                          Icons.dark_mode,
                          color: themeProvider.isDarkMode 
                              ? AppTheme.primaryColor 
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text('Dark Mode'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: ThemeMode.system,
                    child: Row(
                      children: [
                        Icon(
                          Icons.settings_brightness,
                          color: themeProvider.isSystemMode 
                              ? AppTheme.primaryColor 
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text('System Default'),
                      ],
                    ),
                  ),
                ],
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
            // Theme Status Card
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              themeProvider.isDarkMode 
                                  ? Icons.dark_mode 
                                  : Icons.light_mode,
                              color: AppTheme.getPrimaryColor(context),
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Theme',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    themeProvider.themeModeName,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.getPrimaryColor(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.getPrimaryColor(context).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Dynamic Color: ${ThemeProvider.getColorName(themeProvider.dynamicColor)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppTheme.getPrimaryColor(context),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Theme Showcase Cards
            Text(
              'Theme Components Showcase',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                _buildThemeCard(
                  context,
                  'Buttons',
                  Icons.touch_app,
                  _buildButtonShowcase(context),
                ),
                _buildThemeCard(
                  context,
                  'Input Fields',
                  Icons.text_fields,
                  _buildInputShowcase(context),
                ),
                _buildThemeCard(
                  context,
                  'Cards',
                  Icons.style,
                  _buildCardShowcase(context),
                ),
                _buildThemeCard(
                  context,
                  'Navigation',
                  Icons.navigation,
                  _buildNavigationShowcase(context),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Color Palette Selector
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dynamic Color Palette',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ThemeProvider.colorOptions.map((color) {
                            final isSelected = color == themeProvider.dynamicColor;
                            return GestureDetector(
                              onTap: () {
                                themeProvider.updateDynamicColor(color);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Theme color updated to ${ThemeProvider.getColorName(color)}'),
                                    backgroundColor: color,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(20),
                                  border: isSelected 
                                      ? Border.all(color: Colors.white, width: 3)
                                      : null,
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                                    : null,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Settings Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeSettingsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings),
                label: const Text('Advanced Theme Settings'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget content,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.getPrimaryColor(context),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildButtonShowcase(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Primary button pressed!')),
              );
            },
            child: const Text('Primary Button'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Text button pressed!')),
              );
            },
            child: const Text('Text Button'),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Outlined button pressed!')),
            );
          },
          child: const Text('Outlined Button'),
        ),
      ],
    );
  }

  Widget _buildInputShowcase(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Text Input',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password Input',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.lock, color: Colors.grey),
            suffixIcon: Icon(Icons.visibility, color: Colors.grey),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget _buildCardShowcase(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.getPrimaryColor(context).withOpacity(0.3)),
          ),
          child: Text(
            'Themed Card Content',
            style: TextStyle(
              color: AppTheme.getPrimaryColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.getCardColor(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.getSuccessColor.withOpacity(0.3)),
          ),
          child: Text(
            'Success Card Content',
            style: TextStyle(
              color: AppTheme.getSuccessColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationShowcase(BuildContext context) {
    return Column(
      children: [
        NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: (index) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Navigation to index $index')),
            );
          },
        ),
      ],
    );
  }
}

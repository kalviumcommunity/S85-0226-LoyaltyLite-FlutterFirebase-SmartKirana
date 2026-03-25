import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Theme Settings'),
        backgroundColor: AppTheme.getPrimaryColor(context),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Mode Selection
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Mode',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...ThemeMode.values.map((mode) {
                          final isSelected = mode == themeProvider.themeMode;
                          return RadioListTile<ThemeMode>(
                            title: Text(_getThemeModeDisplayName(mode)),
                            subtitle: Text(_getThemeModeDescription(mode)),
                            value: mode,
                            groupValue: themeProvider.themeMode,
                            onChanged: (ThemeMode? value) {
                              if (value != null) {
                                themeProvider.setThemeMode(value);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Theme changed to ${_getThemeModeDisplayName(value)}'),
                                    backgroundColor: AppTheme.getPrimaryColor(context),
                                  ),
                                );
                              }
                            },
                            secondary: Icon(
                              _getThemeModeIcon(mode),
                              color: isSelected 
                                  ? AppTheme.getPrimaryColor(context)
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Dynamic Color Selection
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dynamic Color Theme',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Choose a color to customize your app theme:',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: ThemeProvider.colorOptions.asMap().entries.map((entry) {
                            final color = entry.value;
                            final colorName = entry.key;
                            final index = ThemeProvider.colorOptions.indexOf(color);
                            final isSelected = color == themeProvider.dynamicColor;
                            
                            return GestureDetector(
                              onTap: () {
                                themeProvider.updateDynamicColor(color);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Theme color updated to $colorName'),
                                    backgroundColor: color,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected 
                                      ? Border.all(color: Colors.white, width: 3)
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: color.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 24,
                                      )
                                    : null,
                              ),
                            );
                          }).values.toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Theme Preview
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Preview',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.getCardColor(context),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.getPrimaryColor(context).withOpacity(0.3)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Sample Card',
                                style: TextStyle(
                                  color: AppTheme.getPrimaryColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'This is how your themed UI will look with the current settings.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Primary'),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('Secondary'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Outlined'),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Advanced Settings
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advanced Options',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Follow System Theme'),
                          subtitle: const Text('Automatically switch between light and dark mode'),
                          value: themeProvider.isSystemMode,
                          onChanged: (bool value) {
                            if (value) {
                              themeProvider.setSystemTheme();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Theme set to follow system'),
                                  backgroundColor: AppTheme.successColor,
                                ),
                              );
                            }
                          },
                          secondary: Icon(
                            Icons.settings_brightness,
                            color: themeProvider.isSystemMode 
                                ? AppTheme.getPrimaryColor(context)
                                : Colors.grey,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.restore),
                          title: const Text('Reset to Default'),
                          subtitle: const Text('Restore original theme settings'),
                          onTap: () {
                            themeProvider.resetToDefault();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Theme reset to default'),
                                backgroundColor: AppTheme.warningColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Theme Benefits
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Benefits',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildBenefitItem('🌙 Dark Mode', 
                            'Reduces eye strain and saves battery on OLED screens'),
                        _buildBenefitItem('🎨 Dynamic Colors', 
                            'Personalize your app with custom color themes'),
                        _buildBenefitItem('🔄 System Integration', 
                            'Automatically adapts to device theme settings'),
                        _buildBenefitItem('💾 Persistent Settings', 
                            'Your theme preferences are saved and remembered'),
                        _buildBenefitItem('♿ Accessibility', 
                            'Better contrast and readability for all users'),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getThemeModeDisplayName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
    return 'System';
  }

  String _getThemeModeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Always use light theme';
      case ThemeMode.dark:
        return 'Always use dark theme';
      case ThemeMode.system:
        return 'Follow device theme settings';
    }
    return 'Follow device theme settings';
  }

  IconData _getThemeModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_brightness;
    }
    return Icons.settings_brightness;
  }

  Widget _buildBenefitItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

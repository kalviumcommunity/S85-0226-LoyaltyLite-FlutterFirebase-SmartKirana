import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Simple theme provider without persistence for demo
class SimpleThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _dynamicColor = const Color(0xFF6750A4);
  
  ThemeMode get themeMode => _themeMode;
  Color get dynamicColor => _dynamicColor;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        _themeMode = ThemeMode.light;
        break;
      case ThemeMode.system:
        _themeMode = ThemeMode.light;
        break;
    }
    notifyListeners();
  }
  
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  
  void updateDynamicColor(Color color) {
    _dynamicColor = color;
    notifyListeners();
  }
  
  String get themeModeName {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
    return 'System';
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SimpleThemeProvider(),
      child: const SimpleThemedApp(),
    ),
  );
}

class SimpleThemedApp extends StatelessWidget {
  const SimpleThemedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SimpleThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Smart Kirana - Themed UI Demo',
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(themeProvider, Brightness.light),
          darkTheme: _buildTheme(themeProvider, Brightness.dark),
          themeMode: themeProvider.themeMode,
          home: Builder(
            builder: (context) {
              return const SimpleThemedDemoScreen();
            },
          ),
        );
      },
    );
  }

  ThemeData _buildTheme(SimpleThemeProvider themeProvider, Brightness brightness) {
    final baseTheme = brightness == Brightness.dark 
        ? ThemeData.dark()
        : ThemeData.light();
    
    return baseTheme.copyWith(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: themeProvider.dynamicColor,
        brightness: brightness,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: themeProvider.dynamicColor,
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeProvider.dynamicColor,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }
}

class SimpleThemedDemoScreen extends StatelessWidget {
  const SimpleThemedDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Themed UI Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          Consumer<SimpleThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                onPressed: themeProvider.toggleTheme,
                icon: Icon(
                  themeProvider.isDarkMode 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
                tooltip: 'Toggle Theme',
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
            Consumer<SimpleThemeProvider>(
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
                              color: Theme.of(context).colorScheme.primary,
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
                                      color: Theme.of(context).colorScheme.primary,
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
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Dynamic Color Applied',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
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
            
            // Theme Components Showcase
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
                _buildComponentCard(
                  'Buttons',
                  Icons.touch_app,
                  _buildButtonShowcase(context),
                ),
                _buildComponentCard(
                  'Input Fields',
                  Icons.text_fields,
                  _buildInputShowcase(context),
                ),
                _buildComponentCard(
                  'Cards',
                  Icons.style,
                  _buildCardShowcase(context),
                ),
                _buildComponentCard(
                  'Navigation',
                  Icons.navigation,
                  _buildNavigationShowcase(context),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Color Palette
            Consumer<SimpleThemeProvider>(
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
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            Color(0xFF6750A4), // Deep Purple
                            Color(0xFF2196F3), // Blue
                            Color(0xFF4CAF50), // Green
                            Color(0xFFFF9800), // Orange
                            Color(0xFFE91E63), // Red
                            Color(0xFF9C27B0), // Purple
                            Color(0xFF00BCD4), // Light Blue
                            Color(0xFF795548), // Brown
                          ].map((color) {
                            final isSelected = color == themeProvider.dynamicColor;
                            return GestureDetector(
                              onTap: () {
                                themeProvider.updateDynamicColor(color);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Theme color updated!'),
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
                        'Reduces eye strain and saves battery'),
                    _buildBenefitItem('🎨 Dynamic Colors', 
                        'Personalize your app appearance'),
                    _buildBenefitItem('🔄 System Integration', 
                        'Adapts to device settings'),
                    _buildBenefitItem('♿ Accessibility', 
                        'Better contrast for all users'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentCard(String title, IconData icon, Widget content) {
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
                  color: Theme.of(context).colorScheme.primary,
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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
          ),
          child: Text(
            'Themed Card Content',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Text(
            'Success Card Content',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationShowcase() {
    return NavigationBar(
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
    );
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

import 'package:flutter/material.dart';
import 'screens/scrollable_views.dart';

void main() {
  runApp(const ScrollableViewsDemo());
}

class ScrollableViewsDemo extends StatelessWidget {
  const ScrollableViewsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScrollableViews Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ScrollableViewsApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScrollableViewsApp extends StatefulWidget {
  const ScrollableViewsApp({super.key});

  @override
  State<ScrollableViewsApp> createState() => _ScrollableViewsAppState();
}

class _ScrollableViewsAppState extends State<ScrollableViewsApp> {
  int _selectedIndex = 0;

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.grid_view),
      label: 'Scrollable Views',
    ),
    NavigationDestination(
      icon: Icon(Icons.info),
      label: 'About',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Scrollable Layouts'),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const _HomeScreen(),
          const ScrollableViews(),
          const _AboutScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicatorColor: Colors.deepPurple,
        selectedIndex: _selectedIndex,
        destinations: _destinations,
      ),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple[300]!],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Scrollable Views',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Master ListView and GridView widgets',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What You\'ll Learn',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                _LearningItem(
                  icon: Icons.list,
                  title: 'ListView Fundamentals',
                  description: 'Create scrollable vertical and horizontal lists efficiently',
                ),
                const SizedBox(height: 12),
                _LearningItem(
                  icon: Icons.grid_3x3,
                  title: 'GridView Mastery',
                  description: 'Build responsive multi-column grid layouts',
                ),
                const SizedBox(height: 12),
                _LearningItem(
                  icon: Icons.speed,
                  title: 'Performance Optimization',
                  description: 'Use .builder() for efficient rendering of large lists',
                ),
                const SizedBox(height: 12),
                _LearningItem(
                  icon: Icons.touch_app,
                  title: 'Interactive UI',
                  description: 'Add tap handlers and real-time feedback',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to ScrollableViews
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Explore Demo'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _LearningItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutScreen extends StatelessWidget {
  const _AboutScreen();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.deepPurple.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'About This Demo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle('Overview', context),
                const Text(
                  'This demo showcases the essential scrollable widgets in Flutter: ListView and GridView. '
                  'Learn how to build efficient, performant layouts that can handle large datasets.',
                ),
                const SizedBox(height: 24),
                _SectionTitle('Key Features', context),
                _FeatureList([
                  'Horizontal scrollable ListView showing featured products',
                  'Vertical ListView with user list and online status',
                  'GridView displaying product categories',
                  'Performance optimization using .builder() method',
                  'Interactive tap handlers with feedback',
                  'Beautiful Material Design UI',
                ]),
                const SizedBox(height: 24),
                _SectionTitle('Performance Tips', context),
                _TipList([
                  'Use ListView.builder() to render items on demand',
                  'Set appropriate heights for nested scrollables',
                  'Lazy load images and heavy assets',
                  'Use NeverScrollableScrollPhysics for nested lists',
                  'Profile your app using Flutter DevTools',
                ]),
                const SizedBox(height: 24),
                _SectionTitle('Related Resources', context),
                const Text(
                  '📚 Flutter ListView Documentation\n'
                  '📚 Flutter GridView Documentation\n'
                  '📚 Performance Best Practices\n'
                  '🎥 Flutter Layout Widget Guide',
                  style: TextStyle(height: 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _SectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
      ),
    );
  }
}

class _FeatureList extends StatelessWidget {
  final List<String> items;

  const _FeatureList(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12, top: 4),
                    child: Icon(Icons.check_circle, color: Colors.deepPurple, size: 20),
                  ),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TipList extends StatelessWidget {
  final List<String> tips;

  const _TipList(this.tips);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tips
          .map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.left(
                    color: Colors.amber,
                    width: 4,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(Icons.lightbulb_outline, color: Colors.amber),
                    ),
                    Expanded(child: Text(tip)),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

extension on Border {
  static Border left({
    required Color color,
    required double width,
  }) {
    return Border(
      left: BorderSide(color: color, width: width),
    );
  }
}

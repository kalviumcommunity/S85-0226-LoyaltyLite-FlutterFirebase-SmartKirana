import 'package:flutter/material.dart';

class WidgetTreeDemo extends StatefulWidget {
  const WidgetTreeDemo({super.key});

  @override
  State<WidgetTreeDemo> createState() => _WidgetTreeDemoState();
}

class _WidgetTreeDemoState extends State<WidgetTreeDemo> {
  // State variables to demonstrate reactive UI
  int _counter = 0;
  Color _backgroundColor = Colors.blue.shade50;
  bool _showCard = true;
  String _userName = 'Flutter Student';
  double _fontSize = 16.0;
  bool _isDarkMode = false;

  // List of colors for background cycling
  final List<Color> _colors = [
    Colors.blue.shade50,
    Colors.green.shade50,
    Colors.purple.shade50,
    Colors.orange.shade50,
    Colors.pink.shade50,
  ];
  int _colorIndex = 0;

  @override
  Widget build(BuildContext context) {
    // This is the root of our widget tree demonstration
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Widget Tree & Reactive UI Demo'),
        backgroundColor: _isDarkMode ? Colors.grey.shade800 : Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleDarkMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Card Section
            _buildProfileCard(),
            
            const SizedBox(height: 20),
            
            // Counter Section
            _buildCounterSection(),
            
            const SizedBox(height: 20),
            
            // Interactive Controls Section
            _buildControlPanel(),
            
            const SizedBox(height: 20),
            
            // Dynamic Content Section
            _buildDynamicContent(),
          ],
        ),
      ),
    );
  }

  // Profile Card Widget - demonstrates nested widget structure
  Widget _buildProfileCard() {
    return Card(
      elevation: 8,
      shadowColor: Colors.deepPurple.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade100,
              Colors.blue.shade100,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Avatar Section
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple.shade300,
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // User Name with dynamic font size
            Text(
              _userName,
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Subtitle
            Text(
              'Flutter Developer in Training',
              style: TextStyle(
                fontSize: _fontSize * 0.8,
                color: Colors.grey.shade600,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Projects', '12'),
                _buildStatItem('Stars', '48'),
                _buildStatItem('Following', '23'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Individual Stat Item Widget
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: _fontSize * 1.2,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: _fontSize * 0.75,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // Counter Section - demonstrates state updates
  Widget _buildCounterSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Reactive Counter Demo',
              style: TextStyle(
                fontSize: _fontSize * 1.1,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            // Counter Display
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'Current Count:',
                    style: TextStyle(
                      fontSize: _fontSize * 0.9,
                      color: _isDarkMode ? Colors.white70 : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: _fontSize * 2,
                      fontWeight: FontWeight.bold,
                      color: _counter > 10 ? Colors.red : Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Counter Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove),
                  label: const Text('Decrement'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetCounter,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Increment'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Control Panel - demonstrates multiple interactive elements
  Widget _buildControlPanel() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Interactive Controls',
              style: TextStyle(
                fontSize: _fontSize * 1.1,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
            const SizedBox(height: 16),
            
            // Background Color Changer
            ElevatedButton.icon(
              onPressed: _changeBackgroundColor,
              icon: const Icon(Icons.palette),
              label: const Text('Change Background Color'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade400,
                foregroundColor: Colors.white,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Font Size Slider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Font Size: ${_fontSize.toInt()}',
                  style: TextStyle(
                    fontSize: _fontSize * 0.9,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                Slider(
                  value: _fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  activeColor: Colors.deepPurple,
                  onChanged: _changeFontSize,
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Toggle Card Visibility
            SwitchListTile(
              title: Text(
                'Show Dynamic Card',
                style: TextStyle(
                  fontSize: _fontSize * 0.9,
                  color: Colors.deepPurple.shade700,
                ),
              ),
              value: _showCard,
              onChanged: _toggleCardVisibility,
              activeThumbColor: Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic Content Section - appears/disappears based on state
  Widget _buildDynamicContent() {
    if (!_showCard) {
      return const SizedBox.shrink(); // Returns an empty widget
    }

    return Card(
      elevation: 4,
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.amber.shade600,
                  size: _fontSize * 1.5,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Dynamic Content Card',
                    style: TextStyle(
                      fontSize: _fontSize * 1.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'This card appears and disappears based on the toggle switch above. '
              'This demonstrates how Flutter\'s reactive UI model can show/hide widgets '
              'based on state changes without manually managing the UI.',
              style: TextStyle(
                fontSize: _fontSize * 0.9,
                color: Colors.amber.shade700,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _changeUserName,
              icon: const Icon(Icons.edit),
              label: const Text('Change Name'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade600,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // State update methods - these trigger rebuilds
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _changeBackgroundColor() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _colors.length;
      _backgroundColor = _colors[_colorIndex];
    });
  }

  void _changeFontSize(double newSize) {
    setState(() {
      _fontSize = newSize;
    });
  }

  void _toggleCardVisibility(bool value) {
    setState(() {
      _showCard = value;
    });
  }

  void _changeUserName() {
    final names = ['Flutter Student', 'Widget Master', 'UI Expert', 'State Manager', 'Tree Navigator'];
    final currentIndex = names.indexOf(_userName);
    final nextIndex = (currentIndex + 1) % names.length;
    
    setState(() {
      _userName = names[nextIndex];
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _backgroundColor = _isDarkMode ? Colors.grey.shade900 : _colors[_colorIndex];
    });
  }
}

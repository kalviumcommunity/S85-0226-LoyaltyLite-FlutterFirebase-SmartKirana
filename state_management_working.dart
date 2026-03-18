import 'package:flutter/material.dart';

void main() {
  runApp(const StateManagementApp());
}

class StateManagementApp extends StatelessWidget {
  const StateManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StateManagementDemo(),
    );
  }
}

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  State<StateManagementDemo> createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  int _counter = 0;
  bool _isLiked = false;
  Color _backgroundColor = Colors.white;
  String _message = 'Hello, Flutter!';
  double _sliderValue = 0.0;
  bool _isDarkMode = false;

  // Counter methods
  void _incrementCounter() {
    setState(() {
      _counter++;
      _updateBackgroundColor();
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
        _updateBackgroundColor();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _backgroundColor = Colors.white;
    });
  }

  // Background color update based on counter
  void _updateBackgroundColor() {
    if (_counter >= 10) {
      _backgroundColor = Colors.red.shade100;
    } else if (_counter >= 5) {
      _backgroundColor = Colors.green.shade100;
    } else if (_counter >= 3) {
      _backgroundColor = Colors.yellow.shade100;
    } else {
      _backgroundColor = Colors.white;
    }
  }

  // Like button toggle
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _message = _isLiked ? 'You liked this!' : 'Like this demo!';
    });
  }

  // Message update
  void _updateMessage(String newMessage) {
    setState(() {
      _message = newMessage;
    });
  }

  // Slider value update
  void _updateSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  // Theme toggle
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _backgroundColor = _isDarkMode ? Colors.grey.shade800 : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('State Management Demo'),
        backgroundColor: _isDarkMode ? Colors.grey.shade900 : Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: _toggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Counter Example',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Button pressed:',
                      style: TextStyle(
                        fontSize: 18,
                        color: _isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    Text(
                      '$_counter times',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          child: const Text('Increment'),
                        ),
                        ElevatedButton(
                          onPressed: _decrementCounter,
                          child: const Text('Decrement'),
                        ),
                        ElevatedButton(
                          onPressed: _resetCounter,
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _counter >= 10
                          ? '🔥 Hot! Counter reached 10+'
                          : _counter >= 5
                              ? '👍 Good job! Counter reached 5+'
                              : _counter >= 3
                                  ? '📈 Keep going! Counter reached 3+'
                                  : '🎯 Start clicking!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Like Button Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Like Button Example',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    IconButton(
                      onPressed: _toggleLike,
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : Colors.grey,
                        size: 60,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _message,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Slider Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Slider Example',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 100.0,
                      divisions: 20,
                      label: _sliderValue.round().toString(),
                      onChanged: _updateSliderValue,
                    ),
                    Text(
                      'Slider Value: ${_sliderValue.round()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: _sliderValue / 100.0,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _sliderValue > 75
                            ? Colors.red
                            : _sliderValue > 50
                                ? Colors.orange
                                : _sliderValue > 25
                                    ? Colors.yellow
                                    : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Input Field Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Input Field Example',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Type a message',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: _updateMessage,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _message,
                        style: TextStyle(
                          fontSize: 16,
                          color: _isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // State Info Section
            Card(
              elevation: 4,
              color: _isDarkMode ? Colors.grey.shade800 : Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Current State Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStateRow('Counter', _counter.toString()),
                        _buildStateRow('Liked', _isLiked.toString()),
                        _buildStateRow('Message', _message),
                        _buildStateRow('Slider', _sliderValue.round().toString()),
                        _buildStateRow('Theme', _isDarkMode ? 'Dark' : 'Light'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStateRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: _isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}

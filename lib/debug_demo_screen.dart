import 'package:flutter/material.dart';

class DebugDemoScreen extends StatefulWidget {
  const DebugDemoScreen({Key? key}) : super(key: key);

  @override
  State<DebugDemoScreen> createState() => _DebugDemoScreenState();
}

class _DebugDemoScreenState extends State<DebugDemoScreen> {
  int _counter = 0;
  Color _backgroundColor = Colors.blue;
  String _displayText = 'Hello, Flutter!';
  bool _isExpanded = false;
  List<String> _debugLogs = [];
  
  @override
  void initState() {
    super.initState();
    debugPrint('DebugDemoScreen initialized');
    _addLog('Screen initialized');
  }

  void _addLog(String message) {
    setState(() {
      _debugLogs.add('${DateTime.now().millisecondsSinceEpoch}: $message');
      debugPrint('DEMO LOG: $message');
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _addLog('Counter incremented to $_counter');
    });
  }

  void _changeColor() {
    setState(() {
      final colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple];
      _backgroundColor = colors[(_counter % colors.length)];
      _addLog('Background color changed to ${_backgroundColor.toString()}');
    });
  }

  void _changeText() {
    setState(() {
      final texts = [
        'Hello, Flutter!',
        'Welcome to Hot Reload!',
        'Debug Console Active!',
        'DevTools Ready!',
        'Flutter Development!'
      ];
      _displayText = texts[(_counter % texts.length)];
      _addLog('Text changed to: $_displayText');
    });
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      _addLog('Widget expanded: $_isExpanded');
    });
  }

  void _resetDemo() {
    setState(() {
      _counter = 0;
      _backgroundColor = Colors.blue;
      _displayText = 'Hello, Flutter!';
      _isExpanded = false;
      _debugLogs.clear();
      _addLog('Demo reset completed');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This will help with DevTools Widget Inspector
    debugPrint('Building DebugDemoScreen - Counter: $_counter, Color: $_backgroundColor');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔧 Debug Tools Demo'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetDemo,
            tooltip: 'Reset Demo',
          ),
        ],
      ),
      body: Container(
        color: _backgroundColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hot Reload Demo Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🔥 Hot Reload Demo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try changing the code below and save the file to see Hot Reload in action!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Text(
                          _displayText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _backgroundColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _changeText,
                            child: const Text('Change Text'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _changeColor,
                            child: const Text('Change Color'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Debug Console Demo Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '💻 Debug Console Demo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Check the Debug Console for real-time logs!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'Counter: $_counter',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 16),
                          IconButton(
                            onPressed: _incrementCounter,
                            icon: const Icon(Icons.add),
                            iconSize: 32,
                            tooltip: 'Increment Counter',
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _toggleExpanded,
                        child: Text(_isExpanded ? 'Collapse' : 'Expand'),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // DevTools Demo Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🛠️ DevTools Demo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Open Flutter DevTools to inspect this widget tree!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_isExpanded) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.expand_more, size: 48, color: Colors.green),
                              Text(
                                'Expanded Content for DevTools Inspection',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'This widget tree is perfect for Widget Inspector!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.expand_less, size: 48, color: Colors.orange),
                              Text(
                                'Collapsed State',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Debug Logs Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📋 Debug Logs',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: _debugLogs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                _debugLogs[index],
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            );
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        tooltip: 'Increment Counter (Check Debug Console)',
      ),
    );
  }
}

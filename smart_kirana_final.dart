import 'package:flutter/material.dart';

void main() {
  runApp(const SmartKiranaApp());
}

class SmartKiranaApp extends StatelessWidget {
  const SmartKiranaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Kirana - Complete App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    // Simulate authentication check
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isAuthenticated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return const MainNavigationScreen();
    }
    return const AuthScreen();
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const DashboardScreen(),
    const MapsScreen(),
    const StateManagementScreen(),
    const CloudFunctionsScreen(),
    const RealtimeSyncScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'State',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Functions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Sync',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Kirana Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // Simulate logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthGate()),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'demo@smartkirana.com',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'UID: user_demo_${DateTime.now().millisecondsSinceEpoch}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Features Grid
            const Text(
              'Available Features',
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
                _buildFeatureCard(
                  context,
                  'Google Maps',
                  Icons.map,
                  Colors.blue,
                  1, // Index for navigation
                ),
                _buildFeatureCard(
                  context,
                  'State Management',
                  Icons.sync,
                  Colors.green,
                  2,
                ),
                _buildFeatureCard(
                  context,
                  'Cloud Functions',
                  Icons.cloud,
                  Colors.orange,
                  3,
                ),
                _buildFeatureCard(
                  context,
                  'Real-time Sync',
                  Icons.sync_problem,
                  Colors.purple,
                  4,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Stats Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'App Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildStatRow('Total Users', '1,234'),
                    _buildStatRow('Active Sessions', '89'),
                    _buildStatRow('API Calls', '5,678'),
                    _buildStatRow('Data Synced', '2.3 MB'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Color color, int navIndex) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          // Navigate to the corresponding screen
          final mainScreen = context.findAncestorStateOfType<_MainNavigationScreenState>();
          if (mainScreen != null) {
            mainScreen.setState(() {
              mainScreen._currentIndex = navIndex;
            });
          }
        },
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
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Tap to open',
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitAuthForm() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate authentication
      await Future.delayed(const Duration(seconds: 2));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_isLogin ? 'Login' : 'Sign Up'} successful!')),
      );
      
      // Navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              size: 100,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitAuthForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(_isLogin ? 'Login' : 'Sign Up'),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: Text(_isLogin ? 'Create an account' : 'Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String _currentMapType = 'normal';
  bool _myLocationEnabled = true;
  List<String> _mapEvents = [];

  @override
  void initState() {
    super.initState();
    _addToLogs('Maps initialized (Demo Mode)');
  }

  void _addToLogs(String event) {
    setState(() {
      _mapEvents.insert(0, '${DateTime.now().toString().substring(11, 19)}: $event');
      if (_mapEvents.length > 10) {
        _mapEvents = _mapEvents.take(10).toList();
      }
    });
  }

  void _changeMapType(String type) {
    setState(() {
      _currentMapType = type;
    });
    _addToLogs('Map type changed to: $type');
  }

  void _toggleLocation() {
    setState(() {
      _myLocationEnabled = !_myLocationEnabled;
    });
    _addToLogs('Location ${_myLocationEnabled ? 'enabled' : 'disabled'}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String type) {
              _changeMapType(type);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'normal', child: Text('Normal')),
              const PopupMenuItem(value: 'satellite', child: Text('Satellite')),
              const PopupMenuItem(value: 'hybrid', child: Text('Hybrid')),
              const PopupMenuItem(value: 'terrain', child: Text('Terrain')),
            ],
          ),
          IconButton(
            onPressed: _toggleLocation,
            icon: Icon(_myLocationEnabled ? Icons.location_on : Icons.location_off),
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Controls
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Text('Map Type: $_currentMapType'),
                const Spacer(),
                Text('Location: ${_myLocationEnabled ? 'On' : 'Off'}'),
              ],
            ),
          ),
          
          // Simulated Map View
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade100, Colors.green.shade100],
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 100, color: Colors.blue),
                    SizedBox(height: 16),
                    Text(
                      'Google Maps Demo',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Map Type: Normal'),
                    Text('Location: Enabled'),
                    SizedBox(height: 16),
                    Text(
                      'This is a demo mode.\nDeploy to device for real maps.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Map Events Log
          Container(
            height: 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Map Events',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => setState(() => _mapEvents.clear()),
                      icon: const Icon(Icons.clear),
                      iconSize: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _mapEvents.isEmpty
                      ? const Center(child: Text('No events yet'))
                      : ListView.builder(
                          itemCount: _mapEvents.length,
                          itemBuilder: (context, index) {
                            return Text(
                              _mapEvents[index],
                              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                            );
                          },
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

class StateManagementScreen extends StatefulWidget {
  const StateManagementScreen({super.key});

  @override
  State<StateManagementScreen> createState() => _StateManagementScreenState();
}

class _StateManagementScreenState extends State<StateManagementScreen> {
  int _counter = 0;
  bool _isLiked = false;
  Color _backgroundColor = Colors.white;
  String _message = 'Hello, Flutter!';
  double _sliderValue = 0.0;

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

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _message = _isLiked ? 'You liked this!' : 'Like this demo!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('State Management'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Counter Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Counter Example',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Button pressed: $_counter times',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Like Button Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Like Button Example',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    Text(_message),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Slider Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Slider Example',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 100.0,
                      divisions: 20,
                      label: _sliderValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                    Text('Slider Value: ${_sliderValue.round()}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloudFunctionsScreen extends StatefulWidget {
  const CloudFunctionsScreen({super.key});

  @override
  State<CloudFunctionsScreen> createState() => _CloudFunctionsScreenState();
}

class _CloudFunctionsScreenState extends State<CloudFunctionsScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  List<String> _functionLogs = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addToLogs(String log) {
    setState(() {
      _functionLogs.insert(0, '${DateTime.now().toString().substring(11, 19)}: $log');
      if (_functionLogs.length > 10) {
        _functionLogs = _functionLogs.take(10).toList();
      }
    });
  }

  Future<void> _callSayHello() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    setState(() => _isLoading = true);
    _addToLogs('Calling sayHello function...');

    try {
      // Simulate Cloud Function call
      await Future.delayed(const Duration(seconds: 1));
      
      final result = {
        'message': 'Hello, ${_nameController.text.trim()}!',
        'timestamp': DateTime.now().toIso8601String(),
        'success': true
      };
      
      _addToLogs('Function executed successfully');
      _showResult('Function Result', result);
    } catch (e) {
      _addToLogs('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showResult(String title, dynamic result) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(result.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Functions'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Section
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            
            // Function Buttons
            ElevatedButton(
              onPressed: _isLoading ? null : _callSayHello,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Call Say Hello Function'),
            ),
            
            const SizedBox(height: 16),
            
            // Logs Section
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Function Logs',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => setState(() => _functionLogs.clear()),
                            icon: const Icon(Icons.clear),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _functionLogs.isEmpty
                            ? const Center(child: Text('No function calls yet'))
                            : ListView.builder(
                                itemCount: _functionLogs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      _functionLogs[index],
                                      style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RealtimeSyncScreen extends StatefulWidget {
  const RealtimeSyncScreen({super.key});

  @override
  State<RealtimeSyncScreen> createState() => _RealtimeSyncScreenState();
}

class _RealtimeSyncScreenState extends State<RealtimeSyncScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  List<String> _syncLogs = [];

  @override
  void initState() {
    super.initState();
    _addToLogs('Real-time sync initialized');
    _addSampleMessages();
  }

  void _addSampleMessages() {
    setState(() {
      _messages = [
        'Welcome to Smart Kirana!',
        'Real-time sync is active',
        'Try adding a new message',
      ];
    });
  }

  void _addToLogs(String log) {
    setState(() {
      _syncLogs.insert(0, '${DateTime.now().toString().substring(11, 19)}: $log');
      if (_syncLogs.length > 10) {
        _syncLogs = _syncLogs.take(10).toList();
      }
    });
  }

  void _addMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, _messageController.text.trim());
      if (_messages.length > 20) {
        _messages = _messages.take(20).toList();
      }
    });

    _addToLogs('Message added: ${_messageController.text.trim()}');
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Sync'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Message Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      labelText: 'Type a message',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addMessage,
                  child: const Text('Send'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Messages List
            Expanded(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Live Messages',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _messages.isEmpty
                            ? const Center(child: Text('No messages yet'))
                            : ListView.builder(
                                itemCount: _messages.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(_messages[index]),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Sync Logs
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Sync Logs',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => setState(() => _syncLogs.clear()),
                            icon: const Icon(Icons.clear),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _syncLogs.isEmpty
                            ? const Center(child: Text('No sync events yet'))
                            : ListView.builder(
                                itemCount: _syncLogs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      _syncLogs[index],
                                      style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

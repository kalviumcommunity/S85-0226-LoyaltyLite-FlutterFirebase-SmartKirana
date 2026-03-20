import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CloudFunctionsApp());
}

class CloudFunctionsApp extends StatelessWidget {
  const CloudFunctionsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Functions Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CloudFunctionsDemo(),
    );
  }
}

class CloudFunctionsDemo extends StatefulWidget {
  const CloudFunctionsDemo({super.key});

  @override
  State<CloudFunctionsDemo> createState() => _CloudFunctionsDemoState();
}

class _CloudFunctionsDemoState extends State<CloudFunctionsDemo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  bool _isLoading = false;
  List<String> _functionLogs = [];
  Map<String, dynamic>? _lastResult;
  String _currentUserId = 'demo_user_${DateTime.now().millisecondsSinceEpoch}';

  @override
  void dispose() {
    _nameController.dispose();
    _userIdController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _addToLogs(String log) {
    setState(() {
      _functionLogs.insert(0, '${DateTime.now().toString().substring(11, 19)}: $log');
      if (_functionLogs.length > 20) {
        _functionLogs = _functionLogs.take(20).toList();
      }
    });
  }

  void _showResult(String title, dynamic result) {
    setState(() {
      _lastResult = result;
    });
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Result:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  result.toString(),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(String title, String error) {
    _addToLogs('ERROR: $error');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(
          error,
          style: TextStyle(color: Colors.red.shade700),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ==================== CALLABLE FUNCTIONS ====================

  Future<void> _callSayHello() async {
    if (_nameController.text.trim().isEmpty) {
      _showError('Input Error', 'Please enter a name');
      return;
    }

    setState(() => _isLoading = true);
    _addToLogs('Calling sayHello function...');

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('sayHello');
      final result = await callable.call({'name': _nameController.text.trim()});
      
      _addToLogs('sayHello function executed successfully');
      _showResult('Hello Function Result', result.data);
    } catch (e) {
      _showError('Function Error', 'Failed to call sayHello: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callGetUserProfile() async {
    if (_userIdController.text.trim().isEmpty || _emailController.text.trim().isEmpty) {
      _showError('Input Error', 'Please enter user ID and email');
      return;
    }

    setState(() => _isLoading = true);
    _addToLogs('Calling getUserProfile function...');

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('getUserProfile');
      final result = await callable.call({
        'userId': _userIdController.text.trim(),
        'name': _nameController.text.trim().isEmpty ? 'Demo User' : _nameController.text.trim(),
        'email': _emailController.text.trim(),
      });
      
      _addToLogs('getUserProfile function executed successfully');
      _showResult('Profile Function Result', result.data);
    } catch (e) {
      _showError('Function Error', 'Failed to call getUserProfile: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callSendNotification() async {
    if (_userIdController.text.trim().isEmpty || _titleController.text.trim().isEmpty) {
      _showError('Input Error', 'Please enter user ID and notification title');
      return;
    }

    setState(() => _isLoading = true);
    _addToLogs('Calling sendNotification function...');

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('sendNotification');
      final result = await callable.call({
        'userId': _userIdController.text.trim(),
        'title': _titleController.text.trim(),
        'body': _bodyController.text.trim().isEmpty ? 'Default notification body' : _bodyController.text.trim(),
      });
      
      _addToLogs('sendNotification function executed successfully');
      _showResult('Notification Function Result', result.data);
    } catch (e) {
      _showError('Function Error', 'Failed to call sendNotification: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callHealthCheck() async {
    setState(() => _isLoading = true);
    _addToLogs('Calling healthCheck function...');

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('healthCheck');
      final result = await callable.call();
      
      _addToLogs('healthCheck function executed successfully');
      _showResult('Health Check Result', result.data);
    } catch (e) {
      _showError('Function Error', 'Failed to call healthCheck: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _callEchoTest() async {
    setState(() => _isLoading = true);
    _addToLogs('Calling echoTest function...');

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('echoTest');
      final result = await callable.call({
        'message': 'Test message from Flutter',
        'timestamp': DateTime.now().toIso8601String(),
        'userId': _currentUserId,
        'random': (DateTime.now().millisecondsSinceEpoch % 1000).toString(),
      });
      
      _addToLogs('echoTest function executed successfully');
      _showResult('Echo Test Result', result.data);
    } catch (e) {
      _showError('Function Error', 'Failed to call echoTest: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ==================== EVENT-BASED FUNCTIONS ====================

  Future<void> _triggerUserCreation() async {
    setState(() => _isLoading = true);
    _addToLogs('Triggering user creation event...');

    try {
      await FirebaseFirestore.instance.collection('users').doc(_currentUserId).set({
        'name': _nameController.text.trim().isEmpty ? 'Demo User' : _nameController.text.trim(),
        'email': _emailController.text.trim().isEmpty ? 'demo@example.com' : _emailController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      _addToLogs('User document created - should trigger onUserCreated function');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User created! Check Firebase Console logs for function execution.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      _showError('Firestore Error', 'Failed to create user: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _triggerMessageCreation() async {
    if (_messageController.text.trim().isEmpty) {
      _showError('Input Error', 'Please enter a message');
      return;
    }

    setState(() => _isLoading = true);
    _addToLogs('Triggering message creation event...');

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'text': _messageController.text.trim(),
        'userId': _currentUserId,
        'timestamp': FieldValue.serverTimestamp(),
        'type': 'user_message',
      });
      
      _addToLogs('Message document created - should trigger onMessageCreated function');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message created! Check Firebase Console logs for function execution.'),
          backgroundColor: Colors.green,
        ),
      );
      _messageController.clear();
    } catch (e) {
      _showError('Firestore Error', 'Failed to create message: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _triggerTaskCreation() async {
    setState(() => _isLoading = true);
    _addToLogs('Triggering task creation event...');

    try {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': 'Demo Task ${DateTime.now().millisecondsSinceEpoch}',
        'completed': false,
        'userId': _currentUserId,
        'createdAt': FieldValue.serverTimestamp(),
        'priority': 'normal',
      });
      
      _addToLogs('Task document created - ready for onTaskUpdated trigger');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task created! Try completing it to trigger onTaskUpdated function.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      _showError('Firestore Error', 'Failed to create task: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Functions Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          Icon(
            Icons.cloud,
            color: _isLoading ? Colors.orange : Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            _isLoading ? 'Loading...' : 'Ready',
            style: TextStyle(
              color: _isLoading ? Colors.orange : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Fields Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Input Data',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _userIdController,
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Notification Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.notifications),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _bodyController,
                      decoration: const InputDecoration(
                        labelText: 'Notification Body',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.message),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message Text',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chat),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Callable Functions Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.call, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Callable Functions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _isLoading ? null : _callSayHello,
                          child: const Text('Say Hello'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _callGetUserProfile,
                          child: const Text('Get Profile'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _callSendNotification,
                          child: const Text('Send Notification'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _callHealthCheck,
                          child: const Text('Health Check'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _callEchoTest,
                          child: const Text('Echo Test'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Event-Based Functions Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.event, color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          'Event-Based Triggers',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _isLoading ? null : _triggerUserCreation,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Create User'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _triggerMessageCreation,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Create Message'),
                        ),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _triggerTaskCreation,
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          child: const Text('Create Task'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'These operations will trigger Cloud Functions automatically. Check Firebase Console → Functions → Logs to see execution.',
                        style: TextStyle(fontSize: 12, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Function Logs Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.history, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Function Logs',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => setState(() => _functionLogs.clear()),
                          icon: const Icon(Icons.clear),
                          tooltip: 'Clear logs',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _functionLogs.isEmpty
                          ? const Center(
                              child: Text(
                                'No function calls yet. Try calling a function!',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _functionLogs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    _functionLogs[index],
                                    style: const TextStyle(
                                      fontSize: 12,
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

            const SizedBox(height: 16),

            // Last Result Section
            if (_lastResult != null)
              Card(
                elevation: 4,
                color: Colors.purple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.data_object, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(
                            'Last Function Result',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.purple.shade200),
                        ),
                        child: Text(
                          _lastResult.toString(),
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
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
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthTestScreen extends StatefulWidget {
  @override
  _AuthTestScreenState createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends State<AuthTestScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _authService = AuthService();
  String _status = 'Not authenticated';
  String _userInfo = '';

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        if (user == null) {
          _status = 'User is signed out';
          _userInfo = '';
        } else {
          _status = 'User is signed in';
          _userInfo = 'Email: ${user.email}\nUID: ${user.uid}\nEmail Verified: ${user.emailVerified}';
        }
      });
    });
  }

  void _checkAuthStatus() {
    final user = _auth.currentUser;
    if (user == null) {
      setState(() {
        _status = 'User is signed out';
        _userInfo = '';
      });
    } else {
      setState(() {
        _status = 'User is signed in';
        _userInfo = 'Email: ${user.email}\nUID: ${user.uid}\nEmail Verified: ${user.emailVerified}';
      });
    }
  }

  Future<void> _testSignup() async {
    try {
      setState(() => _status = 'Creating test user...');
      
      final user = await _authService.signUp(
        'testuser${DateTime.now().millisecondsSinceEpoch}@example.com',
        'testpassword123',
      );
      
      if (user != null) {
        setState(() => _status = 'Test user created successfully!');
      } else {
        setState(() => _status = 'Failed to create test user');
      }
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
    }
  }

  Future<void> _testLogin() async {
    try {
      setState(() => _status = 'Logging in test user...');
      
      final user = await _authService.login(
        'testuser@example.com',
        'testpassword123',
      );
      
      if (user != null) {
        setState(() => _status = 'Login successful!');
      } else {
        setState(() => _status = 'Login failed');
      }
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
    }
  }

  Future<void> _testLogout() async {
    try {
      await _authService.logout();
      setState(() => _status = 'Logged out successfully');
    } catch (e) {
      setState(() => _status = 'Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth Test'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Authentication Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(_status),
                    if (_userInfo.isNotEmpty) ...[
                      SizedBox(height: 8),
                      Text(
                        _userInfo,
                        style: TextStyle(fontFamily: 'monospace'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testSignup,
              child: Text('Test Sign Up'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testLogin,
              child: Text('Test Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testLogout,
              child: Text('Test Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _checkAuthStatus,
              child: Text('Check Auth Status'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
            Spacer(),
            Card(
              color: Colors.yellow.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Instructions:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('1. Click "Test Sign Up" to create a new user'),
                    Text('2. Check Firebase Console → Authentication → Users'),
                    Text('3. Click "Test Logout" to sign out'),
                    Text('4. Click "Test Login" to sign back in'),
                    SizedBox(height: 8),
                    Text(
                      'Note: Each signup creates a unique email with timestamp',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
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

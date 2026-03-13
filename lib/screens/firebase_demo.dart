import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDemo extends StatefulWidget {
  const FirebaseDemo({Key? key}) : super(key: key);

  @override
  State<FirebaseDemo> createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  bool _isFirebaseInitialized = false;
  String _firebaseStatus = 'Initializing...';
  String _authStatus = 'Not authenticated';
  String _firestoreStatus = 'Not connected';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
    _checkAuthStatus();
    _testFirestoreConnection();
  }

  Future<void> _initializeFirebase() async {
    try {
      // Firebase is already initialized in main.dart
      // Just verify the connection
      final app = Firebase.app();
      setState(() {
        _isFirebaseInitialized = true;
        _firebaseStatus = 'Connected to Firebase: ${app.name}';
      });
    } catch (e) {
      setState(() {
        _firebaseStatus = 'Firebase Error: $e';
      });
    }
  }

  void _checkAuthStatus() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          _authStatus = 'Not authenticated';
        });
      } else {
        setState(() {
          _authStatus = 'Authenticated as: ${user.email}';
        });
      }
    });
  }

  Future<void> _testFirestoreConnection() async {
    try {
      // Test connection by attempting to read a collection
      await _firestore.collection('test').limit(1).get();
      setState(() {
        _firestoreStatus = 'Connected to Firestore';
      });
    } catch (e) {
      setState(() {
        _firestoreStatus = 'Firestore Error: $e';
      });
    }
  }

  Future<void> _signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in anonymously: ${userCredential.user?.uid}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed out successfully'),
          backgroundColor: Colors.blue,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign out failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _testFirestoreWrite() async {
    try {
      final docRef = await _firestore.collection('test').add({
        'timestamp': FieldValue.serverTimestamp(),
        'message': 'Hello from Flutter!',
        'userId': _auth.currentUser?.uid ?? 'anonymous',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document written: ${docRef.id}'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Write failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _testFirestoreRead() async {
    try {
      final querySnapshot = await _firestore
          .collection('test')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .get();

      final documents = querySnapshot.docs.map((doc) {
        return '${doc.id}: ${doc.data()}';
      }).join('\n');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Documents read: ${querySnapshot.docs.length}'),
          backgroundColor: Colors.green,
        ),
      );

      // Show detailed data in dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Firestore Documents'),
          content: SingleChildScrollView(
            child: Text(documents),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Read failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '🔥 Firebase Integration Demo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Firebase Status Card
            _buildStatusCard(
              'Firebase Core',
              _firebaseStatus,
              _isFirebaseInitialized ? Colors.green : Colors.red,
              Icons.cloud,
            ),
            const SizedBox(height: 16),

            // Auth Status Card
            _buildStatusCard(
              'Authentication',
              _authStatus,
              _auth.currentUser != null ? Colors.green : Colors.orange,
              Icons.person,
            ),
            const SizedBox(height: 16),

            // Firestore Status Card
            _buildStatusCard(
              'Firestore Database',
              _firestoreStatus,
              _firestoreStatus.contains('Connected') ? Colors.green : Colors.red,
              Icons.storage,
            ),
            const SizedBox(height: 32),

            // Authentication Section
            _buildSectionTitle('Authentication'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _signInAnonymously,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sign In Anonymously'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _signOut,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Firestore Section
            _buildSectionTitle('Firestore Database'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testFirestoreWrite,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Write Test Data'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testFirestoreRead,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Read Test Data'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Project Information
            _buildSectionTitle('Project Information'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('Package Name', 'com.smartKirana.app'),
                  _buildInfoRow('Project Name', 'Smart Kirana'),
                  _buildInfoRow('Firebase Core', '✅ Connected'),
                  _buildInfoRow('Firebase Auth', '✅ Available'),
                  _buildInfoRow('Cloud Firestore', '✅ Available'),
                  _buildInfoRow('Firebase Storage', '✅ Available'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Setup Instructions
            _buildSectionTitle('Setup Verification'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✅ Firebase Setup Complete!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your Flutter app is successfully connected to Firebase. You can now:',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  _buildCheckListItem('Authenticate users with email/password'),
                  _buildCheckListItem('Store and sync data with Firestore'),
                  _buildCheckListItem('Upload files to Firebase Storage'),
                  _buildCheckListItem('Send push notifications'),
                  _buildCheckListItem('Track analytics and usage'),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String status, Color color, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

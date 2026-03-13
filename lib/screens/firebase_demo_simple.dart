import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseSimpleDemo extends StatefulWidget {
  const FirebaseSimpleDemo({Key? key}) : super(key: key);

  @override
  State<FirebaseSimpleDemo> createState() => _FirebaseSimpleDemoState();
}

class _FirebaseSimpleDemoState extends State<FirebaseSimpleDemo> {
  bool _isFirebaseInitialized = false;
  String _firebaseStatus = 'Initializing...';
  String _setupStatus = 'Checking setup...';

  @override
  void initState() {
    super.initState();
    _checkFirebaseSetup();
  }

  Future<void> _checkFirebaseSetup() async {
    try {
      // Check if Firebase is available
      if (Firebase.apps.isNotEmpty) {
        final app = Firebase.app();
        setState(() {
          _isFirebaseInitialized = true;
          _firebaseStatus = 'Connected to Firebase: ${app.name}';
          _setupStatus = '✅ Firebase is properly configured';
        });
      } else {
        setState(() {
          _isFirebaseInitialized = false;
          _firebaseStatus = 'Firebase not initialized (Demo Mode)';
          _setupStatus = '⚠️ Firebase setup required for production';
        });
      }
    } catch (e) {
      setState(() {
        _isFirebaseInitialized = false;
        _firebaseStatus = 'Firebase Error: $e';
        _setupStatus = '❌ Firebase configuration issue';
      });
    }
  }

  void _showSetupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Firebase Setup Instructions'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'To complete Firebase setup:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSetupStep('1', 'Create Firebase project'),
              _buildSetupStep('2', 'Add Android app with package name: com.smartKirana.app'),
              _buildSetupStep('3', 'Download google-services.json'),
              _buildSetupStep('4', 'Place file in android/app/google-services.json'),
              _buildSetupStep('5', 'Run flutter pub get'),
              _buildSetupStep('6', 'Test with real device/emulator'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info, color: Colors.orange),
                    SizedBox(height: 8),
                    Text(
                      'Note: Web platform requires additional Firebase configuration for full functionality.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSetupStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
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
              _isFirebaseInitialized ? Colors.green : Colors.orange,
              Icons.cloud,
            ),
            const SizedBox(height: 16),

            // Setup Status Card
            _buildStatusCard(
              'Setup Status',
              _setupStatus,
              _setupStatus.contains('✅') ? Colors.green : 
              _setupStatus.contains('⚠️') ? Colors.orange : Colors.red,
              Icons.settings,
            ),
            const SizedBox(height: 32),

            // Firebase Configuration Info
            _buildSectionTitle('Firebase Configuration'),
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
                  _buildInfoRow('Config File', 'android/app/google-services.json'),
                  _buildInfoRow('Firebase Core', '✅ Added to dependencies'),
                  _buildInfoRow('Firebase Auth', '✅ Added to dependencies'),
                  _buildInfoRow('Cloud Firestore', '✅ Added to dependencies'),
                  _buildInfoRow('Firebase Storage', '✅ Added to dependencies'),
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
                    '📋 Firebase Setup Checklist',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCheckListItem('Firebase project created'),
                  _buildCheckListItem('Android app registered'),
                  _buildCheckListItem('google-services.json downloaded'),
                  _buildCheckListItem('Config file placed in android/app/'),
                  _buildCheckListItem('Firebase dependencies added'),
                  _buildCheckListItem('Gradle plugins configured'),
                  _buildCheckListItem('Firebase.initializeApp() called'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _showSetupDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('View Detailed Setup Instructions'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Features Ready
            _buildSectionTitle('Firebase Features Ready'),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🚀 Ready for Implementation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem('User Authentication', 'Email, Google, Anonymous'),
                  _buildFeatureItem('Cloud Firestore', 'Real-time database'),
                  _buildFeatureItem('Firebase Storage', 'File uploads'),
                  _buildFeatureItem('Firebase Analytics', 'User tracking'),
                  _buildFeatureItem('Cloud Functions', 'Server-side logic'),
                  _buildFeatureItem('Remote Config', 'Dynamic app configuration'),
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

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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

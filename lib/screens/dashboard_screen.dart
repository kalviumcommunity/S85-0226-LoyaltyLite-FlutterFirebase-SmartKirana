import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/auth_service.dart';
import '../services/fcm_service.dart';
import 'asset_demo_screen.dart';
import 'auth_test_screen.dart';
import 'locate_me_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key, required this.user});

  final User user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthService _authService = AuthService();
  final FcmService _fcmService = FcmService.instance;
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
    _fcmService.latestMessage.addListener(_onIncomingMessage);
  }

  @override
  void dispose() {
    _fcmService.latestMessage.removeListener(_onIncomingMessage);
    super.dispose();
  }

  void _onIncomingMessage() {
    if (!mounted) {
      return;
    }

    final message = _fcmService.latestMessage.value;
    if (message == null) {
      return;
    }

    final title = message.notification?.title ?? 'Daily Alert';
    final body = message.notification?.body ?? 'A new update is available.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $body'),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    if (_isSigningOut) {
      return;
    }

    setState(() => _isSigningOut = true);

    try {
      await _authService.logout();
    } on FirebaseAuthException catch (error) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: ${error.message ?? error.code}')),
      );
    } catch (_) {
      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logout failed. Please try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSigningOut = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartKirana Dashboard'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _isSigningOut ? null : () => _logout(context),
            icon: _isSigningOut
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.logout),
            tooltip: _isSigningOut ? 'Signing out...' : 'Logout',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Card
              Card(
                elevation: 8,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              widget.user.email ?? 'Shop Owner',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade800,
                              ),
                            ),
                            Text(
                              'UID: ${widget.user.uid.substring(0, 8)}...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 2,
                color: Colors.deepPurple.shade50,
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.verified_user, color: Colors.deepPurple),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Your Firebase session is active on this device. Restarting the app keeps you signed in until you use Logout.',
                          style: TextStyle(height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildDailyAlertCard(),
              const SizedBox(height: 24),
              
              // Stats Cards
              Text(
                'Business Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildStatCard(
                    Icons.people,
                    'Total Customers',
                    '1,234',
                    Colors.blue,
                  ),
                  _buildStatCard(
                    Icons.currency_rupee,
                    "Today's Revenue",
                    '₹12,450',
                    Colors.green,
                  ),
                  _buildStatCard(
                    Icons.card_giftcard,
                    'Active Rewards',
                    '8',
                    Colors.orange,
                  ),
                  _buildStatCard(
                    Icons.trending_up,
                    'Growth',
                    '+15%',
                    Colors.purple,
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade800,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildActionButton(
                context,
                Icons.image,
                'View Assets Demo',
                'Explore app assets and images',
                Colors.blue,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AssetDemoScreen()),
                  );
                },
              ),
              
              const SizedBox(height: 12),
              
              _buildActionButton(
                context,
                Icons.science,
                'Test Authentication',
                'Verify Firebase Auth functionality',
                Colors.green,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => AuthTestScreen()),
                  );
                },
              ),
              
              const SizedBox(height: 12),

              _buildActionButton(
                context,
                Icons.location_on,
                'Locate Me',
                'Open Google Map with your live GPS marker',
                Colors.red,
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LocateMeScreen()),
                  );
                },
              ),

              const SizedBox(height: 12),
              
              _buildActionButton(
                context,
                Icons.settings,
                'Settings',
                'Manage app preferences',
                Colors.grey,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings coming soon!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String title, String value, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyAlertCard() {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_active, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Text(
                  'Daily Alert (FCM)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Use this token to send "Shift Update" notification from Firebase Console.',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<NotificationSettings?>(
              valueListenable: _fcmService.permissionSettings,
              builder: (context, _, __) {
                return Text(
                  'Permission: ${_fcmService.permissionStatusLabel()}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                );
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<String?>(
              valueListenable: _fcmService.token,
              builder: (context, fcmToken, _) {
                return SelectableText(
                  'FCM Token: ${fcmToken ?? 'Fetching token...'}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade800,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await _fcmService.refreshToken();
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('FCM token refreshed.')),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Token'),
                ),
                OutlinedButton.icon(
                  onPressed: () async {
                    final currentToken = _fcmService.token.value;
                    if (currentToken == null || currentToken.isEmpty) {
                      if (!mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Token not available yet.')),
                      );
                      return;
                    }

                    await Clipboard.setData(ClipboardData(text: currentToken));
                    if (!mounted) {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('FCM token copied.')),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Token'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<String>(
              valueListenable: _fcmService.launchContext,
              builder: (context, stateText, _) {
                return Text(
                  'Last app state event: $stateText',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                );
              },
            ),
            const SizedBox(height: 6),
            ValueListenableBuilder<RemoteMessage?>(
              valueListenable: _fcmService.latestMessage,
              builder: (context, message, _) {
                final title = message?.notification?.title ?? '-';
                final body = message?.notification?.body ?? '-';

                return Text(
                  'Latest message: $title | $body',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color),
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
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

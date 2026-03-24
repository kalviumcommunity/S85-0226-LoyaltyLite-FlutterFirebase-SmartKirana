import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_providers.dart';

class ProviderSettingsScreen extends StatelessWidget {
  const ProviderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Settings Demo'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Settings
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme Settings',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Dark Mode'),
                          subtitle: Text(
                            themeProvider.themeMode == ThemeMode.dark 
                                ? 'Currently using dark theme'
                                : 'Currently using light theme',
                          ),
                          value: themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                          secondary: Icon(
                            themeProvider.themeMode == ThemeMode.dark 
                                ? Icons.dark_mode 
                                : Icons.light_mode,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // Settings Configuration
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'App Settings',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text('Push Notifications'),
                          subtitle: const Text('Enable push notifications'),
                          value: settingsProvider.notificationsEnabled,
                          onChanged: (value) {
                            settingsProvider.toggleNotifications();
                          },
                          secondary: Icon(
                            settingsProvider.notificationsEnabled 
                                ? Icons.notifications_active 
                                : Icons.notifications_off,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Font Size'),
                          subtitle: Text('${settingsProvider.fontSize.toStringAsFixed(1)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (settingsProvider.fontSize > 10) {
                                    settingsProvider.setFontSize(settingsProvider.fontSize - 1);
                                  }
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (settingsProvider.fontSize < 20) {
                                    settingsProvider.setFontSize(settingsProvider.fontSize + 1);
                                  }
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                );
              },
            ),
            
            const SizedBox(height: 16),
            
            // User Status
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Status',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: userProvider.isLoggedIn 
                                ? Colors.green 
                                : Colors.grey,
                            child: Icon(
                              userProvider.isLoggedIn 
                                  ? Icons.person 
                                  : Icons.person_outline,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            userProvider.isLoggedIn 
                                ? userProvider.name 
                                : 'Guest User',
                          ),
                          subtitle: Text(
                            userProvider.isLoggedIn 
                                ? userProvider.email 
                                : 'Not logged in',
                          ),
                          trailing: userProvider.isLoggedIn
                              ? ElevatedButton(
                                  onPressed: userProvider.logout,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Logout'),
                                )
                              : ElevatedButton(
                                  onPressed: () {
                                    userProvider.setUser('Demo User', 'demo@smartkirana.com');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Logged in successfully!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  child: const Text('Login'),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Provider Benefits
            Card(
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Provider State Management Benefits',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildBenefitItem('🔄 Automatic UI Updates', 
                        'UI automatically rebuilds when state changes'),
                    _buildBenefitItem('🌐 Global State Access', 
                        'Access state from anywhere in the app'),
                    _buildBenefitItem('🎯 Clean Architecture', 
                        'Separates business logic from UI'),
                    _buildBenefitItem('🧪 Easy Testing', 
                        'Test state logic independently'),
                    _buildBenefitItem('📱 Cross-Screen Sync', 
                        'State stays consistent across screens'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

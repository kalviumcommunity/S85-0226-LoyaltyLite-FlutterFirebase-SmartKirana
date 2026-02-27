import 'package:flutter/material.dart';

class NavigationSettingsScreen extends StatefulWidget {
  const NavigationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NavigationSettingsScreen> createState() => _NavigationSettingsScreenState();
}

class _NavigationSettingsScreenState extends State<NavigationSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoBackupEnabled = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'INR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ Settings'),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'App Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Configure your application preferences',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Settings Sections
              Expanded(
                child: ListView(
                  children: [
                    _buildSettingsSection('General Settings', [
                      _buildSwitchTile(
                        'Push Notifications',
                        'Receive notifications about rewards and offers',
                        _notificationsEnabled,
                        (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                          _showSnackBar(context, 
                            _notificationsEnabled ? 'Notifications enabled 🔔' : 'Notifications disabled 🔕');
                        },
                      ),
                      _buildSwitchTile(
                        'Dark Mode',
                        'Enable dark theme for the app',
                        _darkModeEnabled,
                        (value) {
                          setState(() {
                            _darkModeEnabled = value;
                          });
                          _showSnackBar(context, 
                            _darkModeEnabled ? 'Dark mode enabled 🌙' : 'Dark mode disabled ☀️');
                        },
                      ),
                      _buildSwitchTile(
                        'Auto Backup',
                        'Automatically backup data to cloud',
                        _autoBackupEnabled,
                        (value) {
                          setState(() {
                            _autoBackupEnabled = value;
                          });
                          _showSnackBar(context, 
                            _autoBackupEnabled ? 'Auto backup enabled ☁️' : 'Auto backup disabled 💾');
                        },
                      ),
                    ]),
                    
                    const SizedBox(height: 24),
                    
                    _buildSettingsSection('Preferences', [
                      _buildDropdownTile(
                        'Language',
                        'Choose your preferred language',
                        _selectedLanguage,
                        ['English', 'Hindi', 'Spanish', 'French'],
                        (value) {
                          setState(() {
                            _selectedLanguage = value;
                          });
                          _showSnackBar(context, 'Language changed to $value 🌐');
                        },
                      ),
                      _buildDropdownTile(
                        'Currency',
                        'Select your preferred currency',
                        _selectedCurrency,
                        ['INR', 'USD', 'EUR', 'GBP'],
                        (value) {
                          setState(() {
                            _selectedCurrency = value;
                          });
                          _showSnackBar(context, 'Currency changed to $value 💱');
                        },
                      ),
                    ]),
                    
                    const SizedBox(height: 24),
                    
                    _buildSettingsSection('Account', [
                      _buildActionTile(
                        'Edit Profile',
                        'Update your personal information',
                        Icons.person,
                        () {
                          _showSnackBar(context, 'Profile editing feature coming soon! 👤');
                        },
                      ),
                      _buildActionTile(
                        'Change Password',
                        'Update your account password',
                        Icons.lock,
                        () {
                          _showSnackBar(context, 'Password change feature coming soon! 🔒');
                        },
                      ),
                      _buildActionTile(
                        'Privacy Settings',
                        'Manage your privacy preferences',
                        Icons.security,
                        () {
                          _showSnackBar(context, 'Privacy settings feature coming soon! 🛡️');
                        },
                      ),
                    ]),
                    
                    const SizedBox(height: 24),
                    
                    _buildSettingsSection('Support', [
                      _buildActionTile(
                        'Help Center',
                        'Get help and support',
                        Icons.help,
                        () {
                          _showSnackBar(context, 'Help center feature coming soon! 🆘');
                        },
                      ),
                      _buildActionTile(
                        'About',
                        'App version and information',
                        Icons.info,
                        () {
                          Navigator.pushNamed(context, '/about');
                        },
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.grey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildDropdownTile(String title, String subtitle, String value, List<String> options, Function(String) onChanged) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          isDense: true,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildActionTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.grey,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/business_provider.dart';
import '../widgets/loading_view.dart';
import 'business_setup_screen.dart';
import 'dashboard_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.isInitializing) {
      return const Scaffold(body: LoadingView(message: 'Starting app...'));
    }
    if (auth.user == null) {
      return const LoginScreen();
    }

    final businessProvider = context.watch<BusinessProvider>();
    if (businessProvider.isLoading) {
      return const Scaffold(body: LoadingView(message: 'Loading business...'));
    }
    if (businessProvider.business == null) {
      return const BusinessSetupScreen();
    }
    return const DashboardScreen();
  }
}

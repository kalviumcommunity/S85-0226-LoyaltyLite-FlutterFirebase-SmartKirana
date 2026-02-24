import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/shop_owner/dashboard_screen.dart';
import 'screens/shop_owner/customer_management_screen.dart';
import 'screens/shop_owner/reward_management_screen.dart';
import 'screens/shop_owner/analytics_screen.dart';
import 'screens/customer/customer_dashboard_screen.dart';
import 'screens/customer/rewards_screen.dart';
import 'screens/customer/qr_scanner_screen.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize app
  runApp(const LoyalBazaarApp());
}

class LoyalBazaarApp extends StatelessWidget {
  const LoyalBazaarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoyalBazaar - लॉयल बाज़ार',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/shop/dashboard': (context) => const ShopDashboardScreen(),
        '/shop/customers': (context) => const CustomerManagementScreen(),
        '/shop/rewards': (context) => const RewardManagementScreen(),
        '/shop/analytics': (context) => const AnalyticsScreen(),
        '/customer/dashboard': (context) => const CustomerDashboardScreen(),
        '/customer/rewards': (context) => const RewardsScreen(),
        '/customer/qr-scanner': (context) => const QRScannerScreen(),
      },
    );
  }
}

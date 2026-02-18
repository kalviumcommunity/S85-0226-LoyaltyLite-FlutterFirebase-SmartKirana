import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/business_provider.dart';
import 'providers/customer_provider.dart';
import 'providers/transaction_provider.dart';
import 'screens/auth_gate.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoyaltyLiteApp());
}

class LoyaltyLiteApp extends StatelessWidget {
  const LoyaltyLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(context.read<AuthService>()),
        ),
        ChangeNotifierProxyProvider2<AuthProvider, FirestoreService,
            BusinessProvider>(
          create: (_) => BusinessProvider(),
          update: (_, auth, firestore, provider) {
            return provider!..updateDependencies(auth, firestore);
          },
        ),
        ChangeNotifierProxyProvider2<BusinessProvider, FirestoreService,
            CustomerProvider>(
          create: (_) => CustomerProvider(),
          update: (_, business, firestore, provider) {
            return provider!..updateDependencies(business, firestore);
          },
        ),
        ChangeNotifierProxyProvider2<BusinessProvider, FirestoreService,
            TransactionProvider>(
          create: (_) => TransactionProvider(),
          update: (_, business, firestore, provider) {
            return provider!..updateDependencies(business, firestore);
          },
        ),
      ],
      child: MaterialApp(
        title: 'LoyaltyLite',
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets Demo')),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dashboard_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/app_logo.png',
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'SmartKirana Loyalty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.people, color: Colors.blue, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.card_giftcard, color: Colors.orange, size: 30),
                      SizedBox(width: 10),
                      Icon(Icons.analytics, color: Colors.green, size: 30),
                      SizedBox(width: 10),
                      Icon(CupertinoIcons.heart_fill, color: Colors.red, size: 28),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icons/star.png', width: 24, height: 24),
                      const SizedBox(width: 10),
                      Image.asset('assets/icons/profile.png', width: 24, height: 24),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Assets + Material + Cupertino icons loaded successfully',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

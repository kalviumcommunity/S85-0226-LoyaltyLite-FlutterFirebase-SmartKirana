import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/app_text_field.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) {
      return 'Enter phone number with country code.';
    }
    if (!phone.startsWith('+') || phone.length < 10) {
      return 'Use country code, e.g. +91XXXXXXXXXX.';
    }
    return null;
  }

  String? _validateOtp(String? value) {
    final code = value?.trim() ?? '';
    if (code.isEmpty) {
      return 'Enter OTP.';
    }
    if (code.length < 4) {
      return 'OTP looks too short.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final otpSent = auth.verificationId != null;

    return Scaffold(
      appBar: AppBar(title: const Text('LoyaltyLite Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sign in with your phone number',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _phoneController,
                label: 'Phone number',
                hint: '+91XXXXXXXXXX',
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              if (otpSent) ...[
                const SizedBox(height: 12),
                AppTextField(
                  controller: _otpController,
                  label: 'OTP',
                  keyboardType: TextInputType.number,
                  validator: _validateOtp,
                ),
              ],
              const SizedBox(height: 16),
              if (auth.errorMessage != null)
                Text(
                  auth.errorMessage!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              const Spacer(),
              PrimaryButton(
                label: otpSent ? 'Verify OTP' : 'Send OTP',
                isLoading: auth.isLoading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  if (otpSent) {
                    await auth.verifyOtp(_otpController.text.trim());
                    if (!mounted) {
                      return;
                    }
                    if (auth.errorMessage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login successful.'),
                        ),
                      );
                    }
                  } else {
                    await auth.sendOtp(_phoneController.text.trim());
                    if (!mounted) {
                      return;
                    }
                    if (auth.errorMessage == null && auth.verificationId != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP sent successfully.'),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

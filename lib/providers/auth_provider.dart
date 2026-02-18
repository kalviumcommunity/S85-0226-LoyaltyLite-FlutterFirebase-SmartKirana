import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider(this._authService) {
    _authSubscription = _authService.authStateChanges().listen((user) {
      _user = user;
      _isInitializing = false;
      notifyListeners();
    });
  }

  final AuthService _authService;
  late final StreamSubscription<User?> _authSubscription;

  User? _user;
  bool _isLoading = false;
  bool _isInitializing = true;
  String? _errorMessage;
  String? _verificationId;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isInitializing => _isInitializing;
  String? get errorMessage => _errorMessage;
  String? get verificationId => _verificationId;

  Future<void> sendOtp(String phoneNumber) async {
    _setLoading(true);
    _errorMessage = null;
    _verificationId = null;
    try {
      _verificationId = await _authService.sendOtp(phoneNumber: phoneNumber);
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> verifyOtp(String smsCode) async {
    if (_verificationId == null) {
      _errorMessage = 'Please request an OTP first.';
      notifyListeners();
      return;
    }
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.verifyOtp(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signOut();
      _verificationId = null;
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}

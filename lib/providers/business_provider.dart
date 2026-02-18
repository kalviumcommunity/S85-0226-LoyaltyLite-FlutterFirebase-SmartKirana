import 'dart:async';

import 'package:flutter/material.dart';

import '../models/business.dart';
import '../services/firestore_service.dart';
import 'auth_provider.dart';

class BusinessProvider extends ChangeNotifier {
  AuthProvider? _authProvider;
  FirestoreService? _firestoreService;
  StreamSubscription<Business?>? _businessSubscription;

  Business? _business;
  bool _isLoading = false;
  String? _errorMessage;

  Business? get business => _business;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateDependencies(
    AuthProvider authProvider,
    FirestoreService firestoreService,
  ) {
    final previousUserId = _authProvider?.user?.uid;
    _authProvider = authProvider;
    _firestoreService = firestoreService;

    final currentUserId = _authProvider?.user?.uid;
    if (previousUserId != currentUserId) {
      _listenToBusiness();
    }
  }

  void _listenToBusiness() {
    _businessSubscription?.cancel();
    _business = null;
    final userId = _authProvider?.user?.uid;
    if (userId == null) {
      notifyListeners();
      return;
    }

    _setLoading(true);
    _businessSubscription = _firestoreService!
        .streamBusinessByOwner(userId)
        .listen((business) {
      _business = business;
      _setLoading(false);
    }, onError: (error) {
      _errorMessage = error.toString();
      _setLoading(false);
    });
  }

  Future<void> createBusiness({
    required String name,
    required int rewardRuleAmount,
    required int rewardRulePoints,
  }) async {
    final userId = _authProvider?.user?.uid;
    if (userId == null) {
      _errorMessage = 'User not logged in.';
      notifyListeners();
      return;
    }
    _setLoading(true);
    _errorMessage = null;
    try {
      final business = await _firestoreService!.createBusiness(
        ownerId: userId,
        name: name,
        rewardRuleAmount: rewardRuleAmount,
        rewardRulePoints: rewardRulePoints,
      );
      _business = business;
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
    _businessSubscription?.cancel();
    super.dispose();
  }
}

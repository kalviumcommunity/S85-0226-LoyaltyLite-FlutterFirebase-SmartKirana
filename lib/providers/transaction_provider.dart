import 'package:flutter/material.dart';

import '../models/customer.dart';
import '../models/loyalty_transaction.dart';
import '../services/firestore_service.dart';
import 'business_provider.dart';

class TransactionProvider extends ChangeNotifier {
  BusinessProvider? _businessProvider;
  FirestoreService? _firestoreService;

  bool _isSubmitting = false;
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  void updateDependencies(
    BusinessProvider businessProvider,
    FirestoreService firestoreService,
  ) {
    _businessProvider = businessProvider;
    _firestoreService = firestoreService;
  }

  Future<void> addTransaction({
    required Customer customer,
    required double amount,
    required TransactionType type,
  }) async {
    final business = _businessProvider?.business;
    if (business == null) {
      _errorMessage = 'Business not found.';
      notifyListeners();
      return;
    }
    _setSubmitting(true);
    _errorMessage = null;
    try {
      await _firestoreService!.addTransaction(
        business: business,
        customer: customer,
        amount: amount,
        type: type,
      );
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      _setSubmitting(false);
    }
  }

  void _setSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }
}

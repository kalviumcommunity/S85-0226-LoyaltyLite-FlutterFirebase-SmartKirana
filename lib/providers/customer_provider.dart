import 'dart:async';

import 'package:flutter/material.dart';

import '../models/customer.dart';
import '../services/firestore_service.dart';
import 'business_provider.dart';

class CustomerProvider extends ChangeNotifier {
  BusinessProvider? _businessProvider;
  FirestoreService? _firestoreService;
  StreamSubscription<List<Customer>>? _customersSubscription;

  List<Customer> _customers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get totalCustomers => _customers.length;
  int get totalPoints =>
      _customers.fold(0, (sum, customer) => sum + customer.totalPoints);

  void updateDependencies(
    BusinessProvider businessProvider,
    FirestoreService firestoreService,
  ) {
    final previousBusinessId = _businessProvider?.business?.id;
    _businessProvider = businessProvider;
    _firestoreService = firestoreService;

    final currentBusinessId = _businessProvider?.business?.id;
    if (previousBusinessId != currentBusinessId) {
      _listenToCustomers();
    }
  }

  void _listenToCustomers() {
    _customersSubscription?.cancel();
    _customers = [];
    final businessId = _businessProvider?.business?.id;
    if (businessId == null) {
      notifyListeners();
      return;
    }

    _setLoading(true);
    _customersSubscription =
        _firestoreService!.streamCustomers(businessId).listen((customers) {
      _customers = customers;
      _setLoading(false);
    }, onError: (error) {
      _errorMessage = error.toString();
      _setLoading(false);
    });
  }

  Future<void> addCustomer({
    required String name,
    required String phone,
  }) async {
    final businessId = _businessProvider?.business?.id;
    if (businessId == null) {
      _errorMessage = 'Business not found.';
      notifyListeners();
      return;
    }
    _setLoading(true);
    _errorMessage = null;
    try {
      await _firestoreService!.addCustomer(
        businessId: businessId,
        name: name,
        phone: phone,
      );
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
    _customersSubscription?.cancel();
    super.dispose();
  }
}

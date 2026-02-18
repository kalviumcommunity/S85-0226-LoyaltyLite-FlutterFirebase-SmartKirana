import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../core/constants.dart';
import '../models/business.dart';
import '../models/customer.dart';
import '../models/loyalty_transaction.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<Business?> streamBusinessByOwner(String ownerId) {
    return _firestore
        .collection(FirestoreCollections.businesses)
        .where('ownerId', isEqualTo: ownerId)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (kDebugMode) {
        debugPrint(
          'Firestore sync: business update received for owner=$ownerId, docs=${snapshot.docs.length}',
        );
      }
      if (snapshot.docs.isEmpty) {
        return null;
      }
      return Business.fromDoc(snapshot.docs.first);
    });
  }

  Future<Business> createBusiness({
    required String ownerId,
    required String name,
    required int rewardRuleAmount,
    required int rewardRulePoints,
  }) async {
    final doc = _firestore.collection(FirestoreCollections.businesses).doc();
    final business = Business(
      id: doc.id,
      ownerId: ownerId,
      name: name,
      rewardRuleAmount: rewardRuleAmount,
      rewardRulePoints: rewardRulePoints,
    );
    await doc.set({
      ...business.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return business;
  }

  Future<void> updateBusiness(Business business) async {
    await _firestore
        .collection(FirestoreCollections.businesses)
        .doc(business.id)
        .update({
      ...business.toMap(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Customer>> streamCustomers(String businessId) {
    return _firestore
        .collection(FirestoreCollections.customers)
        .where('businessId', isEqualTo: businessId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      if (kDebugMode) {
        debugPrint(
          'Firestore sync: customers update received for business=$businessId, docs=${snapshot.docs.length}',
        );
      }
      return snapshot.docs
          .map((doc) => Customer.fromDoc(doc))
          .toList(growable: false);
    });
  }

  Future<Customer> addCustomer({
    required String businessId,
    required String name,
    required String phone,
  }) async {
    final doc = _firestore.collection(FirestoreCollections.customers).doc();
    final customer = Customer(
      id: doc.id,
      businessId: businessId,
      name: name,
      phone: phone,
      totalPoints: 0,
    );
    await doc.set({
      ...customer.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return customer;
  }

  int calculatePoints(Business business, double amount) {
    if (business.rewardRuleAmount <= 0 || business.rewardRulePoints <= 0) {
      return 0;
    }
    final multiplier = (amount / business.rewardRuleAmount).floor();
    return multiplier * business.rewardRulePoints;
  }

  Future<int> addTransaction({
    required Business business,
    required Customer customer,
    required double amount,
    required TransactionType type,
  }) async {
    final points = calculatePoints(business, amount);
    if (points <= 0) {
      throw StateError('Amount too small to earn or redeem points.');
    }
    if (type == TransactionType.redeem && customer.totalPoints < points) {
      throw StateError('Not enough points to redeem.');
    }

    final signedPoints = type == TransactionType.earn ? points : -points;
    final transactionRef =
        _firestore.collection(FirestoreCollections.transactions).doc();
    final customerRef =
        _firestore.collection(FirestoreCollections.customers).doc(customer.id);
    final batch = _firestore.batch();

    batch.set(transactionRef, {
      'businessId': business.id,
      'customerId': customer.id,
      'amount': amount,
      'points': signedPoints,
      'type': type.value,
      'createdAt': FieldValue.serverTimestamp(),
    });

    batch.update(customerRef, {
      'totalPoints': FieldValue.increment(signedPoints),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await batch.commit();
    return signedPoints;
  }
}

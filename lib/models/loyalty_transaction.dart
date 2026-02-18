import 'package:cloud_firestore/cloud_firestore.dart';

enum TransactionType { earn, redeem }

extension TransactionTypeValue on TransactionType {
  String get value {
    switch (this) {
      case TransactionType.earn:
        return 'earn';
      case TransactionType.redeem:
        return 'redeem';
    }
  }

  static TransactionType fromValue(String value) {
    if (value == 'redeem') {
      return TransactionType.redeem;
    }
    return TransactionType.earn;
  }
}

class LoyaltyTransaction {
  final String id;
  final String businessId;
  final String customerId;
  final double amount;
  final int points;
  final TransactionType type;
  final DateTime? createdAt;

  const LoyaltyTransaction({
    required this.id,
    required this.businessId,
    required this.customerId,
    required this.amount,
    required this.points,
    required this.type,
    this.createdAt,
  });

  factory LoyaltyTransaction.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};
    return LoyaltyTransaction(
      id: doc.id,
      businessId: data['businessId'] ?? '',
      customerId: data['customerId'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      points: (data['points'] ?? 0) as int,
      type: TransactionTypeValue.fromValue(data['type'] ?? 'earn'),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'customerId': customerId,
      'amount': amount,
      'points': points,
      'type': type.value,
    };
  }
}

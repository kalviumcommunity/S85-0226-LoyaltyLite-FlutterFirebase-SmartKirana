class Transaction {
  final String id;
  final String customerId;
  final String shopId;
  final double amount;
  final int pointsEarned;
  final String type; // 'purchase', 'redemption', 'bonus'
  final String description;
  final DateTime createdAt;
  final String? paymentMethod;
  final String? orderId;

  Transaction({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.amount,
    this.pointsEarned = 0,
    required this.type,
    required this.description,
    required this.createdAt,
    this.paymentMethod,
    this.orderId,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      shopId: map['shopId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      pointsEarned: (map['pointsEarned'] ?? 0).toInt(),
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      paymentMethod: map['paymentMethod'],
      orderId: map['orderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'shopId': shopId,
      'amount': amount,
      'pointsEarned': pointsEarned,
      'type': type,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'paymentMethod': paymentMethod,
      'orderId': orderId,
    };
  }
}

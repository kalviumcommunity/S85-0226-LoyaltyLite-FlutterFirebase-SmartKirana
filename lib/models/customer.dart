import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String id;
  final String businessId;
  final String name;
  final String phone;
  final int totalPoints;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Customer({
    required this.id,
    required this.businessId,
    required this.name,
    required this.phone,
    required this.totalPoints,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Customer(
      id: doc.id,
      businessId: data['businessId'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      totalPoints: (data['totalPoints'] ?? 0) as int,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'businessId': businessId,
      'name': name,
      'phone': phone,
      'totalPoints': totalPoints,
    };
  }
}

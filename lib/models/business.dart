import 'package:cloud_firestore/cloud_firestore.dart';

class Business {
  final String id;
  final String ownerId;
  final String name;
  final int rewardRuleAmount;
  final int rewardRulePoints;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Business({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.rewardRuleAmount,
    required this.rewardRulePoints,
    this.createdAt,
    this.updatedAt,
  });

  factory Business.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Business(
      id: doc.id,
      ownerId: data['ownerId'] ?? '',
      name: data['name'] ?? '',
      rewardRuleAmount: (data['rewardRuleAmount'] ?? 0) as int,
      rewardRulePoints: (data['rewardRulePoints'] ?? 0) as int,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'rewardRuleAmount': rewardRuleAmount,
      'rewardRulePoints': rewardRulePoints,
    };
  }
}

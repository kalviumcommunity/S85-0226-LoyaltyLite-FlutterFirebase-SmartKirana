class Customer {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String? profileImage;
  final int totalPoints;
  final int availablePoints;
  final String? shopId;
  final DateTime createdAt;
  final DateTime lastVisitAt;
  final double totalSpent;
  final int visitCount;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.profileImage,
    this.totalPoints = 0,
    this.availablePoints = 0,
    this.shopId,
    required this.createdAt,
    required this.lastVisitAt,
    this.totalSpent = 0.0,
    this.visitCount = 1,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'],
      totalPoints: (map['totalPoints'] ?? 0).toInt(),
      availablePoints: (map['availablePoints'] ?? 0).toInt(),
      shopId: map['shopId'],
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      lastVisitAt: DateTime.parse(map['lastVisitAt'] ?? DateTime.now().toIso8601String()),
      totalSpent: (map['totalSpent'] ?? 0.0).toDouble(),
      visitCount: (map['visitCount'] ?? 1).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'profileImage': profileImage,
      'totalPoints': totalPoints,
      'availablePoints': availablePoints,
      'shopId': shopId,
      'createdAt': createdAt.toIso8601String(),
      'lastVisitAt': lastVisitAt.toIso8601String(),
      'totalSpent': totalSpent,
      'visitCount': visitCount,
    };
  }

  Customer copyWith({
    String? name,
    String? phone,
    String? email,
    String? profileImage,
    int? totalPoints,
    int? availablePoints,
    String? shopId,
    DateTime? lastVisitAt,
    double? totalSpent,
    int? visitCount,
  }) {
    return Customer(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      totalPoints: totalPoints ?? this.totalPoints,
      availablePoints: availablePoints ?? this.availablePoints,
      shopId: shopId ?? this.shopId,
      createdAt: createdAt,
      lastVisitAt: lastVisitAt ?? this.lastVisitAt,
      totalSpent: totalSpent ?? this.totalSpent,
      visitCount: visitCount ?? this.visitCount,
    );
  }
}

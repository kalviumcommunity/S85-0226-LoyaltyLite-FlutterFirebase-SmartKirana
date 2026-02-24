class ShopOwner {
  final String id;
  final String name;
  final String phone;
  final String shopName;
  final String location;
  final String email;
  final String? profileImage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLoginAt;

  ShopOwner({
    required this.id,
    required this.name,
    required this.phone,
    required this.shopName,
    required this.location,
    required this.email,
    this.profileImage,
    this.isActive = true,
    required this.createdAt,
    this.lastLoginAt,
  });

  factory ShopOwner.fromMap(Map<String, dynamic> map) {
    return ShopOwner(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      shopName: map['shopName'] ?? '',
      location: map['location'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profileImage'],
      isActive: map['isActive'] ?? true,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      lastLoginAt: map['lastLoginAt'] != null 
          ? DateTime.parse(map['lastLoginAt']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'shopName': shopName,
      'location': location,
      'email': email,
      'profileImage': profileImage,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
    };
  }

  ShopOwner copyWith({
    String? name,
    String? phone,
    String? shopName,
    String? location,
    String? email,
    String? profileImage,
    bool? isActive,
    DateTime? lastLoginAt,
  }) {
    return ShopOwner(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      shopName: shopName ?? this.shopName,
      location: location ?? this.location,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }
}

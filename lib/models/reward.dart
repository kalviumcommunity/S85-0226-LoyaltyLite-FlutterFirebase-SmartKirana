class Reward {
  final String id;
  final String shopId;
  final String name;
  final String description;
  final int pointsRequired;
  final String type; // 'product', 'discount', 'free_item', 'cashback'
  final String? imageUrl;
  final bool isActive;
  final DateTime? validUntil;
  final int? maxQuantity;
  final int currentQuantity;

  Reward({
    required this.id,
    required this.shopId,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.type,
    this.imageUrl,
    this.isActive = true,
    this.validUntil,
    this.maxQuantity,
    this.currentQuantity = 0,
  });

  factory Reward.fromMap(Map<String, dynamic> map) {
    return Reward(
      id: map['id'] ?? '',
      shopId: map['shopId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pointsRequired: (map['pointsRequired'] ?? 0).toInt(),
      type: map['type'] ?? '',
      imageUrl: map['imageUrl'],
      isActive: map['isActive'] ?? true,
      validUntil: map['validUntil'] != null 
          ? DateTime.parse(map['validUntil']) 
          : null,
      maxQuantity: map['maxQuantity']?.toInt(),
      currentQuantity: (map['currentQuantity'] ?? 0).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'name': name,
      'description': description,
      'pointsRequired': pointsRequired,
      'type': type,
      'imageUrl': imageUrl,
      'isActive': isActive,
      'validUntil': validUntil?.toIso8601String(),
      'maxQuantity': maxQuantity,
      'currentQuantity': currentQuantity,
    };
  }

  bool get isAvailable {
    if (!isActive) return false;
    if (validUntil != null && DateTime.now().isAfter(validUntil!)) return false;
    if (maxQuantity != null && currentQuantity >= maxQuantity!) return false;
    return true;
  }

  Reward copyWith({
    String? name,
    String? description,
    int? pointsRequired,
    String? type,
    String? imageUrl,
    bool? isActive,
    DateTime? validUntil,
    int? maxQuantity,
    int? currentQuantity,
  }) {
    return Reward(
      id: id,
      shopId: shopId,
      name: name ?? this.name,
      description: description ?? this.description,
      pointsRequired: pointsRequired ?? this.pointsRequired,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      validUntil: validUntil ?? this.validUntil,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      currentQuantity: currentQuantity ?? this.currentQuantity,
    );
  }
}

/// Represents a product entity used in the domain layer.
class ProductEntity {
  final String id;
  final String name;
  final DateTime createdAt;
  final double price;
  final String description;
  final bool isFavorite;
  final bool discount;
   final double? rating;
  final String? imageUrl;
  final UserEntity user;
  final int reviewCount; // Added review count field

  ProductEntity({
    required this.id,
    required this.name,
    required this.isFavorite,
    required this.rating,
    required this.discount,
    required this.createdAt,
    required this.price,
    required this.description,
    this.imageUrl,
    required this.user,
    required this.reviewCount, // Added to constructor
  });

  /// Converts the ProductEntity to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'user': user.toJson(),
      'reviewCount': reviewCount, // Added to JSON map
    };
  }
}

/// Represents a category entity used in the domain layer.
// class CategoryEntity {
//   final String id;
//   final String name;
//   final List<String>? attributes;
//   final String? imageUrl;
//   final String description;

//   CategoryEntity({
//     required this.id,
//     required this.name,
//     this.attributes,
//     this.imageUrl,
//     required this.description,
//   });

//   /// Converts the CategoryEntity to a JSON-compatible map.
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'attributes': attributes,
//       'imageUrl': imageUrl,
//       'description': description,
//     };
//   }
// }

/// Represents a user entity used in the domain layer.
class UserEntity {
  final String id;
  final String name;
  final String email;
  final bool verified;
  final String phone;
  final String? profilePicture;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.verified,
    required this.phone,
    this.profilePicture,
  });

  /// Creates a UserEntity from a JSON map.
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      verified: json['verified'] as bool? ?? true,
      phone: json['phone']?.toString() ?? '',
      profilePicture: json['profilePicture']?.toString(),
    );
  }

  /// Converts the UserEntity to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'verified': verified,
      'phone': phone,
      'profilePicture': profilePicture,
    };
  }
}

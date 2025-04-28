class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String? imageUrl;
  final String listingType;
  final String? brokerageType;
  final Map<String, dynamic> attributes;
  final String subSubcategoryId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
    required this.listingType,
    this.brokerageType,
    required this.attributes,
    required this.subSubcategoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] is num ? json['price'].toDouble() : 0.0),
      description: json['description']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString(),
      listingType: json['listingType']?.toString() ?? '',
      brokerageType: json['brokerageType']?.toString(),
      attributes: json['attributes'] is Map
          ? Map<String, dynamic>.from(json['attributes'])
          : {},
      subSubcategoryId: json['subSubcategoryId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

class Category {
  final String id;
  final String name;
  final Map<String, dynamic> attributes;
  final String? imageUrl;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.attributes,
    this.imageUrl,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      attributes: json['attributes'] is Map
          ? Map<String, dynamic>.from(json['attributes'])
          : {'options': []},
      imageUrl: json['imageUrl']?.toString(),
      description: json['description']?.toString() ?? '',
    );
  }

  get subcategories => null;
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      profilePicture: json['profilePicture']?.toString(),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.now(),
    );
  }
}

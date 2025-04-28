class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String location;
  final List<String>
      imageUrl; // Changed to List<String> to match ProductDetailScreen
  final String listingType;
  final String? brokerageType;
  final String brand;
  final int stock;
  final double rating;
  final List<String> tags;
  final Map<String, dynamic> attributes;
  final String subSubcategoryId;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SubSubcategory subSubcategory;
  final double? discount; // Nullable to support products without discounts

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.listingType,
    this.brokerageType,
    required this.brand,
    required this.stock,
    required this.rating,
    required this.tags,
    required this.attributes,
    required this.subSubcategoryId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.subSubcategory,
    this.discount,
  });

  // Getter to calculate discounted price
  double? get discountedPrice {
    if (discount != null && discount! > 0) {
      return price * (1 - discount! / 100);
    }
    return null;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? (throw FormatException('Product ID is null')),
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      imageUrl:
          List<String>.from(json['imageUrl'] ?? []), // Parse as List<String>
      listingType: json['listingType'] ?? 'default',
      brokerageType: json['brokerageType'],
      brand: json['brand'] ?? '',
      stock: json['stock'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      tags: List<String>.from(json['tags'] ?? []),
      attributes: Map<String, dynamic>.from(json['attributes'] ?? {}),
      subSubcategoryId: json['subSubcategoryId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      subSubcategory: SubSubcategory.fromJson(json['subSubcategory'] ?? {}),
      discount: json['discountPercentage'] != null
          ? (json['discountPercentage'] as num?)?.toDouble()
          : null,
    );
  }
}

class SubSubcategory {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String imageUrl;
  final SubCategory subCategory;
  final ParentCategory parentCategory;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubSubcategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.imageUrl,
    required this.subCategory,
    required this.parentCategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubSubcategory.fromJson(Map<String, dynamic> json) {
    return SubSubcategory(
      id: json['id'] ?? (throw FormatException('SubSubcategory ID is null')),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      subCategory: SubCategory.fromJson(json['subCategory'] ?? {}),
      parentCategory: ParentCategory.fromJson(json['parentCategory'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String slug;

  SubCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'] ?? (throw FormatException('SubCategory ID is null')),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

class ParentCategory {
  final String id;
  final String name;
  final String slug;

  ParentCategory({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory ParentCategory.fromJson(Map<String, dynamic> json) {
    return ParentCategory(
      id: json['id'] ?? (throw FormatException('ParentCategory ID is null')),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
    );
  }
}

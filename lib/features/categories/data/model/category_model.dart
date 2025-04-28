import 'package:delala/features/categories/domain/entities/category.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<Subcategory> subcategories;
  final List<String> options;
  final String priceRange;
  final double rating;
  final bool isFeatured;
  final int stockCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.subcategories,
    required this.options,
    required this.priceRange,
    required this.rating,
    required this.isFeatured,
    required this.stockCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    final subcategoriesJson = json['subcategories'] as List<dynamic>? ?? [];
    final subcategoriesList = subcategoriesJson
        .map((subcategoryJson) => Subcategory.fromJson(subcategoryJson))
        .toList();

    return Category(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      subcategories: subcategoriesList,
      options: List<String>.from(json['attributes']['options'] ?? []),
      priceRange: json['priceRange'] as String,
      rating: (json['rating'] as num).toDouble(),
      isFeatured: json['isFeatured'] as bool,
      stockCount: json['stockCount'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // 🔁 Entity Mapper
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      subcategories: subcategories.map((s) => s.toEntity()).toList(),
      options: options,
      priceRange: priceRange,
      rating: rating,
      isFeatured: isFeatured,
      stockCount: stockCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Subcategory {
  final String id;
  final String parentId;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, dynamic> attributes;
  final String priceRange;
  final double rating;
  final bool isFeatured;
  final int stockCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  Subcategory({
    required this.id,
    required this.parentId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.attributes,
    required this.priceRange,
    required this.rating,
    required this.isFeatured,
    required this.stockCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] as String,
      parentId: json['parentId'] ?? '', // fallback empty if not found
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      attributes: json['attributes'] ?? {}, // fallback empty map
      priceRange: json['priceRange'] as String,
      rating: (json['rating'] as num).toDouble(),
      isFeatured: json['isFeatured'] as bool,
      stockCount: json['stockCount'] as int,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // 🔁 Entity Mapper
  SubcategoryEntity toEntity() {
    return SubcategoryEntity(
      id: id,
      parentId: parentId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      attributes: attributes,
      priceRange: priceRange,
      rating: rating,
      isFeatured: isFeatured,
      stockCount: stockCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      options: [],
    );
  }
}

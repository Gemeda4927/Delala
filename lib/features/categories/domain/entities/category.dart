// domain/entities/category_entity.dart
class CategoryEntity {
  final String id;
  final String? parentId;
  final String name;
  final String description;
  final String imageUrl;
  final List<SubcategoryEntity> subcategories;
  final List<String> options;
  final String priceRange;
  final double rating;
  final bool isFeatured;
  final int stockCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
    this.parentId,
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

  where(bool Function(dynamic cat) param0) {}
}

// domain/entities/subcategory_entity.dart
class SubcategoryEntity {
  final String id;
  final String parentId;
  final String name;
  final String description;
  final String imageUrl;
  final Map<String, dynamic> attributes;
  final List<String> options;
  final String priceRange;
  final double rating;
  final bool isFeatured;
  final int stockCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubcategoryEntity({
    required this.id,
    required this.parentId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.attributes,
    required this.options,
    required this.priceRange,
    required this.rating,
    required this.isFeatured,
    required this.stockCount,
    required this.createdAt,
    required this.updatedAt,
  });
}

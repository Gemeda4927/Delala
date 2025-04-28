// Category Event
abstract class CategoryEvent {
  const CategoryEvent();
}

class FetchCategories extends CategoryEvent {}

class FetchSubcategories extends CategoryEvent {
  final String categoryId;

  const FetchSubcategories(this.categoryId);
}

class FetchCategoryById extends CategoryEvent {
  final String categoryId;

  const FetchCategoryById(this.categoryId);
}

class FetchSubcategoryById extends CategoryEvent {
  final String subcategoryId;

  const FetchSubcategoryById(this.subcategoryId);
}

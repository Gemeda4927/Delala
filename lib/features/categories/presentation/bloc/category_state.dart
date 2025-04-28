// Category State
import 'package:delala/features/categories/domain/entities/category.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoriesLoaded(this.categories);
}

class SubcategoriesLoaded extends CategoryState {
  final List<SubcategoryEntity> subcategories;

  const SubcategoriesLoaded(this.subcategories);
}

class CategoryLoaded extends CategoryState {
  final CategoryEntity category;

  const CategoryLoaded(this.category);
}

class SubcategoryLoaded extends CategoryState {
  final SubcategoryEntity subcategory;

  const SubcategoryLoaded(this.subcategory);
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);
}

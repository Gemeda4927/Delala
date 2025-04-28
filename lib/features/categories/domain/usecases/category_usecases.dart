// domain/usecases/category_usecases.dart
import 'package:dartz/dartz.dart';
import 'package:delala/core/error/failures.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/domain/repositories/category_repository.dart';

/// Use case for fetching all categories.
class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}

/// Use case for fetching subcategories of a specific category.
class GetSubcategoriesUseCase {
  final CategoryRepository repository;

  GetSubcategoriesUseCase(this.repository);

  Future<Either<Failure, List<SubcategoryEntity>>> call(
      String categoryId) async {
    return await repository.getSubcategories(categoryId);
  }
}

/// Use case for fetching a single category by its ID.
class GetCategoryByIdUseCase {
  final CategoryRepository repository;

  GetCategoryByIdUseCase(this.repository);

  Future<Either<Failure, CategoryEntity>> call(String categoryId) async {
    return await repository.getCategoryById(categoryId);
  }
}

/// Use case for fetching a single subcategory by its ID.
class GetSubcategoryByIdUseCase {
  final CategoryRepository repository;

  GetSubcategoryByIdUseCase(this.repository);

  Future<Either<Failure, SubcategoryEntity>> call(String subcategoryId) async {
    return await repository.getSubcategoryById(subcategoryId);
  }
}

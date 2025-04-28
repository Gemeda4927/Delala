import 'package:dartz/dartz.dart';
import 'package:delala/core/error/failures.dart';
import 'package:delala/features/categories/domain/entities/category.dart';

abstract class CategoryRepository {
  // Fetches a list of all categories
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  // Fetches a list of subcategories for a given category ID
  Future<Either<Failure, List<SubcategoryEntity>>> getSubcategories(
      String categoryId);

  // Fetches a single category by its ID
  Future<Either<Failure, CategoryEntity>> getCategoryById(String categoryId);

  // Fetches a single subcategory by its ID
  Future<Either<Failure, SubcategoryEntity>> getSubcategoryById(
      String subcategoryId);
}

import 'package:dartz/dartz.dart';
import 'package:delala/core/error/failures.dart';
import 'package:delala/features/categories/data/model/category_model.dart';
import 'package:delala/features/categories/data/services/category.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService categoryService;

  CategoryRepositoryImpl({required this.categoryService});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await categoryService.fetchCategories();
      final categoryEntities = categories.map((c) => c.toEntity()).toList();
      return Right(categoryEntities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubcategoryEntity>>> getSubcategories(
      String categoryId) async {
    try {
      final subcategories =
          await categoryService.fetchSubcategories(categoryId);
      final subcategoryEntities =
          subcategories.map((s) => s.toEntity()).toList();
      return Right(subcategoryEntities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CategoryEntity>> getCategoryById(
      String categoryId) async {
    try {
      final category = await categoryService.fetchCategoryById(categoryId);
      return Right(category.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubcategoryEntity>> getSubcategoryById(
      String subcategoryId) async {
    try {
      final subcategory =
          await categoryService.fetchSubcategoryById(subcategoryId);
      return Right(subcategory.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

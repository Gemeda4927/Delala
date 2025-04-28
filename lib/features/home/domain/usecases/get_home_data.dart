import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/home/domain/repositories/home_repository.dart';

/// Use case for fetching products from the repository.
class GetProductsUseCase {
  final HomeRepository _repository;

  GetProductsUseCase(this._repository);

  /// Fetches a list of products from the repository.
  Future<List<ProductEntity>> execute() async {
    return await _repository.getProducts();
  }
}

/// Use case for fetching categories from the repository.
class GetCategoriesUseCase {
  final HomeRepository _repository;

  GetCategoriesUseCase(this._repository);

  /// Fetches a list of categories from the repository.
  Future<List<CategoryEntity>> execute() async {
    return await _repository.getCategories();
  }
}

/// Use case for fetching users from the repository.
class GetUserUseCase {
  final HomeRepository _repository;

  GetUserUseCase(this._repository);

  /// Fetches a list of users from the repository.
  Future<List<UserEntity>> execute() async {
    return await _repository.getUser();
  }
}
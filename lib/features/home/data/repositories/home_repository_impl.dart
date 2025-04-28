import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/data/service/home_services.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService _apiService;

  HomeRepositoryImpl(this._apiService);

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final products = await _apiService.fetchProducts();

      final productEntities = products
          .map(
            (product) => ProductEntity(
              id: product.id,
              name: product.name,
              createdAt: product.createdAt,
              price: product.price,
              description: product.description,
              imageUrl: product.imageUrl,
              user: UserEntity.fromJson(
                product.userId is Map<String, dynamic>
                    ? product.userId as Map<String, dynamic>
                    : <String, dynamic>{}, // Fallback for invalid user data
              ),
              isFavorite: true,
              discount: true,
              reviewCount: 10,
              rating: 10,
            ),
          )
          .toList();

      return productEntities;
    } catch (e) {
      rethrow; // Propagate to HomeBloc for error handling
    }
  }

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      final categories = await _apiService.fetchCategories();

      final categoryEntities = categories.map((category) {
        // Extract attributes['options'] as List<String>
        final attributes = category.attributes['options'] is List
            ? List<String>.from(category.attributes['options'] as List)
            : <String>[]; // Empty list if attributes are invalid

        return CategoryEntity(
          id: category.id,
          name: category.name,
          imageUrl: category.imageUrl ?? '',
          description: category.description,
          subcategories: [],
          options: [],
          priceRange: '',
          rating: 10,
          isFeatured: true,
          stockCount: 10,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }).toList();

      return categoryEntities;
    } catch (e) {
      rethrow; // Propagate to HomeBloc for error handling
    }
  }

  @override
  Future<List<UserEntity>> getUser() async {
    try {
      final users = await _apiService.fetchUsers();

      final userEntities = users
          .map(
            (user) => UserEntity.fromJson(
              user is Map<String, dynamic>
                  ? user as Map<String, dynamic>
                  : <String, dynamic>{}, // Fallback for invalid user data
            ),
          )
          .toList();

      return userEntities;
    } catch (e) {
      rethrow; // Propagate to HomeBloc for error handling
    }
  }
}

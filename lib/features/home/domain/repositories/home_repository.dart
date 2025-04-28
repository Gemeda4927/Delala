import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<List<ProductEntity>> getProducts();
  Future<List<CategoryEntity>> getCategories();
  Future<List<UserEntity>> getUser(); // Fixed return type
}

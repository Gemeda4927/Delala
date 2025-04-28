import 'package:delala/features/products/data/models/products.dart';

abstract class ProductRepository {
  /// Fetches a product by its ID.
  /// Returns a [Product] object, falling back to dummy data on failure.
  Future<Product> getProduct(String productId);

  /// Fetches a list of products by category ID.
  /// Returns a [List<Product>] object, falling back to an empty list on failure.
  Future<List<Product>> getProducts(String categoryId);
}
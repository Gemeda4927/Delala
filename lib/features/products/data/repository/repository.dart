import 'package:delala/features/products/data/models/products.dart';
import 'package:delala/features/products/data/services/products.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductService _productService;

  ProductRepositoryImpl({required ProductService productService})
      : _productService = productService;

  @override
  Future<Product> getProduct(String productId) async {
    return await _productService.fetchProduct(productId);
  }

  @override
  Future<List<Product>> getProducts(String categoryId) async {
    return await _productService.fetchProductsByCategory(categoryId);
  }
}

import 'package:delala/features/products/data/models/products.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';

class GetProductUseCase {
  final ProductRepository productRepository;

  GetProductUseCase({required this.productRepository});

  /// Fetches a product by its ID.
  /// Returns a [Product] object, falling back to dummy data on failure.
  Future<Product> execute(String productId) async {
    try {
      final product = await productRepository.getProduct(productId);
      return product;
    } catch (e, stackTrace) {
      print(
          "Error fetching product for ID $productId: $e\nStackTrace: $stackTrace");
      // In case of an error, return a fallback dummy product
      return _dummyProduct();
    }
  }

  // Customizable fallback data
  Product _dummyProduct() {
    return Product(
      id: 'dummy-id',
      name: 'Fallback Product',
      location: 'Jimma',
      price: 99.99,
      description: 'This is a fallback product description.',
      imageUrl: ['https://via.placeholder.com/150'], // Fixed to List<String>
      listingType: 'ECOMMERCE',
      brokerageType: null,
      brand: 'Fallback Brand',
      stock: 100,
      rating: 4.0,
      tags: ['dummy', 'fallback'],
      attributes: {},
      subSubcategoryId: 'dummy-subcategory-id',
      userId: 'dummy-user-id',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      subSubcategory: SubSubcategory(
        id: 'dummy-sub-subcategory-id',
        name: 'Fallback Subcategory',
        slug: 'fallback-slug',
        description: 'Fallback subcategory description',
        imageUrl: 'https://via.placeholder.com/150',
        subCategory: SubCategory(
          id: 'dummy-subcategory-id',
          name: 'Fallback Subcategory',
          slug: 'fallback-subcategory',
        ),
        parentCategory: ParentCategory(
          id: 'dummy-parent-category-id',
          name: 'Fallback Parent Category',
          slug: 'fallback-parent-category',
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }
}

class GetProductsUseCase {
  final ProductRepository productRepository;

  GetProductsUseCase({required this.productRepository});

  /// Fetches a list of products by category ID.
  /// Returns a [List<Product>] object, falling back to an empty list on failure.
  Future<List<Product>> execute(String categoryId) async {
    try {
      final products = await productRepository.getProducts(categoryId);
      return products;
    } catch (e, stackTrace) {
      print(
          "Error fetching products for category $categoryId: $e\nStackTrace: $stackTrace");
      // In case of an error, return an empty list
      return [];
    }
  }
}

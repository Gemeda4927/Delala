import 'dart:developer';

import 'package:delala/features/products/data/models/products.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio _dio;
  static const String _baseUrl = 'https://api.example.com'; // TODO: Replace with your API base URL

  ProductService({Dio? dio})
      : _dio = dio ?? Dio(
          BaseOptions(
            baseUrl: _baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        );

  // === API Calls ===

  /// Fetches a product by ID from the API.
  /// Returns a [Product] object, falling back to dummy data on failure.
  Future<Product> fetchProduct(String productId) async {
    try {
      log('ProductService - Fetching product with ID: $productId');
      final response = await _dio.get('/products/$productId');

      if (response.statusCode == 200 && response.data != null) {
        log('ProductService - Product fetched successfully');
        return Product.fromJson(response.data);
      } else {
        throw Exception('Invalid response: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log(
        'ProductService - Failed to fetch product for ID $productId: $e',
        stackTrace: stackTrace,
      );
      return _getDummyProduct();
    }
  }

  /// Fetches a list of products by category ID from the API.
  /// Returns a [List<Product>] object, falling back to dummy data or an empty list on failure.
  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      log('ProductService - Fetching products for category: $categoryId with subSubcategoryId');
      final response = await _dio.get(
        '/products',
        queryParameters: {'subSubcategoryId': categoryId},
      );

      log('ProductService - API response: ${response.statusCode}, data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final productList = response.data is List
            ? response.data
            : response.data['products'] ?? [];

        final products = (productList as List<dynamic>)
            .map((json) => Product.fromJson(json))
            .toList();

        log('ProductService - Fetched ${products.length} products');
        return products;
      } else {
        throw Exception('Invalid response: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log(
        'ProductService - Failed to fetch products with subSubcategoryId $categoryId: $e',
        stackTrace: stackTrace,
      );

      // Retry with categoryId
      try {
        log('ProductService - Retrying with categoryId');
        final response = await _dio.get(
          '/products',
          queryParameters: {'categoryId': categoryId},
        );

        log('ProductService - Retry response: ${response.statusCode}, data: ${response.data}');

        if (response.statusCode == 200 && response.data != null) {
          final productList = response.data is List
              ? response.data
              : response.data['products'] ?? [];

          final products = (productList as List<dynamic>)
              .map((json) => Product.fromJson(json))
              .toList();

          log('ProductService - Fetched ${products.length} products with categoryId');
          return products;
        }
      } catch (retryError, retryStackTrace) {
        log(
          'ProductService - Retry failed with categoryId $categoryId: $retryError',
          stackTrace: retryStackTrace,
        );
      }

      // Return dummy products for specific category
      if (categoryId == 'cat_fashion_001') {
        log('ProductService - Returning dummy products for cat_fashion_001');
        return _getDummyProductsForFashion();
      }
      return [];
    }
  }

  // === Dummy Data ===

  /// Returns dummy single product for fallback.
  Product _getDummyProduct() {
    final dummyJson = {
      'id': '680205497a62f06598b66d12',
      'name': 'iPhone 15',
      'price': 300,
      'description':
          'A premium Apple smartphone with a 6.1-inch Super Retina XDR display, A16 Bionic chip, 48MP main camera, and 128GB storage.',
      'imageUrl': [
        'https://images.unsplash.com/photo-1695409504068-7f6992dbce28?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1695634682508-975b1e3727ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      ],
      'listingType': 'ECOMMERCE',
      'brokerageType': null,
      'brand': 'Apple',
      'stock': 50,
      'rating': 4.5,
      'tags': ['smartphone', 'Apple', 'iPhone', '5G'],
      'attributes': {
        'storage': '128GB',
        'color': 'Black',
        'screenSize': '6.1 inches',
        'processor': 'A16 Bionic',
        'camera': '48MP Main + 12MP Ultra Wide',
        'os': 'iOS 17',
      },
      'subSubcategoryId': '67e6632fb084e36436006225',
      'userId': '67d3e3513991865850d7ede2',
      'createdAt': '2025-04-18T07:54:49.314Z',
      'updatedAt': '2025-04-18T07:54:49.314Z',
      'subSubcategory': {
        'id': '67e6632fb084e36436006225',
        'name': 'Smartphones',
        'slug': 'smartphones',
        'description':
            'Mobile devices with advanced computing capabilities and connectivity features.',
        'imageUrl':
            'https://images.unsplash.com/photo-1511707171634-5f897206d7e9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'subCategory': {
          'id': '67e6632fb084e36436006220',
          'name': 'Electronics',
          'slug': 'electronics',
        },
        'parentCategory': {
          'id': '67e6632fb084e36436006215',
          'name': 'Consumer Electronics',
          'slug': 'consumer-electronics',
        },
        'createdAt': '2025-04-01T10:00:00Z',
        'updatedAt': '2025-04-18T07:54:49Z',
      },
    };

    return Product.fromJson(dummyJson);
  }

  /// Returns dummy products list for fashion category fallback.
  List<Product> _getDummyProductsForFashion() {
    final dummyJsonList = [
      {
        'id': 'fashion001',
        'name': 'Summer Dress',
        'price': 59.99,
        'description':
            'A stylish summer dress with floral patterns, perfect for casual outings.',
        'imageUrl': [
          'https://images.unsplash.com/photo-1594633312681-68b5b1f6b8b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1583744946564-b52acbc6e0c9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
        'listingType': 'ECOMMERCE',
        'brokerageType': null,
        'brand': 'Zara',
        'stock': 100,
        'rating': 4.7,
        'tags': ['dress', 'fashion', 'summer', 'casual'],
        'attributes': {
          'size': 'M',
          'color': 'Floral Blue',
          'material': 'Cotton',
        },
        'subSubcategoryId': 'cat_fashion_001',
        'userId': '67d3e3513991865850d7ede2',
        'createdAt': '2025-04-18T07:54:49.314Z',
        'updatedAt': '2025-04-18T07:54:49.314Z',
        'subSubcategory': {
          'id': 'cat_fashion_001',
          'name': 'Women\'s Clothing',
          'slug': 'womens-clothing',
          'description': 'Trendy clothing for women.',
          'imageUrl':
              'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'subCategory': {
            'id': 'fashion_sub_001',
            'name': 'Fashion',
            'slug': 'fashion',
          },
          'parentCategory': {
            'id': 'fashion_parent_001',
            'name': 'Apparel',
            'slug': 'apparel',
          },
          'createdAt': '2025-04-01T10:00:00Z',
          'updatedAt': '2025-04-18T07:54:49Z',
        },
      },
      {
        'id': 'fashion002',
        'name': 'Leather Jacket',
        'price': 129.99,
        'description': 'A sleek leather jacket for a bold and edgy look.',
        'imageUrl': [
          'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'https://images.unsplash.com/photo-1544027995-7a2d06e45056?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        ],
        'listingType': 'ECOMMERCE',
        'brokerageType': null,
        'brand': 'H&M',
        'stock': 30,
        'rating': 4.3,
        'tags': ['jacket', 'fashion', 'leather', 'winter'],
        'attributes': {
          'size': 'L',
          'color': 'Black',
          'material': 'Faux Leather',
        },
        'subSubcategoryId': 'cat_fashion_001',
        'userId': '67d3e3513991865850d7ede2',
        'createdAt': '2025-04-18T07:54:49.314Z',
        'updatedAt': '2025-04-18T07:54:49.314Z',
        'subSubcategory': {
          'id': 'cat_fashion_001',
          'name': 'Women\'s Clothing',
          'slug': 'womens-clothing',
          'description': 'Trendy clothing for women.',
          'imageUrl':
              'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
          'subCategory': {
            'id': 'fashion_sub_001',
            'name': 'Fashion',
            'slug': 'fashion',
          },
          'parentCategory': {
            'id': 'fashion_parent_001',
            'name': 'Apparel',
            'slug': 'apparel',
          },
          'createdAt': '2025-04-01T10:00:00Z',
          'updatedAt': '2025-04-18T07:54:49Z',
        },
      },
    ];

    return dummyJsonList.map((json) => Product.fromJson(json)).toList();
  }
}

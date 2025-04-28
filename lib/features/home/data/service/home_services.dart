import 'package:delala/features/home/data/models/home_data_model.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class ApiService {
  final String baseUrl;
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String usersEndpoint = '/users'; // New endpoint for users
  final Dio _dio;

  ApiService({String? baseUrl})
      : baseUrl = baseUrl ?? 'https://your-api-base-url.com',
        _dio = Dio(BaseOptions(
          baseUrl: baseUrl ?? 'https://your-api-base-url.com',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        )) {
    // Add Dio interceptor for detailed logging
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // Fallback data for products
  static final List<Product> _fallbackProducts = [
    Product.fromJson({
      'id': '680205497a62f06598b66d12',
      'name': 'iPhone 15',
      'price': 1200,
      'description': 'A premium Apple smartphone',
      'imageUrl':
          'https://res.cloudinary.com/drdsqulxl/image/upload/v1744962888/categories/y1ndtwjvezpxnejomqz3.jpg',
      'listingType': 'ECOMMERCE',
      'brokerageType': null,
      'attributes': {},
      'subSubcategoryId': '67e6632fb084e36436006225',
      'userId': '67d3e3513991865850d7ede2',
      'createdAt': '2025-04-18T07:54:49.314Z',
      'updatedAt': '2025-04-18T07:54:49.314Z',
    }),

    Product.fromJson({
      'id': '680205497a62f06598b66d12',
      'name': 'iPhone 15',
      'price': 1200,
      'description': 'A premium Apple smartphone',
      'imageUrl':
          'https://res.cloudinary.com/drdsqulxl/image/upload/v1744962888/categories/y1ndtwjvezpxnejomqz3.jpg',
      'listingType': 'ECOMMERCE',
      'brokerageType': null,
      'attributes': {},
      'subSubcategoryId': '67e6632fb084e36436006225',
      'userId': '67d3e3513991865850d7ede2',
      'createdAt': '2025-04-18T07:54:49.314Z',
      'updatedAt': '2025-04-18T07:54:49.314Z',
    }),
    Product.fromJson({
      'id': '680205497a62f06598b66d12',
      'name': 'iPhone 15',
      'price': 1200,
      'description': 'A premium Apple smartphone',
      'imageUrl':
          'https://res.cloudinary.com/drdsqulxl/image/upload/v1744962888/categories/y1ndtwjvezpxnejomqz3.jpg',
      'listingType': 'ECOMMERCE',
      'brokerageType': null,
      'attributes': {},
      'subSubcategoryId': '67e6632fb084e36436006225',
      'userId': '67d3e3513991865850d7ede2',
      'createdAt': '2025-04-18T07:54:49.314Z',
      'updatedAt': '2025-04-18T07:54:49.314Z',
    })
    // Other products
  ];

  // Fallback data for categories
  static final List<Category> _fallbackCategories = [
    {
      'id': '67f73a01de0d138e5a663584',
      'name': 'Shoes',
      'attributes': {
        'options': ['color', 'size']
      },
      'imageUrl': null,
      'description': 'A category for various types of shoes',
    },
    {
      'id': '67f73a01de0d138e5a663584',
      'name': 'Shoes',
      'attributes': {
        'options': ['color', 'size']
      },
      'imageUrl': null,
      'description': 'A category for various types of shoes',
    },
    {
      'id': '67f73a01de0d138e5a663584',
      'name': 'Shoes',
      'attributes': {
        'options': ['color', 'size']
      },
      'imageUrl': null,
      'description': 'A category for various types of shoes',
    },
    {
      'id': '67f73a01de0d138e5a663584',
      'name': 'Shoes',
      'attributes': {
        'options': ['color', 'size']
      },
      'imageUrl': null,
      'description': 'A category for various types of shoes',
    },
    // Other categories
  ].map((json) => Category.fromJson(json)).toList();

  // Fallback data for users
  static final List<User> _fallbackUsers = [
    User.fromJson({
      'id': '1',
      'name': 'John Doe',
      'email': 'johndoe@example.com',
      'avatarUrl': 'https://example.com/avatar.jpg',
    }),
    User.fromJson({
      'id': '2',
      'name': 'Jane Smith',
      'email': 'janesmith@example.com',
      'avatarUrl': 'https://example.com/avatar2.jpg',
    }),
    // Other users
  ];

  /// Fetches products from the API, falls back to dummy data on failure
  Future<List<Product>> fetchProducts() async {
    try {
      developer.log(
          'Attempting to fetch products from $baseUrl$productsEndpoint',
          name: 'ApiService');
      final response = await _dio.get(productsEndpoint);
      developer.log(
          'Products response: ${response.statusCode} - ${response.data}',
          name: 'ApiService');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List) {
          final products =
              List<Product>.from(data.map((item) => Product.fromJson(item)));
          developer.log('Parsed ${products.length} products',
              name: 'ApiService');
          return products;
        } else if (data is Map<String, dynamic> && data['data'] is List) {
          final products = List<Product>.from(
              data['data'].map((item) => Product.fromJson(item)));
          developer.log('Parsed ${products.length} products from nested data',
              name: 'ApiService');
          return products;
        }
        developer.log('Unexpected response format: $data', name: 'ApiService');
      } else {
        developer.log('Failed to fetch products: Status ${response.statusCode}',
            name: 'ApiService');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching products: $e',
          name: 'ApiService', error: e, stackTrace: stackTrace);
    }

    developer.log('Returning fallback products: ${_fallbackProducts.length}',
        name: 'ApiService');
    return _fallbackProducts;
  }

  /// Fetches categories from the API, falls back to dummy data on failure
  Future<List<Category>> fetchCategories() async {
    try {
      developer.log(
          'Attempting to fetch categories from $baseUrl$categoriesEndpoint',
          name: 'ApiService');
      final response = await _dio.get(categoriesEndpoint);
      developer.log(
          'Categories response: ${response.statusCode} - ${response.data}',
          name: 'ApiService');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List) {
          final categories =
              List<Category>.from(data.map((item) => Category.fromJson(item)));
          developer.log('Parsed ${categories.length} categories',
              name: 'ApiService');
          return categories;
        } else if (data is Map<String, dynamic> && data['data'] is List) {
          final categories = List<Category>.from(
              data['data'].map((item) => Category.fromJson(item)));
          developer.log(
              'Parsed ${categories.length} categories from nested data',
              name: 'ApiService');
          return categories;
        }
        developer.log('Unexpected response format: $data', name: 'ApiService');
      } else {
        developer.log(
            'Failed to fetch categories: Status ${response.statusCode}',
            name: 'ApiService');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching categories: $e',
          name: 'ApiService', error: e, stackTrace: stackTrace);
    }

    developer.log(
        'Returning fallback categories: ${_fallbackCategories.length}',
        name: 'ApiService');
    return _fallbackCategories;
  }

  /// Fetches users from the API, falls back to dummy data on failure
  Future<List<User>> fetchUsers() async {
    try {
      developer.log('Attempting to fetch users from $baseUrl$usersEndpoint',
          name: 'ApiService');
      final response = await _dio.get(usersEndpoint);
      developer.log('Users response: ${response.statusCode} - ${response.data}',
          name: 'ApiService');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is List) {
          final users =
              List<User>.from(data.map((item) => User.fromJson(item)));
          developer.log('Parsed ${users.length} users', name: 'ApiService');
          return users;
        } else if (data is Map<String, dynamic> && data['data'] is List) {
          final users =
              List<User>.from(data['data'].map((item) => User.fromJson(item)));
          developer.log('Parsed ${users.length} users from nested data',
              name: 'ApiService');
          return users;
        }
        developer.log('Unexpected response format: $data', name: 'ApiService');
      } else {
        developer.log('Failed to fetch users: Status ${response.statusCode}',
            name: 'ApiService');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching users: $e',
          name: 'ApiService', error: e, stackTrace: stackTrace);
    }

    developer.log('Returning fallback users: ${_fallbackUsers.length}',
        name: 'ApiService');
    return _fallbackUsers;
  }
}

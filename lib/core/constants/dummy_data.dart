// import 'package:delala/features/categories/data/model/category_model.dart';
// import 'package:delala/features/categories/domain/entities/category.dart';

// /// Provides dummy data for testing and development purposes.
// class DummyData {
//   /// Returns a map of main categories to their respective category lists.
//   static Map<String, List<Category>> getCategoriesByMainCategory() {
//     return {
//       'Clothing': [
//         Category(
//           id: '67f73a01de0d138e5a663584',
//           name: 'Sneakers',
//           attributes: [
//             'color',
//             'size',
//             'material',
//             'brand',
//             'price_range',
//             'cushioning_type',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Explore a wide range of casual and athletic sneakers, perfect for everyday wear, running, or street style.',
//           subcategories: [
//             'Running',
//             'Lifestyle',
//             'Basketball',
//             'Training',
//             'Skate',
//           ],
//           createdAt: DateTime(2025, 1, 15),
//           popularityScore: 95.0,
//           popularity: 0.95,
//           reviewCount: 1200,
//           discountPercentage: 15.0,
//           brand: 4.8,
//           originalPrice: 120.0,
//           price: 102.0,
//         ),
//         Category(
//           id: 'clth789',
//           name: 'Jackets',
//           attributes: [
//             'material',
//             'size',
//             'color',
//             'brand',
//             'weather_resistance',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Stylish jackets for all seasons, from lightweight windbreakers to heavy winter coats.',
//           subcategories: [
//             'Bomber',
//             'Denim',
//             'Puffer',
//             'Raincoat',
//           ],
//           createdAt: DateTime(2025, 1, 20),
//           popularityScore: 85.0,
//           popularity: 0.85,
//           reviewCount: 800,
//           discountPercentage: 10.0,
//           brand: 4.5,
//           originalPrice: 150.0,
//           price: 135.0,
//         ),
//       ],
//       'Houses': [
//         Category(
//           id: 'house123',
//           name: 'Apartments',
//           attributes: [
//             'bedrooms',
//             'bathrooms',
//             'furnished',
//             'location',
//             'price_range',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Modern apartments in urban and suburban areas. Great for singles, couples, or small families.',
//           subcategories: [
//             'Studio',
//             '1 Bedroom',
//             '2 Bedrooms',
//             'Penthouse',
//           ],
//           createdAt: DateTime(2025, 2, 1),
//           popularityScore: 75.0,
//           popularity: 0.75,
//           reviewCount: 500,
//           discountPercentage: 5.0,
//           brand: 4.2,
//           originalPrice: 200000.0,
//           price: 190000.0,
//         ),
//         Category(
//           id: 'house456',
//           name: 'Villas',
//           attributes: [
//             'bedrooms',
//             'bathrooms',
//             'pool',
//             'garden',
//             'price_range',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1613490493576-7fde63acd811?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Luxurious villas with premium amenities, perfect for families or vacation homes.',
//           subcategories: [
//             'Single Story',
//             'Multi Story',
//             'Beachfront',
//           ],
//           createdAt: DateTime(2025, 2, 10),
//           popularityScore: 80.0,
//           popularity: 0.80,
//           reviewCount: 600,
//           discountPercentage: 8.0,
//           brand: 4.7,
//           originalPrice: 500000.0,
//           price: 460000.0,
//         ),
//       ],
//       'Vehicles': [
//         Category(
//           id: 'vehicle456',
//           name: 'Cars',
//           attributes: [
//             'make',
//             'model',
//             'year',
//             'fuel_type',
//             'transmission',
//             'price_range',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1618944769289-b3a96dcd1c2b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Browse various types of cars from sedans to SUVs for personal or commercial use.',
//           subcategories: [
//             'Sedan',
//             'SUV',
//             'Hatchback',
//             'Pickup',
//           ],
//           createdAt: DateTime(2025, 3, 5),
//           popularityScore: 88.0,
//           popularity: 0.88,
//           reviewCount: 900,
//           discountPercentage: 12.0,
//           brand: 4.6,
//           originalPrice: 30000.0,
//           price: 26400.0,
//         ),
//         Category(
//           id: 'vehicle789',
//           name: 'Motorcycles',
//           attributes: [
//             'brand',
//             'engine_size',
//             'type',
//             'year',
//             'price_range',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'High-performance motorcycles for enthusiasts and daily commuters.',
//           subcategories: [
//             'Cruiser',
//             'Sport',
//             'Touring',
//             'Adventure',
//           ],
//           createdAt: DateTime(2025, 3, 15),
//           popularityScore: 82.0,
//           popularity: 0.82,
//           reviewCount: 700,
//           discountPercentage: 10.0,
//           brand: 4.4,
//           originalPrice: 15000.0,
//           price: 13500.0,
//         ),
//       ],
//       'Electronics': [
//         Category(
//           id: 'elec789',
//           name: 'Smartphones',
//           attributes: [
//             'brand',
//             'screen_size',
//             'storage',
//             'battery_life',
//             'camera_quality',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'Latest smartphones with powerful features and sleek designs, from top global brands.',
//           subcategories: [
//             'Android',
//             'iOS',
//             'Gaming Phones',
//             'Budget Phones',
//           ],
//           createdAt: DateTime(2025, 4, 1),
//           popularityScore: 92.0,
//           popularity: 0.92,
//           reviewCount: 1500,
//           discountPercentage: 20.0,
//           brand: 4.9,
//           originalPrice: 800.0,
//           price: 640.0,
//         ),
//         Category(
//           id: 'elec012',
//           name: 'Laptops',
//           attributes: [
//             'brand',
//             'processor',
//             'ram',
//             'storage',
//             'screen_size',
//           ],
//           imageUrl:
//               'https://images.unsplash.com/photo-1496181133206-80ce9b88a0a1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
//           description:
//               'High-performance laptops for work, gaming, and creative professionals.',
//           subcategories: [
//             'Ultrabook',
//             'Gaming',
//             'Workstation',
//             '2-in-1',
//           ],
//           createdAt: DateTime(2025, 4, 10),
//           popularityScore: 90.0,
//           popularity: 0.90,
//           reviewCount: 1000,
//           discountPercentage: 15.0,
//           brand: 4.8,
//           originalPrice: 1500.0,
//           price: 1275.0,
//         ),
//       ],
//     };
//   }
// }

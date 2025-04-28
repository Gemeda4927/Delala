import 'dart:convert';
import 'package:delala/features/categories/data/model/category_model.dart';

class CategoryService {
  Future<List<Category>> fetchCategories() async {
    return _getStaticCategories();
  }

  Future<List<Subcategory>> fetchSubcategories(String categoryId) async {
    final categories = await fetchCategories();
    // Filter subcategories by parentId
    final subcategories = categories
        .expand((cat) => cat.subcategories)
        .where((subcat) => subcat.parentId == categoryId)
        .toList();
    return subcategories;
  }

  Future<Category> fetchCategoryById(String categoryId) async {
    return _getStaticCategoryById(categoryId);
  }

  Future<Subcategory> fetchSubcategoryById(String subcategoryId) async {
    return _getStaticSubcategoryById(subcategoryId);
  }

  // Static data methods
  List<Category> _getStaticCategories() {
    final staticData = '''
    [
      {
        "id": "cat_home_001",
        "name": "Home & Living",
        "attributes": {
          "options": ["color", "material", "style", "room type", "brand"]
        },
        "imageUrl": "https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        "description": "Transform your living space with stylish furniture, decor, and essentials for every room.",
        "subcategories": [
          {
            "id": "sub_home_001",
            "name": "Furniture",
            "description": "High-quality sofas, dining tables, beds, and more to furnish your home.",
            "imageUrl": "https://images.unsplash.com/photo-1555041469-a586c61ea9c4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "material": ["Wood", "Leather", "Fabric", "Metal"],
              "color": ["Beige", "Gray", "Black", "Brown"],
              "style": ["Modern", "Mid-Century", "Scandinavian", "Rustic"]
            },
            "priceRange": "\$150 - \$6000",
            "rating": 4.8,
            "isFeatured": true,
            "stockCount": 320,
            "createdAt": "2025-03-01T08:00:00Z",
            "updatedAt": "2025-04-27T10:00:00Z",
            "parentId": "cat_home_001"
          },
          {
            "id": "sub_home_002",
            "name": "Home Decor",
            "description": "Elevate your space with wall art, vases, candles, and decorative accents.",
            "imageUrl": "https://images.unsplash.com/photo-1589834390005-5d4fb9bf3d32?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Wall Art", "Vases", "Candles", "Mirrors"],
              "style": ["Bohemian", "Minimalist", "Contemporary", "Vintage"],
              "material": ["Ceramic", "Glass", "Metal", "Wood"]
            },
            "priceRange": "\$10 - \$700",
            "rating": 4.6,
            "isFeatured": true,
            "stockCount": 450,
            "createdAt": "2025-03-05T09:00:00Z",
            "updatedAt": "2025-04-27T11:00:00Z",
            "parentId": "cat_home_001"
          },
          {
            "id": "sub_home_003",
            "name": "Kitchen & Dining",
            "description": "Cookware, dinnerware, and kitchen gadgets for culinary enthusiasts.",
            "imageUrl": "https://images.unsplash.com/photo-1556911220-bff31c812dba?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Cookware", "Dinnerware", "Utensils", "Appliances"],
              "material": ["Stainless Steel", "Ceramic", "Glass", "Cast Iron"],
              "brand": ["Le Creuset", "Cuisinart", "KitchenAid", "Zwilling"]
            },
            "priceRange": "\$20 - \$1200",
            "rating": 4.7,
            "isFeatured": false,
            "stockCount": 280,
            "createdAt": "2025-03-10T10:00:00Z",
            "updatedAt": "2025-04-27T12:00:00Z",
            "parentId": "cat_home_001"
          }
        ],
        "priceRange": "\$10 - \$6000",
        "rating": 4.7,
        "isFeatured": true,
        "stockCount": 1050,
        "createdAt": "2025-03-01T07:00:00Z",
        "updatedAt": "2025-04-27T09:00:00Z"
      },
      {
        "id": "cat_electronics_001",
        "name": "Electronics",
        "attributes": {
          "options": ["brand", "color", "storage", "connectivity", "features"]
        },
        "imageUrl": "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        "description": "Discover the latest in smartphones, laptops, and smart home devices.",
        "subcategories": [
          {
            "id": "sub_electronics_001",
            "name": "Smartphones",
            "description": "Cutting-edge smartphones with advanced cameras and performance.",
            "imageUrl": "https://images.unsplash.com/photo-1511707171634-5f89772885ad?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "brand": ["Apple", "Samsung", "Google", "OnePlus"],
              "storage": ["128GB", "256GB", "512GB", "1TB"],
              "os": ["iOS", "Android"],
              "color": ["Black", "White", "Blue", "Green"]
            },
            "priceRange": "\$300 - \$2000",
            "rating": 4.9,
            "isFeatured": true,
            "stockCount": 400,
            "createdAt": "2025-03-15T08:00:00Z",
            "updatedAt": "2025-04-27T13:00:00Z",
            "parentId": "cat_electronics_001"
          },
          {
            "id": "sub_electronics_002",
            "name": "Laptops",
            "description": "High-performance laptops for work, gaming, and creativity.",
            "imageUrl": "https://images.unsplash.com/photo-1496181133206-80ce9b88a0a6?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "brand": ["Apple", "Dell", "HP", "Lenovo"],
              "processor": ["Intel i5", "Intel i7", "AMD Ryzen 7", "M1"],
              "ram": ["8GB", "16GB", "32GB"],
              "type": ["Ultrabook", "Gaming", "Workstation"]
            },
            "priceRange": "\$500 - \$4000",
            "rating": 4.8,
            "isFeatured": true,
            "stockCount": 250,
            "createdAt": "2025-03-20T09:00:00Z",
            "updatedAt": "2025-04-27T14:00:00Z",
            "parentId": "cat_electronics_001"
          },
          {
            "id": "sub_electronics_003",
            "name": "Smart Home",
            "description": "Smart speakers, lights, and security systems for a connected home.",
            "imageUrl": "https://images.unsplash.com/photo-1543512214-318c7553f230?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Speakers", "Lights", "Cameras", "Thermostats"],
              "brand": ["Amazon", "Google", "Philips Hue", "Ring"],
              "connectivity": ["Wi-Fi", "Bluetooth", "Zigbee"]
            },
            "priceRange": "\$30 - \$500",
            "rating": 4.6,
            "isFeatured": false,
            "stockCount": 300,
            "createdAt": "2025-03-25T10:00:00Z",
            "updatedAt": "2025-04-27T15:00:00Z",
            "parentId": "cat_electronics_001"
          }
        ],
        "priceRange": "\$30 - \$4000",
        "rating": 4.8,
        "isFeatured": true,
        "stockCount": 950,
        "createdAt": "2025-03-15T07:00:00Z",
        "updatedAt": "2025-04-27T12:00:00Z"
      },
      {
        "id": "cat_fashion_001",
        "name": "Fashion",
        "attributes": {
          "options": ["size", "color", "material", "style", "gender"]
        },
        "imageUrl": "https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        "description": "Trendy clothing, shoes, and accessories for men, women, and kids.",
        "subcategories": [
          {
            "id": "sub_fashion_001",
            "name": "Women's Clothing",
            "description": "Stylish dresses, tops, and activewear for women.",
            "imageUrl": "https://images.unsplash.com/photo-1529139574466-a303027c1d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Dresses", "Tops", "Jeans", "Activewear"],
              "size": ["XS", "S", "M", "L", "XL"],
              "style": ["Casual", "Formal", "Athleisure", "Bohemian"],
              "material": ["Cotton", "Polyester", "Silk"]
            },
            "priceRange": "\$20 - \$800",
            "rating": 4.7,
            "isFeatured": true,
            "stockCount": 1200,
            "createdAt": "2025-03-01T08:00:00Z",
            "updatedAt": "2025-04-27T16:00:00Z",
            "parentId": "cat_fashion_001"
          },
          {
            "id": "sub_fashion_002",
            "name": "Men's Clothing",
            "description": "Modern shirts, suits, and casual wear for men.",
            "imageUrl": "https://images.unsplash.com/photo-1593032465171-36e0a1b656db?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Shirts", "Suits", "Jeans", "Jackets"],
              "size": ["S", "M", "L", "XL", "XXL"],
              "style": ["Casual", "Business", "Streetwear"],
              "material": ["Cotton", "Wool", "Denim"]
            },
            "priceRange": "\$25 - \$600",
            "rating": 4.6,
            "isFeatured": true,
            "stockCount": 1000,
            "createdAt": "2025-03-05T09:00:00Z",
            "updatedAt": "2025-04-27T17:00:00Z",
            "parentId": "cat_fashion_001"
          },
          {
            "id": "sub_fashion_003",
            "name": "Footwear",
            "description": "Sneakers, boots, and sandals for all occasions.",
            "imageUrl": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Sneakers", "Boots", "Sandals", "Dress Shoes"],
              "size": ["US 5-12", "EU 36-46"],
              "gender": ["Men", "Women", "Unisex"],
              "brand": ["Nike", "Adidas", "Clarks", "Timberland"]
            },
            "priceRange": "\$30 - \$300",
            "rating": 4.8,
            "isFeatured": false,
            "stockCount": 800,
            "createdAt": "2025-03-10T10:00:00Z",
            "updatedAt": "2025-04-27T18:00:00Z",
            "parentId": "cat_fashion_001"
          }
        ],
        "priceRange": "\$20 - \$800",
        "rating": 4.7,
        "isFeatured": true,
        "stockCount": 3000,
        "createdAt": "2025-03-01T07:00:00Z",
        "updatedAt": "2025-04-27T15:00:00Z"
      },
      {
        "id": "cat_sports_001",
        "name": "Sports & Outdoors",
        "attributes": {
          "options": ["type", "brand", "size", "material", "activity"]
        },
        "imageUrl": "https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
        "description": "Gear and equipment for fitness, camping, and outdoor adventures.",
        "subcategories": [
          {
            "id": "sub_sports_001",
            "name": "Fitness Equipment",
            "description": "Treadmills, weights, and yoga mats for home workouts.",
            "imageUrl": "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Treadmills", "Dumbbells", "Yoga Mats", "Resistance Bands"],
              "brand": ["Peloton", "Bowflex", "Manduka", "Rogue"],
              "material": ["Rubber", "Steel", "Foam"]
            },
            "priceRange": "\$50 - \$3000",
            "rating": 4.7,
            "isFeatured": true,
            "stockCount": 200,
            "createdAt": "2025-03-15T08:00:00Z",
            "updatedAt": "2025-04-27T19:00:00Z",
            "parentId": "cat_sports_001"
          },
          {
            "id": "sub_sports_002",
            "name": "Camping Gear",
            "description": "Tents, sleeping bags, and backpacks for outdoor adventures.",
            "imageUrl": "https://images.unsplash.com/photo-1504280390367-5d8a73d74d5d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Tents", "Sleeping Bags", "Backpacks", "Camp Stoves"],
              "brand": ["The North Face", "REI", "Osprey", "Coleman"],
              "capacity": ["1-Person", "2-Person", "4-Person"]
            },
            "priceRange": "\$30 - \$600",
            "rating": 4.6,
            "isFeatured": true,
            "stockCount": 150,
            "createdAt": "2025-03-20T09:00:00Z",
            "updatedAt": "2025-04-27T20:00:00Z",
            "parentId": "cat_sports_001"
          },
          {
            "id": "sub_sports_003",
            "name": "Cycling",
            "description": "Bikes, helmets, and accessories for cycling enthusiasts.",
            "imageUrl": "https://images.unsplash.com/photo-1485965127652-5f2b48a4c5dd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
            "attributes": {
              "type": ["Road Bikes", "Mountain Bikes", "Hybrid Bikes"],
              "brand": ["Trek", "Specialized", "Giant", "Cannondale"],
              "size": ["S", "M", "L"]
            },
            "priceRange": "\$200 - \$5000",
            "rating": 4.8,
            "isFeatured": false,
            "stockCount": 100,
            "createdAt": "2025-03-25T10:00:00Z",
            "updatedAt": "2025-04-27T21:00:00Z",
            "parentId": "cat_sports_001"
          }
        ],
        "priceRange": "\$30 - \$5000",
        "rating": 4.7,
        "isFeatured": true,
        "stockCount": 450,
        "createdAt": "2025-03-15T07:00:00Z",
        "updatedAt": "2025-04-27T18:00:00Z"
      }
    ]
    ''';
    List<dynamic> data = json.decode(staticData);
    return data.map((categoryJson) => Category.fromJson(categoryJson)).toList();
  }

  Category _getStaticCategoryById(String categoryId) {
    final staticCategories = _getStaticCategories();
    return staticCategories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => Category(
        id: categoryId,
        name: "Sample Category",
        description: "Sample category description",
        imageUrl: "https://via.placeholder.com/150",
        subcategories: [],
        priceRange: "\$50 - \$100",
        rating: 4.0,
        isFeatured: false,
        stockCount: 50,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        options: [],
      ),
    );
  }

  Subcategory _getStaticSubcategoryById(String subcategoryId) {
    final staticCategories = _getStaticCategories();
    for (var category in staticCategories) {
      for (var subcategory in category.subcategories) {
        if (subcategory.id == subcategoryId) {
          return subcategory;
        }
      }
    }
    return Subcategory(
      id: subcategoryId,
      name: "Sample Subcategory",
      description: "Sample subcategory description",
      imageUrl: "https://via.placeholder.com/150",
      attributes: {},
      priceRange: "\$50 - \$100",
      rating: 4.5,
      isFeatured: false,
      stockCount: 50,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      parentId: '',
    );
  }
}

import 'package:delala/features/home/data/home_data.dart';
import 'package:flutter/material.dart';

/// Finds a category by its name in the jsonData.
/// Returns a map with the category name or null if not found.
Map<String, dynamic>? findCategoryByName(String name) {
  // Extract unique categories from jsonData
  final categories = jsonData
      .map((product) => product['category'] as String)
      .toSet()
      .map((category) => {'name': category})
      .toList();

  return categories.firstWhere(
    (cat) => cat['name']?.toString().toLowerCase() == name.toLowerCase(),
    // orElse: () => null,
  );
}

/// Returns a list of products for a given category name.
List<Map<String, dynamic>> getProductsForCategory(String categoryName) {
  return jsonData
      .where((product) =>
          (product['category'] as String?)?.toLowerCase() ==
          categoryName.toLowerCase())
      .cast<Map<String, dynamic>>()
      .toList();
}

/// Returns the color associated with a category name.
String getCategoryColor(String name) {
  switch (name.toLowerCase()) {
    case 'casual sneakers':
      return '#D32F2F'; // Red for casual sneakers
    case 'running sneakers':
      return '#0288D1'; // Blue for running sneakers
    default:
      return '#757575'; // Gray for unknown
  }
}

/// Returns the icon name associated with a category name.
String getCategoryIcon(String name) {
  switch (name.toLowerCase()) {
    case 'casual sneakers':
      return 'casual_shoes';
    case 'running sneakers':
      return 'running_shoes';
    default:
      return 'category';
  }
}

/// Returns the IconData for a given icon name.
IconData getIconData(String iconName) {
  switch (iconName.toLowerCase()) {
    case 'casual_shoes':
      return Icons.directions_walk;
    case 'running_shoes':
      return Icons.directions_run;
    case 'category':
      return Icons.category;
    default:
      return Icons.help_outline;
  }
}

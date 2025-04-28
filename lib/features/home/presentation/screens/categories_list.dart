import 'package:delala/config/routes/route_name.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/presentation/screens/category_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatelessWidget {
  final List<CategoryEntity> categories;
  final Animation<double> fadeAnimation;

  const CategoriesList({
    super.key,
    required this.categories,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('CategoriesList: Rendering ${categories.length} categories');
    return SizedBox(
      height: 160,
      child: categories.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              clipBehavior: Clip.none,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildAnimatedCategoryCard(context, category);
              },
            )
          : Center(
              child: Text(
                'No Categories Available',
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
    );
  }

  Widget _buildAnimatedCategoryCard(
      BuildContext context, CategoryEntity category) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: fadeAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 - 30 * fadeAnimation.value),
            child: _buildCategoryCard(context, category),
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryEntity category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _handleCategoryTap(context, category),
          child: CategoryCard(category: category),
        ),
      ),
    );
  }

  void _handleCategoryTap(BuildContext context, CategoryEntity category) {
    debugPrint('Tapped category: ${category.name} (ID: ${category.id})');

    if (category.id.isEmpty) {
      debugPrint('Invalid category ID');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid category')),
      );
      return;
    }

    try {
      context.pushNamed(
        RouteName.categoryDetail,
        pathParameters: {'categoryId': category.id},
        extra: category,
      );
      debugPrint('Navigation successful to category ${category.id}');
    } catch (e) {
      debugPrint('Navigation failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open category: ${e.toString()}')),
      );
    }
  }
}

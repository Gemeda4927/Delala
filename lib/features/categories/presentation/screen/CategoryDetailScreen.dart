import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/categories/presentation/bloc/category_event.dart';
import 'package:delala/features/categories/presentation/widget/image_widget.dart';
import 'package:delala/features/categories/presentation/widget/popular_products_list.dart';
import 'package:delala/features/categories/presentation/widget/subcategories_grid.dart';
import 'package:delala/features/categories/presentation/widget/subcategories_screen.dart';
import 'package:delala/features/products/presentation/bloc/products_bloc.dart';
import 'package:delala/features/products/presentation/bloc/products_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CategoryDetailScreen extends StatelessWidget {
  final CategoryEntity category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryBloc>().add(FetchSubcategories(category.id));
      context.read<ProductBloc>().add(FetchProductEvent(category.id));
    });

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CategoryBloc>().add(FetchSubcategories(category.id));
          context.read<ProductBloc>().add(FetchProductEvent(category.id));
        },
        color: AppConstants.accentColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: AppConstants.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  category.name,
                  style: AppConstants.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                background: Hero(
                  tag: 'category-${category.id}',
                  child: buildImageWidget(
                    imageUrl: category.imageUrl,
                    icon: Iconsax.category,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Iconsax.arrow_left, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Iconsax.share, color: Colors.white),
                  onPressed: () => _shareCategory(context),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (category.description!.isNotEmpty)
                    _buildCategoryDescription(context),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildSubcategoriesSection(context),
                  const SizedBox(height: AppConstants.sectionSpacing),
                  _buildPopularProductsSection(context),
                  const SizedBox(height: AppConstants.sectionSpacing),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDescription(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${category.name}',
            style: AppConstants.heading2,
          ),
          const SizedBox(height: AppConstants.mediumPadding),
          Container(
            padding: const EdgeInsets.all(AppConstants.mediumPadding),
            decoration: BoxDecoration(
              color: AppConstants.cardBackgroundColor,
              borderRadius: AppConstants.cardBorderRadius,
              boxShadow: [AppConstants.cardShadow],
            ),
            child: Text(
              category.description!,
              style: AppConstants.bodyText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppConstants.smallPadding),
          decoration: BoxDecoration(
            gradient: AppConstants.primaryGradient,
            borderRadius: AppConstants.cardBorderRadius,
            boxShadow: [AppConstants.cardShadow],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.category_rounded,
                      color: AppConstants.accentColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppConstants.smallPadding),
                  Text(
                    'Subcategories',
                    style: AppConstants.heading2.copyWith(color: Colors.white),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _viewAllSubcategories(context),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.mediumPadding,
                    vertical: AppConstants.smallPadding,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppConstants.accentGradient,
                    borderRadius: AppConstants.buttonBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.accentColor.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        'See All',
                        style: AppConstants.buttonText.copyWith(fontSize: 14),
                      ),
                      const SizedBox(width: AppConstants.smallPadding),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.mediumPadding),
        BlocProvider.value(
          value: context.read<CategoryBloc>(),
          child: SubcategoriesGrid(categoryId: category.id),
        ),
      ],
    );
  }

  Widget _buildPopularProductsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Products',
          style: AppConstants.heading2,
        ),
        const SizedBox(height: AppConstants.mediumPadding),
        BlocProvider.value(
          value: context.read<ProductBloc>(),
          child: PopularProductsList(category: category),
        ),
      ],
    );
  }

  void _shareCategory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing category...',
          style: AppConstants.bodyText.copyWith(color: Colors.white),
        ),
        backgroundColor: AppConstants.successColor,
      ),
    );
  }

  void _viewAllSubcategories(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubcategoriesScreen(category: category),
      ),
    );
  }
}

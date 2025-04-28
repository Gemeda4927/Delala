import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/categories/presentation/bloc/category_event.dart';
import 'package:delala/features/categories/presentation/bloc/category_state.dart';
import 'package:delala/features/categories/presentation/screen/CategoryDetailScreen.dart';
import 'package:delala/features/categories/presentation/widget/subcategory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SubcategoriesGrid extends StatelessWidget {
  final String categoryId;

  const SubcategoriesGrid({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryBloc, CategoryState, CategoryState>(
      selector: (state) => state,
      builder: (context, state) {
        Widget content;
        if (state is CategoryLoading) {
          content = SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.only(right: AppConstants.mediumPadding),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: AppConstants.cardBorderRadius,
                        ),
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Container(
                        width: 80,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is SubcategoriesLoaded) {
          final subcategories = state.subcategories
              .where((cat) => cat.parentId == categoryId)
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

          if (subcategories.isEmpty) {
            content = Text(
              'No subcategories available',
              style: AppConstants.bodyText
                  .copyWith(color: AppConstants.secondaryTextColor),
            );
          } else {
            content = SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                key: const Key('subcategories_grid'),
                scrollDirection: Axis.horizontal,
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  final subcategory = subcategories[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: AppConstants.mediumPadding),
                    child: SubcategoryItem(
                      subcategory: subcategory,
                      onTap: () => _navigateToSubcategory(context, subcategory),
                    ),
                  );
                },
              ),
            );
          }
        } else if (state is CategoryError) {
          content = Column(
            children: [
              Text(
                'Error: ${state.message}',
                style: AppConstants.bodyText
                    .copyWith(color: AppConstants.errorColor),
              ),
              const SizedBox(height: AppConstants.smallPadding),
              TextButton(
                onPressed: () {
                  context
                      .read<CategoryBloc>()
                      .add(FetchSubcategories(categoryId));
                },
                child: Text(
                  'Retry',
                  style: AppConstants.bodyText
                      .copyWith(color: AppConstants.primaryColor),
                ),
              ),
            ],
          );
        } else {
          content = Text(
            'Unable to load subcategories',
            style:
                AppConstants.bodyText.copyWith(color: AppConstants.errorColor),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: content,
        );
      },
    );
  }

  void _navigateToSubcategory(
      BuildContext context, SubcategoryEntity subcategory) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryDetailScreen(
          category: CategoryEntity(
            id: subcategory.id,
            parentId: subcategory.parentId,
            name: subcategory.name,
            description: subcategory.description,
            imageUrl: subcategory.imageUrl,
            subcategories: [],
            options: subcategory.options,
            priceRange: subcategory.priceRange,
            rating: subcategory.rating,
            isFeatured: subcategory.isFeatured,
            stockCount: subcategory.stockCount,
            createdAt: subcategory.createdAt,
            updatedAt: subcategory.updatedAt,
          ),
        ),
      ),
    );
  }
}

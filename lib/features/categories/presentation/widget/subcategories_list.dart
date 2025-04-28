import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
import 'package:delala/features/categories/presentation/bloc/category_event.dart';
import 'package:delala/features/categories/presentation/bloc/category_state.dart';
import 'package:delala/features/products/domain/repository/Repository.dart';
import 'package:delala/features/products/presentation/bloc/products_bloc.dart';
import 'package:delala/features/products/presentation/bloc/products_event.dart';
import 'package:delala/features/products/presentation/bloc/products_state.dart';
import 'package:delala/features/products/presentation/screen/ProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';
import 'image_widget.dart';

class SubcategoriesList extends StatefulWidget {
  final String categoryId;

  const SubcategoriesList({required this.categoryId, super.key});

  @override
  State<SubcategoriesList> createState() => _SubcategoriesListState();
}

class _SubcategoriesListState extends State<SubcategoriesList> {
  get seller => {
        'name': 'Example Store',
        'rating': 4.8,
        'profilePicture': 'https://example.com/image.jpg',
        'responseTime': '1 hour',
        'reviews': 250,
      };

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchSubcategories(widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        Widget content;
        Key? contentKey;

        if (state is CategoryLoading) {
          contentKey = const Key('loading');
          content = ListView.builder(
            padding: const EdgeInsets.all(AppConstants.mediumPadding),
            itemCount: 5,
            itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[300] ?? Colors.grey,
              highlightColor: Colors.grey[100] ?? Colors.white,
              child: Container(
                margin:
                    const EdgeInsets.only(bottom: AppConstants.mediumPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppConstants.cardBorderRadius ??
                      BorderRadius.circular(8.0),
                ),
                height: 100,
              ),
            ),
          );
        } else if (state is SubcategoriesLoaded) {
          final subcategories = state.subcategories
              .where((cat) => cat.parentId == widget.categoryId)
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

          if (subcategories.isEmpty) {
            contentKey = const Key('empty');
            content = Center(
              child: Text(
                'No subcategories available',
                style: AppConstants.bodyText.copyWith(
                  color: AppConstants.secondaryTextColor ?? Colors.grey,
                ),
              ),
            );
          } else {
            contentKey = const Key('loaded');
            content = ListView.builder(
              key: const Key('subcategories_list'),
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return Card(
                  margin:
                      const EdgeInsets.only(bottom: AppConstants.mediumPadding),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppConstants.cardBorderRadius ??
                        BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    borderRadius: AppConstants.cardBorderRadius ??
                        BorderRadius.circular(8.0),
                    onTap: () => _navigateToProduct(context, subcategory),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConstants.cardBackgroundColor ?? Colors.white,
                        borderRadius: AppConstants.cardBorderRadius,
                        boxShadow: [AppConstants.cardShadow],
                      ),
                      padding: const EdgeInsets.all(AppConstants.mediumPadding),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: AppConstants.cardBorderRadius,
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: buildImageWidget(
                                imageUrl: subcategory.imageUrl,
                                icon: Iconsax.category,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppConstants.mediumPadding),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  subcategory.name,
                                  style: AppConstants.bodyText.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.primaryTextColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (subcategory.description.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppConstants.smallPadding),
                                    child: Text(
                                      subcategory.description!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppConstants.captionText,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                            Iconsax.arrow_right_3,
                            color: AppConstants.secondaryTextColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        } else if (state is CategoryError) {
          contentKey = const Key('error');
          content = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: AppConstants.bodyText.copyWith(
                    color: AppConstants.errorColor ?? Colors.red,
                  ),
                ),
                const SizedBox(height: AppConstants.smallPadding),
                TextButton(
                  onPressed: () {
                    context
                        .read<CategoryBloc>()
                        .add(FetchSubcategories(widget.categoryId));
                  },
                  child: Text(
                    'Retry',
                    style: AppConstants.bodyText.copyWith(
                      color: AppConstants.primaryColor ?? Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          contentKey = const Key('unknown');
          content = Center(
            child: Text(
              'Unable to load subcategories',
              style: AppConstants.bodyText.copyWith(
                color: AppConstants.errorColor ?? Colors.red,
              ),
            ),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: KeyedSubtree(
            key: contentKey,
            child: content,
          ),
        );
      },
    );
  }

  void _navigateToProduct(BuildContext context, SubcategoryEntity subcategory) {
    // Create a new ProductBloc instance for this navigation
    final productBloc = ProductBloc(
      productRepository: context.read<ProductRepository>(),
    );

    // Show a loading dialog and fetch products
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => BlocProvider.value(
        value: productBloc,
        child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoadedState) {
              Navigator.of(dialogContext).pop(); // Close the dialog

              if (state.product != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      product: state.product,
                    ),
                  ),
                );
              } else {
                // Show a snackbar if no products are found
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'No products available for ${subcategory.name}',
                      style: AppConstants.bodyText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppConstants.errorColor ?? Colors.red,
                  ),
                );
              }
            } else if (state is ProductErrorState) {
              Navigator.of(dialogContext).pop(); // Close the dialog
              // Show error snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Error: ${state.error}',
                    style: AppConstants.bodyText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: AppConstants.errorColor ?? Colors.red,
                ),
              );
            }
          },
          child: AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: AppConstants.mediumPadding),
                Text(
                  'Loading product...',
                  style: AppConstants.bodyText,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Dispatch the event to fetch products
    productBloc.add(FetchProductEvent(subcategory.id));
  }
}

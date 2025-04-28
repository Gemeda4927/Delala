import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/products/data/models/products.dart'; // Ensure this matches the Product model
import 'package:delala/features/products/presentation/bloc/products_bloc.dart';
import 'package:delala/features/products/presentation/bloc/products_event.dart';
import 'package:delala/features/products/presentation/bloc/products_state.dart';
import 'package:delala/features/products/presentation/screen/ProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'product_card.dart';

class PopularProductsList extends StatefulWidget {
  final CategoryEntity category;

  const PopularProductsList({required this.category, super.key});

  @override
  State<PopularProductsList> createState() => _PopularProductsListState();
}

class _PopularProductsListState extends State<PopularProductsList> {
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
    // Reset and fetch products
    context.read<ProductBloc>().add(ResetProductStateEvent());
    context.read<ProductBloc>().add(FetchProducts(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: BlocSelector<ProductBloc, ProductState, ProductState>(
        selector: (state) => state,
        builder: (context, state) {
          debugPrint('PopularProductsList - Current state: $state');

          Widget content;
          if (state is ProductInitialState || state is ProductLoadingState) {
            content = GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppConstants.mediumPadding),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppConstants.mediumPadding,
                mainAxisSpacing: AppConstants.mediumPadding,
                childAspectRatio: 0.65,
              ),
              itemCount: 4, // Show 4 shimmer placeholders
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Card(
                  margin: const EdgeInsets.all(4),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppConstants.cardBorderRadius,
                  ),
                  child: Container(
                    color: Colors.white,
                    height: 200,
                  ),
                ),
              ),
            );
          } else if (state is ProductsLoadedState) {
            final products = state.products
                ?.where(
                    (product) => product.subSubcategoryId == widget.category.id)
                .toList()
              ?..sort((a, b) => (b.rating ?? 0.0).compareTo(a.rating ?? 0.0));

            if (products == null || products.isEmpty) {
              content = Center(
                child: Text(
                  'No products available',
                  style: AppConstants.bodyText.copyWith(
                    color: AppConstants.secondaryTextColor ?? Colors.grey,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              content = ProductCardList(
                products: products,
                onTap: (product) => _navigateToProductDetail(context, product),
                onAddToCart: (product) => _addToCart(context, product),
              );
            }
          } else if (state is ProductErrorState) {
            content = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppConstants.errorColor,
                  size: 40,
                ),
                const SizedBox(height: AppConstants.smallPadding),
                Text(
                  'Error: ${state.error}',
                  style: AppConstants.bodyText.copyWith(
                    color: AppConstants.errorColor,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.smallPadding),
                TextButton(
                  onPressed: () {
                    context
                        .read<ProductBloc>()
                        .add(FetchProducts(widget.category.id));
                  },
                  child: Text(
                    'Retry',
                    style: AppConstants.bodyText.copyWith(
                      color: AppConstants.primaryColor ?? Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else {
            content = Center(
              child: Text(
                'Unable to load products',
                style: AppConstants.bodyText.copyWith(
                  color: AppConstants.errorColor ?? Colors.red,
                  fontSize: 16,
                ),
              ),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: content,
          );
        },
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context, Product product) {
    if (product.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid product selected',
            style: AppConstants.bodyText.copyWith(color: Colors.white),
          ),
          backgroundColor: AppConstants.errorColor ?? Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(
          product: product,
        ),
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    final productName = product.name ?? 'Product';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added $productName to cart',
          style: AppConstants.bodyText.copyWith(color: Colors.white),
        ),
        backgroundColor: AppConstants.successColor ?? Colors.green,
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            // TODO: Navigate to cart screen
            // Example: Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }
}

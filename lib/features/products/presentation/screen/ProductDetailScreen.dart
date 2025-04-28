import 'package:delala/features/products/data/models/products.dart';
import 'package:delala/features/products/presentation/views/app_bar_button.dart';
import 'package:delala/features/products/presentation/views/bottom_action_bar.dart';
import 'package:delala/features/products/presentation/views/customer_reviews.dart';
import 'package:delala/features/products/presentation/views/faqs.dart';
import 'package:delala/features/products/presentation/views/image_gallery.dart';
import 'package:delala/features/products/presentation/views/price_and_rating.dart';
import 'package:delala/features/products/presentation/views/product_details.dart';
import 'package:delala/features/products/presentation/views/product_title.dart';
import 'package:delala/features/products/presentation/views/quantity_selector.dart';
import 'package:delala/features/products/presentation/views/related_products.dart';
import 'package:delala/features/products/presentation/views/seller_card.dart';
import 'package:delala/features/products/presentation/views/size_color_selector.dart';
import 'package:delala/features/products/presentation/views/specifications.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _currentImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;
  final PageController _imageController = PageController();

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];
  final List<String> _colors = ['Red', 'Blue', 'Black', 'White'];

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[1000] : Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          icon: Iconsax.arrow_left_24,
          onPressed: () => Navigator.pop(context),
          isDarkMode: isDarkMode,
        ),
        actions: [
          AppBarButton(
            icon: Iconsax.heart5,
            color: Colors.redAccent,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to favorites')),
              );
            },
            isDarkMode: isDarkMode,
          ),
          AppBarButton(
            icon: Iconsax.share5,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share link copied')),
              );
            },
            isDarkMode: isDarkMode,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ImageGallery(
                    product: widget.product,
                    imageController: _imageController,
                    currentImageIndex: _currentImageIndex,
                    onPageChanged: (index) =>
                        setState(() => _currentImageIndex = index),
                  ),
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductTitle(
                            theme: theme,
                            isDarkMode: isDarkMode,
                            product: widget.product,
                          ),
                          const SizedBox(height: 16),
                          PriceAndRating(
                            theme: theme,
                            isDarkMode: isDarkMode,
                            product: widget.product,
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          SizeColorSelector(
                            theme: theme,
                            isDarkMode: isDarkMode,
                            sizes: _sizes,
                            colors: _colors,
                            selectedSize: _selectedSize,
                            selectedColor: _selectedColor,
                            onSizeSelected: (size) =>
                                setState(() => _selectedSize = size),
                            onColorSelected: (color) =>
                                setState(() => _selectedColor = color),
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          QuantitySelector(
                            theme: theme,
                            isDarkMode: isDarkMode,
                            quantity: _quantity,
                            stock: widget.product.stock,
                            onQuantityChanged: (value) =>
                                setState(() => _quantity = value),
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          SellerCard(theme: theme, isDarkMode: isDarkMode),
                          const Divider(height: 32, thickness: 1.2),
                          ProductDetails(
                            theme: theme,
                            isDarkMode: isDarkMode,
                            product: widget.product,
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          Specifications(
                            theme: theme,
                            product: widget.product,
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          CustomerReviews(
                            theme: theme,
                            isDarkMode: isDarkMode,
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          FAQs(
                            theme: theme,
                            isDarkMode: isDarkMode,
                          ),
                          const Divider(height: 32, thickness: 1.2),
                          RelatedProducts(
                            theme: theme,
                            isDarkMode: isDarkMode,
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          BottomActionBar(
            theme: theme,
            isDarkMode: isDarkMode,
            product: widget.product,
            selectedSize: _selectedSize,
            selectedColor: _selectedColor,
            context: context,
          ),
        ],
      ),
    );
  }
}

import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProductCardList extends StatelessWidget {
  final List<Product>? products;
  final List<UserEntity>? seller;
  final Function(Product) onTap;
  final Function(Product) onAddToCart;

  const ProductCardList({
    required this.products,
    required this.onTap,
    required this.onAddToCart,
    super.key,
    this.seller,
  });

  @override
  Widget build(BuildContext context) {
    if (products == null || products!.isEmpty) {
      debugPrint('Products list is null or empty');
      return _buildFallbackCard(context, 'No products available');
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppConstants.mediumPadding,
        mainAxisSpacing: AppConstants.mediumPadding,
        childAspectRatio: 0.65,
      ),
      itemCount: products!.length,
      itemBuilder: (context, index) {
        final product = products![index];
        return _ProductCard(
          product: product,
          onTap: () => onTap(product),
          onAddToCart: () => onAddToCart(product),
        );
      },
    );
  }

  Widget _buildFallbackCard(BuildContext context, String message) {
    return Card(
      margin: const EdgeInsets.all(AppConstants.mediumPadding),
      elevation: 4,
      shape:
          RoundedRectangleBorder(borderRadius: AppConstants.cardBorderRadius),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product? product;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _ProductCard({
    required this.product,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    // if (product == null) {
    //   debugPrint('Product is null');
    //   return ProductCardList._buildFallbackCard(context, 'No product data');
    // }

    // // Log product data for debugging
    // debugPrint('Product: ${product!.name}, '
    //     'imageUrl: ${product!.imageUrl}, '
    //     'price: ${product!.price}, '
    //     'discount: ${product!.discount}, '
    //     'stock: ${product!.stock}, '
    //     'rating: ${product!.rating}, '
    //     'subSubcategoryId: ${product!.subSubcategoryId}, '
    //     'categoryId: ${product!.categoryId}');

    return Card(
      margin: const EdgeInsets.all(4),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.cardBorderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppConstants.cardBorderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: AppConstants.cardBorderRadius,
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(),
                const SizedBox(height: 12),
                _buildProductName(context),
                const SizedBox(height: 8),
                _buildPriceAndRating(context),
                const SizedBox(height: 12),
                _buildAddToCartButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    final imageUrl = product!.imageUrl;
    if (imageUrl == null) {
      debugPrint('Image URL is null for product: ${product!.name}');
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: AppConstants.cardBorderRadius,
          child: SizedBox(
            width: double.infinity,
            height: 150,
            child: Image.network(
              imageUrl as String,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                debugPrint('Image load error for URL: $imageUrl');
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        if ((product!.discount ?? 0) > 0) _buildSaleBadge(),
        _buildStockBadge(),
      ],
    );
  }

  Widget _buildSaleBadge() {
    final discount = product!.discount ?? 0;
    return Positioned(
      top: 8,
      left: 8,
      child: _Badge(
        text: '$discount% OFF',
        color: Colors.redAccent,
      ),
    );
  }

  Widget _buildStockBadge() {
    final stock = product!.stock ?? 0;
    return Positioned(
      bottom: 8,
      right: 8,
      child: _Badge(
        text: stock > 0 ? 'In Stock' : 'Out of Stock',
        color: stock > 0 ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildProductName(BuildContext context) {
    final name = product!.name;
    if (name == null) {
      debugPrint('Product name is null');
    }

    return Text(
      name ?? 'Unnamed Product',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ) ??
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildPriceAndRating(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPrice(),
        _RatingBadge(rating: product!.rating ?? 0.0),
      ],
    );
  }

  Widget _buildPrice() {
    final price = product!.price;
    final discount = product!.discount ?? 0;

    if (price == null) {
      debugPrint('Price is null for product: ${product!.name}');
    }

    final effectivePrice = price ?? 0.0;
    final discountedPrice =
        discount > 0 ? effectivePrice * (1 - discount / 100) : effectivePrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (discount > 0)
          Text(
            '\$${effectivePrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          '\$${discountedPrice.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: discount > 0 ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    final stock = product!.stock ?? 0;
    return AnimatedScale(
      scale: stock > 0 ? 1.0 : 0.95,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: stock > 0 ? onAddToCart : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            elevation: stock > 0 ? 2 : 0,
          ),
          icon: const Icon(Icons.shopping_cart, size: 20),
          label: const Text(
            'Add to Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

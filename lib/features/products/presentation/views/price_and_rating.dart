import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/products.dart';

class PriceAndRating extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final Product product;

  const PriceAndRating({
    required this.theme,
    required this.isDarkMode,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final priceColor = AppConstants.primaryColor ?? Colors.blue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----------- Price Section ------------
        Row(
          children: [
            Text(
              '\$${(product.discountedPrice ?? product.price).toStringAsFixed(2)}',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: priceColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            if (product.discountedPrice != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        // ----------- Rating and Stock Badges ------------
        Row(
          children: [
            _buildBadge(
              color: Colors.amber,
              icon: Iconsax.star1,
              label: '${product.rating.toStringAsFixed(1)}',
            ),
            const SizedBox(width: 12),
            _buildBadge(
              color: product.stock > 0 ? Colors.green : Colors.red,
              icon: Iconsax.box,
              label: product.stock > 0
                  ? '${product.stock} Available'
                  : 'Out of Stock',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge(
      {required Color color, required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

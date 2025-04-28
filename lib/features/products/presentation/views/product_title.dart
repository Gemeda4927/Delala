import 'package:flutter/material.dart';
import '../../data/models/products.dart';

class ProductTitle extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final Product product;

  const ProductTitle({
    required this.theme,
    required this.isDarkMode,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 28,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (product.discount != null && product.discount! > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.redAccent, Colors.pinkAccent],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${product.discount}% OFF',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
      ],
    );
  }
}
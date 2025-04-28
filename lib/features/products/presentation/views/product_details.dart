import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/products.dart';

class ProductDetails extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final Product product;

  const ProductDetails({
    required this.theme,
    required this.isDarkMode,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDescription = product.description.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [Colors.blueAccent, Colors.lightBlueAccent]
                      : [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Iconsax.document_text5,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Product Details',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.grey.shade800, Colors.grey.shade900]
                  : [Colors.white, Colors.grey.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: hasDescription
              ? Text(
                  product.description,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[800],
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.8,
                    letterSpacing: 0.5,
                  ),
                )
              : Row(
                  children: [
                    Icon(
                      Iconsax.warning_2,
                      color: isDarkMode ? Colors.redAccent : Colors.red,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'No description available.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDarkMode ? Colors.red[100] : Colors.red[700],
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

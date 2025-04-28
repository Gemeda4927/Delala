import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/products.dart';

class BottomActionBar extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final Product product;
  final String? selectedSize;
  final String? selectedColor;
  final BuildContext context;

  const BottomActionBar({
    required this.theme,
    required this.isDarkMode,
    required this.product,
    required this.selectedSize,
    required this.selectedColor,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Iconsax.shopping_cart5),
              label: const Text('Add to Cart'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                side: BorderSide(
                  color: AppConstants.primaryColor ?? Colors.blue,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: product.stock > 0
                  ? () {
                      if (selectedSize == null || selectedColor == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select size and color')),
                        );
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to cart')),
                      );
                    }
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Iconsax.shopping_bag5),
              label: const Text('Buy Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor ?? Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
                elevation: 8,
              ),
              onPressed: product.stock > 0
                  ? () {
                      if (selectedSize == null || selectedColor == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select size and color')),
                        );
                        return;
                      }
                      // Proceed to checkout
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
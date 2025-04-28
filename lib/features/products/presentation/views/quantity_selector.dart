import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuantitySelector extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final int quantity;
  final int stock;
  final ValueChanged<int> onQuantityChanged;

  const QuantitySelector({
    required this.theme,
    required this.isDarkMode,
    required this.quantity,
    required this.stock,
    required this.onQuantityChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Quantity',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [Colors.grey[800]!, Colors.grey[900]!]
                    : [Colors.white, Colors.grey[100]!],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) onQuantityChanged(quantity - 1);
                  },
                  icon: const Icon(Iconsax.minus, size: 24),
                ),
                SizedBox(
                  width: 50,
                  child: Text(
                    '$quantity',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (quantity < stock) onQuantityChanged(quantity + 1);
                  },
                  icon: const Icon(Iconsax.add, size: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
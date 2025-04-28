import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';

class SizeColorSelector extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;
  final List<String> sizes;
  final List<String> colors;
  final String? selectedSize;
  final String? selectedColor;
  final ValueChanged<String?> onSizeSelected;
  final ValueChanged<String?> onColorSelected;

  const SizeColorSelector({
    required this.theme,
    required this.isDarkMode,
    required this.sizes,
    required this.colors,
    required this.selectedSize,
    required this.selectedColor,
    required this.onSizeSelected,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: sizes.map((size) {
            return ChoiceChip(
              label: Text(size),
              selected: selectedSize == size,
              onSelected: (selected) {
                onSizeSelected(selected ? size : null);
              },
              selectedColor: AppConstants.primaryColor ?? Colors.blue,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              labelStyle: TextStyle(
                color: selectedSize == size
                    ? Colors.white
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          'Color',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((color) {
            return ChoiceChip(
              label: Text(color),
              selected: selectedColor == color,
              onSelected: (selected) {
                onColorSelected(selected ? color : null);
              },
              selectedColor: AppConstants.primaryColor ?? Colors.blue,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              labelStyle: TextStyle(
                color: selectedColor == color
                    ? Colors.white
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
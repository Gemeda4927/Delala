import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/products.dart';

class Specifications extends StatelessWidget {
  final ThemeData theme;
  final Product product;

  const Specifications({
    required this.theme,
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (product.attributes.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specifications',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        // Wrap in SingleChildScrollView for vertical scrolling if needed
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: theme.brightness == Brightness.dark
                    ? [Colors.grey[900]!, Colors.grey[850]!]
                    : [Colors.white, Colors.grey[100]!],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(
                      theme.brightness == Brightness.dark ? 0.2 : 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(), // Smooth scrolling effect
              child: Row(
                children: product.attributes.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SpecificationItem(
                      title: entry.key,
                      value: entry.value.toString(),
                      theme: theme,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String title;
  final String value;
  final ThemeData theme;

  const SpecificationItem({
    required this.title,
    required this.value,
    required this.theme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 220, // Fixed width for consistent horizontal scrolling
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.blueGrey[900]!.withOpacity(0.3)
            : Colors.blue[50]!.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.blueGrey[700]! : Colors.blue[100]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isDark ? Colors.blue[800] : Colors.blue[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.tick_circle,
              size: 18,
              color: isDark ? Colors.blue[200] : Colors.blue[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black87,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

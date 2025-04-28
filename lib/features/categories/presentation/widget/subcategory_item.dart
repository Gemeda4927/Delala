import 'package:delala/core/constants/constants.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/categories/presentation/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SubcategoryItem extends StatelessWidget {
  final SubcategoryEntity subcategory;
  final VoidCallback onTap;

  const SubcategoryItem(
      {super.key, required this.subcategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppConstants.cardBorderRadius,
      onTap: onTap,
      splashColor: AppConstants.primaryColor.withOpacity(0.1),
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: AppConstants.cardBackgroundColor,
          borderRadius: AppConstants.cardBorderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 100,
                height: 100,
                color: AppConstants.cardBackgroundColor,
                child: buildImageWidget(
                  imageUrl: subcategory.imageUrl,
                  icon: Iconsax.category,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            SizedBox(
              width: 100,
              child: Text(
                subcategory.name,
                style: AppConstants.captionText.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppConstants.primaryTextColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'View More',
                style: AppConstants.captionText.copyWith(
                  fontSize: 12,
                  color: AppConstants.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

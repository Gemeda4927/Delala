import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import './static_seller.dart';

class SellerCard extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;

  const SellerCard({
    required this.theme,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final seller = StaticSeller.seller;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // TODO: Navigate to seller profile
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Colors.grey[900]!, Colors.black]
                : [Colors.white, Colors.grey[100]!],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.25)
                  : Colors.grey.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              backgroundImage: seller.profilePicture != null
                  ? NetworkImage(seller.profilePicture!)
                  : null,
              child: seller.profilePicture == null
                  ? const Icon(Iconsax.user_octagon,
                      size: 36, color: Colors.grey)
                  : null,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sold by',
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    seller.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: isDarkMode ? Colors.white : Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Iconsax.star1, color: Colors.amber, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '${seller.rating} ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        '(${seller.reviewCount} reviews)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Iconsax.clock, color: Colors.grey[400], size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Responds in ${seller.responseTime}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // TODO: Navigate to seller profile
              },
              icon: Icon(
                Iconsax.arrow_right_3,
                color: isDarkMode ? Colors.white : Colors.black,
                size: 28,
              ),
              splashRadius: 24,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerReviews extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;

  const CustomerReviews({
    required this.theme,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customer Reviews',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 24,
            color: isDarkMode ? Colors.white : Colors.black87,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        ReviewItem(
          name: 'Alex Johnson',
          rating: 5,
          date: '2 days ago',
          comment:
              'This product exceeded my expectations. The quality is amazing and it arrived earlier than expected!',
          theme: theme,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 12),
        ReviewItem(
          name: 'Sarah Miller',
          rating: 4,
          date: '1 week ago',
          comment:
              'Very good product, but the color was slightly different than shown in the picture.',
          theme: theme,
          isDarkMode: isDarkMode,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {
              // Navigate to full reviews page
            },
            icon: Icon(
              Iconsax.arrow_right_3,
              color: AppConstants.primaryColor ?? Colors.blue,
              size: 20,
            ),
            label: Text(
              'View All Reviews',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppConstants.primaryColor ?? Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReviewItem extends StatelessWidget {
  final String name;
  final int rating;
  final String date;
  final String comment;
  final ThemeData theme;
  final bool isDarkMode;

  const ReviewItem({
    required this.name,
    required this.rating,
    required this.date,
    required this.comment,
    required this.theme,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.grey[850]!, Colors.grey[900]!]
              : [Colors.white, Colors.grey[50]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDarkMode
              ? Colors.grey[700]!
              : AppConstants.primaryColor?.withOpacity(0.2) ??
                  Colors.blue[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppConstants.primaryColor?.withOpacity(0.1) ??
                    Colors.blue[100],
                child: Icon(
                  Iconsax.user,
                  color: AppConstants.primaryColor ?? Colors.blue,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      date,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Iconsax.star1,
                color: index < rating ? Colors.amber : Colors.grey[300],
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            comment,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

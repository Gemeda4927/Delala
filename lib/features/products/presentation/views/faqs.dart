import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:animate_do/animate_do.dart';

class FAQs extends StatelessWidget {
  final ThemeData theme;
  final bool isDarkMode;

  const FAQs({
    required this.theme,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Frequently Asked Questions',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: isDarkMode ? Colors.white : Colors.black87,
              letterSpacing: 0.7,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ...[
          FAQItem(
            question: 'What is the return policy?',
            answer:
                'You can return the product within 30 days of purchase with the original receipt. Ensure the item is in its original condition and packaging.',
            theme: theme,
            isDarkMode: isDarkMode,
            animationDelay: 600,
          ),
          FAQItem(
            question: 'Is international shipping available?',
            answer:
                'Yes, we ship to over 50 countries. Check shipping details at checkout for estimated delivery times and costs.',
            theme: theme,
            isDarkMode: isDarkMode,
            animationDelay: 700,
          ),
          FAQItem(
            question: 'How do I track my order?',
            answer:
                'Once your order is shipped, you’ll receive a tracking number via email. Use it on our website or the carrier’s portal to track your package.',
            theme: theme,
            isDarkMode: isDarkMode,
            animationDelay: 800,
          ),
        ],
      ],
    );
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  final ThemeData theme;
  final bool isDarkMode;
  final int animationDelay;

  const FAQItem({
    required this.question,
    required this.answer,
    required this.theme,
    required this.isDarkMode,
    required this.animationDelay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: animationDelay),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.grey[850]!, Colors.grey[900]!]
                : [
                    (AppConstants.primaryColor ?? Colors.blue)
                        .withOpacity(0.05),
                    Colors.white,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : (AppConstants.primaryColor ?? Colors.blue).withOpacity(0.1),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: isDarkMode
                ? Colors.grey[700]!
                : (AppConstants.primaryColor ?? Colors.blue).withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor:
                (AppConstants.primaryColor ?? Colors.blue).withOpacity(0.1),
          ),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppConstants.primaryColor ?? Colors.blue,
                    (AppConstants.primaryColor ?? Colors.blue).withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Iconsax.message_question,
                color: Colors.white,
                size: 22,
              ),
            ),
            title: Text(
              question,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            iconColor: AppConstants.primaryColor ?? Colors.blue,
            collapsedIconColor:
                isDarkMode ? Colors.grey[400] : Colors.grey[600],
            tilePadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            childrenPadding:
                const EdgeInsets.only(bottom: 16, left: 20, right: 20),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideInUp(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  answer,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

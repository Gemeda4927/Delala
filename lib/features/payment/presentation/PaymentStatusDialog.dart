import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:delala/features/payment/presentation/payment_page.dart';

class PaymentStatusDialog extends StatelessWidget {
  final PaymentStatus status;
  final String reference;
  final String amount;
  final VoidCallback onClose;

  const PaymentStatusDialog({
    super.key,
    required this.status,
    required this.reference,
    required this.amount,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    late IconData icon;
    late Color color;
    late String title;
    late String message;

    switch (status) {
      case PaymentStatus.success:
        icon = Iconsax.tick_circle;
        color = Colors.green.shade500;
        title = 'Payment Successful!';
        message = 'Your payment of ETB $amount was processed successfully.';
        break;
      case PaymentStatus.failed:
        icon = Iconsax.close_circle;
        color = Colors.red.shade500;
        title = 'Payment Failed';
        message = 'The payment could not be processed. Please try again.';
        break;
      case PaymentStatus.cancelled:
        icon = Iconsax.info_circle;
        color = Colors.orange.shade500;
        title = 'Payment Cancelled';
        message = 'The payment was cancelled. No amount was deducted.';
        break;
      case PaymentStatus.unknown:
        icon = Iconsax.warning_2;
        color = Colors.orange.shade500;
        title = 'Payment Status Unknown';
        message =
            'We could not verify your payment status. Please check your email or contact support.';
        break;
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: theme.colorScheme.surface,
      elevation: 8,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(icon, color: color, size: 56),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Iconsax.receipt_text,
                      size: 22, color: Colors.grey.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Reference: $reference',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  shadowColor: color.withOpacity(0.4),
                ),
                child: Text(
                  status == PaymentStatus.success
                      ? 'Back to Home'
                      : 'Try Again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

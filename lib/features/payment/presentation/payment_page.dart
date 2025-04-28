import 'package:chapasdk/chapasdk.dart';
import 'package:delala/features/payment/presentation/PaymentStatusDialog.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentPage extends StatefulWidget {
  final double total;
  final String address;
  final String phoneNumber;
  final String? deliveryNote;

  const PaymentPage({
    super.key,
    required this.total,
    required this.address,
    required this.phoneNumber,
    this.deliveryNote,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  bool _isProcessing = false;
  String? _paymentError;
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final surfaceColor = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Secure Payment',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: surfaceColor,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, color: primaryColor, size: 26),
          onPressed: () => Navigator.pop(context),
          splashRadius: 24,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [surfaceColor, surfaceColor.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary Card
            _buildSummaryCard(theme),
            const SizedBox(height: 24),

            // Payment Methods
            Text(
              'Choose Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6,
              children: [
                _buildPaymentMethodCard(
                  icon: Iconsax.mobile,
                  title: 'Chapa',
                  color: Colors.purple.shade400,
                  description: 'Fast & Secure',
                ),
                _buildPaymentMethodCard(
                  icon: Iconsax.money,
                  title: 'Telebirr',
                  color: Colors.blue.shade400,
                  description: 'Coming Soon',
                  comingSoon: true,
                ),
                _buildPaymentMethodCard(
                  icon: Iconsax.card_pos,
                  title: 'CBE Birr',
                  color: Colors.green.shade400,
                  description: 'Coming Soon',
                  comingSoon: true,
                ),
                _buildPaymentMethodCard(
                  icon: Iconsax.wallet,
                  title: 'M-Pesa',
                  color: Colors.orange.shade400,
                  description: 'Coming Soon',
                  comingSoon: true,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Error Message
            if (_paymentError != null)
              AnimatedOpacity(
                opacity: _paymentError != null ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.red.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade100.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Iconsax.warning_2,
                          color: Colors.red.shade600, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _paymentError!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Terms and Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Iconsax.info_circle,
                    size: 18, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'By proceeding, you agree to our ',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'Payment Terms',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and authorize the transaction.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: MouseRegion(
          onEnter: (_) => _animationController.forward(),
          onExit: (_) => _animationController.reverse(),
          child: ScaleTransition(
            scale: _buttonScaleAnimation,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _initiateChapaPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: primaryColor.withOpacity(0.4),
                minimumSize: const Size(double.infinity, 56),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.wifi5, size: 20, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'PAY NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(ThemeData theme) {
    return Card(
      elevation: 4,
      shadowColor: theme.colorScheme.onSurface.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceVariant.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'ETB ${widget.total.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.green.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: theme.dividerColor.withOpacity(0.3)),
              const SizedBox(height: 16),
              _buildSummaryRow(
                icon: Iconsax.location,
                title: 'Delivery Address',
                value: widget.address,
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSummaryRow(
                icon: Iconsax.call,
                title: 'Phone Number',
                value: widget.phoneNumber,
                theme: theme,
              ),
              if (widget.deliveryNote != null) ...[
                const SizedBox(height: 12),
                _buildSummaryRow(
                  icon: Iconsax.note,
                  title: 'Delivery Note',
                  value: widget.deliveryNote!,
                  theme: theme,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String title,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodCard({
    required IconData icon,
    required String title,
    required Color color,
    required String description,
    bool comingSoon = false,
  }) {
    return GestureDetector(
      onTap: comingSoon
          ? null
          : () {
              if (title == 'Chapa') _initiateChapaPayment();
            },
      child: Card(
        elevation: 3,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    if (comingSoon) ...[
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Soon',
                          style: TextStyle(
                            color: Colors.orange.shade800,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _initiateChapaPayment() async {
    setState(() {
      _isProcessing = true;
      _paymentError = null;
    });

    try {
      if (kIsWeb) {
        setState(() {
          _paymentError =
              'Payments are not supported on the web yet. Please use our mobile app.';
          _isProcessing = false;
        });
        return;
      }

      final txRef = 'DELALA-${DateTime.now().millisecondsSinceEpoch}';

      await Chapa.paymentParameters(
        context: context,
        publicKey: 'CHASECK_TEST-2FeQC4Xs0ve2aN0khhByc3fmZSh3aeE7',
        currency: 'ETB',
        amount: widget.total.toStringAsFixed(2),
        email: 'customer@example.com',
        phone: widget.phoneNumber,
        firstName: 'Customer',
        lastName: 'Name',
        txRef: txRef,
        title: 'Order Payment',
        desc: 'Payment for order #$txRef',
        nativeCheckout: true,
        namedRouteFallBack: '',
        showPaymentMethodsOnGridView: true,
        availablePaymentMethods: ['mpesa', 'cbebirr', 'telebirr', 'ebirr'],
        onPaymentFinished: (message, reference, amount) {
          _handlePaymentResult(message, reference, amount);
        },
      );
    } catch (e) {
      setState(() {
        _paymentError = 'Failed to initiate payment: $e';
        _isProcessing = false;
      });
    }
  }

  void _handlePaymentResult(String message, String reference, String amount) {
    Navigator.pop(context);

    setState(() {
      _isProcessing = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PaymentStatusDialog(
        status: _getPaymentStatus(message),
        reference: reference,
        amount: amount,
        onClose: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }

  PaymentStatus _getPaymentStatus(String message) {
    if (message.toLowerCase().contains('success')) {
      return PaymentStatus.success;
    } else if (message.toLowerCase().contains('fail')) {
      return PaymentStatus.failed;
    } else if (message.toLowerCase().contains('cancel')) {
      return PaymentStatus.cancelled;
    } else {
      return PaymentStatus.unknown;
    }
  }
}

enum PaymentStatus { success, failed, cancelled, unknown }

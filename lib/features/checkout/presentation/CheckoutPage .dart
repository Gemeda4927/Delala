// import 'package:delala/features/payment/presentation/payment_page.dart';
// import 'package:delala/features/products/data/models/cart.dart';
// import 'package:delala/features/products/data/models/product.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class CheckoutPage extends StatefulWidget {
//   final List<CartItem> cartItems;
//   final double subtotal;
//   final double shippingFee;
//   final double total;

//   const CheckoutPage({
//     super.key,
//     required this.cartItems,
//     required this.subtotal,
//     required this.shippingFee,
//     required this.total,
//   });

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   int _selectedPaymentMethod = 0;
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _noteController = TextEditingController();

//   final List<Map<String, dynamic>> _paymentMethods = [
//     {
//       'name': 'Cash on Delivery',
//       'icon': Iconsax.money,
//       'color': Colors.green,
//       'description': 'Pay when you receive your order'
//     },
//     {
//       'name': 'Credit Card',
//       'icon': Iconsax.card,
//       'color': Colors.blue,
//       'description': 'Pay with Visa, Mastercard, etc.',
//       'comingSoon': true
//     },
//     {
//       'name': 'Mobile Payment',
//       'icon': Iconsax.mobile,
//       'color': Colors.purple,
//       'description': 'Pay with Chapa, Telebirr, etc.',
//       // Removed 'comingSoon': true
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _addressController.text = 'Addis Ababa, Ethiopia';
//     _phoneController.text = '+251911223344';
//   }

//   @override
//   void dispose() {
//     _addressController.dispose();
//     _phoneController.dispose();
//     _noteController.dispose();
//     super.dispose();
//   }

//   void _placeOrder() {
//     if (_addressController.text.isEmpty) {
//       _showSnackBar('Please enter your address', Colors.red);
//       return;
//     }

//     if (_phoneController.text.isEmpty) {
//       _showSnackBar('Please enter your phone number', Colors.red);
//       return;
//     }

//     // Check if selected payment is coming soon
//     if (_paymentMethods[_selectedPaymentMethod]['comingSoon'] == true) {
//       _showSnackBar(
//           'This payment method is coming soon! Please select another method.',
//           Colors.orange);
//       return;
//     }

//     // If Mobile Payment is selected, navigate to PaymentPage
//     if (_paymentMethods[_selectedPaymentMethod]['name'] == 'Mobile Payment') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PaymentPage(
//             total: widget.total,
//             address: _addressController.text,
//             phoneNumber: _phoneController.text,
//             deliveryNote:
//                 _noteController.text.isNotEmpty ? _noteController.text : null,
//           ),
//         ),
//       );
//       return;
//     }

//     // For other payment methods (e.g., Cash on Delivery), show confirmation dialog
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Row(
//           children: [
//             Icon(Iconsax.tick_circle, color: Colors.green.shade700, size: 28),
//             const SizedBox(width: 12),
//             Text('Confirm Order',
//                 style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).colorScheme.onSurface)),
//           ],
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'You are about to place an order with:',
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               _paymentMethods[_selectedPaymentMethod]['name'],
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             const Text('Are you sure you want to proceed?'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel',
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _showOrderSuccess();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Theme.of(context).colorScheme.primary,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//             child: Text('Confirm',
//                 style: TextStyle(
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     fontSize: 16)),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showOrderSuccess() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 padding: const EdgeInsets.all(24),
//                 child: Icon(
//                   Iconsax.tick_circle,
//                   color: Colors.green.shade700,
//                   size: 60,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Order Successful!',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'Your order has been placed successfully. We will contact you soon for confirmation.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 16,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.popUntil(context, (route) => route.isFirst);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12)),
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: Text(
//                     'Back to Home',
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showSnackBar(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//     final primaryColor = theme.colorScheme.primary;
//     final surfaceColor = theme.colorScheme.surface;
//     final onSurfaceColor = theme.colorScheme.onSurface;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: surfaceColor,
//         leading: IconButton(
//           icon: Icon(Iconsax.arrow_left_2, color: primaryColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Delivery Information
//             _buildSectionCard(
//               title: 'Delivery Information',
//               icon: Iconsax.truck,
//               children: [
//                 _buildTextField(
//                   controller: _addressController,
//                   label: 'Delivery Address',
//                   icon: Iconsax.location,
//                   color: Colors.blue,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   controller: _phoneController,
//                   label: 'Phone Number',
//                   icon: Iconsax.call,
//                   color: Colors.green,
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   controller: _noteController,
//                   label: 'Delivery Note (Optional)',
//                   icon: Iconsax.note,
//                   color: Colors.orange,
//                   maxLines: 3,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Payment Method
//             _buildSectionCard(
//               title: 'Payment Method',
//               icon: Iconsax.wallet,
//               children: [
//                 ..._paymentMethods.asMap().entries.map((entry) {
//                   final index = entry.key;
//                   final method = entry.value;
//                   final isComingSoon = method['comingSoon'] == true;

//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(
//                         color: _selectedPaymentMethod == index
//                             ? method['color'].withOpacity(0.8)
//                             : Colors.grey.withOpacity(0.3),
//                         width: _selectedPaymentMethod == index ? 1.5 : 1,
//                       ),
//                       color: _selectedPaymentMethod == index
//                           ? method['color'].withOpacity(0.05)
//                           : Colors.transparent,
//                     ),
//                     child: Stack(
//                       children: [
//                         RadioListTile<int>(
//                           value: index,
//                           groupValue: _selectedPaymentMethod,
//                           onChanged: (value) {
//                             setState(() => _selectedPaymentMethod = value!);
//                           },
//                           title: Text(
//                             method['name'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: onSurfaceColor,
//                             ),
//                           ),
//                           subtitle: Text(
//                             method['description'],
//                             style: TextStyle(
//                               color: Colors.grey.shade600,
//                               fontSize: 13,
//                             ),
//                           ),
//                           secondary: Container(
//                             decoration: BoxDecoration(
//                               color: method['color'].withOpacity(0.1),
//                               shape: BoxShape.circle,
//                             ),
//                             padding: const EdgeInsets.all(10),
//                             child: Icon(
//                               method['icon'],
//                               color: method['color'],
//                               size: 22,
//                             ),
//                           ),
//                           activeColor: method['color'],
//                           contentPadding: const EdgeInsets.only(
//                               right: 16, left: 8, top: 8, bottom: 8),
//                         ),
//                         if (isComingSoon)
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.orange.withOpacity(0.2),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 'Coming Soon',
//                                 style: TextStyle(
//                                   color: Colors.orange.shade800,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Order Summary
//             _buildSectionCard(
//               title: 'Order Summary',
//               icon: Iconsax.shopping_bag,
//               children: [
//                 ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: widget.cartItems.length,
//                   separatorBuilder: (context, index) => Divider(
//                     height: 24,
//                     color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
//                     thickness: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     final item = widget.cartItems[index];
//                     return ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Container(
//                           width: 60,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade200,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Image.network(
//                             item.product.imageUrls[0],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 Center(
//                               child: Icon(
//                                 Iconsax.gallery_slash,
//                                 color: Colors.grey.shade400,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         item.product.name,
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: onSurfaceColor,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       subtitle: Text(
//                         '${item.quantity} × ETB ${item.product.price.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                         ),
//                       ),
//                       trailing: Text(
//                         'ETB ${(item.product.price * item.quantity).toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green.shade700,
//                           fontSize: 15,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 8),
//                 Divider(
//                     color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
//                     thickness: 1),
//                 const SizedBox(height: 12),
//                 _buildSummaryRow('Subtotal', widget.subtotal, onSurfaceColor),
//                 const SizedBox(height: 8),
//                 _buildSummaryRow(
//                     'Shipping Fee', widget.shippingFee, onSurfaceColor),
//                 const SizedBox(height: 12),
//                 Divider(
//                     color: isDarkMode ? Colors.grey[700] : Colors.grey[200],
//                     thickness: 1),
//                 const SizedBox(height: 12),
//                 _buildSummaryRow('Total', widget.total, Colors.green.shade700,
//                     isBold: true),
//               ],
//             ),
//             const SizedBox(height: 28),

//             // Terms and Conditions
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Icon(Iconsax.info_circle,
//                     size: 18, color: Colors.grey.shade600),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'By placing your order, you agree to our ',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 13,
//                       ),
//                       children: [
//                         TextSpan(
//                           text: 'Terms & Conditions',
//                           style: TextStyle(
//                             color: primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const TextSpan(text: ' and '),
//                         TextSpan(
//                           text: 'Privacy Policy',
//                           style: TextStyle(
//                             color: primaryColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Place Order Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _placeOrder,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   padding: const EdgeInsets.symmetric(vertical: 18),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14)),
//                   elevation: 2,
//                   shadowColor: primaryColor.withOpacity(0.3),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Iconsax.lock_1, color: Colors.white, size: 20),
//                     const SizedBox(width: 12),
//                     const Text(
//                       'PLACE ORDER',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         letterSpacing: 0.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     final theme = Theme.of(context);
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18),
//         side: BorderSide(
//           color: theme.dividerColor.withOpacity(0.2),
//           width: 1,
//         ),
//       ),
//       color: theme.colorScheme.surface,
//       margin: EdgeInsets.zero,
//       child: Padding(
//         padding: const EdgeInsets.all(18),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: theme.colorScheme.primary.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: Icon(icon, color: theme.colorScheme.primary, size: 20),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: theme.colorScheme.onSurface,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     required Color color,
//     int maxLines = 1,
//     TextInputType? keyboardType,
//   }) {
//     final theme = Theme.of(context);
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: color),
//         prefixIcon: Container(
//           margin: const EdgeInsets.only(left: 16, right: 12),
//           child: Icon(icon, color: color, size: 20),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide(color: color, width: 1.5),
//         ),
//         filled: true,
//         fillColor: theme.colorScheme.surface,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       ),
//       maxLines: maxLines,
//       keyboardType: keyboardType,
//       style: TextStyle(color: theme.colorScheme.onSurface),
//     );
//   }

//   Widget _buildSummaryRow(String title, double amount, Color color,
//       {bool isBold = false}) {
//     final theme = Theme.of(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: isBold ? 17 : 15,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
//             color: theme.colorScheme.onSurface.withOpacity(isBold ? 1 : 0.8),
//           ),
//         ),
//         Text(
//           'ETB ${amount.toStringAsFixed(2)}',
//           style: TextStyle(
//             fontSize: isBold ? 18 : 15,
//             fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }

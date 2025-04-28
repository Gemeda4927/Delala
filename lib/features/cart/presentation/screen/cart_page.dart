// import 'package:delala/core/constants/constants.dart';
// import 'package:delala/features/products/presentation/views/bottom_action_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cartManager = CartManager();
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//         centerTitle: true,
//         actions: [
//           if (cartManager.items.isNotEmpty)
//             IconButton(
//               icon: const Icon(Iconsax.trash),
//               onPressed: () {
//                 cartManager.items.clear();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Cart cleared')),
//                 );
//               },
//             ),
//         ],
//       ),
//       body: cartManager.items.isEmpty
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Iconsax.shopping_cart,
//                     size: 80,
//                     color: Colors.grey[400],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Your cart is empty',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: cartManager.items.length,
//               itemBuilder: (context, index) {
//                 final item = cartManager.items[index];
//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.only(bottom: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         // Product Image (Placeholder)
//                         Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(8),
//                             image: item.product.imageUrl != null
//                                 ? DecorationImage(
//                                     image: NetworkImage(
//                                         item.product.imageUrl as String),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : null,
//                           ),
//                           child: item.product.imageUrl == null
//                               ? Icon(
//                                   Iconsax.image,
//                                   color: Colors.grey[400],
//                                 )
//                               : null,
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.product.name,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 'Size: ${item.size} | Color: ${item.color}',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 '\$${item.product.price.toStringAsFixed(2)}',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color:
//                                       AppConstants.primaryColor ?? Colors.blue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             IconButton(
//                               icon: const Icon(Iconsax.trash),
//                               onPressed: () {
//                                 cartManager.removeFromCart(item);
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content:
//                                         Text('${item.product.name} removed'),
//                                   ),
//                                 );
//                               },
//                             ),
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: const Icon(Iconsax.minus),
//                                   onPressed: () {
//                                     cartManager.updateQuantity(
//                                         item, item.quantity - 1);
//                                   },
//                                 ),
//                                 Text(
//                                   '${item.quantity}',
//                                   style: const TextStyle(fontSize: 16),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Iconsax.add),
//                                   onPressed: () {
//                                     cartManager.updateQuantity(
//                                         item, item.quantity + 1);
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//       bottomNavigationBar: cartManager.items.isNotEmpty
//           ? Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isDarkMode ? Colors.grey[900] : Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 12,
//                     offset: const Offset(0, -4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Total:',
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Text(
//                         '\$${cartManager.totalPrice.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppConstants.primaryColor ?? Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/checkout');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppConstants.primaryColor ?? Colors.blue,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 16,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Checkout',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : null,
//     );
//   }
// }

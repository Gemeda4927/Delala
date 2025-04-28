// import 'package:delala/config/routes/route_name.dart';
// import 'package:delala/config/theme/app_theme.dart.dart';
// import 'package:delala/features/categories/domain/entities/category.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:iconly/iconly.dart';

// class CategoryCardWidget extends StatelessWidget {
//   final Category category;

//   const CategoryCardWidget({
//     super.key,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _navigateToDetail(context),
//       child: Hero(
//         tag: 'category-${category.id}',
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: AppTheme.borderRadius,
//               boxShadow: AppTheme.cardShadow,
//             ),
//             child: ClipRRect(
//               borderRadius: AppTheme.borderRadius,
//               child: Stack(
//                 children: [
//                   _buildImageWithGradient(),
//                   _buildCardContent(context),
//                   _buildFavoriteButton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildImageWithGradient() {
//     return ShaderMask(
//       shaderCallback: (bounds) => LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           Colors.transparent,
//           Colors.black.withOpacity(0.7),
//         ],
//         stops: const [0.5, 1.0],
//       ).createShader(bounds),
//       blendMode: BlendMode.darken,
//       child: category.imageUrl != null
//           ? Image.network(
//               category.imageUrl!,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return Center(
//                   child: CircularProgressIndicator(
//                     value: loadingProgress.expectedTotalBytes != null
//                         ? loadingProgress.cumulativeBytesLoaded /
//                             loadingProgress.expectedTotalBytes!
//                         : null,
//                     strokeWidth: 2,
//                     valueColor: const AlwaysStoppedAnimation(
//                       AppTheme.primaryColor,
//                     ),
//                   ),
//                 );
//               },
//               errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
//             )
//           : _buildPlaceholder(),
//     );
//   }

//   Widget _buildPlaceholder() {
//     return Container(
//       color: Colors.grey[200],
//       child: const Center(
//         child: Icon(
//           IconlyLight.category,
//           size: 48,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _buildCardContent(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               category.name,
//               style: AppTheme.heading3.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             ...[
//               const SizedBox(height: 8),
//               Text(
//                 category.description,
//                 style: AppTheme.caption.copyWith(
//                   color: Colors.white.withOpacity(0.9),
//                 ),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ],
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 _buildViewButton(context),
//                 const Spacer(),
//                 const Icon(
//                   IconlyLight.arrow_right_2,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildViewButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _navigateToDetail(context),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: AppTheme.primaryColor,
//           borderRadius: AppTheme.smallBorderRadius,
//         ),
//         child: Text(
//           'View',
//           style: AppTheme.caption.copyWith(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFavoriteButton() {
//     return Positioned(
//       top: 12,
//       right: 12,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: AppTheme.cardShadow,
//         ),
//         child: Icon(
//           IconlyLight.heart,
//           size: 20,
//           color: AppTheme.secondaryColor,
//         ),
//       ),
//     );
//   }

//   void _navigateToDetail(BuildContext context) {
//     if (category == null || category.id.isEmpty || category.id == 'null') {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Cannot navigate: Invalid or missing category'),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: AppTheme.borderRadius,
//           ),
//           margin: const EdgeInsets.all(16),
//           elevation: 6,
//         ),
//       );
//       return;
//     }

//     try {
//       context.goNamed(
//         RouteName.categoryDetail,
//         pathParameters: {'categoryId': category.id},
//         extra: category,
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Failed to navigate to category details'),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: AppTheme.borderRadius,
//           ),
//           margin: const EdgeInsets.all(16),
//           elevation: 6,
//         ),
//       );
//     }
//   }
// }

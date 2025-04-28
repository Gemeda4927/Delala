// import 'package:delala/config/theme/app_theme.dart.dart';
// import 'package:delala/features/categories/domain/entities/category.dart';
// import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
// import 'package:delala/features/categories/presentation/bloc/category_event.dart';
// import 'package:delala/features/products/presentation/widgets/category_card_widget.dart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:lottie/lottie.dart';

// class ErrorState extends StatelessWidget {
//   final List<Category> fallbackCategories;
//   final String categoryId;

//   const ErrorState({
//     required this.fallbackCategories,
//     required this.categoryId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return fallbackCategories.isEmpty
//         ? ErrorCard(
//             message: 'Oops! Something went wrong while loading categories.',
//             onRetry: () {
//               context.read<CategoryBloc>().add(GetCategoriesEvent(
//                     categoryId: categoryId,
//                     isInitialLoad: true,
//                   ));
//             },
//           )
//         : Column(
//             children: [
//               ErrorCard(
//                 message:
//                     'Showing cached data. There was an error fetching new data.',
//                 onRetry: () {
//                   context.read<CategoryBloc>().add(GetCategoriesEvent(
//                         categoryId: categoryId,
//                         isInitialLoad: true,
//                       ));
//                 },
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: AnimationLimiter(
//                   child: GridView.builder(
//                     padding: const EdgeInsets.all(20),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount:
//                           MediaQuery.of(context).size.width > 600 ? 3 : 2,
//                       crossAxisSpacing: 20,
//                       mainAxisSpacing: 20,
//                       childAspectRatio: 0.75,
//                     ),
//                     itemCount: fallbackCategories.length,
//                     itemBuilder: (context, index) {
//                       return AnimationConfiguration.staggeredGrid(
//                         position: index,
//                         duration: const Duration(milliseconds: 500),
//                         columnCount: 2,
//                         child: SlideAnimation(
//                           verticalOffset: 50.0,
//                           child: FadeInAnimation(
//                             child: CategoryCardWidget(
//                               category: fallbackCategories[index],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           );
//   }
// }

// class ErrorCard extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;

//   const ErrorCard({super.key, required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Material(
//         elevation: 4,
//         borderRadius: AppTheme.borderRadius,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surface,
//             borderRadius: AppTheme.borderRadius,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Lottie.asset(
//                 'assets/animations/error.json',
//                 height: 120,
//                 width: 120,
//                 fit: BoxFit.contain,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 message,
//                 style: AppTheme.bodyText.copyWith(
//                   color: Theme.of(context).colorScheme.onSurface,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: AppTheme.borderRadius,
//                         ),
//                         side: BorderSide(color: AppTheme.primaryColor),
//                       ),
//                       child: Text(
//                         'Dismiss',
//                         style: AppTheme.bodyText.copyWith(
//                           color: AppTheme.primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: onRetry,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: AppTheme.borderRadius,
//                         ),
//                         elevation: 0,
//                         backgroundColor: AppTheme.primaryColor,
//                       ),
//                       child: Text(
//                         'Retry',
//                         style: AppTheme.buttonText,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

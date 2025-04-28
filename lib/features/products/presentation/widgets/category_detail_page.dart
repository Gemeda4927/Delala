// import 'package:delala/config/theme/app_theme.dart.dart';
// import 'package:delala/features/categories/domain/entities/category.dart';
// import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
// import 'package:delala/features/categories/presentation/bloc/category_event.dart';
// import 'package:delala/features/categories/presentation/bloc/category_state.dart';
// import 'package:delala/features/products/presentation/widgets/category_card_widget.dart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:go_router/go_router.dart';
// import 'package:iconly/iconly.dart';
// import 'package:shimmer/shimmer.dart';

// import 'empty_state.dart';
// import 'error_state.dart';
// import 'search_and_filter_bar.dart';

// class CategoryListPage extends StatefulWidget {
//   final String categoryId;
//   final Category? category;

//   const CategoryListPage({
//     super.key,
//     required this.categoryId,
//     this.category,
//   });

//   @override
//   State<CategoryListPage> createState() => _CategoryListPageState();
// }

// class _CategoryListPageState extends State<CategoryListPage> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoadingMore = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_scrollListener);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<CategoryBloc>().add(GetCategoriesEvent(
//             categoryId: widget.categoryId,
//             isInitialLoad: true,
//           ));
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent &&
//         !_isLoadingMore) {
//       setState(() => _isLoadingMore = true);
//       context.read<CategoryBloc>().add(GetCategoriesEvent(
//             categoryId: widget.categoryId,
//             isInitialLoad: false,
//           ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: _buildAppBar(context),
//       body: Container(
//         decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
//         child: Column(
//           children: [
//             const SizedBox(height: 100),
//             SearchAndFilterBar(categoryId: widget.categoryId),
//             Expanded(
//               child: BlocConsumer<CategoryBloc, CategoryState>(
//                 listener: (context, state) {
//                   if (state is CategoryError) {
//                     _showErrorSnackbar(context, state.message);
//                   }
//                   if (state is CategoryLoaded) {
//                     setState(() => _isLoadingMore = false);
//                   }
//                 },
//                 builder: (context, state) {
//                   return AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 400),
//                     transitionBuilder: (child, animation) => FadeTransition(
//                       opacity: animation,
//                       child: child,
//                     ),
//                     child: _buildStateView(context, state),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       title: Text(
//         widget.category?.name ?? 'Categories',
//         style: AppTheme.heading2.copyWith(color: Colors.white),
//       ),
//       centerTitle: true,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppTheme.primaryColor,
//               AppTheme.primaryColor.withOpacity(0.9),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: AppTheme.buttonShadow,
//         ),
//       ),
//       leading: IconButton(
//         icon:
//             const Icon(IconlyLight.arrow_left_2, color: Colors.white, size: 28),
//         onPressed: () => context.pop(),
//         splashRadius: 24,
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(IconlyLight.bookmark, color: Colors.white, size: 24),
//           onPressed: () {},
//           splashRadius: 24,
//         ),
//       ],
//     );
//   }

//   void _showErrorSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           style: AppTheme.bodyText.copyWith(color: Colors.white),
//         ),
//         backgroundColor: Colors.redAccent,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: AppTheme.borderRadius),
//         margin: const EdgeInsets.all(16),
//         elevation: 6,
//       ),
//     );
//   }

//   Widget _buildStateView(BuildContext context, CategoryState state) {
//     if (state is CategoryLoading) {
//       return const _ShimmerLoadingGrid();
//     } else if (state is CategoryLoaded) {
//       final filtered = state.filteredCategories;
//       if (filtered.isEmpty) return const EmptyState();
//       return _buildGridView(context, filtered);
//     } else if (state is CategoryError) {
//       return ErrorState(
//         fallbackCategories: state.fallbackCategories,
//         categoryId: widget.categoryId,
//       );
//     }
//     return const EmptyState();
//   }

//   Widget _buildGridView(BuildContext context, List<Category> categories) {
//     return RefreshIndicator(
//       onRefresh: () async {
//         context.read<CategoryBloc>().add(GetCategoriesEvent(
//               categoryId: widget.categoryId,
//               isInitialLoad: true,
//             ));
//       },
//       color: AppTheme.primaryColor,
//       backgroundColor: AppTheme.lightColor,
//       strokeWidth: 3,
//       child: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification is ScrollEndNotification &&
//               _scrollController.position.pixels == 0) {
//             context.read<CategoryBloc>().add(GetCategoriesEvent(
//                   categoryId: widget.categoryId,
//                   isInitialLoad: true,
//                 ));
//           }
//           return false;
//         },
//         child: AnimationLimiter(
//           child: CustomScrollView(
//             controller: _scrollController,
//             physics: const AlwaysScrollableScrollPhysics(),
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.all(20),
//                 sliver: SliverGrid(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount:
//                         MediaQuery.of(context).size.width > 600 ? 3 : 2,
//                     crossAxisSpacing: 20,
//                     mainAxisSpacing: 20,
//                     childAspectRatio: 0.75,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                       if (index < categories.length) {
//                         return AnimationConfiguration.staggeredGrid(
//                           position: index,
//                           duration: const Duration(milliseconds: 500),
//                           columnCount: 2,
//                           child: SlideAnimation(
//                             verticalOffset: 50.0,
//                             child: FadeInAnimation(
//                               child: CategoryCardWidget(
//                                 category: categories[index],
//                               ),
//                             ),
//                           ),
//                         );
//                       }
//                       return null;
//                     },
//                     childCount: categories.length,
//                   ),
//                 ),
//               ),
//               if (_isLoadingMore)
//                 const SliverToBoxAdapter(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.0),
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         valueColor:
//                             AlwaysStoppedAnimation(AppTheme.primaryColor),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ShimmerLoadingGrid extends StatelessWidget {
//   const _ShimmerLoadingGrid();

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(20),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//         childAspectRatio: 0.75,
//       ),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey[300]!,
//           highlightColor: Colors.grey[100]!,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: AppTheme.borderRadius,
//               color: Colors.white,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

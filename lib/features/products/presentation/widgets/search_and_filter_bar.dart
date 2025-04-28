// import 'dart:async';

// import 'package:delala/config/routes/route_name.dart';
// import 'package:delala/config/theme/app_theme.dart.dart';
// import 'package:delala/features/categories/domain/entities/category.dart';
// import 'package:delala/features/categories/presentation/bloc/category_bloc.dart';
// import 'package:delala/features/categories/presentation/bloc/category_event.dart';
// import 'package:delala/features/categories/presentation/bloc/category_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:iconly/iconly.dart';

// /// A widget that provides a search bar, subcategory dropdown, and filter options
// /// for categories.
// class SearchAndFilterBar extends StatefulWidget {
//   final String categoryId;

//   const SearchAndFilterBar({
//     super.key,
//     required this.categoryId,
//   });

//   @override
//   State<SearchAndFilterBar> createState() => _SearchAndFilterBarState();
// }

// class _SearchAndFilterBarState extends State<SearchAndFilterBar> {
//   Timer? _debounce;
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();
//   String? _selectedSubcategory;

//   @override
//   void initState() {
//     super.initState();
//     _searchController
//         .addListener(() => _onSearchChanged(_searchController.text));
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _searchController.dispose();
//     super.dispose();
//   }

//   /// Triggers a debounced search event when the search text changes.
//   void _onSearchChanged(String value) {
//     setState(() => _isSearching = true);
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), () {
//       context.read<CategoryBloc>().add(FilterCategoriesEvent(value));
//       setState(() => _isSearching = false);
//     });
//   }

//   /// Shows a bottom sheet with sort and filter options.
//   void _showFilterBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 32,
//               spreadRadius: 0,
//               offset: const Offset(0, -8),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.only(top: 16),
//         child: DraggableScrollableSheet(
//           initialChildSize: 0.5,
//           maxChildSize: 0.9,
//           minChildSize: 0.3,
//           expand: false,
//           builder: (context, scrollController) => Column(
//             children: [
//               Container(
//                 width: 48,
//                 height: 4,
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[400],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Filter & Sort',
//                       style: AppTheme.heading3.copyWith(
//                         color: Theme.of(context).colorScheme.onSurface,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(IconlyLight.close_square, size: 24),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 16,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildSectionTitle('Sort Options'),
//                       _buildSortOption(context, 'Name (A-Z)', 'name_asc'),
//                       _buildSortOption(context, 'Name (Z-A)', 'name_desc'),
//                       _buildSortOption(context, 'Most Popular', 'popular'),
//                       _buildSortOption(context, 'Newest First', 'newest'),
//                       const SizedBox(height: 24),
//                       _buildSectionTitle('Filter Options'),
//                       _buildFilterChip('On Sale', Icons.local_offer_outlined),
//                       _buildFilterChip('In Stock', Icons.inventory_2_outlined),
//                       _buildFilterChip('Top Rated', Icons.star_border_outlined),
//                       const SizedBox(height: 32),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 18),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: AppTheme.borderRadius,
//                             ),
//                             elevation: 0,
//                             backgroundColor: AppTheme.primaryColor,
//                           ),
//                           child: Text(
//                             'Apply Filters',
//                             style: AppTheme.buttonText,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Builds a section title for the filter bottom sheet.
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16, top: 8),
//       child: Text(
//         title,
//         style: AppTheme.caption.copyWith(
//           fontWeight: FontWeight.w600,
//           color: AppTheme.primaryColor,
//         ),
//       ),
//     );
//   }

//   /// Builds a sort option tile for the filter bottom sheet.
//   Widget _buildSortOption(BuildContext context, String title, String sortType) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: AppTheme.primaryColor.withOpacity(0.1),
//           borderRadius: AppTheme.smallBorderRadius,
//         ),
//         child: Icon(
//           _getSortIcon(sortType),
//           size: 20,
//           color: AppTheme.primaryColor,
//         ),
//       ),
//       title: Text(title, style: AppTheme.bodyText),
//       trailing: const Icon(IconlyLight.arrow_right_2, size: 20),
//       onTap: () {
//         context.read<CategoryBloc>().add(SortCategoriesEvent(sortType));
//         Navigator.pop(context);
//       },
//     );
//   }

//   /// Returns the appropriate icon for a sort type.
//   IconData _getSortIcon(String sortType) {
//     switch (sortType) {
//       case 'name_asc':
//         return IconlyLight.arrow_up_2;
//       case 'name_desc':
//         return IconlyLight.arrow_down_2;
//       case 'popular':
//         return IconlyLight.user;
//       case 'newest':
//         return IconlyLight.time_circle;
//       default:
//         return IconlyLight.filter;
//     }
//   }

//   /// Builds a filter chip for the filter bottom sheet.
//   Widget _buildFilterChip(String label, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8, bottom: 8),
//       child: FilterChip(
//         label: Text(label, style: AppTheme.caption),
//         avatar: Icon(icon, size: 16),
//         selected: false,
//         onSelected: (bool selected) {},
//         backgroundColor: Colors.transparent,
//         shape: StadiumBorder(
//           side: BorderSide(color: Colors.grey.withOpacity(0.3)),
//         ),
//         selectedColor: AppTheme.primaryColor.withOpacity(0.1),
//         checkmarkColor: AppTheme.primaryColor,
//         labelPadding: const EdgeInsets.symmetric(horizontal: 8),
//       ),
//     );
//   }

//   /// Navigates to the category detail page for the first available category.
//   void _navigateToCategoryDetail(BuildContext context) {
//     final state = context.read<CategoryBloc>().state;
//     if (state is CategoryLoaded && state.filteredCategories.isNotEmpty) {
//       final category = state.filteredCategories.first;
//       context.goNamed(
//         RouteName.categoryDetail,
//         pathParameters: {'categoryId': category.id},
//         extra: category,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'No categories available to view.',
//             style: AppTheme.bodyText.copyWith(color: Colors.white),
//           ),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: AppTheme.borderRadius,
//           ),
//           margin: const EdgeInsets.all(16),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: AppTheme.borderRadius,
//                       boxShadow: AppTheme.cardShadow,
//                     ),
//                     child: TextField(
//                       controller: _searchController,
//                       onChanged: _onSearchChanged,
//                       style: AppTheme.bodyText,
//                       decoration: InputDecoration(
//                         hintText: 'Search categories...',
//                         hintStyle: AppTheme.bodyText.copyWith(
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onSurfaceVariant
//                               .withOpacity(0.5),
//                         ),
//                         prefixIcon: const Icon(
//                           IconlyLight.search,
//                           size: 22,
//                           color: AppTheme.primaryColor,
//                         ),
//                         suffixIcon: _isSearching
//                             ? const Padding(
//                                 padding: EdgeInsets.all(12),
//                                 child: SizedBox(
//                                   width: 16,
//                                   height: 16,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation(
//                                       AppTheme.primaryColor,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : _searchController.text.isNotEmpty
//                                 ? IconButton(
//                                     icon: const Icon(Icons.clear, size: 20),
//                                     onPressed: () {
//                                       _searchController.clear();
//                                       _onSearchChanged('');
//                                     },
//                                   )
//                                 : null,
//                         filled: true,
//                         fillColor: Theme.of(context).colorScheme.surface,
//                         border: OutlineInputBorder(
//                           borderRadius: AppTheme.borderRadius,
//                           borderSide: BorderSide.none,
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(vertical: 0),
//                       ),
//                       textInputAction: TextInputAction.search,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 InkWell(
//                   onTap: () => _showFilterBottomSheet(context),
//                   borderRadius: AppTheme.borderRadius,
//                   child: Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       gradient: AppTheme.buttonGradient,
//                       borderRadius: AppTheme.borderRadius,
//                       boxShadow: AppTheme.buttonShadow,
//                     ),
//                     child: const Icon(
//                       IconlyLight.filter,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: BlocBuilder<CategoryBloc, CategoryState>(
//                     builder: (context, state) {
//                       List<Category> categories = [];
//                       if (state is CategoryLoaded) {
//                         categories = state.filteredCategories;
//                       }
//                       // Ensure _selectedSubcategory is valid
//                       if (_selectedSubcategory != null &&
//                           !categories
//                               .any((c) => c.id == _selectedSubcategory)) {
//                         _selectedSubcategory = null;
//                       }
//                       return Container(
//                         height: 56,
//                         decoration: BoxDecoration(
//                           borderRadius: AppTheme.borderRadius,
//                           boxShadow: AppTheme.cardShadow,
//                           color: Theme.of(context).colorScheme.surface,
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: DropdownButton<String>(
//                           value: _selectedSubcategory,
//                           hint: Text(
//                             'Select Subcategory',
//                             style: AppTheme.bodyText.copyWith(
//                               color: Theme.of(context)
//                                   .colorScheme
//                                   .onSurfaceVariant
//                                   .withOpacity(0.5),
//                             ),
//                           ),
//                           isExpanded: true,
//                           underline: const SizedBox(),
//                           items: categories.isEmpty
//                               ? [
//                                   DropdownMenuItem<String>(
//                                     value: null,
//                                     child: Text(
//                                       'No subcategories available',
//                                       style: AppTheme.bodyText,
//                                     ),
//                                   ),
//                                 ]
//                               : categories.map((Category category) {
//                                   return DropdownMenuItem<String>(
//                                     value: category.id,
//                                     child: Text(
//                                       category.name,
//                                       style: AppTheme.bodyText,
//                                     ),
//                                   );
//                                 }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedSubcategory = newValue;
//                             });
//                             if (newValue != null) {
//                               context.read<CategoryBloc>().add(
//                                     FilterCategoriesBySubcategoryEvent(
//                                       newValue,
//                                     ),
//                                   );
//                             }
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 InkWell(
//                   onTap: () => _navigateToCategoryDetail(context),
//                   borderRadius: AppTheme.borderRadius,
//                   child: Container(
//                     width: 56,
//                     height: 56,
//                     decoration: BoxDecoration(
//                       gradient: AppTheme.buttonGradient,
//                       borderRadius: AppTheme.borderRadius,
//                       boxShadow: AppTheme.buttonShadow,
//                     ),
//                     child: const Icon(
//                       IconlyLight.category,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FilterCategoriesBySubcategoryEvent extends CategoryEvent {
//   final String subcategoryId;

//   FilterCategoriesBySubcategoryEvent(this.subcategoryId);
// }

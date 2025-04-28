// import 'dart:convert';
// import 'package:delala/config/routes/route_name.dart';
// import 'package:delala/features/home/data/home_data.dart';
// import 'package:delala/features/home/presentation/bloc/home_bloc.dart';
// import 'package:delala/features/home/presentation/bloc/home_event.dart';
// import 'package:delala/features/home/presentation/bloc/home_state.dart';
// import 'package:delala/features/home/presentation/screens/AnimatedCategoryButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:carousel_slider/carousel_slider.dart' as carousel;
// import 'package:flutter/services.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeContent extends StatelessWidget {
//   final HomeLoaded state;
//   final void Function(BuildContext, String, {Object? extra, String? categoryId})
//       onNavigate;

//   const HomeContent({
//     super.key,
//     required this.state,
//     required this.onNavigate,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return _buildHomeContent(context, state);
//   }

//   Widget _buildHomeContent(BuildContext context, HomeLoaded state) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;

//     return RefreshIndicator(
//       color: theme.primaryColor,
//       backgroundColor: theme.scaffoldBackgroundColor,
//       onRefresh: () async {
//         // TODO: Implement refresh logic
//         // context.read<HomeBloc>().add(FetchHomeData());
//       },
//       child: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           SliverToBoxAdapter(child: _buildHeroBanner(context)),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             sliver: SliverList(
//               delegate: SliverChildListDelegate([
//                 _buildSearchBar(context, textTheme),
//                 const SizedBox(height: 28),
//                 _buildCategorySection(context, state, textTheme),
//                 const SizedBox(height: 32),
//                 _buildTopRankingSection(context, state, textTheme),
//                 const SizedBox(height: 32),
//                 _buildPromotionalDealsSection(context, state, textTheme),
//                 const SizedBox(height: 32),
//                 _buildTopProductsSection(context, state, textTheme),
//                 const SizedBox(height: 40),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeroBanner(BuildContext context) {
//     final banners = jsonData.asMap().entries.map((entry) {
//       final index = entry.key;
//       final product = entry.value;
//       final gradientColors =
//           _getBannerGradientColors(product['category'], index);

//       return {
//         'title': '${product['name']}\nby ${product['attributes']['brand']}',
//         'subtitle': product['description'] ?? '',
//         'image': (product['imageUrls'] as List<dynamic>?)?.first ?? '',
//         'colorStart': gradientColors['start'],
//         'colorEnd': gradientColors['end'],
//       };
//     }).toList();

//     return SizedBox(
//       height: 320,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           carousel.CarouselSlider(
//             options: carousel.CarouselOptions(
//               height: 320,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 5),
//               autoPlayAnimationDuration: const Duration(milliseconds: 1000),
//               enlargeCenterPage: false,
//               viewportFraction: 1,
//               enableInfiniteScroll: true,
//               onPageChanged: (index, reason) {
//                 context.read<HomeBloc>().add(ChangeCarouselIndex(index));
//               },
//             ),
//             items: banners.map((banner) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           banner['colorStart']! as Color,
//                           banner['colorEnd']! as Color
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(0),
//                             child: ColorFiltered(
//                               colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.1),
//                                 BlendMode.darken,
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl: banner['image']! as String,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) => Container(
//                                   color: Colors.grey[200],
//                                 ),
//                                 errorWidget: (context, url, error) => Container(
//                                   color: Colors.grey[200],
//                                   child: const Icon(Icons.error),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 24,
//                           top: 80,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ShaderMask(
//                                 shaderCallback: (bounds) {
//                                   return LinearGradient(
//                                     colors: [
//                                       Colors.white,
//                                       Colors.white.withOpacity(0.8),
//                                     ],
//                                   ).createShader(bounds);
//                                 },
//                                 child: Text(
//                                   banner['title']! as String,
//                                   style: const TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: 32,
//                                     fontWeight: FontWeight.w800,
//                                     height: 1.2,
//                                     shadows: [
//                                       Shadow(
//                                         blurRadius: 10,
//                                         color: Colors.black38,
//                                         offset: Offset(2, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.6,
//                                 child: Text(
//                                   banner['subtitle']! as String,
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white.withOpacity(0.9),
//                                     shadows: const [
//                                       Shadow(
//                                         blurRadius: 6,
//                                         color: Colors.black26,
//                                         offset: Offset(1, 1),
//                                       ),
//                                     ],
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               const SizedBox(height: 24),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   HapticFeedback.lightImpact();
//                                   onNavigate(context, RouteName.categories);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.white,
//                                   foregroundColor:
//                                       banner['colorStart'] as Color,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 28,
//                                     vertical: 16,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30),
//                                   ),
//                                   elevation: 8,
//                                   shadowColor: Colors.black26,
//                                 ),
//                                 child: const Text(
//                                   'Shop Now',
//                                   style: TextStyle(
//                                     fontFamily: 'Poppins',
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           right: 24,
//                           bottom: 40,
//                           child: Hero(
//                             tag: 'banner-image-${banner['image']}',
//                             child: Transform.rotate(
//                               angle: -0.1,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 20,
//                                       spreadRadius: 2,
//                                       offset: const Offset(5, 10),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(16),
//                                   child: CachedNetworkImage(
//                                     imageUrl: banner['image']! as String,
//                                     width: 180,
//                                     height: 180,
//                                     fit: BoxFit.cover,
//                                     placeholder: (context, url) => Container(
//                                       width: 180,
//                                       height: 180,
//                                       color: Colors.grey[200],
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         Container(
//                                       width: 180,
//                                       height: 180,
//                                       color: Colors.grey[200],
//                                       child: const Icon(Icons.error),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//           Positioned(
//             bottom: 20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 banners.length,
//                 (index) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   width: state.currentCarouselIndex == index ? 24 : 8,
//                   height: 4,
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     color: state.currentCarouselIndex == index
//                         ? Colors.white
//                         : Colors.white.withOpacity(0.5),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchBar(BuildContext context, TextTheme textTheme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(50),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 12,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search sneakers, brands...',
//           hintStyle: textTheme.bodyLarge?.copyWith(
//             color: Theme.of(context).hintColor,
//           ),
//           prefixIcon: Padding(
//             padding: const EdgeInsets.only(left: 16, right: 12),
//             child: Icon(
//               Icons.search,
//               color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
//               size: 24,
//             ),
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               Icons.clear,
//               color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
//               size: 24,
//             ),
//             onPressed: () {
//               // TODO: Implement clear search text logic
//             },
//           ),
//           filled: true,
//           fillColor: Colors.transparent,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(50),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 18),
//         ),
//         onTap: () {
//           HapticFeedback.lightImpact();
//         },
//       ),
//     );
//   }

//   Widget _buildCategorySection(
//       BuildContext context, HomeLoaded state, TextTheme textTheme) {
//     final categories = jsonData
//         .map((product) => {
//               'id': product['id'],
//               'title': product['category'],
//               'color': _getCategoryColor(product['category']),
//               'icon': _getCategoryIcon(product['category']),
//             })
//         .toSet()
//         .toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Explore Categories',
//               style: textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             TextButton(
//               onPressed: () => onNavigate(context, RouteName.categories),
//               child: Text(
//                 'See All',
//                 style: textTheme.bodyLarge?.copyWith(
//                   color: Theme.of(context).primaryColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 120,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               final category = categories[index];
//               final categoryId = category['id']?.toString();

//               return Padding(
//                 padding: EdgeInsets.only(
//                   right: index == categories.length - 1 ? 0 : 16,
//                 ),
//                 child: AnimatedCategoryButton(
//                   title: category['title']?.toString() ?? 'Unknown',
//                   color: category['color']?.toString() ?? '#000000',
//                   icon: category['icon']?.toString() ?? 'category',
//                   onTap: () {
//                     HapticFeedback.mediumImpact();
//                     onNavigate(
//                       context,
//                       RouteName.categories,
//                       categoryId: categoryId,
//                       extra: category,
//                     );
//                   },
//                   index: index,
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTopRankingSection(
//       BuildContext context, HomeLoaded state, TextTheme textTheme) {
//     final topRankingItems = jsonData
//         .map((product) => {
//               'imageUrl': (product['imageUrls'] as List<dynamic>?)?.first ?? '',
//               'title': product['name'] ?? '',
//               'price': product['price']?.toString() ?? '0',
//               'isFavorite': product['isFavorite'] ?? false,
//               'id': product['id']?.toString() ?? '',
//             })
//         .toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Top Picks',
//           style: textTheme.headlineSmall,
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 240,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: topRankingItems.length,
//             itemBuilder: (context, index) {
//               final item = topRankingItems[index];
//               return GestureDetector(
//                 onTap: () =>
//                     onNavigate(context, RouteName.itemDetails, extra: item),
//                 child: Container(
//                   width: 160,
//                   margin: EdgeInsets.only(
//                     right: index == topRankingItems.length - 1 ? 0 : 16,
//                   ),
//                   child: Stack(
//                     children: [
//                       Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.vertical(
//                                 top: Radius.circular(16),
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl: item['imageUrl']! as String,
//                                 height: 140,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) =>
//                                     Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Container(
//                                     height: 140,
//                                     width: double.infinity,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(12),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item['title']! as String,
//                                     style: textTheme.bodyLarge?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     '\$${item['price']}',
//                                     style: textTheme.bodyMedium?.copyWith(
//                                       color: Theme.of(context).primaryColor,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: CircleAvatar(
//                           radius: 16,
//                           backgroundColor: Colors.white.withOpacity(0.9),
//                           child: IconButton(
//                             icon: Icon(
//                               item['isFavorite'] == true
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               size: 16,
//                               color: item['isFavorite'] == true
//                                   ? Colors.red
//                                   : Colors.grey,
//                             ),
//                             onPressed: () {
//                               HapticFeedback.lightImpact();
//                               // TODO: Implement toggle favorite logic
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPromotionalDealsSection(
//       BuildContext context, HomeLoaded state, TextTheme textTheme) {
//     final promotionalItems = jsonData
//         .map((product) => {
//               'imageUrl': (product['imageUrls'] as List<dynamic>?)?.first ?? '',
//               'title': product['name'] ?? '',
//               'price': product['price']?.toString() ?? '0',
//               'originalPrice':
//                   (product['price'] * 1.2).toStringAsFixed(2) ?? '0',
//               'description': product['description'] ?? '',
//               'category': product['category'] ?? '',
//               'rating': product['rating']?.toDouble() ?? 0.0,
//               'ratingCount': product['reviewCount']?.toString() ?? '0',
//               'isDiscount': product['isDiscount'] ?? false,
//               'discountPercent': product['discountPercent']?.toString() ?? '0',
//               'isFavorite': product['isFavorite'] ?? false,
//               'id': product['id']?.toString() ?? '',
//             })
//         .toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Hot Deals',
//           style: textTheme.headlineSmall,
//         ),
//         const SizedBox(height: 16),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.7,
//           ),
//           itemCount: promotionalItems.length,
//           itemBuilder: (context, index) {
//             final item = promotionalItems[index];
//             return GestureDetector(
//               onTap: () =>
//                   onNavigate(context, RouteName.itemDetails, extra: item),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(16),
//                           ),
//                           child: Stack(
//                             children: [
//                               CachedNetworkImage(
//                                 imageUrl: item['imageUrl']! as String,
//                                 height: 140,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                                 placeholder: (context, url) =>
//                                     Shimmer.fromColors(
//                                   baseColor: Colors.grey[300]!,
//                                   highlightColor: Colors.grey[100]!,
//                                   child: Container(
//                                     height: 140,
//                                     width: double.infinity,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               if (item['isDiscount'] == true)
//                                 Positioned(
//                                   top: 8,
//                                   left: 8,
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Text(
//                                       '${item['discountPercent']}% OFF',
//                                       style: const TextStyle(
//                                         fontFamily: 'Poppins',
//                                         fontSize: 12,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item['title']! as String,
//                                 style: textTheme.bodyLarge?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Text(
//                                     '\$${item['price']}',
//                                     style: textTheme.bodyMedium?.copyWith(
//                                       color: Theme.of(context).primaryColor,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     '\$${item['originalPrice']}',
//                                     style: textTheme.bodySmall?.copyWith(
//                                       decoration: TextDecoration.lineThrough,
//                                       color: Theme.of(context).disabledColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     size: 16,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     item['rating'].toString(),
//                                     style: textTheme.bodySmall,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     '(${item['ratingCount']})',
//                                     style: textTheme.bodySmall?.copyWith(
//                                       color: Theme.of(context).hintColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: CircleAvatar(
//                         radius: 16,
//                         backgroundColor: Colors.white.withOpacity(0.9),
//                         child: IconButton(
//                           icon: Icon(
//                             item['isFavorite'] == true
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             size: 16,
//                             color: item['isFavorite'] == true
//                                 ? Colors.red
//                                 : Colors.grey,
//                           ),
//                           onPressed: () {
//                             HapticFeedback.lightImpact();
//                             // TODO: Implement toggle favorite logic
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildTopProductsSection(
//       BuildContext context, HomeLoaded state, TextTheme textTheme) {
//     final topProducts = jsonData
//         .map((product) => {
//               'imageUrl': (product['imageUrls'] as List<dynamic>?)?.first ?? '',
//               'title': product['name'] ?? '',
//               'price': product['price']?.toString() ?? '0',
//               'description': product['description'] ?? '',
//               'rating': product['rating']?.toString() ?? '0',
//               'isDiscount': product['isDiscount'] ?? false,
//               'discountPercent': product['discountPercent']?.toString() ?? '0',
//               'isFavorite': product['isFavorite'] ?? false,
//               'id': product['id']?.toString() ?? '',
//             })
//         .toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Best Sellers',
//               style: textTheme.headlineSmall,
//             ),
//             TextButton(
//               onPressed: () => onNavigate(context, RouteName.categories),
//               child: Text(
//                 'View More',
//                 style: textTheme.bodyLarge?.copyWith(
//                   color: Theme.of(context).primaryColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.7,
//           ),
//           itemCount: topProducts.length,
//           itemBuilder: (context, index) {
//             final item = topProducts[index];
//             return GestureDetector(
//               onTap: () =>
//                   onNavigate(context, RouteName.itemDetails, extra: item),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: Stack(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(16),
//                           ),
//                           child: CachedNetworkImage(
//                             imageUrl: item['imageUrl']! as String,
//                             height: 140,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => Shimmer.fromColors(
//                               baseColor: Colors.grey[300]!,
//                               highlightColor: Colors.grey[100]!,
//                               child: Container(
//                                 height: 140,
//                                 width: double.infinity,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item['title']! as String,
//                                 style: textTheme.bodyLarge?.copyWith(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 '\$${item['price']}',
//                                 style: textTheme.bodyMedium?.copyWith(
//                                   color: Theme.of(context).primaryColor,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.star,
//                                     size: 16,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     item['rating']! as String,
//                                     style: textTheme.bodySmall,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: CircleAvatar(
//                         radius: 16,
//                         backgroundColor: Colors.white.withOpacity(0.9),
//                         child: IconButton(
//                           icon: Icon(
//                             item['isFavorite'] == true
//                                 ? Icons.favorite
//                                 : Icons.favorite_border,
//                             size: 16,
//                             color: item['isFavorite'] == true
//                                 ? Colors.red
//                                 : Colors.grey,
//                           ),
//                           onPressed: () {
//                             HapticFeedback.lightImpact();
//                             // TODO: Implement toggle favorite logic
//                           },
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 8,
//                       right: 8,
//                       child: FloatingActionButton.small(
//                         heroTag: 'add-to-cart-${item['id']}',
//                         onPressed: () {
//                           HapticFeedback.lightImpact();
//                           // TODO: Implement add to cart logic
//                         },
//                         backgroundColor: Theme.of(context).primaryColor,
//                         child: const Icon(
//                           Icons.add_shopping_cart,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Map<String, Color> _getBannerGradientColors(String? category, int index) {
//     const gradientPresets = [
//       {'start': Color(0xFF0288D1), 'end': Color(0xFF26C6DA)},
//       {'start': Color(0xFF388E3C), 'end': Color(0xFF66BB6A)},
//       {'start': Color(0xFFFF5252), 'end': Color(0xFFFF8A80)},
//       {'start': Color(0xFF7B1FA2), 'end': Color(0xFFAB47BC)},
//       {'start': Color(0xFFFF6D00), 'end': Color(0xFFFFAB40)},
//     ];

//     switch (category?.toLowerCase()) {
//       case 'casual sneakers':
//         return gradientPresets[0];
//       case 'running sneakers':
//         return gradientPresets[1];
//       case 'athletic sneakers':
//         return gradientPresets[2];
//       case 'high-top sneakers':
//         return gradientPresets[3];
//       default:
//         return gradientPresets[index % gradientPresets.length];
//     }
//   }

//   String _getCategoryColor(String name) {
//     switch (name.toLowerCase()) {
//       case 'casual sneakers':
//         return '#FF5252';
//       case 'running sneakers':
//         return '#0288D1';
//       case 'athletic sneakers':
//         return '#388E3C';
//       case 'high-top sneakers':
//         return '#7B1FA2';
//       default:
//         return '#616161';
//     }
//   }

//   String _getCategoryIcon(String name) {
//     switch (name.toLowerCase()) {
//       case 'casual sneakers':
//         return 'casual_shoes';
//       case 'running sneakers':
//         return 'running_shoes';
//       case 'athletic sneakers':
//         return 'athletic_shoes';
//       case 'high-top sneakers':
//         return 'high_top_shoes';
//       default:
//         return 'category';
//     }
//   }
// }

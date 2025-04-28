import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delala/config/routes/route_name.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/home/presentation/bloc/home_bloc.dart';
import 'package:delala/features/home/presentation/bloc/home_event.dart';
import 'package:delala/features/home/presentation/bloc/home_state.dart';
import 'package:delala/features/home/presentation/screens/categories_list.dart';
import 'package:delala/features/home/presentation/screens/featured_product.dart';
import 'package:delala/features/home/presentation/screens/loading_shimmer.dart';
import 'package:delala/features/home/presentation/screens/login_dialog.dart';
import 'package:delala/features/home/presentation/screens/products_grid.dart';
import 'package:delala/features/home/presentation/screens/promo_banner.dart.dart';
import 'package:delala/features/home/presentation/screens/search_dialog.dart';
import 'package:delala/features/home/presentation/screens/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoggedIn = false;
  final List<String> bannerImages = [
    'https://images.unsplash.com/photo-1555529669-22405a1447f8',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
  ];

  @override
  void initState() {
    super.initState();
    print(
        'HomeScreen: Dispatching FetchCategoriesEvent, FetchProductsEvent, FetchUsersEvent');
    context.read<HomeBloc>().add(FetchCategoriesEvent());
    context.read<HomeBloc>().add(FetchProductsEvent());
    context.read<HomeBloc>().add(FetchUsersEvent());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    setState(() {
      _isLoggedIn = true;
    });
    print('HomeScreen: User logged in');
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
    });
    print('HomeScreen: User logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                print('HomeScreen: Navigating to cart');
                // Add cart navigation if needed
              },
              backgroundColor: Colors.blueAccent,
              child: const Icon(FeatherIcons.shoppingCart, color: Colors.white),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          print('HomeScreen: Refresh triggered');
          context.read<HomeBloc>().add(FetchCategoriesEvent());
          context.read<HomeBloc>().add(FetchProductsEvent());
          context.read<HomeBloc>().add(FetchUsersEvent());
          return Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  print('HomeScreen: State: $state');
                  if (state is HomeLoaded) {
                    print(
                      'HomeScreen: HomeLoaded - Products: ${state.products.length}, Categories: ${state.categories.length}',
                    );
                    for (var category in state.categories) {
                      print(
                        'HomeScreen: Category - id: ${category.id}, name: ${category.name}, imageUrl: ${category.imageUrl}',
                      );
                    }
                    for (var product in state.products) {
                      print(
                        'HomeScreen: Product - id: ${product.id}, name: ${product.name}, price: ${product.price}, createdAt: ${product.createdAt}',
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PromoBanner(),
                        SectionHeader(
                          title: 'Explore Categories',
                          showSeeAll: false,
                          onSeeAll: () {},
                        ),
                        CategoriesList(
                          categories: state.categories,
                          fadeAnimation: _fadeAnimation,
                        ),
                        SectionHeader(
                          title: 'Featured Product',
                          showSeeAll: true,
                          onSeeAll: () {},
                        ),
                        FeaturedProduct(
                          product: state.products.isNotEmpty
                              ? state.products[0]
                              : null,
                        ),
                        SectionHeader(
                          title: 'Best Sellers',
                          showSeeAll: false,
                          onSeeAll: () {},
                        ),
                        ProductsGrid(
                          products: state.products
                              .where((p) => p.price > 1000)
                              .toList(),
                          fadeAnimation: _fadeAnimation,
                        ),
                        SectionHeader(
                          title: 'New Arrivals',
                          showSeeAll: false,
                          onSeeAll: () {},
                        ),
                        ProductsGrid(
                          products: state.products
                              .where(
                                (p) =>
                                    p.createdAt != null &&
                                    DateTime.now()
                                            .difference(p.createdAt!)
                                            .inDays <
                                        30,
                              )
                              .toList(),
                          fadeAnimation: _fadeAnimation,
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  } else if (state is HomeLoading) {
                    print('HomeScreen: Rendering loading state');
                    return const LoadingShimmer();
                  } else if (state is HomeError) {
                    print(
                        'HomeScreen: Rendering error state - ${state.message}');
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.message,
                            style: GoogleFonts.poppins(color: Colors.redAccent),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              print('HomeScreen: Retry triggered');
                              context
                                  .read<HomeBloc>()
                                  .add(FetchCategoriesEvent());
                              context
                                  .read<HomeBloc>()
                                  .add(FetchProductsEvent());
                              context.read<HomeBloc>().add(FetchUsersEvent());
                            },
                            child: Text(
                              'Retry',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  print('HomeScreen: Rendering initial state');
                  return Center(
                    child: Text(
                      'Start exploring DeLala Shop',
                      style: GoogleFonts.poppins(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 350.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Text(
                'DeLala Shop',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 28,
                  shadows: [
                    Shadow(
                      blurRadius: 8.0,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        background: SizedBox(
          height: 350,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 350.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 1.0,
            ),
            items: bannerImages.map((url) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(color: Colors.grey[300]),
                    ),
                    errorWidget: (context, url, error) =>
                        Container(color: Colors.grey[200]),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Discover Amazing Deals!',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            print('HomeScreen: Shop Now button pressed');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Shop Now',
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(FeatherIcons.search, color: Colors.white, size: 28),
          onPressed: () => SearchDialog.show(context),
        ),
        IconButton(
          icon: const Icon(FeatherIcons.bell, color: Colors.white, size: 28),
          onPressed: () {
            print('HomeScreen: Notifications button pressed');
          },
        ),
        IconButton(
          icon: Icon(
            _isLoggedIn ? FeatherIcons.logOut : FeatherIcons.logIn,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            if (_isLoggedIn) {
              _handleLogout();
            } else {
              LoginDialog.show(context, onLogin: _handleLogin);
            }
          },
        ),
      ],
    );
  }
}

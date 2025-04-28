import 'package:delala/base_page.dart';
import 'package:delala/config/routes/route_name.dart';
import 'package:delala/features/auth/sign_in/presentation/sign_in.dart';
import 'package:delala/features/auth/sign_up/presentation/sign_up.dart';
import 'package:delala/features/cart/presentation/screen/cart_page.dart';
import 'package:delala/features/categories/data/model/category_model.dart';
import 'package:delala/features/categories/domain/entities/category.dart'
    show Category, CategoryEntity;
import 'package:delala/features/categories/presentation/screen/category_list_page.dart';
import 'package:delala/features/chat/presentation/chat_screen.dart';
import 'package:delala/features/home/presentation/screens/HomeScreen.dart';
import 'package:delala/features/home/presentation/screens/home_screen.dart';
import 'package:delala/features/products/presentation/screen/ProductDetailScreen.dart';
import 'package:delala/features/profile/presentation/profile_page.dart';
import 'package:delala/features/splash/presentation/screen/splash_page.dart';
import 'package:delala/features/todo/presentation/pages/todo_list_page.dart';
import 'package:delala/features/welcome_page.dart';
import 'package:delala/features/wishlist/presentation/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Placeholder widget for unimplemented routes
class PlaceholderPage extends StatelessWidget {
  final String routeName;

  const PlaceholderPage({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(routeName)),
      body: Center(child: Text('Page for $routeName not implemented yet')),
    );
  }
}

// Global navigator keys for root and shell navigation
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

// Defines the app's routing configuration using go_router
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteName.splash,
  routes: [
    // Initial Routes
    GoRoute(
      path: RouteName.splash,
      name: RouteName.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteName.welcome,
      name: RouteName.welcome,
      builder: (context, state) => const WelcomePage(),
    ),

    // Authentication Routes
    GoRoute(
      path: RouteName.login,
      name: RouteName.login,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: RouteName.signup,
      name: RouteName.signup,
      builder: (context, state) => const SignUpScreen(),
    ),

    // Todo Route
    GoRoute(
      path: RouteName.todo,
      name: RouteName.todo,
      builder: (context, state) => const TodoListPage(),
    ),

    // Shell Route for Bottom Navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BasePage(child: child),
      routes: [
        // Main Navigation Routes
        GoRoute(
          path: RouteName.home,
          name: RouteName.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteName.wishlist,
          name: RouteName.wishlist,
          builder: (context, state) => const WishlistPage(),
        ),
        GoRoute(
          path: RouteName.chat,
          name: RouteName.chat,
          builder: (context, state) => ChatScreen(),
        ),
        // GoRoute(
        //   path: RouteName.cart,
        //   name: RouteName.cart,
        //   builder: (context, state) => const CartPage(),
        // ),

        // Category Route
        GoRoute(
          path: '${RouteName.categoryDetail}/:categoryId',
          name: RouteName.categoryDetail,
          builder: (context, state) {
            final categoryId = state.pathParameters['categoryId']!;
            final CategoryEntity? category = state.extra as CategoryEntity?;
            return CategoriesListScreen();
          },
        ),

        // Placeholder Routes for Unimplemented Features
        GoRoute(
          path: RouteName.itemDetails,
          name: RouteName.itemDetails,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'Item Details'),
        ),
        GoRoute(
          path: RouteName.notifications,
          name: RouteName.notifications,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'Notifications'),
        ),
        GoRoute(
          path: RouteName.contact,
          name: RouteName.contact,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'Contact'),
        ),
        GoRoute(
          path: RouteName.about,
          name: RouteName.about,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'About'),
        ),
        GoRoute(
          path: RouteName.orders,
          name: RouteName.orders,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'Orders'),
        ),
        GoRoute(
          path: RouteName.logout,
          name: RouteName.logout,
          builder: (context, state) =>
              const PlaceholderPage(routeName: 'Logout'),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) {
    debugPrint('Route error: ${state.uri}, Error: ${state.error}');
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page not found: ${state.uri}',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteName.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0288D1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  },
);

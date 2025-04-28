// // lib/features/home/presentation/screens/home_screen.dart
// import 'package:delala/config/routes/route_name.dart';
// import 'package:delala/features/auth/sign_in/data/Service/auth_service.dart';
// import 'package:delala/features/home/data/repositories/home_repository_impl.dart';
// import 'package:delala/features/home/data/service/home_local_data_source.dart';
// import 'package:delala/features/home/domain/usecases/get_home_data.dart';
// import 'package:delala/features/home/presentation/bloc/home_bloc.dart';
// import 'package:delala/features/home/presentation/bloc/home_event.dart';
// import 'package:delala/features/home/presentation/bloc/home_state.dart';
// import 'package:delala/features/home/presentation/screens/home_content.dart'; // Import new file
// import 'package:delala/features/home/presentation/widget/appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   void _handleNavigation(
//     BuildContext context,
//     String routeName, {
//     Object? extra,
//     String? categoryId,
//   }) {
//     if (SignInService.isAuthenticated()) {
//       if (routeName == RouteName.categories && categoryId != null) {
//         context.pushNamed(
//           routeName,
//           pathParameters: {'categoryId': categoryId},
//           extra: extra,
//         );
//       } else {
//         context.pushNamed(routeName, extra: extra);
//       }
//     } else {
//       context.pushNamed(RouteName.login);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please log in to proceed')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

    
//     final homeLocalDataSource = HomeLocalDataSourceImpl();
//     final homeRepository = HomeRepositoryImpl(homeLocalDataSource);
//     final getHomeData = GetHomeData(homeRepository);

//     return BlocProvider(
//       create: (context) => HomeBloc(getHomeData)..add(const LoadHomeData()),
//       child: Scaffold(
//         appBar: const CustomAppBar(),
//         drawer: _buildDrawer(context),
//         body: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) {
//             if (state is HomeInitial) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is HomeLoaded) {
//               return HomeContent(
//                 state: state,
//                 onNavigate: _handleNavigation,
//               ); // Use new HomeContent widget
//             }
//             return const Center(child: Text('Failed to load home data'));
//           },
//         ),
//       ),
//     );
//   }

//   Drawer _buildDrawer(BuildContext context) {
//     return Drawer(
//       width: MediaQuery.of(context).size.width * 0.75,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 10,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Color(0xFF0288D1),
//                     Color(0xFF03A9F4),
//                   ],
//                 ),
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey.shade300, width: 1),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           if (!SignInService.isAuthenticated()) {
//                             _handleNavigation(context, RouteName.login);
//                           }
//                         },
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.white.withOpacity(0.3),
//                               child: const Icon(
//                                 Icons.person,
//                                 size: 35,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 15),
//                             const Text(
//                               'Sign in | Register',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 fontFamily: 'Poppins',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.close,
//                           color: Colors.white,
//                           size: 30,
//                         ),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     SignInService.isAuthenticated()
//                         ? 'Welcome Back!'
//                         : 'Join us today!',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.home,
//               title: 'Home',
//               routeName: RouteName.home,
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.category,
//               title: 'Categories',
//               routeName: RouteName.categories,
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.favorite,
//               title: 'Wishlist',
//               routeName: RouteName.wishlist,
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.shopping_cart,
//               title: 'My Orders',
//               routeName: '',
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.person,
//               title: 'My Profile',
//               routeName: RouteName.profile,
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.headset_mic,
//               title: 'Contact Us',
//               routeName: '',
//             ),
//             _buildDrawerItem(
//               context: context,
//               icon: Icons.info,
//               title: 'About',
//               routeName: '',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDrawerItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String routeName,
//   }) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade200,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFF0288D1).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: const Color(0xFF0288D1), size: 28),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         onTap: () {
//           Navigator.of(context).pop();
//           if (routeName.isNotEmpty) {
//             _handleNavigation(context, routeName);
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Route not implemented yet')),
//             );
//           }
//         },
//         hoverColor: Colors.grey.shade100,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       ),
//     );
//   }
// }

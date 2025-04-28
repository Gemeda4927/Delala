import 'package:delala/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.child});
  final Widget child;
  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int currentIndex = 0;

  void changeTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
            
        
          context.goNamed(  convertIndexIntoRouteName(index));
        },
        currentIndex: (){
          String currentRoute = GoRouterState.of(context).uri.toString();
          return convertRouteNameIntoIndex(currentRoute);
        }(),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wish'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int convertRouteNameIntoIndex(String routeName) {
    if (routeName.startsWith(RouteName.home)) {
      return 0;
    } else if (routeName.startsWith(RouteName.wishlist)) {
      return 1;
    } else if (routeName.startsWith(RouteName.chat)) {
      return 2;
    } else if (routeName.startsWith(RouteName.profile)) {
      return 3;
    }else {
      return 0;
    }
  }

  String convertIndexIntoRouteName(int index) {
    switch (index) {
      case 0:
        return RouteName.home;
      case 1:
        return RouteName.wishlist;
      case 2:
        return RouteName.chat;
      case 3:
        return RouteName.profile;
      default:
        return RouteName.home;
    }
  }
}

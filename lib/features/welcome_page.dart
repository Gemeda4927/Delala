import 'package:delala/config/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC), // Softer light gray
              Color(0xFFFFFFFF), // Pure white
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with soft shadow
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  '../../assets/images/image.png',
                  width: 110, // Slightly optimized size
                  height: 110,
                ),
              ),
              const SizedBox(height: 22),

              // App Title
              const Text(
                'DELALA',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700, // Modern bold
                  color: Colors.black87,
                  letterSpacing: 1.2, // Slight spacing
                  shadows: [
                    Shadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tagline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  'Find great deals, chat with sellers, and connect instantly!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    height: 1.6, // Better line spacing
                  ),
                ),
              ),
              const SizedBox(height: 45),

              // Get Started Button
              ElevatedButton(
                onPressed: () {
                  context.goNamed(RouteName.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2979FF), // Clean blue
                  padding: const EdgeInsets.symmetric(
                    horizontal: 38,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4, // Smooth shadow
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

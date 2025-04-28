import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;
  final bool isDarkMode;

  const AppBarButton({
    required this.icon,
    this.color,
    required this.onPressed,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.black54, Colors.black87]
                : [Colors.white, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon,
            color: color ?? (isDarkMode ? Colors.white : Colors.black)),
      ),
      onPressed: onPressed,
    );
  }
}
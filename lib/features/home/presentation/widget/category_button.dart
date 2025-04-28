// lib/features/home/presentation/widget/category_button.dart
import 'package:flutter/material.dart';

Widget buildCategoryButton(
  String title,
  String color,
  String icon,
  VoidCallback onTap,
) {
  Color buttonColor;
  try {
    String colorString = color.trim();
    if (!colorString.startsWith('#')) {
      colorString = '#$colorString';
    }
    if (colorString.length == 7) {
      buttonColor = Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } else {
      buttonColor = Colors.grey;
    }
  } catch (e) {
    buttonColor = Colors.grey;
    debugPrint('Error parsing color in buildCategoryButton: $e');
  }

  IconData _getIconData(String? iconName) {
    switch (iconName?.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'directions_car':
        return Icons.directions_car;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'chair':
        return Icons.chair;
      case 'kitchen':
        return Icons.kitchen;
      default:
        return Icons.category;
    }
  }

  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: buttonColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            _getIconData(icon),
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

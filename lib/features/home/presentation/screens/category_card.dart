import 'package:cached_network_image/cached_network_image.dart';
import 'package:delala/features/categories/domain/entities/category.dart';
import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.cyanAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.white.withOpacity(0.2),
              backgroundImage: category.imageUrl != null
                  ? CachedNetworkImageProvider(category.imageUrl!)
                  : null,
              child: category.imageUrl == null
                  ? const Icon(FeatherIcons.grid, color: Colors.white, size: 32)
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              category.name != null && category.name!.length > 15
                  ? '${category.name!.substring(0, 12)}...'
                  : category.name ?? 'Unknown',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

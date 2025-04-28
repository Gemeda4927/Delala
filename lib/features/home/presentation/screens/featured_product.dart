import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/home/presentation/screens/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedProduct extends StatelessWidget {
  final ProductEntity? product;

  const FeaturedProduct({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    print('FeaturedProduct: Rendering Product: ${product?.name ?? 'None'}');
    if (product == null) {
      return Center(
        child: Text(
          'No Featured Product',
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ProductCard(
        product: product!,
        isFeatured: true,
      ),
    );
  }
}

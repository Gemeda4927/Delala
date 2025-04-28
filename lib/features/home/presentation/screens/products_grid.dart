import 'package:delala/features/home/domain/entities/home_data.dart';
import 'package:delala/features/home/presentation/screens/product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final Animation<double> fadeAnimation;

  const ProductsGrid({
    super.key,
    required this.products,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    print('ProductsGrid: Rendering Products: ${products.length}');
    return products.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return AnimatedBuilder(
                animation: fadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, 30 - 30 * fadeAnimation.value),
                      child: ProductCard(
                        product: product,
                        isBestSeller: product.price > 1000,
                      ),
                    ),
                  );
                },
              );
            },
          )
        : Center(
            child: Text(
              'No Products Available',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          );
  }
}

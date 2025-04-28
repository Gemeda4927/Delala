import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/models/products.dart';

class ImageGallery extends StatelessWidget {
  final Product product;
  final PageController imageController;
  final int currentImageIndex;
  final ValueChanged<int> onPageChanged;

  const ImageGallery({
    required this.product,
    required this.imageController,
    required this.currentImageIndex,
    required this.onPageChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          PageView.builder(
            controller: imageController,
            itemCount: product.imageUrl.isNotEmpty ? product.imageUrl.length : 1,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Hero(
                  tag: product.id,
                  child: product.imageUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrl[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Iconsax.image,
                                size: 100, color: Colors.grey),
                          ),
                        )
                      : const Center(
                          child: Icon(Iconsax.image,
                              size: 100, color: Colors.grey),
                        ),
                ),
              );
            },
          ),
          if (product.imageUrl.length > 1)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  product.imageUrl.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: currentImageIndex == index ? 30 : 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.primaryColor ?? Colors.blue,
                          (AppConstants.primaryColor ?? Colors.blue)
                              .withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
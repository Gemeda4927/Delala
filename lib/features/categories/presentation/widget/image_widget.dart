import 'package:cached_network_image/cached_network_image.dart';
import 'package:delala/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildImageWidget({String? imageUrl, required IconData icon, required BoxFit fit}) {
  return CachedNetworkImage(
    imageUrl: imageUrl ?? '',
    fit: BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.white),
    ),
    errorWidget: (context, url, error) => Container(
      color: Colors.grey[200],
      child: Icon(icon, size: 50, color: AppConstants.secondaryTextColor),
    ),
  );
}

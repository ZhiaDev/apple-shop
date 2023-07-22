import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/colors.dart';

// ignore: must_be_immutable
class CachedImage extends StatelessWidget {
  CachedImage({super.key, required this.imageUrl});
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'خطا در بارگذاری تصاویر!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            color: Kcolor.grey.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Text(
              'در حال بارگذاری تصاویر...',
              style: TextStyle(color: Kcolor.black, fontSize: 12),
            ),
          ),
        ),
        imageUrl: imageUrl ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Empty_set_symbol.svg/640px-Empty_set_symbol.svg.png',
      ),
    );
  }
}

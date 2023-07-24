import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/colors.dart';

// ignore: must_be_immutable
class CachedImage extends StatelessWidget {
  CachedImage({super.key, required this.imageUrl, required this.radius});
  String? imageUrl;
  double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'خطا!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
        ),
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            color: Kcolor.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        imageUrl: imageUrl ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Empty_set_symbol.svg/640px-Empty_set_symbol.svg.png',
      ),
    );
  }
}

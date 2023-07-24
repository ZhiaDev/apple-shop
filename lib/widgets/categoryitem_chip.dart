import 'package:apple_shop/widgets/cached_image.dart';
import 'package:flutter/material.dart';

import '/data/model/category.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;
  const CategoryItemChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    String categoryColor = 'FF${category.color}';
    int hexColor = int.parse(categoryColor, radix: 16);

    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          Container(
              height: 56,
              width: 56,
              decoration: ShapeDecoration(
                color: Color(hexColor),
                shadows: [
                  BoxShadow(
                    color: Color(hexColor),
                    blurRadius: 42,
                    spreadRadius: -10,
                    offset: const Offset(0, 15),
                  )
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CachedImage(imageUrl: category.icon, radius: 0),
              )),
          const SizedBox(height: 6),
          Text(
            category.title ?? 'دسته محصول',
            style: const TextStyle(fontSize: 12, fontFamily: 'SB'),
          )
        ],
      ),
    );
  }
}

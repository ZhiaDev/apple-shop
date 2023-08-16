import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/model/category.dart';
import '/widgets/cached_image.dart';
import '/pages/productlist_page.dart';
import '/utility/string_extension.dart';
import '/bloc/category_product/category_product_bloc.dart';

class CategoryItemChip extends StatelessWidget {
  final Category category;
  const CategoryItemChip({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryProductBloc(),
            child: ProductListPage(category: category),
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 18),
        child: Column(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: ShapeDecoration(
                color: category.color.parseToColor(),
                shadows: [
                  BoxShadow(
                    color: category.color.parseToColor(),
                    blurRadius: 42,
                    spreadRadius: -12,
                    offset: const Offset(0, 12),
                  )
                ],
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CachedImage(imageUrl: category.icon, radius: 0),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.title ?? 'دسته محصول',
              style: const TextStyle(fontSize: 12, fontFamily: 'SB'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:apple_shop/widgets/product_item.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Kcolor.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 42,
                margin: const EdgeInsets.fromLTRB(42, 4, 42, 32),
                decoration: BoxDecoration(
                  color: Kcolor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'پرفروش ترین ها',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SB',
                        color: Kcolor.primery,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: Ksvg(
                          path: Assets.icons.filter,
                          size: 26,
                          color: Kcolor.black,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Ksvg(
                          path: Assets.icons.arrowRight,
                          size: 26,
                          color: Kcolor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              sliver: SliverGrid.builder(
                // delegate: SliverChildBuilderDelegate(
                //   (context, index) => const ProductItem()
                // ),
                itemBuilder: (BuildContext context, int index) {
                  return const ProductItem();
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2 / 2.7,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

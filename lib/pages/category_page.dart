import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

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
                    const Spacer(),
                    const Text(
                      'دسته بندی',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SB',
                        color: Kcolor.primery,
                      ),
                    ),
                    const Spacer(),
                    Positioned(
                      left: 10,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Ksvg(
                          path: Assets.icons.apple,
                          size: 28,
                          color: Kcolor.primery,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/categoryitem_chip.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_item.dart';
import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Ksvg(
                      path: Assets.icons.search,
                      size: 24,
                      color: Kcolor.black,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'جستجوی محصولات',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'SB',
                        color: Kcolor.grey,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Ksvg(
                        path: Assets.icons.apple,
                        size: 28,
                        color: Kcolor.primery,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: BannerSlider()),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(32, 32, 32, 20),
                child: Row(
                  children: [
                    Text(
                      'دسته بندی',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SB',
                        color: Kcolor.grey,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.only(left: 32, right: 14),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return const CategoryItemChip();
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 32, left: 32, bottom: 20),
                child: Row(
                  children: [
                    const Text(
                      'پرفروش ترین‌ها',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SB',
                        color: Kcolor.grey,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Text(
                          'مشاهده همه',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'SB',
                            color: Kcolor.primery,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Ksvg(
                          path: Assets.icons.arrowLeft,
                          size: 24,
                          color: Kcolor.primery,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260,
                // color: Colors.amber,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 32, right: 14),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: Column(children: [ProductItem()]),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                child: Row(
                  children: [
                    const Text(
                      'پربازدید ترین‌ها',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SB',
                        color: Kcolor.grey,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Text(
                          'مشاهده همه',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'SB',
                            color: Kcolor.primery,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Ksvg(
                          path: Assets.icons.arrowLeft,
                          size: 24,
                          color: Kcolor.primery,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 32, right: 14),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: Column(
                        children: [ProductItem()],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
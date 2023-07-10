import 'package:apple_shop/constants/colors.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'آیفون',
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
                          path: Assets.icons.apple,
                          size: 26,
                          color: Kcolor.primery,
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 18),
                child: Text(
                  'آیفون SE 2022',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'SB',
                    color: Kcolor.black,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 284,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Kcolor.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: double.infinity,
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  Assets.images.iphone.path,
                                  // height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 70,
                                width: 70,
                                padding: const EdgeInsets.all(6.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Kcolor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Kcolor.grey, width: 1),
                                ),
                                child: Image.asset(
                                  Assets.images.iphone.path,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Ksvg(
                            path: Assets.icons.favorite,
                            size: 22,
                            color: Kcolor.primery,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              const Text(
                                '۴.۶',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SM',
                                  color: Kcolor.black,
                                ),
                              ),
                              Ksvg(
                                path: Assets.icons.star,
                                size: 22,
                                color: Kcolor.yellow,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

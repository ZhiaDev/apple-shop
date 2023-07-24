import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var loadingController =
        PageController(viewportFraction: 0.86, initialPage: 1);

    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Container(
              height: 42,
              margin: const EdgeInsets.fromLTRB(42, 4, 42, 32),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: SizedBox(
              height: 170,
              child: PageView.builder(
                itemCount: 3,
                controller: loadingController,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Kcolor.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 12),
              child: Row(
                children: [
                  Container(
                    height: 14,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.only(left: 32, right: 14),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Column(
                      children: [
                        Container(
                          height: 56,
                          width: 56,
                          decoration: ShapeDecoration(
                            color: Kcolor.white,
                            shadows: const [
                              BoxShadow(
                                color: Kcolor.white,
                                blurRadius: 42,
                                spreadRadius: -10,
                                offset: Offset(0, 15),
                              )
                            ],
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(48),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 8,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 12),
              child: Row(
                children: [
                  Container(
                    height: 14,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 14,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: const BoxDecoration(
                        color: Kcolor.white, shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 32, right: 14),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Column(
                      children: [
                        Container(
                          width: 156,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
          // SearchBox
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Container(
              height: 42,
              margin: const EdgeInsets.fromLTRB(42, 8, 42, 0),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          // Banner Slider
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.only(top: 28),
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
          ),

          // Title
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 28, 32, 0),
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

          // Category list
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Container(
              height: 110,
              margin: const EdgeInsets.only(top: 8.0),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
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

          // Title
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
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
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
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
          ),
        ],
      ),
    );
  }
}

class CategoryShimmerLoading extends StatelessWidget {
  const CategoryShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
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
          // Shimmer.fromColors(
          //   baseColor: Kcolor.white,
          //   highlightColor: Kcolor.grey2,
          //   child: SliverPadding(
          //     padding: const EdgeInsets.symmetric(horizontal: 32),
          //     sliver: SliverGrid(
          //       delegate: SliverChildBuilderDelegate(
          //         childCount: 8,
          //         (context, index) => Container(
          //           decoration: BoxDecoration(
          //             color: Kcolor.white,
          //             borderRadius: BorderRadius.circular(15),
          //           ),
          //         ),
          //       ),
          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 20,
          //         crossAxisSpacing: 20,
          //       ),
          //     ),
          //   ),
          // ),
          Shimmer.fromColors(
            baseColor: Kcolor.white,
            highlightColor: Kcolor.grey2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(15),
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

class DetailPageShimmerLoading extends StatelessWidget {
  const DetailPageShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // SearchBox
                Shimmer.fromColors(
                  baseColor: Kcolor.white,
                  highlightColor: Kcolor.grey2,
                  child: Container(
                    height: 42,
                    margin: const EdgeInsets.fromLTRB(42, 8, 42, 0),
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                // Title
                Shimmer.fromColors(
                  baseColor: Kcolor.white,
                  highlightColor: Kcolor.grey2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(64, 28, 64, 0),
                    child: Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: Kcolor.white,
                        borderRadius: BorderRadius.circular(365),
                      ),
                    ),
                  ),
                ),

                // Gallery
                Shimmer.fromColors(
                  baseColor: Kcolor.white,
                  highlightColor: Kcolor.grey2,
                  child: Container(
                    height: 284,
                    margin: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                    decoration: BoxDecoration(
                      color: Kcolor.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 80,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Kcolor.white, width: 1),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Shimmer.fromColors(
                          baseColor: const Color(0xFFF7F7F7),
                          highlightColor: Kcolor.grey2,
                          child: Container(
                            width: 140,
                            height: 47,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          child: Shimmer.fromColors(
                            baseColor: Kcolor.white,
                            highlightColor: Kcolor.grey2,
                            child: Container(
                              height: 53,
                              width: 160,
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Shimmer.fromColors(
                          baseColor: const Color(0xFFF7F7F7),
                          highlightColor: Kcolor.grey2,
                          child: Container(
                            width: 140,
                            height: 47,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          child: Shimmer.fromColors(
                            baseColor: Kcolor.white,
                            highlightColor: Kcolor.grey2,
                            child: Container(
                              height: 53,
                              width: 160,
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

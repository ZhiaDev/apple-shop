import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/model/product.dart';
import '/data/model/category.dart';
import '/data/model/banner.dart';
import '/bloc/home/home_bloc.dart';
import '/bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/categoryitem_chip.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_item.dart';
import '../widgets/shimmer_loading.dart';
import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetwInitializedData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.background,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(microseconds: 500), () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(HomeGetwInitializedData());
                });
              },
              color: Kcolor.primery,
              child: CustomScrollView(
                slivers: [
                  // Banner
                  if (state is HomeLoadingState) ...{
                    const HomeShimmerLoading()
                  } else ...{
                    // Search Box
                    const _GetSearchBox(),
                    if (state is HomeRequestSuccessState) ...[
                      state.bannerList.fold(
                        (exceptionMessage) {
                          return SliverToBoxAdapter(
                              child: Column(
                            children: [
                              Icon(
                                Icons
                                    .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                color: Theme.of(context).colorScheme.error,
                                size: 32,
                              ),
                              const Text('خطا در بارگذاری محتوا'),
                            ],
                          ));
                        },
                        (bannerList) {
                          return _GetBanners(campaignBanner: bannerList);
                        },
                      )
                    ],

                    // Category list
                    if (state is HomeRequestSuccessState) ...[
                      state.categoryList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (categoryList) {
                          return const _GetCategoryTitle();
                        },
                      )
                    ],
                    if (state is HomeRequestSuccessState) ...[
                      state.categoryList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (categoryList) {
                          return _GetCategoryList(categoryList: categoryList);
                        },
                      )
                    ],
                    const SliverToBoxAdapter(child: SizedBox(height: 12)),

                    // Best Seller Products
                    if (state is HomeRequestSuccessState) ...[
                      state.bestSellerProductList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (productList) {
                          return const _GetBestSellerTitle();
                        },
                      )
                    ],
                    if (state is HomeRequestSuccessState) ...[
                      state.bestSellerProductList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (productList) {
                          return _GetBestSellerList(productList: productList);
                        },
                      )
                    ],

                    // Hotest Products
                    if (state is HomeRequestSuccessState) ...[
                      state.hotestProductList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (productList) {
                          return const _GetMostViewTitle();
                        },
                      )
                    ],
                    if (state is HomeRequestSuccessState) ...[
                      state.hotestProductList.fold(
                        (exceptionMessage) {
                          return const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                        },
                        (productList) {
                          return _GetMostViewList(productList: productList);
                        },
                      )
                    ],
                  },
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GetMostViewList extends StatelessWidget {
  final List<Product> productList;
  const _GetMostViewList({required this.productList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 260,
        child: ListView.builder(
          itemCount: productList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 32, right: 14),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Column(
                children: [ProductItem(product: productList[index])],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GetMostViewTitle extends StatelessWidget {
  const _GetMostViewTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
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
    );
  }
}

class _GetBestSellerList extends StatelessWidget {
  final List<Product> productList;
  const _GetBestSellerList({required this.productList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 260,
        child: ListView.builder(
          itemCount: productList.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 32, right: 14),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Column(
                children: [ProductItem(product: productList[index])],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GetBestSellerTitle extends StatelessWidget {
  const _GetBestSellerTitle();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
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
    );
  }
}

class _GetCategoryList extends StatelessWidget {
  final List<Category> categoryList;

  const _GetCategoryList({required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemCount: categoryList.length,
          padding: const EdgeInsets.only(left: 32, right: 14),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CategoryItemChip(category: categoryList[index]);
          },
        ),
      ),
    );
  }
}

class _GetCategoryTitle extends StatelessWidget {
  const _GetCategoryTitle();

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(32, 32, 32, 12),
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
    );
  }
}

class _GetBanners extends StatelessWidget {
  final List<CampaignBanner> campaignBanner;
  const _GetBanners({required this.campaignBanner});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: BannerSlider(bannerList: campaignBanner));
  }
}

class _GetSearchBox extends StatelessWidget {
  const _GetSearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
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
    );
  }
}

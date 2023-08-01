import 'package:apple_shop/pages/productlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_product/category_product_bloc.dart';
import '../utility/svg.dart';
import '../gen/assets.gen.dart';
import '../constants/colors.dart';
import '../widgets/shimmer_loading.dart';
import '/data/model/category.dart';
import '/widgets/cached_image.dart';
import '/bloc/category/category_bloc.dart';
import '/bloc/category/category_event.dart';
import '/bloc/category/category_state.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Kcolor.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(microseconds: 500), () {
              BlocProvider.of<CategoryBloc>(context).add(CategoryRequestList());
            });
          },
          color: Kcolor.primery,
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  if (state is CategoryLoadingState) ...{
                    const CategoryShimmerLoading()
                  } else ...{
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
                              'دسته بندی',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'SB',
                                color: Kcolor.primery,
                              ),
                            ),
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
                    if (state is CategoryResponseState) ...[
                      state.response.fold(
                        (l) => SliverToBoxAdapter(
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
                        )),
                        (r) => CategoryGridList(list: r),
                      )
                    ],
                    const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoryGridList extends StatelessWidget {
  final List<Category>? list;
  // final Category category;
  const CategoryGridList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          childCount: list?.length ?? 0,
          (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CategoryProductBloc(),
                  child: ProductListPage(category: list![index]),
                ),
              ));
            },
            child: CachedImage(
              imageUrl: list?[index].thumbnail,
              radius: 15,
            ),
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}

import 'package:apple_shop/bloc/category_product/category_product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/category_product/category_product_bloc.dart';
import '../bloc/category_product/category_product_state.dart';
import '/data/model/category.dart';
import '/widgets/product_item.dart';
import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProductListPage extends StatefulWidget {
  final Category category;
  const ProductListPage({super.key, required this.category});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    BlocProvider.of<CategoryProductBloc>(context).add(
      CategoryProductInitializeEvent(widget.category.id!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
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
                        Text(
                          widget.category.title ?? 'لیست محصولات',
                          style: const TextStyle(
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
                if (state is CategoryProductLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                },
                if (state is CategoryProductResponseSuccessState) ...{
                  state.productListByCategory.fold(
                    (l) => SliverToBoxAdapter(
                      child: Text(l),
                    ),
                    (productList) => SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      sliver: SliverGrid.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(product: productList[index]);
                        },
                        itemCount: productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 2 / 2.7,
                        ),
                      ),
                    ),
                  )
                },
                const SliverPadding(padding: EdgeInsets.only(bottom: 42))
              ],
            ),
          ),
        );
      },
    );
  }
}

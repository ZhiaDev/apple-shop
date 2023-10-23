import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_state.dart';
import '../bloc/comment/comment_bloc.dart';
import '../widgets/shimmer_loading.dart';
import '../data/model/product.dart';
import '../data/model/variant.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';
import '/bloc/checkout/checkout_bloc.dart';
import '/bloc/checkout/checkout_event.dart';
import '/bloc/product/product_event.dart';
import '/utility/string_extension.dart';
import '/data/model/product_image.dart';
import '/data/model/product_variant.dart';
import '/data/model/properties.dart';
import '/data/model/variant_type.dart';
import '/widgets/cached_image.dart';
import '/constants/colors.dart';
import '/di/di.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = ProductBloc();
        bloc.add(ProductInitializeEvent(
          productId: widget.product.id!,
          categoryId: widget.product.category!,
        ));
        return bloc;
      },

      // Scaffold
      child: ProductDetailContent(parentWidget: widget),
    );
  }
}

class ProductDetailContent extends StatelessWidget {
  const ProductDetailContent({
    super.key,
    required this.parentWidget,
  });

  final ProductDetailPage parentWidget;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Kcolor.background,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SafeArea(
                child: RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(const Duration(microseconds: 500),
                        () {
                      BlocProvider.of<ProductBloc>(context).add(
                        ProductInitializeEvent(
                          productId: parentWidget.product.id!,
                          categoryId: parentWidget.product.category!,
                        ),
                      );
                    });
                  },
                  child: CustomScrollView(
                    slivers: [
                      // Circular Progress Indicator
                      if (state is ProductLoadingState) ...[
                        const DetailPageShimmerLoading()
                      ],

                      // AppBar
                      if (state is ProductResponseState) ...[
                        SliverToBoxAdapter(
                          child: Container(
                            height: 42,
                            margin: const EdgeInsets.fromLTRB(42, 8, 42, 0),
                            decoration: BoxDecoration(
                              color: Kcolor.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                state.productCategory.fold(
                                  (l) => const Text(
                                    'اطلاعات محصول',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: Kcolor.primery,
                                    ),
                                  ),
                                  (r) => Text(
                                    r.title ?? 'اطلاعات محصول',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SB',
                                      color: Kcolor.primery,
                                    ),
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

                        // Product name title
                        state.productImages.fold(
                          (error) => SliverToBoxAdapter(
                              child: Column(
                            children: [
                              const SizedBox(height: 32),
                              Icon(
                                Icons
                                    .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                color: Theme.of(context).colorScheme.error,
                                size: 32,
                              ),
                              const Text('خطا در بارگذاری محتوا'),
                            ],
                          )),
                          (right) {
                            return SliverToBoxAdapter(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(42, 28, 42, 0),
                                child: Text(
                                  parentWidget.product.name!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'SB',
                                    color: Kcolor.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Gallery Card
                        state.productImages.fold(
                          (error) => const SliverToBoxAdapter(
                            child: SizedBox(),
                          ),
                          (productImages) {
                            return GalleryImage(
                              images: productImages,
                              defaultProductThumbnail:
                                  parentWidget.product.thumbnail!,
                            );
                          },
                        ),

                        // Product Variants
                        state.productVariant.fold(
                          (error) => const SliverToBoxAdapter(
                            child: SizedBox(),
                          ),
                          (productVariantList) {
                            return VariantContainerGenerator(
                              productVariantList: productVariantList,
                            );
                          },
                        ),

                        // Product Technical Detail
                        state.productProperties.fold(
                          (error) => const SliverToBoxAdapter(
                            child: SizedBox(),
                          ),
                          (r) {
                            return ProductTechnicalDetail(properties: r);
                          },
                        ),

                        // Prodeuct Description
                        state.productProperties.fold(
                          (error) => const SliverToBoxAdapter(
                            child: SizedBox(),
                          ),
                          (right) {
                            return ProdeuctDescription(
                              productDescription:
                                  parentWidget.product.description ??
                                      'بدون توضیحات',
                            );
                          },
                        ),

                        // User Comments
                        state.productProperties.fold(
                          (error) => const SliverToBoxAdapter(
                            child: SizedBox(),
                          ),
                          (right) {
                            return SliverToBoxAdapter(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    useSafeArea: true,
                                    showDragHandle: true,
                                    context: context,
                                    builder: (context) {
                                      return BlocProvider(
                                        create: (context) {
                                          final bloc =
                                              CommentBloc(locator.get());
                                          bloc.add(CommentInitializeEvent(
                                              productId:
                                                  parentWidget.product.id!));
                                          return bloc;
                                        },
                                        child: CommentBottomSheet(
                                          productId: parentWidget.product.id!,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 46,
                                  margin:
                                      const EdgeInsets.fromLTRB(32, 20, 32, 0),
                                  decoration: BoxDecoration(
                                    color: Kcolor.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: Kcolor.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'نظرات کاربران:',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SM',
                                            color: Kcolor.black,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        BlocProvider(
                                          create: (context) {
                                            final bloc =
                                                CommentBloc(locator.get());
                                            bloc.add(CommentInitializeEvent(
                                                productId:
                                                    parentWidget.product.id!));
                                            return bloc;
                                          },
                                          child: BlocBuilder<CommentBloc,
                                              CommentState>(
                                            builder: (context, state) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (state
                                                      is CommentResponse) ...[
                                                    state.response.fold(
                                                      (l) => const SizedBox
                                                          .shrink(),
                                                      (r) => Container(
                                                        height: 26,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Kcolor.primery
                                                              .withOpacity(0.8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            '${(r.length < 100) ? r.length : '99+'}',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Kcolor.white,
                                                              fontFamily: 'SB',
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        // Stack(
                                        //   clipBehavior: Clip.none,
                                        //   children: [
                                        //     Container(
                                        //       width: 26,
                                        //       height: 26,
                                        //       decoration: BoxDecoration(
                                        //         color: Kcolor.secondary,
                                        //         borderRadius:
                                        //             BorderRadius.circular(8),
                                        //         border: Border.all(
                                        //           width: 1,
                                        //           color: Kcolor.white,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Positioned(
                                        //       right: 15,
                                        //       child: Container(
                                        //         width: 26,
                                        //         height: 26,
                                        //         decoration: BoxDecoration(
                                        //           color: Kcolor.tertiary,
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           border: Border.all(
                                        //             width: 1,
                                        //             color: Kcolor.white,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Positioned(
                                        //       right: 30,
                                        //       child: Container(
                                        //         width: 26,
                                        //         height: 26,
                                        //         decoration: BoxDecoration(
                                        //           color: Kcolor.primery,
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           border: Border.all(
                                        //             width: 1,
                                        //             color: Kcolor.white,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Positioned(
                                        //       right: 45,
                                        //       child: Container(
                                        //         height: 26,
                                        //         width: 26,
                                        //         decoration: BoxDecoration(
                                        //           color: Kcolor.yellow,
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           border: Border.all(
                                        //             width: 1,
                                        //             color: Kcolor.white,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Positioned(
                                        //       right: 60,
                                        //       child: Container(
                                        //         height: 26,
                                        //         width: 26,
                                        //         decoration: BoxDecoration(
                                        //           color: Kcolor.grey,
                                        //           borderRadius:
                                        //               BorderRadius.circular(8),
                                        //           border: Border.all(
                                        //             width: 1,
                                        //             color: Kcolor.white,
                                        //           ),
                                        //         ),
                                        //         child: const Center(
                                        //           child: Text(
                                        //             '99+',
                                        //             style: TextStyle(
                                        //               color: Kcolor.white,
                                        //               fontFamily: 'SB',
                                        //               fontSize: 10,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        const Spacer(),
                                        const Text(
                                          'مشاهده',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'SM',
                                            color: Kcolor.primery,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Ksvg(
                                          size: 20,
                                          color: Kcolor.primery,
                                          path: Assets.icons.arrowLeft,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Empty Space
                        const SliverPadding(
                            padding: EdgeInsets.only(bottom: 132)),
                      ],
                    ],
                  ),
                ),
              ),
              if (state is ProductResponseState) ...[
                Container(
                  height: 115,
                  decoration: const BoxDecoration(
                    color: Kcolor.background,
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
                          AddToCheckoutButton(product: parentWidget.product),
                          const PriceTagButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({super.key, required this.productId});
  final String productId;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  final TextEditingController commentController = TextEditingController();
  bool isSendButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<CommentBloc>(context)
                      .add(CommentInitializeEvent(productId: widget.productId));
                },
                child: CustomScrollView(
                  slivers: [
                    if (state is CommentLoading) ...[
                      const SliverToBoxAdapter(child: Text('Loading...'))
                    ],
                    if (state is CommentResponse) ...[
                      state.response.fold(
                        (error) => SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              Icon(
                                Icons
                                    .signal_wifi_statusbar_connected_no_internet_4_sharp,
                                color: Theme.of(context).colorScheme.error,
                                size: 32,
                              ),
                              const Text('خطا در بارگذاری نظرات'),
                            ],
                          ),
                        ),
                        (commentList) {
                          if (commentList.isEmpty) {
                            return const SliverToBoxAdapter(
                                child: Text('•NO COMMENT•'));
                          }
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: index.isEven
                                          ? Kcolor.primery.withOpacity(0.05)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      // user avatar
                                      CircleAvatar(
                                          child: commentList[index]
                                                  .avatarEmptyChecker
                                                  .isNotEmpty
                                              ? CachedImage(
                                                  imageUrl: commentList[index]
                                                      .userAvatarUrl,
                                                  radius: 360,
                                                )
                                              : const Icon(
                                                  Icons.person,
                                                  color: Colors.black87,
                                                )),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // User name
                                            Text(
                                              commentList[index]
                                                      .userName
                                                      .isEmpty
                                                  ? 'کاربر اپل شاپ'
                                                  : commentList[index].userName,
                                              style: TextStyle(
                                                color: Kcolor.black
                                                    .withOpacity(0.5),
                                                fontSize: 13,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            // Comment Text
                                            Text(
                                              commentList[index].text.isEmpty
                                                  ? 'بدون نظر'
                                                  : commentList[index].text,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: commentList.length,
                            ),
                          );
                        },
                      ),
                    ]

                    //
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              onChanged: (text) {
                                setState(() {
                                  isSendButtonEnable = text.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(12),
                                hintText: 'افزودن نظر...',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Kcolor.grey,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Kcolor.primery,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            onPressed: isSendButtonEnable
                                ? () {
                                    context.read<CommentBloc>().add(
                                          CommentPostEvent(
                                            text: commentController.text,
                                            productId: widget.productId,
                                          ),
                                        );
                                    setState(() {
                                      commentController.text = '';
                                      isSendButtonEnable = false;
                                    });
                                  }
                                : null,
                            color: Kcolor.primery,
                            icon: const Icon(
                              Icons.send_rounded,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class ProductTechnicalDetail extends StatefulWidget {
  final List<Properties> properties;
  const ProductTechnicalDetail({
    super.key,
    required this.properties,
  });

  @override
  State<ProductTechnicalDetail> createState() => _ProductTechnicalDetailState();
}

class _ProductTechnicalDetailState extends State<ProductTechnicalDetail> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.only(top: 20, right: 32, left: 32),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Kcolor.grey, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'مشخصات فنی:',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.black,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.primery,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Ksvg(
                      size: 20,
                      color: Kcolor.primery,
                      path: Assets.icons.arrowLeft,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.fromLTRB(32, 6, 32, 0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Kcolor.grey),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.properties.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.properties[index].title} : ',
                        style: const TextStyle(
                          wordSpacing: 2,
                          fontSize: 14,
                          height: 1.6,
                          fontFamily: 'SM',
                          color: Kcolor.grey,
                        ),
                      ),
                      Text(
                        widget.properties[index].value!,
                        style: TextStyle(
                          wordSpacing: 2,
                          fontSize: 14,
                          height: 1.6,
                          fontFamily: 'SM',
                          color: Kcolor.black.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 6)
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProdeuctDescription extends StatefulWidget {
  final String productDescription;
  const ProdeuctDescription({super.key, required this.productDescription});

  @override
  State<ProdeuctDescription> createState() => _ProdeuctDescriptionState();
}

class _ProdeuctDescriptionState extends State<ProdeuctDescription> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: Container(
              height: 46,
              margin: const EdgeInsets.fromLTRB(32, 20, 32, 0),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Kcolor.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      'توضیحات محصول:',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.black,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'مشاهده',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.primery,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Ksvg(
                      size: 20,
                      color: Kcolor.primery,
                      path: Assets.icons.arrowLeft,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              margin: const EdgeInsets.fromLTRB(32, 6, 32, 0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Kcolor.grey),
              ),
              child: Text(
                widget.productDescription.toUpperCase(),
                style: TextStyle(
                  wordSpacing: 2,
                  fontSize: 14,
                  height: 1.6,
                  fontFamily: 'SM',
                  color: Kcolor.black.withOpacity(0.8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VariantContainerGenerator extends StatelessWidget {
  final List<ProductVariant> productVariantList;
  const VariantContainerGenerator(
      {super.key, required this.productVariantList});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var productVariant in productVariantList) ...{
            if (productVariant.variantList.isNotEmpty) ...{
              VariantGeneratorChild(productVariant: productVariant)
            }
          },
        ],
      ),
    );
  }
}

class VariantGeneratorChild extends StatelessWidget {
  final ProductVariant productVariant;
  const VariantGeneratorChild({super.key, required this.productVariant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '${productVariant.variantType.title}',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'SM',
              color: Kcolor.black,
            ),
          ),
          const SizedBox(height: 8),
          if (productVariant.variantType.type == VariantTypeEnum.color) ...{
            ColorVariantList(variantList: productVariant.variantList),
          },
          if (productVariant.variantType.type == VariantTypeEnum.storage) ...{
            StorageVariantList(variantList: productVariant.variantList),
          },
        ],
      ),
    );
  }
}

class GalleryImage extends StatefulWidget {
  final List<ProductImage> images;
  final String defaultProductThumbnail;
  const GalleryImage({
    super.key,
    required this.images,
    required this.defaultProductThumbnail,
  });

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 284,
        margin: const EdgeInsets.fromLTRB(32, 16, 32, 0),
        decoration: BoxDecoration(
          color: Kcolor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Kcolor.grey.withOpacity(0.4),
              spreadRadius: -5,
              blurRadius: 14,
              offset: const Offset(0, 7),
            )
          ],
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
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: CachedImage(
                              imageUrl: (widget.images.isEmpty)
                                  ? widget.defaultProductThumbnail
                                  : widget.images[selectedImage].imageUrl,
                              radius: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.images.isNotEmpty) ...{
                  SizedBox(
                    height: 56,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: widget.images.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImage = index;
                            });
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Kcolor.grey,
                                width: 1,
                              ),
                            ),
                            child: CachedImage(
                              imageUrl: widget.images[index].imageUrl,
                              radius: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                },
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Ksvg(
                    size: 22,
                    color: Kcolor.primery,
                    path: Assets.icons.favorite,
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
                        size: 22,
                        color: Kcolor.yellow,
                        path: Assets.icons.star,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCheckoutButton extends StatelessWidget {
  final Product product;
  const AddToCheckoutButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140,
          height: 47,
          decoration: BoxDecoration(
            color: Kcolor.primery,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                height: 53,
                width: 160,
                decoration: BoxDecoration(
                  color: Kcolor.primery.withOpacity(0.2),
                  border: Border.all(color: Kcolor.white.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.noise.path),
                    opacity: 0.1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Kcolor.primery.withOpacity(0.5),
                      focusColor: Kcolor.primery.withOpacity(0.5),
                      highlightColor: Kcolor.primery.withOpacity(0.5),
                      onTap: () {
                        context
                            .read<ProductBloc>()
                            .add(ProductAddToCheckout(product));
                        context
                            .read<CheckoutBloc>()
                            .add(FetchCheckoutItemListEvent());
                      },
                      child: Container(
                        height: 53,
                        width: 160,
                        padding: const EdgeInsets.all(4.0),
                        child: const Center(
                          child: Text(
                            'افزودن به سبد خرید',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'SB',
                              letterSpacing: -0.1,
                              color: Kcolor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceTagButton extends StatelessWidget {
  const PriceTagButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 140,
          height: 47,
          decoration: BoxDecoration(
            color: Kcolor.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Positioned(
          top: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                height: 53,
                width: 160,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  color: Kcolor.secondary.withOpacity(0.4),
                  border: Border.all(color: Kcolor.white.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.noise.path),
                    opacity: 0.1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Kcolor.tertiary,
                          borderRadius: BorderRadius.circular(365),
                        ),
                        padding: const EdgeInsets.fromLTRB(6, 1, 6, 0),
                        child: const Text(
                          '%3',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SB',
                            color: Kcolor.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '۴۶٬۰۰۰٬۰۰۰',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'SM',
                              color: Kcolor.white,
                              decorationColor: Kcolor.white,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            '۴۵٬۳۵۰٬۰۰۰',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'SB',
                              color: Kcolor.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'تومان',
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'SB',
                          color: Kcolor.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const ColorVariantList({super.key, required this.variantList});

  @override
  State<ColorVariantList> createState() => _ColorVariantListState();
}

class _ColorVariantListState extends State<ColorVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.variantList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(8),
                border: (_selectedIndex == index)
                    ? Border.all(
                        width: 1.5,
                        color: Kcolor.primery,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )
                    : Border.all(
                        width: 0.5,
                        color: Kcolor.grey,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
              ),
              child: Center(
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.variantList[index].value.parseToColor(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.variantList[index].name!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: 'SM',
                        color: Kcolor.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StorageVariantList extends StatefulWidget {
  final List<Variant> variantList;
  const StorageVariantList({super.key, required this.variantList});

  @override
  State<StorageVariantList> createState() => _StorageVariantListState();
}

class _StorageVariantListState extends State<StorageVariantList> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.variantList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Kcolor.white,
                borderRadius: BorderRadius.circular(8),
                border: (_selectedIndex == index)
                    ? Border.all(
                        width: 1.5,
                        color: Kcolor.primery,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )
                    : Border.all(
                        width: 0.5,
                        color: Kcolor.grey,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
              ),
              child: Center(
                child: Text(
                  widget.variantList[index].value!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'SM',
                    color: Kcolor.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

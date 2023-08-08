import 'dart:ui';
import 'package:apple_shop/bloc/checkout/checkout_bloc.dart';
import 'package:apple_shop/bloc/checkout/checkout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utility/string_extension.dart';
import '/data/model/product_image.dart';
import '/data/model/product_variant.dart';
import '/data/model/properties.dart';
import '/data/model/variant_type.dart';
import '/widgets/cached_image.dart';
import '/bloc/product/product_event.dart';
import '../data/model/product.dart';
import '../data/model/variant.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_state.dart';
import '/constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

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
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Kcolor.background,
            bottomNavigationBar: Container(
              height: 115,
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
                      AddToCheckoutButton(product: widget.product),
                      const PriceTagButton(),
                    ],
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(const Duration(microseconds: 500), () {
                    BlocProvider.of<ProductBloc>(context).add(
                      ProductInitializeEvent(
                        productId: widget.product.id!,
                        categoryId: widget.product.category!,
                      ),
                    );
                  });
                },
                child: CustomScrollView(
                  slivers: [
                    // Circular Progress Indicator
                    if (state is ProductLoadingState) ...[
                      const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    ],

                    // AppBar
                    if (state is ProductResponseState) ...[
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
                    ],

                    // Product name title
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(42, 0, 42, 18),
                        child: Text(
                          widget.product.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'SB',
                            color: Kcolor.black,
                          ),
                        ),
                      ),
                    ),

                    // Gallery Card
                    if (state is ProductResponseState) ...[
                      state.productImages.fold(
                        (l) => const SliverToBoxAdapter(
                          child: Text('unknown error'),
                        ),
                        (productImages) {
                          return GalleryImage(
                            images: productImages,
                            defaultProductThumbnail: widget.product.thumbnail!,
                          );
                        },
                      )
                    ],

                    // Product Variants
                    if (state is ProductResponseState) ...[
                      state.productVariant.fold(
                        (l) => const SliverToBoxAdapter(
                          child: Text('unknown error'),
                        ),
                        (productVariantList) {
                          return VariantContainerGenerator(
                            productVariantList: productVariantList,
                          );
                        },
                      )
                    ],

                    if (state is ProductResponseState) ...[
                      state.productProperties.fold(
                        (l) => const SliverToBoxAdapter(
                          child: Text('unknown error'),
                        ),
                        (r) {
                          return ProductTechnicalDetail(properties: r);
                        },
                      )
                    ],

                    // Prodeuct Description
                    ProdeuctDescription(
                      productDescription:
                          widget.product.description ?? 'بدون توضیحات',
                    ),

                    // User Comments
                    SliverToBoxAdapter(
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
                                'نظرات کاربران:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'SM',
                                  color: Kcolor.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Kcolor.secondary,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                        color: Kcolor.white,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 15,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Kcolor.tertiary,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Kcolor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 30,
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        color: Kcolor.primery,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Kcolor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 45,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Kcolor.yellow,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Kcolor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 60,
                                    child: Container(
                                      height: 26,
                                      width: 26,
                                      decoration: BoxDecoration(
                                        color: Kcolor.grey,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: Kcolor.white,
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '99+',
                                          style: TextStyle(
                                            color: Kcolor.white,
                                            fontFamily: 'SB',
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                    const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
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
        margin: const EdgeInsets.symmetric(horizontal: 32),
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

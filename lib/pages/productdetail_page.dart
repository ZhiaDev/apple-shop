import 'dart:ui';

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
      bottomNavigationBar: Container(
        height: 115,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Kcolor.white, width: 1),
          ),
        ),
        child: const Column(
          children: [
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AddToCheckoutButton(),
                PriceTagButton(),
              ],
            ),
          ],
        ),
      ),
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
                    fontSize: 18,
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
                                  child: Image.asset(
                                    Assets.images.iPhone14ProMax.path,
                                    fit: BoxFit.fitHeight,
                                  ),
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
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Kcolor.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Kcolor.grey,
                                    width: 1,
                                  ),
                                ),
                                child: Image.asset(
                                  Assets.images.iPhone14ProMax.path,
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'انتخاب رنگ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Kcolor.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text(
                                'مشکی',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SM',
                                  color: Kcolor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Kcolor.tertiary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 0.5,
                              color: Kcolor.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'انتخاب حافظه داخلی',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'SM',
                        color: Kcolor.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Kcolor.primery,
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '۱۲۸',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SM',
                                color: Kcolor.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Kcolor.grey,
                              width: 0.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '۲۵۶',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SM',
                                color: Kcolor.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Kcolor.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Kcolor.grey,
                              width: 0.5,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '۵۱۲',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'SM',
                                color: Kcolor.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
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
    );
  }
}

class AddToCheckoutButton extends StatelessWidget {
  const AddToCheckoutButton({super.key});

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
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Kcolor.primery.withOpacity(0.2),
                  border: Border.all(color: Kcolor.white.withOpacity(0.8)),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(Assets.images.noise.path),
                    opacity: 0.1,
                  ),
                ),
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

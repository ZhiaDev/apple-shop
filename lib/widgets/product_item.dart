import 'package:apple_shop/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/checkout/checkout_bloc.dart';
import '/pages/productdetail_page.dart';
import '/widgets/cached_image.dart';
import '/data/model/product.dart';
import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlocProvider<CheckoutBloc>.value(
              value: locator.get<CheckoutBloc>(),
              child: ProductDetailPage(product: product),
            ),
          ),
        );
      },
      child: Container(
        width: 156,
        height: 210,
        decoration: BoxDecoration(
          color: Kcolor.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(width: 170),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      height: 100,
                      child:
                          CachedImage(imageUrl: product.thumbnail, radius: 0),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Ksvg(
                      path: Assets.icons.favorite,
                      size: 22,
                      color: Kcolor.primery,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Kcolor.tertiary,
                        borderRadius: BorderRadius.circular(365),
                      ),
                      padding: const EdgeInsets.only(
                        right: 6,
                        left: 6,
                        top: 1,
                      ),
                      child: Text(
                        '%${product.percent?.round()}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'SB',
                          color: Kcolor.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Spacer(),
            // I do this temporarily
            // because I don't have access to the backend right now to change these names
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name!
                    .replaceAll(
                        'گوشی موبایل اپل مدل iphone 14 Pro', 'آیفون 14 پرو')
                    .replaceAll('گوشی موبایل اپل مدل iPhone 13 Pro Max A2644',
                        'آیفون 13 پرو مکس')
                    .replaceAll('اپل مدل AirPods Max', 'هدفون AirPods Max')
                    .replaceAll('AirPods 3  هدفون', 'ایرپاد مدل 3')
                    .replaceAll(
                        '2021 MacBook MKGR3 M1 Pro', 'مک‌بوک 2021 M1 Pro')
                    .replaceAll('MacBook Air-A M2 2022', 'مک‌بوک ایر 2022 M2')
                    .replaceAll('Ultra 49 mm اپل واچ', 'اپل واچ اولترا 49mm')
                    .replaceAll('8 Aluminum 41mm ساعت هوشمند', 'اپل واچ 49mm 8')
                    .replaceAll('iMac Pro 2017 آی مک', 'آی مک پرو 2017')
                    .replaceAll('iMac-A 2021 آی مک', 'آی مک 2021 M1')
                    .replaceAll('iPad Mini 6th آی‌پد', 'آیپد مینی نسل 6')
                    .replaceAll('iPad Pro 12.9 آی‌پد', 'آیپد پرو 12.9 اینچ')
                    .replaceAll('Pencil 2nd قلم', 'قلم اپل نسل 2')
                    .replaceAll('شارژر ۲۰ وات', 'شارژر 20 وات اپل'),
                maxLines: 1,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 14, fontFamily: 'SM'),
              ),
            ),
            const Spacer(),
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: Kcolor.primery,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Kcolor.primery,
                    offset: Offset(0, 15),
                    blurRadius: 42,
                    spreadRadius: -16,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Ksvg(
                      path: Assets.icons.arrowRightBold,
                      size: 20,
                      color: Kcolor.white,
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product.price.toString().seRagham(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'SM',
                            color: Kcolor.grey2,
                            decorationColor: Kcolor.white,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          product.discountPrice.toString().seRagham(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'SM',
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
                        fontFamily: 'SM',
                        color: Kcolor.white,
                      ),
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

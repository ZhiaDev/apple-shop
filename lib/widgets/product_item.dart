import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  child: Image.asset(
                    Assets.images.iphone.path,
                    height: 100,
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
                    child: const Text(
                      '%3',
                      style: TextStyle(
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
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: const Text(
              'آیفون ۱۳ پرو مکس',
              style: TextStyle(fontSize: 14, fontFamily: 'SM'),
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
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '۴۶٬۰۰۰٬۰۰۰',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SM',
                          color: Kcolor.grey2,
                          decorationColor: Kcolor.white,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '۴۵٬۳۵۰٬۰۰۰',
                        style: TextStyle(
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
    );
  }
}

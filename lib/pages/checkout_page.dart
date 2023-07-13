import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import '../utility/svg.dart';
import '/constants/colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kcolor.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Row(
          children: [
            Text(
              'ادامه فرآیند خرید',
              style: TextStyle(color: Kcolor.white, fontFamily: 'SB'),
            ),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_rounded, color: Kcolor.white)
          ],
        ),
        backgroundColor: Kcolor.secondary,
        splashColor: const Color(0xFF38BD98),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Center(
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
                        'سبد خرید',
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 10,
                  (context, index) {
                    return cardWidget(context);
                  },
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 72)),
            ],
          ),
        ),
      ),
    );
  }

  Container cardWidget(BuildContext context) {
    return Container(
      height: 249,
      margin: const EdgeInsets.fromLTRB(32, 0, 32, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Kcolor.white,
        boxShadow: [
          BoxShadow(
            color: Kcolor.grey.withOpacity(0.4),
            spreadRadius: -18,
            blurRadius: 14,
            offset: const Offset(0, 18),
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Image.asset(
                    Assets.images.iPhone14ProMax.path,
                    width: 80,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'آیفون ۱۳ پرومکس دوسیم کارت',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SB',
                            color: Kcolor.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'گارانتی 18 ماه مدیا پردازش',
                          style: TextStyle(color: Kcolor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  '۴۶٬۰۰۰٬۰۰۰',
                                  style: TextStyle(
                                    color: Kcolor.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  ' تومان',
                                  style: TextStyle(
                                    color: Kcolor.grey,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),
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
                          ],
                        ),
                        const Spacer(),
                        const Wrap(
                          spacing: 4,
                          runSpacing: 8,
                          children: [
                            OptionChip(),
                            OptionChip(),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    topLeft: Radius.circular(100),
                  ),
                  color: Kcolor.background,
                  shape: BoxShape.rectangle,
                ),
                height: 24,
                width: 12,
              ),
              const SizedBox(width: 4),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: DottedLine(
                    dashLength: 8,
                    dashGapLength: 3,
                    lineThickness: 2.5,
                    dashColor: Kcolor.grey2,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(100),
                  ),
                  color: Kcolor.background,
                  shape: BoxShape.rectangle,
                ),
                height: 24,
                width: 12,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '۴۶٬۰۰۰٬۰۰۰',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  ' تومان',
                  style: TextStyle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Kcolor.grey.withOpacity(0.6),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '۲۵۶ گیگابایت',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'SM',
              color: Kcolor.grey,
            ),
          ),
          const SizedBox(width: 4),
          Ksvg(
            size: 14,
            color: Kcolor.grey,
            path: Assets.icons.option,
          ),
        ],
      ),
    );
  }
}

import 'package:apple_shop/bloc/checkout/checkout_event.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../bloc/checkout/checkout_bloc.dart';
import '../bloc/checkout/checkout_state.dart';
import '../data/model/checkout_item.dart';
import '/utility/string_extension.dart';
import '/widgets/cached_image.dart';
import '../gen/assets.gen.dart';
import '../utility/svg.dart';
import '/constants/colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Kcolor.background,
              floatingActionButton: (state is CheckoutDataFetchedState &&
                      state.checkoutFinalPrice > 0)
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        context
                            .read<CheckoutBloc>()
                            .add(CheckoutPaymentInitEvent());
                        context
                            .read<CheckoutBloc>()
                            .add(CheckoutPaymentRequestEvent());
                      },
                      label: const Row(
                        children: [
                          Text(
                            'ادامه فرآیند سفارش',
                            style: TextStyle(
                              color: Kcolor.white,
                              fontFamily: 'SB',
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            color: Kcolor.white,
                          )
                        ],
                      ),
                      backgroundColor: Kcolor.secondary,
                      splashColor: const Color(0xFF38BD98),
                    )
                  : const SizedBox(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              body: SafeArea(
                child: Center(
                  child: CustomScrollView(
                    slivers: [
                      // AppBar
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

                      if (state is CheckoutDataFetchedState) ...{
                        SliverToBoxAdapter(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                            padding: const EdgeInsets.all(16),
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
                            child: (state.checkoutFinalPrice == 0)
                                ? const Row(
                                    children: [
                                      Icon(
                                        Icons.priority_high_rounded,
                                        color: Kcolor.tertiary,
                                        size: 20,
                                      ),
                                      Text(
                                        ' سبد خرید خالی است.',
                                        style: TextStyle(
                                          color: Kcolor.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      const Icon(
                                        Icons.shopping_cart,
                                        color: Kcolor.primery,
                                        size: 20,
                                      ),
                                      const Text(
                                        '  مبلغ قابل پرداخت : ',
                                        style: TextStyle(
                                          color: Kcolor.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        state.checkoutFinalPrice
                                            .toString()
                                            .seRagham(),
                                        style: const TextStyle(
                                          color: Kcolor.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Text(
                                        ' تومان',
                                        style: TextStyle(
                                          color: Kcolor.black,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      },
                      // Product Lists
                      if (state is CheckoutDataFetchedState) ...{
                        state.checkoutItemList.fold(
                          (l) {
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
                          (checkoutItemList) => SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: checkoutItemList.length,
                              (context, index) {
                                return CardWidget(
                                  checkoutItem: checkoutItemList[index],
                                  index: index,
                                );
                              },
                            ),
                          ),
                        )
                      },
                      const SliverPadding(padding: EdgeInsets.only(bottom: 72)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CardWidget extends StatelessWidget {
  final CheckoutItem checkoutItem;
  const CardWidget({
    super.key,
    required this.checkoutItem,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
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
                  child: SizedBox(
                    width: 80,
                    child: CachedImage(
                      imageUrl: checkoutItem.thumbnail,
                      radius: 0,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title of Product
                        Text(
                          checkoutItem.name ?? 'نام محصول',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'SB',
                            color: Kcolor.black,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Subtitle of product
                        const Text(
                          'گارانتی 18 ماه مدیا پردازش',
                          style: TextStyle(color: Kcolor.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Price of Product
                            Row(
                              children: [
                                Text(
                                  checkoutItem.price.toString().seRagham(),
                                  style: const TextStyle(
                                    color: Kcolor.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                const Text(
                                  ' تومان',
                                  style: TextStyle(
                                    color: Kcolor.grey,
                                    fontSize: 13,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),

                            // Offer Percent
                            Container(
                              decoration: BoxDecoration(
                                color: Kcolor.tertiary,
                                borderRadius: BorderRadius.circular(365),
                              ),
                              padding: const EdgeInsets.fromLTRB(6, 1, 6, 0),
                              child: Text(
                                '%${checkoutItem.percent?.round()}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'SB',
                                  color: Kcolor.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        // Details of product
                        Wrap(
                          spacing: 4,
                          runSpacing: 8,
                          children: [
                            const OptionChip(
                              title: '100 گیگ',
                              color: 'DF4F3B',
                            ),
                            GestureDetector(
                              onTap: () => context.read<CheckoutBloc>().add(
                                  CheckoutRemoveProductEvent(index: index)),
                              child: Container(
                                height: 28,
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
                                    Ksvg(
                                      path: Assets.icons.delete,
                                      size: 16,
                                      color: Kcolor.tertiary,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'حذف',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'SM',
                                        color: Kcolor.tertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

          // real Price
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  checkoutItem.discountPrice.toString().seRagham(),
                  style: const TextStyle(fontSize: 18),
                ),
                const Text(
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
  final String? color;
  final String title;
  const OptionChip({
    super.key,
    this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
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
          if (color != null) ...{
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.parseToColor(),
              ),
            ),
            const SizedBox(width: 8),
          },
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'SM',
              color: Kcolor.grey,
            ),
          ),
        ],
      ),
    );
  }
}

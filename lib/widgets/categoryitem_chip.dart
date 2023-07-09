import 'package:flutter/material.dart';

import '../constants/colors.dart';


class CategoryItemChip extends StatelessWidget {
  const CategoryItemChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: ShapeDecoration(
              color: Kcolor.secondary,
              shadows: const [
                BoxShadow(
                  color: Kcolor.secondary,
                  offset: Offset(0, 15),
                  blurRadius: 42,
                  spreadRadius: -10,
                )
              ],
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(48),
              ),
            ),
            child: const Icon(
              Icons.mobile_off_sharp,
              color: Kcolor.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'همه',
            style: TextStyle(fontSize: 13, fontFamily: 'SB'),
          )
        ],
      ),
    );
  }
}

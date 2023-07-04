import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constants/colors.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.8, initialPage: 1);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            itemCount: 3,
            controller: controller,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.amber,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: const ExpandingDotsEffect(
              dotWidth: 6,
              dotHeight: 6,
              expansionFactor: 4,
              dotColor: Kcolor.white,
              activeDotColor: Kcolor.blueIndicator,
            ),
          ),
        )
      ],
    );
  }
}

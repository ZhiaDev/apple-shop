import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/widgets/cached_image.dart';
import '/data/model/banner.dart';
import '../constants/colors.dart';

class BannerSlider extends StatelessWidget {
  final List<CampaignBanner> bannerList;
  const BannerSlider({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    var controller = PageController(viewportFraction: 0.86, initialPage: 1);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 170,
          child: PageView.builder(
            itemCount: bannerList.length,
            controller: controller,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CachedImage(
                  imageUrl: bannerList[index].thumbnail,
                  radius: 15,
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: controller,
            count: bannerList.length,
            effect: const ExpandingDotsEffect(
              dotWidth: 6,
              dotHeight: 6,
              expansionFactor: 3,
              dotColor: Kcolor.white,
              activeDotColor: Kcolor.black,
            ),
          ),
        )
      ],
    );
  }
}

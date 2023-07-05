import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Ksvg extends StatelessWidget {
  final String path;
  final double size;
  final Color color;

  const Ksvg({
    super.key,
    required this.path,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: size,
      fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }
}

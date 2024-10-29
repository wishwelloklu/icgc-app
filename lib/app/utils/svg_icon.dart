import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      {super.key,
      this.size,
      required this.icon,
      this.color,
      this.width,
      this.height});
  final Color? color;
  final double? size;
  final double? width;
  final double? height;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height ?? size,
      width: width ?? size,
      color: color,
    );
  }
}

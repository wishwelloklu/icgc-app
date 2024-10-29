import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';

class RoundIcon extends StatelessWidget {
  final String imageIcon;
  final double imageSize;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback? onPressed;

  const RoundIcon(
      {super.key,
      this.imageSize = AppPadding.buttonIcon,
      this.iconColor = AppColor.darkColor,
      this.bgColor = AppColor.pageBorder,
      this.onPressed,
      required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.medium),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppPadding.teamImage),
        ),
        child: Image.asset(
          color: iconColor,
          width: imageSize,
          height: imageSize,
          imageIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

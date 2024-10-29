import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';

class TeamIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageIcon;
  final double imageSize;
  final Color bgColor;

  const TeamIcon(
      {super.key,
      this.imageSize = AppPadding.buttonIcon,
      this.bgColor = AppColor.pageBorder,
      required this.onPressed,
      required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.medium),
        decoration: BoxDecoration(
          color: AppColor.pageBackground,
          borderRadius: BorderRadius.circular(AppPadding.teamImage),
        ),
        child: Image.asset(
          color: AppColor.blackColor,
          width: imageSize,
          height: imageSize,
          imageIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

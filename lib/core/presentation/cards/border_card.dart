import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_raduis.dart';


class BorderContainerCard extends StatelessWidget {
  const BorderContainerCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.borderColor,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(AppPadding.normal),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color ?? AppColor.whiteColor,
        border: Border.all(
            color: borderColor ?? const Color(0xFFF1F5F9), width: 1.5),
      ),
      child: child,
    );
  }
}

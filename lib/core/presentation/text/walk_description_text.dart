import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class WalkDescriptionText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;

  const WalkDescriptionText(
      {super.key,
      required this.text,
      this.fontSize = AppFontSize.labelSmall,
      this.color = AppColor.whiteColor,
      this.maxLine = 10,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: AppTextStyle.appDescription(color: color, size: fontSize),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class SubHeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;

  const SubHeaderText(
      {super.key,
      required this.text,
      this.fontSize = AppFontSize.headLineSmall,
      this.color = AppColor.blackColor,
      this.maxLine = 10,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: AppTextStyle.appTitle(color: color, size: fontSize),
    );
  }
}

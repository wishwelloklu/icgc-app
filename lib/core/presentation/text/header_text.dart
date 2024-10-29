import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class HeaderText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;

  const HeaderText(
      {super.key,
      required this.text,
      this.fontSize = AppFontSize.headLineMedium,
      this.color = AppColor.blackColor,
      this.maxLine = 10,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: maxLine,
        textAlign: textAlign,
        style: AppTextStyle.appHeader(color: color, size: fontSize),
      ),
    );
  }
}

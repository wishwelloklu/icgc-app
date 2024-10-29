import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;
  final double? width;

  const LabelText(
      {super.key,
      required this.text,
      this.fontSize = AppFontSize.small,
      this.color = AppColor.labelColor,
      this.maxLine = 10,
      this.width,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: maxLine,
        textAlign: textAlign,
        style: AppTextStyle.appLabel(color: color, size: fontSize),
      ),
    );
  }
}

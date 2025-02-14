import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_text_style.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final int? maxLine;
  final TextAlign textAlign;
  const DescriptionText({
    super.key,
    required this.text,
    this.fontSize,
    this.color = AppColor.descriptionColor,
    this.maxLine = 10,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: AppTextStyle.appDescription(
          color: color, size: fontSize ?? AppFontSize.labelSmall),
      overflow: TextOverflow.ellipsis,
    );
  }
}

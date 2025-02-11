import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_text_style.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  const TitleText({
    super.key,
    required this.text,
    this.fontSize = AppFontSize.labelMedium,
    this.color = AppColor.darkColor,
    this.fontWeight = FontWeight.w700,
    this.maxLine = 2,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: AppTextStyle.appTitle(
        color: color,
        size: fontSize,
        fontWeight: fontWeight,
        
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

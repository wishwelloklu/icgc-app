import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/screen_size.dart';

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
    var isTablet = ScreenSizeHelper(context).isTablet;
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: maxLine,
        textAlign: textAlign,
        style: AppTextStyle.appLabel(
            color: color, size: isTablet ? AppFontSize.medium : fontSize),
      ),
    );
  }
}

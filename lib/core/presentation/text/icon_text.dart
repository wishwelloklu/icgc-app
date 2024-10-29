import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_spacer.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/svg_icon.dart';

class IconText extends StatelessWidget {
  final String text;
  final String icon;
  final double iconSize;
  final double fontSize;
  final Color textColor;
  final Color iconColor;
  final int maxLine;
  final TextAlign textAlign;

  const IconText(
      {super.key,
      required this.text,
      this.icon = '',
      this.iconSize = AppPadding.smallerIcon,
      this.fontSize = AppFontSize.small,
      this.textColor = AppColor.labelColor,
      this.iconColor = AppColor.labelColor,
      this.maxLine = 1,
      this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon.isNotEmpty) ...[
          SvgIcon(
            icon: icon,
            color: iconColor,
            size: iconSize,
          ),
        ],
        AppSpacer.horizontalSpace(width: AppPadding.extraSmall),
        Text(
          text,
          maxLines: maxLine,
          textAlign: textAlign,
          style: AppTextStyle.appDescription(
            color: textColor,
            size: fontSize,
          ),
        ),
      ],
    );
  }
}

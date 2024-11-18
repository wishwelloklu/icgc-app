import 'package:flutter/material.dart';
import '../../../app/theme/app_padding.dart';
import 'description_text.dart';

class TextWithBackgroundColor extends StatelessWidget {
  const TextWithBackgroundColor({
    super.key,
    required this.text,
    this.textColor,
    required this.backgroundColor,
    this.opacity = .1,
  });

  final String text;
  final Color? textColor;
  final double opacity;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(opacity),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.medium,
          vertical: AppPadding.extraXSmall,
        ),
        child: DescriptionText(
          color: textColor ?? backgroundColor,
          text: text,
        ));
  }
}

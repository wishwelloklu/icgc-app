import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color foreColor;
  final Color bgColor;

  const SmallButton({
    super.key,
    required this.text,
    this.foreColor = AppColor.primaryColor,
    this.bgColor = AppColor.secondaryColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(AppPadding.appBar, AppPadding.large),
          textStyle: AppTextStyle.buttonSmallStyle(),
          foregroundColor: foreColor,
          backgroundColor: bgColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.regular)),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.buttonText(color: foreColor),
      ),
    );
  }
}

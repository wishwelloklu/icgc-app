import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class SuccessButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;

  const SuccessButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.height = AppPadding.buttonHeight,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: const TextTheme().titleMedium,
          foregroundColor: AppColor.whiteColor,
          backgroundColor: AppColor.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyle.buttonText(),
        ),
      ),
    );
  }
}

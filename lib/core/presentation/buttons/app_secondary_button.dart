import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_text_style.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;

  const SecondaryButton(
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
          foregroundColor: AppColor.primaryColor,
          backgroundColor: AppColor.secondaryColor,
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

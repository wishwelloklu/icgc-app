import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_padding.dart';
import 'package:icgc/app/theme/app_text_style.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color color;
  final Color? backgroundColor;
  final bool showLoadingIndicator;
  final bool showBorder;
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = AppPadding.buttonHeight,
    this.color = AppColor.primaryColor,
    this.backgroundColor,
    this.width,
    this.showLoadingIndicator = false,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: showBorder ? const BorderSide(color: AppColor.textInputFieldBorder) : BorderSide.none,
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
        ),
        child: showLoadingIndicator
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2))
            : Text(
                text,
                style: AppTextStyle.buttonText(color: color),
              ),
      ),
    );
  }
}

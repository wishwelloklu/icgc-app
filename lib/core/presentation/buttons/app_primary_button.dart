import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool showLoadingIndicator;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = AppPadding.buttonHeight,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: AppTextStyle.buttonText(),
          foregroundColor: textColor ?? AppColor.whiteColor,
          disabledBackgroundColor: AppColor.primaryColor.withOpacity(.4),
          backgroundColor: backgroundColor ?? AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
        ),
        onPressed: showLoadingIndicator ? null : onPressed,
        child: showLoadingIndicator
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2))
            : Text(
                text,
                style: AppTextStyle.buttonText(
                    color: textColor ?? AppColor.whiteColor),
              ),
      ),
    );
  }
}

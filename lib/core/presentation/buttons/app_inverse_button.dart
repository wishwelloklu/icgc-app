import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_text_style.dart';

class InverseButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color foreColor;
  final Color bgColor;

  const InverseButton({
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
        textStyle: const TextTheme().titleMedium,
        foregroundColor: foreColor,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTextStyle.buttonText(),
      ),
    );
  }
}

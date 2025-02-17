import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_spacer.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/svg_icon.dart';

class AppIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imageIcon;
  final double? width;
  final double height;

  const AppIconButton({
    super.key,
    required this.text,
    required this.imageIcon,
    required this.onPressed,
    this.height = AppPadding.buttonHeight,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          textStyle: AppTextStyle.buttonText(),
          foregroundColor: AppColor.labelColor,
          backgroundColor: AppColor.whiteColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: AppColor.buttonBorderColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgIcon(
              icon:imageIcon,
              size: AppPadding.buttonIcon,
            ),
            AppSpacer.horizontalSpace(),
            Text(text),
          ],
        ),
      ),
    );
  }
}

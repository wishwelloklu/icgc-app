import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_spacer.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/screen_size.dart';
import '../../../app/utils/svg_icon.dart';

class AppTwoIconButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? backIcon;
  final String? frontIcon;
  final double? width;
  final double height;
  final Color bgColor;
  final bool useWidth;
  final TextStyle? style;
  final EdgeInsets? padding;
  const AppTwoIconButton(
      {super.key,
      required this.text,
      this.style,
      this.padding,
      this.backIcon,
      this.frontIcon,
      this.useWidth = false,
      required this.onPressed,
      this.height = AppPadding.buttonHeight,
      this.bgColor = AppColor.pageBackground,
      this.width});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: useWidth ? (width ?? MediaQuery.of(context).size.width) : null,
      height: height,
      child: TextButton(
        iconAlignment: IconAlignment.start,
        style: TextButton.styleFrom(
          elevation: 0.0,
          textStyle: AppTextStyle.buttonText(),
          padding: padding,
          foregroundColor: AppColor.labelColor,
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.buttonRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (backIcon != null)
              SvgIcon(
                icon: backIcon!,
                size: AppPadding.xSmallerIcon,
              ),
            AppSpacer.horizontalSpace(),
            Text(text, style: style),
            AppSpacer.horizontalSpace(),
            if (frontIcon != null)
              SvgIcon(
                icon: frontIcon!,
                size: AppPadding.xSmallerIcon,
              ),
          ],
        ),
      ),
    );
  }
}

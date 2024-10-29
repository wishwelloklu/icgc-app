import 'package:flutter/material.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'package:icgc/app/theme/app_color.dart';

class ThemeStyle {
  final bool isDarkMode;

  ThemeStyle({this.isDarkMode = false});

  // Button Style
  ButtonStyle get primaryButton => ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextTheme().titleMedium),
        foregroundColor: WidgetStateProperty.all(AppColor.whiteColor),
        backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
      );

  ButtonStyle get secondaryButton => ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextTheme().titleMedium),
        foregroundColor: WidgetStateProperty.all(AppColor.whiteColor),
        backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
      );

  ButtonStyle get inverseButton => ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextTheme().titleMedium),
        foregroundColor: WidgetStateProperty.all(AppColor.primaryColor),
        backgroundColor: WidgetStateProperty.all(AppColor.whiteColor),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
      );

  ButtonStyle get successButton => ButtonStyle(
        textStyle: WidgetStateProperty.all(const TextTheme().titleMedium),
        foregroundColor: WidgetStateProperty.all(AppColor.whiteColor),
        backgroundColor: WidgetStateProperty.all(AppColor.greenColor),
        padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
      );

  //Progress Bar
  static const TextStyle progressHeader = TextStyle(
      fontFamily: ConstantConfig.mulish,
      color: Colors.black,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);

  static const TextStyle progressBody = TextStyle(
      fontFamily: ConstantConfig.mulish,
      color: Colors.white,
      fontSize: 10,
      height: 0.5,
      fontWeight: FontWeight.w400);

  static const TextStyle progressFooter = TextStyle(
      fontFamily: ConstantConfig.mulish,
      color: Colors.black,
      fontSize: 20,
      height: 0.5,
      fontWeight: FontWeight.w600);
}

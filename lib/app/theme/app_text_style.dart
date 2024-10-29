import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';

class AppTextStyle {
  static TextStyle appHeader(
      {double size = AppFontSize.headLineMedium,
      Color color = AppColor.whiteColor}) {
    return TextStyle(
      fontFamily: ConstantConfig.satoshi,
      height: 1.1,
      letterSpacing: 0.0,
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle appSubHeader(
      {double size = AppFontSize.large, Color color = AppColor.whiteColor}) {
    return TextStyle(
      fontFamily: ConstantConfig.satoshi,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle appTitle({
    double size = AppFontSize.normal,
    Color color = AppColor.blackColor,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle appLabel(
      {double size = AppFontSize.medium, Color color = AppColor.blackColor}) {
    return TextStyle(
        fontFamily: ConstantConfig.mulish,
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w500);
  }

  static TextStyle appInputHint(
      {double size = AppFontSize.small, Color color = AppColor.textInputHint}) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle appInputText(
      {double size = AppFontSize.medium, Color color = AppColor.labelColor}) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle appDescription({
    double size = AppFontSize.small,
    Color color = AppColor.blackColor,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle buttonText({
    double size = AppFontSize.medium,
    Color color = AppColor.whiteColor,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle buttonSmallStyle(
      {double size = AppFontSize.small, Color color = AppColor.whiteColor}) {
    return TextStyle(
      fontFamily: ConstantConfig.mulish,
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }
}

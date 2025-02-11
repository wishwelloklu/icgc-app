import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/app/utils/string_extension.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class RoundTextCard extends StatelessWidget {
  const RoundTextCard(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Container(
      height: isTablet ? 70 : 40,
      width: isTablet ? 70 : 40,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.primaryColor,
      ),
      child: TitleText(
        text: text.initial,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: isTablet ? 35 : 20,
        maxLine: 1,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/svg_icon.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class RowCard extends StatelessWidget {
  const RowCard(
      {super.key, required this.icon, required this.text, required this.lable});
  final String icon;
  final String text;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      width: MediaQuery.sizeOf(context).width * .29,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgIcon(icon: icon),
          TitleText(text: lable),
          TitleText(
            text: text,
            color: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }
}

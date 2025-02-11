// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/svg_icon.dart';

class SideNaveItem extends StatelessWidget {
  const SideNaveItem({
    super.key,
    required this.text,
    required this.icon,
    required this.isSelected,
  });

  final String text;
  final String icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final isSvg = icon.split('.').last == 'svg';
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(.2) : null,
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        spacing: 5,
        children: [
          Expanded(
            flex: 2,
            child: isSvg
                ? SvgIcon(
                    color: Colors.white,
                    icon: icon,
                    size: 35,
                  )
                : Image.asset(
                    color: isSelected ? AppColor.primaryColor : Colors.white,
                    icon,
                    height: 35,
                    width: 35,
                  ),
          ),
          Expanded(
            flex: 8,
            child: Text(text,
                style: isSelected
                    ? AppTextStyle.navBarLable(
                        fontWeight: FontWeight.w600,
                        color: AppColor.whiteColor,
                        size: 25,
                      )
                    : AppTextStyle.navBarLable(
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteColor,
                        size: 25,
                      )),
          )
        ],
      ),
    );
  }
}

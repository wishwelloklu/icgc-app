import 'package:flutter/material.dart';

import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_padding.dart';
import '../../../app/theme/app_raduis.dart';
import '../../../app/theme/app_text_style.dart';

class ModalListItem extends StatelessWidget {
  const ModalListItem(
      {super.key,
      required this.onTap,
      required this.title,
      this.trailing,
      this.isSelected = false,
      this.leading});

  final VoidCallback onTap;
  final String title;
  final IconData? trailing;
  final bool isSelected;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppPadding.extraXSmall),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.medium),
          color: AppColor.whiteColor,
          border: Border.all(color: const Color(0xFFF1F5F9), width: 2)),
      child: ListTile(
        horizontalTitleGap: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.medium)),
        onTap: onTap,
        leading: leading != null
            ? SizedBox(height: 24, width: 24, child: leading)
            : null,
        title: Text(
          title,
          style: AppTextStyle.appDescription(
              fontWeight: FontWeight.w500,
              size: AppFontSize.small,
              color: AppColor.blackColor),
        ),
        trailing: trailing != null
            ? Icon(
                trailing,
                color: AppColor.blackColor,
              )
            : null,
      ),
    );
  }
}

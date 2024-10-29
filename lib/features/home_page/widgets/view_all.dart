import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import '../../../core/presentation/buttons/app_two_icon_button.dart';

class ViewAllTitle extends StatelessWidget {
  const ViewAllTitle({
    super.key,
    required this.onViewAll,
    required this.text,
  });
  final VoidCallback onViewAll;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: TitleText(
              text: text,
              textAlign: TextAlign.left,
              fontSize: 14,
            ),
          ),
          AppTwoIconButton(
            text: AppString.viewAll,
            frontIcon: AppImages.arrowRight,
            width: double.infinity,
            onPressed: onViewAll,
            useWidth: false,
            padding: EdgeInsets.zero,
            style: AppTextStyle.appDescription(color: AppColor.primaryColor),
          ),
        ],
      ),
    );
  }
}

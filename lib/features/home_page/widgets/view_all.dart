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
    this.onViewAll,
    required this.text,
    this.horizontalPadding,
    this.isViewMore = true,
  });
  final VoidCallback? onViewAll;
  final String text;
  final double? horizontalPadding;
  final bool isViewMore;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 4, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TitleText(
              text: text,
              textAlign: TextAlign.left,
              fontSize: 14,
            ),
          ),
          if (onViewAll != null)
            AppTwoIconButton(
              text: isViewMore ? AppString.viewMore : AppString.viewAll,
              frontIcon: AppImages.arrowRight,
              width: double.infinity,
              onPressed: onViewAll!,
              useWidth: false,
              padding: EdgeInsets.zero,
              style: AppTextStyle.appDescription(color: AppColor.primaryColor),
            ),
        ],
      ),
    );
  }
}

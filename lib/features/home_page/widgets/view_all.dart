import 'package:flutter/material.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_images.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/text/title_text.dart';

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
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 4, vertical: isTablet ? 10 : 5),
      child: Row(
        children: [
          Expanded(
            child: TitleText(
              text: text,
              textAlign: TextAlign.left,
              fontSize: isTablet ? 20 : 14,
            ),
          ),
          AppTwoIconButton(
            text: onViewAll != null
                ? isViewMore
                    ? AppString.viewMore
                    : AppString.viewAll
                : '',
            frontIcon: onViewAll != null ? AppImages.arrowRight : null,
            width: double.infinity,
            height: 35,
            onPressed: onViewAll ?? () {},
            useWidth: false,
            padding: EdgeInsets.zero,
            style: AppTextStyle.appDescription(
                color: AppColor.primaryColor,
                size: isTablet ? 20 : AppFontSize.small),
          ),
        ],
      ),
    );
  }
}

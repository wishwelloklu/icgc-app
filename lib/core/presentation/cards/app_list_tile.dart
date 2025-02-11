import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.title,
    this.trailing,
    this.subTitle,
    this.leading,
    this.onTap,
  });

  final String? title;
  final Widget? trailing;
  final Widget? leading;
  final String? subTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final double verticalPadding = isTablet ? 10 : 5;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: leading != null
            ? EdgeInsets.only(
                left: 10,
                right: 16,
                top: verticalPadding,
                bottom: verticalPadding)
            : null,
        leading: leading,
        title: Row(
          children: [
            if (title != null)
              TitleText(
                text: title!,
                textAlign: TextAlign.left,
                fontSize:
                    isTablet ? AppFontSize.labelLarge : AppFontSize.labelMedium,
              ),
            if (trailing != null) Expanded(child: trailing!)
          ],
        ),
        subtitle: subTitle != null
            ? DescriptionText(
                text: subTitle!,
                fontSize:
                    isTablet ? AppFontSize.labelMedium : AppFontSize.small,
              )
            : null,
      ),
    );
  }
}

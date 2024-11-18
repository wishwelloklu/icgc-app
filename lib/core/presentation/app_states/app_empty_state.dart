import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/utils/svg_icon.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class AppEmptyStateWidget extends StatelessWidget {
  const AppEmptyStateWidget({
    super.key,
    required this.title,
    required this.text,
    this.icon,
  });

  final String title;
  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ??
        SvgIcon(icon: AppImages.emptyState),
        const Gap(10),
        TitleText(text: title),
        DescriptionText(text: text),
      ],
    );
  }
}

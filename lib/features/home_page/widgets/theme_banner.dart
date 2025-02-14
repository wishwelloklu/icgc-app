import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/theme/data/models/theme_model.dart';

class ThemeBanner extends StatelessWidget {
  const ThemeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final imageSize = isTablet
        ? isPortrait
            ? height * .08
            : height * .15
        : height * .08;
    final imageWidth = isTablet
        ? isPortrait
            ? width * .15
            : width * .15
        : width * .2;
    final theme = ThemeModel.themesMock[0];
    return InkWell(
      onTap: () =>
          routeNavigator(context, AppRoutes.themeDetails, arguments: theme),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: [
              AppColor.primaryColor.withValues(alpha: .2),
              AppColor.primaryColor,
            ])),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: .2,
                        color: AppColor.primaryColor,
                      )
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        theme.imageUrl,
                        height: imageSize,
                        width: imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          text: '${theme.theme} - ${theme.year}',
                          fontSize: isTablet ? 23 : 18,
                          color: Colors.white,
                          maxLine: 2,
                          textAlign: TextAlign.start,
                        ),
                        const Gap(2),
                        DescriptionText(
                          text: theme.declaration,
                          fontSize: isTablet ? 20 : 15,
                          color: Colors.white,
                          maxLine: 2,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
            const Gap(16),
          ],
        ),
      ),
    );
  }
}

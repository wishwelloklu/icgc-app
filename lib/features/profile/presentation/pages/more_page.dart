// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_font_size.dart';
import '../../../../app/theme/app_images.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/utils/screen_size.dart';
import '../../../../app/utils/svg_icon.dart';
import '../../../../core/presentation/text/title_text.dart';
import '../widgets/logout_dialog.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final double iconSize = isTablet ? 30 : 24;
    return Scaffold(
      backgroundColor: AppColor.pageBorder,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.whiteColor,
              ),
              child: Row(
                children: [
                  ClipOval(
                      child: Image.asset(
                    AppImages.profileDummy,
                    scale: 1.5,
                  )),
                  const Gap(10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(text: 'Victor Odame'),
                        Gap(5),
                        TitleText(
                          text: '233245668887',
                          color: AppColor.descriptionColor,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, size: iconSize)
                ],
              ),
            ),
            const Gap(20),
            MoreTile(
              icon: SvgIcon(
                icon: AppImages.library,
                color: AppColor.primaryColor,
                size: iconSize,
              ),
              text: AppString.library,
              trailing: Icons.keyboard_arrow_right,
              onTap: () => routeNavigator(context, AppRoutes.library),
            ),
            const Gap(10),
            MoreTile(
              onTap: () => routeNavigator(context, AppRoutes.notifications),
              icon: SvgIcon(
                size: iconSize,
                icon: AppImages.bell,
                color: AppColor.primaryColor,
              ),
              text: AppString.notification,
              trailing: Icons.keyboard_arrow_right,
            ),

            // const Gap(10),
            // MoreTile(
            //   icon: Icon(
            //     Icons.lock_outline,
            //     color: AppColor.primaryColor,
            //     size: iconSize,
            //   ),
            //   text: AppString.security,
            //   trailing: Icons.keyboard_arrow_right,
            //   onTap: () {},
            // ),
            const Gap(10),
            MoreTile(
              icon: Icon(
                FontAwesomeIcons.questionCircle,
                color: AppColor.primaryColor,
                size: iconSize,
              ),
              text: AppString.help,
              trailing: Icons.keyboard_arrow_right,
              onTap: () {},
            ),
            const Gap(50),
            MoreTile(
              onTap: () {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return LogoutDialog(
                          onLogout: () =>
                              routeAndRemoveNavigator(context, AppRoutes.login),
                          onCancle: () => popBack(context));
                    });
              },
              icon: Icon(
                Icons.logout,
                color: AppColor.redColor,
                size: iconSize,
              ),
              text: AppString.logout,
              trailing: null,
            ),
          ],
        ),
      ),
    );
  }
}

class MoreTile extends StatelessWidget {
  const MoreTile({
    super.key,
    required this.onTap,
    required this.icon,
    this.trailing,
    required this.text,
  });

  final VoidCallback onTap;
  final Widget icon;
  final IconData? trailing;
  final String text;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final double tileVerticalPadding = isTablet ? AppFontSize.titleMedium : 0;
    final double tileHorizontalPadding = isTablet ? 23 : 16;
    final double iconSize = isTablet ? 35 : 24;
    final double tileTextSize = isTablet ? 23 : AppFontSize.labelMedium;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        vertical: tileVerticalPadding,
        horizontal: tileHorizontalPadding,
      ),
      tileColor: AppColor.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: icon,
      title: TitleText(
        text: text,
        textAlign: TextAlign.left,
        fontSize: tileTextSize,
      ),
      trailing: Icon(
        trailing,
        size: iconSize,
      ),
    );
  }
}

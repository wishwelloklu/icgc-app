import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/svg_icon.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/profile/presentation/widgets/row_card.dart';

import '../widgets/logout_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const cards = [
      RowCard(icon: AppImages.book, lable: AppString.totalBooks, text: '148'),
      RowCard(icon: AppImages.timer, lable: AppString.duration, text: '23h'),
      RowCard(
          icon: AppImages.checkCircle, lable: AppString.completed, text: '12'),
    ];
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
                  const Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
            const Gap(10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: cards,
            ),
            const Gap(20),
            ListTile(
              tileColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const SvgIcon(
                icon: AppImages.bell,
                color: AppColor.primaryColor,
              ),
              title: const TitleText(
                text: AppString.notification,
                textAlign: TextAlign.left,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            ListTile(
              tileColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const Icon(
                FontAwesomeIcons.creditCard,
                color: AppColor.primaryColor,
              ),
              title: const TitleText(
                text: AppString.subscription,
                textAlign: TextAlign.left,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            ListTile(
              tileColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const Icon(
                Icons.lock_outline,
                color: AppColor.primaryColor,
              ),
              title: const TitleText(
                text: AppString.security,
                textAlign: TextAlign.left,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(10),
            ListTile(
              tileColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const Icon(
                FontAwesomeIcons.questionCircle,
                color: AppColor.primaryColor,
              ),
              title: const TitleText(
                text: AppString.help,
                textAlign: TextAlign.left,
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            const Gap(50),
            ListTile(
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
              tileColor: AppColor.whiteColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const Icon(
                Icons.logout,
                color: AppColor.redColor,
              ),
              title: const TitleText(
                text: AppString.logout,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

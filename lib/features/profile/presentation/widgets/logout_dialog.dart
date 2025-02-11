import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/utils/screen_size.dart';
import '../../../../core/presentation/buttons/app_primary_button.dart';
import '../../../../core/presentation/buttons/app_text_button.dart';
import '../../../../core/presentation/text/description_text.dart';
import '../../../../core/presentation/text/title_text.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog(
      {super.key, required this.onCancle, required this.onLogout});
  final VoidCallback onCancle;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width *
              (isTablet
                  ? isPortrait
                      ? .6
                      : .5
                  : .8),
          // margin: EdgeInsets.symmetric(horizontal:  ? 40 : 20),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColor.whiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleText(
                text: AppString.logoutTitle,
                fontSize: 20,
              ),
              const Gap(10),
              const DescriptionText(
                text: AppString.logoutMessage,
                textAlign: TextAlign.center,
                fontSize: 15,
              ),
              const Gap(20),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                        child: AppTextButton(
                      text: AppString.cancel,
                      onPressed: onCancle,
                      backgroundColor: AppColor.grey.withOpacity(.3),
                      color: AppColor.blackColor,
                    )),
                    const Gap(16),
                    Expanded(
                        child: PrimaryButton(
                      text: AppString.logout,
                      onPressed: onLogout,
                      backgroundColor: AppColor.redColor,
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_font_size.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/theme/app_text_style.dart';
import '../../../../core/presentation/buttons/app_primary_button.dart';
import '../../../../core/presentation/text/title_text.dart';
import '../../../../core/presentation/text_field/phone_text_field.dart';

class LoginPhonePage extends StatefulWidget {
  const LoginPhonePage({super.key});

  @override
  State<LoginPhonePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPhonePage> {
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper(context).determineTabletScreenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: screenSize == DeviceScreenSize.medium ? 100 : 25),
          children: [
            const Gap(10),
            const TitleText(
              text: AppString.welcome,
              maxLine: 10,
              fontSize: AppFontSize.titleLarge,
            ),
            const Gap(10),
            Text(
              AppString.loginSubTitle,
              style: AppTextStyle.appDescription(
                  size: AppFontSize.medium, color: AppColor.subTextColor),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            PhoneTextField(
              controller: phoneController,
              labelText: AppString.phoneNumber,
              hintText: AppString.phoneNumberHint,
            ),
            const Gap(32),
            PrimaryButton(
              text: AppString.login,
              onPressed: () => routeAndRemoveNavigator(
                context,
                AppRoutes.otpPage,
              ),
            ),
            // const Gap(56),
            // Center(
            //   child: Text.rich(TextSpan(
            //     children: [
            //       TextSpan(
            //         text: AppString.alreadyHasAccount,
            //         style: AppTextStyle.appDescription(
            //             color: const Color(0xFF8A98AC),
            //             size: AppFontSize.small),
            //       ),
            //       TextSpan(
            //           text: AppString.signUp,
            //           style: AppTextStyle.appHeader(
            //               color: AppColor.primaryColor,
            //               size: AppFontSize.small),
            //           recognizer: TapGestureRecognizer()
            //             ..onTap =
            //                 () => routeNavigator(context, AppRoutes.signup))
            //     ],
            //   )),
            // )
          ],
        ),
      ),
    );
  }
}

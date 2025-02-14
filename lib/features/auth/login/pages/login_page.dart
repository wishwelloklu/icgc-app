import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_font_size.dart';
import '../../../../app/theme/app_images.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/theme/app_text_style.dart';
import '../../../../app/utils/screen_size.dart';
import '../../../../core/presentation/buttons/app_icon_button.dart';
import '../../../../core/presentation/buttons/app_primary_button.dart';
import '../../../../core/presentation/text/title_text.dart';
import '../../../../core/presentation/text_field/input_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailnameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: isTablet
                  ? isPortrait
                      ? width * .1
                      : width * .2
                  : 25),
          children: [
            const Gap(10),
            TitleText(
              text: AppString.welcome,
              maxLine: 10,
              fontSize:
                  isTablet ? AppFontSize.headLineLarge : AppFontSize.titleLarge,
            ),
            const Gap(10),
            Text(
              AppString.loginSubTitle,
              style: AppTextStyle.appDescription(
                  size: isTablet ? AppFontSize.normal : AppFontSize.medium,
                  color: AppColor.subTextColor),
              textAlign: TextAlign.center,
            ),
            const Gap(22),
            const Gap(20),
            InputTextField(
              controller: emailnameController,
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
            const Gap(56),
            AppIconButton(
              text: AppString.signInWithPhoneNumber,
              onPressed: () =>
                  routeNavigator(context, AppRoutes.loginWithPhone),
              imageIcon: AppImages.keypad,
              height: 48,
            ),
            const Gap(56),
            Center(
              child: Text.rich(TextSpan(
                children: [
                  TextSpan(
                    text: AppString.alreadyHasAccount,
                    style: AppTextStyle.appDescription(
                        color: const Color(0xFF8A98AC),
                        size: AppFontSize.small),
                  ),
                  TextSpan(
                      text: AppString.signUp,
                      style: AppTextStyle.appHeader(
                          color: AppColor.primaryColor,
                          size: AppFontSize.small),
                      recognizer: TapGestureRecognizer()
                        ..onTap =
                            () => routeNavigator(context, AppRoutes.signup))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/presentation/buttons/app_primary_button.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/core/presentation/text_field/input_text_field.dart';
import 'package:icgc/core/presentation/text_field/password_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailnameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pageBackground,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            const Gap(10),
            const TitleText(
              text: AppString.createAccount,
              maxLine: 10,
              fontSize: AppFontSize.titleLarge,
            ),
            const Gap(10),
            Text(
              AppString.signupSubTitle,
              style: AppTextStyle.appDescription(
                size: AppFontSize.medium,
                color: AppColor.subTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(22),
            Row(
              children: [
                Expanded(
                    child: InputTextField(
                  labelText: AppString.firstName,
                  hintText: AppString.firstNameHint,
                  controller: fnameController,
                )),
                const Gap(10),
                Expanded(
                    child: InputTextField(
                  labelText: AppString.lastName,
                  hintText: AppString.lastNameHint,
                  controller: lnameController,
                )),
              ],
            ),
            const Gap(20),
            InputTextField(
              controller: emailnameController,
              isEmail: true,
              labelText: AppString.email,
              hintText: AppString.emailHint,
            ),
            const Gap(20),
            PasswordTextField(
              controller: passwordController,
              labelText: AppString.password,
              hintText: AppString.passwordHint,
            ),
            const Gap(32),
            PrimaryButton(
                text: AppString.createAccount,
                onPressed: () => routeAndRemoveNavigator(
                    context, AppRoutes.subscriptionPage)),
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
                      text: AppString.login,
                      style: AppTextStyle.appHeader(
                          color: AppColor.primaryColor,
                          size: AppFontSize.small),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () =>
                            routeAndRemoveNavigator(context, AppRoutes.login))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}

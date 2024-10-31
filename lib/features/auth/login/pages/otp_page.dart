import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_font_size.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/int_externsions.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/core/presentation/cards/border_card.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/header_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/auth/blocs/auth_bloc.dart';
import 'package:icgc/features/auth/blocs/auth_states.dart';

import '../../../../../app/theme/app_padding.dart';
import '../../../../../app/theme/app_spacer.dart';
import '../../../../core/presentation/text_field/pin_otp_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  final _countDownOver = ValueNotifier(false);
  FocusNode focusNode = FocusNode();
  String? phoneNumber;
  String? userId;
  String? email;
  int _countDown = 60;

  Timer? _timer;

  String obfuscateString(String input, bool isEmail) {
    if (email == null) {
      if (input.length <= 4) {
        return input;
      }
      return '*' * (input.length - 4) + input.substring(input.length - 4);
    } else {
      return '*' * (input.length - 7) + input.substring(input.length - 7);
    }
  }

  @override
  void initState() {
    _startCountDown();
    super.initState();
  }

  @override
  dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startCountDown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown > 0) {
        setState(() => _countDown--);
        if (_countDownOver.value) {
          _countDownOver.value = false;
        }
      } else {
        _countDownOver.value = true;
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      phoneNumber = arguments['phone'] as String?;
      userId = arguments['userId'] as String;
      email = arguments['email'] as String?;
    }

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        // routeAndRemoveNavigator(appContext ?? context, AppRoutes.walkthrough);
        // routeNavigator(appContext ?? context, AppRoutes.login);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: BlocConsumer<AuthBloc, AuthStates>(
            listener: (context, state) {},
            listenWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return GestureDetector(
                onTap: () => focusNode.unfocus(),
                child: Container(
                  color: AppColor.pageBackground,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.normal),
                    children: [
                      AppSpacer.verticalSpace(),
                      Image.asset(
                        AppImages.logoIcon,
                        scale: 2,
                        height: 200,
                        color: AppColor.primaryColor,
                      ),
                      const HeaderText(
                        text: AppString.verifyOtp,
                        textAlign: TextAlign.center,
                      ),
                      AppSpacer.verticalSpace(height: AppPadding.small),
                      const DescriptionText(
                        text: AppString.enterThe6DigitCode,
                        fontSize: AppFontSize.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                      DescriptionText(
                        text: obfuscateString(
                            email ?? '0234556668', email != null),
                        fontSize: AppFontSize.labelMedium,
                        textAlign: TextAlign.center,
                        color: AppColor.tertiaryColor,
                      ),
                      AppSpacer.verticalSpace(),
                      BorderContainerCard(
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: PinOrOTPTextField(
                                pinController: pinController,
                                focusNode: focusNode,
                                onCompleted: (pin) {
                                  routeAndRemoveNavigator(
                                      context, AppRoutes.subscriptionPage);
                                },
                              ),
                            ),
                            // AppSpacer.verticalSpace(),
                            // PrimaryButton(
                            //     text: AppString.verify,
                            //     onPressed: () {
                            //       if (formKey.currentState?.validate() ?? false) {
                            //         context.read<AuthBloc>().add(VerifyOtpEvent(
                            //               otp: pinController.text,
                            //               userId: userId!,
                            //               isEmailVerification: email != null,
                            //             ));
                            //       }
                            //     }),
                            AppSpacer.verticalSpace(),
                            ValueListenableBuilder(
                                valueListenable: _countDownOver,
                                builder: (context, countDownOver, child) {
                                  return Column(
                                    children: [
                                      AnimatedOpacity(
                                          opacity: countDownOver ? 0 : 1,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: AnimatedSize(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              curve: Curves.easeInOut,
                                              child: SizedBox(
                                                height: countDownOver ? 0 : 20,
                                                child: TitleText(
                                                    text: _countDown
                                                        .countDownDuration()),
                                              ))),
                                      AppTextButton(
                                        text: AppString.ididntReceiveCode,
                                        onPressed: countDownOver ? () {} : null,
                                      ),
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}

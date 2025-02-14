import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/route_navigator.dart';
import 'app/theme/app_color.dart';
import 'app/theme/app_font_size.dart';
import 'app/theme/app_images.dart';
import 'app/theme/app_string.dart';
import 'app/utils/screen_size.dart';
import 'app/utils/svg_icon.dart';
import 'core/presentation/buttons/app_primary_button.dart';
import 'core/presentation/buttons/app_text_button.dart';
import 'core/presentation/text/title_text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  int _selectIndex = 0;
  final walkThroughImages = <String>[
    AppImages.walkthroughOne,
    AppImages.walkthroughTwo,
    AppImages.walkthroughThree,
  ];
  final walkThroughText = <String>[
    AppString.walkthroughOneText,
    AppString.walkthroughTwoText,
    AppString.walkthroughThreeText,
  ];
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final width = MediaQuery.sizeOf(context).width;
    final double dotSize = isTablet ? 15 : 8;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(110),
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) => setState(() => _selectIndex = value),
                itemCount: walkThroughImages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TitleText(
                          text: walkThroughText[index],
                          maxLine: 10,
                          fontSize: isTablet
                              ? AppFontSize.titleLarge
                              : AppFontSize.titleMedium,
                        ),
                      ),
                      const Gap(32),
                      Expanded(
                        child: SvgIcon(
                          icon: walkThroughImages[index],
                          size: isTablet ? 500 : null,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Gap(32),
            AnimatedSmoothIndicator(
              activeIndex: _selectIndex,
              count: walkThroughImages.length,
              effect: WormEffect(
                  dotWidth: dotSize,
                  dotHeight: dotSize,
                  spacing: 19,
                  activeDotColor: AppColor.secondaryColor,
                  dotColor: AppColor.grey),
            ),
            const Gap(32),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet
                      ? isPortrait
                          ? width * .1
                          : width * .2
                      : 40),
              child: Column(
                children: [
                  PrimaryButton(
                    text: AppString.login,
                    onPressed: () => routeNavigator(
                      context,
                      AppRoutes.loginWithPhone,
                    ),
                  ),
                  const Gap(10),
                  AppTextButton(
                    text: AppString.getStarted,
                    onPressed: () => routeNavigator(
                      context,
                      AppRoutes.signup,
                    ),
                    width: double.infinity,
                    backgroundColor: const Color.fromARGB(45, 33, 70, 54),
                  ),
                ],
              ),
            ),
            const Gap(110),
          ],
        ),
      ),
    );
  }
}

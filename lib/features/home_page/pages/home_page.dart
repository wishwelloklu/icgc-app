import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/config/constant_config.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/features/home_page/pages/top_policy.dart';
import 'package:icgc/features/home_page/widgets/theme_banner.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_images.dart';
import '../../../app/utils/svg_icon.dart';
import '../../../core/presentation/text/title_text.dart';
import 'event_slider.dart';
import 'top_manual.dart';
import 'top_sermons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = ScreenSizeHelper(context).isTablet;
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            titleSpacing: 12,
            expandedHeight: kToolbarHeight * 1.7,
            toolbarHeight: kToolbarHeight * 2,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.zero,
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        const TitleText(
                          text: ConstantConfig.appName,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        Text(
                          'Hello Victor',
                          style: AppTextStyle.appTitle(
                            size: 25,
                            fontFamily: ConstantConfig.playfairDisplay,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryColor.withOpacity(.05)),
                      child: IconButton(
                          onPressed: () {
                            routeNavigator(context, AppRoutes.notifications);
                          },
                          icon: const SvgIcon(icon: AppImages.bell)),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          children: [
            const EventSlider(),
            Gap(isTablet ? 30 : 20),
            const ThemeBanner(),
            Gap(isTablet ? 30 : 20),
            const TopManual(),
            Gap(isTablet ? 30 : 0),
            const TopSermons(),
            Gap(isTablet ? 30 : 20),
            const TopPolicy()
          ],
        ),
      )),
    );
  }
}

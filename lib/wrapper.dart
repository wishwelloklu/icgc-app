// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/data/bloc/nav_bar_bloc/nav_bar_bloc.dart';
import 'package:icgc/core/data/bloc/nav_bar_bloc/nav_bar_event.dart';
import 'package:icgc/core/data/bloc/nav_bar_bloc/nav_bar_states.dart';
import 'package:icgc/core/presentation/nav/side_menu.dart';

import 'package:icgc/features/profile/presentation/pages/more_page.dart';

import 'app/theme/app_color.dart';
import 'app/theme/app_font_size.dart';
import 'app/theme/app_images.dart';
import 'app/theme/app_text_style.dart';
import 'app/utils/screen_size.dart';
import 'app/utils/svg_icon.dart';
import 'features/declaration/pages/declaration.dart';
import 'features/home_page/pages/home_page.dart';
import 'features/manual/pages/manuals_page.dart';
import 'features/sermons/pages/sermons.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final double iconSize = isTablet ? 35 : 20;
    final pages = <Widget>[
      const HomePage(),
      const ManualsPage(),
      const Sermons(),
      const Declaration(),
      const More(),
    ];
    return BlocBuilder<NavBarBloc, NavBarStates>(builder: (context, state) {
      final index = state.index;
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: isTablet && !isPortrait
            ? SideMenu(
                currentIndex: index,
                pages: pages,
                child: Expanded(child: pages[index]),
              )
            : pages[index],
        bottomNavigationBar: isPortrait
            ? BottomNavigationBar(
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                type: BottomNavigationBarType.fixed,
                useLegacyColorScheme: false,
                selectedLabelStyle: AppTextStyle.navBarLable(
                  fontWeight: FontWeight.w500,
                  color: AppColor.primaryColor,
                  size: isTablet ? AppFontSize.labelSmall : 12,
                ),
                unselectedLabelStyle: AppTextStyle.navBarLable(
                  fontWeight: FontWeight.w400,
                  color: AppColor.blackColor,
                  size: isTablet ? AppFontSize.labelSmall : 12,
                ),
                backgroundColor: AppColor.pageBackground,
                unselectedItemColor: AppColor.blackColor,
                // showUnselectedLabels: true,
                onTap: (index) {
                  context.read<NavBarBloc>().add(NavBarEvent(index));
                },
                currentIndex: index,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgIcon(
                      icon: AppImages.homeLight,
                      size: iconSize,
                      color: AppColor.secondaryColor,
                    ),
                    activeIcon: SvgIcon(
                      icon: AppImages.homeBold,
                      size: iconSize + 3,
                      color: AppColor.primaryColor,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgIcon(
                      icon: AppImages.booksLight,
                      size: iconSize,
                      color: AppColor.secondaryColor,
                    ),
                    activeIcon: SvgIcon(
                      icon: AppImages.booksBold,
                      size: iconSize + 3,
                      color: AppColor.primaryColor,
                    ),
                    label: AppString.manual,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgIcon(
                      icon: AppImages.sermonsLight,
                      size: iconSize,
                      color: AppColor.secondaryColor,
                    ),
                    activeIcon: SvgIcon(
                      icon: AppImages.sermonsBold,
                      size: iconSize + 3,
                      color: AppColor.primaryColor,
                    ),
                    label: AppString.sermons,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgIcon(
                      icon: AppImages.declarationLight,
                      size: iconSize,
                      color: AppColor.secondaryColor,
                    ),
                    activeIcon: SvgIcon(
                      icon: AppImages.declarationBold,
                      size: iconSize + 3,
                      color: AppColor.primaryColor,
                    ),
                    label: "Declaration",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgIcon(
                      icon: AppImages.moreLight,
                      size: iconSize,
                      color: AppColor.secondaryColor,
                    ),
                    activeIcon: SvgIcon(
                      icon: AppImages.moreBold,
                      size: iconSize + 3,
                      color: AppColor.primaryColor,
                    ),
                    label: "More",
                  ),
                ],
              )
            : null,
      );
    });
  }
}

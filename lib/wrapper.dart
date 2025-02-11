// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_string.dart';
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

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<Wrapper> {
  final _currentIndex = ValueNotifier(0);

  final _pages = <Widget>[
    const HomePage(),
    const ManualsPage(),
    const Sermons(),
    const Declaration(),
    const More(),
  ];

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final double iconSize = isTablet ? 35 : 20;

    return ValueListenableBuilder(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: isTablet && !isPortrait
                ? SideMenu(
                    currentIndex: currentIndex,
                    pages: _pages,
                    onTap: (index) {
                      _currentIndex.value = index;
                    },
                    child: Expanded(child: _pages[currentIndex]),
                  )
                : _pages[currentIndex],
            bottomNavigationBar: isPortrait
                ? BottomNavigationBar(
                    landscapeLayout:
                        BottomNavigationBarLandscapeLayout.centered,
                    type: BottomNavigationBarType.fixed,

                    useLegacyColorScheme: false,
                    selectedIconTheme:
                        const IconThemeData(color: AppColor.primaryColor),
                    selectedLabelStyle: AppTextStyle.navBarLable(
                      fontWeight: FontWeight.w600,
                      color: AppColor.primaryColor,
                      size: isTablet ? AppFontSize.labelSmall : 10,
                    ),
                    unselectedLabelStyle: AppTextStyle.navBarLable(
                      fontWeight: FontWeight.w400,
                      color: AppColor.subTextColor,
                      size: isTablet ? AppFontSize.labelSmall : 10,
                    ),
                    backgroundColor: AppColor.pageBackground,
                    unselectedItemColor: AppColor.subTextColor,
                    // showUnselectedLabels: true,
                    onTap: (index) {
                      _currentIndex.value = index;
                    },
                    currentIndex: currentIndex,
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgIcon(
                          icon: AppImages.home,
                          size: iconSize,
                          color: AppColor.secondaryColor,
                        ),
                        activeIcon: SvgIcon(
                          icon: AppImages.home,
                          size: iconSize,
                          color: AppColor.primaryColor,
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: SvgIcon(
                          icon: AppImages.books,
                          size: iconSize,
                          color: AppColor.secondaryColor,
                        ),
                        activeIcon: SvgIcon(
                          icon: AppImages.books,
                          size: iconSize,
                          color: AppColor.primaryColor,
                        ),
                        label: AppString.manual,
                      ),
                      BottomNavigationBarItem(
                        icon: SvgIcon(
                          icon: AppImages.sermons,
                          size: iconSize,
                          color: AppColor.secondaryColor,
                        ),
                        activeIcon: SvgIcon(
                          icon: AppImages.sermons,
                          size: iconSize,
                          color: AppColor.primaryColor,
                        ),
                        label: AppString.sermons,
                      ),
                      BottomNavigationBarItem(
                        icon: SvgIcon(
                          icon: AppImages.declaration,
                          size: iconSize,
                          color: AppColor.secondaryColor,
                        ),
                        activeIcon: SvgIcon(
                          icon: AppImages.declaration,
                          size: iconSize,
                          color: AppColor.primaryColor,
                        ),
                        label: "Declaration",
                      ),
                      BottomNavigationBarItem(
                        icon: SvgIcon(
                          icon: AppImages.more,
                          size: iconSize,
                          color: AppColor.secondaryColor,
                        ),
                        activeIcon: SvgIcon(
                          icon: AppImages.more,
                          size: iconSize,
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

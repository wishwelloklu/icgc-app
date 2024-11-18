import 'package:flutter/material.dart';
import 'app/theme/app_color.dart';
import 'app/theme/app_font_size.dart';
import 'app/theme/app_images.dart';
import 'app/theme/app_text_style.dart';
import 'app/utils/svg_icon.dart';
import 'features/manual/pages/manuals_page.dart';
import 'features/home_page/pages/home_page.dart';
import 'features/library/presentation/pages/library_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<Wrapper> {
  int currentIndex = 0;

  final _pages = <Widget>[
    const HomePage(),
    const ManualsPage(),
    const LibraryPage(),
    const ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        selectedFontSize: AppFontSize.labelMedium,
        iconSize: AppFontSize.labelMedium,
        selectedItemColor: AppColor.primaryColor,
        selectedIconTheme: const IconThemeData(color: AppColor.primaryColor),
        unselectedFontSize: AppFontSize.labelMedium,
        selectedLabelStyle: AppTextStyle.navBarLable(),
        unselectedLabelStyle: AppTextStyle.navBarLable(
            fontWeight: FontWeight.w400, color: AppColor.subTextColor),
        backgroundColor: AppColor.pageBackground,
        unselectedItemColor: AppColor.subTextColor,
        showUnselectedLabels: true,
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: SvgIcon(icon: AppImages.home, size: 20),
            activeIcon: SvgIcon(
              icon: AppImages.home,
              size: 20,
              color: AppColor.primaryColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: AppImages.books, size: 20),
            activeIcon: SvgIcon(
              icon: AppImages.books,
              size: 20,
              color: AppColor.primaryColor,
            ),
            label: "Manuals",
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: AppImages.library, size: 20),
            activeIcon: SvgIcon(
              icon: AppImages.library,
              size: 20,
              color: AppColor.primaryColor,
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: SvgIcon(icon: AppImages.profile, size: 20),
            activeIcon: SvgIcon(
              icon: AppImages.profile,
              size: 20,
              color: AppColor.primaryColor,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

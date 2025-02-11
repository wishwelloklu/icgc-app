import 'package:flutter/material.dart';

import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/tab_bar_page.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../theme/pages/themes.dart';

class Declaration extends StatefulWidget {
  const Declaration({super.key});

  @override
  State<Declaration> createState() => _DeclarationState();
}

class _DeclarationState extends State<Declaration>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const Tab(text: AppString.theme),
    const Tab(text: AppString.prayer),
    const Tab(text: AppString.others),
  ];

  final pages = [
    const Themes(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: pages.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    return Scaffold(
      appBar: AppBar(
        title: isTablet
            ? isPortrait
                ? TitleText(
                    text: AppString.declaration,
                    fontSize: isTablet
                        ? AppFontSize.titleLarge
                        : AppFontSize.labelMedium,
                  )
                : null
            : const TitleText(
                text: AppString.declaration,
                fontSize: AppFontSize.labelMedium,
              ),
        toolbarHeight: kToolbarHeight *
            (isTablet
                ? isPortrait
                    ? 2
                    : 1
                : 1),
        bottom: TabBar(
          labelStyle: isTablet ? AppTextStyle.appTitle(size: 25) : null,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          labelPadding:
              EdgeInsets.only(bottom: isTablet ? 15 : kTabLabelPadding.bottom),
          tabs: _tabs,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: isTablet
                ? isPortrait
                    ? 25
                    : 10
                : 10),
        child: TabBarPage(tabController: _tabController, pages: pages),
      ),
    );
  }
}

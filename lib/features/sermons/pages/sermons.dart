import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_text_style.dart';
import '../../../core/presentation/tab_bar_page.dart';
import 'officiates_list.dart';
import 'sermon_sample.dart';

class Sermons extends StatefulWidget {
  const Sermons({super.key});

  @override
  State<Sermons> createState() => _SermonsState();
}

class _SermonsState extends State<Sermons> with TickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const Tab(text: AppString.samples),
    const Tab(text: AppString.officiate),
  ];

  final pages = [
    const SermonSample(),
    const OfficiatesList(),
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
      backgroundColor: AppColor.pageBackground,
      appBar: AppBar(
        title: isTablet
            ? isPortrait
                ? TitleText(
                    text: AppString.sermons,
                    fontSize: isTablet
                        ? AppFontSize.titleLarge
                        : AppFontSize.labelMedium,
                  )
                : null
            : const TitleText(
                text: AppString.sermons,
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
        padding: const EdgeInsets.all(16),
        child: TabBarPage(tabController: _tabController, pages: pages),
      ),
    );
  }
}

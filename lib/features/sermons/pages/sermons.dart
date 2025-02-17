import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/screen_size.dart';

import '../../../app/theme/app_text_style.dart';
import '../../../core/presentation/tab_bar_page.dart';
import 'sermon_list.dart';
import 'sample_sermon.dart';

class Sermons extends StatefulWidget {
  const Sermons({super.key});

  @override
  State<Sermons> createState() => _SermonsState();
}

class _SermonsState extends State<Sermons> with TickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = [
    const Tab(text: AppString.samples),
    const Tab(text: AppString.mySermons),
  ];

  final pages = [
    const SampleSermon(),
    const SermonList(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: pages.length, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    return Scaffold(
      backgroundColor: AppColor.pageBackground,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * .5,
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

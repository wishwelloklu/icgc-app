import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import 'package:icgc/core/presentation/tab_bar_page.dart';
import 'package:icgc/features/manual/data/bloc/manual_page_event.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_font_size.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/generic_modal_sheet.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../library/data/models/collections.dart';
import '../data/bloc/manual_page_bloc.dart';
import 'manual_list.dart';
import 'officiate_page.dart';
import '../../policy/pages/policies_page.dart';

import '../widgets/officiate_modal.dart';

class ManualsPage extends StatefulWidget {
  const ManualsPage({super.key});

  @override
  State<ManualsPage> createState() => _ManualsPageState();
}

class _ManualsPageState extends State<ManualsPage>
    with TickerProviderStateMixin {
  final int _selectedIndex = 0;
  late TabController _tabController;
  final _tabs = [
    const Tab(text: 'Manuals'),
    const Tab(text: 'Policies'),
    const Tab(text: 'Officiate'),
  ];
  final pages = [
    const ManualList(),
    const PoliciesPage(),
    const OfficiatePage(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<ManualPageBloc>().state;
      _tabController.animateTo(state.index);
      context.read<ManualPageBloc>().add(ManualPageEvent(0));
    });
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
                    text: AppString.manual,
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
        padding: EdgeInsets.only(top: isTablet ? 25 : 10),
        child: TabBarPage(tabController: _tabController, pages: pages),
      ),
      floatingActionButton: _selectedIndex == 2
          ? BlocBuilder<NamingBloc, NamingStates>(builder: (context, state) {
              switch (state) {
                case AllNamingLoadedState():
                  if (state.namings.isNotEmpty) {
                    return FloatingActionButton(
                      onPressed: () {
                        showGenericModalSheet(
                          child: OfficiateModal(
                            onTap: (String id) {
                              popBack(context);
                              if (id == '1') {
                                routeNavigator(context, AppRoutes.officiateList,
                                    arguments: OfficiatingType.namingList);
                              }
                            },
                          ),
                          context: context,
                        );
                      },
                      backgroundColor: AppColor.primaryColor,
                      child: const Icon(
                        Icons.add,
                        color: AppColor.whiteColor,
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                default:
                  return const SizedBox.shrink();
              }
            })
          : null,
    );
  }
}

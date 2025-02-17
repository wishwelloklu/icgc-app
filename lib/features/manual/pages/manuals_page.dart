import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import 'package:icgc/core/presentation/tab_bar_page.dart';
import 'package:icgc/features/manual/data/bloc/manual_page_event.dart';
import 'package:icgc/features/others/pages/others.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/utils/generic_modal_sheet.dart';
import '../../../app/utils/screen_size.dart';
import '../../library/data/models/collections.dart';
import '../data/bloc/manual_page_bloc.dart';
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
  int _selectedIndex = 0;
  late TabController _tabController;
  final _tabs = [
    const Tab(text: 'Officiate'),
    const Tab(text: 'Policies'),
    const Tab(text: 'Others'),
  ];
  final pages = [
    const OfficiatePage(),
    // const ManualList(),
    const PoliciesPage(),
    const Others()

  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        _selectedIndex = _tabController.index;
        setState(() {});
      });
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
    return Scaffold(
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

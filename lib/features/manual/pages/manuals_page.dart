import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/generic_modal_sheet.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../library/data/models/collections.dart';
import 'manual_list.dart';
import 'officiate_page.dart';
import 'policies_page.dart';

import '../widgets/officiate_modal.dart';

class ManualsPage extends StatefulWidget {
  const ManualsPage({super.key});

  @override
  State<ManualsPage> createState() => _ManualsPageState();
}

class _ManualsPageState extends State<ManualsPage>
    with TickerProviderStateMixin {
  late ValueNotifier<Widget> _isShowSearchPage;
  final _isShowCancelButton = ValueNotifier<bool>(false);

  int _selectedIndex = 0;
  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
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
    _isShowSearchPage =
        ValueNotifier(TabBarPage(tabController: _tabController, pages: pages));
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
      _isShowSearchPage.value =
          TabBarPage(tabController: _tabController, pages: pages);
      _isShowCancelButton.value = false;
      _focusNode.unfocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(text: AppString.manual),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
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

class TabBarPage extends StatelessWidget {
  const TabBarPage({
    super.key,
    required TabController tabController,
    required this.pages,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<StatefulWidget> pages;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: pages,
    );
  }
}

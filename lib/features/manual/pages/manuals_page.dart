import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/generic_modal_sheet.dart';
import '../../../core/presentation/animated_widget.dart';
import '../../../core/presentation/buttons/app_text_button.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../../core/presentation/text_field/search_text_field.dart';
import '../../library/data/models/collections.dart';
import 'manual_list.dart';
import 'officiate_page.dart';
import 'policies_page.dart';
import 'search_page.dart';

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
      body: ValueListenableBuilder(
        valueListenable: _isShowSearchPage,
        builder: (context, showShearcPage, child) {
          return SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                      SliverAppBar(
                          titleSpacing: 12,
                          pinned: true,
                          expandedHeight:
                              _selectedIndex != 2 ? kToolbarHeight * 3.5 : null,
                          toolbarHeight: kToolbarHeight * 2,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(80),
                              const TitleText(text: AppString.manual),
                              const Gap(20),
                              TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                controller: _tabController,
                                tabs: _tabs,
                              ),
                              const Gap(70),
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: true,
                            background: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppAnimatedWidget(
                                      child:
                                          Gap(_selectedIndex != 2 ? 112 : 0)),
                                  Expanded(
                                    child: AppAnimatedWidget(
                                      opacity: _selectedIndex != 2 ? 1 : 0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SearchTextField(
                                              controller:
                                                  TextEditingController(),
                                              focusNode: _focusNode,
                                              borderColor:
                                                  AppColor.textInputFieldBorder,
                                              onTap: () {
                                                _isShowSearchPage.value =
                                                    const SearchPage();
                                                _isShowCancelButton.value =
                                                    true;
                                              },
                                            ),
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable:
                                                  _isShowCancelButton,
                                              builder:
                                                  (context, showButton, child) {
                                                return AppAnimatedWidget(
                                                    opacity: showButton ? 1 : 0,
                                                    child: SizedBox(
                                                      width:
                                                          showButton ? null : 0,
                                                      child: AppTextButton(
                                                          text:
                                                              AppString.cancel,
                                                          onPressed: () {
                                                            _isShowSearchPage
                                                                    .value =
                                                                TabBarPage(
                                                                    tabController:
                                                                        _tabController,
                                                                    pages:
                                                                        pages);
                                                            _focusNode
                                                                .unfocus();
                                                            _isShowCancelButton
                                                                .value = false;
                                                          }),
                                                    ));
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                body: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: showShearcPage)),
          );
        },
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

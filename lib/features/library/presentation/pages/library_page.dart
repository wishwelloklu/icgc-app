import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/core/presentation/animated_widget.dart';
import 'package:icgc/core/presentation/buttons/app_text_button.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/core/presentation/text_field/search_text_field.dart';
import 'package:icgc/features/manual/pages/search_page.dart';
import 'package:icgc/features/library/presentation/pages/add_notes.dart';
import 'package:icgc/features/library/presentation/pages/articles.dart';

import 'books.dart';
import 'notes_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _ManualsPageState();
}

class _ManualsPageState extends State<LibraryPage>
    with TickerProviderStateMixin {
  final _isShowSearchPage = ValueNotifier(false);
  int _selectedIndex = 0;
  late TabController _tabController;
  final FocusNode _focusNode = FocusNode();
  final _tabs = [
    const Tab(text: 'Articles'),
    const Tab(text: 'Books'),
    const Tab(text: 'Notes'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Articles(),
      const Books(),
      const NotesPage(),
    ];
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
                  expandedHeight: kToolbarHeight * 3.5,
                  toolbarHeight: kToolbarHeight * 2,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(80),
                      const TitleText(text: AppString.library),
                      const Gap(20),
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                        tabs: _tabs,
                        onTap: (value) =>
                            setState(() => _selectedIndex = value),
                      ),
                      const Gap(70),
                    ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(120),
                          Row(
                            children: [
                              Expanded(
                                child: SearchTextField(
                                  controller: TextEditingController(),
                                  focusNode: _focusNode,
                                  borderColor: AppColor.textInputFieldBorder,
                                  onTap: () {
                                    _isShowSearchPage.value = true;
                                  },
                                ),
                              ),
                              AppAnimatedWidget(
                                opacity: showShearcPage ? 1 : 0,
                                child: showShearcPage
                                    ? AppTextButton(
                                        text: AppString.cancel,
                                        onPressed: () {
                                          _isShowSearchPage.value = false;
                                          _focusNode.unfocus();
                                        })
                                    : const SizedBox.shrink(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              body: showShearcPage
                  ? AppAnimatedWidget(
                      duration: const Duration(seconds: 5),
                      opacity: showShearcPage ? 1 : 0,
                      child: const SearchPage())
                  : AppAnimatedWidget(
                      duration: const Duration(seconds: 5),
                      opacity: showShearcPage ? 0 : 1,
                      child: TabBarView(
                        controller: _tabController,
                        children: pages,
                      )),
            ),
          );
        },
      ),
      floatingActionButton: _selectedIndex == 2
          ? FloatingActionButton(
              onPressed: () {
                showGenericModalSheet(
                  child: const AddNotes(),
                  context: context,
                );
              },
              backgroundColor: AppColor.primaryColor,
              child: const Icon(
                Icons.add,
                color: AppColor.whiteColor,
              ),
            )
          : null,
    );
  }
}

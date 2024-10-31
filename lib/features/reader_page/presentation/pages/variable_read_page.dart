import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/custom_text.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/app/utils/naming_custome_text.dart';
import 'package:icgc/core/data/bloc/naming/naming_bloc.dart';
import 'package:icgc/core/data/bloc/naming/naming_states.dart';
import 'package:icgc/core/presentation/animated_widget.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/manual/data/models/naming_ceremoney_variable.dart';
import 'package:icgc/features/manual/data/models/read_model.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/reader_page/presentation/widgets/font_modal.dart';

import '../bloc/font_bloc.dart';

class VariableReadPage extends StatefulWidget {
  const VariableReadPage({super.key});

  @override
  State<VariableReadPage> createState() => _ReadJsonState();
}

class _ReadJsonState extends State<VariableReadPage> {
  int percentage = 0;
  int totalPage = 0;
  int currentPage = 1;
  String title = '';
  Color? coverColor;
  final _showOtherWidgets = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final namingModel =
        ModalRoute.settingsOf(context)!.arguments as NamingCeremoneyVariable;
    return BlocBuilder<FontBloc, FontStates>(builder: (context, state) {
      switch (state) {
        case FontState():
          return ValueListenableBuilder(
              valueListenable: _showOtherWidgets,
              builder: (context, showOtherWidgets, child) {
                return GestureDetector(
                  onTap: () =>
                      _showOtherWidgets.value = !_showOtherWidgets.value,
                  child: BlocBuilder<NamingBloc, NamingStates>(
                      builder: (context, namingState) {
                    switch (namingState) {
                      case NamingLoadedState():
                        final book = namingState.book;
                        return Scaffold(
                          key: const ValueKey(2),
                          body: SafeArea(
                            child: Stack(
                              children: [
                                PageView.builder(
                                  itemCount: book.pages.length,
                                  onPageChanged: (value) {
                                    percentage =
                                        (value / book.pages.length * 100)
                                            .round();
                                    currentPage = value + 1;
                                    setState(() {});
                                  },
                                  itemBuilder: (context, index) {
                                    if (book.pages[index].title != null) {
                                      title = book.pages[index].title!;
                                    }
                                    return SingleChildScrollView(
                                      child: AppAnimatedWidget(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  showOtherWidgets ? 78 : 0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              NamingCustomeText(
                                                book.pages[index].content,
                                                state.fontSize,
                                                father: namingModel.father,
                                                child: namingModel.child,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: AppAnimatedWidget(
                                    opacity: showOtherWidgets ? 1 : 0,
                                    child: Container(
                                      height: showOtherWidgets ? null : 0,
                                      color: const Color.fromARGB(
                                          229, 254, 254, 254),
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TitleText(text: title),
                                          IconButton(
                                            onPressed: () {
                                              showGenericModalSheet(
                                                  removeDrop: true,
                                                  showHanlde: false,
                                                  isDismissible: true,
                                                  child: const FontModal(),
                                                  context: context);
                                            },
                                            icon: const Icon(
                                                FontAwesomeIcons.ellipsisV),
                                            iconSize: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: AppAnimatedWidget(
                                    opacity: showOtherWidgets ? 1 : 0,
                                    child: Container(
                                      height: showOtherWidgets ? null : 0,
                                      color: const Color.fromARGB(
                                          246, 254, 254, 254),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              const DescriptionText(
                                                  text: AppString.page,
                                                  fontSize: 12),
                                              DescriptionText(
                                                  text:
                                                      ' ${currentPage.toString()} of ',
                                                  fontSize: 12),
                                              DescriptionText(
                                                  text: book.pages.length
                                                      .toString(),
                                                  fontSize: 12),
                                              const Spacer(),
                                              DescriptionText(
                                                  text: '$percentage%',
                                                  fontSize: 12),
                                            ],
                                          ),
                                          const Gap(5),
                                          // LinearProgressIndicator(
                                          //   value: currentPage / totalPage,
                                          //   valueColor:
                                          //       const AlwaysStoppedAnimation(
                                          //           AppColor.yellow),
                                          //   backgroundColor:
                                          //       const Color(0xFFE5E7EB),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );

                      default:
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                    }
                  }),
                );
              });

        default:
          return const SizedBox.shrink();
      }
    });
  }
}

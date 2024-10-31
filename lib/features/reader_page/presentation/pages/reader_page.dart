import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/custom_text.dart';
import 'package:icgc/app/utils/generic_modal_sheet.dart';
import 'package:icgc/core/presentation/animated_widget.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/manual/data/models/read_model.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/reader_page/presentation/widgets/font_modal.dart';

import '../bloc/font_bloc.dart';

class ReaderPage extends StatefulWidget {
  const ReaderPage({super.key});

  @override
  State<ReaderPage> createState() => _ReadJsonState();
}

class _ReadJsonState extends State<ReaderPage> {
  int percentage = 0;
  int totalPage = 0;
  int currentPage = 1;
  String title = '';
  Color? coverColor;
  final _showCover = ValueNotifier(true);
  final _showOtherWidgets = ValueNotifier(true);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final readModel = ModalRoute.settingsOf(context)!.arguments as ReadModel;
      title = readModel.book.pages[0].title!;
      coverColor = readModel.color;
      setState(() {});
    });

    Future.delayed(const Duration(seconds: 2)).then((value) {
      _showCover.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final readModel = ModalRoute.settingsOf(context)!.arguments as ReadModel;
    final book = readModel.book;
    totalPage = book.pages.length;
    return BlocBuilder<FontBloc, FontStates>(builder: (context, state) {
      switch (state) {
        case FontState():
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: ValueListenableBuilder(
              valueListenable: _showCover,
              builder: (context, showCover, child) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  layoutBuilder: showCover
                      ? (currentChild, previousChildren) {
                          return Scaffold(
                            key: const ValueKey(1),
                            backgroundColor: readModel.color.withOpacity(1),
                            body: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 20,
                                  offset: const Offset(0, 10), // Deeper shadow
                                ),
                              ]),
                              child: Image.asset(
                                book.coverImageUrl,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          );
                        }
                      : AnimatedSwitcher.defaultLayoutBuilder,
                  child: !showCover
                      ? ValueListenableBuilder(
                          valueListenable: _showOtherWidgets,
                          builder: (context, showOtherWidgets, child) {
                            return GestureDetector(
                              onTap: () => _showOtherWidgets.value =
                                  !_showOtherWidgets.value,
                              child: Scaffold(
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
                                                    vertical: showOtherWidgets
                                                        ? 78
                                                        : 0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    CustomeText(
                                                        book.pages[index]
                                                            .content,
                                                        state.fontSize),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TitleText(text: title),
                                                IconButton(
                                                  onPressed: () {
                                                    showGenericModalSheet(
                                                        removeDrop: true,
                                                        showHanlde: false,
                                                        isDismissible: true,
                                                        child:
                                                            const FontModal(),
                                                        context: context);
                                                  },
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .ellipsisV),
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
                                                LinearProgressIndicator(
                                                  value:
                                                      currentPage / totalPage,
                                                  valueColor:
                                                      const AlwaysStoppedAnimation(
                                                          AppColor.yellow),
                                                  backgroundColor:
                                                      const Color(0xFFE5E7EB),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : null,
                );

                // if (showCover) {
                //   return Scaffold(
                //     key: const ValueKey(1),
                //     backgroundColor: coverColor?.withOpacity(1),
                //     body: Container(
                //       decoration: BoxDecoration(boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.2),
                //           spreadRadius: 3,
                //           blurRadius: 20,
                //           offset: const Offset(0, 10), // Deeper shadow
                //         ),
                //       ]),
                //       child: Image.asset(
                //         book.coverImageUrl,
                //         width: double.infinity,
                //         height: double.infinity,
                //       ),
                //     ),
                //   );

                // }
                // return Scaffold(
                //   key: const ValueKey(2),
                //   appBar: AppBar(
                //     automaticallyImplyLeading: false,
                //     title: TitleText(text: title),
                //     actions: [
                //       IconButton(
                //         onPressed: () {
                //           showGenericModalSheet(
                //               removeDrop: true,
                //               showHanlde: false,
                //               child: const FontModal(),
                //               context: context);
                //         },
                //         icon: const Icon(FontAwesomeIcons.ellipsisV),
                //         iconSize: 20,
                //       )
                //     ],
                //   ),
                //   body: PageView.builder(
                //     itemCount: book.pages.length,
                //     onPageChanged: (value) {
                //       percentage = (value / book.pages.length * 100).round();
                //       currentPage = value + 1;
                //       setState(() {});
                //     },
                //     itemBuilder: (context, index) {
                //       if (book.pages[index].title != null) {
                //         title = book.pages[index].title!;
                //       }
                //       return SingleChildScrollView(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 10),
                //           child: Column(
                //             children: [
                //               BoldText(
                //                   book.pages[index].content, state.fontSize),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                //   bottomSheet: Container(
                //     margin: const EdgeInsets.only(bottom: 40),
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Row(
                //           children: [
                //             const DescriptionText(
                //                 text: AppString.page, fontSize: 12),
                //             DescriptionText(
                //                 text: ' ${currentPage.toString()} of ',
                //                 fontSize: 12),
                //             DescriptionText(
                //                 text: book.pages.length.toString(),
                //                 fontSize: 12),
                //             const Spacer(),
                //             DescriptionText(text: '$percentage%', fontSize: 12),
                //           ],
                //         ),
                //         const Gap(5),
                //         LinearProgressIndicator(
                //           value: book.currentPage / book.totalPage,
                //           valueColor:
                //               const AlwaysStoppedAnimation(AppColor.yellow),
                //           backgroundColor: const Color(0xFFE5E7EB),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
          );

        default:
          return const SizedBox.shrink();
      }
    });
  }
}

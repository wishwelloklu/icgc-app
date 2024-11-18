import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/features/reader_page/presentation/pages/search_book_page.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../app/theme/app_images.dart';
import '../../../../app/theme/app_string.dart';
import '../../../../app/utils/custom_text.dart';
import '../../../../app/utils/generic_modal_sheet.dart';
import '../../../../app/utils/svg_icon.dart';
import '../../../../core/presentation/animated_widget.dart';
import '../../../../core/presentation/text/description_text.dart';
import '../../../../core/presentation/text/title_text.dart';
import '../../../manual/data/models/read_model.dart';
import '../bloc/font_states.dart';
import '../widgets/font_modal.dart';

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
  String _searchText = '';
  Color? coverColor;
  final _showCover = ValueNotifier(true);
  final _showOtherWidgets = ValueNotifier(true);
  PageController _pageController = PageController();
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final readModel = ModalRoute.settingsOf(context)!.arguments as ReadModel;

      title = readModel.book.pages[readModel.currentPage].title ?? '';
      coverColor = readModel.color;
      _pageController = PageController(initialPage: readModel.currentPage);
      percentage = (1 / readModel.book.pages.length * 100).round();
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
                                readModel.image ?? book.coverImageUrl,
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
                                          controller: _pageController,
                                          itemCount: book.pages.length,
                                          onPageChanged: (value) {
                                            percentage = ((value + 1) /
                                                    book.pages.length *
                                                    100)
                                                .round();
                                            currentPage = value + 1;
                                            _searchText = '';
                                            setState(() {});
                                          },
                                          itemBuilder: (context, index) {
                                            if (book.pages[index].title !=
                                                null) {
                                              title = book.pages[index].title!;
                                            }
                                            return SingleChildScrollView(
                                              controller: _scrollController,
                                              child: Column(
                                                children: [
                                                  const Gap(10),
                                                  TitleText(
                                                      text: book.pages[index]
                                                              .title ??
                                                          title),
                                                  const Gap(10),
                                                  AppAnimatedWidget(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: showOtherWidgets
                                                              ? 0
                                                              : 0,
                                                          bottom:
                                                              showOtherWidgets
                                                                  ? 60
                                                                  : 0),
                                                      child: Column(
                                                        children: [
                                                          Builder(builder:
                                                              (context) {
                                                            return CustomeText(
                                                              book.pages[index]
                                                                  .content,
                                                              state.fontSize,
                                                              searchText:
                                                                  _searchText,
                                                              fontName: state
                                                                  .fontName,
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                              height:
                                                  showOtherWidgets ? null : 0,
                                              color: const Color.fromARGB(
                                                  239, 255, 255, 255),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 10, 10, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () =>
                                                          popBack(context),
                                                      icon: const Icon(
                                                          Icons.arrow_back)),
                                                  Expanded(
                                                      child: TitleText(
                                                    text: book.title,
                                                    fontSize: 20,
                                                    maxLine: 1,
                                                  )),
                                                  const Gap(5),
                                                  Row(
                                                    children: [
                                                      TopButtons(
                                                          onTap: () {
                                                            showGenericModalSheet(
                                                                removeDrop:
                                                                    true,
                                                                showHanlde:
                                                                    false,
                                                                isDismissible:
                                                                    true,
                                                                child:
                                                                    const FontModal(),
                                                                context:
                                                                    context);
                                                          },
                                                          icon: const SvgIcon(
                                                            icon:
                                                                AppImages.font,
                                                            size: 20,
                                                          )),
                                                      const Gap(2),
                                                      TopButtons(
                                                        onTap: () {
                                                          showGenericModalSheet(
                                                              removeDrop: true,
                                                              showHanlde: false,
                                                              isDismissible:
                                                                  true,
                                                              isScrollControlled:
                                                                  false,
                                                              child:
                                                                  SearchBookPage(
                                                                      pages: book
                                                                          .pages,
                                                                      onResult:
                                                                          (index,
                                                                              resultTerm) {
                                                                        popBack(
                                                                            context);
                                                                        setState(
                                                                            () {
                                                                          _searchText =
                                                                              resultTerm;
                                                                        });
                                                                        _pageController.animateToPage(
                                                                            index,
                                                                            duration:
                                                                                Durations.medium2,
                                                                            curve: Curves.linear);
                                                                      }),
                                                              context: context);
                                                        },
                                                        icon: const SvgIcon(
                                                          icon:
                                                              AppImages.search,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      const Gap(2),
                                                      TopButtons(
                                                        onTap: () {},
                                                        icon: const Icon(
                                                          FontAwesomeIcons
                                                              .ellipsisH,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
                                              height:
                                                  showOtherWidgets ? null : 0,
                                              color: const Color.fromARGB(
                                                  246, 254, 254, 254),
                                              padding: const EdgeInsets.all(16),
                                              child: ReaderProgress(
                                                  currentPage: currentPage,
                                                  book: book,
                                                  percentage: percentage,
                                                  totalPage: totalPage),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  floatingActionButton: _scrollController
                                          .hasClients
                                      ? _scrollController.offset + 100 == 0.0
                                          ? IconButton(
                                              onPressed: () {
                                                _scrollController.jumpTo(
                                                    _scrollController.position
                                                        .maxScrollExtent);
                                              },
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                            )
                                          : null
                                      : null,
                                ));
                          })
                      : null,
                );
              },
            ),
          );

        default:
          return const SizedBox.shrink();
      }
    });
  }
}

class TopButtons extends StatelessWidget {
  const TopButtons({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color.fromARGB(15, 0, 0, 0)),
          child: icon),
    );
  }
}

class ReaderProgress extends StatefulWidget {
  const ReaderProgress({
    super.key,
    required this.currentPage,
    required this.book,
    required this.percentage,
    required this.totalPage,
  });

  final int currentPage;
  final BookModel book;
  final int percentage;
  final int totalPage;

  @override
  State<ReaderProgress> createState() => _ReaderProgressState();
}

class _ReaderProgressState extends State<ReaderProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _progress = 0;
  // initial progress value
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((duration) {
    //   Future.delayed(const Duration(milliseconds: 200)).then((_) {
    _progress = widget.currentPage / widget.totalPage;
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // animation duration
    );

    // Define the animation with the AnimationController
    _animation = Tween<double>(begin: _progress).animate(_controller)
      ..addListener(() {});

    // Start the initial animation
    _controller.forward();
    // });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateProgress(double newProgress) {
    // Update the animation to the new progress value
    setState(() {
      _progress = newProgress;
      _animation = Tween<double>(begin: _animation.value, end: newProgress)
          .animate(_controller)
        ..addListener(() {
          setState(() {});
        });

      _controller.forward(from: 0.0); // Restart the animation
    });
  }

  @override
  Widget build(BuildContext context) {
    updateProgress(widget.currentPage / widget.totalPage);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const DescriptionText(text: AppString.page, fontSize: 12),
            DescriptionText(
                text: ' ${widget.currentPage.toString()} of ', fontSize: 12),
            DescriptionText(
                text: widget.book.pages.length.toString(), fontSize: 12),
            const Spacer(),
            DescriptionText(text: '${widget.percentage}%', fontSize: 12),
          ],
        ),
        const Gap(5),
        LinearProgressIndicator(
          minHeight: 7,
          borderRadius: BorderRadius.circular(8),
          value: _animation.value,
          valueColor: const AlwaysStoppedAnimation(AppColor.yellow),
          backgroundColor: const Color(0xFFE5E7EB),
        ),
      ],
    );
  }
}

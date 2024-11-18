import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/config/navigation_key.dart';
import 'package:icgc/features/reader_page/presentation/pages/reader_page.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/theme/app_images.dart';
import '../../../../app/utils/generic_modal_sheet.dart';
import '../../../../app/utils/naming_custome_text.dart';
import '../../../../app/utils/svg_icon.dart';
import '../../../../core/data/bloc/naming/naming_bloc.dart';
import '../../../../core/data/bloc/naming/naming_events.dart';
import '../../../../core/data/bloc/naming/naming_states.dart';
import '../../../../core/presentation/animated_widget.dart';
import '../../../manual/data/models/naming_ceremoney_variable.dart';
import '../bloc/font_states.dart';
import '../widgets/font_modal.dart';

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
  void dispose() {
    appContext?.read<NamingBloc>().add(LoadAllNamingEvent());
    super.dispose();
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
                                        ((value + 1) / book.pages.length * 100)
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
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            children: [
                                              NamingCustomeText(
                                                book.pages[index].content,
                                                state.fontSize,
                                                father: namingModel.father,
                                                child: namingModel.child,
                                                parent:
                                                    '${namingModel.mother} and ${namingModel.father}',
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
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<NamingBloc>()
                                                    .add(LoadAllNamingEvent());
                                                popBack(context);
                                              },
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_left)),
                                          const Spacer(),
                                          Row(
                                            children: [
                                              DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        15, 0, 0, 0)),
                                                child: IconButton(
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
                                                      FontAwesomeIcons.font),
                                                  iconSize: 15,
                                                ),
                                              ),
                                              const Gap(2),
                                              DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        15, 0, 0, 0)),
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const SvgIcon(
                                                      icon: AppImages.search),
                                                  iconSize: 20,
                                                ),
                                              ),
                                              const Gap(2),
                                              DecoratedBox(
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color.fromARGB(
                                                        15, 0, 0, 0)),
                                                child: IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                      FontAwesomeIcons
                                                          .ellipsisH),
                                                  iconSize: 20,
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
                                      height: showOtherWidgets ? null : 0,
                                      color: const Color.fromARGB(
                                          246, 254, 254, 254),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ReaderProgress(
                                              currentPage: currentPage,
                                              book: book,
                                              percentage: percentage,
                                              totalPage: book.pages.length)
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

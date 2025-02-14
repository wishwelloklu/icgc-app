import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/date_time.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_states.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';
import 'package:icgc/features/sermons/data/models/tag.dart';
import 'package:icgc/features/sermons/widgets/tag_widget.dart';

import '../../../app/utils/screen_size.dart';
import '../data/bloc/officiate_bloc/sermon_bloc.dart';
import '../data/bloc/officiate_bloc/sermon_events.dart';

class TagList extends StatelessWidget {
  TagList(this.sermon, {super.key});
  final SermonModel sermon;

  final _maxLines = ValueNotifier<int>(3);

  final _expandedIndex = ValueNotifier<int>(-1);
  List<Tag> tags = [];

  // late AnimationController _animationController;
  void _expand(int index) {
    // _animationController.forward();
    _expandedIndex.value = index;
    _maxLines.value = 100;
  }

  void _collapse() {
    // _animationController.reverse();
    _expandedIndex.value = -1;
    _maxLines.value = 3;
  }

  bool hasTextOverflow({
    required String text,
    required TextStyle style,
    required double maxWidth,
    required int? maxLines,
  }) {
    final TextSpan span = TextSpan(text: text, style: style);
    final TextPainter tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
    tp.layout(minWidth: 0, maxWidth: maxWidth);
    return tp.didExceedMaxLines;
  }

  @override
  Widget build(BuildContext context) {
    tags = sermon.tags ?? [];
    var isTablet = ScreenSizeHelper(context).isTablet;
    return BlocBuilder<SermonBloc, SermonStates>(builder: (context, state) {
      return ValueListenableBuilder(
          valueListenable: _maxLines,
          builder: (context, maxLine, _) {
            return ValueListenableBuilder(
                valueListenable: _expandedIndex,
                builder: (context, expandedIndex, _) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration:
                        const BoxDecoration(color: AppColor.pageBackground),
                    child: tags.isNotEmpty
                        ? ListView.separated(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 20, left: 16, right: 16),
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: tags.length,
                            separatorBuilder: (context, index) => const Gap(10),
                            itemBuilder: (context, index) {
                              final tag = tags[index];
                              final isExpanded =
                                  (index == expandedIndex && maxLine > 3);
                              return LayoutBuilder(
                                  builder: (context, constraints) {
                                return Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 10,
                                                color:
                                                    Color.fromARGB(14, 0, 0, 0))
                                          ]),
                                      child: Builder(builder: (context) {
                                        return AnimatedSize(
                                          duration: Durations.medium1,
                                          // height: isExpanded ? null : 100,

                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (tag.name != null)
                                                TitleText(
                                                  text: tag.name!,
                                                  fontSize:
                                                      isTablet ? 25 : null,
                                                ),
                                              if (tag.description != null)
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      WidgetSpan(
                                                          child: SizedBox(
                                                        width: constraints
                                                                .maxWidth -
                                                            (constraints
                                                                    .maxWidth *
                                                                (isTablet
                                                                    ? isExpanded
                                                                        ? .05
                                                                        : .2
                                                                    : .3)),
                                                        child: DescriptionText(
                                                          text:
                                                              tag.description!,
                                                          maxLine: index ==
                                                                  expandedIndex
                                                              ? maxLine
                                                              : 3,
                                                          fontSize: isTablet
                                                              ? 20
                                                              : null,
                                                        ),
                                                      )),
                                                      if (hasTextOverflow(
                                                        maxLines: 3,
                                                        text: tag.description!,
                                                        style: AppTextStyle
                                                            .appDescription(),
                                                        maxWidth: constraints
                                                            .maxWidth,
                                                      ))
                                                        WidgetSpan(
                                                          child:
                                                              GestureDetector(
                                                            onTap: () =>
                                                                isExpanded
                                                                    ? _collapse()
                                                                    : _expand(
                                                                        index),
                                                            child: Text(
                                                              isExpanded
                                                                  ? 'Read Less'
                                                                  : 'Read More',
                                                              style: AppTextStyle
                                                                  .appDescription(
                                                                      size: isTablet
                                                                          ? 20
                                                                          : null,
                                                                      color: AppColor
                                                                          .primaryColor),
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              // DescriptionText(
                                              //   text: tag.description!,
                                              //   maxLine: 2,
                                              // ),
                                              SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      if (tag.date != null)
                                                        TagWidget(
                                                          avatar: const Icon(
                                                            Icons
                                                                .calendar_month_sharp,
                                                            color: AppColor
                                                                .primaryColor,
                                                          ),
                                                          tag: tag.date!
                                                              .formattedDate,
                                                          color: AppColor
                                                              .primaryColor,
                                                          background:
                                                              const Color
                                                                  .fromARGB(37,
                                                                  33, 70, 54),
                                                        ),
                                                      if (tag.place != null &&
                                                          tag.place!
                                                              .isNotEmpty) ...[
                                                        const Gap(10),
                                                        TagWidget(
                                                          tag: tag.place!,
                                                          color:
                                                              AppColor.redColor,
                                                          background:
                                                              const Color
                                                                  .fromARGB(69,
                                                                  244, 70, 54),
                                                        ),
                                                      ],
                                                      if (tag.time != null) ...[
                                                        const Gap(10),
                                                        TagWidget(
                                                          tag: tag.time!,
                                                          avatar: const Icon(
                                                            Icons.alarm,
                                                            color: Colors
                                                                .deepPurpleAccent,
                                                          ),
                                                          color: Colors
                                                              .deepPurpleAccent,
                                                          background:
                                                              const Color
                                                                  .fromARGB(63,
                                                                  124, 77, 255),
                                                        ),
                                                      ],
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        );
                                      }),
                                    ),
                                    Positioned(
                                        right: 15,
                                        top: 15,
                                        child: GestureDetector(
                                            onTapDown: (details) {
                                              final offset =
                                                  details.globalPosition;
                                              showMenu(
                                                context: context,
                                                position: RelativeRect.fromLTRB(
                                                    offset.dx,
                                                    offset.dy + 10,
                                                    offset.dx,
                                                    0),
                                                items: [
                                                  PopupMenuItem(
                                                      onTap: () async {
                                                        final value =
                                                            await routeNavigator(
                                                          context,
                                                          AppRoutes.newSermon,
                                                          arguments: tag,
                                                        );
                                                        if (context.mounted &&
                                                            value != null) {
                                                          final newValue =
                                                              value as Tag;
                                                          final newSermon =
                                                              sermon;

                                                          tags[index] =
                                                              newValue;
                                                          context
                                                              .read<
                                                                  SermonBloc>()
                                                              .add(UpdateSermon(
                                                                newSermon
                                                                    .copyWith(
                                                                        tags:
                                                                            tags),
                                                              ));
                                                        }
                                                      },
                                                      child:
                                                          const Text('Edit')),
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        tags.removeAt(index);
                                                        context
                                                            .read<SermonBloc>()
                                                            .add(UpdateSermon(
                                                              sermon.copyWith(
                                                                  tags: tags),
                                                            ));
                                                      },
                                                      child:
                                                          const Text('Delete')),
                                                ],
                                              );
                                            },
                                            child: const Icon(
                                              FontAwesomeIcons.ellipsisH,
                                              size: 20,
                                              weight: .1,
                                            )))
                                  ],
                                );
                              });
                            },
                          )
                        : const TitleText(text: 'No tag'),
                  );
                });
          });
    });
  }
}

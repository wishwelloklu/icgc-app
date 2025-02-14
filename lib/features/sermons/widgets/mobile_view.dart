import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/app/utils/date_time.dart';
import 'package:icgc/core/presentation/cards/elevated_container.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/sermons/data/models/sermon_detail_model.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';
import 'package:icgc/features/sermons/widgets/tag_widget.dart';

import 'sermon_cover.dart';

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.sermons,
    required this.width,
    required this.height,
  });

  final List<SermonModel> sermons;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: sermons.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Gap(20),
        itemBuilder: (context, index) {
          final sermon = sermons[index];
          if (sermon.tags?.isNotEmpty ?? false) {
            sermon.tags?.sort((a, b) {
              if (a.date != null && b.date != null) {
                return a.date!.compareTo(b.date!);
              }
              return -1;
            });
          }
          return ElevatedContainer(
            child: InkWell(
              onTap: () => routeNavigator(
                context,
                AppRoutes.sermonDetails,
                arguments: SermonDetailModel(
                  sermonModel: sermon,
                  showOption: true,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: width * .25,
                      height: height * .13,
                      child: SermonCover(
                        subTitle: sermon.subTitle,
                        title: sermon.title,
                        color: sermon.color?.color ?? generateColor.color,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          text: sermon.title,
                          fontSize: 18,
                          maxLine: 3,
                          textAlign: TextAlign.left,
                          // fontWeight: Fo,
                        ),
                        if (sermon.tags?.isNotEmpty ?? false)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (sermon.tags![0].date != null)
                                  TagWidget(
                                    tag: sermon.tags![0].date!.formattedDate,
                                    color: AppColor.primaryColor,
                                    background:
                                        const Color.fromARGB(37, 33, 70, 54),
                                  ),
                                if (sermon.tags![0].place != null) ...[
                                  const Gap(10),
                                  TagWidget(
                                    tag: sermon.tags![0].place!,
                                    color: AppColor.redColor,
                                    background:
                                        const Color.fromARGB(69, 244, 70, 54),
                                  ),
                                ],
                                if (sermon.tags![0].time != null) ...[
                                  const Gap(10),
                                  TagWidget(
                                    tag: sermon.tags![0].time!,
                                    avatar: const Icon(
                                      Icons.alarm,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    color: Colors.deepPurpleAccent,
                                    background:
                                        const Color.fromARGB(63, 124, 77, 255),
                                  ),
                                ],
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

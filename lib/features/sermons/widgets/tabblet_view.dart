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

class TabbletView extends StatelessWidget {
  const TabbletView({
    super.key,
    required this.sermons,
    required this.isPortrait,
    required this.height,
    required this.width,
  });

  final List<SermonModel> sermons;
  final bool isPortrait;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: sermons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: isPortrait ? height * .17 : height * .23,
        // childAspectRatio: 0.3,
        crossAxisSpacing: 20,
        mainAxisSpacing: isPortrait ? 20 : 20,
      ),
      itemBuilder: (context, index) {
        final sermon = sermons[index];
        return ElevatedContainer(
          gradient: LinearGradient(colors: [
            sermon.color!.color.withValues(alpha: 0),
            sermon.color!.color,
          ]),
          child: InkWell(
            onTap: () {
              routeNavigator(
                context,
                AppRoutes.sermonDetails,
                arguments: SermonDetailModel(
                  sermonModel: sermon,
                  showOption: true,
                ),
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: isPortrait ? width * .2 : width * .12,
                  height: isPortrait ? height * .15 : height * .2,
                  child: SermonCover(
                    title: sermon.title,
                    subTitle: sermon.subTitle,
                    color: sermon.color?.color ?? generateColor.color,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
      },
    );
  }
}

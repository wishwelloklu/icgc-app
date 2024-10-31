import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/app/utils/string_extension.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class NotesCard extends StatelessWidget {
  const NotesCard(
      {super.key,
      required this.time,
      required this.note,
      required this.title,
      required this.color});
  final String time;
  final String note;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColor.whiteColor,
          border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: TitleText(
                text: title.initial,
                fontSize: 30,
                color: AppColor.whiteColor,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: title),
                      Text(
                        note,
                        style: AppTextStyle.appDescription(
                          color: AppColor.descriptionColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const Spacer(),
                  Text(time, style: AppTextStyle.appDescription()),
                ],
              ),
            ),
          ],
        ));
  }
}

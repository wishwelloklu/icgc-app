import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/utils/string_extension.dart';
import '../../../core/presentation/text/title_text.dart';

class OfficiateCard extends StatelessWidget {
  const OfficiateCard(
      {super.key,
      required this.title,
      required this.color,
      required this.isCompleted});

  final String title;
  final Color color;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                textAlign: TextAlign.left,
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: title,
                    maxLine: 1,
                    textAlign: TextAlign.left,
                  ),
                  const Gap(2),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColor.primaryColor
                            : AppColor.yellow,
                        borderRadius: BorderRadius.circular(8)),
                    child: DescriptionText(
                      text: isCompleted ? 'Completed' : "Pending",
                      color: isCompleted ? Colors.white : Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

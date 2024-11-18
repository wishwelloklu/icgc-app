import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/theme/app_color.dart';
import '../../../core/presentation/text/description_text.dart';
import '../data/models/policy_model.dart';

import '../../../core/presentation/text/title_text.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({
    super.key,
    required this.book,
  });

  final PolicyModel book;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/policy_image.png',
              fit: BoxFit.fill,
              height: 120,
              width: 120,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(
                  text: book.title,
                  color: AppColor.bookTitleColor,
                  fontSize: 15,
                  textAlign: TextAlign.left,
                ),
                const Gap(5),
                const DescriptionText(
                  text: 'ICGC',
                  color: AppColor.subTextColor,
                  fontSize: 12,
                ),
                const Gap(5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColor.yellow,
                  ),
                  child: const TitleText(
                    text: '20 mins',
                    fontSize: 10,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/text/description_text.dart';
import '../../manual/data/models/policy_model.dart';

import '../../../core/presentation/text/title_text.dart';

class PolicyTile extends StatelessWidget {
  const PolicyTile({
    super.key,
    required this.book,
  });

  final PolicyModel book;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    // var isPortrait = ScreenSizeHelper(context).isPortrait;
    final double imageSize = isTablet ? 150 : 120;
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
              height: imageSize,
              width: imageSize,
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
                  fontSize: isTablet ? 18 : 14,
                  textAlign: TextAlign.left,
                  maxLine: 2,
                ),
                const Gap(5),
                DescriptionText(
                  text: 'ICGC',
                  color: AppColor.subTextColor,
                  fontSize: isTablet ? 16 : 12,
                ),
                const Gap(5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColor.yellow,
                  ),
                  child: TitleText(
                    text: '20 mins',
                    fontSize: isTablet ? 14 : 10,
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

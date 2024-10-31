import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/core/presentation/text/description_text.dart';

import '../../../core/presentation/text/title_text.dart';
import '../../home_page/widgets/view_all.dart';

class Trendings extends StatelessWidget {
  const Trendings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewAllTitle(
            onViewAll: () {},
            text: AppString.whatsTrending,
            horizontalPadding: 0),
        SizedBox(
          height: 200,
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: BookModel.trendingBookList.length,
              itemBuilder: (context, index) {
                final book = BookModel.trendingBookList[index];
                return Container(
                  width: 130,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          book.coverImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DescriptionText(
                                  text: book.title,
                                  color: AppColor.bookTitleColor,
                                  fontSize: 12,
                                ),
                                DescriptionText(
                                  text: book.author,
                                  color: AppColor.subTextColor,
                                  fontSize: 10,
                                ),
                                const Gap(5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: AppColor.secondaryColor,
                                  ),
                                  child: const TitleText(
                                    text: '20 mins',
                                    fontSize: 8,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.bookmark_border,
                              size: 15,
                              color: AppColor.primaryColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

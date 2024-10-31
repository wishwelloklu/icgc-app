import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_text_style.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/core/presentation/text/description_text.dart';

import '../../../../core/presentation/text/title_text.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              book.coverImageUrl,
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
                  fontSize: 18,
                ),
                const Gap(5),
                Text(
                  book.pages[0].content,
                  style: AppTextStyle.appDescription(),
                  maxLines: 2,
                ),
                const Gap(5),
                DescriptionText(
                  text: book.author,
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

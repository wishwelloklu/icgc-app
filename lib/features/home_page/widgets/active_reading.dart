import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

import '../../../core/data/models/book_model.dart';
import '../../../core/presentation/text/description_text.dart';

class ActiveBook extends StatelessWidget {
  const ActiveBook({
    super.key,
    required this.book,
    required this.onTap,
  });

  final BookModel book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final percentage = (book.currentPage / book.totalPage * 100).round();
    return Container(
      height: 143,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.lightColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(book.coverImageUrl),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(text: book.title, fontSize: 16),
                const Gap(5),
                DescriptionText(text: book.author, fontSize: 10),
                const Gap(5),
                Row(
                  children: [
                    const DescriptionText(text: AppString.page, fontSize: 12),
                    DescriptionText(
                        text: ' ${book.currentPage.toString()} of ',
                        fontSize: 12),
                    DescriptionText(
                        text: book.totalPage.toString(), fontSize: 12),
                    const Spacer(),
                    DescriptionText(text: '$percentage%', fontSize: 12),
                  ],
                ),
                const Gap(5),
                LinearProgressIndicator(
                  value: book.currentPage / book.totalPage,
                  valueColor: const AlwaysStoppedAnimation(AppColor.yellow),
                  backgroundColor: const Color(0xFFE5E7EB),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

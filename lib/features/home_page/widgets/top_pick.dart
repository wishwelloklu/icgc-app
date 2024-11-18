import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/theme/app_color.dart';
import '../../../core/data/models/book/book_model.dart';
import '../../../core/presentation/text/description_text.dart';
import '../../../core/presentation/text/title_text.dart';

class TopPick extends StatelessWidget {
  const TopPick({
    super.key,
    required this.book,
    required this.onTap,
  });
  final BookModel book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        height: 183,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(book.coverImageUrl),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: book.title,
                    color: AppColor.whiteColor,
                    textAlign: TextAlign.start,
                  ),
                  Expanded(
                    child: DescriptionText(
                      text: book.pages[0].content,
                      maxLine: 10,
                      fontSize: 10,
                      color: AppColor.whiteColor,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  DescriptionText(
                    text: book.author,
                    maxLine: 2,
                    fontSize: 10,
                    color: AppColor.whiteColor,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

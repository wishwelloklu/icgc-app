import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.images,
    required this.book,
    required this.onTap,
  });

  final String images;
  final BookModel book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper.determineTabletScreenSize(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenSize == TabletScreenSize.medium
            ? MediaQuery.sizeOf(context).width * .3
            : MediaQuery.sizeOf(context).width * .45,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                images,
                fit: BoxFit.cover,
                height: screenSize == TabletScreenSize.medium
                    ? MediaQuery.sizeOf(context).width * .4
                    : MediaQuery.sizeOf(context).width * .55,
                width: double.infinity,
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
                        maxLine: 2,
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
      ),
    );
  }
}

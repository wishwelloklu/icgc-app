import 'package:flutter/material.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/core/presentation/text/description_text.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.images,
    required this.book,
    required this.onTap,
    this.isExpaned = true,
    required this.width,
  });

  final String images;
  final BookModel book;
  final VoidCallback onTap;
  final bool isExpaned;
  final double width;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(images,
                  fit: BoxFit.fill,
                  height: isTablet
                      ? isPortrait
                          ? height * .25
                          : height * .4
                      : height * .25,
                  width: width),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionText(
                  text: book.title,
                  color: AppColor.bookTitleColor,
                  fontSize: isTablet ? 20 : 12,
                  maxLine: 2,
                ),
                DescriptionText(
                  text: book.author,
                  color: AppColor.subTextColor,
                  fontSize: isTablet ? 15 : 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

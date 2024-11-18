import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../app/theme/app_color.dart';
import '../../../../core/data/models/book/book_model.dart';
import '../../../../core/presentation/text/description_text.dart';
import '../../../../core/presentation/text/title_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: BookModel.trendingBookList.length,
        itemBuilder: (context, index) {
          final book = BookModel.trendingBookList[index];
          return Container(
            height: 143,
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
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
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.bookmark_border,
                          size: 24,
                          color: AppColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

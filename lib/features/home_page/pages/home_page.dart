import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/svg_icon.dart';
import 'package:icgc/core/data/models/book_model.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/home_page/widgets/active_reading.dart';
import 'package:icgc/features/home_page/widgets/top_pick.dart';
import 'package:icgc/features/home_page/widgets/view_all.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const Gap(50),
            Row(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(text: 'Hello Wishwell'),
                    DescriptionText(
                      text: 'What  do you want to read today?',
                      fontSize: 14,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor.withOpacity(.05)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const SvgIcon(icon: AppImages.bell)),
                )
              ],
            ),
            ViewAllTitle(onViewAll: () {}, text: AppString.continueReading),
            ActiveBook(
              onTap: () {},
              book: BookModel(
                title: "The Preacher's Portrait",
                description: "description",
                totalPage: 32,
                currentPage: 7,
                author: 'John Stott',
                coverImageUrl: AppImages.bookImage,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: TitleText(
                text: AppString.outTopPick,
                textAlign: TextAlign.left,
                fontSize: 14,
              ),
            ),
            TopPick(
              book: BookModel(
                title: "The Pastor: A Memoir",
                description:
                    "Embark on a transformative journey as Jacob unravels the secrets of her destiny, embracing her true potential amidst enchanting landscapes and mysterious encounters. ",
                totalPage: 32,
                currentPage: 7,
                author: 'John Stott',
                coverImageUrl: AppImages.topPickBookImage,
              ),
              onTap: () {},
            ),
            ViewAllTitle(onViewAll: () {}, text: AppString.whatsTrending),
            SizedBox(
              height: 143,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: BookModel.trendingBookList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.asset(
                            BookModel.trendingBookList[index].coverImageUrl),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}

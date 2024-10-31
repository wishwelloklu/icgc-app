import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/theme/app_images.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/svg_icon.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/core/data/models/book/pages.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/manual/widgets/trendings.dart';
import 'package:icgc/features/home_page/widgets/active_reading.dart';
import 'package:icgc/features/home_page/widgets/top_pick.dart';
import 'package:icgc/features/home_page/widgets/view_all.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              titleSpacing: 12,
              expandedHeight: kToolbarHeight * 1.5,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(30),
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
                ),
              ),
            )
          ],
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            children: [
              ViewAllTitle(
                onViewAll: () {},
                text: AppString.continueReading,
                isViewMore: false,
              ),
              ActiveBook(
                onTap: () {},
                book: BookModel(
                  title: "The Preacher's Portrait",
                  totalPage: 32,
                  currentPage: 7,
                  author: 'John Stott',
                  coverImageUrl: AppImages.bookImage,
                  pages: [
                    Pages(pageNumber: 1, content: ''),
                    Pages(pageNumber: 2, content: ''),
                  ],
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
                  totalPage: 32,
                  currentPage: 7,
                  author: 'John Stott',
                  coverImageUrl: AppImages.topPickBookImage,
                  pages: [
                    Pages(pageNumber: 1, content: ''),
                    Pages(pageNumber: 2, content: ''),
                  ],
                ),
                onTap: () {},
              ),
              const Trendings(),
            ],
          ),
        ),
      ),
    );
  }
}

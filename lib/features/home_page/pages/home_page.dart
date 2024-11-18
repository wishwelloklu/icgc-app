import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_color.dart';
import '../../../app/theme/app_images.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../app/utils/svg_icon.dart';
import '../../../core/data/bloc/book/book_bloc.dart';
import '../../../core/data/models/book/book_model.dart';
import '../../../core/data/models/book/pages.dart';
import '../../../core/presentation/text/description_text.dart';
import '../../../core/presentation/text/title_text.dart';
import '../../manual/data/bloc/policy_bloc/policy_bloc.dart';
import '../../manual/data/bloc/policy_bloc/policy_states.dart';
import '../../manual/data/models/read_model.dart';
import 'latest_books.dart';
import 'top_manual.dart';
import 'trendings.dart';
import '../widgets/active_reading.dart';
import '../widgets/top_pick.dart';
import '../widgets/view_all.dart';

import '../../../core/data/bloc/book/book_states.dart';

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
            expandedHeight: kToolbarHeight * 1.65,
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
                        TitleText(
                          text: 'Hello Wishwell',
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                        DescriptionText(
                          text: 'What  do you want to read today?',
                          fontSize: 15,
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
            const ViewAllTitle(
              text: AppString.continueReading,
              isViewMore: false,
            ),
            BlocBuilder<BookBloc, BookStates>(buildWhen: (previous, current) {
              return current is BookLoadedState ||
                  current is BookInitialState ||
                  current is BookProcessingState;
            }, builder: (context, state) {
              if (state is BookLoadedState) {
                return ActiveBook(
                  onTap: () async {
                    final color =
                        await getDominantColor(state.bookList[0].coverImageUrl);
                    routeNavigator(context, AppRoutes.continueReading,
                        arguments: ReadModel(
                            color: color!,
                            book: state.bookList[0],
                            currentPage: 7));
                  },
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
                );
              }
              return const Center(child: CircularProgressIndicator.adaptive());
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 16),
              child: TitleText(
                text: AppString.outTopPick,
                textAlign: TextAlign.left,
                fontSize: 14,
              ),
            ),
            BlocBuilder<PolicyBloc, PolicyStates>(builder: (context, state) {
              if (state is PolicyLoadedState) {
                return Column(
                  children: [
                    TopPick(
                      book: BookModel(
                        title: "The Pastor: A Memoir",
                        totalPage: 61,
                        currentPage: 3,
                        author: 'John Stott',
                        coverImageUrl: AppImages.topPickBookImage,
                        pages: [
                          Pages(pageNumber: 1, content: ''),
                          Pages(pageNumber: 2, content: ''),
                        ],
                      ),
                      onTap: () async {
                        final color = await getDominantColor(
                            'assets/images/policy_image.png');
                        routeNavigator(context, AppRoutes.readerPage,
                            arguments: ReadModel(
                              color: color!,
                              book: BookModel(
                                author: 'ICGC',
                                currentPage: 3,
                                totalPage: state.policyList.length,
                                coverImageUrl: 'assets/images/policy_image.png',
                                title: state.policyList[0].title,
                                pages: state.policyList
                                    .map((data) => Pages(
                                        content: data.title,
                                        title: data.title,
                                        pageNumber: data.totalPage))
                                    .toList(),
                              ),
                            ));
                      },
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
            BlocBuilder<BookBloc, BookStates>(buildWhen: (previous, current) {
              return current is BookLoadedState ||
                  current is BookInitialState ||
                  current is BookProcessingState;
            }, builder: (context, state) {
              if (state is BookLoadedState) {
                return TopManual(list: state.bookList);
              }
              return const SizedBox.shrink();
            }),
            LatestBook(),
            Trendings(),
          ],
        ),
      )),
    );
  }
}

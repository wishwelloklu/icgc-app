import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/manual/data/bloc/policy_bloc/policy_bloc.dart';
import 'package:icgc/features/manual/data/bloc/policy_bloc/policy_states.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../core/data/models/book/book_model.dart';
import '../../../core/data/models/book/pages.dart';
import '../../manual/data/models/read_model.dart';
import '../widgets/policy_card.dart';
import '../widgets/view_all.dart';

class TopPolicy extends StatelessWidget {
  const TopPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<PolicyBloc, PolicyStates>(
        buildWhen: (previous, current) {
      return current is PolicyLoadedState ||
          current is PolicyInitialState ||
          current is PolicyProcessingState;
    }, builder: (context, state) {
      if (state is PolicyLoadedState) {
        final list = state.policyList;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ViewAllTitle(
              onViewAll: () {},
              text: "Top policy manuals",
              horizontalPadding: 0,
            ),
            SizedBox(
              height: isTablet
                  ? isPortrait
                      ? height * .26
                      : height * .45
                  : height * .25,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    final book = list[index];

                    return GestureDetector(
                        onTap: () async {
                          final color = await getDominantColor(
                              'assets/images/policy_image.png');
                          routeNavigator(context, AppRoutes.readerPage,
                              arguments: ReadModel(
                                color: color!,
                                book: BookModel(
                                  author: 'ICGC',
                                  currentPage: 1,
                                  totalPage:
                                      state.policyList[index].pages.length,
                                  coverImageUrl:
                                      'assets/images/policy_image.png',
                                  title: state.policyList[index].title,
                                  pages: state.policyList[index].pages
                                      .map((data) => Pages(
                                          content: data.content,
                                          title: data.title,
                                          pageNumber: data.pageNumber))
                                      .toList(),
                                ),
                              ));
                        },
                        child: PolicyCard(book: book));
                  }),
            ),
          ],
        );
      }
      return SizedBox(
        height: isTablet
            ? isPortrait
                ? height * .3
                : height * .5
            : 300,
        child: const AppLoadingState(),
      );
    });
  }
}

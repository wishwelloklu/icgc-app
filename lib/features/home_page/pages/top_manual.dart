import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../core/data/bloc/book/book_bloc.dart';
import '../../../core/data/bloc/book/book_states.dart';
import '../../../core/data/bloc/nav_bar_bloc/nav_bar_bloc.dart';
import '../../../core/data/bloc/nav_bar_bloc/nav_bar_event.dart';
import '../../manual/data/models/read_model.dart';

import '../widgets/view_all.dart';
import '../widgets/book_card.dart';

class TopManual extends StatelessWidget {
  const TopManual({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<BookBloc, BookStates>(buildWhen: (previous, current) {
      return current is BookLoadedState ||
          current is BookInitialState ||
          current is BookProcessingState;
    }, builder: (context, state) {
      if (state is BookLoadedState) {
        final list = state.bookList;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ViewAllTitle(
              onViewAll: () => context.read<NavBarBloc>().add(NavBarEvent(1)),
              text: "Top officiating manuals",
              horizontalPadding: 0,
            ),
            SizedBox(
              height: isTablet
                  ? isPortrait
                      ? height * .3
                      : height * .47
                  : height * .3,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    final book = list[index];

                    return BookCard(
                      width: isTablet
                          ? isPortrait
                              ? width * .3
                              : width * .2
                          : width * .4,
                      images: book.coverImageUrl,
                      book: book,
                      isExpaned: false,
                      onTap: () async {
                        final color =
                            await getDominantColor(book.coverImageUrl);
                        routeNavigator(context, AppRoutes.readerPage,
                            arguments: ReadModel(color: color!, book: book));
                      },
                    );
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

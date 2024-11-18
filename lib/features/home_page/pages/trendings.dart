import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_bloc.dart';
import 'package:icgc/core/data/bloc/trending/trending_book_states.dart';
import 'package:icgc/features/home_page/widgets/book_card.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/colors_generator.dart';
import '../../manual/data/models/read_model.dart';

import '../widgets/view_all.dart';

class Trendings extends StatelessWidget {
  const Trendings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final images = <String>[
      'assets/images/icgc_images/book_chooseing.png',
      'assets/images/icgc_images/book_annoited.png',
      'assets/images/icgc_images/book_future.png',
      'assets/images/icgc_images/book_dominion.png',
      'assets/images/icgc_images/docterign_of_the_christian_faith.png',
    ];
    return BlocBuilder<TrendingBookBloc, TrendingBookStates>(
        builder: (context, state) {
      switch (state) {
        case TrendingBookLoadedState():
          final nonManualList = state.bookList;
          final temp0 =
              nonManualList[0].copyWith(title: 'Choosing A Life Partner');
          final temp1 =
              nonManualList[1].copyWith(title: 'Anointed To Start And Finish');
          final temp2 = nonManualList[2].copyWith(title: 'Buy The Future');
          final temp3 =
              nonManualList[3].copyWith(title: 'The Dominion Mandate');
          final temp4 = nonManualList[3]
              .copyWith(title: 'Doctering Of The Christian Faith');
          nonManualList[0] = temp0;
          nonManualList[1] = temp1;
          nonManualList[2] = temp2;
          nonManualList[3] = temp3;
          nonManualList[4] = temp4;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewAllTitle(
                  onViewAll: () {},
                  text: AppString.whatsTrending,
                  horizontalPadding: 0),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.sizeOf(context).height * .3,
                    maxHeight: MediaQuery.sizeOf(context).height * .35),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.bookList.length,
                    itemBuilder: (context, index) {
                      final book = state.bookList[index];
                      return BookCard(
                          images: images[index],
                          book: book,
                          onTap: () async {
                            final color = await getDominantColor(images[index]);
                            routeNavigator(context, AppRoutes.readerPage,
                                arguments: ReadModel(
                                    color: color!,
                                    book: book,
                                    image: images[index]));
                          });
                    }),
              ),
            ],
          );

        default:
          return const Center(child: CircularProgressIndicator.adaptive());
      }
    });
  }
}

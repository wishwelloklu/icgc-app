import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/utils/colors_generator.dart';
import '../../../../app/utils/screen_size.dart';
import '../../../../core/data/bloc/book/book_bloc.dart';
import '../../../../core/data/bloc/book/book_states.dart';
import '../../../manual/data/models/read_model.dart';
import '../../../home_page/widgets/book_card.dart';

class Books extends StatelessWidget {
  const Books({super.key, required this.searchTerm});
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final images = [
      'assets/images/icgc_images/book_annoited.png',
      'assets/images/icgc_images/book_chooseing.png',
      'assets/images/icgc_images/book_dominion.png',
      'assets/images/icgc_images/book_future.png',
      'assets/images/icgc_images/book_wisdom.png',
    ];
    return BlocBuilder<BookBloc, BookStates>(buildWhen: (previous, current) {
      return current is BookLoadedState ||
          current is BookInitialState ||
          current is BookProcessingState;
    }, builder: (context, state) {
      if (state is BookLoadedState) {
        final list = state.bookList;
        final dataList = list
            .where((book) =>
                book.author.toLowerCase().contains(searchTerm) ||
                book.title.toLowerCase().contains(searchTerm))
            .toList();
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: searchTerm.isNotEmpty ? dataList.length : list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet
                ? isPortrait
                    ? 3
                    : 4
                : 2,
            mainAxisExtent: isTablet
                ? isPortrait
                    ? height * .29
                    : height * .47
                : height * .29,
            crossAxisSpacing: isTablet
                ? isPortrait
                    ? 10
                    : 0
                : 10,
            mainAxisSpacing: isTablet
                ? isPortrait
                    ? 20
                    : 20
                : 10,
          ),
          itemBuilder: (context, index) {
            final book = searchTerm.isNotEmpty ? dataList[index] : list[index];
            book.pages.removeWhere((element) => element.content.isEmpty);
            return BookCard(
              width: isTablet
                    ? isPortrait
                        ? width * .3
                        : width * .2
                    : width * .4,
              book: book,
              images: images[index],
              onTap: () async {
                final color = await getDominantColor(images[index]);
                routeNavigator(context, AppRoutes.readerPage,
                    arguments: ReadModel(
                      color: color!,
                      book: book,
                      image: images[index],
                    ));
              },
            );
          },
        );
      }

      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

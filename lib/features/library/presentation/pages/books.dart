import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/routes/route_navigator.dart';
import '../../../../app/utils/colors_generator.dart';
import '../../../../core/data/bloc/book/book_bloc.dart';
import '../../../../core/data/bloc/book/book_states.dart';
import '../../../manual/data/models/read_model.dart';
import '../../../home_page/widgets/book_card.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
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
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: list.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 280,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final book = list[index];
            book.pages.removeWhere((element) => element.content.isEmpty);
            return BookCard(
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

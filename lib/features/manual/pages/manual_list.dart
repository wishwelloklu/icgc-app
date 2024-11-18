import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/features/home_page/widgets/book_card.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../core/data/bloc/book/book_bloc.dart';
import '../../../core/data/bloc/book/book_states.dart';

import '../data/models/read_model.dart';

class ManualList extends StatefulWidget {
  const ManualList({super.key});

  @override
  State<ManualList> createState() => _ManualListState();
}

class _ManualListState extends State<ManualList> {
  @override
  Widget build(BuildContext context) {
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
              images: book.coverImageUrl,
              onTap: () async {
                final color = await getDominantColor(book.coverImageUrl);
                routeNavigator(context, AppRoutes.readerPage,
                    arguments: ReadModel(
                      color: color!,
                      book: book,
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

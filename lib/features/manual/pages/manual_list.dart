import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/core/data/bloc/book/book_bloc.dart';
import 'package:icgc/core/data/bloc/book/book_states.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/features/manual/widgets/manual_card.dart';
import 'package:palette_generator/palette_generator.dart';

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
            return GestureDetector(
              onTap: () async {
                final color = await getDominantColor(book.coverImageUrl);
                routeNavigator(context, AppRoutes.readerPage,
                    arguments: ReadModel(
                      color: color!,
                      book: book,
                    ));
              },
              child: ManualCard(book: book),
            );
          },
        );
      }

      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }

  Future<Color?> getDominantColor(String path) async {
    ImageProvider imageProvider = AssetImage(path);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: const Size(200, 200),
    );

    return paletteGenerator.dominantColor?.color;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/debounce.dart';
import 'package:icgc/core/presentation/text_field/search_text_field.dart';
import 'package:icgc/features/home_page/widgets/book_card.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/data/bloc/book/book_bloc.dart';
import '../../../core/data/bloc/book/book_states.dart';

import '../../../core/data/models/book/book_model.dart';
import '../data/models/read_model.dart';

class ManualList extends StatefulWidget {
  const ManualList({super.key});

  @override
  State<ManualList> createState() => _ManualListState();
}

class _ManualListState extends State<ManualList> {
  List<BookModel> _searchBookList = [];
  List<BookModel> _bookList = [];
  final _searchController = TextEditingController();
  bool _isSearching = false;
  late Debounce _debounce;

  @override
  void initState() {
    _debounce = Debounce(delay: Durations.long2);

    _searchController.addListener(() {
      final searchTerm = _searchController.text.toLowerCase();

      _debounce.call(() {
        final filtered = _bookList.where((book) {
          final authorMatches = book.author.toLowerCase().contains(searchTerm);
          final titleMatches = book.title.toLowerCase().contains(searchTerm);

          return authorMatches || titleMatches;
        }).toList();
        _searchBookList = filtered;
        if (searchTerm.isEmpty) {
          _isSearching = false;
        } else {
          _isSearching = true;
        }
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper.determineTabletScreenSize(context);
    return BlocBuilder<BookBloc, BookStates>(buildWhen: (previous, current) {
      return current is BookLoadedState ||
          current is BookInitialState ||
          current is BookProcessingState;
    }, builder: (context, state) {
      if (state is BookLoadedState) {
        final list = state.bookList;
        _bookList = state.bookList;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              SearchTextField(
                controller: _searchController,
                borderColor: AppColor.textInputFieldBorder,
                height: 10,
              ),
              const Gap(10),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _isSearching ? _searchBookList.length : list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        screenSize == TabletScreenSize.medium ? 3 : 2,
                    mainAxisExtent:
                        screenSize == TabletScreenSize.medium ? 320 : 280,
                    // childAspectRatio: 0.,
                    // mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final book =
                        _isSearching ? _searchBookList[index] : list[index];
                    book.pages
                        .removeWhere((element) => element.content.isEmpty);
                    return BookCard(
                      book: book,
                      images: book.coverImageUrl,
                      // imageHeight: screenSize == TabletScreenSize.medium
                      //     ? MediaQuery.sizeOf(context).width * .4
                      //     : null,
                      onTap: () async {
                        // book.pages.removeAt(0);
                        final color =
                            await getDominantColor(book.coverImageUrl);
                        routeNavigator(context, AppRoutes.readerPage,
                            arguments: ReadModel(
                              color: color!,
                              book: book,
                            ));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }

      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

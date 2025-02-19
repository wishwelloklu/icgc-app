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
        _bookList = state.bookList;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 25 : 20),
          child: Column(
            children: [
              SearchTextField(
                controller: _searchController,
                borderColor: AppColor.textInputFieldBorder,
                height: isTablet ? null : 10,
              ),
              const Gap(10),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _isSearching ? _searchBookList.length : list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    mainAxisExtent: isTablet
                        ? isPortrait
                            ? height * .35
                            : height * .48
                        : height * .3,
                    // childAspectRatio: 0.3,
                    crossAxisSpacing: isTablet ? 25 : 20,
                    mainAxisSpacing: isTablet
                        ? isPortrait
                            ? 20
                            : 20
                        : 15,
                  ),
                  itemBuilder: (context, index) {
                    final book =
                        _isSearching ? _searchBookList[index] : list[index];
                    book.pages
                        .removeWhere((element) => element.content.isEmpty);
                    return BookCard(
                      width: isTablet
                          ? isPortrait
                              ? width * .3
                              : width * .25
                          : width * .53,
                      book: book,
                      images: book.coverImageUrl,
                      onTap: () async {
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

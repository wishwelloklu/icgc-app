import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/custom_text.dart';
import 'package:icgc/app/utils/debounce.dart';
import 'package:icgc/core/data/models/book/pages.dart';
import 'package:icgc/core/presentation/text_field/search_text_field.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import '../../../../core/presentation/text/title_text.dart';

class SearchBookPage extends StatefulWidget {
  const SearchBookPage(
      {super.key, required this.onResult, required this.pages});
  final void Function(int, String) onResult;
  final List<Pages> pages;
  @override
  State<SearchBookPage> createState() => _SearchBookPageState();
}

class _SearchBookPageState extends State<SearchBookPage> {
  final _searchController = TextEditingController();
  late Debounce _debounce;
  List<Pages> searchResult = [];
  List<Pages> pages = [];
  bool _isSearching = false;
  List<TextSpan> textSpans = [];
  @override
  void initState() {
    super.initState();
    _debounce = Debounce(delay: const Duration(milliseconds: 300));
    for (var i = 0; i < widget.pages.length; i++) {
      final page = widget.pages[i];

      // Parse the content of the current page
      final textSpans = parseText(page.content);

      // Extract the plain text from parsed spans
      final content = textSpans.map(extractTextFromTextSpan).join();

      // Add the page to the list with the title
      pages.add(Pages(
        pageNumber: i,
        content: content,
        title: page.title, // Access title from widget.pages
      ));
    }
    _searchController.addListener(() {
      final text = _searchController.text.toLowerCase().trim();

      _debounce.call(() {
        if (text.isEmpty) {
          setState(() {
            _isSearching = false;
            searchResult.clear();
          });
          return;
        }

        final result = pages.where((data) {
          final contentMatch = data.content.toLowerCase().contains(text);
          final titleMatch = data.content.toLowerCase().contains(text);
          if (contentMatch || titleMatch) {
            data.copyWith(pageNumber: pages.indexOf(data));
          }
          return data.content.toLowerCase().contains(text) ||
              (data.title?.toLowerCase().contains(text) ?? false) ||
              data.pageNumber.toString().contains(text);
        }).toList();

        List<Pages> filteredResults = [];

        for (var element in result) {
          RegExp sentenceSplitter = RegExp(r'[^.!?]+[.!?]');
          final sentences = sentenceSplitter.allMatches(element.content);
          sentences.map((match) => match.group(0)!.trim()).forEach((sentence) {
            if (sentence.toLowerCase().contains(text)) {
              filteredResults.add(Pages(
                pageNumber: element.pageNumber,
                title: element.title,
                content: sentence,
              ));
            }
          });
        }

        setState(() {
          searchResult = filteredResults;
          _isSearching = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // widget.pages.removeWhere((element) => element.title?.isEmpty ?? true);
    return BlocBuilder<FontBloc, FontState>(builder: (context, fontState) {
      switch (fontState) {
        case FontState():
          return Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchTextField(
                    controller: _searchController,
                    borderColor:
                        AppColor.textInputFieldBorder.withValues(alpha: 1),
                    hintText: 'Type a word or page number',
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount:
                          _isSearching ? searchResult.length : pages.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final book = _isSearching
                            ? searchResult[index]
                            : widget.pages[index];

                        return ListTile(
                          onTap: () => widget.onResult(
                              _isSearching ? book.pageNumber : index,
                              _searchController.text.isNotEmpty
                                  ? _searchController.text
                                  : book.title ?? ''),
                          title: book.title != null
                              ? TitleText(
                                  text: book.title!,
                                  textAlign: TextAlign.left,
                                )
                              : null,
                          subtitle: _isSearching
                              ? CustomeText(
                                  text: book.content,
                                  fontSize: fontState.fontSize,
                                  searchText:
                                      _searchController.text.toLowerCase(),
                                  fontName: fontState.fontName,
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );

        default:
          return const Center(child: CircularProgressIndicator.adaptive());
      }
    });
  }
}

class Match {
  final int start;
  final int end;

  Match(this.start, this.end);
}

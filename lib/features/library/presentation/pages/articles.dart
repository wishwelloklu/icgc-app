import 'package:flutter/material.dart';
import '../../../../core/data/models/book/book_model.dart';

import '../widgets/article_card.dart';

class Articles extends StatelessWidget {
  const Articles({super.key, required this.searchTerm});
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    final dataList = BookModel.trendingBookList
        .where((book) =>
            book.author.toLowerCase().contains(searchTerm) ||
            book.title.toLowerCase().contains(searchTerm))
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: searchTerm.isEmpty
          ? BookModel.trendingBookList.length
          : dataList.length,
      itemBuilder: (context, index) {
        final book = searchTerm.isNotEmpty
            ? dataList[index]
            : BookModel.trendingBookList[index];
        return ArticleCard(book: book);
      },
    );
  }
}

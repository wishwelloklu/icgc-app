import 'package:flutter/material.dart';
import 'package:icgc/core/data/models/book/book_model.dart';

import '../widgets/article_card.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: BookModel.trendingBookList.length,
      itemBuilder: (context, index) {
        final book = BookModel.trendingBookList[index];
        return ArticleCard(book: book);
      },
    );
  }
}

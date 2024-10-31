import 'package:flutter/material.dart';
import 'package:icgc/core/data/models/book/book_model.dart';
import 'package:icgc/features/manual/widgets/manual_card.dart';

class Books extends StatelessWidget {
  const Books({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: BookModel.trendingBookList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 280,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final book = BookModel.trendingBookList[index];
        return ManualCard(book: book);
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/data/models/book/book_model.dart';
import '../../manual/data/models/read_model.dart';

import '../widgets/view_all.dart';
import '../widgets/book_card.dart';

class TopManual extends StatelessWidget {
  const TopManual({
    super.key,
    required this.list,
  });
  final List<BookModel> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllTitle(
            onViewAll: () {}, text: "Top manuals", horizontalPadding: 0),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * .32,
          child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                final book = list[index];

                return BookCard(
                  images: book.coverImageUrl,
                  book: book,
                  onTap: () async {
                    final color = await getDominantColor(book.coverImageUrl);
                    routeNavigator(context, AppRoutes.readerPage,
                        arguments: ReadModel(color: color!, book: book));
                  },
                );
              }),
        ),
      ],
    );
  }
}

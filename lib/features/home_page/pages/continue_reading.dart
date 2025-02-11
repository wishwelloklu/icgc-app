import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/core/presentation/text/description_text.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_bloc.dart';
import 'package:icgc/features/reader_page/presentation/bloc/font_states.dart';
import 'package:icgc/features/reader_page/presentation/pages/reader_page.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/theme/app_string.dart';
import '../../../app/utils/custom_text.dart';
import '../../../core/presentation/buttons/app_primary_button.dart';
import '../../manual/data/models/read_model.dart';

class ContinueReading extends StatelessWidget {
  const ContinueReading({super.key});

  @override
  Widget build(BuildContext context) {
    final readModel = ModalRoute.settingsOf(context)!.arguments as ReadModel;
    final book = readModel.book;
    final percentage =
        (readModel.currentPage / book.pages.length * 100).round();
    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  toolbarHeight: kToolbarHeight * 7,
                  automaticallyImplyLeading: false,
                  titleSpacing: 30,
                  centerTitle: true,
                  title: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(50),
                        DecoratedBox(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(27, 0, 0, 0),
                              spreadRadius: 10,
                              blurRadius: 7,
                            )
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              book.coverImageUrl,
                              height: 140,
                              width: 120,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Gap(10),
                        TitleText(text: book.title),
                        const Gap(5),
                        DescriptionText(
                          text: book.author,
                          fontSize: 12,
                        ),
                        const Gap(10),
                        ReaderProgress(
                          currentPage: book.currentPage + 1,
                          book: book,
                          percentage: percentage,
                          totalPage: book.totalPage,
                        ),
                      ],
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(bottom: 200),
                    centerTitle: true,
                    title: Stack(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              book.coverImageUrl,
                              fit: BoxFit.fitWidth,
                              width: double.infinity,
                            ),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(79, 1, 1, 1)),
                        ),
                        Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                              color: AppColor.whiteColor,
                              onPressed: () => popBack(context),
                              icon: const Icon(Icons.arrow_back_ios)),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromARGB(49, 0, 0, 0),
                  ],
                )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<FontBloc, FontStates>(
                      builder: (context, state) {
                    if (state is FontState) {
                      return CustomeText(
                        text: book.pages[0].content,
                        fontSize: 18,
                        searchText: '',
                        fontName: state.fontName,
                      );
                    }
                    return const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
                )),
          ),
          // Positioned(
          //   top: 100,
          //   left: 100,
          //   right: 100,
          //   child: Image.asset(
          //     book.coverImageUrl,
          //     height: 200,
          //     fit: BoxFit.fill,
          //     width: 170,
          //   ),
          // ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PrimaryButton(
        text: AppString.continues,
        onPressed: () {
          routeNavigator(context, AppRoutes.readerPage,
              arguments: ReadModel(
                  color: readModel.color,
                  book: book,
                  currentPage: book.currentPage));
        },
        width: MediaQuery.sizeOf(context).width * .8,
      ),
    );
  }
}

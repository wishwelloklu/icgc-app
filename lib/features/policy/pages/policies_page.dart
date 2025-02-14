import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/debounce.dart';
import 'package:icgc/features/home_page/widgets/policy_card.dart';
import 'package:icgc/features/manual/data/models/policy_model.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';

import '../../../app/utils/screen_size.dart';
import '../../../core/data/models/book/book_model.dart';
import '../../../core/data/models/book/pages.dart';
import '../../../core/presentation/text_field/search_text_field.dart';
import '../data/bloc/policy_bloc/policy_bloc.dart';
import '../data/bloc/policy_bloc/policy_events.dart';
import '../data/bloc/policy_bloc/policy_states.dart';
import '../../manual/data/models/read_model.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  List<PolicyModel> _searchBookList = [];
  List<PolicyModel> _bookList = [];
  final _searchController = TextEditingController();
  bool _isSearching = false;
  late Debounce _debounce;

  @override
  void initState() {
    context.read<PolicyBloc>().add(LoadPolicyEvent());
    _debounce = Debounce(delay: Durations.long2);

    _searchController.addListener(() {
      final searchTerm = _searchController.text.toLowerCase();

      _debounce.call(() {
        final filtered = _bookList
            .where((book) => book.title.toLowerCase().contains(searchTerm))
            .toList();
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
    return BlocBuilder<PolicyBloc, PolicyStates>(builder: (context, state) {
      if (state is PolicyLoadedState) {
        state.policyList.removeWhere((test) => test.pages.isEmpty);
        _bookList = state.policyList;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 25 : 20),
          child: Column(
            children: [
              SearchTextField(
                controller: _searchController,
                borderColor: AppColor.textInputFieldBorder,
              ),
              const Gap(10),
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  mainAxisExtent: isTablet
                      ? isPortrait
                          ? height * .25
                          : height * .45
                      : height * .25,
                  // childAspectRatio: 0.3,
                  crossAxisSpacing: isTablet
                      ? isPortrait
                          ? 25
                          : 30
                      : 20,
                  mainAxisSpacing: isTablet
                      ? isPortrait
                          ? 20
                          : 20
                      : 15,
                ),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _isSearching
                    ? _searchBookList.length
                    : state.policyList.length,
                itemBuilder: (context, index) {
                  final book = _isSearching
                      ? _searchBookList[index]
                      : state.policyList[index];

                  return GestureDetector(
                      onTap: () async {
                        final color = await getDominantColor(
                            'assets/images/policy_image.png');
                        routeNavigator(context, AppRoutes.readerPage,
                            arguments: ReadModel(
                              color: color!,
                              book: BookModel(
                                author: 'ICGC',
                                currentPage: 1,
                                totalPage: state.policyList[index].pages.length,
                                coverImageUrl: 'assets/images/policy_image.png',
                                title: state.policyList[index].title,
                                pages: state.policyList[index].pages
                                    .map((data) => Pages(
                                        content: data.content,
                                        title: data.title,
                                        pageNumber: data.pageNumber))
                                    .toList(),
                              ),
                            ));
                      },
                      child: PolicyCard(book: book));
                },
              ),
            ],
          ),
        );
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

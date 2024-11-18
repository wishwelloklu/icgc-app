import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/theme/app_color.dart';
import 'package:icgc/app/utils/debounce.dart';
import 'package:icgc/features/manual/data/models/policy_model.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';

import '../../../core/data/models/book/book_model.dart';
import '../../../core/data/models/book/pages.dart';
import '../../../core/presentation/text_field/search_text_field.dart';
import '../data/bloc/policy_bloc/policy_bloc.dart';
import '../data/bloc/policy_bloc/policy_events.dart';
import '../data/bloc/policy_bloc/policy_states.dart';
import '../data/models/read_model.dart';
import '../widgets/policy_card.dart';

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
    return BlocBuilder<PolicyBloc, PolicyStates>(builder: (context, state) {
      if (state is PolicyLoadedState) {
        state.policyList.removeWhere((test) => test.pages.isEmpty);
        _bookList = state.policyList;
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
              ListView.builder(
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
                        state.policyList[index].pages.removeAt(0);
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

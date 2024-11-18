import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../../app/utils/colors_generator.dart';

import '../../../core/data/models/book/book_model.dart';
import '../../../core/data/models/book/pages.dart';
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
  @override
  void initState() {
    context.read<PolicyBloc>().add(LoadPolicyEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PolicyBloc, PolicyStates>(builder: (context, state) {
      if (state is PolicyLoadedState) {
        state.policyList.removeWhere((test) => test.pages.isEmpty);
        return ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: state.policyList.length,
          itemBuilder: (context, index) {
            final book = state.policyList[index];
            return GestureDetector(
                onTap: () async {
                  final color =
                      await getDominantColor('assets/images/policy_image.png');
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
        );
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}

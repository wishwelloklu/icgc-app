import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/app/utils/colors_generator.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/app_states/app_error_state.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/officiate_states.dart';

import '../../../app/utils/screen_size.dart';
import '../widgets/book_cover.dart';

class OfficiatesList extends StatelessWidget {
  const OfficiatesList({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<OfficiateBloc, OfficiateStates>(
        builder: (context, state) {
      switch (state) {
        case OfficiateLoaded():
          final samples = state.samples;
          if (samples.isEmpty) {
            return const AppEmptyStateWidget(
              title: AppString.noSample,
              text: AppString.emptySampleText,
            );
          }

          return ListView.separated(
              itemCount: samples.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Gap(20),
              itemBuilder: (context, index) {
                final officiate = samples[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () => routeNavigator(
                        context, AppRoutes.sermonDetails,
                        arguments: officiate),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: isTablet ? width * .3 : width * .3,
                            height: isTablet ? height * .3 : height * .15,
                            child: BookCover(
                              subTitle: officiate.subTitle,
                              title: officiate.title,
                              color: generateColor.color,
                              showSampleText: false,
                            ),
                          ),
                        ),
                        const Gap(5),
                        Expanded(
                          child: TitleText(
                            text: officiate.title,
                            fontSize: isTablet ? 20 : 18,
                            maxLine: 3,
                            textAlign: TextAlign.left,
                            // fontWeight: Fo,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });

        // return GridView.builder(
        //   itemCount: samples.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: isTablet ? 3 : 2,
        //     mainAxisExtent: isTablet
        //         ? isPortrait
        //             ? height * .29
        //             : height * .43
        //         : height * .29,
        //     // childAspectRatio: 0.3,
        //     crossAxisSpacing: isTablet ? 20 : 5,
        //     mainAxisSpacing: isTablet
        //         ? isPortrait
        //             ? 20
        //             : 20
        //         : 15,
        //   ),
        //   itemBuilder: (context, index) {
        //     final sample = samples[index];
        //     return InkWell(
        //       onTap: () {
        //         routeNavigator(
        //           context,
        //           AppRoutes.sampleDetails,
        //           arguments: sample,
        //         );
        //       },
        //       child: BookCover(
        //         title: sample.title,
        //         subTitle: sample.subTitle,
        //         color: generateColor.color,
        //       ),
        //     );
        //     // AppListTile(

        //     //   title: sample.title,
        //     //   subTitle: sample.subTitle,
        //     // );
        //   },
        // );

        case ErrorOfficiateState():
          return AppErrorState(error: state.error);
        default:
          return const AppLoadingState();
      }
    });
  }
}

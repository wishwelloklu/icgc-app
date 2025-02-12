import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/app_states/app_error_state.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_states.dart';
import 'package:icgc/features/sermons/widgets/book_cover.dart';

import '../../../app/utils/screen_size.dart';

class SermonSample extends StatelessWidget {
  const SermonSample({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    return BlocBuilder<SampleBloc, SampleStates>(builder: (context, state) {
      switch (state) {
        case SamplesLoaded():
          final samples = state.samples;
          if (samples.isEmpty) {
            return const AppEmptyStateWidget(
              title: AppString.noSample,
              text: AppString.emptySampleText,
            );
          }
          return GridView.builder(
            itemCount: samples.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isTablet ? 3 : 2,
              mainAxisExtent: isTablet
                  ? isPortrait
                      ? height * .25
                      : height * .43
                  : height * .29,
              // childAspectRatio: 0.3,
              crossAxisSpacing: isTablet ? 20 : 5,
              mainAxisSpacing: isTablet
                  ? isPortrait
                      ? 20
                      : 20
                  : 15,
            ),
            itemBuilder: (context, index) {
              final sample = samples[index];
              return InkWell(
                onTap: () {
                  routeNavigator(
                    context,
                    AppRoutes.sermonDetails,
                    arguments: sample,
                  );
                },
                child: BookCover(
                  title: sample.title,
                  subTitle: sample.subTitle,
                  color: sample.color!.color,
                ),
              );
              // AppListTile(

              //   title: sample.title,
              //   subTitle: sample.subTitle,
              // );
            },
          );
        case ErrorSampleState():
          return AppErrorState(error: state.error);
        default:
          return const AppLoadingState();
      }
    });
  }
}

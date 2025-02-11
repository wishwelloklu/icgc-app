import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/app_states/app_error_state.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/core/presentation/text/title_text.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_states.dart';

import '../../../app/utils/colors_generator.dart';
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
                      ? height * .29
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
                    AppRoutes.sampleDetails,
                    arguments: sample,
                  );
                },
                child: BookCover(
                  title: sample.title,
                  subTitle: sample.subTitle,
                  color: sample.color.color,
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

class BookCover extends StatelessWidget {
  const BookCover(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.color});
  final String title;
  final String subTitle;
  final Color color;
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    final height = MediaQuery.sizeOf(context).height;

    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color,
                darkenColor(color),
              ],
            ),
          ),
        ),
        Positioned(
          left: 1,
          child: Container(
            height: height,
            width: 5,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-3, 0),
                  spreadRadius: .2,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 15,
          child: Container(
            height: height,
            width: 5,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color,
                  offset: const Offset(-3, 0),
                  spreadRadius: 2,
                  blurRadius: 2,
                ),
                const BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 0),
                  spreadRadius: .2,
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          top: 40,
          child: TitleText(
            text: title,
            fontSize: isTablet ? 30 : 20,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 30,
          child: TitleText(
            text: 'Sample Sermon',
            fontSize: isTablet ? 20 : 15,
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

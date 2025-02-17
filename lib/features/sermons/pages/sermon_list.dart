import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icgc/app/theme/app_string.dart';
import 'package:icgc/core/presentation/app_states/app_empty_state.dart';
import 'package:icgc/core/presentation/app_states/app_error_state.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_states.dart';
import 'package:icgc/features/sermons/widgets/mobile_view.dart';
import 'package:icgc/features/sermons/widgets/tabblet_view.dart';

import '../../../app/utils/screen_size.dart';

class SermonList extends StatelessWidget {
  const SermonList({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<SermonBloc, SermonStates>(builder: (context, state) {
      switch (state) {
        case SermonLoaded():
          final sermons = state.sermons;
          if (sermons.isEmpty) {
            return const AppEmptyStateWidget(
              title: AppString.noSample,
              text: AppString.emptySampleText,
            );
          }
          if (isTablet) {
            return TabbletView(
              sermons: sermons,
              isPortrait: isPortrait,
              height: height,
              width: width,
            );
          }
          return MobileView(
            sermons: sermons,
            width: width,
            height: height,
          );

        case ErrorSermonState():
          return AppErrorState(error: state.error);
        default:
          return const AppLoadingState();
      }
    });
  }
}

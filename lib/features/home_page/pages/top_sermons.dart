import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/utils/screen_size.dart';
import 'package:icgc/core/presentation/app_states/app_loading_state.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_bloc.dart';
import 'package:icgc/features/sermons/data/bloc/sample_bloc/sample_states.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/routes/route_navigator.dart';
import '../../sermons/pages/sermon_sample.dart';
import '../widgets/view_all.dart';

class TopSermons extends StatelessWidget {
  const TopSermons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<SampleBloc, SampleStates>(builder: (context, state) {
      if (state is SamplesLoaded) {
        final list = state.samples;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ViewAllTitle(
              onViewAll: () {},
              text: "Top officiating manuals",
              horizontalPadding: 0,
            ),
            SizedBox(
              height: isTablet
                  ? isPortrait
                      ? height * .3
                      : height * .4
                  : height * .3,
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    final sample = list[index];

                    return SizedBox(
                      width: isTablet
                          ? isPortrait
                              ? width * .3
                              : width * .19
                          : width * .4,
                      child: InkWell(
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
                      ),
                    );
                  }),
            ),
          ],
        );
      }
      return SizedBox(
        height: isTablet
            ? isPortrait
                ? height * .3
                : height * .5
            : 300,
        child: const AppLoadingState(),
      );
    });
  }
}

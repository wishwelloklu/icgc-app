import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:icgc/app/routes/app_routes.dart';
import 'package:icgc/app/routes/route_navigator.dart';
import 'package:icgc/features/prayer/data/bloc/prayer_bloc.dart';
import 'package:icgc/features/prayer/data/bloc/prayer_events.dart';
import 'package:icgc/features/prayer/data/bloc/prayer_states.dart';

import '../../../app/theme/app_string.dart';
import '../../../app/utils/screen_size.dart';
import '../../../core/presentation/app_states/app_empty_state.dart';
import '../../../core/presentation/app_states/app_error_state.dart';
import '../../../core/presentation/app_states/app_loading_state.dart';
import '../../../core/presentation/text/description_text.dart';
import '../../../core/presentation/text/title_text.dart';

class Prayer extends StatefulWidget {
  const Prayer({super.key});

  @override
  State<Prayer> createState() => _PrayerState();
}

class _PrayerState extends State<Prayer> {
  @override
  void initState() {
    context.read<PrayerBloc>().add(LoadPrayer());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final imageSize = isTablet
        ? isPortrait
            ? height * .15
            : height * .2
        : height * .1;
    final imageWidth = isTablet
        ? isPortrait
            ? width * .3
            : width * .2
        : width * .25;
    return BlocBuilder<PrayerBloc, PrayerStates>(
      builder: (context, state) {
        switch (state) {
          case PrayerLoadedState():
            final themes = state.prayers;
            if (themes.isEmpty) {
              return const AppEmptyStateWidget(
                title: AppString.noTheme,
                text: AppString.emptyThemeText,
              );
            }
            return ListView.separated(
                itemCount: 1,
                separatorBuilder: (context, index) => const Gap(20),
                itemBuilder: (context, index) {
                  final theme = themes[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {
                       
                        routeNavigator(context, AppRoutes.prayerDetails,
                            arguments: theme);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                height: imageSize,
                                width: imageWidth,
                                theme.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TitleText(
                                    text: theme.title,
                                    fontSize: isTablet ? 25 : 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  DescriptionText(
                                    text: theme.prayer,
                                    fontSize: isTablet ? 20 : 15,
                                    maxLine: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          case PrayerErrorState():
            return AppErrorState(error: state.error);
          default:
            return const AppLoadingState();
        }
      },
    );
  }
}
